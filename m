Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09C62CC24F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbgLBQbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 11:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389126AbgLBQbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 11:31:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B35FC0613D4;
        Wed,  2 Dec 2020 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GlOw3b7M/4i8hX4WqqCNrb13MBql3ucRIPQK5dDn1/s=; b=nMLwDQ5GVq0wfCdJBRBFD4WitS
        hcPd9A53uhlZQMAVq1dXH6tjQcVY6pI21qKQvKHspz/qVnC0v0XcnYlTplV5CSHAaGLL0EPAif2xm
        3wnzYMGe0wFR8V+k3GX8BiwFRZQnUZu9actZuVGxAFG6LzR891aaFQj8PfjXuTVLZGYN3iQA5K+ZX
        BTvarfmDZ0EPpGuqWfwcKZfa1ZgoNpKIVj8SJmXRh0w71G9MT6ycw9dx/Q1JAFLnYwNyZ51OGDkke
        x2Z9mhY06HCkOxWH7QAJTMsy4heBYrcud3ETkLY7/nyqkvJmO9sQmplh/HPQnnNcRnMTnewrA12w8
        MujyVPTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkV0h-0004AB-Dg; Wed, 02 Dec 2020 16:29:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96BE13035D4;
        Wed,  2 Dec 2020 17:29:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73661201F097E; Wed,  2 Dec 2020 17:29:41 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:29:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201202162941.GB2414@hirez.programming.kicks-ass.net>
References: <20201202141957.GJ3021@hirez.programming.kicks-ass.net>
 <BA2FB4C0-55EA-481A-824C-95B94EA29FAB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA2FB4C0-55EA-481A-824C-95B94EA29FAB@amacapital.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 06:38:12AM -0800, Andy Lutomirski wrote:
> 
> > On Dec 2, 2020, at 6:20 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿On Sun, Nov 29, 2020 at 02:01:39AM +1000, Nicholas Piggin wrote:
> >> +         * - A delayed freeing and RCU-like quiescing sequence based on
> >> +         *   mm switching to avoid IPIs completely.
> > 
> > That one's interesting too. so basically you want to count switch_mm()
> > invocations on each CPU. Then, periodically snapshot the counter on each
> > CPU, and when they've all changed, increment a global counter.
> > 
> > Then, you snapshot the global counter and wait for it to increment
> > (twice I think, the first increment might already be in progress).
> > 
> > The only question here is what should drive this machinery.. the tick
> > probably.
> > 
> > This shouldn't be too hard to do I think.
> > 
> > Something a little like so perhaps?
> 
> I don’t think this will work.  A CPU can go idle with lazy mm and nohz
> forever.  This could lead to unbounded memory use on a lightly loaded
> system.

Hurm.. quite so indeed. Fixing that seems to end up with requiring that
other proposal, such that we can tell which CPU has what active_mm
stuck.

Also, more complicated... :/

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552922C8120
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 10:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgK3JfN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 04:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgK3JfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 04:35:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DB8C0613CF;
        Mon, 30 Nov 2020 01:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0rWZ/IKLgX5YBtYlsGOEnzcxhpN2D379f2O4Lio8snw=; b=DZmGHuBX23XyOb0cYXxLwKvpB+
        1QFJSgOTkI0TdQcuEDlwzcyxfvK3NW4jFlga+VMD1+hut7ZfTUVDPiUZg3xzF3qLlP+Ac1USFi6qp
        4YPToAcqP+rNdlu7fqFgH0OGt0wmYCFT/6L1/DE07qbTOPFDXO4mKDdJhGVoRLRDUPLytj7/QB3QO
        7btaCKCgshCA358zEjjiqbMdS8WOI/Oz2FA5XL/ZvrcoogYQU/ql+fcUXzEV2kuq7/40oBjjGMzwG
        PUnV/3WJfZ+yQycDAIuAN1vCwkquC+gl0cJ06EY6rBnJh+aLw1wUU17oDBEXk4K5uqm6mAfKXQMv4
        eCafddhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjfZa-0001G5-CH; Mon, 30 Nov 2020 09:34:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 278DA3003E1;
        Mon, 30 Nov 2020 10:34:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12B1720107BE2; Mon, 30 Nov 2020 10:34:17 +0100 (CET)
Date:   Mon, 30 Nov 2020 10:34:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201130093417.GI3092@hirez.programming.kicks-ass.net>
References: <20201128160141.1003903-1-npiggin@gmail.com>
 <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
 <20201130093000.GM2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130093000.GM2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 30, 2020 at 10:30:00AM +0100, Peter Zijlstra wrote:
> On Sat, Nov 28, 2020 at 07:54:57PM -0800, Andy Lutomirski wrote:
> > This means that mm_cpumask operations won't need to be full barriers
> > forever, and we might not want to take the implied full barriers in
> > set_bit() and clear_bit() for granted.
> 
> There is no implied full barrier for those ops.

Neither ARM nor Power implies any ordering on those ops. But Power has
some of the worst atomic performance in the world despite of that.

IIRC they don't do their LL/SC in L1.

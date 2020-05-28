Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF11E6E7D
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 00:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436722AbgE1WRu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 18:17:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436893AbgE1WRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 18:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1p43sYK6aOQqNZ7F6V33wq1Ybm5fjK74e0YqjQ9JQps=; b=zz6OmL3TLZZZxXVLu94PrZQzqp
        aZggvYiaXq/6Kx5oRvLYx2k3w87cbHEcNOWcd6KbK6PHLdzf3IWQKTz5P/+f6yoC9ZzzNItPSpJeS
        IGL9rh+K1jT4rRIfq8WznLydWADKdFrTQPYdqb4Fo2Bq/WeBtdX23hdU2n/kSNv2xnfWzjQ+brAQH
        9qghibZ66lg9OOrgtmiYU6tYquWvMmn+/Ig9axRDNH/Vc6Gpirhp4Og1rYY2FvBZD/4OZl8Ys5fJ+
        3Mdga68MOIyxa2AjRRRI6IuqTTfuC2QKSdVeqbJCWQcoCXtm7hn5XsCjUUj8W8B4cEFgVe1orSpxs
        uolrwG4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeQpi-0006Ot-RM; Thu, 28 May 2020 22:17:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 032949834F3; Fri, 29 May 2020 00:16:59 +0200 (CEST)
Date:   Fri, 29 May 2020 00:16:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200528221659.GS2483@worktop.programming.kicks-ass.net>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
 <20200528220047.GB211369@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528220047.GB211369@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 06:00:47PM -0400, Joel Fernandes wrote:

> Any idea why this choice of locking-based ring buffer implementation in BPF?
> The ftrace ring buffer can support NMI interruptions as well for writes.
> 
> Also, is it possible for BPF to reuse the ftrace ring buffer implementation
> or does it not meet the requirements?

Both perf and ftrace are per-cpu, which, according to the patch
description is too much memory overhead for them. Neither have ever
considered anything else, atomic ops are expensive.

On top of that, they want multi-producer support. Yes, doing that gets
interesting really fast, but using spinlocks gets you a trainwreck like
this.

This thing so readily wanting to drop data on the floor should worry
people, but apparently they've not spend enough time debugging stuff
with partial logs yet. Of course, bpf_prog_active already makes BPF
lossy, so maybe they went with that.

All reasons why I never bother with BPF, aside from it being more
difficult than hacking up a kernel in the first place.

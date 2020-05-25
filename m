Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE11E1207
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbgEYPrb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 11:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390935AbgEYPra (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 11:47:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814432053B;
        Mon, 25 May 2020 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590421650;
        bh=6ZI5+EOa31FmQbdlFBmWEw79uHVTHv8ArYj5YaQUIng=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=u0IOQQkzOfJuJEsZrO/MQh1+5wnQ1uynD2OUaCBwSJw0LYmCJciyTvRi8HiQocLFY
         B3VKtLa2GzLvLanIC5oGbjstKA/Sdy44JlAillm5U/jc4kzu3FhHtvbYDmszYyblN2
         rRz4HB7d+TiAe6LLz47sSF/oL+oqZyCnlSaQO9kM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1B8E8352267E; Mon, 25 May 2020 08:47:30 -0700 (PDT)
Date:   Mon, 25 May 2020 08:47:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200525154730.GW2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525112521.GD317569@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 25, 2020 at 01:25:21PM +0200, Peter Zijlstra wrote:
> On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> 
> > > > Also, what use is a spinlock that is accessed in only one thread?
> > > 
> > > Multiple writers synchronize via the spinlock in this case.  I am
> > > guessing that his larger 16-hour test contended this spinlock.
> > 
> > Yes, spinlock is for coordinating multiple producers. 2p1c cases (bounded
> > and unbounded) rely on this already. 1p1c cases are sort of subsets (but
> > very fast to verify) checking only consumer/producer interaction.
> 
> Does that spinlock imply that we can now never fix that atrocious
> bpf_prog_active trainwreck ?
> 
> How does that spinlock not trigger the USED <- IN-NMI lockdep check:
> 
>   f6f48e180404 ("lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions")
> 
> ?
> 
> That is; how can you use a spinlock on the producer side at all?

So even trylock is now forbidden in NMI handlers?  If so, why?

							Thanx, Paul

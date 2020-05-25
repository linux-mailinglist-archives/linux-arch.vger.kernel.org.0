Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7777B1E1352
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbgEYRVz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 13:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388230AbgEYRVz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 13:21:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6E22070A;
        Mon, 25 May 2020 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590427314;
        bh=qjdmVOIqRqo3sOlRUfcgEntQkhzxxq6U+VJ1HX37vfg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BFSdAKMh2JVYmQrOhs3VAjWh47ScTS/Px/6VBmd+nUNAt55M3C6fgt7loIk3IY8xt
         IxvFvWCdKJPJ7VeukMDPahAopzg9wNb98FrBIqwfy+z5uTuPVL37+BFhDBBCDyXido
         6UW0Pdy2GzXOJ4oRLqBN5lv6Rj59EnKI891WF20I=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A38AB3522846; Mon, 25 May 2020 10:21:54 -0700 (PDT)
Date:   Mon, 25 May 2020 10:21:54 -0700
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
Message-ID: <20200525172154.GZ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525170257.GA325280@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 25, 2020 at 07:02:57PM +0200, Peter Zijlstra wrote:
> On Mon, May 25, 2020 at 08:47:30AM -0700, Paul E. McKenney wrote:
> > On Mon, May 25, 2020 at 01:25:21PM +0200, Peter Zijlstra wrote:
> 
> > > That is; how can you use a spinlock on the producer side at all?
> > 
> > So even trylock is now forbidden in NMI handlers?  If so, why?
> 
> The litmus tests don't have trylock.

Fair point.

> But you made me look at the actual patch:
> 
> +static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
> +{
> +	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
> +	u32 len, pg_off;
> +	struct bpf_ringbuf_hdr *hdr;
> +
> +	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
> +		return NULL;
> +
> +	len = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> +	cons_pos = smp_load_acquire(&rb->consumer_pos);
> +
> +	if (in_nmi()) {
> +		if (!spin_trylock_irqsave(&rb->spinlock, flags))
> +			return NULL;
> +	} else {
> +		spin_lock_irqsave(&rb->spinlock, flags);
> +	}
> 
> And that is of course utter crap. That's like saying you don't care
> about your NMI data.

Almost.  It is really saying that -if- there is sufficient lock
contention, printk()s will be lost.  Just as they always have been if
there is more printk() volume than can be accommodated.

							Thanx, Paul

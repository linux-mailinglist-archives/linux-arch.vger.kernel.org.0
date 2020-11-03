Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38312A3C05
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 06:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCFjn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 00:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCFjm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Nov 2020 00:39:42 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22EC22277;
        Tue,  3 Nov 2020 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604381982;
        bh=Q076BhLY0DjbtliwCu3GQaRyBU42Z/sESEIdo+7CCzE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wXLsZJezLTss4VZf3uN/AvI46+E1z5Odjbvi+BURO54maOx6U+UQ2wefCCzSow2na
         19n2QkXSlNBlOyUVmUmLCyaGmJEfltTAICNSS8PI8jIlpvD2qNHyrgSoRfaQnxcHG6
         yyIKsbDtuUB0s4jDE2XaDgQxIm4o16orrtVO7jfM=
Date:   Tue, 3 Nov 2020 14:39:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v5 14/21] kprobes: Remove NMI context check
Message-Id: <20201103143938.704c7974e93c854511580c38@kernel.org>
In-Reply-To: <20201102092726.57cb643f@gandalf.local.home>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <159870615628.1229682.6087311596892125907.stgit@devnote2>
        <20201030213831.04e81962@oasis.local.home>
        <20201102141138.1fa825113742f3bea23bc383@kernel.org>
        <20201102145334.23d4ba691c13e0b6ca87f36d@kernel.org>
        <20201102160234.fa0ae70915ad9e2b21c08b85@kernel.org>
        <20201102092726.57cb643f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2 Nov 2020 09:27:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Peter Z, please take a look a this ]
> 
> On Mon, 2 Nov 2020 16:02:34 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >From 509b27efef8c7dbf56cab2e812916d6cd778c745 Mon Sep 17 00:00:00 2001  
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Mon, 2 Nov 2020 15:37:28 +0900
> > Subject: [PATCH] kprobes: Disable lockdep for kprobe busy area
> > 
> > Since the code area in between kprobe_busy_begin()/end() prohibits
> > other kprobs to call probe handlers, we can avoid inconsitent
> > locks there. But lockdep doesn't know that, so it warns rp->lock
> > or kretprobe_table_lock.
> > 
> > To supress those false-positive errors, disable lockdep while
> > kprobe_busy is set.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 8a12a25fa40d..c7196e583600 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1295,10 +1295,12 @@ void kprobe_busy_begin(void)
> >  	__this_cpu_write(current_kprobe, &kprobe_busy);
> >  	kcb = get_kprobe_ctlblk();
> >  	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > +	lockdep_off();
> >  }
> >  
> >  void kprobe_busy_end(void)
> >  {
> > +	lockdep_on();
> >  	__this_cpu_write(current_kprobe, NULL);
> >  	preempt_enable();
> >  }
> > -- 
> 
> No, this is not the correct workaround (too big of a hammer). You could do
> the following:
> 
> From 4139d9c8437b0bd2262e989ca4eb0a83b7e7bb72 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Date: Mon, 2 Nov 2020 09:17:49 -0500
> Subject: [PATCH] kprobes: Tell lockdep about kprobe nesting
> 
> Since the kprobe handlers have protection that prohibits other handlers from
> executing in other contexts (like if an NMI comes in while processing a
> kprobe, and executes the same kprobe, it will get fail with a "busy"
> return). Lockdep is unaware of this protection. Use lockdep's nesting api to
> differentiate between locks taken in NMI context and other context to
> supress the false warnings.

Ah, OK. This looks good to me.

BTW, in_nmi() in pre_handler_kretprobe() always be true because
now int3 is treated as an NMI. So you can always pass 1 there.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Link: https://lore.kernel.org/r/20201102160234.fa0ae70915ad9e2b21c08b85@kernel.org
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/kprobes.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 8a12a25fa40d..ccb285867059 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1249,7 +1249,12 @@ __acquires(hlist_lock)
>  
>  	*head = &kretprobe_inst_table[hash];
>  	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	/*
> +	 * Nested is a workaround that will soon not be needed.
> +	 * There's other protections that make sure the same lock
> +	 * is not taken on the same CPU that lockdep is unaware of.
> +	 */
> +	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
>  }
>  NOKPROBE_SYMBOL(kretprobe_hash_lock);
>  
> @@ -1258,7 +1263,12 @@ static void kretprobe_table_lock(unsigned long hash,
>  __acquires(hlist_lock)
>  {
>  	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	/*
> +	 * Nested is a workaround that will soon not be needed.
> +	 * There's other protections that make sure the same lock
> +	 * is not taken on the same CPU that lockdep is unaware of.
> +	 */
> +	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_lock);
>  
> @@ -2025,10 +2035,16 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
>  	unsigned long hash, flags = 0;
>  	struct kretprobe_instance *ri;
> +	int nmi = !!in_nmi();
>  
>  	/* TODO: consider to only swap the RA after the last pre_handler fired */
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);
> -	raw_spin_lock_irqsave(&rp->lock, flags);
> +	/*
> +	 * Nested is a workaround that will soon not be needed.
> +	 * There's other protections that make sure the same lock
> +	 * is not taken on the same CPU that lockdep is unaware of.
> +	 */
> +	raw_spin_lock_irqsave_nested(&rp->lock, flags, nmi);
>  	if (!hlist_empty(&rp->free_instances)) {
>  		ri = hlist_entry(rp->free_instances.first,
>  				struct kretprobe_instance, hlist);
> @@ -2039,7 +2055,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  		ri->task = current;
>  
>  		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> -			raw_spin_lock_irqsave(&rp->lock, flags);
> +			raw_spin_lock_irqsave_nested(&rp->lock, flags, nmi);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
>  			raw_spin_unlock_irqrestore(&rp->lock, flags);
>  			return 0;
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

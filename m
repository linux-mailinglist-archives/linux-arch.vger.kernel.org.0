Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFCD25AFFE
	for <lists+linux-arch@lfdr.de>; Wed,  2 Sep 2020 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgIBPsF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Sep 2020 11:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgIBNa1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Sep 2020 09:30:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB8F20767;
        Wed,  2 Sep 2020 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599052772;
        bh=4nBXQMAOX8blqbEXUEK70S72k3vG/C/3WXxmVFWBar4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GDugYxKxMVWwExNCyjSt5NxZo2b+BOn20T2fVJ2yxRdYdrN6hepJZtB/s2/MXTW0s
         r76jarj7gquPqJPY1fqrxk/hfsee9aJEAZWSNXMJklfkYIynP6Pbg0v3ImtCT4yjvt
         FQV9h3RqWmVwUwCUZXWdYndzN4wtozFTyS1Tos+E=
Date:   Wed, 2 Sep 2020 22:19:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
In-Reply-To: <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2 Sep 2020 11:36:13 +0200
peterz@infradead.org wrote:

> On Wed, Sep 02, 2020 at 05:17:55PM +0900, Masami Hiramatsu wrote:
> 
> > > Ok, but then lockdep will yell at you if you have that enabled and run
> > > the unoptimized things.
> > 
> > Oh, does it warn for all spinlock things in kprobes if it is unoptimized?
> > Hmm, it has to be noted in the documentation.
> 
> Lockdep will warn about spinlocks used in NMI context that are also used
> outside NMI context.

OK, but raw_spin_lock_irqsave() will not involve lockdep, correct?

> Now, for the kretprobe that kprobe_busy flag prevents the actual
> recursion self-deadlock, but lockdep isn't smart enough to see that.
> 
> One way around this might be to use SINGLE_DEPTH_NESTING for locks when
> we use them from INT3 context. That way they'll have a different class
> and lockdep will not see the recursion.

Hmm, so lockdep warns only when it detects the spinlock in NMI context,
and int3 is now always NMI, thus all spinlock (except raw_spinlock?)
in kprobe handlers should get warned, right?
I have tested this series up to [16/21] with optprobe disabled, but
I haven't see the lockdep warnings.

> 
> pre_handler_kretprobe() is always called from INT3, right?

No, not always, it can be called from optprobe (same as original code
context) or ftrace handler.
But if you set 0 to /proc/sys/debug/kprobe_optimization, and compile
the kernel without function tracer, it should always be called from
INT3.

> 
> Something like the below might then work...

OK, but I would like to reproduce the lockdep warning on this for
confirmation.

Thank you,

> 
> ---
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..b78f4fe08e86 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1255,11 +1255,11 @@ __acquires(hlist_lock)
>  NOKPROBE_SYMBOL(kretprobe_hash_lock);
>  
>  static void kretprobe_table_lock(unsigned long hash,
> -				 unsigned long *flags)
> +				 unsigned long *flags, int nesting)
>  __acquires(hlist_lock)
>  {
>  	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	raw_spin_lock_irqsave_nested(hlist_lock, *flags, nesting);
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_lock);
>  
> @@ -1326,7 +1326,7 @@ void kprobe_flush_task(struct task_struct *tk)
>  	INIT_HLIST_HEAD(&empty_rp);
>  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
>  	head = &kretprobe_inst_table[hash];
> -	kretprobe_table_lock(hash, &flags);
> +	kretprobe_table_lock(hash, &flags, 0);
>  	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
>  		if (ri->task == tk)
>  			recycle_rp_inst(ri, &empty_rp);
> @@ -1361,7 +1361,7 @@ static void cleanup_rp_inst(struct kretprobe *rp)
>  
>  	/* No race here */
>  	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
> -		kretprobe_table_lock(hash, &flags);
> +		kretprobe_table_lock(hash, &flags, 0);
>  		head = &kretprobe_inst_table[hash];
>  		hlist_for_each_entry_safe(ri, next, head, hlist) {
>  			if (ri->rp == rp)
> @@ -1950,7 +1950,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  
>  	/* TODO: consider to only swap the RA after the last pre_handler fired */
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);
> -	raw_spin_lock_irqsave(&rp->lock, flags);
> +	raw_spin_lock_irqsave_nested(&rp->lock, flags, SINGLE_DEPTH_NESTING);
>  	if (!hlist_empty(&rp->free_instances)) {
>  		ri = hlist_entry(rp->free_instances.first,
>  				struct kretprobe_instance, hlist);
> @@ -1961,7 +1961,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  		ri->task = current;
>  
>  		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> -			raw_spin_lock_irqsave(&rp->lock, flags);
> +			raw_spin_lock_irqsave_nested(&rp->lock, flags, SINGLE_DEPTH_NESTING);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
>  			raw_spin_unlock_irqrestore(&rp->lock, flags);
>  			return 0;
> @@ -1971,7 +1971,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  
>  		/* XXX(hch): why is there no hlist_move_head? */
>  		INIT_HLIST_NODE(&ri->hlist);
> -		kretprobe_table_lock(hash, &flags);
> +		kretprobe_table_lock(hash, &flags, SINGLE_DEPTH_NESTING);
>  		hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
>  		kretprobe_table_unlock(hash, &flags);
>  	} else {


-- 
Masami Hiramatsu <mhiramat@kernel.org>

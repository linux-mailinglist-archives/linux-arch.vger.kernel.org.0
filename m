Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57232620BE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 22:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIHUPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 16:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbgIHPKm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2012405E;
        Tue,  8 Sep 2020 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577769;
        bh=HIQuytNpS2u2tupsYQd9yv/nlYoWgcoAF+EPFLxakTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RPawD2jkjqHZg8PD9kGJ5KCY7wKzZES9LcBzVvatZnsS6VWwYeIkhkNIADHvzM8KF
         xuGweNH3fY2dJfi+Zgw8OXkSbkMwVmHH8iaGQIGkqEyXSi7nNcDzMMZOQ4GfWA2qZx
         DzUKyzGPZCRwzOQL1ECxVLWaTMZ4RIWQTqtTSU3U=
Date:   Wed, 9 Sep 2020 00:09:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org, systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers
 and make kretprobe lockless
Message-Id: <20200909000923.54cca4fb530904c57e8ff529@kernel.org>
In-Reply-To: <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
        <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
        <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
        <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
        <20200908103736.GP1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 8 Sep 2020 12:37:36 +0200
peterz@infradead.org wrote:

> On Thu, Sep 03, 2020 at 10:39:54AM +0900, Masami Hiramatsu wrote:
> 
> > > There's a bug, that might make it miss it. I have a patch. I'll send it
> > > shortly.
> > 
> > OK, I've confirmed that the lockdep warns on kretprobe from INT3
> > with your fix.
> 
> I'm now trying and failing to reproduce.... I can't seem to make it use
> int3 today. It seems to want to use ftrace or refuses everything. I'm
> probably doing it wrong.

Ah, yes. For using the INT3, we need to disable CONFIG_FUNCTION_TRACER,
or enable CONFIG_KPROBE_EVENTS_ON_NOTRACE and put a kretprobe on a notrace
function :)

> 
> Could you verify the below actually works? It's on top of the first 16
> patches.

Sure. (BTW, you mean the first 15 patches, since kretprobe_hash_lock()
becomes static by 16th patch ?)

Here is the result. I got same warning with or without your patch.
I have built the kernel with CONFIG_FUNCTION_TRACER=n and CONFIG_KPROBES_SANITY_TEST=y. 

[    0.269235] PCI: Using configuration type 1 for base access
[    0.272171] Kprobe smoke test: started
[    0.281125] 
[    0.281126] ================================
[    0.281126] WARNING: inconsistent lock state
[    0.281126] 5.9.0-rc2+ #101 Not tainted
[    0.281126] --------------------------------
[    0.281127] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[    0.281127] swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[    0.281127] ffffffff8228c778 (&rp->lock){....}-{2:2}, at: pre_handler_kretprobe+0x2b/0x1b0
[    0.281128] {INITIAL USE} state was registered at:
[    0.281129]   lock_acquire+0x9e/0x3c0
[    0.281129]   _raw_spin_lock+0x2f/0x40
[    0.281129]   recycle_rp_inst+0x48/0x90
[    0.281129]   __kretprobe_trampoline_handler+0x15d/0x1e0
[    0.281130]   trampoline_handler+0x43/0x60
[    0.281130]   kretprobe_trampoline+0x2a/0x50
[    0.281130]   kretprobe_trampoline+0x0/0x50
[    0.281130]   init_kprobes+0x1b6/0x1d5
[    0.281130]   do_one_initcall+0x5c/0x315
[    0.281131]   kernel_init_freeable+0x21a/0x25f
[    0.281131]   kernel_init+0x9/0x104
[    0.281131]   ret_from_fork+0x22/0x30
[    0.281131] irq event stamp: 25978
[    0.281132] hardirqs last  enabled at (25977): [<ffffffff8108a0f7>] queue_delayed_work_on+0x57/0x90
[    0.281132] hardirqs last disabled at (25978): [<ffffffff818df778>] exc_int3+0x48/0x140
[    0.281132] softirqs last  enabled at (25964): [<ffffffff81c00389>] __do_softirq+0x389/0x48b
[    0.281133] softirqs last disabled at (25957): [<ffffffff81a00f42>] asm_call_on_stack+0x12/0x20
[    0.281133] 
[    0.281133] other info that might help us debug this:
[    0.281133]  Possible unsafe locking scenario:
[    0.281134] 
[    0.281134]        CPU0
[    0.281134]        ----
[    0.281134]   lock(&rp->lock);
[    0.281135]   <Interrupt>
[    0.281135]     lock(&rp->lock);
[    0.281136] 
[    0.281136]  *** DEADLOCK ***
[    0.281136] 
[    0.281136] no locks held by swapper/0/1.
[    0.281136] 
[    0.281137] stack backtrace:
[    0.281137] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc2+ #101
[    0.281137] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[    0.281137] Call Trace:
[    0.281138]  dump_stack+0x81/0xba
[    0.281138]  print_usage_bug.cold+0x195/0x19e
[    0.281138]  lock_acquire+0x314/0x3c0
[    0.281138]  ? __text_poke+0x2db/0x400
[    0.281139]  ? pre_handler_kretprobe+0x2b/0x1b0
[    0.281139]  _raw_spin_lock_irqsave+0x3a/0x50
[    0.281139]  ? pre_handler_kretprobe+0x2b/0x1b0
[    0.281139]  pre_handler_kretprobe+0x2b/0x1b0
[    0.281139]  ? stop_machine_from_inactive_cpu+0x120/0x120
[    0.281140]  aggr_pre_handler+0x5f/0xd0
[    0.281140]  kprobe_int3_handler+0x10f/0x160
[    0.281140]  exc_int3+0x52/0x140
[    0.281140]  asm_exc_int3+0x31/0x40
[    0.281141] RIP: 0010:kprobe_target+0x1/0x10
[    0.281141] Code: 65 48 33 04 25 28 00 00 00 75 10 48 81 c4 90 00 00 00 44 89 e0 41 5c 5d c3 0f 0b e8 a
[    0.281141] RSP: 0000:ffffc90000013e48 EFLAGS: 00000246
[    0.281142] RAX: ffffffff81142130 RBX: 0000000000000001 RCX: ffffc90000013cec
[    0.281142] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 00000000f3eb0b20
[    0.281142] RBP: ffffc90000013e68 R08: 0000000000000000 R09: 0000000000000001
[    0.281143] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    0.281143] R13: ffffffff8224c2b0 R14: ffffffff8255cf60 R15: 0000000000000000
[    0.281143]  ? stop_machine_from_inactive_cpu+0x120/0x120
[    0.281143]  ? kprobe_target+0x1/0x10
[    0.281144]  ? stop_machine_from_inactive_cpu+0x120/0x120
[    0.281144]  ? init_test_probes.cold+0x2e3/0x391
[    0.281144]  init_kprobes+0x1b6/0x1d5
[    0.281144]  ? debugfs_kprobe_init+0xa9/0xa9
[    0.281145]  do_one_initcall+0x5c/0x315
[    0.281145]  ? rcu_read_lock_sched_held+0x4a/0x80
[    0.281145]  kernel_init_freeable+0x21a/0x25f
[    0.281145]  ? rest_init+0x23c/0x23c
[    0.281145]  kernel_init+0x9/0x104
[    0.281146]  ret_from_fork+0x22/0x30
[    0.281282] Kprobe smoke test: passed successfully


> 
> > Of course make it lockless then warning is gone.
> > But even without the lockless patch, this warning can be false-positive
> > because we prohibit nested kprobe call, right?
> 
> Yes, because the actual nesting is avoided by kprobe_busy, but lockdep
> can't tell. Lockdep sees a regular lock user and an in-nmi lock user and
> figures that's a bad combination.

Thanks for confirmation!

> 
> 
> ---
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1241,48 +1241,47 @@ void recycle_rp_inst(struct kretprobe_in
>  }
>  NOKPROBE_SYMBOL(recycle_rp_inst);
>  
> -void kretprobe_hash_lock(struct task_struct *tsk,
> -			 struct hlist_head **head, unsigned long *flags)
> -__acquires(hlist_lock)
> -{
> -	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> -	raw_spinlock_t *hlist_lock;
> -
> -	*head = &kretprobe_inst_table[hash];
> -	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> -}
> -NOKPROBE_SYMBOL(kretprobe_hash_lock);
> -
>  static void kretprobe_table_lock(unsigned long hash,
>  				 unsigned long *flags)
>  __acquires(hlist_lock)
>  {
>  	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> +	/*
> +	 * HACK, due to kprobe_busy we'll never actually recurse, make NMI
> +	 * context use a different lock class to avoid it reporting.
> +	 */
> +	raw_spin_lock_irqsave_nested(hlist_lock, *flags, !!in_nmi());
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_lock);
>  
> -void kretprobe_hash_unlock(struct task_struct *tsk,
> -			   unsigned long *flags)
> +static void kretprobe_table_unlock(unsigned long hash,
> +				   unsigned long *flags)
>  __releases(hlist_lock)
>  {
> +	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> +	raw_spin_unlock_irqrestore(hlist_lock, *flags);
> +}
> +NOKPROBE_SYMBOL(kretprobe_table_unlock);
> +
> +void kretprobe_hash_lock(struct task_struct *tsk,
> +			 struct hlist_head **head, unsigned long *flags)
> +__acquires(hlist_lock)
> +{
>  	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> -	raw_spinlock_t *hlist_lock;
>  
> -	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_unlock_irqrestore(hlist_lock, *flags);
> +	*head = &kretprobe_inst_table[hash];
> +	kretprobe_table_lock(hash, flags);
>  }
> -NOKPROBE_SYMBOL(kretprobe_hash_unlock);
> +NOKPROBE_SYMBOL(kretprobe_hash_lock);
>  
> -static void kretprobe_table_unlock(unsigned long hash,
> -				   unsigned long *flags)
> +void kretprobe_hash_unlock(struct task_struct *tsk,
> +			   unsigned long *flags)
>  __releases(hlist_lock)
>  {
> -	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_unlock_irqrestore(hlist_lock, *flags);
> +	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> +	kretprobe_table_unlock(hash, flags);
>  }
> -NOKPROBE_SYMBOL(kretprobe_table_unlock);
> +NOKPROBE_SYMBOL(kretprobe_hash_unlock);
>  
>  struct kprobe kprobe_busy = {
>  	.addr = (void *) get_kprobe,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

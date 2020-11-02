Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260CD2A23F5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 06:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgKBFLo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 00:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgKBFLn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 00:11:43 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9492921D91;
        Mon,  2 Nov 2020 05:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604293902;
        bh=WBqK3hQfaLDnY6xifFw2NtALyoUiphjppFurxkLVyq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Aa+ldGx4dqa2NQewkBzftlMRzPR7K6Jh/SmXv09lHJPUnJdUPhNDBzgh/fOv/h2g2
         /0itfM3ZFOKYleV/aF+tJdq10DVGiYfbEtSebB+qB7KlFSplI3acgZ1cXzAT0l3oPn
         Gj6uLL0Nxw+cdA2Uc1kIKYmxCWsVYTgsYw6iqng8=
Date:   Mon, 2 Nov 2020 14:11:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [PATCH v5 14/21] kprobes: Remove NMI context check
Message-Id: <20201102141138.1fa825113742f3bea23bc383@kernel.org>
In-Reply-To: <20201030213831.04e81962@oasis.local.home>
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <159870615628.1229682.6087311596892125907.stgit@devnote2>
        <20201030213831.04e81962@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 30 Oct 2020 21:38:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 29 Aug 2020 22:02:36 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since the commit 9b38cc704e84 ("kretprobe: Prevent triggering
> > kretprobe from within kprobe_flush_task") sets a dummy current
> > kprobe in the trampoline handler by kprobe_busy_begin/end(),
> > it is not possible to run a kretprobe pre handler in kretprobe
> > trampoline handler context even with the NMI. If the NMI interrupts
> > a kretprobe_trampoline_handler() and it hits a kretprobe, the
> > 2nd kretprobe will detect recursion correctly and it will be
> > skipped.
> > This means we have almost no double-lock issue on kretprobes by NMI.
> > 
> > The last one point is in cleanup_rp_inst() which also takes
> > kretprobe_table_lock without setting up current kprobes.
> > So adding kprobe_busy_begin/end() there allows us to remove
> > in_nmi() check.
> > 
> > The above commit applies kprobe_busy_begin/end() on x86, but
> > now all arch implementation are unified to generic one, we can
> > safely remove the in_nmi() check from arch independent code.
> >
> 
> So are you saying that lockdep is lying?
> 
> Kprobe smoke test: started
> 
> ================================
> WARNING: inconsistent lock state
> 5.10.0-rc1-test+ #29 Not tainted
> --------------------------------
> inconsistent {INITIAL USE} -> {IN-NMI} usage.
> swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
> ffffffff82b07118 (&rp->lock){....}-{2:2}, at: pre_handler_kretprobe+0x4b/0x193
> {INITIAL USE} state was registered at:
>   lock_acquire+0x280/0x325
>   _raw_spin_lock+0x30/0x3f
>   recycle_rp_inst+0x3f/0x86
>   __kretprobe_trampoline_handler+0x13a/0x177
>   trampoline_handler+0x48/0x57
>   kretprobe_trampoline+0x2a/0x4f
>   kretprobe_trampoline+0x0/0x4f
>   init_kprobes+0x193/0x19d
>   do_one_initcall+0xf9/0x27e
>   kernel_init_freeable+0x16e/0x2b6
>   kernel_init+0xe/0x109
>   ret_from_fork+0x22/0x30
> irq event stamp: 1670
> hardirqs last  enabled at (1669): [<ffffffff811cc344>] slab_free_freelist_hook+0xb4/0xfd
> hardirqs last disabled at (1670): [<ffffffff81da0887>] exc_int3+0xae/0x10a
> softirqs last  enabled at (1484): [<ffffffff82000352>] __do_softirq+0x352/0x38d
> softirqs last disabled at (1471): [<ffffffff81e00f82>] asm_call_irq_on_stack+0x12/0x20
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&rp->lock);
>   <Interrupt>
>     lock(&rp->lock);
> 
>  *** DEADLOCK ***
> 
> no locks held by swapper/0/1.
> 
> stack backtrace:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-test+ #29
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> Call Trace:
>  dump_stack+0x7d/0x9f
>  print_usage_bug+0x1c0/0x1d3
>  lock_acquire+0x302/0x325
>  ? pre_handler_kretprobe+0x4b/0x193
>  ? stop_machine_from_inactive_cpu+0x120/0x120
>  _raw_spin_lock_irqsave+0x43/0x58
>  ? pre_handler_kretprobe+0x4b/0x193
>  pre_handler_kretprobe+0x4b/0x193
>  ? stop_machine_from_inactive_cpu+0x120/0x120
>  ? kprobe_target+0x1/0x16
>  kprobe_int3_handler+0xd0/0x109
>  exc_int3+0xb8/0x10a
>  asm_exc_int3+0x31/0x40
> RIP: 0010:kprobe_target+0x1/0x16
>  5d c3 cc
> RSP: 0000:ffffc90000033e00 EFLAGS: 00000246
> RAX: ffffffff8110ea77 RBX: 0000000000000001 RCX: ffffc90000033cb4
> RDX: 0000000000000231 RSI: 0000000000000000 RDI: 000000003ca57c35
> RBP: ffffc90000033e20 R08: 0000000000000000 R09: ffffffff8111d207
> R10: ffff8881002ab480 R11: ffff8881002ab480 R12: 0000000000000000
> R13: ffffffff82a52af0 R14: 0000000000000200 R15: ffff888100331130
>  ? register_kprobe+0x43c/0x492
>  ? stop_machine_from_inactive_cpu+0x120/0x120
>  ? kprobe_target+0x1/0x16
>  ? init_test_probes+0x2c6/0x38a
>  init_kprobes+0x193/0x19d
>  ? debugfs_kprobe_init+0xb8/0xb8
>  do_one_initcall+0xf9/0x27e
>  ? rcu_read_lock_sched_held+0x3e/0x75
>  ? init_mm_internals+0x27b/0x284
>  kernel_init_freeable+0x16e/0x2b6
>  ? rest_init+0x152/0x152
>  kernel_init+0xe/0x109
>  ret_from_fork+0x22/0x30
> Kprobe smoke test: passed successfully
> 
> Config attached.

Thanks for the report! Let me check what happen.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>

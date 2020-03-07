Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1717CA96
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 02:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCGB6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 20:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCGB6v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 20:58:51 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B41206CC;
        Sat,  7 Mar 2020 01:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583546331;
        bh=ExtkPMqbgavpcWFzRo9l0MznJQ9+a243YmhK0uBJNN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gtVaGIY0wwidlN5U3Cl7bbAxy2RxRQC+vbTPjbg+TCQUZyt1UTFRxJvbNSK8Dcb3r
         //l4vlMFu6yeFSopSqper9JkU2BeONsjw+wrK1hCLZcL8Pk9LMD3P4NSIU8CoDbdlm
         rDaztdsQZf3WyhEx2axxC/NYTCktOf+wSrNMjp38=
Date:   Sat, 7 Mar 2020 10:58:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-Id: <20200307105846.71c3f9c1df298f2754fe30ae@kernel.org>
In-Reply-To: <20200306191151.GA60713@google.com>
References: <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
        <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
        <20200217163112.GM2935@paulmck-ThinkPad-P72>
        <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
        <20200218124609.1a33f868@gandalf.local.home>
        <20200218201806.GI2935@paulmck-ThinkPad-P72>
        <20200219114510.6f942b56868a97e06352738c@kernel.org>
        <20200307030149.1f70bdb019ad5ea896bce5a7@kernel.org>
        <20200306191151.GA60713@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Mar 2020 14:11:51 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Sat, Mar 07, 2020 at 03:01:49AM +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > On Wed, 19 Feb 2020 11:45:10 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Tue, 18 Feb 2020 12:18:06 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > On Tue, Feb 18, 2020 at 12:46:09PM -0500, Steven Rostedt wrote:
> > > > > On Tue, 18 Feb 2020 13:33:35 +0900
> > > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > 
> > > > > > On Mon, 17 Feb 2020 08:31:12 -0800
> > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > >   
> > > > > > > > BTW, if you consider the x86 specific code is in the generic file,
> > > > > > > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > > > > > > > (Sorry, I've hit this idea right now)  
> > > > > > > 
> > > > > > > Might this affect other architectures with NMIs and probe-like things?
> > > > > > > If so, it might make sense to leave it where it is.  
> > > > > > 
> > > > > > Yes, git grep shows that arm64 is using rcu_nmi_enter() in
> > > > > > debug_exception_enter().
> > > > > > OK, let's keep it, but maybe it is good to update the comment for
> > > > > > arm64 too. What about following?
> > > > > > 
> > > > > > +/*
> > > > > > + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
> > > > > > + * marked NOKPROBE before kprobes handler is called.
> > > > > > + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
> > > > > > + * before kprobes handle happens to call rcu_nmi_enter() which means
> > > > > > + * that rcu_nmi_enter() must be marked NOKRPOBE.
> > > > > > + */
> > > > > > 
> > > > > 
> > > > > Ah, why don't we just say...
> > > > > 
> > > > > /*
> > > > >  * All functions called in the breakpoint trap handler (e.g. do_int3()
> > > > >  * on x86), must not allow kprobes until the kprobe breakpoint handler
> > > > >  * is called, otherwise it can cause an infinite recursion.
> > > > >  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> > > > >  * before the kprobe breakpoint handler is called, thus it must be
> > > > >  * marked as NOKPROBE.
> > > > >  */
> > > > > 
> > > > > And that way we don't make this an arch specific comment.
> > > > 
> > > > That looks good to me.  Masami, does this work for you?
> > > 
> > > Yes, that looks good to me too :)
> > 
> > Oops, I'm guilty!
> > Sorry *rcu_nmi_exit()* also must be NOKPROBE, since even if we could catch
> > a recursive kprobe call, we can only skip the kprobe handler, but we must
> > exit from do_int3() and hit rcu_nmi_exit() again!
> > 
> > [45235.497591] Unrecoverable kprobe detected.
> > [45235.501400] Dumping kprobe:
> > [45235.502433] Name: (null)
> > [45235.502433] Offset: 0
> > [45235.502433] Address: rcu_nmi_exit+0x0/0x290
> > [45235.504044] ------------[ cut here ]------------
> > [45235.504855] kernel BUG at arch/x86/kernel/kprobes/core.c:646!
> > [45235.505816] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > [45235.506615] CPU: 7 PID: 143 Comm: sh Not tainted 5.6.0-rc3+ #143
> > [45235.507662] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > [45235.509764] RIP: 0010:reenter_kprobe.cold+0x14/0x16
> > [45235.510630] Code: 48 8b 75 10 48 c7 c7 f0 70 0e 82 48 8b 56 28 e8 22 91 08 00 0f 0b 48 c7 c7 20 71 0e 82 e8 14 91 08 00 48 89 ef e8 23 ee 0f 00 <0f> 0b 48 89 ee 48 c7 c7 48 71 0e 82 e8 fb 90 08 00 e9 c3 fc ff ff
> > [45235.513948] RSP: 0018:ffffc90000347bf8 EFLAGS: 00010046
> > [45235.514906] RAX: 0000000000000036 RBX: 0000000000017f20 RCX: 0000000000000000
> > [45235.516109] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> > [45235.517278] RBP: ffff88807c9820c0 R08: 0000000000000000 R09: 0000000000000001
> > [45235.518415] R10: 0000000000000000 R11: ffff88807c9d1f18 R12: ffff88807d9d7f20
> > [45235.519609] R13: ffffc90000347c68 R14: ffffffff810e8a60 R15: ffffffff810e8a61
> > [45235.520787] FS:  0000000001d9a8c0(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
> > [45235.522198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [45235.523172] CR2: 0000000001da9000 CR3: 000000007a880000 CR4: 00000000000006a0
> > [45235.524288] Call Trace:
> > [45235.524825]  kprobe_int3_handler+0x74/0x150
> > [45235.525627]  do_int3+0x36/0xf0
> > [45235.526244]  int3+0x42/0x50
> > [45235.526767] RIP: 0010:rcu_nmi_exit+0x1/0x290
> > [45235.527551] Code: a2 0d 82 be c2 01 00 00 48 c7 c7 d5 44 0f 82 c6 05 e7 ac 24 01 01 e8 1f ba fd ff eb b8 66 66 2e 0f 1f 84 00 00 00 00 00 90 cc <57> 41 56 41 55 41 54 55 48 c7 c5 40 c2 02 00 53 48 89 eb e8 77 75
> > [45235.530898] RSP: 0018:ffffc90000347d40 EFLAGS: 00000046
> > [45235.531816] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [45235.533001] RDX: 0000000000000001 RSI: ffffffff8101e1fe RDI: ffffffff8101e1fe
> > [45235.534252] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > [45235.535516] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > [45235.536759] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [45235.537945]  ? ist_exit+0xe/0x20
> > [45235.538593]  ? ist_exit+0xe/0x20
> > [45235.539239]  ? rcu_nmi_exit+0x1/0x290
> > [45235.541182]  int3+0x42/0x50
> > [45235.541687] RIP: 0010:0xffffffffa000005a
> > [45235.542363] Code: 2e 16 13 e1 00 00 00 00 00 00 00 00 89 f8 e9 1f 16 13 e1 00 00 00 00 00 00 00 00 89 f8 e9 20 16 13 e1 00 00 00 00 00 00 00 00 <41> 57 e9 01 8a 0e e1 00 00 00 00 00 00 00 00 41 57 e9 f2 22 26 e1
> > [45235.545628] RSP: 0018:ffffc90000347e20 EFLAGS: 00000146
> > [45235.546596] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [45235.547989] RDX: 0000000000000001 RSI: ffffffff8101e1fe RDI: ffffffff8101e1fe
> > [45235.550183] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff88807d2aa000
> > [45235.551591] R10: 0000000000000a4c R11: ffff88807bfec600 R12: 0000000000000000
> > [45235.552893] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [45235.554633]  ? ist_exit+0xe/0x20
> > [45235.555537]  ? ist_exit+0xe/0x20
> > [45235.556565]  ? rcu_nmi_exit+0x1/0x290
> > [45235.557909]  ? int3+0x42/0x50
> > [45235.559156]  ? 0xffffffffa0000069
> > [45235.560547]  ? vfs_read+0x1/0x150
> > [45235.561522]  ? ksys_read+0x60/0xe0
> > [45235.562458]  ? do_syscall_64+0x4b/0x1e0
> > [45235.563404]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [45235.564705] Modules linked in:
> > [45235.565556] ---[ end trace 870af8724dba9ac8 ]---
> > 
> > So all functions called from do_int3() must be NOKPROBE.
> 
> Makes sense, I am curious though why you thought before that the breakpoint
> recursion was not possible *after* kprobe_int3_handler(). In the below thread
> you said it is to be marked only for functions *before*
> kprobe_int3_handler(). Was there a reason?
> https://lore.kernel.org/lkml/154998793571.31052.11301258949601150994.stgit@devbox/

Sorry, that was my simple mistake. When I tested the rcu_nmi_exit(), I forgot
to disable optprobe. So whole the do_int3() was not hit... (I had to think
deeper why the hit count of the probe was not incremented at that point.)

This time, I set 0 to the /proc/sys/debug/kprobes_optimization, and confirmed
this bug.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75F2255D02
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgH1Oto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 10:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgH1Otl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 10:49:41 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6BFD2086A;
        Fri, 28 Aug 2020 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598626180;
        bh=04a6vdBBQ6R1olubD3jLTI1BBJ7EVXFpOwF6nXaK8HI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ccty4vJPd5OwGxITyMDnjL+eN+Jm4usNwk0IsL/BdzO3HVEOqk2ZYlr67psF6KzC9
         8QPUwgmdVp7w4he0jJn82c/GRukVl0pqmR1V/KXnleYeGrP7TS0BJoxsyJ0+MlLqRt
         0FgXFmeY2B8pP84cbqV0xtQ+j3+qE4sITjaZTIho=
Date:   Fri, 28 Aug 2020 23:49:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "cameron@moodycamel.com" <cameron@moodycamel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
Message-Id: <20200828234937.9ff591e59591a966f3d17858@kernel.org>
In-Reply-To: <7df0a1af432040d9908517661c32dc34@trendmicro.com>
References: <20200827161237.889877377@infradead.org>
        <20200827161754.359432340@infradead.org>
        <7df0a1af432040d9908517661c32dc34@trendmicro.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 13:11:15 +0000
"Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:

> > -----Original Message----
> Hi, I found a NULL pointer dereference here, where current->kretprobe_instances.first == NULL in these two scenario:
> 
> 1) In task "rs:main Q:Reg"
> # insmod samples/kprobes/kretprobe_example.ko func=schedule
> # pkill sddm-greeter
> 
> 2) In task "llvmpipe-10"
> # insmod samples/kprobes/kretprobe_example.ko func=schedule
> login plasmashell session from sddm graphical interface
> 
> based on Masami's v2 + Peter's lockless patch, I'll try the new branch once I can compile kernel
> 
> Stacktrace may not be really useful here:
> [  402.008630] BUG: kernel NULL pointer dereference, address: 0000000000000018
> [  402.008633] #PF: supervisor read access in kernel mode
> [  402.008642] #PF: error_code(0x0000) - not-present page
> [  402.008644] PGD 0 P4D 0
> [  402.008646] Oops: 0000 [#1] PREEMPT SMP PTI
> [  402.008649] CPU: 7 PID: 1505 Comm: llvmpipe-10 Kdump: loaded Not tainted 5.9.0-rc2-00111-g72091ec08f03-dirty #45

Hmm, this case llvmpipe will be the user task (not kthread, I guess)

Here are some logs, both happened with following command and wait 5min or so.

cd /sys/kernel/debug/tracing/
echo r:event1 vfs_read >> kprobe_events
echo r:event2 vfs_read %ax >> kprobe_events
echo r:event3 rw_verify_area %ax >> kprobe_events
echo r:schedule schedule >> kprobe_events
echo 1 > events/kprobes/enable


[  332.986337] ------------[ cut here ]------------
[  332.987312] kernel BUG at kernel/kprobes.c:1893!
[  332.988237] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  332.989108] CPU: 7 PID: 55 Comm: kcompactd0 Not tainted 5.9.0-rc2+ #54
[  332.990480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  332.994600] RIP: 0010:__kretprobe_trampoline_handler+0xf2/0x100
[  332.995551] Code: 48 c7 05 e5 40 ec 7e c0 cc 28 82 4c 89 ff e8 c5 fe ff ff 48 85 db 75 92 48 83 c4 08 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 55 48 89 e5 41 56 41 55
[  332.998498] RSP: 0000:ffffc90000217cf8 EFLAGS: 00010246
[  332.999405] RAX: ffff88807cfe9700 RBX: 0000000000000000 RCX: 0000000000000000
[  333.000597] RDX: ffffc90000217de8 RSI: ffffffff810471e0 RDI: ffffc90000217d50
[  333.002058] RBP: ffffc90000217d28 R08: 0000000000000001 R09: 0000000000000001
[  333.003594] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90000217d50
[  333.005219] R13: ffff88807d7dbac0 R14: ffffc90000217e00 R15: ffff88807d7dbac0
[  333.006826] FS:  0000000000000000(0000) GS:ffff88807d7c0000(0000) knlGS:0000000000000000
[  333.008787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  333.010249] CR2: 0000000000000000 CR3: 0000000002220000 CR4: 00000000000006a0
[  333.011895] Call Trace:
[  333.012529]  trampoline_handler+0x43/0x60
[  333.013214]  kretprobe_trampoline+0x2a/0x50
[  333.014028] RIP: 0010:kretprobe_trampoline+0x0/0x50
[  333.014856] Code: c7 e9 2d 04 82 e8 a0 f2 0d 00 5d c3 31 f6 e9 79 ff ff ff be 01 00 00 00 e9 6f ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc <54> 9c 48 83 ec 18 57 56 52 51 50 41 50 41 51 41 52 41 53 53 55 41
[  333.017750] RSP: 81170fba:ffffc90000217df0 EFLAGS: 00000246
[  333.018894] RAX: 0000000040200040 RBX: ffff88807d7dbac0 RCX: 0000000000000000
[  333.020232] RDX: 0000000000000001 RSI: ffffffff818e51b4 RDI: ffffffff818e51b4
[  333.021476] RBP: ffffc90000217e88 R08: 0000000000000001 R09: 0000000000000001
[  333.022603] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000100008044
[  333.024221] R13: ffff88807d7dbac0 R14: ffffc90000217e00 R15: ffff88807d7dbac0
[  333.025851]  ? schedule+0x54/0x100
[  333.026717]  ? schedule+0x54/0x100
[  333.027400]  ? trace_preempt_on+0x2a/0xd0
[  333.028161]  ? __next_timer_interrupt+0x110/0x110
[  333.029080]  kcompactd+0x20e/0x350
[  333.029882]  ? wait_woken+0x80/0x80
[  333.030593]  ? kcompactd_do_work+0x3a0/0x3a0
[  333.031347]  kthread+0x13c/0x180
[  333.031988]  ? kthread_park+0x90/0x90
[  333.032734]  ret_from_fork+0x22/0x30
[  333.033557] Modules linked in:
[  333.034451] ---[ end trace 901e8137e8d04982 ]---
[  333.035601] RIP: 0010:__kretprobe_trampoline_handler+0xf2/0x100
[  333.037073] Code: 48 c7 05 e5 40 ec 7e c0 cc 28 82 4c 89 ff e8 c5 fe ff ff 48 85 db 75 92 48 83 c4 08 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 55 48 89 e5 41 56 41 55
[  333.041089] RSP: 0000:ffffc90000217cf8 EFLAGS: 00010246
[  333.042201] RAX: ffff88807cfe9700 RBX: 0000000000000000 RCX: 0000000000000000
[  333.043747] RDX: ffffc90000217de8 RSI: ffffffff810471e0 RDI: ffffc90000217d50
[  333.045063] RBP: ffffc90000217d28 R08: 0000000000000001 R09: 0000000000000001
[  333.046547] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90000217d50
[  333.048055] R13: ffff88807d7dbac0 R14: ffffc90000217e00 R15: ffff88807d7dbac0
[  333.049616] FS:  0000000000000000(0000) GS:ffff88807d7c0000(0000) knlGS:0000000000000000
[  333.051487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  333.052737] CR2: 0000000000000000 CR3: 0000000002220000 CR4: 00000000000006a0
[  333.054127] Kernel panic - not syncing: Fatal exception
[  333.055450] Kernel Offset: disabled
[  333.056207] ---[ end Kernel panic - not syncing: Fatal exception ]---

Another one is here.

 [  335.258721] ------------[ cut here ]------------
[  335.264413] kernel BUG at kernel/kprobes.c:1893!
[  335.267757] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  335.272090] CPU: 7 PID: 71 Comm: kworker/7:1 Not tainted 5.9.0-rc2+ #54
[  335.277787] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  335.285971] Workqueue:  0x0 (mm_percpu_wq)
[  335.288156] RIP: 0010:__kretprobe_trampoline_handler+0xf2/0x100
[  335.295194] Code: 48 c7 05 e5 40 ec 7e c0 cc 28 82 4c 89 ff e8 c5 fe ff ff 48 85 db 75 92 48 83 c4 08 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 55 48 89 e5 41 56 41 55
[  335.300922] RSP: 0018:ffffc9000028fdb8 EFLAGS: 00010246
[  335.302336] RAX: ffff88807c4e9700 RBX: 0000000000000000 RCX: 0000000000000000
[  335.304154] RDX: ffffc9000028fea8 RSI: ffffffff810471e0 RDI: ffffc9000028fe10
[  335.305688] RBP: ffffc9000028fde8 R08: 0000000000000001 R09: 0000000000000001
[  335.307486] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000028fe10
[  335.309131] R13: ffff88807d7ea440 R14: ffffc900001cbd58 R15: ffff88807c4e4000
[  335.310472] FS:  0000000000000000(0000) GS:ffff88807d7c0000(0000) knlGS:0000000000000000
[  335.312121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  335.313261] CR2: 00000000005c0a56 CR3: 0000000002220000 CR4: 00000000000006a0
[  335.314561] Call Trace:
[  335.315089]  trampoline_handler+0x43/0x60
[  335.315844]  kretprobe_trampoline+0x2a/0x50
[  335.316774] RIP: 0010:kretprobe_trampoline+0x0/0x50
[  335.317651] Code: c7 e9 2d 04 82 e8 a0 f2 0d 00 5d c3 31 f6 e9 79 ff ff ff be 01 00 00 00 e9 6f ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc <54> 9c 48 83 ec 18 57 56 52 51 50 41 50 41 51 41 52 41 53 53 55 41
[  335.320480] RSP: 7c4e9700:ffffc9000028feb0 EFLAGS: 00000246
[  335.321410] RAX: ffff88807c4e4000 RBX: ffff88807d7ea440 RCX: 0000000000000000
[  335.322508] RDX: 0000000000000000 RSI: ffffffff818e51b4 RDI: ffff88807c4e9700
[  335.323611] RBP: ffffc9000028ff00 R08: 0000000000000001 R09: 0000000000000001
[  335.324699] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807c4e4028
[  335.325903] R13: ffff88807d7ea440 R14: ffffc900001cbd58 R15: ffff88807c4e4000
[  335.327012]  ? schedule+0x54/0x100
[  335.327570]  ? process_one_work+0x5c0/0x5c0
[  335.328127]  kthread+0x13c/0x180
[  335.328583]  ? kthread_park+0x90/0x90
[  335.329063]  ret_from_fork+0x22/0x30
[  335.329558] Modules linked in:
[  335.329974] ---[ end trace bd6d1f4d3806b3de ]---
[  335.330562] RIP: 0010:__kretprobe_trampoline_handler+0xf2/0x100
[  335.331294] Code: 48 c7 05 e5 40 ec 7e c0 cc 28 82 4c 89 ff e8 c5 fe ff ff 48 85 db 75 92 48 83 c4 08 4c 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 55 48 89 e5 41 56 41 55
[  335.333433] RSP: 0018:ffffc9000028fdb8 EFLAGS: 00010246
[  335.334091] RAX: ffff88807c4e9700 RBX: 0000000000000000 RCX: 0000000000000000
[  335.334959] RDX: ffffc9000028fea8 RSI: ffffffff810471e0 RDI: ffffc9000028fe10
[  335.335697] RBP: ffffc9000028fde8 R08: 0000000000000001 R09: 0000000000000001
[  335.336447] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000028fe10
[  335.337192] R13: ffff88807d7ea440 R14: ffffc900001cbd58 R15: ffff88807c4e4000
[  335.337956] FS:  0000000000000000(0000) GS:ffff88807d7c0000(0000) knlGS:0000000000000000
[  335.338917] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  335.339618] CR2: 00000000005c0a56 CR3: 0000000002220000 CR4: 00000000000006a0
[  335.340373] Kernel panic - not syncing: Fatal exception
[  335.341086] Kernel Offset: disabled
[  335.341587] ---[ end Kernel panic - not syncing: Fatal exception ]---



-- 
Masami Hiramatsu <mhiramat@kernel.org>

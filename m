Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D36256097
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 20:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgH1Shc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 14:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1Shb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 14:37:31 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6FD420838;
        Fri, 28 Aug 2020 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598639850;
        bh=hhP+sKu0o1kiHXBo6bu1hhxpjNOa9rkZcMa33yTahZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/J0/HnlctxwCJazwFzwS4hsbvilP+wb34bL60uNA1fZpgSX0cn+Qyhc7VIDUFNAp
         ppM2DznHDx5sl7dDNaoaJO0J2WjBQ7mtbebgCNiwph/V0jprSZ+Vncs3Dn80117UoF
         CdxyFapZjStCE7Hdt9Fe86zFxXeGvGKROp5BG6LA=
Date:   Sat, 29 Aug 2020 03:37:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Message-Id: <20200829033726.68547b37624d3510ebc33ab1@kernel.org>
In-Reply-To: <159861780638.992023.16486601398173945135.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
        <159861780638.992023.16486601398173945135.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 21:30:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> The kretprobe hash is mostly superfluous, replace it with a per-task
> variable.
> 
> This gets rid of the task hash and it's related locking.
> 
> The whole invalidate_rp_inst() is tedious and could go away once we
> drop rp specific ri size.

OK, something wrong with this patch. Now I can reproduce it always,
it takes around 330 second from setting up the kretprobe event on
schedule(). Maybe some timer or timeout value affect?

Anyway, before this patch, I can not reproduce the bug yet. After
applying this patch, I hit the bug always. So something wrong with this.

----
cd /sys/kernel/debug/tracing/

echo r:schedule schedule >> kprobe_events
echo 1 > events/kprobes/enable

sleep 333
----

And show this.

/sys/kernel/debug/tracing # [  336.718043] ------------[ cut here ]------------
[  336.719041] kernel BUG at kernel/kprobes.c:1950!
[  336.720212] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  336.721206] CPU: 0 PID: 85 Comm: kworker/0:2 Not tainted 5.9.0-rc2+ #58
[  336.722557] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  336.724310] Workqueue:  0x0 (events)
[  336.726997] RIP: 0010:__kretprobe_trampoline_handler+0xe5/0xf0
[  336.728084] Code: e8 20 04 79 00 65 48 c7 05 ec 4a ec 7e 00 cd 28 82 4c 89 e7 e8 ac fe ff ff 48 85 db 75 97 5b 4c 89 e8 41 5c 41 5d 41 5e 5d c3 <0f> 0b 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49 89 fc 53 48
[  336.731574] RSP: 0018:ffffc90000307dc8 EFLAGS: 00010246
[  336.732608] RAX: ffff88807d600000 RBX: 0000000000000000 RCX: 0000000000000000
[  336.733896] RDX: ffffc90000307ea8 RSI: ffffffff810471e0 RDI: ffff88807c579700
[  336.735205] RBP: ffffc90000307de8 R08: 0000000000000001 R09: 0000000000000001
[  336.736506] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90000307e10
[  336.737820] R13: ffff88807d62a440 R14: ffffc90000307e10 R15: ffff88807cfb5300
[  336.739125] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
[  336.740705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.741773] CR2: 000000000212cd38 CR3: 000000007a732000 CR4: 00000000000006b0
[  336.742953] Call Trace:
[  336.743523]  trampoline_handler+0x43/0x60
[  336.744317]  kretprobe_trampoline+0x2a/0x50
[  336.745098] RIP: 0010:kretprobe_trampoline+0x0/0x50
[  336.745961] Code: c7 39 2e 04 82 e8 a0 f2 0d 00 5d c3 31 f6 e9 79 ff ff ff be 01 00 00 00 e9 6f ff ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc <54> 9c 48 83 ec 18 57 56 52 51 50 41 50 41 51 41 52 41 53 53 55 41
[  336.749100] RSP: 7c579700:ffffc90000307eb0 EFLAGS: 00000246
[  336.750077] RAX: ffff88807cfb5300 RBX: ffff88807d62a440 RCX: 0000000000000000
[  336.751233] RDX: 0000000000000000 RSI: ffffffff818e5334 RDI: ffff88807c579700
[  336.752391] RBP: ffffc90000307f00 R08: 0000000000000001 R09: 0000000000000001
[  336.753563] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807cfb5328
[  336.754718] R13: ffff88807d62a440 R14: ffffc90000033d58 R15: ffff88807cfb5300
[  336.756005]  ? schedule+0x54/0x100
[  336.756684]  ? process_one_work+0x5c0/0x5c0
[  336.757504]  kthread+0x13c/0x180
[  336.758102]  ? kthread_park+0x90/0x90
[  336.758931]  ret_from_fork+0x22/0x30
[  336.759719] Modules linked in:
[  336.760456] ---[ end trace a7f6025840267136 ]---
[  336.761448] RIP: 0010:__kretprobe_trampoline_handler+0xe5/0xf0
[  336.762767] Code: e8 20 04 79 00 65 48 c7 05 ec 4a ec 7e 00 cd 28 82 4c 89 e7 e8 ac fe ff ff 48 85 db 75 97 5b 4c 89 e8 41 5c 41 5d 41 5e 5d c3 <0f> 0b 66 0f 1f 84 00 00 00 00 00 55 48 89 e5 41 54 49 89 fc 53 48
[  336.766128] RSP: 0018:ffffc90000307dc8 EFLAGS: 00010246
[  336.767112] RAX: ffff88807d600000 RBX: 0000000000000000 RCX: 0000000000000000
[  336.768321] RDX: ffffc90000307ea8 RSI: ffffffff810471e0 RDI: ffff88807c579700
[  336.769539] RBP: ffffc90000307de8 R08: 0000000000000001 R09: 0000000000000001
[  336.770744] R10: 0000000000000000 R11: 0000000000000001 R12: ffffc90000307e10
[  336.771947] R13: ffff88807d62a440 R14: ffffc90000307e10 R15: ffff88807cfb5300
[  336.773201] FS:  0000000000000000(0000) GS:ffff88807d600000(0000) knlGS:0000000000000000
[  336.774706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  336.775577] CR2: 000000000212cd38 CR3: 000000007a732000 CR4: 00000000000006b0
[  336.776699] Kernel panic - not syncing: Fatal exception
[  336.777829] Kernel Offset: disabled
[  336.778526] ---[ end Kernel panic - not syncing: Fatal exception ]---


Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>

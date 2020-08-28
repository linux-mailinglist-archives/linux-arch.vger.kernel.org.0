Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4B255B94
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgH1Nvr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 09:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgH1NvT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 09:51:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5268C2075B;
        Fri, 28 Aug 2020 13:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598622678;
        bh=AU0nkt3HD/dMAiwcwMOKnZmLAkdcDbmItz+LEm358+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dDE2Pb/vfjA6ZvgdhWz6qsU0cQrK/96wTx32dUikqCH3kKl1v0kNJDHM9W+zb9iuV
         h2Uu6sTR7IFgCrfU3xoZc4Y89D+rMsc1AF+KODJ90mNwUGcYisdBtCwZFGl/+QAKu6
         6n0f9NVDQTuMt6e3JEhxztkNF/8nGsgfGOGHVCfQ=
Date:   Fri, 28 Aug 2020 22:51:13 +0900
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
Message-Id: <20200828225113.9541a5f67a3bcb17c4ce930c@kernel.org>
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

> > -----Original Message-----
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Friday, August 28, 2020 12:13 AM
> > To: linux-kernel@vger.kernel.org; mhiramat@kernel.org
> > Cc: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>; x86@kernel.org; davem@davemloft.net; rostedt@goodmis.org;
> > naveen.n.rao@linux.ibm.com; anil.s.keshavamurthy@intel.com; linux-arch@vger.kernel.org; cameron@moodycamel.com;
> > oleg@redhat.com; will@kernel.org; paulmck@kernel.org; peterz@infradead.org
> > Subject: [RFC][PATCH 3/7] kprobes: Remove kretprobe hash
> >
> > @@ -1935,71 +1932,45 @@ unsigned long __kretprobe_trampoline_han
> >                                         unsigned long trampoline_address,
> >                                         void *frame_pointer)
> >  {
> > // ... removed
> > // NULL here
> > +       first = node = current->kretprobe_instances.first;
> > +       while (node) {
> > +               ri = container_of(node, struct kretprobe_instance, llist);
> >
> > -               orig_ret_address = (unsigned long)ri->ret_addr;
> > -               if (skipped)
> > -                       pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
> > -                               ri->rp->kp.addr);
> > +               BUG_ON(ri->fp != frame_pointer);
> >
> > -               if (orig_ret_address != trampoline_address)
> > +               orig_ret_address = (unsigned long)ri->ret_addr;
> > +               if (orig_ret_address != trampoline_address) {
> >                         /*
> >                          * This is the real return address. Any other
> >                          * instances associated with this task are for
> >                          * other calls deeper on the call stack
> >                          */
> >                         break;
> > +               }
> > +
> > +               node = node->next;
> >         }
> >
> 
> Hi, I found a NULL pointer dereference here, where current->kretprobe_instances.first == NULL in these two scenario:

Thanks! that may be what I'm chasing.

> 
> 1) In task "rs:main Q:Reg"
> # insmod samples/kprobes/kretprobe_example.ko func=schedule
> # pkill sddm-greeter
> 
> 2) In task "llvmpipe-10"
> # insmod samples/kprobes/kretprobe_example.ko func=schedule
> login plasmashell session from sddm graphical interface

OK, schedule function will be the key. I guess the senario is..

1) kretporbe replace the return address with kretprobe_trampoline on task1's kernel stack
2) the task1 forks task2 before returning to the kretprobe_trampoline
3) while copying the process with the kernel stack, task2->kretprobe_instances.first = NULL
4) task2 returns to the kretprobe_trampoline
5) Bomb!

Hmm, we need to fixup the kernel stack when copying process. 

Thank you,

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
> [  402.008650] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
> [  402.008653] RIP: 0010:__kretprobe_trampoline_handler+0xb8/0x17f
> [  402.008655] Code: 65 4c 8b 34 25 80 6d 01 00 4c 89 e2 48 c7 c7 91 6b 85 91 49 8d b6 38 07 00 00 e8 d1 1a f9 ff 48 85 db 74 06 48 3b 5d d0 75 16 <49> 8b 75 18 48 c7 c7 a0 6c 85 91 48
>  8b 56 28 e8 b2 1a f9 ff 0f 0b
> [  402.008655] RSP: 0018:ffffab408147bde0 EFLAGS: 00010246
> [  402.008656] RAX: 0000000000000021 RBX: 0000000000000000 RCX: 0000000000000002
> [  402.008657] RDX: 0000000080000002 RSI: ffffffff9189757d RDI: 00000000ffffffff
> [  402.008658] RBP: ffffab408147be20 R08: 0000000000000001 R09: 000000000000955c
> [  402.008658] R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000000
> [  402.008659] R13: 0000000000000000 R14: ffff90736d305f40 R15: 0000000000000000
> [  402.008661] FS:  00007f20f6ffd700(0000) GS:ffff9073781c0000(0000) knlGS:0000000000000000
> [  402.008675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  402.008678] CR2: 0000000000000018 CR3: 00000001ed256006 CR4: 00000000003706e0
> [  402.008684] Call Trace:
> [  402.008689]  ? elfcorehdr_read+0x40/0x40
> [  402.008690]  ? elfcorehdr_read+0x40/0x40
> [  402.008691]  trampoline_handler+0x42/0x60
> [  402.008692]  kretprobe_trampoline+0x2a/0x50
> [  402.008693] RIP: 0010:kretprobe_trampoline+0x0/0x50
> 
> TREND MICRO EMAIL NOTICE
> 
> The information contained in this email and any attachments is confidential and may be subject to copyright or other intellectual property protection. If you are not the intended recipient, you are not authorized to use or disclose this information, and we request that you notify us by reply mail or telephone and delete the original message from your mail system.
> 
> For details about what personal information we collect and why, please see our Privacy Notice on our website at: Read privacy policy<http://www.trendmicro.com/privacy>


-- 
Masami Hiramatsu <mhiramat@kernel.org>

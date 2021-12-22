Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB947D71F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Dec 2021 19:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhLVSqr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 13:46:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47038 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbhLVSqq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 13:46:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0A861C24;
        Wed, 22 Dec 2021 18:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5AAC36AE8;
        Wed, 22 Dec 2021 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640198805;
        bh=OPM0F056+Xn6sxVEeahCN38HdV+X1zgC5cxXn0IndFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jho7VzVCY29z5Vt+NoiYwXC7GXLwulpS3griP/I9ZD0rQAonGLR21jatKYOqEY9b6
         DCsG2v92PGLbBWuy7gGBz0GydSxN6YEtOVK2SnD4Z7/9XOfzXIBXsvdbXSCywu4ItM
         41yC06zwipuLBi6f4/7nCtoEUFpRcOXEWvNyY40QpoQmg7hVptDjDYKMNRCvy0BUU/
         yaX+V0k3myBvIsHPYLPr5qTd3uiGpb2sie9dRPQheJ7cVHjomwfbGhg5MZ4S2qTZEG
         zfzUL/S0FzCza9ONCA9QAoIlHd9hvdsDsouboFQkxD/W3dTeYpzTXP2QeFcYLwanYo
         naN+Sy9gVZ1Mg==
Date:   Wed, 22 Dec 2021 11:46:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all
 kthreads
Message-ID: <YcNyjxac3wlKPywk@archlinux-ax161>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com>
 <YcNsG0Lp94V13whH@archlinux-ax161>
 <87zgoswkym.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgoswkym.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 22, 2021 at 12:30:57PM -0600, Eric W. Biederman wrote:
> Nathan Chancellor <nathan@kernel.org> writes:
> 
> > Hi Eric,
> >
> > On Wed, Dec 08, 2021 at 02:25:31PM -0600, Eric W. Biederman wrote:
> >> Today the rules are a bit iffy and arbitrary about which kernel
> >> threads have struct kthread present.  Both idle threads and thread
> >> started with create_kthread want struct kthread present so that is
> >> effectively all kernel threads.  Make the rule that if PF_KTHREAD
> >> and the task is running then struct kthread is present.
> >> 
> >> This will allow the kernel thread code to using tsk->exit_code
> >> with different semantics from ordinary processes.
> >> 
> >> To make ensure that struct kthread is present for all
> >> kernel threads move it's allocation into copy_process.
> >> 
> >> Add a deallocation of struct kthread in exec for processes
> >> that were kernel threads.
> >> 
> >> Move the allocation of struct kthread for the initial thread
> >> earlier so that it is not repeated for each additional idle
> >> thread.
> >> 
> >> Move the initialization of struct kthread into set_kthread_struct
> >> so that the structure is always and reliably initailized.
> >> 
> >> Clear set_child_tid in free_kthread_struct to ensure the kthread
> >> struct is reliably freed during exec.  The function
> >> free_kthread_struct does not need to clear vfork_done during exec as
> >> exec_mm_release called from exec_mmap has already cleared vfork_done.
> >> 
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > This patch as commit 40966e316f86 ("kthread: Ensure struct kthread is
> > present for all kthreads") in -next causes an ARCH=arm
> > multi_v5_defconfig kernel to fail to boot in QEMU. I had to apply commit
> > 6692c98c7df5 ("fork: Stop protecting back_fork_cleanup_cgroup_lock with
> > CONFIG_NUMA") to get it to build and I applied commit dd621ee0cf8e
> > ("kthread: Warn about failed allocations for the init kthread") to avoid
> > the known runtime warning.
> >
> > $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- distclean multi_v5_defconfig all
> >
> > $ qemu-system-arm \
> >     -initrd rootfs.cpio \
> >     -append earlycon \
> >     -machine palmetto-bmc \
> >     -no-reboot \
> >     -dtb arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dtb \
> >     -display none \
> >     -kernel arch/arm/boot/zImage \
> >     -m 512m \
> >     -nodefaults \
> >     -serial mon:stdio
> > qemu-system-arm: warning: nic ftgmac100.0 has no peer
> > qemu-system-arm: warning: nic ftgmac100.1 has no peer
> > Booting Linux on physical CPU 0x0
> > Linux version 5.16.0-rc1-00016-g40966e316f86-dirty (nathan@archlinux-ax161) (arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 PREEMPT Wed Dec 22 18:08:53 UTC 2021
> > CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
> > CPU: VIVT data cache, VIVT instruction cache
> > OF: fdt: Machine model: Palmetto BMC
> > earlycon: ns16550a0 at MMIO 0x1e784000 (options '')
> > printk: bootconsole [ns16550a0] enabled
> > Memory policy: Data cache writethrough
> > cma: Reserved 16 MiB at 0x5b000000
> > Zone ranges:
> >   DMA      [mem 0x0000000040000000-0x000000005edfffff]
> >   Normal   empty
> >   HighMem  [mem 0x000000005ee00000-0x000000005fffffff]
> > Movable zone start for each node
> > Early memory node ranges
> >   node   0: [mem 0x0000000040000000-0x000000005bffffff]
> >   node   0: [mem 0x000000005c000000-0x000000005dffffff]
> >   node   0: [mem 0x000000005e000000-0x000000005edfffff]
> >   node   0: [mem 0x000000005ee00000-0x000000005fffffff]
> > Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
> > Built 1 zonelists, mobility grouping on.  Total pages: 130084
> > Kernel command line: earlycon
> > Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
> > Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
> > mem auto-init: stack:off, heap alloc:off, heap free:off
> > Memory: 433140K/524288K available (9628K kernel code, 2019K rwdata, 2368K rodata, 340K init, 661K bss, 74764K reserved, 16384K cma-reserved, 0K highmem)
> > SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > rcu: Preemptible hierarchical RCU implementation.
> > rcu:    RCU event tracing is enabled.
> >         Trampoline variant of Tasks RCU enabled.
> > rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
> > NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> > i2c controller registered, irq 16
> > random: get_random_bytes called from start_kernel+0x408/0x624 with crng_init=0
> > clocksource: FTTMR010-TIMER2: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> > sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
> > Switching to timer-based delay loop, resolution 41ns
> > Console: colour dummy device 80x30
> > printk: console [tty0] enabled
> > printk: bootconsole [ns16550a0] disabled
> >
> > After that, it just hangs.
> >
> > The rootfs is available at https://github.com/ClangBuiltLinux/boot-utils
> > in the images/arm folder.
> >
> > If there is any more information that I can provide or changes to test,
> > please let me know.
> 
> Well crap.  I hate to hear my code is causing problems like this.
> 
> This is however a very good bug report, which I very much appreciate.
> 
> I think I have enough information.  I will see if I can reproduce this
> and track down what is happening.
> 
> Have you by any chance tried linux-next with just these changes backed
> out? 

Yes, if I back out of the following commits on top of next-20211222 then
the kernel boots right up.

dd621ee0cf8e ("kthread: Warn about failed allocations for the init kthread")
ff8288ff475e ("fork: Rename bad_fork_cleanup_threadgroup_lock to bad_fork_cleanup_delayacct")
6692c98c7df5 ("fork: Stop protecting back_fork_cleanup_cgroup_lock with CONFIG_NUMA")
1fb466dff904 ("objtool: Add a missing comma to avoid string concatenation")
5eb6f22823e0 ("exit/kthread: Fix the kerneldoc comment for kthread_complete_and_exit")
6b1248798eb6 ("exit/kthread: Move the exit code for kernel threads into struct kthread")
40966e316f86 ("kthread: Ensure struct kthread is present for all kthreads")

Cheers,
Nathan

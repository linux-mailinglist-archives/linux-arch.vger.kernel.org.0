Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9E47DAD3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 00:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbhLVXZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 18:25:21 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:51662 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344161AbhLVXZV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 18:25:21 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:60530)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0Az1-00DkcB-QM; Wed, 22 Dec 2021 16:25:19 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:60728 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0Ayy-005jrX-PH; Wed, 22 Dec 2021 16:25:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Nathan Chancellor <nathan@kernel.org>
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
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-9-ebiederm@xmission.com>
        <YcNsG0Lp94V13whH@archlinux-ax161>
        <87zgoswkym.fsf@email.froward.int.ebiederm.org>
        <YcNyjxac3wlKPywk@archlinux-ax161>
Date:   Wed, 22 Dec 2021 17:22:45 -0600
In-Reply-To: <YcNyjxac3wlKPywk@archlinux-ax161> (Nathan Chancellor's message
        of "Wed, 22 Dec 2021 11:46:39 -0700")
Message-ID: <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n0Ayy-005jrX-PH;;;mid=<87pmpow7ga.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+eVyc/Ebr7xf36I02tNJgugmEpyw6siY=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Nathan Chancellor <nathan@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1891 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 9 (0.5%), parse: 0.97 (0.1%),
         extract_message_metadata: 14 (0.7%), get_uri_detail_list: 4.2 (0.2%),
        tests_pri_-1000: 14 (0.7%), tests_pri_-950: 1.20 (0.1%),
        tests_pri_-900: 1.02 (0.1%), tests_pri_-90: 291 (15.4%), check_bayes:
        289 (15.3%), b_tokenize: 15 (0.8%), b_tok_get_all: 15 (0.8%),
        b_comp_prob: 4.4 (0.2%), b_tok_touch_all: 251 (13.3%), b_finish: 0.81
        (0.0%), tests_pri_0: 1546 (81.8%), check_dkim_signature: 0.56 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 1.18 (0.1%), tests_pri_10:
        2.2 (0.1%), tests_pri_500: 7 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all kthreads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nathan Chancellor <nathan@kernel.org> writes:

> On Wed, Dec 22, 2021 at 12:30:57PM -0600, Eric W. Biederman wrote:
>> Nathan Chancellor <nathan@kernel.org> writes:
>> 
>> > Hi Eric,
>> >
>> > On Wed, Dec 08, 2021 at 02:25:31PM -0600, Eric W. Biederman wrote:
>> >> Today the rules are a bit iffy and arbitrary about which kernel
>> >> threads have struct kthread present.  Both idle threads and thread
>> >> started with create_kthread want struct kthread present so that is
>> >> effectively all kernel threads.  Make the rule that if PF_KTHREAD
>> >> and the task is running then struct kthread is present.
>> >> 
>> >> This will allow the kernel thread code to using tsk->exit_code
>> >> with different semantics from ordinary processes.
>> >> 
>> >> To make ensure that struct kthread is present for all
>> >> kernel threads move it's allocation into copy_process.
>> >> 
>> >> Add a deallocation of struct kthread in exec for processes
>> >> that were kernel threads.
>> >> 
>> >> Move the allocation of struct kthread for the initial thread
>> >> earlier so that it is not repeated for each additional idle
>> >> thread.
>> >> 
>> >> Move the initialization of struct kthread into set_kthread_struct
>> >> so that the structure is always and reliably initailized.
>> >> 
>> >> Clear set_child_tid in free_kthread_struct to ensure the kthread
>> >> struct is reliably freed during exec.  The function
>> >> free_kthread_struct does not need to clear vfork_done during exec as
>> >> exec_mm_release called from exec_mmap has already cleared vfork_done.
>> >> 
>> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >
>> > This patch as commit 40966e316f86 ("kthread: Ensure struct kthread is
>> > present for all kthreads") in -next causes an ARCH=arm
>> > multi_v5_defconfig kernel to fail to boot in QEMU. I had to apply commit
>> > 6692c98c7df5 ("fork: Stop protecting back_fork_cleanup_cgroup_lock with
>> > CONFIG_NUMA") to get it to build and I applied commit dd621ee0cf8e
>> > ("kthread: Warn about failed allocations for the init kthread") to avoid
>> > the known runtime warning.
>> >
>> > $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- distclean multi_v5_defconfig all
>> >
>> > $ qemu-system-arm \
>> >     -initrd rootfs.cpio \
>> >     -append earlycon \
>> >     -machine palmetto-bmc \
>> >     -no-reboot \
>> >     -dtb arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dtb \
>> >     -display none \
>> >     -kernel arch/arm/boot/zImage \
>> >     -m 512m \
>> >     -nodefaults \
>> >     -serial mon:stdio
>> > qemu-system-arm: warning: nic ftgmac100.0 has no peer
>> > qemu-system-arm: warning: nic ftgmac100.1 has no peer
>> > Booting Linux on physical CPU 0x0
>> > Linux version 5.16.0-rc1-00016-g40966e316f86-dirty (nathan@archlinux-ax161) (arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 PREEMPT Wed Dec 22 18:08:53 UTC 2021
>> > CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
>> > CPU: VIVT data cache, VIVT instruction cache
>> > OF: fdt: Machine model: Palmetto BMC
>> > earlycon: ns16550a0 at MMIO 0x1e784000 (options '')
>> > printk: bootconsole [ns16550a0] enabled
>> > Memory policy: Data cache writethrough
>> > cma: Reserved 16 MiB at 0x5b000000
>> > Zone ranges:
>> >   DMA      [mem 0x0000000040000000-0x000000005edfffff]
>> >   Normal   empty
>> >   HighMem  [mem 0x000000005ee00000-0x000000005fffffff]
>> > Movable zone start for each node
>> > Early memory node ranges
>> >   node   0: [mem 0x0000000040000000-0x000000005bffffff]
>> >   node   0: [mem 0x000000005c000000-0x000000005dffffff]
>> >   node   0: [mem 0x000000005e000000-0x000000005edfffff]
>> >   node   0: [mem 0x000000005ee00000-0x000000005fffffff]
>> > Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
>> > Built 1 zonelists, mobility grouping on.  Total pages: 130084
>> > Kernel command line: earlycon
>> > Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> > Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
>> > mem auto-init: stack:off, heap alloc:off, heap free:off
>> > Memory: 433140K/524288K available (9628K kernel code, 2019K rwdata, 2368K rodata, 340K init, 661K bss, 74764K reserved, 16384K cma-reserved, 0K highmem)
>> > SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> > rcu: Preemptible hierarchical RCU implementation.
>> > rcu:    RCU event tracing is enabled.
>> >         Trampoline variant of Tasks RCU enabled.
>> > rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
>> > NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
>> > i2c controller registered, irq 16
>> > random: get_random_bytes called from start_kernel+0x408/0x624 with crng_init=0
>> > clocksource: FTTMR010-TIMER2: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
>> > sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
>> > Switching to timer-based delay loop, resolution 41ns
>> > Console: colour dummy device 80x30
>> > printk: console [tty0] enabled
>> > printk: bootconsole [ns16550a0] disabled
>> >
>> > After that, it just hangs.
>> >
>> > The rootfs is available at https://github.com/ClangBuiltLinux/boot-utils
>> > in the images/arm folder.
>> >
>> > If there is any more information that I can provide or changes to test,
>> > please let me know.

I have managed to reproduce, fix and verify my fix, please
see below.


Subject: [PATCH] kthread: Never put_user the set_child_tid address

Kernel threads abuse set_child_tid.  Historically that has been fine
as set_child_tid was initialized after the kernel thread had been
forked.  Unfortunately storing struct kthread in set_child_tid after
the thread is running makes struct kthread being unusable for storing
result codes of the thread.

When set_child_tid is set to struct kthread during fork that results
in schedule_tail writing the thread id to the beggining of struct
kthread (if put_user does not realize it is a kernel address).

Solve this by skipping the put_user for all kthreads.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lkml.kernel.org/r/YcNsG0Lp94V13whH@archlinux-ax161
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee222b89c692..d8adbea77be1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4908,7 +4908,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	finish_task_switch(prev);
 	preempt_enable();
 
-	if (current->set_child_tid)
+	if (!(current->flags & PF_KTHREAD) && current->set_child_tid)
 		put_user(task_pid_vnr(current), current->set_child_tid);
 
 	calculate_sigpending();
-- 
2.29.2


Eric

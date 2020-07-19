Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB90C2254C6
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgGSXs6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 19:48:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22639 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726601AbgGSXs6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Jul 2020 19:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595202535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdqLooIgB6oeeU7H/Stwha7r3J4HGY3SLmOrV3wr41Y=;
        b=EKh6h61qTb+1t7zOzs7o/pSa1WQz+BQ3vk2Uwi0nAKBVvog/m1n9vDjEnfslPKUO19E+W+
        JQHVSo52b5/BH/du0BsH1CJCKYPpNgZkDXBbBUWb8QybjFzAebOOoWdugUXrHTKO5HnZ95
        YAmQZb+qaxSzilaitSH5icRslJKcYdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-FuwHifinNRWRVMrGyG5L5w-1; Sun, 19 Jul 2020 19:48:52 -0400
X-MC-Unique: FuwHifinNRWRVMrGyG5L5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B69588015FB;
        Sun, 19 Jul 2020 23:48:48 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-253.rdu2.redhat.com [10.10.112.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51C462B6E2;
        Sun, 19 Jul 2020 23:48:45 +0000 (UTC)
Subject: Re: [locking/qspinlock] 45877ea393:
 BUG:spinlock_already_unlocked_on_CPU
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, lkp@lists.01.org
References: <20200717073924.GB19262@shao2-debian>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <097239a5-1fb2-9d9b-3b6b-1b137e7175d0@redhat.com>
Date:   Sun, 19 Jul 2020 19:48:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200717073924.GB19262@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/17/20 3:39 AM, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 45877ea3934b977dd4fd9fa8b4b7e9a2a8925d38 ("[PATCH v2 4/5] locking/qspinlock: Make qspinhlock store lock holder cpu number")
> url: https://github.com/0day-ci/linux/commits/Waiman-Long/x86-locking-qspinlock-Allow-lock-to-store-lock-holder-cpu-number/20200717-033319
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git f9ad4a5f3f20bee022b1bdde94e5ece6dc0b0edc
>
> in testcase: trinity
> with following parameters:
>
> 	runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +--------------------------------------+------------+------------+
> |                                      | a104f8329b | 45877ea393 |
> +--------------------------------------+------------+------------+
> | boot_successes                       | 6          | 0          |
> | boot_failures                        | 0          | 8          |
> | BUG:spinlock_already_unlocked_on_CPU | 0          | 8          |
> +--------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> [    0.174207] BUG: spinlock already unlocked on CPU#0, swapper/0
> [    0.174208]  lock: logbuf_lock+0x0/0x40, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
> [    0.174209] CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc4-00016-g45877ea3934b9 #1
> [    0.174210] Call Trace:
> [    0.174210]  ? dump_stack+0x96/0xd0
> [    0.174211]  ? do_raw_spin_unlock+0x81/0xc0
> [    0.174211]  ? _raw_spin_unlock+0x1f/0x40
> [    0.174212]  ? vprintk_emit+0x141/0x370
> [    0.174212]  ? printk+0x58/0x6f
> [    0.174213]  ? start_kernel+0x60/0x664
> [    0.174213]  ? x86_family+0x5/0x20
> [    0.174214]  ? secondary_startup_64+0xb6/0xc0
> [    0.174215] BUG: spinlock already unlocked on CPU#0, swapper/0
> [    0.174216]  lock: logbuf_lock+0x0/0x40, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
> [    0.174217] CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc4-00016-g45877ea3934b9 #1
> [    0.174217] Call Trace:
> [    0.174218]  ? dump_stack+0x96/0xd0
> [    0.174218]  ? do_raw_spin_unlock+0x81/0xc0
> [    0.174219]  ? _raw_spin_unlock+0x1f/0x40
> [    0.174219]  ? vprintk_emit+0x141/0x370
> [    0.174220]  ? printk+0x58/0x6f
> [    0.174220]  ? start_kernel+0x60/0x664
> [    0.174221]  ? x86_family+0x5/0x20
> [    0.174222]  ? secondary_startup_64+0xb6/0xc0
> [    0.179324] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.203325] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.204873] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.303179] Memory: 2330956K/16776640K available (16390K kernel code, 3578K rwdata, 9300K rodata, 2508K init, 17536K bss, 1290512K reserved, 0K cma-reserved)
> [    0.306358] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.307555] Kernel/User page tables isolation: enabled
> [    0.308477] ftrace: allocating 49199 entries in 193 pages
> [    0.334062] ftrace: allocated 193 pages with 3 groups
> [    0.335730] Running RCU self tests
> [    0.336314] rcu: Preemptible hierarchical RCU implementation.
> [    0.337275] rcu: 	RCU lockdep checking is enabled.
> [    0.338117] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
> [    0.339252] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
> [    0.340525] 	Trampoline variant of Tasks RCU enabled.
> [    0.341420] 	Rude variant of Tasks RCU enabled.
> [    0.342120] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.343410] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
> [    0.350046] NR_IRQS: 524544, nr_irqs: 440, preallocated irqs: 16
> [    0.351568] random: get_random_bytes called from start_kernel+0x47c/0x664 with crng_init=0
> [    0.360133] Console: colour VGA+ 80x25
> [    0.488053] printk: console [tty0] enabled
> [    0.489397] printk: console [ttyS0] enabled
> [    0.491484] printk: bootconsole [earlyser0] disabled
> [    0.493957] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.496330] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.497667] ... MAX_LOCK_DEPTH:          48
> [    0.498992] ... MAX_LOCKDEP_KEYS:        8192
> [    0.500345] ... CLASSHASH_SIZE:          4096
> [    0.501709] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.502983] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.504225] ... CHAINHASH_SIZE:          32768
> [    0.505597]  memory used by lock dependency info: 6301 kB
> [    0.507170]  memory used for stack traces: 4224 kB
> [    0.508622]  per task-struct memory footprint: 1920 bytes
> [    0.510320] ACPI: Core revision 20200528
> [    0.511870] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
> [    0.514831] APIC: Switch to symmetric I/O mode setup
> [    0.516572] x2apic enabled
> [    0.517835] Switched APIC routing to physical x2apic.
> [    0.519267] masked ExtINT on CPU#0
> [    0.521620] ENABLING IO-APIC IRQs
> [    0.522862] init IO_APIC IRQs
> [    0.523904]  apic 0 pin 0 not connected
> [    0.525142] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Active:0 Dest:0)
> [    0.527588] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Active:0 Dest:0)
> [    0.530160] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Active:0 Dest:0)
> [    0.532595] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Active:0 Dest:0)
> [    0.535040] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:1 Active:0 Dest:0)
> [    0.537473] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Active:0 Dest:0)
> [    0.539907] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Active:0 Dest:0)
> [    0.542375] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Active:0 Dest:0)
> [    0.544872] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Active:0 Dest:0)
> [    0.547321] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:1 Active:0 Dest:0)
> [    0.549764] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:1 Active:0 Dest:0)
> [    0.552139] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 Active:0 Dest:0)
> [    0.554509] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 Active:0 Dest:0)
> [    0.556877] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 Active:0 Dest:0)
> [    0.559407] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 Active:0 Dest:0)
> [    0.561851]  apic 0 pin 16 not connected
> [    0.563100]  apic 0 pin 17 not connected
> [    0.564382]  apic 0 pin 18 not connected
> [    0.565667]  apic 0 pin 19 not connected
> [    0.566978]  apic 0 pin 20 not connected
> [    0.568223]  apic 0 pin 21 not connected
> [    0.569546]  apic 0 pin 22 not connected
> [    0.574439]  apic 0 pin 23 not connected
> [    0.575852] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.577696] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x26d349e8249, max_idle_ns: 440795288087 ns
> [    0.580936] Calibrating delay loop (skipped) preset value.. 5387.01 BogoMIPS (lpj=2693508)
> [    0.581945] pid_max: default: 32768 minimum: 301
> [    0.583003] LSM: Security Framework initializing
> [    0.583943] Yama: becoming mindful.
> [    0.585038] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.586506] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> Poking KASLR using RDTSC...
> [    0.589007] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
> [    0.589936] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
> [    0.590943] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.591952] Spectre V2 : Mitigation: Full generic retpoline
> [    0.592937] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.593941] Speculative Store Bypass: Vulnerable
> [    0.594944] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [    0.597034] Freeing SMP alternatives memory: 40K
> [    0.600063] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
> [    0.601429] Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
> [    0.602098] rcu: Hierarchical SRCU implementation.
> [    0.604237] NMI watchdog: Perf NMI watchdog permanently disabled
> [    0.605187] smp: Bringing up secondary CPUs ...
> [    0.606363] x86: Booting SMP configuration:
>
>
> To reproduce:
>
>          # build kernel
> 	cd linux
> 	cp config-5.8.0-rc4-00016-g45877ea3934b9 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> lkp
>
Thanks for the test. The first locking call is earlier than I expected. 
There is a simple fix for that and I will put that in the next v3 patch.

Cheers,
Longman


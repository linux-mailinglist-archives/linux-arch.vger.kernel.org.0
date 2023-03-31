Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292DC6D29E6
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjCaVWP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCaVWO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 17:22:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5520D99
        for <linux-arch@vger.kernel.org>; Fri, 31 Mar 2023 14:22:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id cu12so15656571pfb.13
        for <linux-arch@vger.kernel.org>; Fri, 31 Mar 2023 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1680297728;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMlyJUBtyrHUaSVJlBX+86J3P6CBuMm4QvPPhAAp8+4=;
        b=5y6Sig4r54zJYR4QBIoU/JnNEMSrkLx+n9W355OLxvJVVlhyMzMJucXW65nucDoNTI
         BejONBRt8FtBFAK9m57xXzAZdyNfKxipzAEdHLkDCKDEdsbAFDYV5OgT7PLck9gn6ON/
         QCA/wBZwd4n0H4uSO0sTeM8fpGFDXKo7i9lIbNcLaY7l+t/Esas3EPot1TD5RHfS+xnR
         t1KMSj3ZgWKwOHAkrbx2fzaw5cw39d3a973By0acfsoSuHQn2qi083AeG77UQYyVqX74
         smNqIXTQNcUlYstTIHYgANK/zRrJKe+GiUyH+iSeYr6TkjwQEertYJ+TSZu5ZhlC41kn
         WjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680297728;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMlyJUBtyrHUaSVJlBX+86J3P6CBuMm4QvPPhAAp8+4=;
        b=bmBjt8ac+a3qDjK1EHALk/VO5YSa5z9AXQ/ZdqqcjOoyiQvLFnjlNydmRBrnYEWwti
         Rup0z+f3J+UPgOzZQmqTQ9+6eJcJJU20bViOeyo3w5wsy/BsLY0TMcptVDoHKyhOf35L
         G1Hh66WvC8jSSw8pIBs2EeNFH7Roh2+KgLtiQXLtmrmBYIsd7/wCr0OO5sB5/7OXGz9j
         Mq39TxR/CUgNHibE0HgIqzH5NzZ35xwDOihevX+4tnHfrVNw4i/3jC+JDVGta80tUxSB
         fukOntVHHkT2oXVCZIElzk12lu3os/fsSuK092nuMBT2PE3AjFE8qDUc0XxhhNjpXJfG
         7EZA==
X-Gm-Message-State: AAQBX9dt7SJHRM+wr5RSduaCrDwzNdWcSDry5mBzU7BV6vuyiy4E8RXC
        7rMSR6l6m3CaD/ov8QcfbkN0nA==
X-Google-Smtp-Source: AKy350Z7lazxmn4ePUZhGR613DtFjeHoRaT6JEU32E8Mb4nWSLhtJ/rpvAnSQS1nq9Yp5F2g7zJYjw==
X-Received: by 2002:a62:5254:0:b0:625:febb:bc25 with SMTP id g81-20020a625254000000b00625febbbc25mr26103738pfb.11.1680297728142;
        Fri, 31 Mar 2023 14:22:08 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id k8-20020aa792c8000000b0062de3e977bcsm1875455pfa.26.2023.03.31.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:22:07 -0700 (PDT)
Date:   Fri, 31 Mar 2023 14:22:07 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Mar 2023 14:21:57 PDT (-0700)
Subject:     Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
In-Reply-To: <24493b95-d994-4a42-a825-38ce2bf47c92@spud>
CC:     heiko@sntech.de, guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        Mark Rutland <mark.rutland@arm.com>, ben@decadent.org.uk,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, Bjorn Topel <bjorn@rivosinc.com>,
        zouyipeng@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-bb13cb27-2213-43fc-9708-242f8164b827@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 31 Mar 2023 11:55:42 PDT (-0700), Conor Dooley wrote:
> On Fri, Mar 31, 2023 at 08:46:44PM +0200, Heiko Stübner wrote:
>> Hi,
>>
>> Am Freitag, 31. März 2023, 20:41:35 CEST schrieb Conor Dooley:
>> > On Fri, Mar 31, 2023 at 07:34:38PM +0100, Conor Dooley wrote:
>> > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
>> > > > From: Guo Ren <guoren@linux.alibaba.com>
>> > > >
>> > > > This patch converts riscv to use the generic entry infrastructure from
>> > > > kernel/entry/*. The generic entry makes maintainers' work easier and
>> > > > codes more elegant. Here are the changes:
>> > > >
>> > > >  - More clear entry.S with handle_exception and ret_from_exception
>> > > >  - Get rid of complex custom signal implementation
>> > > >  - Move syscall procedure from assembly to C, which is much more
>> > > >    readable.
>> > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
>> > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
>> > > >  - Use the standard preemption code instead of custom
>> > >
>> > > This has unfortunately broken booting my usual NFS rootfs on both my D1
>> > > and Icicle. It's one of the Fedora images from David, I think this one:
>> > > http://fedora.riscv.rocks/kojifiles/work/tasks/3933/1313933/
>> > >
>> > > It gets pretty far into things, it's once systemd is operational that
>> > > things go pear shaped:
>> >
>> > Shoulda said, can share the full logs if required of course, but they're
>> > quite verbose cos systemd etc.
>>
>> I was just investigating the same thing just now. So that saves me some
>> tracking down the culprit :-) .
>>
>> My main qemu is living as a "board" in my boardfarm (also doing nfsroot)
>> as well as my d1 nezha with nfsroot was affected.
>>
>> Though my board is stuck in some failure loop with both the journal- as
>> well as the timesyncd service failing again and again. And I haven't
>> figured out how to get logs without a working login console yet.
>
> I'll attach the full output from a run I guess. journald fails ad
> infinitum for me too after I cut this log off.

Thanks for looking at this.  I'm not opposed to reverting the generic 
entry stuff if it's breaking things, but it's a nice cleanup so it'd be 
great to keep it if possible.  I'm going to keep picking up other 
features for now, but if folks run out of patience trying to fix the bug 
then LMK and I'll figure out how to drop the series.

>
> Cheers,
> Conor.
>
> [    0.000000] Linux version 6.3.0-rc2-gd5e0396cf8bf-dirty (conor@spud) (ClangBuiltLinux clang version 15.0.7 (/stuff/brsdk/llvm/clang 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) #1 SMP PREEMPT @7
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020000000 (options '115200n8')
> [    0.000000] printk: bootconsole [ns16550a0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node 'region@BFC00000': base 0x00000000bfc00000, size 4 MiB
> [    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (4096 KiB) nomap non-reusable region@BFC00000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges
> [    0.000000] SBI specification v0.3 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10000
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] SBI HSM extension detected
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] riscv: base ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 29 pages/cpu s79648 r8192 d30944 u118784
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258055
> [    0.000000] Kernel command line: root=/dev/nfs rw ip=dhcp nfsroot=99.99.99.5:/stuff/nfs_share,tcp,v3 rdinit=/usr/sbin/init rootwait=10 earlycon
> [    0.000000] Unknown kernel command line parameters "rootwait=10", will be passed to user space.
> [    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
> [    0.000000] stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (2048 kB)
> [    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  16 MB)
> [    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (4096 MB)
> [    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  64 GB)
> [    0.000000]      modules : 0xffffffff0305f000 - 0xffffffff80000000   (1999 MB)
> [    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffd83fe00000   (1022 MB)
> [    0.000000]        kasan : 0xfffffff700000000 - 0xffffffff00000000   (  32 GB)
> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
> [    0.000000] Memory: 545616K/1046528K available (16518K kernel code, 8042K rwdata, 8192K rodata, 2303K init, 12559K bss, 500912K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] trace event string verifier disabled
> [    0.000000] Running RCU self tests
> [    0.000000] Running RCU synchronous self tests
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU lockdep checking is enabled.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
> [    0.000000] rcu: 	RCU debug extended QS entry/exit.
> [    0.000000] 	Trampoline variant of Tasks RCU enabled.
> [    0.000000] 	Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] Running RCU synchronous self tests
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt-controller
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts with 4 handlers for 9 contexts.
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] riscv-timer: riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [1]
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000006] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns
> [    0.015372] Console: colour dummy device 80x25
> [    0.020991] printk: console [tty0] enabled
> [    0.026672] printk: bootconsole [ns16550a0] disabled
> [    0.000000] Linux version 6.3.0-rc2-gd5e0396cf8bf-dirty (conor@spud) (ClangBuiltLinux clang version 15.0.7 (/stuff/brsdk/llvm/clang 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) #1 SMP PREEMPT @7
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020000000 (options '115200n8')
> [    0.000000] printk: bootconsole [ns16550a0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for node 'region@BFC00000': base 0x00000000bfc00000, size 4 MiB
> [    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (4096 KiB) nomap non-reusable region@BFC00000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges
> [    0.000000] SBI specification v0.3 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10000
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] SBI HSM extension detected
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] riscv: base ISA extensions acdfim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 29 pages/cpu s79648 r8192 d30944 u118784
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258055
> [    0.000000] Kernel command line: root=/dev/nfs rw ip=dhcp nfsroot=99.99.99.5:/stuff/nfs_share,tcp,v3 rdinit=/usr/sbin/init rootwait=10 earlycon
> [    0.000000] Unknown kernel command line parameters "rootwait=10", will be passed to user space.
> [    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] stackdepot: allocating hash table via alloc_large_system_hash
> [    0.000000] stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (2048 kB)
> [    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  16 MB)
> [    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (4096 MB)
> [    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  64 GB)
> [    0.000000]      modules : 0xffffffff0305f000 - 0xffffffff80000000   (1999 MB)
> [    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffd83fe00000   (1022 MB)
> [    0.000000]        kasan : 0xfffffff700000000 - 0xffffffff00000000   (  32 GB)
> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
> [    0.000000] Memory: 545616K/1046528K available (16518K kernel code, 8042K rwdata, 8192K rodata, 2303K init, 12559K bss, 500912K reserved, 0K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] trace event string verifier disabled
> [    0.000000] Running RCU self tests
> [    0.000000] Running RCU synchronous self tests
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU lockdep checking is enabled.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
> [    0.000000] rcu: 	RCU debug extended QS entry/exit.
> [    0.000000] 	Trampoline variant of Tasks RCU enabled.
> [    0.000000] 	Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] Running RCU synchronous self tests
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt-controller
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts with 4 handlers for 9 contexts.
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] riscv-timer: riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [1]
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000006] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns
> [    0.015372] Console: colour dummy device 80x25
> [    0.020991] printk: console [tty0] enabled
> [    0.026672] printk: bootconsole [ns16550a0] disabled
> [    0.033749] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.035065] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.035844] ... MAX_LOCK_DEPTH:          48
> [    0.036633] ... MAX_LOCKDEP_KEYS:        8192
> [    0.037658] ... CLASSHASH_SIZE:          4096
> [    0.038478] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.039307] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.040135] ... CHAINHASH_SIZE:          32768
> [    0.040963]  memory used by lock dependency info: 6365 kB
> [    0.042130]  memory used for stack traces: 4224 kB
> [    0.043012]  per task-struct memory footprint: 1920 bytes
> [    0.044452] Calibrating delay loop (skipped), value calculated using timer frequency.. 2.00 BogoMIPS (lpj=4000)
> [    0.046447] pid_max: default: 32768 minimum: 301
> [    0.052917] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> [    0.054369] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
> [    0.084506] Running RCU synchronous self tests
> [    0.085686] Running RCU synchronous self tests
> [    0.095405] CPU node for /cpus/cpu@0 exist but the possible cpu range is :0-3
> [    0.130236] cblist_init_generic: Setting adjustable number of callback queues.
> [    0.133050] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    0.137669] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    0.142192] Running RCU-tasks wait API self tests
> [    0.263638] riscv: ELF compat mode unsupported
> [    0.263807] ASID allocator disabled (0 bits)
> [    0.270226] Callback from call_rcu_tasks_trace() invoked.
> [    0.272903] rcu: Hierarchical SRCU implementation.
> [    0.274289] rcu: 	Max phase no-delay instances is 1000.
> [    0.302638] EFI services will not be available.
> [    0.315637] smp: Bringing up secondary CPUs ...
> [    0.396166] smp: Brought up 1 node, 4 CPUs
> [    0.422047] devtmpfs: initialized
> [    0.490692] Callback from call_rcu_tasks() invoked.
> [    0.681118] Running RCU synchronous self tests
> [    0.682861] Running RCU synchronous self tests
> [    0.691211] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.693981] futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
> [    0.702882] pinctrl core: initialized pinctrl subsystem
> [    0.744067] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.758314] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
> [    0.761255] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.795383] cpuidle: using governor menu
> [    1.272427] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> [    1.274292] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
> [    1.411012] SCSI subsystem initialized
> [    1.431885] usbcore: registered new interface driver usbfs
> [    1.435740] usbcore: registered new interface driver hub
> [    1.439351] usbcore: registered new device driver usb
> [    1.462261] FPGA manager framework
> [    1.512290] vgaarb: loaded
> [    1.519890] clocksource: Switched to clocksource riscv_clocksource
> [    2.009122] NET: Registered PF_INET protocol family
> [    2.016053] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    2.052865] tcp_listen_portaddr_hash hash table entries: 512 (order: 3, 36864 bytes, linear)
> [    2.056616] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> [    2.059500] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
> [    2.072933] TCP bind hash table entries: 8192 (order: 8, 1179648 bytes, linear)
> [    2.113517] TCP: Hash tables configured (established 8192 bind 8192)
> [    2.120319] UDP hash table entries: 512 (order: 4, 81920 bytes, linear)
> [    2.125390] UDP-Lite hash table entries: 512 (order: 4, 81920 bytes, linear)
> [    2.136344] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    2.161084] RPC: Registered named UNIX socket transport module.
> [    2.162843] RPC: Registered udp transport module.
> [    2.164402] RPC: Registered tcp transport module.
> [    2.165631] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    2.167599] PCI: CLS 0 bytes, default 64
> [    2.190148] Unpacking initramfs...
> [    2.251957] workingset: timestamp_bits=62 max_order=18 bucket_order=0
> [    2.296023] NFS: Registering the id_resolver key type
> [    2.299423] Key type id_resolver registered
> [    2.300826] Key type id_legacy registered
> [    2.303490] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
> [    2.305408] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
> [    2.314304] 9p: Installing v9fs 9p2000 file system support
> [    2.330388] NET: Registered PF_ALG protocol family
> [    2.335558] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
> [    2.337681] io scheduler mq-deadline registered
> [    2.338886] io scheduler kyber registered
> [    2.341159] io scheduler bfq registered
> [   13.013052] String selftests succeeded
> [   13.014173] test_string_helpers: Running tests...
> [   13.386804] CCACHE: DataError @ 0x00000000.0807FFF8
> [   13.391444] CCACHE: DataFail @ 0x00000000.0807FFF0
> [   13.397053] CCACHE: 4 banks, 16 ways, sets/bank=512, bytes/block=64
> [   13.398602] CCACHE: Index of the largest way enabled: 11
> [   16.037879] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [   16.149343] 20000000.serial: ttyS0 at MMIO 0x20000000 (irq = 15, base_baud = 9375000) is a 16550A
> [   16.156089] printk: console [ttyS0] enabled
> [   17.265279] 20100000.serial: ttyS1 at MMIO 0x20100000 (irq = 16, base_baud = 9375000) is a 16550A
> [   17.327497] 20102000.serial: ttyS2 at MMIO 0x20102000 (irq = 17, base_baud = 9375000) is a 16550A
> [   17.389076] 20104000.serial: ttyS3 at MMIO 0x20104000 (irq = 18, base_baud = 9375000) is a 16550A
> [   17.426517] of_serial: probe of 20106000.serial failed with error -28
> [   17.916595] loop: module loaded
> [   17.964831] zram: Added device: zram0
> [   18.086264] microchip-corespi 20108000.spi: Registered SPI controller 0
> [   18.121095] microchip-corespi 20109000.spi: Registered SPI controller 1
> [   18.203919] spi-nor spi3.0: w25q128 (16384 Kbytes)
> [   21.169496] Freeing initrd memory: 15668K
> [   21.395452] macb 20110000.ethernet eth0: Cadence GEM rev 0x0107010c at 0x20110000 irq 23 (00:04:a3:41:d0:fd)
> [   21.412679] e1000e: Intel(R) PRO/1000 Network Driver
> [   21.419777] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [   21.460117] usbcore: registered new interface driver uas
> [   21.469638] usbcore: registered new interface driver usb-storage
> [   21.524504] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
> [   21.540183] musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned bus number 1
> [   21.610837] hub 1-0:1.0: USB hub found
> [   21.621142] hub 1-0:1.0: 1 port detected
> [   21.680372] mpfs-musb 20201000.usb: Registered MPFS MUSB driver
> [   21.702517] mousedev: PS/2 mouse device common for all mice
> [   21.724021] i2c_dev: i2c /dev entries driver
> [   21.763554] microchip-corei2c 2010a000.i2c: registered CoreI2C bus driver
> [   21.797752] microchip-corei2c 2010b000.i2c: registered CoreI2C bus driver
> [   21.852615] sdhci: Secure Digital Host Controller Interface driver
> [   21.860773] sdhci: Copyright(c) Pierre Ossman
> [   21.868727] sdhci-pltfm: SDHCI platform and OF driver helper
> [   21.895884] usbcore: registered new interface driver usbhid
> [   21.902221] usbhid: USB HID core driver
> [   21.936265] mpfs-mailbox 37020000.mailbox: Registered MPFS mailbox controller driver
> [   21.966319] riscv-pmu-sbi: SBI PMU extension is available
> [   21.973922] riscv-pmu-sbi: 15 firmware and 4 hardware counters
> [   21.981727] riscv-pmu-sbi: Perf sampling/filtering is not supported as sscof extension is not available
> [   21.996006] mmc0: SDHCI controller on 20008000.mmc [20008000.mmc] using ADMA 64-bit
> [   22.032435] NET: Registered PF_INET6 protocol family
> [   22.080829] Segment Routing with IPv6
> [   22.087604] In-situ OAM (IOAM) with IPv6
> [   22.094555] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [   22.132241] NET: Registered PF_PACKET protocol family
> [   22.143837] 9pnet: Installing 9P2000 support
> [   22.145445] mmc0: new HS200 MMC card at address 0001
> [   22.160350] Key type dns_resolver registered
> [   22.198172] mmcblk0: mmc0:0001 TB2916 14.6 GiB
> [   22.359675] mmcblk0boot0: mmc0:0001 TB2916 4.00 MiB
> [   22.472842] mmcblk0boot1: mmc0:0001 TB2916 4.00 MiB
> [   22.574290] mmcblk0rpmb: mmc0:0001 TB2916 4.00 MiB, chardev (242:0)
> [   23.619821] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [   23.910330] mpfs-sys-controller syscontroller: Registered MPFS system controller
> [   23.955403] random: crng init done
> [   23.961736] mpfs-rng mpfs-rng: Registered MPFS hwrng
> [   24.040123] macb 20110000.ethernet eth0: PHY [20110000.ethernet-ffffffff:00] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
> [   24.055924] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> [   28.254478] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [   28.266341] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   28.275892] Sending DHCP requests ., OK
> [   28.306175] IP-Config: Got DHCP answer from 99.99.99.1, my address is 99.99.99.97
> [   28.316744] IP-Config: Complete:
> [   28.321357]      device=eth0, hwaddr=00:04:a3:41:d0:fd, ipaddr=99.99.99.97, mask=255.255.255.0, gw=99.99.99.1
> [   28.334209]      host=99.99.99.97, domain=, nis-domain=(none)
> [   28.341874]      bootserver=99.99.99.1, rootserver=99.99.99.5, rootpath=
> [   28.342051]      nameserver0=99.99.99.1
> [   28.684402] VFS: Mounted root (nfs filesystem) on device 0:16.
> [   28.708272] devtmpfs: mounted
> [   28.747831] Freeing unused kernel image (initmem) memory: 2300K
> [   28.757755] Run /sbin/init as init process
> [   39.469486] systemd[1]: System time before build time, advancing clock.
> [   41.382394] systemd[1]: systemd v246.15-1.0.riscv64.fc33 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> [   41.432906] systemd[1]: Detected architecture riscv64.
>
> Welcome to [0;34mFedora 33 (Rawhide)[0m!
>
> [   41.587681] systemd[1]: Set hostname to <fedora-riscv>.
> [   50.761418] systemd-sysv-generator[95]: SysV service '/etc/rc.d/init.d/livesys' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
> [   51.527913] zram_generator::generator[97]: Creating dev-zram0.swap for /dev/zram0 (275MB)
> [   57.964444] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-udev.service:27: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   57.993549] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-udev.service:28: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   58.053419] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-trigger.service:23: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   58.081477] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-trigger.service:24: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   58.145535] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-pivot.service:30: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   58.174372] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-pivot.service:31: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   58.447602] systemd[1]: /usr/lib/systemd/system/gssproxy.service:13: PIDFile= references a path below legacy directory /var/run/, updating /var/run/gssproxy.pid → /run/gssproxy.pid; please update the unit file accordingly.
> [   59.596376] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-mount.service:22: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   59.624034] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-pre-mount.service:23: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   59.682316] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-mount.service:22: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   59.709969] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-mount.service:23: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   59.766799] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-initqueue.service:24: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   59.795713] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-initqueue.service:25: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   59.854333] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-cmdline.service:26: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   59.882177] systemd[1]: /usr/lib/dracut/modules.d/98dracut-systemd/dracut-cmdline.service:27: Standard output type syslog+console is obsolete, automatically updating to journal+console. Please update your unit file, and consider removing the setting altogether.
> [   63.677176] systemd[1]: /usr/lib/systemd/system/ip6tables.service:14: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   63.702465] systemd[1]: /usr/lib/systemd/system/ip6tables.service:15: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   63.755847] systemd[1]: /usr/lib/systemd/system/iptables.service:14: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   63.780923] systemd[1]: /usr/lib/systemd/system/iptables.service:15: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
> [   64.176567] systemd[1]: Queued start job for default target Graphical Interface.
> [   64.280125] systemd[1]: Created slice Slice /system/getty.
> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/getty[0m.
> [   64.354451] systemd[1]: Created slice Slice /system/modprobe.
> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/modprobe[0m.
> [   64.419976] systemd[1]: Created slice Slice /system/serial-getty.
> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/serial-getty[0m.
> [   64.488102] systemd[1]: Created slice Slice /system/sshd-keygen.
> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/sshd-keygen[0m.
> [   64.554661] systemd[1]: Created slice Slice /system/swap-create.
> [[0;32m  OK  [0m] Created slice [0;1;39mSlice /system/swap-create[0m.
> [   64.621316] systemd[1]: Created slice User and Session Slice.
> [[0;32m  OK  [0m] Created slice [0;1;39mUser and Session Slice[0m.
> [   64.678839] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [[0;32m  OK  [0m] Started [0;1;39mForward Password R…uests to Wall Directory Watch[0m.
> [   64.732402] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
> [   64.749679] systemd[1]: Reached target Slices.
> [[0;32m  OK  [0m] Reached target [0;1;39mSlices[0m.
> [   64.804090] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [[0;32m  OK  [0m] Listening on [0;1;39mDevice-mapper event daemon FIFOs[0m.
> [   64.868427] systemd[1]: Listening on LVM2 poll daemon socket.
> [[0;32m  OK  [0m] Listening on [0;1;39mLVM2 poll daemon socket[0m.
> [   64.998827] systemd[1]: Listening on Process Core Dump Socket.
> [[0;32m  OK  [0m] Listening on [0;1;39mProcess Core Dump Socket[0m.
> [   65.061733] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [[0;32m  OK  [0m] Listening on [0;1;39minitctl Compatibility Named Pipe[0m.
> [   65.762318] systemd[1]: Condition check resulted in Journal Audit Socket being skipped.
> [   65.803879] systemd[1]: Listening on Journal Socket (/dev/log).
> [[0;32m  OK  [0m] Listening on [0;1;39mJournal Socket (/dev/log)[0m.
> [   65.870028] systemd[1]: Listening on Journal Socket.
> [[0;32m  OK  [0m] Listening on [0;1;39mJournal Socket[0m.
> [   65.966580] systemd[1]: Listening on udev Control Socket.
> [[0;32m  OK  [0m] Listening on [0;1;39mudev Control Socket[0m.
> [   66.016638] systemd[1]: Listening on udev Kernel Socket.
> [[0;32m  OK  [0m] Listening on [0;1;39mudev Kernel Socket[0m.
> [   66.072113] systemd[1]: Listening on User Database Manager Socket.
> [[0;32m  OK  [0m] Listening on [0;1;39mUser Database Manager Socket[0m.
> [   66.265196] systemd[1]: Mounting Huge Pages File System...
>          Mounting [0;1;39mHuge Pages File System[0m...
> [   66.477098] systemd[1]: Mounting POSIX Message Queue File System...
>          Mounting [0;1;39mPOSIX Message Queue File System[0m...
> [   66.717215] systemd[1]: Mounting Kernel Debug File System...
>          Mounting [0;1;39mKernel Debug File System[0m...
> [   67.000634] systemd[1]: Mounting Kernel Trace File System...
>          Mounting [0;1;39mKernel Trace File System[0m...
> [   67.061135] systemd[1]: Condition check resulted in Kernel Module supporting RPCSEC_GSS being skipped.
> [   67.078706] systemd[1]: Condition check resulted in Create list of static device nodes for the current kernel being skipped.
> [   67.246059] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
>          Starting [0;1;39mMonitoring of LVM…meventd or progress polling[0m...
> [   67.451615] systemd[1]: Starting Load Kernel Module configfs...
>          Starting [0;1;39mLoad Kernel Module configfs[0m...
> [   67.643795] systemd[1]: Starting Load Kernel Module drm...
>          Starting [0;1;39mLoad Kernel Module drm[0m...
> [   67.889066] systemd[1]: Starting Load Kernel Module fuse...
>          Starting [0;1;39mLoad Kernel Module fuse[0m...
> [   68.223484] systemd[1]: Starting Preprocess NFS configuration convertion...
>          Starting [0;1;39mPreprocess NFS configuration convertion[0m...
> [   68.405239] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [   68.685006] systemd[1]: Starting Load Kernel Modules...
>          Starting [0;1;39mLoad Kernel Modules[0m...
> [   68.936926] systemd[1]: Starting Remount Root and Kernel File Systems...
>          Starting [0;1;39mRemount Root and Kernel File Systems[0m...
> [   69.026562] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
> [   69.217824] systemd[1]: Starting Coldplug All udev Devices...
>          Starting [0;1;39mColdplug All udev Devices[0m...
> [   69.476888] systemd[1]: Starting Setup Virtual Console...
>          Starting [0;1;39mSetup Virtual Console[0m...
> [   69.908789] systemd[1]: Mounted Huge Pages File System.
> [[0;32m  OK  [0m] Mounted [0;1;39mHuge Pages File System[0m.
> [   69.985603] systemd[1]: Mounted POSIX Message Queue File System.
> [[0;32m  OK  [0m] Mounted [0;1;39mPOSIX Message Queue File System[0m.
> [   70.097151] systemd[1]: Mounted Kernel Debug File System.
> [[0;32m  OK  [0m] Mounted [0;1;39mKernel Debug File System[0m.
> [   70.243463] systemd[1]: Mounted Kernel Trace File System.
> [[0;32m  OK  [0m] Mounted [0;1;39mKernel Trace File System[0m.
> [   70.407632] systemd[1]: modprobe@configfs.service: Succeeded.
> [   70.493564] systemd[1]: Finished Load Kernel Module configfs.
> [[0;32m  OK  [0m] Finished [0;1;39mLoad Kernel Module configfs[0m.
> [   71.599759] systemd[1]: modprobe@drm.service: Succeeded.
> [   71.667485] systemd[1]: Finished Load Kernel Module drm.
> [[0;32m  OK  [0m] Finished [0;1;39mLoad Kernel Module drm[0m.
> [   71.800153] systemd[1]: modprobe@fuse.service: Succeeded.
> [   71.890649] systemd[1]: Finished Load Kernel Module fuse.
> [[0;32m  OK  [0m] Finished [0;1;39mLoad Kernel Module fuse[0m.
> [   72.030929] systemd[1]: nfs-convert.service: Succeeded.
> [   72.143720] systemd[1]: Finished Preprocess NFS configuration convertion.
> [[0;32m  OK  [0m] Finished [0;1;39mPreprocess NFS configuration convertion[0m.
> [   72.226306] systemd[1]: systemd-modules-load.service: Main process exited, code=exited, status=1/FAILURE
> [   72.288874] systemd[1]: systemd-modules-load.service: Failed with result 'exit-code'.
> [   72.405669] systemd[1]: Failed to start Load Kernel Modules.
> [[0;1;31mFAILED[0m] Failed to start [0;1;39mLoad Kernel Modules[0m.
> See 'systemctl status systemd-modules-load.service' for details.
> [   72.490312] systemd[1]: systemd-modules-load.service: Consumed 1.437s CPU time.
> [   72.572603] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
> [   72.596232] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
> [   72.813113] systemd[1]: Starting Apply Kernel Variables...
>          Starting [0;1;39mApply Kernel Variables[0m...
> [   73.694614] systemd[1]: systemd-remount-fs.service: Main process exited, code=exited, status=1/FAILURE
> [   73.736508] systemd[1]: systemd-remount-fs.service: Failed with result 'exit-code'.
> [   73.781556] systemd[1]: Failed to start Remount Root and Kernel File Systems.
> [[0;1;31mFAILED[0m] Failed to start [0;1;39mRemount Root and Kernel File Systems[0m.
> See 'systemctl status systemd-remount-fs.service' for details.
> [   73.866320] systemd[1]: systemd-remount-fs.service: Consumed 2.933s CPU time.
> [   73.899554] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
> [   73.988234] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [   74.177164] systemd[1]: Starting Load/Save Random Seed...
>          Starting [0;1;39mLoad/Save Random Seed[0m...
> [   74.298545] systemd[1]: Condition check resulted in Create System Users being skipped.
> [   74.658647] systemd[1]: Starting Create Static Device Nodes in /dev...
>          Starting [0;1;39mCreate Static Device Nodes in /dev[0m...
> [   75.179823] systemd[1]: Finished Apply Kernel Variables.
> [[0;32m  OK  [0m] Finished [0;1;39mApply Kernel Variables[0m.

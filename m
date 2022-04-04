Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B754F201D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbiDDXQt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 19:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244287AbiDDXQo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 19:16:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24043150D
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 16:06:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kw18so3907959pjb.5
        for <linux-arch@vger.kernel.org>; Mon, 04 Apr 2022 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Vq/MRmMCjiK6fuq3dlZyXWJYgx/AIjYDXsSht985KAA=;
        b=kLMEG6mi9oFlAINWVygD3Z3mg1+nbudtJ6MPO5aiH3rBzkWZvZKiOXWuqkDykqHdT7
         gKWpksMJIJOwZj8ZZ6wz8PWt3XTA4Xn0fB6RKU4v8gCHnyOPPSEm5i86wBA2yRZklqPI
         3Hmg3aCFm2gTIchAz8nIammJIK51oSgJQZETSRhIubxsgK5SD84f2W3XRodY9cbbYvs5
         BBIWyuGpFKEjjVjHvL/0CXRkEhCcXfpiQJkesw1MC8Wl38nGpgQy8kAAOIAryAx8wo6k
         dOeHLH8sbI6MzNyM2FU3OKuZac9kxzUPY898kznpOEERAVXtxp/XKCLGx9yMS5eHkh9o
         9Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Vq/MRmMCjiK6fuq3dlZyXWJYgx/AIjYDXsSht985KAA=;
        b=gBzcRDWGYsvArFbyfdk8HkTs+BqAN9M18+/gpI7PPweAe36J2TZC6/tzBuxl3Uo6kt
         LsVogBsCOK+IBkPflWMDTQHw9KpPy0OsVm3AI6Ak9ufceajdrFYByi193pdrK+DOzPtO
         44qPQuSyqRtTd9FEYs89PSWmexZIuTBm0oHokC1Yn+25Wnis55w3ht8JQeP0QPeWyygI
         WtAFnDCeQfiL4XcoyasykZzPuiL114JD/IUzEGNIUQoTBIapkOqQqzxnyWZChlx5HFGE
         XHtIpeabmmOKvHJIwjufGiSkaqXkhKIbqwS+AfVpSMR+F7P3NITgSZqduQ1CKa2JhCNH
         Mg9A==
X-Gm-Message-State: AOAM5322V2lnmvjt6NehuyqIjVamAX/qIcMYZFmzelnK55HQF0GHvwtZ
        3J4+YdRP22be1h07wHSN+OnSQg==
X-Google-Smtp-Source: ABdhPJzztiRS166UWBU6PyfRrJHJGWpHIUchw5N3nsFX/KY9ga+Fyp8oy/7RbpoQ0nF6D7s96VwTxQ==
X-Received: by 2002:a17:903:2351:b0:156:a562:b3f8 with SMTP id c17-20020a170903235100b00156a562b3f8mr519887plh.81.1649113599891;
        Mon, 04 Apr 2022 16:06:39 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id j22-20020a637a56000000b003984be1f515sm11347601pgn.69.2022.04.04.16.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 16:06:39 -0700 (PDT)
Date:   Mon, 04 Apr 2022 16:06:39 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Apr 2022 16:06:33 PDT (-0700)
Subject:     Re: [PATCH V11 00/20] riscv: Add COMPAT mode support for rv64
In-Reply-To: <CAJF2gTRzOytFedvZM5-OwibUoYfRr50ieKjT-Asj9FfOevy2mQ@mail.gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-9d254a50-fd2e-47e7-a585-3a92a1e7b200@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 04 Apr 2022 07:28:50 PDT (-0700), guoren@kernel.org wrote:
> On Sat, Apr 2, 2022 at 10:04 PM Guo Ren <guoren@kernel.org> wrote:
>>
>> Hi Palmer,
>>
>> Sorry for the late reply, I still want COMPAT to catch up at 5.18..
>> I've pushed it into my next branch, and it would get in linux-next the
>> next day. You could have a look at that. The repo is:
>> https://github.com/c-sky/csky-linux/tree/linux-next
>>
>> We still need your sending pull request for COMPAT, thank you very much.

Sorry, but it was still failing the autobuilders on the previous 
versions and Saturday night is way, way too late for a respin of a big 
patch set.

> Seems we have already missed 5.18, I just prepared the 5.18-rc1 for
> you. It solved the arm64 compile problem and some conflicts, Hope you
> could put it into your for-next (5.19-rc1).
> https://github.com/c-sky/csky-linux/tree/riscv_compat_v12

This says v11, but that says v12.  I'm going to put the v11 that was 
sent to the lists in a branch for the autobuilders to test again, but 
LMK if there's a difference (maybe by sending the v12?).  Might take a 
bit for me to get everything bumped and tested, my machine's super flaky 
right now...

>
>>
>> On Sat, Apr 2, 2022 at 9:53 PM <guoren@kernel.org> wrote:
>> >
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
>> > s390, mips, sparc) have supported COMPAT mode. But they all have
>> > history issues and can't use standard linux unistd.h. RISC-V would
>> > be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
>> > /unistd.h.
>> >
>> > The patchset are based on v5.17-rc8, you can compare rv64-compat
>> > v.s. rv32-native in qemu with following steps:
>> >
>> >  - Prepare rv32 rootfs & fw_jump.bin by buildroot.org
>> >    $ git clone git://git.busybox.net/buildroot
>> >    $ cd buildroot
>> >    $ make qemu_riscv32_virt_defconfig O=qemu_riscv32_virt_defconfig
>> >    $ make -C qemu_riscv32_virt_defconfig
>> >    $ make qemu_riscv64_virt_defconfig O=qemu_riscv64_virt_defconfig
>> >    $ make -C qemu_riscv64_virt_defconfig
>> >    (Got fw_jump.bin & rootfs.ext2 in qemu_riscvXX_virt_defconfig/images)
>> >
>> >  - Prepare Linux rv32 & rv64 Image
>> >    $ git clone git@github.com:c-sky/csky-linux.git -b riscv_compat_v11 linux
>> >    $ cd linux
>> >    $ echo "CONFIG_STRICT_KERNEL_RWX=n" >> arch/riscv/configs/defconfig
>> >    $ echo "CONFIG_STRICT_MODULE_RWX=n" >> arch/riscv/configs/defconfig
>> >    $ make ARCH=riscv CROSS_COMPILE=riscv32-buildroot-linux-gnu- O=../build-rv32/ rv32_defconfig
>> >    $ make ARCH=riscv CROSS_COMPILE=riscv32-buildroot-linux-gnu- O=../build-rv32/ Image
>> >    $ make ARCH=riscv CROSS_COMPILE=riscv64-buildroot-linux-gnu- O=../build-rv64/ defconfig
>> >    $ make ARCH=riscv CROSS_COMPILE=riscv64-buildroot-linux-gnu- O=../build-rv64/ Image
>> >
>> >  - Prepare Qemu:
>> >    $ git clone https://gitlab.com/qemu-project/qemu.git -b master linux
>> >    $ cd qemu
>> >    $ ./configure --target-list="riscv64-softmmu riscv32-softmmu"
>> >    $ make
>> >
>> > Now let's compare rv64-compat with rv32-native memory footprint with almost the same
>> > defconfig, rootfs, opensbi in one qemu.
>> >
>> >  - Run rv64 with rv32 rootfs in compat mode:
>> >    $ ./build/qemu-system-riscv64 -cpu rv64 -M virt -m 64m -nographic -bios qemu_riscv64_virt_defconfig/images/fw_jump.bin -kernel build-rv64/Image -drive file qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -append "rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi" -netdev user,id=net0 -device virtio-net-device,netdev=net0
>> >
>> > QEMU emulator version 6.2.50 (v6.2.0-29-g196d7182c8)
>> > OpenSBI v0.9
>> > [    0.000000] Linux version 5.16.0-rc6-00017-g750f87086bdd-dirty (guoren@guoren-Z87-HD3) (riscv64-unknown-linux-gnu-gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.37) #96 SMP Tue Dec 28 21:01:55 CST 2021
>> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
>> > [    0.000000] Machine model: riscv-virtio,qemu
>> > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
>> > [    0.000000] printk: bootconsole [sbi0] enabled
>> > [    0.000000] efi: UEFI not found.
>> > [    0.000000] Zone ranges:
>> > [    0.000000]   DMA32    [mem 0x0000000080200000-0x0000000083ffffff]
>> > [    0.000000]   Normal   empty
>> > [    0.000000] Movable zone start for each node
>> > [    0.000000] Early memory node ranges
>> > [    0.000000]   node   0: [mem 0x0000000080200000-0x0000000083ffffff]
>> > [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x0000000083ffffff]
>> > [    0.000000] SBI specification v0.2 detected
>> > [    0.000000] SBI implementation ID=0x1 Version=0x9
>> > [    0.000000] SBI TIME extension detected
>> > [    0.000000] SBI IPI extension detected
>> > [    0.000000] SBI RFENCE extension detected
>> > [    0.000000] SBI v0.2 HSM extension detected
>> > [    0.000000] riscv: ISA extensions acdfhimsu
>> > [    0.000000] riscv: ELF capabilities acdfim
>> > [    0.000000] percpu: Embedded 17 pages/cpu s30696 r8192 d30744 u69632
>> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 15655
>> > [    0.000000] Kernel command line: rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi
>> > [    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> > [    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
>> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
>> > [    0.000000] Virtual kernel memory layout:
>> > [    0.000000]       fixmap : 0xffffffcefee00000 - 0xffffffceff000000   (2048 kB)
>> > [    0.000000]       pci io : 0xffffffceff000000 - 0xffffffcf00000000   (  16 MB)
>> > [    0.000000]      vmemmap : 0xffffffcf00000000 - 0xffffffcfffffffff   (4095 MB)
>> > [    0.000000]      vmalloc : 0xffffffd000000000 - 0xffffffdfffffffff   (65535 MB)
>> > [    0.000000]       lowmem : 0xffffffe000000000 - 0xffffffe003e00000   (  62 MB)
>> > [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
>> > [    0.000000] Memory: 52788K/63488K available (6184K kernel code, 888K rwdata, 1917K rodata, 294K init, 297K bss, 10700K reserved, 0K cma-reserved)
>> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> > [    0.000000] rcu: Hierarchical RCU implementation.
>> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
>> > [    0.000000] rcu:     RCU debug extended QS entry/exit.
>> > [    0.000000]  Tracing variant of Tasks RCU enabled.
>> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
>> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> > [    0.000000] riscv-intc: 64 local interrupts mapped
>> > [    0.000000] plic: plic@c000000: mapped 53 interrupts with 1 handlers for 2 contexts.
>> > ...
>> > Welcome to Buildroot
>> > buildroot login: root
>> > # cat /proc/cpuinfo
>> > processor       : 0
>> > hart            : 0
>> > isa             : rv64imafdcsuh
>> > mmu             : sv48
>> >
>> > # file /bin/busybox
>> > /bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, for GNU/Linux 5.15.0, stripped
>> > # ca[   78.386630] random: fast init done
>> > # cat /proc/meminfo
>> > MemTotal:          53076 kB
>> > MemFree:           40264 kB
>> > MemAvailable:      40244 kB
>> > Buffers:             236 kB
>> > Cached:             1560 kB
>> > SwapCached:            0 kB
>> > Active:             1700 kB
>> > Inactive:            516 kB
>> > Active(anon):         40 kB
>> > Inactive(anon):      424 kB
>> > Active(file):       1660 kB
>> > Inactive(file):       92 kB
>> > Unevictable:           0 kB
>> > Mlocked:               0 kB
>> > SwapTotal:             0 kB
>> > SwapFree:              0 kB
>> > Dirty:                 0 kB
>> > Writeback:             0 kB
>> > AnonPages:           444 kB
>> > Mapped:             1188 kB
>> > Shmem:                44 kB
>> > KReclaimable:        952 kB
>> > Slab:               5744 kB
>> > SReclaimable:        952 kB
>> > SUnreclaim:         4792 kB
>> > KernelStack:         624 kB
>> > PageTables:          156 kB
>> > NFS_Unstable:          0 kB
>> > Bounce:                0 kB
>> > WritebackTmp:          0 kB
>> > CommitLimit:       26536 kB
>> > Committed_AS:       1748 kB
>> > VmallocTotal:   67108863 kB
>> > VmallocUsed:         652 kB
>> > VmallocChunk:          0 kB
>> > Percpu:               80 kB
>> > #
>> >
>> >  - Run rv32 with rv32 rootfs:
>> >    $ ./build/qemu-system-riscv32 -cpu rv32 -M virt -m 64m -nographic -bios qemu_riscv32_virt_defconfig/images/fw_jump.bin -kernel build-rv32/Image -drive file qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -append "rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi" -netdev user,id=net0 -device virtio-net-device,netdev=net0
>> >
>> > QEMU emulator version 6.2.50 (v6.2.0-29-g196d7182c8)
>> > OpenSBI v0.9
>> > [    0.000000] Linux version 5.16.0-rc6-00017-g750f87086bdd-dirty (guoren@guoren-Z87-HD3) (riscv32-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-201-g7600ca7960-dirty) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #7 SMP Tue Dec 28 21:02:21 CST 2021
>> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80400000
>> > [    0.000000] Machine model: riscv-virtio,qemu
>> > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
>> > [    0.000000] printk: bootconsole [sbi0] enabled
>> > [    0.000000] efi: UEFI not found.
>> > [    0.000000] Zone ranges:
>> > [    0.000000]   Normal   [mem 0x0000000080400000-0x0000000083ffffff]
>> > [    0.000000] Movable zone start for each node
>> > [    0.000000] Early memory node ranges
>> > [    0.000000]   node   0: [mem 0x0000000080400000-0x0000000083ffffff]
>> > [    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x0000000083ffffff]
>> > [    0.000000] SBI specification v0.2 detected
>> > [    0.000000] SBI implementation ID=0x1 Version=0x9
>> > [    0.000000] SBI TIME extension detected
>> > [    0.000000] SBI IPI extension detected
>> > [    0.000000] SBI RFENCE extension detected
>> > [    0.000000] SBI v0.2 HSM extension detected
>> > [    0.000000] riscv: ISA extensions acdfhimsu
>> > [    0.000000] riscv: ELF capabilities acdfim
>> > [    0.000000] percpu: Embedded 12 pages/cpu s16600 r8192 d24360 u49152
>> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 15240
>> > [    0.000000] Kernel command line: rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi
>> > [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
>> > [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
>> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
>> > [    0.000000] Virtual kernel memory layout:
>> > [    0.000000]       fixmap : 0x9dc00000 - 0x9e000000   (4096 kB)
>> > [    0.000000]       pci io : 0x9e000000 - 0x9f000000   (  16 MB)
>> > [    0.000000]      vmemmap : 0x9f000000 - 0x9fffffff   (  15 MB)
>> > [    0.000000]      vmalloc : 0xa0000000 - 0xbfffffff   ( 511 MB)
>> > [    0.000000]       lowmem : 0xc0000000 - 0xc3c00000   (  60 MB)
>> > [    0.000000] Memory: 51924K/61440K available (6117K kernel code, 695K rwdata, 1594K rodata, 255K init, 241K bss, 9516K reserved, 0K cma-reserved)
>> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> > [    0.000000] rcu: Hierarchical RCU implementation.
>> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
>> > [    0.000000] rcu:     RCU debug extended QS entry/exit.
>> > [    0.000000]  Tracing variant of Tasks RCU enabled.
>> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
>> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> > [    0.000000] riscv-intc: 32 local interrupts mapped
>> > [    0.000000] plic: plic@c000000: mapped 53 interrupts with 1 handlers for 2 contexts.
>> > ...
>> > Welcome to Buildroot
>> > buildroot login: root
>> > # cat /proc/cpuinfo
>> > processor       : 0
>> > hart            : 0
>> > isa             : rv32imafdcsuh
>> > mmu             : sv32
>> >
>> > # file /bin/busybox
>> > /bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, for GNU/Linux 5.15.0, stripped
>> > [   79.320589] random: fast init done
>> > # cat /proc/meminfo
>> > MemTotal:          52176 kB
>> > MemFree:           41012 kB
>> > MemAvailable:      42176 kB
>> > Buffers:             644 kB
>> > Cached:             2724 kB
>> > SwapCached:            0 kB
>> > Active:             3128 kB
>> > Inactive:            752 kB
>> > Active(anon):         40 kB
>> > Inactive(anon):      516 kB
>> > Active(file):       3088 kB
>> > Inactive(file):      236 kB
>> > Unevictable:           0 kB
>> > Mlocked:               0 kB
>> > SwapTotal:             0 kB
>> > SwapFree:              0 kB
>> > Dirty:                 4 kB
>> > Writeback:             0 kB
>> > AnonPages:           556 kB
>> > Mapped:             2172 kB
>> > Shmem:                44 kB
>> > KReclaimable:        656 kB
>> > Slab:               3684 kB
>> > SReclaimable:        656 kB
>> > SUnreclaim:         3028 kB
>> > KernelStack:         312 kB
>> > PageTables:           88 kB
>> > NFS_Unstable:          0 kB
>> > Bounce:                0 kB
>> > WritebackTmp:          0 kB
>> > CommitLimit:       26088 kB
>> > Committed_AS:       2088 kB
>> > VmallocTotal:     524287 kB
>> > VmallocUsed:          12 kB
>> > VmallocChunk:          0 kB
>> > Percpu:               60 kB
>> > #
>> >
>> >  Some conclusions:
>> >  - kernel statics:
>> >    64: Memory: 52788K/63488K available (6184K kernel code, 888K rwdata, 1917K rodata, 294K init, 297K bss, 10700K reserved)
>> >    32: Memory: 51924K/61440K available (6117K kernel code, 695K rwdata, 1594K rodata, 255K init, 241K bss,  9516K reserved)
>> >    rv32 better than rv64:                  1%               22%           17%          13%        19%         11%
>> >    The code size is very similar, but data size rv32 would be better.
>> >
>> >  - rv32 kernel runtime KernelStack, Slab... are smaller,
>> >    rv64: MemTotal: 53076 kB,        MemFree: 40264 kB
>> >    rv32: MemTotal: 52176 + 2048 kB, MemFree: 41012  + 2048 kB
>> >    rv32 better than rv64:       2%                         6%
>> >
>> >    (Because opensbi problem, we could add another 2MB for rv32.)
>> >    Overall in 64MB memory situation, rv64-compat is 6% worse than rv32-native
>> >    at memory footprint. If the userspace memory usage increases, I think
>> >    the gap will be further reduced.
>> >
>> > Changes in v11:
>> >  - Using arch instead of kconfig for commit subject by Masahiro Yamada
>> >
>> > Changes in v10:
>> >  - Fixup arm64 compile error with compat_statfs definition
>> >  - Fixup compat_sys_fadvise64_64 function arguments error cause ltp failure
>> >
>> > Changes in v9:
>> >  - Fixup rv32 call rv64 segment fault
>> >  - Ready for 5.18
>> >
>> > Changes in v8:
>> >  - Enhanced elf_check_arch with EI_CLASS
>> >  - Fixup SR_UXL doesn't exist in CONFIG_32BIT
>> >  - Add Tested-by with Heiko
>> >  - Update qemu compile tips with upstream repo
>> >
>> > Changes in v7:
>> >  - Re-construct compat_vdso/Makefile
>> >  - Fixup disable COMPAT compile error by csr.h's macro.
>> >  - Optimize coding convention for lo/hi in compat.h
>> >
>> > Changes in v6:
>> >  - Rebase on linux-5.17-rc5
>> >  - Optimize hw capability check for elf
>> >  - Optimize comment in thread_info.h
>> >  - Optimize start_thread with SR_UXL setting
>> >  - Optimize vdso.c with direct panic
>> >
>> > Changes in v5:
>> >  - Rebase on linux-5.17-rc2
>> >  - Include consolidate the fcntl patches by Christoph Hellwig
>> >  - Remove F_GETLK64/F_SETLK64/F_SETLKW64 from asm/compat.h
>> >  - Change COMPAT_RLIM_INFINITY from 0x7fffffff to 0xffffffff
>> >  - Bring back "Add hw-cap detect in setup_arch patch" in v1
>> >
>> > Changes in v4:
>> >  - Rebase on linux-5.17-rc1
>> >  - Optimize compat_sys_call_table implementation with Arnd's advice
>> >  - Add reviewed-by for Arnd. Thx :)
>> >  - Remove FIXME comment in elf.h
>> >  - Optimize Cleanup duplicate definitions in compat.h with Arnd's advice
>> >
>> > Changes in v3:
>> >  - Rebase on newest master (pre linux-5.17-rc1)
>> >  - Using newest qemu version v7 for test
>> >  - Remove fcntl common modification
>> >  - Fixup SET_PERSONALITY in elf.h by Arnd
>> >  - Fixup KVM Kconfig
>> >  - Update Acked-by & Reviewed-by
>> >
>> > Changes in v2:
>> >  - Add __ARCH_WANT_COMPAT_STAT suggested
>> >  - Cleanup fcntl compatduplicate definitions
>> >  - Cleanup compat.h
>> >  - Move rv32_defconfig into Makefile
>> >  - Fixup rv64 rootfs boot failed, remove hw_compat_mode_detect
>> >  - Move SYSVIPC_COMPAT into init/Kconfig
>> >  - Simplify compat_elf_check
>> >
>> > Christoph Hellwig (3):
>> >   uapi: simplify __ARCH_FLOCK{,64}_PAD a little
>> >   uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
>> >   compat: consolidate the compat_flock{,64} definition
>> >
>> > Guo Ren (17):
>> >   arch: Add SYSVIPC_COMPAT for all architectures
>> >   fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
>> >   asm-generic: compat: Cleanup duplicate definitions
>> >   syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
>> >   riscv: Fixup difference with defconfig
>> >   riscv: compat: Add basic compat data type implementation
>> >   riscv: compat: Support TASK_SIZE for compat mode
>> >   riscv: compat: syscall: Add compat_sys_call_table implementation
>> >   riscv: compat: syscall: Add entry.S implementation
>> >   riscv: compat: process: Add UXL_32 support in start_thread
>> >   riscv: compat: Add elf.h implementation
>> >   riscv: compat: Add hw capability check for elf
>> >   riscv: compat: vdso: Add COMPAT_VDSO base code implementation
>> >   riscv: compat: vdso: Add setup additional pages implementation
>> >   riscv: compat: signal: Add rt_frame implementation
>> >   riscv: compat: ptrace: Add compat_arch_ptrace implement
>> >   riscv: compat: Add COMPAT Kbuild skeletal support
>> >
>> >  arch/arm64/Kconfig                            |   4 -
>> >  arch/arm64/include/asm/compat.h               |  93 +------
>> >  arch/arm64/include/asm/unistd.h               |   1 +
>> >  arch/mips/Kconfig                             |   5 -
>> >  arch/mips/include/asm/compat.h                |  41 +--
>> >  arch/mips/include/asm/unistd.h                |   2 +
>> >  arch/mips/include/uapi/asm/fcntl.h            |  30 +--
>> >  arch/parisc/Kconfig                           |   4 -
>> >  arch/parisc/include/asm/compat.h              |  45 +---
>> >  arch/parisc/include/asm/unistd.h              |   1 +
>> >  arch/powerpc/Kconfig                          |   5 -
>> >  arch/powerpc/include/asm/compat.h             |  50 +---
>> >  arch/powerpc/include/asm/unistd.h             |   1 +
>> >  arch/riscv/Kconfig                            |  19 ++
>> >  arch/riscv/Makefile                           |   9 +
>> >  arch/riscv/configs/rv32_defconfig             | 135 ----------
>> >  arch/riscv/include/asm/compat.h               | 129 ++++++++++
>> >  arch/riscv/include/asm/csr.h                  |   7 +
>> >  arch/riscv/include/asm/elf.h                  |  50 +++-
>> >  arch/riscv/include/asm/mmu.h                  |   1 +
>> >  arch/riscv/include/asm/pgtable.h              |  13 +-
>> >  arch/riscv/include/asm/processor.h            |   6 +-
>> >  arch/riscv/include/asm/syscall.h              |   1 +
>> >  arch/riscv/include/asm/thread_info.h          |   1 +
>> >  arch/riscv/include/asm/unistd.h               |  11 +
>> >  arch/riscv/include/asm/vdso.h                 |   9 +
>> >  arch/riscv/include/uapi/asm/unistd.h          |   2 +-
>> >  arch/riscv/kernel/Makefile                    |   3 +
>> >  arch/riscv/kernel/compat_signal.c             | 243 ++++++++++++++++++
>> >  arch/riscv/kernel/compat_syscall_table.c      |  19 ++
>> >  arch/riscv/kernel/compat_vdso/.gitignore      |   2 +
>> >  arch/riscv/kernel/compat_vdso/Makefile        |  78 ++++++
>> >  arch/riscv/kernel/compat_vdso/compat_vdso.S   |   8 +
>> >  .../kernel/compat_vdso/compat_vdso.lds.S      |   3 +
>> >  arch/riscv/kernel/compat_vdso/flush_icache.S  |   3 +
>> >  .../compat_vdso/gen_compat_vdso_offsets.sh    |   5 +
>> >  arch/riscv/kernel/compat_vdso/getcpu.S        |   3 +
>> >  arch/riscv/kernel/compat_vdso/note.S          |   3 +
>> >  arch/riscv/kernel/compat_vdso/rt_sigreturn.S  |   3 +
>> >  arch/riscv/kernel/entry.S                     |  18 +-
>> >  arch/riscv/kernel/process.c                   |  37 +++
>> >  arch/riscv/kernel/ptrace.c                    |  87 ++++++-
>> >  arch/riscv/kernel/signal.c                    |  13 +-
>> >  arch/riscv/kernel/sys_riscv.c                 |   6 +-
>> >  arch/riscv/kernel/vdso.c                      | 105 +++++---
>> >  arch/riscv/kernel/vdso/vdso.S                 |   6 +-
>> >  arch/s390/Kconfig                             |   3 -
>> >  arch/s390/include/asm/compat.h                |  99 +------
>> >  arch/s390/include/asm/unistd.h                |   1 +
>> >  arch/sparc/Kconfig                            |   5 -
>> >  arch/sparc/include/asm/compat.h               |  61 ++---
>> >  arch/sparc/include/asm/unistd.h               |   1 +
>> >  arch/x86/Kconfig                              |   4 -
>> >  arch/x86/include/asm/compat.h                 | 104 ++------
>> >  arch/x86/include/asm/unistd.h                 |   1 +
>> >  fs/open.c                                     |  24 ++
>> >  fs/read_write.c                               |  16 ++
>> >  fs/stat.c                                     |   2 +-
>> >  fs/sync.c                                     |   9 +
>> >  include/asm-generic/compat.h                  | 113 ++++++++
>> >  include/linux/compat.h                        |  68 +++++
>> >  include/uapi/asm-generic/fcntl.h              |  23 +-
>> >  include/uapi/asm-generic/unistd.h             |   4 +-
>> >  init/Kconfig                                  |   4 +
>> >  mm/fadvise.c                                  |  11 +
>> >  mm/readahead.c                                |   7 +
>> >  tools/include/uapi/asm-generic/fcntl.h        |  21 +-
>> >  tools/include/uapi/asm-generic/unistd.h       |   4 +-
>> >  68 files changed, 1207 insertions(+), 698 deletions(-)
>> >  delete mode 100644 arch/riscv/configs/rv32_defconfig
>> >  create mode 100644 arch/riscv/include/asm/compat.h
>> >  create mode 100644 arch/riscv/kernel/compat_signal.c
>> >  create mode 100644 arch/riscv/kernel/compat_syscall_table.c
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/Makefile
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
>> >  create mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/note.S
>> >  create mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S
>> >
>> > --
>> > 2.25.1
>> >
>>
>>
>> --
>> Best Regards
>>  Guo Ren
>>
>> ML: https://lore.kernel.org/linux-csky/
>
>
>
> -- 
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FD52F282
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352613AbiETSTX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352663AbiETSTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 14:19:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAD8A7E27;
        Fri, 20 May 2022 11:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10221B82D92;
        Fri, 20 May 2022 18:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01ECC34119;
        Fri, 20 May 2022 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653070738;
        bh=dLpj7qKkKib+aI9CC01MUR5D/MbLKwYxjZ2Or3/u66w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kzNqqr8pp8bHR0I2mQVS/6H224ZnHvTx6hnUE4bnAlyFwem9P4NeAdJTKycGMo5uu
         Xmc3cnb1flrmdz8LYjY/9nCNOGmYcsWgP3lN0rWY6nGpY1+4PKZAjbGv3IBiw17TnW
         ngx6wK9zegEFnakupcp3PQEmvmlz0bczq7dYAuRKJfj5FKd1uGos+zRGiF/WYxOie6
         oHmY/rMP1H1b3JUqQVCoUl3AIPx8EtJw1zbA6gambZPY9Fzr2bxJltx7IiVQp+pGnl
         7X8+KvZKYqGdfUUiHpr/N8zThqV9V5005k4oYOWCA6Kv1v7JibgrscSWe+1Z4Kz52Z
         2gy80+YxwRXMw==
Received: by mail-vs1-f54.google.com with SMTP id z6so9009575vsp.0;
        Fri, 20 May 2022 11:18:58 -0700 (PDT)
X-Gm-Message-State: AOAM532chkWUjeRJO1NYV6SBuRGhdvSxUFloM19VpTMtxV4gmg/iTVDF
        L7qflms7qB/NCjoM5Pn4dgTVY3oVeX9xNEN+pCI=
X-Google-Smtp-Source: ABdhPJzNJFwsn6T9T5KIfZQ4CHoJUNjpTHgdCFaq6U5Mf9Bq6/7s0wM9wbreJ82vFhfCuqKoGio5ahZh4lQSCmWjcCA=
X-Received: by 2002:a05:6102:a49:b0:335:fd3b:7ab8 with SMTP id
 i9-20020a0561020a4900b00335fd3b7ab8mr3647435vss.2.1653070737462; Fri, 20 May
 2022 11:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220405071314.3225832-1-guoren@kernel.org> <mhng-18c947be-e3f4-49eb-adec-47f5e7eb372b@palmer-mbp2014>
In-Reply-To: <mhng-18c947be-e3f4-49eb-adec-47f5e7eb372b@palmer-mbp2014>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 21 May 2022 02:18:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR995JG_fyhSx2q5dO3YkBg-zTc8qstOZNjZ8qmpT1n1w@mail.gmail.com>
Message-ID: <CAJF2gTR995JG_fyhSx2q5dO3YkBg-zTc8qstOZNjZ8qmpT1n1w@mail.gmail.com>
Subject: Re: [PATCH V12 00/20] riscv: Add COMPAT mode support for 64BIT
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 20, 2022 at 1:50 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 05 Apr 2022 00:12:54 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> > s390, mips, sparc) have supported COMPAT mode. But they all have
> > history issues and can't use standard linux unistd.h. RISC-V would
> > be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> > /unistd.h.
> >
> > The patchset are based on v5.18-rc1, you can compare rv64-compat
> > v.s. rv32-native in qemu with following steps:
> >
> >  - Prepare rv32 rootfs & fw_jump.bin by buildroot.org
> >    $ git clone git://git.busybox.net/buildroot
> >    $ cd buildroot
> >    $ make qemu_riscv32_virt_defconfig O=3Dqemu_riscv32_virt_defconfig
> >    $ make -C qemu_riscv32_virt_defconfig
> >    $ make qemu_riscv64_virt_defconfig O=3Dqemu_riscv64_virt_defconfig
> >    $ make -C qemu_riscv64_virt_defconfig
> >    (Got fw_jump.bin & rootfs.ext2 in qemu_riscvXX_virt_defconfig/images=
)
> >
> >  - Prepare Linux rv32 & rv64 Image
> >    $ git clone git@github.com:c-sky/csky-linux.git -b riscv_compat_v12 =
linux
> >    $ cd linux
> >    $ echo "CONFIG_STRICT_KERNEL_RWX=3Dn" >> arch/riscv/configs/defconfi=
g
> >    $ echo "CONFIG_STRICT_MODULE_RWX=3Dn" >> arch/riscv/configs/defconfi=
g
> >    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv32-buildroot-linux-gnu- O=
=3D../build-rv32/ rv32_defconfig
> >    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv32-buildroot-linux-gnu- O=
=3D../build-rv32/ Image
> >    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-buildroot-linux-gnu- O=
=3D../build-rv64/ defconfig
> >    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-buildroot-linux-gnu- O=
=3D../build-rv64/ Image
> >
> >  - Prepare Qemu:
> >    $ git clone https://gitlab.com/qemu-project/qemu.git -b master linux
> >    $ cd qemu
> >    $ ./configure --target-list=3D"riscv64-softmmu riscv32-softmmu"
> >    $ make
> >
> > Now let's compare rv64-compat with rv32-native memory footprint with al=
most the same
> > defconfig, rootfs, opensbi in one qemu.
> >
> >  - Run rv64 with rv32 rootfs in compat mode:
> >    $ ./build/qemu-system-riscv64 -cpu rv64 -M virt -m 64m -nographic -b=
ios qemu_riscv64_virt_defconfig/images/fw_jump.bin -kernel build-rv64/Image=
 -drive file qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=3Draw,id=
=3Dhd0 -device virtio-blk-device,drive=3Dhd0 -append "rootwait root=3D/dev/=
vda ro console=3DttyS0 earlycon=3Dsbi" -netdev user,id=3Dnet0 -device virti=
o-net-device,netdev=3Dnet0
> >
> > QEMU emulator version 6.2.50 (v6.2.0-29-g196d7182c8)
> > OpenSBI v0.9
> > [    0.000000] Linux version 5.16.0-rc6-00017-g750f87086bdd-dirty (guor=
en@guoren-Z87-HD3) (riscv64-unknown-linux-gnu-gcc (GCC) 10.2.0, GNU ld (GNU=
 Binutils) 2.37) #96 SMP Tue Dec 28 21:01:55 CST 2021
> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> > [    0.000000] Machine model: riscv-virtio,qemu
> > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> > [    0.000000] printk: bootconsole [sbi0] enabled
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] Zone ranges:
> > [    0.000000]   DMA32    [mem 0x0000000080200000-0x0000000083ffffff]
> > [    0.000000]   Normal   empty
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000080200000-0x0000000083ffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x000000008=
3ffffff]
> > [    0.000000] SBI specification v0.2 detected
> > [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
> > [    0.000000] SBI TIME extension detected
> > [    0.000000] SBI IPI extension detected
> > [    0.000000] SBI RFENCE extension detected
> > [    0.000000] SBI v0.2 HSM extension detected
> > [    0.000000] riscv: ISA extensions acdfhimsu
> > [    0.000000] riscv: ELF capabilities acdfim
> > [    0.000000] percpu: Embedded 17 pages/cpu s30696 r8192 d30744 u69632
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1=
5655
> > [    0.000000] Kernel command line: rootwait root=3D/dev/vda ro console=
=3DttyS0 earlycon=3Dsbi
> > [    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 b=
ytes, linear)
> > [    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 by=
tes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]       fixmap : 0xffffffcefee00000 - 0xffffffceff000000  =
 (2048 kB)
> > [    0.000000]       pci io : 0xffffffceff000000 - 0xffffffcf00000000  =
 (  16 MB)
> > [    0.000000]      vmemmap : 0xffffffcf00000000 - 0xffffffcfffffffff  =
 (4095 MB)
> > [    0.000000]      vmalloc : 0xffffffd000000000 - 0xffffffdfffffffff  =
 (65535 MB)
> > [    0.000000]       lowmem : 0xffffffe000000000 - 0xffffffe003e00000  =
 (  62 MB)
> > [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff  =
 (2047 MB)
> > [    0.000000] Memory: 52788K/63488K available (6184K kernel code, 888K=
 rwdata, 1917K rodata, 294K init, 297K bss, 10700K reserved, 0K cma-reserve=
d)
> > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
> > [    0.000000] rcu: Hierarchical RCU implementation.
> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu=
_ids=3D1.
> > [    0.000000] rcu:     RCU debug extended QS entry/exit.
> > [    0.000000]  Tracing variant of Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay =
is 25 jiffies.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D1
> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> > [    0.000000] riscv-intc: 64 local interrupts mapped
> > [    0.000000] plic: plic@c000000: mapped 53 interrupts with 1 handlers=
 for 2 contexts.
> > ...
> > Welcome to Buildroot
> > buildroot login: root
> > # cat /proc/cpuinfo
> > processor       : 0
> > hart            : 0
> > isa             : rv64imafdcsuh
> > mmu             : sv48
> >
> > # file /bin/busybox
> > /bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version =
1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1=
, for GNU/Linux 5.15.0, stripped
> > # ca[   78.386630] random: fast init done
> > # cat /proc/meminfo
> > MemTotal:          53076 kB
> > MemFree:           40264 kB
> > MemAvailable:      40244 kB
> > Buffers:             236 kB
> > Cached:             1560 kB
> > SwapCached:            0 kB
> > Active:             1700 kB
> > Inactive:            516 kB
> > Active(anon):         40 kB
> > Inactive(anon):      424 kB
> > Active(file):       1660 kB
> > Inactive(file):       92 kB
> > Unevictable:           0 kB
> > Mlocked:               0 kB
> > SwapTotal:             0 kB
> > SwapFree:              0 kB
> > Dirty:                 0 kB
> > Writeback:             0 kB
> > AnonPages:           444 kB
> > Mapped:             1188 kB
> > Shmem:                44 kB
> > KReclaimable:        952 kB
> > Slab:               5744 kB
> > SReclaimable:        952 kB
> > SUnreclaim:         4792 kB
> > KernelStack:         624 kB
> > PageTables:          156 kB
> > NFS_Unstable:          0 kB
> > Bounce:                0 kB
> > WritebackTmp:          0 kB
> > CommitLimit:       26536 kB
> > Committed_AS:       1748 kB
> > VmallocTotal:   67108863 kB
> > VmallocUsed:         652 kB
> > VmallocChunk:          0 kB
> > Percpu:               80 kB
> > #
> >
> >  - Run rv32 with rv32 rootfs:
> >    $ ./build/qemu-system-riscv32 -cpu rv32 -M virt -m 64m -nographic -b=
ios qemu_riscv32_virt_defconfig/images/fw_jump.bin -kernel build-rv32/Image=
 -drive file qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=3Draw,id=
=3Dhd0 -device virtio-blk-device,drive=3Dhd0 -append "rootwait root=3D/dev/=
vda ro console=3DttyS0 earlycon=3Dsbi" -netdev user,id=3Dnet0 -device virti=
o-net-device,netdev=3Dnet0
> >
> > QEMU emulator version 6.2.50 (v6.2.0-29-g196d7182c8)
> > OpenSBI v0.9
> > [    0.000000] Linux version 5.16.0-rc6-00017-g750f87086bdd-dirty (guor=
en@guoren-Z87-HD3) (riscv32-buildroot-linux-gnu-gcc.br_real (Buildroot 2021=
.11-201-g7600ca7960-dirty) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #7 SMP Tue=
 Dec 28 21:02:21 CST 2021
> > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80400000
> > [    0.000000] Machine model: riscv-virtio,qemu
> > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> > [    0.000000] printk: bootconsole [sbi0] enabled
> > [    0.000000] efi: UEFI not found.
> > [    0.000000] Zone ranges:
> > [    0.000000]   Normal   [mem 0x0000000080400000-0x0000000083ffffff]
> > [    0.000000] Movable zone start for each node
> > [    0.000000] Early memory node ranges
> > [    0.000000]   node   0: [mem 0x0000000080400000-0x0000000083ffffff]
> > [    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x000000008=
3ffffff]
> > [    0.000000] SBI specification v0.2 detected
> > [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
> > [    0.000000] SBI TIME extension detected
> > [    0.000000] SBI IPI extension detected
> > [    0.000000] SBI RFENCE extension detected
> > [    0.000000] SBI v0.2 HSM extension detected
> > [    0.000000] riscv: ISA extensions acdfhimsu
> > [    0.000000] riscv: ELF capabilities acdfim
> > [    0.000000] percpu: Embedded 12 pages/cpu s16600 r8192 d24360 u49152
> > [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1=
5240
> > [    0.000000] Kernel command line: rootwait root=3D/dev/vda ro console=
=3DttyS0 earlycon=3Dsbi
> > [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 b=
ytes, linear)
> > [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 by=
tes, linear)
> > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]       fixmap : 0x9dc00000 - 0x9e000000   (4096 kB)
> > [    0.000000]       pci io : 0x9e000000 - 0x9f000000   (  16 MB)
> > [    0.000000]      vmemmap : 0x9f000000 - 0x9fffffff   (  15 MB)
> > [    0.000000]      vmalloc : 0xa0000000 - 0xbfffffff   ( 511 MB)
> > [    0.000000]       lowmem : 0xc0000000 - 0xc3c00000   (  60 MB)
> > [    0.000000] Memory: 51924K/61440K available (6117K kernel code, 695K=
 rwdata, 1594K rodata, 255K init, 241K bss, 9516K reserved, 0K cma-reserved=
)
> > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
> > [    0.000000] rcu: Hierarchical RCU implementation.
> > [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu=
_ids=3D1.
> > [    0.000000] rcu:     RCU debug extended QS entry/exit.
> > [    0.000000]  Tracing variant of Tasks RCU enabled.
> > [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay =
is 25 jiffies.
> > [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu=
_ids=3D1
> > [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> > [    0.000000] riscv-intc: 32 local interrupts mapped
> > [    0.000000] plic: plic@c000000: mapped 53 interrupts with 1 handlers=
 for 2 contexts.
> > ...
> > Welcome to Buildroot
> > buildroot login: root
> > # cat /proc/cpuinfo
> > processor       : 0
> > hart            : 0
> > isa             : rv32imafdcsuh
> > mmu             : sv32
> >
> > # file /bin/busybox
> > /bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version =
1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1=
, for GNU/Linux 5.15.0, stripped
> > [   79.320589] random: fast init done
> > # cat /proc/meminfo
> > MemTotal:          52176 kB
> > MemFree:           41012 kB
> > MemAvailable:      42176 kB
> > Buffers:             644 kB
> > Cached:             2724 kB
> > SwapCached:            0 kB
> > Active:             3128 kB
> > Inactive:            752 kB
> > Active(anon):         40 kB
> > Inactive(anon):      516 kB
> > Active(file):       3088 kB
> > Inactive(file):      236 kB
> > Unevictable:           0 kB
> > Mlocked:               0 kB
> > SwapTotal:             0 kB
> > SwapFree:              0 kB
> > Dirty:                 4 kB
> > Writeback:             0 kB
> > AnonPages:           556 kB
> > Mapped:             2172 kB
> > Shmem:                44 kB
> > KReclaimable:        656 kB
> > Slab:               3684 kB
> > SReclaimable:        656 kB
> > SUnreclaim:         3028 kB
> > KernelStack:         312 kB
> > PageTables:           88 kB
> > NFS_Unstable:          0 kB
> > Bounce:                0 kB
> > WritebackTmp:          0 kB
> > CommitLimit:       26088 kB
> > Committed_AS:       2088 kB
> > VmallocTotal:     524287 kB
> > VmallocUsed:          12 kB
> > VmallocChunk:          0 kB
> > Percpu:               60 kB
> > #
> >
> >  Some conclusions:
> >  - kernel statics:
> >    64: Memory: 52788K/63488K available (6184K kernel code, 888K rwdata,=
 1917K rodata, 294K init, 297K bss, 10700K reserved)
> >    32: Memory: 51924K/61440K available (6117K kernel code, 695K rwdata,=
 1594K rodata, 255K init, 241K bss,  9516K reserved)
> >    rv32 better than rv64:                  1%               22%        =
   17%          13%        19%         11%
> >    The code size is very similar, but data size rv32 would be better.
> >
> >  - rv32 kernel runtime KernelStack, Slab... are smaller,
> >    rv64: MemTotal: 53076 kB,        MemFree: 40264 kB
> >    rv32: MemTotal: 52176 + 2048 kB, MemFree: 41012  + 2048 kB
> >    rv32 better than rv64:       2%                         6%
> >
> >    (Because opensbi problem, we could add another 2MB for rv32.)
> >    Overall in 64MB memory situation, rv64-compat is 6% worse than rv32-=
native
> >    at memory footprint. If the userspace memory usage increases, I thin=
k
> >    the gap will be further reduced.
> >
> > Changes in v12:
> >  - Rebase on 5.18-rc1
> >  - Fixup compile conflicts with 5.18-rc1
> >  - Fixup $(srctree) =3D=3D $(objtree) compile error reported by Nathan
> >
> > Changes in v11:
> >  - Using arch instead of kconfig for commit subject by Masahiro Yamada
> >
> > Changes in v10:
> >  - Fixup arm64 compile error with compat_statfs definition
> >  - Fixup compat_sys_fadvise64_64 function arguments error cause ltp fai=
lure
> >
> > Changes in v9:
> >  - Fixup rv32 call rv64 segment fault
> >  - Ready for 5.18
> >
> > Changes in v8:
> >  - Enhanced elf_check_arch with EI_CLASS
> >  - Fixup SR_UXL doesn't exist in CONFIG_32BIT
> >  - Add Tested-by with Heiko
> >  - Update qemu compile tips with upstream repo
> >
> > Changes in v7:
> >  - Re-construct compat_vdso/Makefile
> >  - Fixup disable COMPAT compile error by csr.h's macro.
> >  - Optimize coding convention for lo/hi in compat.h
> >
> > Changes in v6:
> >  - Rebase on linux-5.17-rc5
> >  - Optimize hw capability check for elf
> >  - Optimize comment in thread_info.h
> >  - Optimize start_thread with SR_UXL setting
> >  - Optimize vdso.c with direct panic
> >
> > Changes in v5:
> >  - Rebase on linux-5.17-rc2
> >  - Include consolidate the fcntl patches by Christoph Hellwig
> >  - Remove F_GETLK64/F_SETLK64/F_SETLKW64 from asm/compat.h
> >  - Change COMPAT_RLIM_INFINITY from 0x7fffffff to 0xffffffff
> >  - Bring back "Add hw-cap detect in setup_arch patch" in v1
> >
> > Changes in v4:
> >  - Rebase on linux-5.17-rc1
> >  - Optimize compat_sys_call_table implementation with Arnd's advice
> >  - Add reviewed-by for Arnd. Thx :)
> >  - Remove FIXME comment in elf.h
> >  - Optimize Cleanup duplicate definitions in compat.h with Arnd's advic=
e
> >
> > Changes in v3:
> >  - Rebase on newest master (pre linux-5.17-rc1)
> >  - Using newest qemu version v7 for test
> >  - Remove fcntl common modification
> >  - Fixup SET_PERSONALITY in elf.h by Arnd
> >  - Fixup KVM Kconfig
> >  - Update Acked-by & Reviewed-by
> >
> > Changes in v2:
> >  - Add __ARCH_WANT_COMPAT_STAT suggested
> >  - Cleanup fcntl compatduplicate definitions
> >  - Cleanup compat.h
> >  - Move rv32_defconfig into Makefile
> >  - Fixup rv64 rootfs boot failed, remove hw_compat_mode_detect
> >  - Move SYSVIPC_COMPAT into init/Kconfig
> >  - Simplify compat_elf_check
> >
> > Christoph Hellwig (3):
> >   uapi: simplify __ARCH_FLOCK{,64}_PAD a little
> >   uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
> >   compat: consolidate the compat_flock{,64} definition
> >
> > Guo Ren (17):
> >   arch: Add SYSVIPC_COMPAT for all architectures
> >   fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
> >   asm-generic: compat: Cleanup duplicate definitions
> >   syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
> >   riscv: Fixup difference with defconfig
> >   riscv: compat: Add basic compat data type implementation
> >   riscv: compat: Support TASK_SIZE for compat mode
> >   riscv: compat: syscall: Add compat_sys_call_table implementation
> >   riscv: compat: syscall: Add entry.S implementation
> >   riscv: compat: process: Add UXL_32 support in start_thread
> >   riscv: compat: Add elf.h implementation
> >   riscv: compat: Add hw capability check for elf
> >   riscv: compat: vdso: Add COMPAT_VDSO base code implementation
> >   riscv: compat: vdso: Add setup additional pages implementation
> >   riscv: compat: signal: Add rt_frame implementation
> >   riscv: compat: ptrace: Add compat_arch_ptrace implement
> >   riscv: compat: Add COMPAT Kbuild skeletal support
> >
> >  arch/arm64/Kconfig                            |   4 -
> >  arch/arm64/include/asm/compat.h               |  93 +------
> >  arch/arm64/include/asm/unistd.h               |   1 +
> >  arch/mips/Kconfig                             |   5 -
> >  arch/mips/include/asm/compat.h                |  41 +--
> >  arch/mips/include/asm/unistd.h                |   2 +
> >  arch/mips/include/uapi/asm/fcntl.h            |  30 +--
> >  arch/parisc/Kconfig                           |   4 -
> >  arch/parisc/include/asm/compat.h              |  45 +---
> >  arch/parisc/include/asm/unistd.h              |   1 +
> >  arch/powerpc/Kconfig                          |   5 -
> >  arch/powerpc/include/asm/compat.h             |  50 +---
> >  arch/powerpc/include/asm/unistd.h             |   1 +
> >  arch/riscv/Kconfig                            |  19 ++
> >  arch/riscv/Makefile                           |   9 +
> >  arch/riscv/include/asm/compat.h               | 129 ++++++++++
> >  arch/riscv/include/asm/csr.h                  |   7 +
> >  arch/riscv/include/asm/elf.h                  |  50 +++-
> >  arch/riscv/include/asm/mmu.h                  |   1 +
> >  arch/riscv/include/asm/pgtable.h              |  13 +-
> >  arch/riscv/include/asm/processor.h            |   6 +-
> >  arch/riscv/include/asm/syscall.h              |   1 +
> >  arch/riscv/include/asm/thread_info.h          |   1 +
> >  arch/riscv/include/asm/unistd.h               |  11 +
> >  arch/riscv/include/asm/vdso.h                 |   9 +
> >  arch/riscv/include/uapi/asm/unistd.h          |   2 +-
> >  arch/riscv/kernel/Makefile                    |   3 +
> >  arch/riscv/kernel/compat_signal.c             | 242 ++++++++++++++++++
> >  arch/riscv/kernel/compat_syscall_table.c      |  19 ++
> >  arch/riscv/kernel/compat_vdso/.gitignore      |   2 +
> >  arch/riscv/kernel/compat_vdso/Makefile        |  78 ++++++
> >  arch/riscv/kernel/compat_vdso/compat_vdso.S   |   8 +
> >  .../kernel/compat_vdso/compat_vdso.lds.S      |   3 +
> >  arch/riscv/kernel/compat_vdso/flush_icache.S  |   3 +
> >  .../compat_vdso/gen_compat_vdso_offsets.sh    |   5 +
> >  arch/riscv/kernel/compat_vdso/getcpu.S        |   3 +
> >  arch/riscv/kernel/compat_vdso/note.S          |   3 +
> >  arch/riscv/kernel/compat_vdso/rt_sigreturn.S  |   3 +
> >  arch/riscv/kernel/entry.S                     |  18 +-
> >  arch/riscv/kernel/process.c                   |  37 +++
> >  arch/riscv/kernel/ptrace.c                    |  87 ++++++-
> >  arch/riscv/kernel/signal.c                    |  13 +-
> >  arch/riscv/kernel/sys_riscv.c                 |   6 +-
> >  arch/riscv/kernel/vdso.c                      | 105 +++++---
> >  arch/riscv/kernel/vdso/vdso.S                 |   6 +-
> >  arch/s390/Kconfig                             |   3 -
> >  arch/s390/include/asm/compat.h                |  99 +------
> >  arch/s390/include/asm/unistd.h                |   1 +
> >  arch/sparc/Kconfig                            |   5 -
> >  arch/sparc/include/asm/compat.h               |  61 ++---
> >  arch/sparc/include/asm/unistd.h               |   1 +
> >  arch/x86/Kconfig                              |   4 -
> >  arch/x86/include/asm/compat.h                 | 104 ++------
> >  arch/x86/include/asm/unistd.h                 |   1 +
> >  fs/open.c                                     |  24 ++
> >  fs/read_write.c                               |  16 ++
> >  fs/stat.c                                     |   2 +-
> >  fs/sync.c                                     |   9 +
> >  include/asm-generic/compat.h                  | 113 ++++++++
> >  include/linux/compat.h                        |  68 +++++
> >  include/uapi/asm-generic/fcntl.h              |  23 +-
> >  include/uapi/asm-generic/unistd.h             |   4 +-
> >  init/Kconfig                                  |   4 +
> >  mm/fadvise.c                                  |  11 +
> >  mm/readahead.c                                |   7 +
> >  tools/include/uapi/asm-generic/fcntl.h        |  21 +-
> >  tools/include/uapi/asm-generic/unistd.h       |   4 +-
> >  67 files changed, 1206 insertions(+), 563 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/compat.h
> >  create mode 100644 arch/riscv/kernel/compat_signal.c
> >  create mode 100644 arch/riscv/kernel/compat_syscall_table.c
> >  create mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
> >  create mode 100644 arch/riscv/kernel/compat_vdso/Makefile
> >  create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
> >  create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
> >  create mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
> >  create mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offse=
ts.sh
> >  create mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
> >  create mode 100644 arch/riscv/kernel/compat_vdso/note.S
> >  create mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S
>
> Thanks.
>
> This touches a bunch of other trees, which I try to avoid without the
> relevant acks and such.  In this case I'm OK taking it because Arnd and
> Christoph have written/reviewed/ack'd so much of it, and because some
> autobuilders found build issues (and thus I'm assuming there aren't any
> more).
>
> There's been a bunch of versions of this and I'm pretty sure I've said
> this a handful of times without any comments.  Now that it's passing all
> my tests and I'm not getting any autobuilding breakages I've put it on
> for-next, but happy to try and spin up some sort of multi-tree merge if
Sounds good to me. Thx.

> that's an issue for anyone.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

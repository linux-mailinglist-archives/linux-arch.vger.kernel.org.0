Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12070851F
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjERPi2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjERPi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 11:38:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128012C
        for <linux-arch@vger.kernel.org>; Thu, 18 May 2023 08:38:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-643b60855c8so2320462b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 18 May 2023 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684424303; x=1687016303;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JhrgXeiQOxUHDraeEUPB8K66Vg75L62U37cHG7sloo=;
        b=UBonUSmx537teqA3ICRmRkfaOEOG7RU4uOYGU+UOvI9gWmX5G4xuVGcZlptsi/+u5z
         O0f/yIW1yzBbI7M2cUCLpJE39/X3awWYXBtXGhAmxyzm6C0QNr4NiPsiz4Doo0CbVVeu
         4EVz4QlbfGV2KS41yeAvtVH4QpFg+srhqIy1shNheKrsr8TIgNDt1LIp4kRH0DWAEpYC
         i0nFoY1fUuI6leo7W/+AJI+PmJARni1sKPUAxRWRbp10/f35PhaPOy7br2Lg+qFArC2j
         FVL6WNh1Ic1VAd8/6wvWSzCxNh8qvJLs/2U1UODCtW+E8NUf6TUV/yUCOvo1Qa9bMpGr
         qrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424303; x=1687016303;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JhrgXeiQOxUHDraeEUPB8K66Vg75L62U37cHG7sloo=;
        b=FOjPpgGqrWGvaSUBGmL/U+KgAe89J2Hq75vsqaO8MEe1B0GQCUgoNq13J/EvHVIoZo
         +ibXfk3aRSomeCv3TLFqVSevrOsoer4WtZwCQmRouzR6BfNM8P3MxrmoIBlYPkCnJb1j
         kZGdRI5USjaxtI3yUPeilSf5J0KTPaiK34N6jr0m6yEt2ckdsGN6Iti6zmeEsPks3N8F
         G/DABEdE257f9SjnHEpMfN16hjPDcJa2WDW7hMJjT5MMPunIsZslJYgtDf4sMLQE4FiD
         tHHJB9mdtvtBNVCPlb4bHW3LKoovhVVP6sinGB7KC6Eg4jBzFrDsvA9veMYyMPaVXVNR
         USlA==
X-Gm-Message-State: AC+VfDzm6N6efTuHotR2HXaqzswfxc/dx6CPfmdMWfMkyhKx1UX8wMD2
        G/FoPomxRCp1am2UZjtdIbZBkQ==
X-Google-Smtp-Source: ACHHUZ4YGX4cMmOvXlybF2r6bpAUviOfPAOA3WSD6EEWBYvUyGI94F7oFtGD6/+OCZYmFbr5S+L7KA==
X-Received: by 2002:a05:6a21:9986:b0:105:eded:5369 with SMTP id ve6-20020a056a21998600b00105eded5369mr3311523pzb.53.1684424302965;
        Thu, 18 May 2023 08:38:22 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id h4-20020a655184000000b00530621e5ee4sm1325535pgq.9.2023.05.18.08.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:38:22 -0700 (PDT)
Date:   Thu, 18 May 2023 08:38:22 -0700 (PDT)
X-Google-Original-Date: Thu, 18 May 2023 08:38:19 PDT (-0700)
Subject:     Re: [RFC PATCH 00/22] riscv: s64ilp32: Running 32-bit Linux kernel on 64-bit supervisor mode
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        jszhang@kernel.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, Mark Rutland <mark.rutland@arm.com>,
        bjorn@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, rppt@kernel.org,
        anup@brainfault.org, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn, chunyu@iscas.ac.cn,
        tsu.yubo@gmail.com, wefu@redhat.com, wangjunqiang@iscas.ac.cn,
        kito.cheng@sifive.com, andy.chiu@sifive.com,
        vincent.chen@sifive.com, greentime.hu@sifive.com, corbet@lwn.net,
        wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     guoren@kernel.org
Message-ID: <mhng-24855381-7da8-4c77-bcaf-a3a53c8cb38b@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 18 May 2023 06:09:51 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch series adds s64ilp32 support to riscv. The term s64ilp32
> means smode-xlen=64 and -mabi=ilp32 (ints, longs, and pointers are all
> 32-bit), i.e., running 32-bit Linux kernel on pure 64-bit supervisor
> mode. There have been many 64ilp32 abis existing, such as mips-n32 [1],
> arm-aarch64ilp32 [2], and x86-x32 [3], but they are all about userspace.
> Thus, this should be the first time running a 32-bit Linux kernel with
> the 64ilp32 ABI at supervisor mode (If not, correct me).

Does anyone actually want this?  At a bare minimum we'd need to add it 
to the psABI, which would presumably also be required on the compiler 
side of things.

It's not even clear anyone wants rv64/ilp32 in userspace, the kernel 
seems like it'd be even less widely used.

> Why 32-bit Linux?
> =================
> The motivation for using a 32-bit Linux kernel is to reduce memory
> footprint and meet the small capacity of DDR & cache requirement
> (e.g., 64/128MB SIP SoC).
>
> Here are the 32-bit v.s. 64-bit Linux kernel data type comparison
> summary:
> 			32-bit		64-bit
> sizeof(page):		32bytes		64bytes
> sizeof(list_head):	8bytes		16bytes
> sizeof(hlist_head):	8bytes		16bytes
> sizeof(vm_area):	68bytes		136bytes
> ...
>
> The size of ilp32's long & pointer is just half of lp64's (rv64 default
> abi - longs and pointers are all 64-bit). This significant difference
> in data type causes different memory & cache footprint costs. Here is
> the comparison measurement between s32ilp32, s64ilp32, and s64lp64 in
> the same 128MB qemu system environment:
>
> Rootfs:
> u32ilp32 - Using the same 32-bit userspace rootfs.ext2 (UXL=32) binary
> 	   from buildroot 2023.02-rc3, qemu_riscv32_virt_defconfig
>
> Linux:
> s32ilp32 - Linux version 6.3.0-rc1 (124MB)
>            rv32_defconfig: $(Q)$(MAKE) -f $(srctree)/Makefile
>            defconfig 32-bit.config
>
> s64lp64  - Linux version 6.3.0-rc1 (126MB)
>            defconfig: $(Q)$(MAKE) -f $(srctree)/Makefile defconfig
>
> s64ilp32 - Linux version 6.3.0-rc1 (126MB)
>            rv64ilp32_defconfig: $(Q)$(MAKE) -f $(srctree)/Makefile
> 	   defconfig 64ilp32.config
>
> Opensbi:
> m64lp64  - (2MB) OpenSBI v1.2-80-g4b28afc98bbe
> m32ilp32 - (4MB) OpenSBI v1.2-80-g4b28afc98bbe
>
>   +----------------------------------------+--------
>   |              u32ilp32                  |
>   |                UXL=32                  | Rootfs
>   +----------------------------------------+--------
>   | +----------+ +---------+ | +---------+ |
>   | | s64ilp32 | | s64lp64 | | | s32ilp32| |
>   | |  SXL=64  | |  SXL=64 | | |  SXL=32 | | Linux
>   | +----------+ +---------+ | +---------+ |
>   +----------------------------------------+--------
>   | +----------------------+ | +---------+ |
>   | |        m64lp64       | | | m32ilp32| |
>   | |         MXL=64       | | |  MXL=32 | | Opensbi
>   | +----------------------+ | +---------+ |
>   +----------------------------------------+--------
>   | +----------------------+ | +---------+ |
>   | |        qemu-rv64     | | |qemu-rv32| | HW
>   | +----------------------+ | +---------+ |
>   +----------------------------------------+--------
>
> Mem-usage:
> (s32ilp32) # free
>        total   used   free  shared  buff/cache   available
> Mem:  100040   8380  88244      44        3416       88080
>
> (s64lp64)  # free
>        total   used   free  shared  buff/cache   available
> Mem:   91568  11848  75796      44        3924       75952
>
> (s64ilp32) # free
>        total   used   free  shared  buff/cache   available
> Mem:  101952   8528  90004      44        3420       89816
>                      ^^^^^
>
> It's a rough measurement based on the current default config without any
> modification, and 32-bit (s32ilp32, s64ilp32) saved more than 16% memory
> to 64-bit (s64lp64). But s32ilp32 & s64ilp32 have a similar memory
> footprint (about 0.33% difference), meaning s64ilp32 has a big chance to
> replace s32ilp32 on the 64-bit machine.
>
> Why s64ilp32?
> =============
> The current RISC-V has the profiles of RVA20S64, RVA22S64, and RVA23S64
> (ongoing) [4], but no RVA**S32 profile exists or any ongoing plan. That
> means when a vendor wants to produce a 32-bit s-mode RISC-V Application
> Processor, they have no shape to follow. Therefore, many cheap riscv
> chips have come out but follow the RVA2xS64 profiles, such as Allwinner
> D1/D1s/F133 [5], SOPHGO CV1800B [6], Canaan Kendryte k230 [7], and
> Bouffalo Lab BL808 which are typically cortex a7/a35/a53 product
> scenarios. The D1 & CV1800B & BL808 didn't support UXL=32 (32-bit U-mode),
> so they need a new u64ilp32 userspace ABI which has no software ecosystem
> for the current. Thus, the first landing of s64ilp32 would be on Canaan
> Kendryte k230, which has c908 with rv64gcv and compat user mode
> (sstatus.uxl=32/64), which could support the existing rv32 userspace
> software ecosystem.
>
> Another reason for inventing s64ilp32 is performance benefits and
> simplify 64-bit CPU hardware design (v.s. s32ilp32).
>
> Why s64ilp32 has better performance?
> ====================================
> Generally speaking, we should build a 32-bit hardware s-mode to run
> 32-bit Linux on a 64-bit processor (such as Linux-arm32 on cortex-a53).
> Or only use old 32ilp32-abi on a 64-bit machine (such as mips
> SYS_SUPPORTS_32BIT_KERNEL). These can't reuse performance-related
> features and instructions of the 64-bit hardware, such as 64-bit ALU,
> AMO, and LD/SD, which would cause significant performance gaps on many
> Linux features:
>
>  - memcpy/memset/strcmp (s64ilp32 has half of the instructions count
>    and double the bandwidth of load/store instructions than s32ilp32.)
>
>  - ebpf JIT is a 64-bit virtual ISA, which is not suitable
>    for mapping to s32ilp32.
>
>  - Atomic64 (s64ilp32 has the exact native instructions mapping as
>    s64lp64, but s32ilp32 only uses generic_atomic64, a tradeoff &
>    limited software solution.)
>
>  - 64-bit native arithmetic instructions for "long long" type
>
>  - Support cmxchg_double for slub (The 2nd 32-bit Linux
>    supports the feature, the 1st is i386.)
>
>  - ...
>
> Compared with the user space ecosystem, the 32-bit Linux kernel is more
> eager to need 64ilp32 to improve performance because the Linux kernel
> can't utilize float-point/vector features of the ISA.
>
> Let's look at performance from another perspective (s64ilp32 v.s.
> s64lp64). Just as the first chapter said, the pointer size of ilp32 is
> half of the lp64, and it reduces the size of the critical data structs
> (e.g., page, list, ...). That means the cache of using ilp32 could
> contain double data that lp64 with the same cache capacity, which is a
> natural advantage of 32-bit.
>
> Why s64ilp32 simplifies CPU design?
> ===================================
> Yes, there are a lot of runing 32-bit Linux on 64-bit hardware examples
> in history, such as arm cortex a35/a53/a55, which implements the 32-bit
> EL1/EL2/EL3 hardware mode to support 32-bit Linux. We could follow Arm's
> style, but riscv could choose another better way. Compared to UXL=32,
> the MXL=SXL=32 has many CSR-related hardware functionalities, which
> causes a lot of effort to mix them into 64-bit hardware. The s64ilp32
> works on MXL=SXL=64 mode, so the CPU vendors needn't implement 32-bit
> machine and supervisor modes.
>
> How does s64ilp32 work?
> =======================
> The s64ilp32 is the same as the s64lp64 compat mode from a hardware
> view, i.e., MXL=SXL=64 + UXL=32. Because the s64ilp32 uses CONFIG_32BIT
> of Linux, it only supports u32ilp32 abi user space, the current standard
> rv32 software ecosystem, and it can't work with u64lp64 abi (I don't
> want that complex and useless stuff). But it may work with u64ilp32 in the
> future; now, the s64ilp32 depends on the UXL=32 feature of the hardware.
>
> The 64ilp32 gcc still uses sign-extend lw & auipc to generate address
> variables because inserting zero-extend instructions to mask the highest
> 32-bit would cause significant code size and performance problems. Thus,
> we invented an OS approach to solve the problem:
>  - When satp=bare and start physical address < 2GB, there is no sign-extend
>    address problem.
>  - When satp=bare and start physical address > 2GB, we need zjpm liked
>    hardware extensions to mask high 32bit.
>    (Fortunately, all existed SoCs' (D1/D1s/F133, CV1800B, k230, BL808)
>     start physical address < 2GB.)
>  - When satp=sv39, we invent double mapping to make the sign-extended
>    virtual address the same as the zero-extended virtual address.
>
>    +--------+      +---------+      +--------+
>    |        |   +--| 511:PUD1|      |        |
>    |        |   |  +---------+      |        |
>    |        |   |  | 510:PUD0|--+   |        |
>    |        |   |  +---------+  |   |        |
>    |        |   |  |         |  |   |        |
>    |        |   |  |         |  |   |        |
>    |        |   |  |         |  |   |        |
>    |        |   |  | INVALID |  |   |        |
>    |        |   |  |         |  |   |        |
>    |  ....  |   |  |         |  |   |  ....  |
>    |        |   |  |         |  |   |        |
>    |        |   |  +---------+  |   |        |
>    |        |   +--|  3:PUD1 |  |   |        |
>    |        |   |  +---------+  |   |        |
>    |        |   |  |  2:PUD0 |--+   |        |
>    |        |   |  +---------+  |   |        |
>    |        |   |  |1:USR_PUD|  |   |        |
>    |        |   |  +---------+  |   |        |
>    |        |   |  |0:USR_PUD|  |   |        |
>    +--------+<--+  +---------+  +-->+--------+
>       PUD1         ^   PGD             PUD0
>       1GB          |   4GB             1GB
>                    |
>                    +----------+
>                    | Sv39 PGDP|
>                    +----------+
>                        SATP
>
> The size of xlen was always equal to the pointer/long size before
> s64ilp32 emerged. So we need to introduce a new type of data - xlen_t,
> which could deal with CSR-related and callee-save/restore operations.
>
> Some kernel features use 32BIT/64BIT to determine the exact ISA, such as
> ebpf JIT would map to rv32 ISA when CONFIG_32BIT=y. But s64ilp32 needs
> the ebpf JIT map to rv64 ISA when CONFIG_32BIT=y and we need to use
> another config to distinguish the difference.
>
> More detials, please review the path series.
>
> How to run s64ilp32?
> ====================
>
> GNU toolchain
> -------------
> git clone https://github.com/Liaoshihua/riscv-gnu-toolchain.git
> cd riscv-gnu-toolchain
> ./configure --prefix="$PWD/opt-rv64-ilp32/" --with-arch=rv64imac --with-abi=ilp32
> make linux
> export PATH=$PATH:$PWD/opt-rv64-ilp32/bin/
>
> Opensbi
> -------
> git clone https://github.com/riscv-software-src/opensbi.git
> CROSS_COMPILE=riscv64-unknown-linux-gnu- make PLATFORM=generic
>
> Linux kernel
> ------------
> git clone https://github.com/guoren83/linux.git -b s64ilp32
> cd linux
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- rv64ilp32_defconfig
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- all
>
> Rootfs
> ------
> git clone git://git.busybox.net/buildroot
> cd buildroot
> make qemu_riscv32_virt_defconfig
> make
>
> Qemu
> ----
> git clone https://github.com/plctlab/plct-qemu.git -b plct-s64ilp32-dev
> cd plct-qemu
> mkdir build
> cd build
> ../qemu/configure --target-list="riscv64-softmmu riscv32-softmmu"
> make
>
> Run
> ---
> ./qemu-system-riscv64 -cpu rv64 -M virt -m 128m -nographic -bios fw_dynamic.bin -kernel Image -drive file=rootfs.ext2,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -append "rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi" -netdev user,id=net0 -device virtio-net-device,netdev=net0
>
> OpenSBI v1.2-119-gdc1c7db05e07
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|___/_____|
>         | |
>         |_|
>
> Platform Name             : riscv-virtio,qemu
> Platform Features         : medeleg
> Platform HART Count       : 1
> Platform IPI Device       : aclint-mswi
> Platform Timer Device     : aclint-mtimer @ 10000000Hz
> Platform Console Device   : uart8250
> Platform HSM Device       : ---
> Platform PMU Device       : ---
> Platform Reboot Device    : sifive_test
> Platform Shutdown Device  : sifive_test
> Platform Suspend Device   : ---
> Platform CPPC Device      : ---
> Firmware Base             : 0x60000000
> Firmware Size             : 360 KB
> Firmware RW Offset        : 0x40000
> Runtime SBI Version       : 1.0
>
> Domain0 Name              : root
> Domain0 Boot HART         : 0
> Domain0 HARTs             : 0*
> Domain0 Region00          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
> Domain0 Region01          : 0x0000000060040000-0x000000006005ffff M: (R,W) S/U: ()
> Domain0 Region02          : 0x0000000060000000-0x000000006003ffff M: (R,X) S/U: ()
> Domain0 Region03          : 0x0000000000000000-0xffffffffffffffff M: (R,W,X) S/U: (R,W,X)
> Domain0 Next Address      : 0x0000000060200000
> Domain0 Next Arg1         : 0x0000000067e00000
> Domain0 Next Mode         : S-mode
> Domain0 SysReset          : yes
> Domain0 SysSuspend        : yes
>
> Boot HART ID              : 0
> Boot HART Domain          : root
> Boot HART Priv Version    : v1.12
> Boot HART Base ISA        : rv64imafdch
> Boot HART ISA Extensions  : time,sstc
> Boot HART PMP Count       : 16
> Boot HART PMP Granularity : 4
> Boot HART PMP Address Bits: 54
> Boot HART MHPM Count      : 16
> Boot HART MIDELEG         : 0x0000000000001666
> Boot HART MEDELEG         : 0x0000000000f0b509
> [    0.000000] Linux version 6.3.0-rc1-00086-gc8d2fedb997a (guoren@fedora) (riscv64-unknown-linux-gnu-gcc (g5e578a16201f) 13.0.1 20230206 (experimental), GNU ld (GNU Binutils) 2.40.50.20230205) #1 SMP Sun May 14 10:46:42 EDT 2023
> [    0.000000] random: crng init done
> [    0.000000] OF: fdt: Ignoring memory range 0x60000000 - 0x60200000
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x60000000..0x6003ffff (256 KiB) map non-reusable mmode_resv1@60000000
> [    0.000000] OF: reserved mem: 0x60040000..0x6005ffff (128 KiB) map non-reusable mmode_resv0@60040000
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000060200000-0x0000000067ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000060200000-0x0000000067ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000060200000-0x0000000067ffffff]
> [    0.000000] On node 0, zone Normal: 512 pages in unavailable ranges
> [    0.000000] SBI specification v1.0 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10002
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] SBI HSM extension detected
> [    0.000000] riscv: base ISA extensions acdfhim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 13 pages/cpu s24352 r8192 d20704 u53248
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 31941
> [    0.000000] Kernel command line: rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi norandmaps
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0x9ce00000 - 0x9d000000   (2048 kB)
> [    0.000000]       pci io : 0x9d000000 - 0x9e000000   (  16 MB)
> [    0.000000]      vmemmap : 0x9e000000 - 0xa0000000   (  32 MB)
> [    0.000000]      vmalloc : 0xa0000000 - 0xc0000000   ( 512 MB)
> [    0.000000]       lowmem : 0xc0000000 - 0xc7e00000   ( 126 MB)
> [    0.000000] Memory: 97748K/129024K available (8699K kernel code, 8867K rwdata, 4096K rodata, 4204K init, 361K bss, 31276K reserved, 0K cma-reserved)
> ...
> Starting network: udhcpc: started, v1.36.0
> udhcpc: broadcasting discover
> udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
> udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
> deleting routers
> adding dns 10.0.2.3
> OK
>
> Welcome to Buildroot
> buildroot login: root
> # cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdch_zihintpause_zbb_sstc
> mmu             : sv39
> mvendorid       : 0x0
> marchid         : 0x70232
> mimpid          : 0x70232
>
> # uname -a
> Linux buildroot 6.3.0-rc1-00086-gc8d2fedb997a #1 SMP Sun May 14 10:46:42 EDT 2023 riscv32 GNU/Linux
> # ls /lib/
> ld-linux-riscv32-ilp32d.so.1  libgcc_s.so.1
> libanl.so.1                   libm.so.6
> libatomic.so                  libnss_dns.so.2
> libatomic.so.1                libnss_files.so.2
> libatomic.so.1.2.0            libpthread.so.0
> libc.so.6                     libresolv.so.2
> libcrypt.so.1                 librt.so.1
> libdl.so.2                    libutil.so.1
> libgcc_s.so                   modules
>
> # cat /proc/99/maps
> 0000000055554000-0000000055634000 r-xp 00000000 00000000fe:00 17  /bin/busybox
> 0000000055634000-0000000055636000 r--p 00000000df000 00000000fe:00 17  /bin/busybox
> 0000000055636000-0000000055637000 rw-p 00000000e1000 00000000fe:00 17  /bin/busybox
> 0000000055637000-0000000055659000 rw-p 00000000 00:00 0  [heap]
> 0000000077e8d000-0000000077fbe000 r-xp 00000000 00000000fe:00 137  /lib/libc.so.6
> 0000000077fbe000-0000000077fbf000 ---p 00000000131000 00000000fe:00 137  /lib/libc.so.6
> 0000000077fbf000-0000000077fc1000 r--p 00000000131000 00000000fe:00 137  /lib/libc.so.6
> 0000000077fc1000-0000000077fc2000 rw-p 00000000133000 00000000fe:00 137  /lib/libc.so.6
> 0000000077fc2000-0000000077fcc000 rw-p 00000000 00:00 0
> 0000000077fcc000-0000000077fd4000 r-xp 00000000 00000000fe:00 146  /lib/libresolv.so.2
> 0000000077fd4000-0000000077fd5000 ---p 000000008000 00000000fe:00 146  /lib/libresolv.so.2
> 0000000077fd5000-0000000077fd6000 r--p 000000008000 00000000fe:00 146  /lib/libresolv.so.2
> 0000000077fd6000-0000000077fd7000 rw-p 000000009000 00000000fe:00 146  /lib/libresolv.so.2
> 0000000077fd7000-0000000077fd9000 rw-p 00000000 00:00 0
> 0000000077fd9000-0000000077fdb000 r--p 00000000 00:00 0  [vvar]
> 0000000077fdb000-0000000077fdd000 r-xp 00000000 00:00 0  [vdso]
> 0000000077fdd000-0000000077ffc000 r-xp 00000000 00000000fe:00 132  /lib/ld-linux-riscv32-ilp32d.so.1
> 0000000077ffd000-0000000077ffe000 r--p 000000001f000 00000000fe:00 132  /lib/ld-linux-riscv32-ilp32d.so.1
> 0000000077ffe000-0000000077fff000 rw-p 0000000020000 00000000fe:00 132  /lib/ld-linux-riscv32-ilp32d.so.1
> 000000007ffde000-000000007ffff000 rw-p 00000000 00:00 0  [stack]
>
> Other resources
> ===============
>
> OpenEuler riscv32 rootfs
> ------------------------
> The OpenEuler riscv32 rootfs you can download from here:
> https://repo.tarsier-infra.com/openEuler-RISC-V/obs/archive/rv32/openeuler-image-qemu-riscv32-20221111070036.rootfs.ext4
> (Made by Junqiang Wang)
>
> Debain riscv32 rootfs
> ---------------------
> The Debian riscv32 rootfs you can download from here:
> https://github.com/yuzibo/riscv32
> (Made by Bo YU and Han Gao)
>
> Fedora riscv32 rootfs
> ---------------------
> https://fedoraproject.org/wiki/Architectures/RISC-V/RV32
> (Made by Wei Fu)
>
> LLVM 64ilp32
> ------------
> git clone https://github.com/luxufan/llvm-project.git -b rv64-ilp32
> cd llvm-project
> mkdir build && cd build
> cmake ../llvm -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=“X86;RISCV" -DLLVM_ENABLE_PROJECTS="clang;lld"
> ninja all
>
> (LLVM development status is that CC=clang can compile the kernel with
>  LLVM=1 but has not yet booted successfully.)
>
> Patch organization
> ==================
> This series depends on 64ilp32 toolchain patches that are not upstream
> yet.
>
> PATCH [0-1] unify vdso32 & compat_vdso
> PATCH [2] adds time-related vDSO common flow for vdso32
> PATCH [3] adds s64ilp32 support of clocksource driver
> PATCH [5] adds s64ilp32 support of irqchip driver
> PATCH [4,6-12] add basic data types and compiling framework
> PATCH [13] adds MMU_SV39 support
> PATCH [14] adds native atomic64
> PATCH [15] adds TImode
> PATCH [16] adds cmpxchg_double
> PATCH [17-19] cleanup kconfig & add defconfig
> PATCH [20-21] fix temporary compiler problems
>
> Open issues
> ===========
>
> Callee saved the register width
> -------------------------------
> For 64-bit ISA (including 64lp64, 64ilp32), callee can't determine the
> correct width used in the register, so they saved the maximum width of
> the ISA register, i.e., xlen size. We also found this rule in x86-x32,
> mips-n32, and aarch64ilp32, which comes from 64lp64. See PATCH [20]
>
> Here are two downsides of this:
>  - It would cause a difference with 32ilp32's stack frame, and s64ilp32
>    reuses 32ilp32 software stack. Thus, many additional compatible
>    problems would happen during the porting of 64ilp32 software.
>  - It also increases the budget of the stack usage.
>    <setup_vm>:
>      auipc   a3,0xff3fb
>      add     a3,a3,1234 # c0000000
>      li      a5,-1
>      lui     a4,0xc0000
>      addw    sp,sp,-96
>      srl     a5,a5,0x20
>      subw    a4,a4,a3
>      auipc   a2,0x111a
>      add     a2,a2,1212 # c1d1f000
>      sd      s0,80(sp)----+
>      sd      s1,72(sp)    |
>      sd      s2,64(sp)    |
>      sd      s7,24(sp)    |
>      sd      s8,16(sp)    |
>      sd      s9,8(sp)     |-> All <= 32b widths, but occupy 64b
>      sd      ra,88(sp)    |   stack space.
>      sd      s3,56(sp)    |   Affect memory footprint & cache
>      sd      s4,48(sp)    |   performance.
>      sd      s5,40(sp)    |
>      sd      s6,32(sp)    |
>      sd      s10,0(sp)----+
>      sll     a1,a4,0x20
>      subw    a2,a2,a3
>      and     a4,a4,a5
>
> So here is a proposal to riscv 64ilp32 ABI:
>  - Let the compiler prevent callee saving ">32b variables" in
>    callee-registers. (Q: We need to measure, how the influence of
>    64b variables cross function call?)
>
> EF_RISCV_X32
> ------------
> We add an e_flag (EF_RISCV_X32) to distinguish the 32-bit ELF, which
> occupies BIT[6] of the e_flags layout.
>
> ELF Header:
>   Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
>   Class:                             ELF32
>   Data:                              2's complement, little endian
>   Version:                           1 (current)
>   OS/ABI:                            UNIX - System V
>   ABI Version:                       0
>   Type:                              REL (Relocatable file)
>   Machine:                           RISC-V
>   Version:                           0x1
>   Entry point address:               0x0
>   Start of program headers:          0 (bytes into file)
>   Start of section headers:          24620 (bytes into file)
>   Flags:                             0x21, RVC, X32, soft-float ABI
>                                                 ^^^
> 64-bit Optimization problem
> ---------------------------
> There is an existing problem in 64ilp32 gcc that combines two pointers
> in one register. Liao is solving that problem. Before he finishes the
> job, we could prevent it with a simple noinline attribute, fortunately.
>     struct path {
>             struct vfsmount *mnt;
>             struct dentry *dentry;
>     } __randomize_layout;
>
>     struct nameidata {
>             struct path     path;
>             ...
>             struct path     root;
>     ...
>     } __randomize_layout;
>
>             struct nameidata *nd
>             ...
>             nd->path = nd->root;
>     6c88                    ld      a0,24(s1)
>                                     ^^ // a0 contains two pointers
>     e088                    sd      a0,0(s1)
>             mntget(path->mnt);
>             // Need "lw a0,0(s1)" or "a0 << 32; a0 >> 32"
>     2a6150ef                jal     c01ce946 <mntget> // bug!
>
> Acknowledge
> ===========
> The s64ilp32 needs many other projects' cooperation. Thx, all guys
> involved:
>  - GNU:			LiaoShihua <shihua@iscas.ac.cn>,
> 			Jiawe Chen<jiawei@iscas.ac.cn>
>  - Qemu:		Weiwei Li <liweiwei@iscas.ac.cn>
>  - LLVM:		luxufan <luxufan@iscas.ac.cn>,
> 			Chunyu Liao<chunyu@iscas.ac.cn>
>  - OpenEuler rv32:	Junqiang Wang <wangjunqiang@iscas.ac.cn>
>  - Debian rv32:		Bo YU <tsu.yubo@gmail.com>
> 			Han Gao <gaohan@iscas.ac.cn>
>  - Fedora rv32:		Wei Fu <wefu@redhat.com>
>
> References
> ==========
> [1] https://techpubs.jurassic.nl/manuals/0630/developer/Mpro_n32_ABI/sgi_html/index.html
> [2] https://wiki.debian.org/Arm64ilp32Port
> [3] https://lwn.net/Articles/456731/
> [4] https://github.com/riscv/riscv-profiles/releases
> [5] https://www.cnx-software.com/2021/10/25/allwinner-d1s-f133-risc-v-processor-64mb-ddr2/
> [6] https://milkv.io/duo/
> [7] https://twitter.com/tphuang/status/1631308330256801793
> [8] https://www.cnx-software.com/2022/12/02/pine64-ox64-sbc-bl808-risc-v-multi-protocol-wisoc-64mb-ram/
>
> Guo Ren (22):
>   riscv: vdso: Unify vdso32 & compat_vdso into vdso/Makefile
>   riscv: vdso: Remove compat_vdso/
>   riscv: vdso: Add time-related vDSO common flow for vdso32
>   clocksource: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
>   riscv: s64ilp32: Introduce xlen_t
>   irqchip: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
>   riscv: s64ilp32: Add sbi support
>   riscv: s64ilp32: Add asid support
>   riscv: s64ilp32: Introduce PTR_L and PTR_S
>   riscv: s64ilp32: Enable user space runtime environment
>   riscv: s64ilp32: Add ebpf jit support
>   riscv: s64ilp32: Add ELF32 support
>   riscv: s64ilp32: Add ARCH RV64 ILP32 compiling framework
>   riscv: s64ilp32: Add MMU_SV39 mode support for 32BIT
>   riscv: s64ilp32: Enable native atomic64
>   riscv: s64ilp32: Add TImode (128 int) support
>   riscv: s64ilp32: Implement cmpxchg_double
>   riscv: s64ilp32: Disable KVM
>   riscv: Cleanup rv32_defconfig
>   riscv: s64ilp32: Add rv64ilp32_defconfig
>   riscv: s64ilp32: Correct the rv64ilp32 stackframe layout
>   riscv: s64ilp32: Temporary workaround solution to gcc problem
>
>  arch/riscv/Kconfig                            |  36 +++-
>  arch/riscv/Makefile                           |  24 ++-
>  arch/riscv/configs/32-bit.config              |   2 -
>  arch/riscv/configs/64ilp32.config             |   2 +
>  arch/riscv/include/asm/asm.h                  |   5 +
>  arch/riscv/include/asm/atomic.h               |   6 +
>  arch/riscv/include/asm/cmpxchg.h              |  53 ++++++
>  arch/riscv/include/asm/cpu_ops_sbi.h          |   4 +-
>  arch/riscv/include/asm/csr.h                  |  58 +++---
>  arch/riscv/include/asm/extable.h              |   2 +-
>  arch/riscv/include/asm/page.h                 |  24 ++-
>  arch/riscv/include/asm/pgtable-64.h           |  42 ++---
>  arch/riscv/include/asm/pgtable.h              |  26 ++-
>  arch/riscv/include/asm/processor.h            |   8 +-
>  arch/riscv/include/asm/ptrace.h               |  96 +++++-----
>  arch/riscv/include/asm/sbi.h                  |  24 +--
>  arch/riscv/include/asm/stacktrace.h           |   6 +
>  arch/riscv/include/asm/timex.h                |  10 +-
>  arch/riscv/include/asm/vdso.h                 |  34 +++-
>  arch/riscv/include/asm/vdso/gettimeofday.h    |  84 +++++++++
>  arch/riscv/include/uapi/asm/elf.h             |   2 +-
>  arch/riscv/include/uapi/asm/unistd.h          |   1 +
>  arch/riscv/kernel/Makefile                    |   3 +-
>  arch/riscv/kernel/compat_signal.c             |   2 +-
>  arch/riscv/kernel/compat_vdso/.gitignore      |   2 -
>  arch/riscv/kernel/compat_vdso/compat_vdso.S   |   8 -
>  .../kernel/compat_vdso/compat_vdso.lds.S      |   3 -
>  arch/riscv/kernel/compat_vdso/flush_icache.S  |   3 -
>  arch/riscv/kernel/compat_vdso/getcpu.S        |   3 -
>  arch/riscv/kernel/compat_vdso/note.S          |   3 -
>  arch/riscv/kernel/compat_vdso/rt_sigreturn.S  |   3 -
>  arch/riscv/kernel/cpu.c                       |   4 +-
>  arch/riscv/kernel/cpu_ops_sbi.c               |   4 +-
>  arch/riscv/kernel/cpufeature.c                |   4 +-
>  arch/riscv/kernel/entry.S                     |  24 +--
>  arch/riscv/kernel/head.S                      |   8 +-
>  arch/riscv/kernel/process.c                   |   8 +-
>  arch/riscv/kernel/sbi.c                       |  24 +--
>  arch/riscv/kernel/signal.c                    |   6 +-
>  arch/riscv/kernel/traps.c                     |   4 +-
>  arch/riscv/kernel/vdso.c                      |   4 +-
>  arch/riscv/kernel/vdso/Makefile               | 176 ++++++++++++------
>  ..._vdso_offsets.sh => gen_vdso32_offsets.sh} |   2 +-
>  .../gen_vdso64_offsets.sh}                    |   2 +-
>  arch/riscv/kernel/vdso/vgettimeofday.c        |  39 +++-
>  arch/riscv/kernel/vdso32.S                    |   8 +
>  arch/riscv/kernel/{vdso/vdso.S => vdso64.S}   |   8 +-
>  arch/riscv/kvm/Kconfig                        |   1 +
>  arch/riscv/lib/Makefile                       |   1 +
>  arch/riscv/lib/memset.S                       |   4 +-
>  arch/riscv/mm/context.c                       |  16 +-
>  arch/riscv/mm/fault.c                         |  13 +-
>  arch/riscv/mm/init.c                          |  29 ++-
>  arch/riscv/net/Makefile                       |   6 +-
>  arch/riscv/net/bpf_jit_comp64.c               |  10 +-
>  drivers/clocksource/timer-riscv.c             |   2 +-
>  drivers/irqchip/irq-riscv-intc.c              |   4 +-
>  fs/namei.c                                    |   2 +-
>  58 files changed, 675 insertions(+), 317 deletions(-)
>  create mode 100644 arch/riscv/configs/64ilp32.config
>  delete mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
>  delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/note.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S
>  rename arch/riscv/kernel/vdso/{gen_vdso_offsets.sh => gen_vdso32_offsets.sh} (78%)
>  rename arch/riscv/kernel/{compat_vdso/gen_compat_vdso_offsets.sh => vdso/gen_vdso64_offsets.sh} (77%)
>  create mode 100644 arch/riscv/kernel/vdso32.S
>  rename arch/riscv/kernel/{vdso/vdso.S => vdso64.S} (73%)

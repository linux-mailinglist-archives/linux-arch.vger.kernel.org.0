Return-Path: <linux-arch+bounces-194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C97E95FB
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 05:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDB3B20AA8
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05029C2CD;
	Mon, 13 Nov 2023 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN7EqhIc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB213C150
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 04:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA4CC433C7;
	Mon, 13 Nov 2023 04:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699848796;
	bh=v4Yj/g4pflokBH655TaMYBcH7BjZ1pL0mnIPrMUaX90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN7EqhIcroBLmcD8x3VcLS5kfTBv8Ttx6iitremGlgHG9zHyO/NY0iSQgKqUsLaKy
	 xXCRWcwy/xOH6pKTk5dC0NnPEJycDBrJcP02+7oGQLOTwzGfAUfOICmynXXwfIksnE
	 e7R33/9X3X1eUu2NlI1ibJ5++p/zGpl4BT2DatKVjycZ+M7yBpIppZ08B+oU3DjaVV
	 hY9L+5zYD8tdeVkUkx7vKiB48TCFVKhXpxLwtolWTfvqv2wyvB0BuyqbJjkqpUgsfo
	 stEQoi7KCxVMq8TFtKVJoEB8jPQ3H1khB/u1FR8lyAHDu5jcgDRBLw+ZCzjVFugo2a
	 Rq91I+HxgsevQ==
Date: Sun, 12 Nov 2023 23:13:06 -0500
From: Guo Ren <guoren@kernel.org>
To: arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
	conor.dooley@microchip.com, heiko@sntech.de,
	apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
	paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
	andy.chiu@sifive.com, vincent.chen@sifive.com,
	greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
	luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RFC PATCH V2 00/38] rv64ilp32: Running ILP32 on RV64 ISA
Message-ID: <ZVGiUl4YhcqxHHYv@gmail.com>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>

On Sun, Nov 12, 2023 at 01:14:36AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This patch series adds s64ilp32 & u64ilp32 support to riscv. The term
> s64ilp32 means smode-xlen=64 and -mabi=ilp32 (ints, longs, and pointers
> are all 32-bit) and u64ilp32 means umode-xlen=64 and -mabi=ilp32, i.e.,
> running 32-bit Linux kernel on 64-bit supervisor mode or running 32-bit
> Linux applications on 32-bit user mode. There have been many 64ilp32
> abis existing, such as mips-n32 [1], arm-aarch64ilp32 [2], and x86-x32
> [3], but they are all about userspace. Thus, this should be the first
> time running a 32-bit Linux kernel with the 64ilp32 ABI at supervisor
> mode (If not, correct me).
> 
>  +--------------------------------+------------+
>  | +-------------------+--------+ | +--------+ |
>  | |           (compat)|(compat)| | |        | |
>  | |u64lp64    u64ilp32|u32ilp32| | |u32ilp32| | ABI
>  | |           ^^^^^^^^|        | | |        | |
>  | +-------------------+--------+ | +--------+ |
>  | +-------------------+--------+ | +--------+ |
>  | |       UXL=64      | UXL=32 | | | UXL=32 | | ISA
>  | +-------------------+--------+ | +--------+ |
>  +--------------------------------+------------+-------
>  | +----------------------------+ | +--------+ |
>  | |            64BIT           | | |   32BIT| | Kernel
>  | |     s64lp64 & s64ilp32     | | |s32ilp32| | ABI
>  | |               ^^^^^^^^     | | |        | |
>  | +----------------------------+ | +--------+ |
>  | +----------------------------+ | +--------+ |
>  | |            SXL=64          | | | SXL=32 | | ISA
>  | +----------------------------+ | +--------+ |
>  +--------------------------------+------------+
> 
> Motivation:
> ===========
> The current RISC-V has the 64-bit ISA profiles of RVA20, RVA22, and RVA23
> (ongoing) [4], but no 32-bit RVA profile exists or any ongoing plan. That
> means when a vendor wants to produce a 32-bit ISA RISC-V Application
> Processor, they have no shape to follow. Therefore, many cheap riscv
> chips have come out but follow the 64-bit RVA profiles, such as Allwinner
> D1/D1s/F133 [5], SOPHGO CV1800B [6], Canaan Kendryte k230 [7], and
> Bouffalo Lab BL808[3] which are typically cortex-a7 (arm 32-bit) product
> scenarios. So running ILP32 on rv64 ISA is the only choice for these
> chips.
> 
> The ilp32 and lp64 have different scenarios, but if the address space
> and data range are under 2GB. The ilp32, compared to the lp64, has three
> advantages:
>  - Better memory footprint cost.
>  - Better benchmark performance (SPEC CPU 2006/2017).
>  - Compatible with ilp32 code.
> 
> Memory Footprint
> ================
> rv64lp64 has 25% more memory footprint than rv64ilp32!
> 
> Calculation Process:
>  rv64lp64  = (4096 - 3407) = 689
>  rv64ilp32 = (4096 - 3231) = 865
Correct:
   rv64ilp32 = (4096 - 3407) = 689
   rv64lp64  = (4096 - 3231) = 865

>  (865 - 689)/689 = 25.54426%
> 
> Here are the ILP32 v.s. LP64 Linux kernel data type comparison:
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
> the comparison log between rv64ilp32 and rv64lp64 in the same 20MB(16MB
> for Linux) qemu system environment:
> 
> rv64ilp32:
>  Memory: 14008K/16384K available (1253K kernel code, 474K rwdata, 114K
>  rodata, 134K init, 192K bss, 2376K reserved, 0K cma-reserved)
>  Mem-Info:
>  active_anon:0 inactive_anon:0 isolated_anon:0
>   active_file:0 inactive_file:0 isolated_file:0
>   unevictable:0 dirty:0 writeback:0
>   slab_reclaimable:0 slab_unreclaimable:47
>   mapped:0 shmem:0 pagetables:0
>   sec_pagetables:0 bounce:0
>   kernel_misc_reclaimable:0
>   free:3407 free_pcp:45 free_cma:0
>   ^^^^^^^^^
>  Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
>  inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
>  mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB
>  kernel_stack:104kB pagetables:0kB sec_pagetabl
>  es:0kB all_unreclaimable? no
>  Normal free:13628kB boost:0kB min:472kB low:588kB high:704kB
>  reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>  active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>  present:16384kB managed:14140kB mlocked:0kB bounce:0
>  kB free_pcp:180kB local_pcp:180kB free_cma:0kB
>  lowmem_reserve[]: 0 0
>  Normal: 3*4kB (UM) 2*8kB (M) 2*16kB (M) 2*32kB (M) 3*64kB (M) 2*128kB
>  (UM) 3*256kB (M) 4*512kB (UM) 2*1024kB (UM) 2*2048kB (UM) 1*4096kB (M) =
>  13628kB
>  0 total pagecache pages
>  4096 pages RAM
>  0 pages HighMem/MovableOnly
>  561 pages reserved
> 
> rv64lp64:
>  Memory: 13776K/16384K available (1234K kernel code, 539K rwdata, 129K
>  rodata, 161K init, 207K bss, 2608K reserved, 0K cma-reserved)
>  Mem-Info:
>  active_anon:0 inactive_anon:0 isolated_anon:0
>   active_file:0 inactive_file:0 isolated_file:0
>   unevictable:0 dirty:0 writeback:0
>   slab_reclaimable:0 slab_unreclaimable:69
>   mapped:0 shmem:0 pagetables:1
>   sec_pagetables:0 bounce:0
>   kernel_misc_reclaimable:0
>   free:3231 free_pcp:55 free_cma:0
>   ^^^^^^^^^
>  Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB
>  inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
>  mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB
>  kernel_stack:208kB pagetables:4kB sec_pagetabl
>  es:0kB all_unreclaimable? no
>  Normal free:12924kB boost:0kB min:468kB low:584kB high:700kB
>  reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
>  active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB
>  present:16384kB managed:13936kB mlocked:0kB bounce:0
>  kB free_pcp:220kB local_pcp:220kB free_cma:0kB
>  lowmem_reserve[]: 0 0
>  Normal: 3*4kB (UM) 4*8kB (UM) 3*16kB (M) 3*32kB (UM) 1*64kB (M) 3*128kB
>  (UM) 2*256kB (M) 3*512kB (M) 2*1024kB (UM) 2*2048kB (UM) 1*4096kB (M) =
>  12924kB
>  0 total pagecache pages
>  4096 pages RAM
>  0 pages HighMem/MovableOnly
>  612 pages reserved
> 
> Why rv64 isa?
> ==============
> Generally speaking, we should build a 32-bit hardware s-mode to run
> 32-bit Linux on a 64/32-bit processor (such as cortex-a35/a53).
> But, it can't reuse performance-related features and instructions of
> the 64-bit hardware, such as 64-bit ALU, AMO, and LD/SD, which would
> cause significant performance gaps on many Linux kernel features:
> 
>  - memcpy/memset/strcmp (s64ilp32 has half of the instructions count
>    and double the bandwidth of load/store instructions than s32ilp32.)
> 
>  - ebpf JIT is a 64-bit Language virtual machine ISA, which is not
>    suitable for mapping to s32ilp32.
> 
>  - Atomic64 (s64ilp32 has the exact native instructions mapping as
>    s64lp64, but s32ilp32 only uses generic_atomic64, a tradeoff &
>    limited software solution.)
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
> Simplifies CPU Design
> =====================
> Yes, there are a lot of runing 32-bit Linux on 64-bit hardware examples
> in history, such as arm cortex a35/a53/a55, which implements the 32-bit
> EL1/EL2/EL3 hardware mode to support 32-bit Linux. We could follow Arm's
> style, but riscv could choose another better way. Compared to UXL=32,
> the MXL=SXL=32 has many CSR-related hardware functionalities, which
> causes a lot of effort to mix them into 64-bit hardware. The s64ilp32
> works on MXL=SXL=64 mode, so the CPU vendors needn't implement 32-bit
> machine and supervisor modes.
> 
> How does rv64ilp32 work?
> ========================
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
> v6.5-rc1 + patches
> cd linux
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- rv64ilp32_defconfig
> make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- all
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
> Patch organization
> ==================
> PATCH [ 1-11] u64ilp32: User space support
> PATCH [12-36] adds time-related vDSO common flow for vdso32
Correct:
  PATCH [12-36] s64ilp32: Add s64ip32 linux kernel support
> PATCH [37] Add tiny defconfig for ilp32 v.s. lp64
> PATCH [38] Unify ilp32 & lp64 configs and memory 
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
>  - GNU:			LiaoShihua <shihua@iscas.ac.cn>
> 			Jiawe Chen<jiawei@iscas.ac.cn>
>  - Qemu:		Weiwei Li <liweiwei@iscas.ac.cn>
>  - Benchmark:		Junqiang Wang <wangjunqiang@iscas.ac.cn> 
> 			XiaoOu Chen <chenxiaoou@iscas.ac.cn>
>  - Fedora:		Wei Fu <wefu@redhat.com>
> 			Songsong Zhang <U2FsdGVkX1@gmail.com>
> 
> References
> ==========
> [1] https://techpubs.jurassic.nl/manuals/0630/developer/Mpro_...
> [2] https://wiki.debian.org/Arm64ilp32Port
> [3] https://lwn.net/Articles/456731/
> [4] https://github.com/riscv/riscv-profiles/releases
> [5] https://www.cnx-software.com/2021/10/25/allwinner-d1s-f13...
> [6] https://milkv.io/duo/
> [7] https://twitter.com/tphuang/status/1631308330256801793
> [8] https://www.cnx-software.com/2022/12/02/pine64-ox64-sbc-b...
> 
> Changelog:
> V2:
>  - Add u64ilp32 support
>  - Rebase v6.5-rc1
>  - Enable 64ilp32 vgettimeofday for benchmarking
> 
> V1:
> https://lore.kernel.org/linux-riscv/20230518131013.3366406-1-guoren@kernel.org/
> 
> Guo Ren (38):
>   riscv: u64ilp32: Unify vdso32 & compat_vdso into vdso/Makefile
>   riscv: u64ilp32: Remove compat_vdso/
>   riscv: u64ilp32: Add time-related vDSO common flow for vdso32
>   riscv: u64ilp32: Introduce ILP32 vdso for UXL=64
>   riscv: u64ilp32: Adjust vDSO kernel flow for 64ilp32 abi
>   riscv: u64ilp32: Add signal support for compat
>   riscv: u64ilp32: Add ptrace interface support
>   riscv: u64ilp32: Adjust vDSO alternative for 64ilp32 abi
>   riscv: u64ilp32: Add xlen_t in user_regs_struct
>   riscv: u64ilp32: Remove the restriction of UXL=32
>   riscv: u64ilp32: Enable user space runtime switch
>   riscv: s64ilp32: Unify ULL & UL into UXL in csr
>   riscv: s64ilp32: Introduce xlen_t for 64ILP32 kernel
>   riscv: s64ilp32: Add sbi support
>   riscv: s64ilp32: Add asid support
>   riscv: s64ilp32: Introduce PTR_L and PTR_S
>   riscv: s64ilp32: Adjust TASK_SIZE for s64ilp32 kernel
>   riscv: s64ilp32: Add ebpf jit support
>   riscv: s64ilp32: Add ELF32 support
>   riscv: s64ilp32: Add ARCH_RV64ILP32 Kconfig option
>   riscv: s64ilp32: Add MMU_SV32 mode support
>   riscv: s64ilp32: Add MMU_SV39 mode support
>   riscv: s64ilp32: Enable native atomic64
>   riscv: s64ilp32: Add TImode (128 int) support
>   riscv: s64ilp32: Implement cmpxchg_double
>   riscv: s64ilp32: Disable KVM
>   riscv: s64ilp32: Correct the rv64ilp32 stackframe layout
>   riscv: s64ilp32: Temporary workaround solution to gcc problem
>   riscv: s64ilp32: Introduce ARCH_HAS_64ILP32_KERNEL for syscall
>   riscv: s64ilp32: Add u32ilp32 ptrace support
>   riscv: s64ilp32: Add u32ilp32 signal support
>   riscv: s64ilp32: Validate harts by architecture name
>   riscv: s64ilp32: Add rv64ilp32_defconfig
>   riscv: Cleanup rv32_defconfig
>   clocksource: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
>   irqchip: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
>   add tinylab defconfig
>   64ilp32 v.s. 64lp64
> 
>  arch/Kconfig                                  |  10 +
>  arch/riscv/Kconfig                            |  49 +++-
>  arch/riscv/Kconfig.errata                     |   2 +-
>  arch/riscv/Makefile                           |  28 ++-
>  arch/riscv/configs/32-bit.config              |   2 -
>  arch/riscv/configs/64ilp32.config             |   2 +
>  arch/riscv/configs/tinylab32ilp32_defconfig   |  88 +++++++
>  arch/riscv/configs/tinylab64ilp32_defconfig   |  89 +++++++
>  arch/riscv/configs/tinylab_defconfig          |  89 +++++++
>  arch/riscv/include/asm/asm.h                  |   5 +
>  arch/riscv/include/asm/atomic.h               |   6 +
>  arch/riscv/include/asm/cmpxchg.h              |  53 ++++
>  arch/riscv/include/asm/cpu_ops_sbi.h          |   4 +-
>  arch/riscv/include/asm/csr.h                  | 189 +++++++-------
>  arch/riscv/include/asm/elf.h                  |   7 +-
>  arch/riscv/include/asm/extable.h              |   2 +-
>  arch/riscv/include/asm/module.h               |  30 +++
>  arch/riscv/include/asm/page.h                 |  26 +-
>  arch/riscv/include/asm/pgtable-64.h           |  50 ++--
>  arch/riscv/include/asm/pgtable.h              |  26 +-
>  arch/riscv/include/asm/processor.h            |   8 +-
>  arch/riscv/include/asm/ptrace.h               |  96 ++++----
>  arch/riscv/include/asm/sbi.h                  |  24 +-
>  arch/riscv/include/asm/signal32.h             |  11 +-
>  arch/riscv/include/asm/stacktrace.h           |   6 +
>  arch/riscv/include/asm/syscall.h              |   2 +-
>  arch/riscv/include/asm/thread_info.h          |   1 +
>  arch/riscv/include/asm/timex.h                |  10 +-
>  arch/riscv/include/asm/tlbflush.h             |   2 +-
>  arch/riscv/include/asm/vdso.h                 |  34 ++-
>  arch/riscv/include/asm/vdso/gettimeofday.h    |  95 +++++++
>  arch/riscv/include/uapi/asm/elf.h             |   2 +-
>  arch/riscv/include/uapi/asm/ptrace.h          |  72 +++---
>  arch/riscv/include/uapi/asm/unistd.h          |   1 +
>  arch/riscv/kernel/Makefile                    |   5 +-
>  arch/riscv/kernel/alternative.c               |  50 +++-
>  arch/riscv/kernel/compat_signal.c             |  23 +-
>  arch/riscv/kernel/compat_vdso/.gitignore      |   2 -
>  arch/riscv/kernel/compat_vdso/compat_vdso.S   |   8 -
>  .../kernel/compat_vdso/compat_vdso.lds.S      |   3 -
>  arch/riscv/kernel/compat_vdso/flush_icache.S  |   3 -
>  arch/riscv/kernel/compat_vdso/getcpu.S        |   3 -
>  arch/riscv/kernel/compat_vdso/note.S          |   3 -
>  arch/riscv/kernel/compat_vdso/rt_sigreturn.S  |   3 -
>  arch/riscv/kernel/cpu.c                       |   9 +-
>  arch/riscv/kernel/cpu_ops_sbi.c               |   4 +-
>  arch/riscv/kernel/entry.S                     |  24 +-
>  arch/riscv/kernel/head.S                      |   8 +-
>  arch/riscv/kernel/process.c                   |  10 +-
>  arch/riscv/kernel/ptrace.c                    |   9 +-
>  arch/riscv/kernel/sbi.c                       |  24 +-
>  arch/riscv/kernel/signal.c                    |  79 ++++--
>  arch/riscv/kernel/traps.c                     |   4 +-
>  arch/riscv/kernel/vdso.c                      | 102 ++++++--
>  arch/riscv/kernel/vdso/Makefile               | 232 ++++++++++++++----
>  ..._vdso_offsets.sh => gen_vdso32_offsets.sh} |   2 +-
>  .../gen_vdso64_offsets.sh}                    |   2 +-
>  .../kernel/vdso/gen_vdso64ilp32_offsets.sh    |   5 +
>  arch/riscv/kernel/vdso/vdso.lds.S             |   2 -
>  arch/riscv/kernel/vdso/vgettimeofday.c        |  39 ++-
>  arch/riscv/kernel/vdso32.S                    |   8 +
>  arch/riscv/kernel/{vdso/vdso.S => vdso64.S}   |   8 +-
>  arch/riscv/kernel/vdso64ilp32.S               |   8 +
>  arch/riscv/kernel/vector.c                    |   2 +-
>  arch/riscv/kvm/Kconfig                        |   1 +
>  arch/riscv/lib/Makefile                       |   1 +
>  arch/riscv/lib/memset.S                       |   4 +-
>  arch/riscv/mm/context.c                       |  16 +-
>  arch/riscv/mm/fault.c                         |  13 +-
>  arch/riscv/mm/init.c                          |  24 +-
>  arch/riscv/net/Makefile                       |   6 +-
>  arch/riscv/net/bpf_jit_comp64.c               |   6 +-
>  drivers/clocksource/timer-riscv.c             |   2 +-
>  drivers/irqchip/irq-riscv-intc.c              |   9 +-
>  fs/namei.c                                    |   2 +-
>  fs/open.c                                     |  22 ++
>  fs/read_write.c                               |  17 ++
>  fs/sync.c                                     |  22 ++
>  include/linux/syscalls.h                      |  35 ++-
>  init/main.c                                   |   2 +
>  kernel/signal.c                               |  24 +-
>  mm/fadvise.c                                  |  24 ++
>  82 files changed, 1526 insertions(+), 509 deletions(-)
>  create mode 100644 arch/riscv/configs/64ilp32.config
>  create mode 100644 arch/riscv/configs/tinylab32ilp32_defconfig
>  create mode 100644 arch/riscv/configs/tinylab64ilp32_defconfig
>  create mode 100644 arch/riscv/configs/tinylab_defconfig
>  delete mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
>  delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/note.S
>  delete mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S
>  rename arch/riscv/kernel/vdso/{gen_vdso_offsets.sh => gen_vdso32_offsets.sh} (78%)
>  rename arch/riscv/kernel/{compat_vdso/gen_compat_vdso_offsets.sh => vdso/gen_vdso64_offsets.sh} (77%)
>  create mode 100755 arch/riscv/kernel/vdso/gen_vdso64ilp32_offsets.sh
>  create mode 100644 arch/riscv/kernel/vdso32.S
>  rename arch/riscv/kernel/{vdso/vdso.S => vdso64.S} (73%)
>  create mode 100644 arch/riscv/kernel/vdso64ilp32.S
> 
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


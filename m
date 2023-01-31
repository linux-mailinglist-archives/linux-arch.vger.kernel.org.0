Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A368343C
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 18:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAaRrs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjAaRrr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 12:47:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC08D4212;
        Tue, 31 Jan 2023 09:47:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3989AB81E3B;
        Tue, 31 Jan 2023 17:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86990C433D2;
        Tue, 31 Jan 2023 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675187255;
        bh=QnwKwH3HYANM+Aq3C3nM0Et17hsNKdeqy3Lzqr3Z7m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+wa8ybzSNBVFhkCRA8ORE+GN31Fu4zmd3dvodkx9KohpJVvkpvRngWxKo8M7cLHT
         zobwTrLkBJ/kLrv+j7wRNA5VdhsSrItpd+pqcHOm/kKMxs/9pAU9T+ysfAe6dDM2/k
         GP6PPYJpdR4EwYLIVD6gMseYxQtyFnypmzkuOUIX+MXlBitICMk/wcg+Xr/uQAIde1
         F7J53QSE0kJXZ5cS3BMulukNzTdQo9H8A/0mzHsgAE8xwg6h4l2TFlMZXP15bL/G+C
         hPYRq/xn+ITVw2dq65uAazMQdbJmeil11o6WnYj3PRtDlCyjZSIM2cM6LfKBCcfB1r
         mfY8Ls5utZDGA==
Date:   Tue, 31 Jan 2023 17:47:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Message-ID: <Y9lULIIOneBUFE/E@spud>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wH8cft02OMY4GuQp"
Content-Disposition: inline
In-Reply-To: <20230129124235.209895-5-rppt@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--wH8cft02OMY4GuQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mike,

On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>=20
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>=20
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions.
>=20
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Guo Ren <guoren@kernel.org>		# csky
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>	# LoongArch
> Acked-by: Stafford Horne <shorne@gmail.com>	# OpenRISC

Hmm, so this landed in linux-next today and I bisected a boot failure in
my CI to it. However, I am not really sure if it is a real issue worth
worrying about as the platform it triggered on is supposed to be using
SPARSEMEM, but isn't.
I had thought that my CI was using a config with SPARSEMEM since that
became required for riscv defconfig builds to boot in v6.1-rc1, but I
must have just forgotten to add it to my $platform_defconfig builds too.
However, those $platform_defconfig builds continued booting without
SPARSEMEM enabled until today.
for $platform_defconfig builds I now see the following, which is in turn
followed by an opps. The full output is at the bottom of this mail.

	WARNING: CPU: 0 PID: 0 at mm/vmalloc.c:479 __vmap_pages_range_noflush+0x2d=
4/0x4c8
	Modules linked in:
	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc4-00538-g6e265f6be0c8 #1
	Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
	epc : __vmap_pages_range_noflush+0x2d4/0x4c8
	 ra : __vmap_pages_range_noflush+0x3e0/0x4c8
	epc : ffffffff801461e4 ra : ffffffff801462f0 sp : ffffffff81203b90
	 gp : ffffffff812e9fe0 tp : ffffffff8120fa80 t0 : ffffffe7bfe57000
	 t1 : ffffffffffff8000 t2 : 00000000000001a7 s0 : ffffffff81203c50
	 s1 : ffffffe7bfe56040 a0 : 0000000000000000 a1 : ffffffe7c7df2840
	 a2 : ffffffff812ebae8 a3 : 0000000000001000 a4 : 0000000000080200
	 a5 : 0000000000fffe00 a6 : 0000000001040056 a7 : ffffffffffffffff
	 s2 : 0000000001040024 s3 : ffffffff80de1118 s4 : ffffffc80400c000
	 s5 : ffffffc80400c000 s6 : 00000000000000e7 s7 : 0000000000000000
	 s8 : ffffffc80400bfff s9 : 00fffffffffff000 s10: ffffffc804008000
	 s11: ffffffe7bfe0d100 t3 : 0000000000000000 t4 : fffffffffff00000
	 t5 : 00000000000f0000 t6 : ffffffe7bfe22ac4
	status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
	[<ffffffff8014762a>] __vmalloc_node_range+0x392/0x52e
	[<ffffffff8000dfc4>] copy_process+0x636/0x1196
	[<ffffffff8000ec42>] kernel_clone+0x4a/0x2f4
	[<ffffffff8000f15e>] user_mode_thread+0x7c/0x9a
	[<ffffffff8077056e>] rest_init+0x28/0xea
	[<ffffffff80800670>] arch_post_acpi_subsys_init+0x0/0x18
	[<ffffffff80800de4>] start_kernel+0x72c/0x75c

In my mind, there's a kernel misconfiguration issue, but it's not the
same splat as I used to get when using FLATMEM in this configuration:
	OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
	Machine model: Microchip PolarFire-SoC Icicle Kit
	earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '115200n8')
	printk: bootconsole [ns16550a0] enabled
	printk: debug: skip boot console de-registration.
	efi: UEFI not found.
	Zone ranges:
	  DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
	  Normal   [mem 0x0000000100000000-0x000000107fffffff]
	Movable zone start for each node
	Early memory node ranges
	  node   0: [mem 0x0000000080200000-0x00000000bfbfffff]
	  node   0: [mem 0x00000000bfc00000-0x00000000bfffffff]
	  node   0: [mem 0x0000001040000000-0x000000107fffffff]
	Initmem setup node 0 [mem 0x0000000080200000-0x000000107fffffff]
	Kernel panic - not syncing: Failed to allocate 1073741824 bytes for node 0=
 memory map
	CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-dirty #1
	Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
	Call Trace:
	[<ffffffff800057f0>] show_stack+0x30/0x3c
	[<ffffffff807d5802>] dump_stack_lvl+0x4a/0x66
	[<ffffffff807d5836>] dump_stack+0x18/0x20
	[<ffffffff807d1ae8>] panic+0x124/0x2c6
	[<ffffffff80814064>] free_area_init_core+0x0/0x11e
	[<ffffffff80813720>] free_area_init_node+0xc2/0xf6
	[<ffffffff8081331e>] free_area_init+0x222/0x260
	[<ffffffff808064d6>] misc_mem_init+0x62/0x9a
	[<ffffffff80803cb2>] setup_arch+0xb0/0xea
	[<ffffffff8080039a>] start_kernel+0x88/0x4ee

Turning on SPARSEMEM fixes both problems, but I'm just not sure if there
is some underlying issue here that I don't know enough about the area to
understand.

Thanks,
Conor.

[    0.000000] Linux version 6.2.0-rc4-00538-g6e265f6be0c8 (conor@wendy) (r=
iscv64-unknown-linux-gnu-gcc (g5964b5cd727)
 11.1.0, GNU ld (GNU Binutils) 2.37) #1 SMP PREEMPT @7
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
[    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
[    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '1=
15200n8')
[    0.000000] printk: bootconsole [ns16550a0] enabled
[    0.000000] printk: debug: skip boot console de-registration.
[    0.000000] efi: UEFI not found.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfbfffff]
[    0.000000]   node   0: [mem 0x00000000bfc00000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x0000001040000000-0x000000107fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x000000107ffff=
fff]
[    0.000000] On node 0, zone Normal: 15990272 pages in unavailable ranges
[    0.000000] SBI specification v0.3 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10000
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI HSM extension detected
[    0.000000] CPU with hartid=3D0 is not available
[    0.000000] CPU with hartid=3D0 is not available
[    0.000000] CPU with hartid=3D0 is not available
[    0.000000] riscv: base ISA extensions acdfim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 19 pages/cpu s37048 r8192 d32584 u77824
[    0.000000] CPU node for /cpus/cpu@0 exist but the possible cpu range is=
 :0-3
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 294407
[    0.000000] Kernel command line: earlycon keep_bootcon reboot=3Dcold
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 b=
ytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 by=
tes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 4.
[    0.000000] software IO TLB: mapped [mem 0x00000000bbc00000-0x00000000bf=
c00000] (64MB)
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (20=
48 kB)
[    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  =
16 MB)
[    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (40=
96 MB)
[    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  =
64 GB)
[    0.000000]      modules : 0xffffffff01352000 - 0xffffffff80000000   (20=
28 MB)
[    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffe7ffe00000   (  =
63 GB)
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (20=
47 MB)
[    0.000000] Memory: 1067600K/2095104K available (7639K kernel code, 4898=
K rwdata, 4096K rodata, 2183K init, 410K bss, 1027504K reserved, 0K cma-res=
erved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_id=
s=3D4.
[    0.000000] rcu:     RCU debug extended QS entry/exit.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] CPU with hartid=3D0 is not available
[    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt=
-controller
[    0.000000] riscv-intc: 64 local interrupts mapped
[    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts wi=
th 4 handlers for 9 contexts.
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] riscv-timer: riscv_timer_init_dt: Registering clocksource cp=
uid [0] hartid [1]
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
[    0.000004] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps ev=
ery 2199023255500ns
[    0.009687] Console: colour dummy device 80x25
[    0.014654] printk: console [tty0] enabled
[    0.019313] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 2.00 BogoMIPS (lpj=3D4000)
[    0.030490] pid_max: default: 32768 minimum: 301
[    0.036094] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes,=
 linear)
[    0.044458] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 b=
ytes, linear)
[    0.055493] ------------[ cut here ]------------
[    0.060606] WARNING: CPU: 0 PID: 0 at mm/vmalloc.c:479 __vmap_pages_rang=
e_noflush+0x2d4/0x4c8
[    0.070040] Modules linked in:
[    0.073421] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.2.0-rc4-00538-g6=
e265f6be0c8 #1
[    0.082157] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.088972] epc : __vmap_pages_range_noflush+0x2d4/0x4c8
[    0.094838]  ra : __vmap_pages_range_noflush+0x3e0/0x4c8
[    0.100707] epc : ffffffff801461e4 ra : ffffffff801462f0 sp : ffffffff81=
203b90
[    0.108674]  gp : ffffffff812e9fe0 tp : ffffffff8120fa80 t0 : ffffffe7bf=
e57000
[    0.116643]  t1 : ffffffffffff8000 t2 : 00000000000001a7 s0 : ffffffff81=
203c50
[    0.124611]  s1 : ffffffe7bfe56040 a0 : 0000000000000000 a1 : ffffffe7c7=
df2840
[    0.132588]  a2 : ffffffff812ebae8 a3 : 0000000000001000 a4 : 0000000000=
080200
[    0.140564]  a5 : 0000000000fffe00 a6 : 0000000001040056 a7 : ffffffffff=
ffffff
[    0.148541]  s2 : 0000000001040024 s3 : ffffffff80de1118 s4 : ffffffc804=
00c000
[    0.156518]  s5 : ffffffc80400c000 s6 : 00000000000000e7 s7 : 0000000000=
000000
[    0.164495]  s8 : ffffffc80400bfff s9 : 00fffffffffff000 s10: ffffffc804=
008000
[    0.172472]  s11: ffffffe7bfe0d100 t3 : 0000000000000000 t4 : ffffffffff=
f00000
[    0.180449]  t5 : 00000000000f0000 t6 : ffffffe7bfe22ac4
[    0.186317] status: 0000000200000120 badaddr: 0000000000000000 cause: 00=
00000000000003
[    0.195060] [<ffffffff8014762a>] __vmalloc_node_range+0x392/0x52e
[    0.201802] [<ffffffff8000dfc4>] copy_process+0x636/0x1196
[    0.207878] [<ffffffff8000ec42>] kernel_clone+0x4a/0x2f4
[    0.213755] [<ffffffff8000f15e>] user_mode_thread+0x7c/0x9a
[    0.219918] [<ffffffff8077056e>] rest_init+0x28/0xea
[    0.225429] [<ffffffff80800670>] arch_post_acpi_subsys_init+0x0/0x18
[    0.232460] [<ffffffff80800de4>] start_kernel+0x72c/0x75c
[    0.238434] ---[ end trace 0000000000000000 ]---
n):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shme=
m_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stac=
k:0kB pagetables:4kB sec_pagetables:0kB all_unreclaimable? no
[    0.423801] DMA32 free:940780kB boost:0kB min:0kB low:0kB high:0kB reser=
ved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inacti=
ve_file:0kB unevictable:0kB writepending:0kB present:1046528kB managed:9407=
80kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    0.452034] lowmem_reserve[]: 0 0 0
[    0.455919] Normal free:126248kB boost:0kB min:0kB low:0kB high:0kB rese=
rved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inact=
ive_file:0kB unevictable:0kB writepending:0kB present:1048576kB managed:126=
820kB mlocked:0kB bounce:0kB free_pcp:156kB local_pcp:156kB free_cma:0kB
[    0.484652] lowmem_reserve[]: 0 0 0
[    0.488538] DMA32: 1*4kB (M) 1*8kB (M) 0*16kB 1*32kB (M) 1*64kB (M) 1*12=
8kB (M) 0*256kB 1*512kB (M) 0*1024kB 1*2048kB (M) 229*4096kB (M) =3D 940780=
kB
[    0.503367] Normal: 2*4kB (ME) 0*8kB 2*16kB (UE) 2*32kB (ME) 3*64kB (UME=
) 0*128kB 2*256kB (ME) 3*512kB (UME) 3*1024kB (UME) 3*2048kB (UME) 28*4096k=
B (M) =3D 126248kB
[    0.519722] 0 total pagecache pages
[    0.523579] 0 pages in swap cache
[    0.527264] Free swap  =3D 0kB
[    0.530445] Total swap =3D 0kB
[    0.533652] 523776 pages RAM
[    0.536833] 0 pages HighMem/MovableOnly
[    0.541090] 256876 pages reserved
[    0.544833] Unable to handle kernel NULL pointer dereference at virtual =
address 000000000000003c
[    0.554576] Oops [#1]
[    0.557092] Modules linked in:
[    0.560470] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6=
=2E2.0-rc4-00538-g6e265f6be0c8 #1
[    0.570841] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.577664] epc : rest_init+0x44/0xea
[    0.581726]  ra : rest_init+0x44/0xea
[    0.585788] epc : ffffffff8077058a ra : ffffffff8077058a sp : ffffffff81=
203f70
[    0.593764]  gp : ffffffff812e9fe0 tp : ffffffff8120fa80 t0 : 0000000000=
000000
[    0.601741]  t1 : 0000000000000000 t2 : 0000000000000040 s0 : ffffffff81=
203f90
[    0.609718]  s1 : fffffffffffffff4 a0 : 0000000000000000 a1 : ffffffffff=
fffff4
[    0.617695]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000=
000000
[    0.625672]  a5 : 0000000000000000 a6 : 0000000001212dec a7 : ffffffffd8=
bc86ae
[    0.633649]  s2 : ffffffff80de0bf0 s3 : ffffffe7c7de7700 s4 : 0000000000=
000000
[    0.641626]  s5 : ffffffff812eb018 s6 : ffffffff80a00008 s7 : 0000000000=
000000
[    0.649603]  s8 : 00000000bfb85036 s9 : 0000000000000000 s10: 0000000000=
000000
[    0.657580]  s11: 0000000000000000 t3 : 0000000000000002 t4 : 0000000000=
000402
[    0.665557]  t5 : ffffffff812158a8 t6 : 0000000000000000
[    0.671416] status: 0000000200000120 badaddr: 000000000000003c cause: 00=
0000000000000d
[    0.680157] [<ffffffff80800670>] arch_post_acpi_subsys_init+0x0/0x18
[    0.687188] [<ffffffff80800de4>] start_kernel+0x72c/0x75c
[    0.693195] ---[ end trace 0000000000000000 ]---
[    0.698325] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.705729] ---[ end Kernel panic - not syncing: Attempted to kill the i=
dle task! ]---

--wH8cft02OMY4GuQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9lT8gAKCRB4tDGHoIJi
0tpsAQCFNq+12KVPvP/QGa4Em/waus0GSj+fXuGM4H+0ljxq6wD/QxvrvVnLjF+J
9MwIWBS7kUGSsCtmh64UcSw/gN1bPAw=
=cG1J
-----END PGP SIGNATURE-----

--wH8cft02OMY4GuQp--

Return-Path: <linux-arch+bounces-464-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D47F9506
	for <lists+linux-arch@lfdr.de>; Sun, 26 Nov 2023 20:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BBE1C2074B
	for <lists+linux-arch@lfdr.de>; Sun, 26 Nov 2023 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5511C93;
	Sun, 26 Nov 2023 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRUyYU9I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE411708;
	Sun, 26 Nov 2023 19:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD83C433C7;
	Sun, 26 Nov 2023 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701026688;
	bh=+Ib51J32sC6CohxpGKJ6GacdVZWJlO3V2k4CZyMRG+A=;
	h=Date:From:To:Subject:Reply-To:From;
	b=bRUyYU9Iy6+kLo0xUqbvf5i3wK7tmfoDgIqegDXufzRKY8k+AZbU6noN8/Rm8LFYr
	 ypOWGRKeLHjb5g9xxQJAxM0u9zVu6HxSz0kPFNlC9OnQPtsD8m9RIVmr5MXpDixrlP
	 86fLQ3PulATUmhbLecjpCVXKzz5psOJ+vMAnKB4gVK6hKbqPaagPjTdbj8k23lKH6V
	 BnwMfYseNf+aBrUDK0i19Se0DWbgr3IshPr/Ll5Npl/PYTkbLTWQFuK4OuzUQ319zM
	 S1w3JuQTWI/YZfAw19rVNC/9o66+rr+rmzw8OKRuBkOl6HMfM5N5ft88rOd2fx/fdO
	 MFyRM1/U1Y0Jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14F20CE0ADA; Sun, 26 Nov 2023 11:24:48 -0800 (PST)
Date: Sun, 26 Nov 2023 11:24:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH RFC doc] Add EARLY flag to early-parsed kernel boot parameters
Message-ID: <48fc9653-3069-435f-a0ab-322aa7117e27@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kernel boot parameters declared with early_param() are parsed before
embedded parameters are extracted from initrd, and early_param()
parameters are not helpful when embedded in initrd.  Therefore,
mark early_param() kernel boot parameters with "EARLY" in
kernel-parameters.txt.

The following early_param() calls declare kernel boot parameters that
are undocumented:

early_param("atmel.pm_modes", at91_pm_modes_select);
early_param("mem_fclk_21285", early_fclk);
early_param("ecc", early_ecc);
early_param("cachepolicy", early_cachepolicy);
early_param("nodebugmon", early_debug_disable);
early_param("kfence.sample_interval", parse_kfence_early_init);
early_param("additional_cpus", setup_additional_cpus);
early_param("stram_pool", atari_stram_setup);
early_param("disable_octeon_edac", disable_octeon_edac);
early_param("rd_start", rd_start_early);
early_param("rd_size", rd_size_early);
early_param("coherentio", setcoherentio);
early_param("nocoherentio", setnocoherentio);
early_param("fadump", early_fadump_param);
early_param("fadump_reserve_mem", early_fadump_reserve_mem);
early_param("no_stf_barrier", handle_no_stf_barrier);
early_param("no_rfi_flush", handle_no_rfi_flush);
early_param("smt-enabled", early_smt_enabled);
early_param("ppc_pci_reset_phbs", pci_reset_phbs_setup);
early_param("ps3fb", early_parse_ps3fb);
early_param("ps3flash", early_parse_ps3flash);
early_param("novx", disable_vector_extension);
early_param("nobp", nobp_setup_early);
early_param("nospec", nospec_setup_early);
early_param("possible_cpus", _setup_possible_cpus);
early_param("stp", early_parse_stp);
early_param("nopfault", nopfault);
early_param("nmi_mode", nmi_mode_setup);
early_param("sh_mv", early_parse_mv);
early_param("pmb", early_pmb);
early_param("hvirq", early_hvirq_major);
early_param("cfi", cfi_parse_cmdline);
early_param("disableapic", setup_disableapic);
early_param("noapictimer", parse_disable_apic_timer);
early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
early_param("uv_memblksize", parse_mem_block_size);
early_param("retbleed", retbleed_parse_cmdline);
early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
early_param("update_mptable", update_mptable_setup);
early_param("alloc_mptable", parse_alloc_mptable_opt);
early_param("possible_cpus", _setup_possible_cpus);
early_param("lsmsi", early_parse_ls_scfg_msi);
early_param("nokgdbroundup", opt_nokgdbroundup);
early_param("kgdbcon", opt_kgdb_con);
early_param("kasan", early_kasan_flag);
early_param("kasan.mode", early_kasan_mode);
early_param("kasan.vmalloc", early_kasan_flag_vmalloc);
early_param("kasan.page_alloc.sample", early_kasan_flag_page_alloc_sample);
early_param("kasan.page_alloc.sample.order", early_kasan_flag_page_alloc_sample_order);
early_param("kasan.fault", early_kasan_fault);
early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
early_param("kasan.stack_ring_size", early_kasan_flag_stack_ring_size);
early_param("accept_memory", accept_memory_parse);
early_param("page_table_check", early_page_table_check_param);
sh_early_platform_init("earlytimer", &sh_cmt_device_driver);
early_param_on_off("gbpages", "nogbpages", direct_gbpages, CONFIG_X86_DIRECT_GBPAGES);

These are not necessarily bugs, given that some kernel boot parameters
are intended for deep debugging rather than general use.

This work does not cover all of the kernel boot parameters declared using
cmdline_find_option() and cmdline_find_option_bool().  If these are in
fact guaranteed to be early (which appears to be the case), they can be
added in a later version of this patch.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Petr Malat <oss@malat.biz>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: <linux-doc@vger.kernel.org>
Cc: <linux-arch@vger.kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 102937bc8443..fe4644df4b47 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -108,6 +108,7 @@ is applicable::
 	CMA	Contiguous Memory Area support is enabled.
 	DRM	Direct Rendering Management support is enabled.
 	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
+	EARLY	Parameter processed too early to be embedded in initrd.
 	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
 	EFI	EFI Partitioning (GPT) is enabled
 	EVM	Extended Verification Module
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9336e65d500d..54eb630fc689 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,4 +1,4 @@
-	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
+	acpi=		[HW,ACPI,X86,ARM64,RISCV64,EARLY]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
 				  copy_dsdt }
@@ -15,7 +15,7 @@
 
 			See also Documentation/power/runtime_pm.rst, pci=noacpi
 
-	acpi_apic_instance=	[ACPI, IOAPIC]
+	acpi_apic_instance=	[ACPI,IOAPIC,EARLY]
 			Format: <int>
 			2: use 2nd APIC table, if available
 			1,0: use 1st APIC table
@@ -30,7 +30,7 @@
 			If set to native, use the device's native backlight mode.
 			If set to none, disable the ACPI backlight interface.
 
-	acpi_force_32bit_fadt_addr
+	acpi_force_32bit_fadt_addr [ACPI,EARLY]
 			force FADT to use 32 bit addresses rather than the
 			64 bit X_* addresses. Some firmware have broken 64
 			bit addresses for force ACPI ignore these and use
@@ -86,7 +86,7 @@
 			no: ACPI OperationRegions are not marked as reserved,
 			no further checks are performed.
 
-	acpi_force_table_verification	[HW,ACPI]
+	acpi_force_table_verification	[HW,ACPI,EARLY]
 			Enable table checksum verification during early stage.
 			By default, this is disabled due to x86 early mapping
 			size limitation.
@@ -126,7 +126,7 @@
 	acpi_no_memhotplug [ACPI] Disable memory hotplug.  Useful for kdump
 			   kernels.
 
-	acpi_no_static_ssdt	[HW,ACPI]
+	acpi_no_static_ssdt	[HW,ACPI,EARLY]
 			Disable installation of static SSDTs at early boot time
 			By default, SSDTs contained in the RSDT/XSDT will be
 			installed automatically and they will appear under
@@ -140,7 +140,7 @@
 			Ignore the ACPI-based watchdog interface (WDAT) and let
 			a native driver control the watchdog device instead.
 
-	acpi_rsdp=	[ACPI,EFI,KEXEC]
+	acpi_rsdp=	[ACPI,EFI,KEXEC,EARLY]
 			Pass the RSDP address to the kernel, mostly used
 			on machines running EFI runtime service to boot the
 			second kernel for kdump.
@@ -217,10 +217,10 @@
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
 
-	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
+	acpi_sci=	[HW,ACPI,EARLY] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
 
-	acpi_skip_timer_override [HW,ACPI]
+	acpi_skip_timer_override [HW,ACPI,EARLY]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
 
@@ -255,11 +255,11 @@
 			behave incorrectly in some ways with respect to system
 			suspend and resume to be ignored (use wisely).
 
-	acpi_use_timer_override [HW,ACPI]
+	acpi_use_timer_override [HW,ACPI,EARLY]
 			Use timer override. For some broken Nvidia NF5 boards
 			that require a timer override, but don't have HPET
 
-	add_efi_memmap	[EFI; X86] Include EFI memory map in
+	add_efi_memmap	[EFI,X86,EARLY] Include EFI memory map in
 			kernel's map of available physical RAM.
 
 	agp=		[AGP]
@@ -296,7 +296,7 @@
 			do not want to use tracing_snapshot_alloc() as it needs
 			to be done where GFP_KERNEL allocations are allowed.
 
-	allow_mismatched_32bit_el0 [ARM64]
+	allow_mismatched_32bit_el0 [ARM64,EARLY]
 			Allow execve() of 32-bit applications and setting of the
 			PER_LINUX32 personality on systems where only a strict
 			subset of the CPUs support 32-bit EL0. When this
@@ -340,7 +340,7 @@
 			             This mode requires kvm-amd.avic=1.
 			             (Default when IOMMU HW support is present.)
 
-	amd_pstate=	[X86]
+	amd_pstate=	[X86,EARLY]
 			disable
 			  Do not enable amd_pstate as the default
 			  scaling driver for the supported processors
@@ -380,7 +380,7 @@
 			not play well with APC CPU idle - disable it if you have
 			APC and your system crashes randomly.
 
-	apic=		[APIC,X86] Advanced Programmable Interrupt Controller
+	apic=		[APIC,X86,EARLY] Advanced Programmable Interrupt Controller
 			Change the output verbosity while booting
 			Format: { quiet (default) | verbose | debug }
 			Change the amount of debugging information output
@@ -390,7 +390,7 @@
 			Format: apic=driver_name
 			Examples: apic=bigsmp
 
-	apic_extnmi=	[APIC,X86] External NMI delivery setting
+	apic_extnmi=	[APIC,X86,EARLY] External NMI delivery setting
 			Format: { bsp (default) | all | none }
 			bsp:  External NMI is delivered only to CPU 0
 			all:  External NMIs are broadcast to all CPUs as a
@@ -497,21 +497,22 @@
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
-	bgrt_disable	[ACPI][X86]
+	bgrt_disable	[ACPI,X86,EARLY]
 			Disable BGRT to avoid flickering OEM logo.
 
 	blkdevparts=	Manual partition parsing of block device(s) for
 			embedded devices based on command line input.
 			See Documentation/block/cmdline-partition.rst
 
-	boot_delay=	Milliseconds to delay each printk during boot.
+	boot_delay=	[KNL,EARLY]
+			Milliseconds to delay each printk during boot.
 			Only works if CONFIG_BOOT_PRINTK_DELAY is enabled,
 			and you may also have to specify "lpj=".  Boot_delay
 			values larger than 10 seconds (10000) are assumed
 			erroneous and ignored.
 			Format: integer
 
-	bootconfig	[KNL]
+	bootconfig	[KNL,EARLY]
 			Extended command line options can be added to an initrd
 			and this will cause the kernel to look for it.
 
@@ -546,7 +547,7 @@
 			trust validation.
 			format: { id:<keyid> | builtin }
 
-	cca=		[MIPS] Override the kernel pages' cache coherency
+	cca=		[MIPS,EARLY] Override the kernel pages' cache coherency
 			algorithm.  Accepted values range from 0 to 7
 			inclusive. See arch/mips/include/asm/pgtable-bits.h
 			for platform specific values (SB1, Loongson3 and
@@ -657,7 +658,7 @@
 			[X86-64] hpet,tsc
 
 	clocksource.arm_arch_timer.evtstrm=
-			[ARM,ARM64]
+			[ARM,ARM64,EARLY]
 			Format: <bool>
 			Enable/disable the eventstream feature of the ARM
 			architected timer so that code using WFE-based polling
@@ -687,7 +688,7 @@
 			10 seconds when built into the kernel.
 
 	cma=nn[MG]@[start[MG][-end[MG]]]
-			[KNL,CMA]
+			[KNL,CMA,EARLY]
 			Sets the size of kernel global memory area for
 			contiguous memory allocations and optionally the
 			placement constraint by the physical address range of
@@ -696,7 +697,7 @@
 			kernel/dma/contiguous.c
 
 	cma_pernuma=nn[MG]
-			[KNL,CMA]
+			[KNL,CMA,EARLY]
 			Sets the size of kernel per-numa memory area for
 			contiguous memory allocations. A value of 0 disables
 			per-numa CMA altogether. And If this option is not
@@ -707,7 +708,7 @@
 			they will fallback to the global default memory area.
 
 	numa_cma=<node>:nn[MG][,<node>:nn[MG]]
-			[KNL,CMA]
+			[KNL,CMA,EARLY]
 			Sets the size of kernel numa memory area for
 			contiguous memory allocations. It will reserve CMA
 			area for the specified node.
@@ -724,7 +725,7 @@
 			a hypervisor.
 			Default: yes
 
-	coherent_pool=nn[KMG]	[ARM,KNL]
+	coherent_pool=nn[KMG]	[ARM,KNL,EARLY]
 			Sets the size of memory pool for coherent, atomic dma
 			allocations, by default set to 256K.
 
@@ -742,7 +743,7 @@
 	condev=		[HW,S390] console device
 	conmode=
 
-	con3215_drop=	[S390] 3215 console drop mode.
+	con3215_drop=	[S390,EARLY] 3215 console drop mode.
 			Format: y|n|Y|N|1|0
 			When set to true, drop data on the 3215 console when
 			the console buffer is full. In this case the
@@ -848,7 +849,7 @@
 			kernel before the cpufreq driver probes.
 
 	cpu_init_udelay=N
-			[X86] Delay for N microsec between assert and de-assert
+			[X86,EARLY] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
 			on every CPU online, such as boot, and resume from suspend.
 			Default: 10000
@@ -868,7 +869,7 @@
 			kernel more unstable.
 
 	crashkernel=size[KMG][@offset[KMG]]
-			[KNL] Using kexec, Linux can switch to a 'crash kernel'
+			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
 			upon panic. This parameter reserves the physical
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
@@ -937,10 +938,10 @@
 			Format: <port#>,<type>
 			See also Documentation/input/devices/joystick-parport.rst
 
-	debug		[KNL] Enable kernel debugging (events log level).
+	debug		[KNL,EARLY] Enable kernel debugging (events log level).
 
 	debug_boot_weak_hash
-			[KNL] Enable printing [hashed] pointers early in the
+			[KNL,EARLY] Enable printing [hashed] pointers early in the
 			boot sequence.  If enabled, we use a weak hash instead
 			of siphash to hash pointers.  Use this option if you are
 			seeing instances of '(___ptrval___)') and need to see a
@@ -957,10 +958,10 @@
 			will print _a_lot_ more information - normally only
 			useful to lockdep developers.
 
-	debug_objects	[KNL] Enable object debugging
+	debug_objects	[KNL,EARLY] Enable object debugging
 
 	debug_guardpage_minorder=
-			[KNL] When CONFIG_DEBUG_PAGEALLOC is set, this
+			[KNL,EARLY] When CONFIG_DEBUG_PAGEALLOC is set, this
 			parameter allows control of the order of pages that will
 			be intentionally kept free (and hence protected) by the
 			buddy allocator. Bigger value increase the probability
@@ -979,7 +980,7 @@
 			tracking down these problems.
 
 	debug_pagealloc=
-			[KNL] When CONFIG_DEBUG_PAGEALLOC is set, this parameter
+			[KNL,EARLY] When CONFIG_DEBUG_PAGEALLOC is set, this parameter
 			enables the feature at boot time. By default, it is
 			disabled and the system will work mostly the same as a
 			kernel built without CONFIG_DEBUG_PAGEALLOC.
@@ -987,8 +988,8 @@
 			useful to also enable the page_owner functionality.
 			on: enable the feature
 
-	debugfs=    	[KNL] This parameter enables what is exposed to userspace
-			and debugfs internal clients.
+	debugfs=    	[KNL,EARLY] This parameter enables what is exposed to
+			userspace and debugfs internal clients.
 			Format: { on, no-mount, off }
 			on: 	All functions are enabled.
 			no-mount:
@@ -1067,7 +1068,7 @@
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
-	disable_1tb_segments [PPC]
+	disable_1tb_segments [PPC,EARLY]
 			Disables the use of 1TB hash page table segments. This
 			causes the kernel to fall back to 256MB segments which
 			can be useful when debugging issues that require an SLB
@@ -1076,7 +1077,7 @@
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
-	disable_radix	[PPC]
+	disable_radix	[PPC,EARLY]
 			Disable RADIX MMU mode on POWER9
 
 	disable_tlbie	[PPC]
@@ -1092,25 +1093,25 @@
 			causing system reset or hang due to sending
 			INIT from AP to BSP.
 
-	disable_ddw	[PPC/PSERIES]
+	disable_ddw	[PPC/PSERIES,EARLY]
 			Disable Dynamic DMA Window support. Use this
 			to workaround buggy firmware.
 
 	disable_ipv6=	[IPV6]
 			See Documentation/networking/ipv6.rst.
 
-	disable_mtrr_cleanup [X86]
+	disable_mtrr_cleanup [X86,EARLY]
 			The kernel tries to adjust MTRR layout from continuous
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter disables that.
 
-	disable_mtrr_trim [X86, Intel and AMD only]
+	disable_mtrr_trim [X86, Intel and AMD only,EARLY]
 			By default the kernel will trim any uncacheable
 			memory out of your available memory pool based on
 			MTRR settings.  This parameter disables that behavior,
 			possibly causing your machine to run very slowly.
 
-	disable_timer_pin_1 [X86]
+	disable_timer_pin_1 [X86,EARLY]
 			Disable PIN 1 of APIC timer
 			Can be useful to work around chipset bugs.
 
@@ -1160,7 +1161,7 @@
 
 	dscc4.setup=	[NET]
 
-	dt_cpu_ftrs=	[PPC]
+	dt_cpu_ftrs=	[PPC,EARLY]
 			Format: {"off" | "known"}
 			Control how the dt_cpu_ftrs device-tree binding is
 			used for CPU feature discovery and setup (if it
@@ -1180,12 +1181,12 @@
 			Documentation/admin-guide/dynamic-debug-howto.rst
 			for details.
 
-	early_ioremap_debug [KNL]
+	early_ioremap_debug [KNL,EARLY]
 			Enable debug messages in early_ioremap support. This
 			is useful for tracking down temporary early mappings
 			which are not unmapped.
 
-	earlycon=	[KNL] Output early console device and options.
+	earlycon=	[KNL,EARLY] Output early console device and options.
 
 			When used with no options, the early console is
 			determined by stdout-path property in device tree's
@@ -1321,7 +1322,7 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
-	earlyprintk=	[X86,SH,ARM,M68k,S390]
+	earlyprintk=	[X86,SH,ARM,M68k,S390,UM,EARLY]
 			earlyprintk=vga
 			earlyprintk=sclp
 			earlyprintk=xen
@@ -1376,7 +1377,7 @@
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
-	efi=		[EFI]
+	efi=		[EFI,EARLY]
 			Format: { "debug", "disable_early_pci_dma",
 				  "nochunk", "noruntime", "nosoftreserve",
 				  "novamap", "no_disable_early_pci_dma" }
@@ -1397,13 +1398,13 @@
 			no_disable_early_pci_dma: Leave the busmaster bit set
 			on all PCI bridges while in the EFI boot stub
 
-	efi_no_storage_paranoia [EFI; X86]
+	efi_no_storage_paranoia [EFI,X86,EARLY]
 			Using this parameter you can use more than 50% of
 			your efi variable storage. Use this parameter only if
 			you are really sure that your UEFI does sane gc and
 			fulfills the spec otherwise your board may brick.
 
-	efi_fake_mem=	nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI; X86]
+	efi_fake_mem=	nn[KMG]@ss[KMG]:aa[,nn[KMG]@ss[KMG]:aa,..] [EFI,X86,EARLY]
 			Add arbitrary attribute to specific memory range by
 			updating original EFI memory map.
 			Region of memory which aa attribute is added to is
@@ -1434,7 +1435,7 @@
 	eisa_irq_edge=	[PARISC,HW]
 			See header of drivers/parisc/eisa.c.
 
-	ekgdboc=	[X86,KGDB] Allow early kernel console debugging
+	ekgdboc=	[X86,KGDB,EARLY] Allow early kernel console debugging
 			Format: ekgdboc=kbd
 
 			This is designed to be used in conjunction with
@@ -1449,13 +1450,13 @@
 			See comment before function elanfreq_setup() in
 			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
 
-	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
+	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390,EARLY]
 			Specifies physical address of start of kernel core
 			image elf header and optionally the size. Generally
 			kexec loader will pass this option to capture kernel.
 			See Documentation/admin-guide/kdump/kdump.rst for details.
 
-	enable_mtrr_cleanup [X86]
+	enable_mtrr_cleanup [X86,EARLY]
 			The kernel tries to adjust MTRR layout from continuous
 			to discrete, to make X server driver able to add WB
 			entry later. This parameter enables that.
@@ -1488,7 +1489,7 @@
 			Permit 'security.evm' to be updated regardless of
 			current integrity status.
 
-	early_page_ext [KNL] Enforces page_ext initialization to earlier
+	early_page_ext [KNL,EARLY] Enforces page_ext initialization to earlier
 			stages so cover more early boot allocations.
 			Please note that as side effect some optimizations
 			might be disabled to achieve that (e.g. parallelized
@@ -1586,7 +1587,7 @@
 			can be changed at run time by the max_graph_depth file
 			in the tracefs tracing directory. default: 0 (no limit)
 
-	fw_devlink=	[KNL] Create device links between consumer and supplier
+	fw_devlink=	[KNL,EARLY] Create device links between consumer and supplier
 			devices by scanning the firmware to infer the
 			consumer/supplier relationships. This feature is
 			especially useful when drivers are loaded as modules as
@@ -1605,12 +1606,12 @@
 			rpm --	Like "on", but also use to order runtime PM.
 
 	fw_devlink.strict=<bool>
-			[KNL] Treat all inferred dependencies as mandatory
+			[KNL,EARLY] Treat all inferred dependencies as mandatory
 			dependencies. This only applies for fw_devlink=on|rpm.
 			Format: <bool>
 
 	fw_devlink.sync_state =
-			[KNL] When all devices that could probe have finished
+			[KNL,EARLY] When all devices that could probe have finished
 			probing, this parameter controls what to do with
 			devices that haven't yet received their sync_state()
 			calls.
@@ -1631,12 +1632,12 @@
 
 	gamma=		[HW,DRM]
 
-	gart_fix_e820=	[X86-64] disable the fix e820 for K8 GART
+	gart_fix_e820=	[X86-64,EARLY] disable the fix e820 for K8 GART
 			Format: off | on
 			default: on
 
 	gather_data_sampling=
-			[X86,INTEL] Control the Gather Data Sampling (GDS)
+			[X86,INTEL,EARLY] Control the Gather Data Sampling (GDS)
 			mitigation.
 
 			Gather Data Sampling is a hardware vulnerability which
@@ -1734,7 +1735,7 @@
 				(that will set all pages holding image data
 				during restoration read-only).
 
-	highmem=nn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
+	highmem=nn[KMG]	[KNL,BOOT,EARLY] forces the highmem zone to have an exact
 			size of <nn>. This works even on boxes that have no
 			highmem otherwise. This also works to reduce highmem
 			size on bigger boxes.
@@ -1745,7 +1746,7 @@
 
 	hlt		[BUGS=ARM,SH]
 
-	hostname=	[KNL] Set the hostname (aka UTS nodename).
+	hostname=	[KNL,EARLY] Set the hostname (aka UTS nodename).
 			Format: <string>
 			This allows setting the system's hostname during early
 			startup. This sets the name returned by gethostname.
@@ -1790,7 +1791,7 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
-	hugetlb_cma=	[HW,CMA] The size of a CMA area used for allocation
+	hugetlb_cma=	[HW,CMA,EARLY] The size of a CMA area used for allocation
 			of gigantic hugepages. Or using node format, the size
 			of a CMA area per node can be specified.
 			Format: nn[KMGTPE] or (node format)
@@ -1836,9 +1837,10 @@
 				If specified, z/VM IUCV HVC accepts connections
 				from listed z/VM user IDs only.
 
-	hv_nopvspin	[X86,HYPER_V] Disables the paravirt spinlock optimizations
-				      which allow the hypervisor to 'idle' the
-				      guest on lock contention.
+	hv_nopvspin	[X86,HYPER_V,EARLY]
+			Disables the paravirt spinlock optimizations
+			which allow the hypervisor to 'idle' the guest
+			on lock contention.
 
 	i2c_bus=	[HW]	Override the default board specific I2C bus speed
 				or register an additional I2C bus that is not
@@ -1903,7 +1905,7 @@
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
 
-	idle=		[X86]
+	idle=		[X86,EARLY]
 			Format: idle=poll, idle=halt, idle=nomwait
 			Poll forces a polling idle loop that can slightly
 			improve the performance of waking up a idle CPU, but
@@ -1959,7 +1961,7 @@
 			mode generally follows that for the NaN encoding,
 			except where unsupported by hardware.
 
-	ignore_loglevel	[KNL]
+	ignore_loglevel	[KNL,EARLY]
 			Ignore loglevel setting - this will print /all/
 			kernel messages to the console. Useful for debugging.
 			We also add it as printk module parameter, so users
@@ -2077,21 +2079,21 @@
 			unpacking being completed before device_ and
 			late_ initcalls.
 
-	initrd=		[BOOT] Specify the location of the initial ramdisk
+	initrd=		[BOOT,EARLY] Specify the location of the initial ramdisk
 
-	initrdmem=	[KNL] Specify a physical address and size from which to
+	initrdmem=	[KNL,EARLY] Specify a physical address and size from which to
 			load the initrd. If an initrd is compiled in or
 			specified in the bootparams, it takes priority over this
 			setting.
 			Format: ss[KMG],nn[KMG]
 			Default is 0, 0
 
-	init_on_alloc=	[MM] Fill newly allocated pages and heap objects with
+	init_on_alloc=	[MM,EARLY] Fill newly allocated pages and heap objects with
 			zeroes.
 			Format: 0 | 1
 			Default set by CONFIG_INIT_ON_ALLOC_DEFAULT_ON.
 
-	init_on_free=	[MM] Fill freed pages and heap objects with zeroes.
+	init_on_free=	[MM,EARLY] Fill freed pages and heap objects with zeroes.
 			Format: 0 | 1
 			Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
 
@@ -2147,7 +2149,7 @@
 			0	disables intel_idle and fall back on acpi_idle.
 			1 to 9	specify maximum depth of C-state.
 
-	intel_pstate=	[X86]
+	intel_pstate=	[X86,EARLY]
 			disable
 			  Do not enable intel_pstate as the default
 			  scaling driver for the supported processors
@@ -2191,7 +2193,7 @@
 			  Allow per-logical-CPU P-State performance control limits using
 			  cpufreq sysfs interface
 
-	intremap=	[X86-64, Intel-IOMMU]
+	intremap=	[X86-64,Intel-IOMMU,EARLY]
 			on	enable Interrupt Remapping (default)
 			off	disable Interrupt Remapping
 			nosid	disable Source ID checking
@@ -2203,7 +2205,7 @@
 		strict	regions from userspace.
 		relaxed
 
-	iommu=		[X86]
+	iommu=		[X86,EARLY]
 		off
 		force
 		noforce
@@ -2218,7 +2220,7 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
-	iommu.forcedac=	[ARM64, X86] Control IOVA allocation for PCI devices.
+	iommu.forcedac=	[ARM64,X86,EARLY] Control IOVA allocation for PCI devices.
 			Format: { "0" | "1" }
 			0 - Try to allocate a 32-bit DMA address first, before
 			  falling back to the full range if needed.
@@ -2226,7 +2228,7 @@
 			  forcing Dual Address Cycle for PCI cards supporting
 			  greater than 32-bit addressing.
 
-	iommu.strict=	[ARM64, X86] Configure TLB invalidation behaviour
+	iommu.strict=	[ARM64,X86,EARLY] Configure TLB invalidation behaviour
 			Format: { "0" | "1" }
 			0 - Lazy mode.
 			  Request that DMA unmap operations use deferred
@@ -2242,7 +2244,7 @@
 			legacy driver-specific options takes precedence.
 
 	iommu.passthrough=
-			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
+			[ARM64,X86,EARLY] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
 			0 - Use IOMMU translation for DMA.
 			1 - Bypass the IOMMU for DMA.
@@ -2252,7 +2254,7 @@
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
 
-	io_delay=	[X86] I/O delay method
+	io_delay=	[X86,EARLY] I/O delay method
 		0x80
 			Standard port 0x80 based delay
 		0xed
@@ -2265,28 +2267,28 @@
 	ip=		[IP_PNP]
 			See Documentation/admin-guide/nfs/nfsroot.rst.
 
-	ipcmni_extend	[KNL] Extend the maximum number of unique System V
+	ipcmni_extend	[KNL,EARLY] Extend the maximum number of unique System V
 			IPC identifiers from 32,768 to 16,777,216.
 
 	irqaffinity=	[SMP] Set the default irq affinity mask
 			The argument is a cpu list, as described above.
 
 	irqchip.gicv2_force_probe=
-			[ARM, ARM64]
+			[ARM,ARM64,EARLY]
 			Format: <bool>
 			Force the kernel to look for the second 4kB page
 			of a GICv2 controller even if the memory range
 			exposed by the device tree is too small.
 
 	irqchip.gicv3_nolpi=
-			[ARM, ARM64]
+			[ARM,ARM64,EARLY]
 			Force the kernel to ignore the availability of
 			LPIs (and by consequence ITSs). Intended for system
 			that use the kernel as a bootloader, and thus want
 			to let secondary kernels in charge of setting up
 			LPIs.
 
-	irqchip.gicv3_pseudo_nmi= [ARM64]
+	irqchip.gicv3_pseudo_nmi= [ARM64,EARLY]
 			Enables support for pseudo-NMIs in the kernel. This
 			requires the kernel to be built with
 			CONFIG_ARM64_PSEUDO_NMI.
@@ -2431,7 +2433,7 @@
 			parameter KASAN will print report only for the first
 			invalid access.
 
-	keep_bootcon	[KNL]
+	keep_bootcon	[KNL,EARLY]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
 			between unregistering the boot console and initializing
@@ -2439,7 +2441,7 @@
 
 	keepinitrd	[HW,ARM]
 
-	kernelcore=	[KNL,X86,IA-64,PPC]
+	kernelcore=	[KNL,X86,IA-64,PPC,EARLY]
 			Format: nn[KMGTPE] | nn% | "mirror"
 			This parameter specifies the amount of memory usable by
 			the kernel for non-movable allocations.  The requested
@@ -2464,7 +2466,7 @@
 			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
 			are exclusive, so you cannot specify multiple forms.
 
-	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
+	kgdbdbgp=	[KGDB,HW,EARLY] kgdb over EHCI usb debug port.
 			Format: <Controller#>[,poll interval]
 			The controller # is the number of the ehci usb debug
 			port as it is probed via PCI.  The poll interval is
@@ -2485,7 +2487,7 @@
 			 kms, kbd format: kms,kbd
 			 kms, kbd and serial format: kms,kbd,<ser_dev>[,baud]
 
-	kgdboc_earlycon=	[KGDB,HW]
+	kgdboc_earlycon=	[KGDB,HW,EARLY]
 			If the boot console provides the ability to read
 			characters and can work in polling mode, you can use
 			this parameter to tell kgdb to use it as a backend
@@ -2500,14 +2502,14 @@
 			blank and the first boot console that implements
 			read() will be picked.
 
-	kgdbwait	[KGDB] Stop kernel execution and enter the
+	kgdbwait	[KGDB,EARLY] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
 	kmac=		[MIPS] Korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
 
-	kmemleak=	[KNL] Boot-time kmemleak enable/disable
+	kmemleak=	[KNL,EARLY] Boot-time kmemleak enable/disable
 			Valid arguments: on, off
 			Default: on
 			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
@@ -2526,8 +2528,8 @@
 			See also Documentation/trace/kprobetrace.rst "Kernel
 			Boot Parameter" section.
 
-	kpti=		[ARM64] Control page table isolation of user
-			and kernel address spaces.
+	kpti=		[ARM64,EARLY] Control page table isolation of
+			user and kernel address spaces.
 			Default: enabled on cores which need mitigation.
 			0: force disabled
 			1: force enabled
@@ -2604,7 +2606,8 @@
 			for NPT.
 
 	kvm-arm.mode=
-			[KVM,ARM] Select one of KVM/arm64's modes of operation.
+			[KVM,ARM,EARLY] Select one of KVM/arm64's modes of
+			operation.
 
 			none: Forcefully disable KVM.
 
@@ -2624,22 +2627,22 @@
 			used with extreme caution.
 
 	kvm-arm.vgic_v3_group0_trap=
-			[KVM,ARM] Trap guest accesses to GICv3 group-0
+			[KVM,ARM,EARLY] Trap guest accesses to GICv3 group-0
 			system registers
 
 	kvm-arm.vgic_v3_group1_trap=
-			[KVM,ARM] Trap guest accesses to GICv3 group-1
+			[KVM,ARM,EARLY] Trap guest accesses to GICv3 group-1
 			system registers
 
 	kvm-arm.vgic_v3_common_trap=
-			[KVM,ARM] Trap guest accesses to GICv3 common
+			[KVM,ARM,EARLY] Trap guest accesses to GICv3 common
 			system registers
 
 	kvm-arm.vgic_v4_enable=
-			[KVM,ARM] Allow use of GICv4 for direct injection of
-			LPIs.
+			[KVM,ARM,EARLY] Allow use of GICv4 for direct
+			injection of LPIs.
 
-	kvm_cma_resv_ratio=n [PPC]
+	kvm_cma_resv_ratio=n [PPC,EARLY]
 			Reserves given percentage from system memory area for
 			contiguous memory allocation for KVM hash pagetable
 			allocation.
@@ -2692,7 +2695,7 @@
 			(enabled). Disable by KVM if hardware lacks support
 			for it.
 
-	l1d_flush=	[X86,INTEL]
+	l1d_flush=	[X86,INTEL,EARLY]
 			Control mitigation for L1D based snooping vulnerability.
 
 			Certain CPUs are vulnerable to an exploit against CPU
@@ -2709,7 +2712,7 @@
 
 			on         - enable the interface for the mitigation
 
-	l1tf=           [X86] Control mitigation of the L1TF vulnerability on
+	l1tf=           [X86,EARLY] Control mitigation of the L1TF vulnerability on
 			      affected CPUs
 
 			The kernel PTE inversion protection is unconditionally
@@ -2778,7 +2781,7 @@
 
 	l3cr=		[PPC]
 
-	lapic		[X86-32,APIC] Enable the local APIC even if BIOS
+	lapic		[X86-32,APIC,EARLY] Enable the local APIC even if BIOS
 			disabled it.
 
 	lapic=		[X86,APIC] Do not use TSC deadline
@@ -2786,7 +2789,7 @@
 			back to the programmable timer unit in the LAPIC.
 			Format: notscdeadline
 
-	lapic_timer_c2_ok	[X86,APIC] trust the local apic timer
+	lapic_timer_c2_ok	[X86,APIC,EARLY] trust the local apic timer
 			in C2 power state.
 
 	libata.dma=	[LIBATA] DMA control
@@ -2910,7 +2913,7 @@
 	lockd.nlm_udpport=M	[NFS] Assign UDP port.
 			Format: <integer>
 
-	lockdown=	[SECURITY]
+	lockdown=	[SECURITY,EARLY]
 			{ integrity | confidentiality }
 			Enable the kernel lockdown feature. If set to
 			integrity, kernel features that allow userland to
@@ -3017,7 +3020,8 @@
 	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
 			Format: <irq>
 
-	loglevel=	All Kernel Messages with a loglevel smaller than the
+	loglevel=	[KNL,EARLY]
+			All Kernel Messages with a loglevel smaller than the
 			console loglevel will be printed to the console. It can
 			also be changed with klogd or other programs. The
 			loglevels are defined as follows:
@@ -3031,13 +3035,15 @@
 			6 (KERN_INFO)		informational
 			7 (KERN_DEBUG)		debug-level messages
 
-	log_buf_len=n[KMG]	Sets the size of the printk ring buffer,
-			in bytes.  n must be a power of two and greater
-			than the minimal size. The minimal size is defined
-			by LOG_BUF_SHIFT kernel config parameter. There is
-			also CONFIG_LOG_CPU_MAX_BUF_SHIFT config parameter
-			that allows to increase the default size depending on
-			the number of CPUs. See init/Kconfig for more details.
+	log_buf_len=n[KMG] [KNL,EARLY]
+			Sets the size of the printk ring buffer, in bytes.
+			n must be a power of two and greater than the
+			minimal size. The minimal size is defined by
+			LOG_BUF_SHIFT kernel config parameter. There
+			is also CONFIG_LOG_CPU_MAX_BUF_SHIFT config
+			parameter that allows to increase the default size
+			depending on the number of CPUs. See init/Kconfig
+			for more details.
 
 	logo.nologo	[FB] Disables display of the built-in Linux logo.
 			This may be used to provide more screen space for
@@ -3095,7 +3101,7 @@
 	max_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory greater
 			than or equal to this physical address is ignored.
 
-	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
+	maxcpus=	[SMP,EARLY] Maximum number of processors that an SMP kernel
 			will bring up during bootup.  maxcpus=n : n >= 0 limits
 			the kernel to bring up 'n' processors. Surely after
 			bootup you can bring up the other plugged cpu by executing
@@ -3122,7 +3128,7 @@
 			Format: <first>,<last>
 			Specifies range of consoles to be captured by the MDA.
 
-	mds=		[X86,INTEL]
+	mds=		[X86,INTEL,EARLY]
 			Control mitigation for the Micro-architectural Data
 			Sampling (MDS) vulnerability.
 
@@ -3154,11 +3160,12 @@
 
 			For details see: Documentation/admin-guide/hw-vuln/mds.rst
 
-	mem=nn[KMG]	[HEXAGON] Set the memory size.
+	mem=nn[KMG]	[HEXAGON,EARLY] Set the memory size.
 			Must be specified, otherwise memory size will be 0.
 
-	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
-			Amount of memory to be used in cases as follows:
+	mem=nn[KMG]	[KNL,BOOT,EARLY] Force usage of a specific amount
+			of memory Amount of memory to be used in cases
+			as follows:
 
 			1 for test;
 			2 when the kernel is not able to see the whole system memory;
@@ -3182,8 +3189,8 @@
 			if system memory of hypervisor is not sufficient.
 
 	mem=nn[KMG]@ss[KMG]
-			[ARM,MIPS] - override the memory layout reported by
-			firmware.
+			[ARM,MIPS,EARLY] - override the memory layout
+			reported by firmware.
 			Define a memory region of size nn[KMG] starting at
 			ss[KMG].
 			Multiple different regions can be specified with
@@ -3192,7 +3199,7 @@
 	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
 			memory.
 
-	memblock=debug	[KNL] Enable memblock debug messages.
+	memblock=debug	[KNL,EARLY] Enable memblock debug messages.
 
 	memchunk=nn[KMG]
 			[KNL,SH] Allow user to override the default size for
@@ -3206,14 +3213,14 @@
 			option.
 			See Documentation/admin-guide/mm/memory-hotplug.rst.
 
-	memmap=exactmap	[KNL,X86] Enable setting of an exact
+	memmap=exactmap	[KNL,X86,EARLY] Enable setting of an exact
 			E820 memory map, as specified by the user.
 			Such memmap=exactmap lines can be constructed based on
 			BIOS output or other requirements. See the memmap=nn@ss
 			option description.
 
 	memmap=nn[KMG]@ss[KMG]
-			[KNL, X86, MIPS, XTENSA] Force usage of a specific region of memory.
+			[KNL, X86,MIPS,XTENSA,EARLY] Force usage of a specific region of memory.
 			Region of memory to be used is from ss to ss+nn.
 			If @ss[KMG] is omitted, it is equivalent to mem=nn[KMG],
 			which limits max address to nn[KMG].
@@ -3223,11 +3230,11 @@
 				memmap=100M@2G,100M#3G,1G!1024G
 
 	memmap=nn[KMG]#ss[KMG]
-			[KNL,ACPI] Mark specific memory as ACPI data.
+			[KNL,ACPI,EARLY] Mark specific memory as ACPI data.
 			Region of memory to be marked is from ss to ss+nn.
 
 	memmap=nn[KMG]$ss[KMG]
-			[KNL,ACPI] Mark specific memory as reserved.
+			[KNL,ACPI,EARLY] Mark specific memory as reserved.
 			Region of memory to be reserved is from ss to ss+nn.
 			Example: Exclude memory from 0x18690000-0x1869ffff
 			         memmap=64K$0x18690000
@@ -3237,14 +3244,14 @@
 			like Grub2, otherwise '$' and the following number
 			will be eaten.
 
-	memmap=nn[KMG]!ss[KMG]
+	memmap=nn[KMG]!ss[KMG,EARLY]
 			[KNL,X86] Mark specific memory as protected.
 			Region of memory to be used, from ss to ss+nn.
 			The memory region may be marked as e820 type 12 (0xc)
 			and is NVDIMM or ADR memory.
 
 	memmap=<size>%<offset>-<oldtype>+<newtype>
-			[KNL,ACPI] Convert memory within the specified region
+			[KNL,ACPI,EARLY] Convert memory within the specified region
 			from <oldtype> to <newtype>. If "-<oldtype>" is left
 			out, the whole region will be marked as <newtype>,
 			even if previously unavailable. If "+<newtype>" is left
@@ -3252,7 +3259,7 @@
 			specified as e820 types, e.g., 1 = RAM, 2 = reserved,
 			3 = ACPI, 12 = PRAM.
 
-	memory_corruption_check=0/1 [X86]
+	memory_corruption_check=0/1 [X86,EARLY]
 			Some BIOSes seem to corrupt the first 64k of
 			memory when doing things like suspend/resume.
 			Setting this option will scan the memory
@@ -3264,13 +3271,13 @@
 			affects the same memory, you can use memmap=
 			to prevent the kernel from using that memory.
 
-	memory_corruption_check_size=size [X86]
+	memory_corruption_check_size=size [X86,EARLY]
 			By default it checks for corruption in the low
 			64k, making this memory unavailable for normal
 			use.  Use this parameter to scan for
 			corruption in more or less memory.
 
-	memory_corruption_check_period=seconds [X86]
+	memory_corruption_check_period=seconds [X86,EARLY]
 			By default it checks for corruption every 60
 			seconds.  Use this parameter to check at some
 			other rate.  0 disables periodic checking.
@@ -3294,7 +3301,7 @@
 			Note that even when enabled, there are a few cases where
 			the feature is not effective.
 
-	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
+	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV,EARLY] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
 			Specifies the number of memtest passes to be
@@ -3357,7 +3364,7 @@
 			https://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			[X86,PPC,S390,ARM64] Control optional mitigations for
+			[X86,PPC,S390,ARM64,EARLY] Control optional mitigations for
 			CPU vulnerabilities.  This is a set of curated,
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
@@ -3410,7 +3417,7 @@
 					       retbleed=auto,nosmt [X86]
 
 	mminit_loglevel=
-			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
+			[KNL,EARLY] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for
 			the additional memory initialisation checks. A value
 			of 0 disables mminit logging and a level of 4 will
@@ -3418,7 +3425,7 @@
 			so loglevel=8 may also need to be specified.
 
 	mmio_stale_data=
-			[X86,INTEL] Control mitigation for the Processor
+			[X86,INTEL,EARLY] Control mitigation for the Processor
 			MMIO Stale Data vulnerabilities.
 
 			Processor MMIO Stale Data is a class of
@@ -3493,7 +3500,7 @@
 	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 
-	movablecore=	[KNL,X86,IA-64,PPC]
+	movablecore=	[KNL,X86,IA-64,PPC,EARLY]
 			Format: nn[KMGTPE] | nn%
 			This parameter is the complement to kernelcore=, it
 			specifies the amount of memory used for migratable
@@ -3504,7 +3511,7 @@
 			that the amount of memory usable for all allocations
 			is not too small.
 
-	movable_node	[KNL] Boot-time switch to make hotplugable memory
+	movable_node	[KNL,EARLY] Boot-time switch to make hotplugable memory
 			NUMA nodes to be movable. This means that the memory
 			of such nodes will be usable only for movable
 			allocations which rules out almost all kernel
@@ -3528,21 +3535,21 @@
 			[HW] Make the MicroTouch USB driver use raw coordinates
 			('y', default) or cooked coordinates ('n')
 
-	mtrr=debug	[X86]
+	mtrr=debug	[X86,EARLY]
 			Enable printing debug information related to MTRR
 			registers at boot time.
 
-	mtrr_chunk_size=nn[KMG] [X86]
+	mtrr_chunk_size=nn[KMG,X86,EARLY]
 			used for mtrr cleanup. It is largest continuous chunk
 			that could hold holes aka. UC entries.
 
-	mtrr_gran_size=nn[KMG] [X86]
+	mtrr_gran_size=nn[KMG,X86,EARLY]
 			Used for mtrr cleanup. It is granularity of mtrr block.
 			Default is 1.
 			Large value could prevent small alignment from
 			using up MTRRs.
 
-	mtrr_spare_reg_nr=n [X86]
+	mtrr_spare_reg_nr=n [X86,EARLY]
 			Format: <integer>
 			Range: 0,7 : spare reg number
 			Default : 1
@@ -3721,10 +3728,10 @@
 			emulation library even if a 387 maths coprocessor
 			is present.
 
-	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
-			kernel to use 3-level paging instead.
+	no4lvl		[RISCV,EARLY] Disable 4-level and 5-level paging modes.
+			Forces kernel to use 3-level paging instead.
 
-	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
+	no5lvl		[X86-64,RISCV,EARLY] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
 	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
@@ -3733,15 +3740,15 @@
 
 	noalign		[KNL,ARM]
 
-	noaltinstr	[S390] Disables alternative instructions patching
-			(CPU alternatives feature).
+	noaltinstr	[S390,EARLY] Disables alternative instructions
+			patching (CPU alternatives feature).
 
-	noapic		[SMP,APIC] Tells the kernel to not make use of any
+	noapic		[SMP,APIC,EARLY] Tells the kernel to not make use of any
 			IOAPICs that may be present in the system.
 
 	noautogroup	Disable scheduler automatic task group creation.
 
-	nocache		[ARM]
+	nocache		[ARM,EARLY]
 
 	no_console_suspend
 			[HW] Never suspend the console
@@ -3759,13 +3766,13 @@
 			turn on/off it dynamically.
 
 	no_debug_objects
-			[KNL] Disable object debugging
+			[KNL,EARLY] Disable object debugging
 
 	nodsp		[SH] Disable hardware DSP at boot time.
 
-	noefi		Disable EFI runtime services support.
+	noefi		[EFI,EARLY] Disable EFI runtime services support.
 
-	no_entry_flush  [PPC] Don't flush the L1-D cache when entering the kernel.
+	no_entry_flush  [PPC,EARLY] Don't flush the L1-D cache when entering the kernel.
 
 	noexec		[IA-64]
 
@@ -3796,6 +3803,7 @@
 			real-time systems.
 
 	no_hash_pointers
+			[KNL,EARLY]
 			Force pointers printed to the console or buffers to be
 			unhashed.  By default, when a pointer is printed via %p
 			format string, that pointer is "hashed", i.e. obscured
@@ -3820,9 +3828,9 @@
 			the impact of the sleep instructions. This is also
 			useful when using JTAG debugger.
 
-	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
+	nohugeiomap	[KNL,X86,PPC,ARM64,EARLY] Disable kernel huge I/O mappings.
 
-	nohugevmalloc	[KNL,X86,PPC,ARM64] Disable kernel huge vmalloc mappings.
+	nohugevmalloc	[KNL,X86,PPC,ARM64,EARLY] Disable kernel huge vmalloc mappings.
 
 	nohz=		[KNL] Boottime enable/disable dynamic ticks
 			Valid arguments: on, off
@@ -3844,13 +3852,13 @@
 	noinitrd	[RAM] Tells the kernel not to load any configured
 			initial RAM disk.
 
-	nointremap	[X86-64, Intel-IOMMU] Do not enable interrupt
+	nointremap	[X86-64,Intel-IOMMU,EARLY] Do not enable interrupt
 			remapping.
 			[Deprecated - use intremap=off]
 
 	nointroute	[IA-64]
 
-	noinvpcid	[X86] Disable the INVPCID cpu feature.
+	noinvpcid	[X86,EARLY] Disable the INVPCID cpu feature.
 
 	noiotrap	[SH] Disables trapped I/O port accesses.
 
@@ -3861,19 +3869,19 @@
 
 	nojitter	[IA-64] Disables jitter checking for ITC timers.
 
-	nokaslr		[KNL]
+	nokaslr		[KNL,EARLY]
 			When CONFIG_RANDOMIZE_BASE is set, this disables
 			kernel and module base offset ASLR (Address Space
 			Layout Randomization).
 
-	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
+	no-kvmapf	[X86,KVM,EARLY] Disable paravirtualized asynchronous page
 			fault handling.
 
-	no-kvmclock	[X86,KVM] Disable paravirtualized KVM clock driver
+	no-kvmclock	[X86,KVM,EARLY] Disable paravirtualized KVM clock driver
 
-	nolapic		[X86-32,APIC] Do not enable or use the local APIC.
+	nolapic		[X86-32,APIC,EARLY] Do not enable or use the local APIC.
 
-	nolapic_timer	[X86-32,APIC] Do not use the local APIC timer.
+	nolapic_timer	[X86-32,APIC,EARLY] Do not use the local APIC timer.
 
 	nomca		[IA-64] Disable machine check abort handling
 
@@ -3898,23 +3906,23 @@
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
-	nopat		[X86] Disable PAT (page attribute table extension of
+	nopat		[X86,EARLY] Disable PAT (page attribute table extension of
 			pagetables) support.
 
-	nopcid		[X86-64] Disable the PCID cpu feature.
+	nopcid		[X86-64,EARLY] Disable the PCID cpu feature.
 
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
 			in some Intel CPUs.
 
-	nopti		[X86-64]
+	nopti		[X86-64,EARLY]
 			Equivalent to pti=off
 
-	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE]
+	nopv=		[X86,XEN,KVM,HYPER_V,VMWARE,EARLY]
 			Disables the PV optimizations forcing the guest to run
 			as generic guest with no PV drivers. Currently support
 			XEN HVM, KVM, HYPER_V and VMWARE guest.
 
-	nopvspin	[X86,XEN,KVM]
+	nopvspin	[X86,XEN,KVM,EARLY]
 			Disables the qspinlock slow path using PV optimizations
 			which allow the hypervisor to 'idle' the guest on lock
 			contention.
@@ -3934,20 +3942,20 @@
 			This is required for the Braillex ib80-piezo Braille
 			reader made by F.H. Papenmeier (Germany).
 
-	nosgx		[X86-64,SGX] Disables Intel SGX kernel support.
+	nosgx		[X86-64,SGX,EARLY] Disables Intel SGX kernel support.
 
-	nosmap		[PPC]
+	nosmap		[PPC,EARLY]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
 
-	nosmep		[PPC64s]
+	nosmep		[PPC64s,EARLY]
 			Disable SMEP (Supervisor Mode Execution Prevention)
 			even if it is supported by processor.
 
-	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
+	nosmp		[SMP,EARLY] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
-	nosmt		[KNL,MIPS,PPC,S390] Disable symmetric multithreading (SMT).
+	nosmt		[KNL,MIPS,PPC,S390,EARLY] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
 			[KNL,X86,PPC] Disable symmetric multithreading (SMT).
@@ -3957,24 +3965,26 @@
 	nosoftlockup	[KNL] Disable the soft-lockup detector.
 
 	nospec_store_bypass_disable
-			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
+			[HW,EARLY] Disable all mitigations for the Speculative
+			Store Bypass vulnerability
 
-	nospectre_bhb	[ARM64] Disable all mitigations for Spectre-BHB (branch
+	nospectre_bhb	[ARM64,EARLY] Disable all mitigations for Spectre-BHB (branch
 			history injection) vulnerability. System may allow data leaks
 			with this option.
 
-	nospectre_v1	[X86,PPC] Disable mitigations for Spectre Variant 1
+	nospectre_v1	[X86,PPC,EARLY] Disable mitigations for Spectre Variant 1
 			(bounds check bypass). With this option data leaks are
 			possible in the system.
 
-	nospectre_v2	[X86,PPC_E500,ARM64] Disable all mitigations for
-			the Spectre variant 2 (indirect branch prediction)
-			vulnerability. System may allow data leaks with this
-			option.
+	nospectre_v2	[X86,PPC_E500,ARM64,EARLY] Disable all mitigations
+			for the Spectre variant 2 (indirect branch
+			prediction) vulnerability. System may allow data
+			leaks with this option.
 
-	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES] Disable paravirtualized
-			steal time accounting. steal time is computed, but
-			won't influence scheduler behaviour
+	no-steal-acc	[X86,PV_OPS,ARM64,PPC/PSERIES,EARLY] Disable
+			paravirtualized steal time accounting. steal
+			time is computed, but won't influence scheduler
+			behaviour
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
@@ -3982,7 +3992,7 @@
 			broken timer IRQ sources.
 
 	no_uaccess_flush
-	                [PPC] Don't flush the L1-D cache after accessing user data.
+	                [PPC,EARLY] Don't flush the L1-D cache after accessing user data.
 
 	novmcoredd	[KNL,KDUMP]
 			Disable device dump. Device dump allows drivers to
@@ -3996,15 +4006,15 @@
 			is set.
 
 	no-vmw-sched-clock
-			[X86,PV_OPS] Disable paravirtualized VMware scheduler
-			clock and use the default one.
+			[X86,PV_OPS,EARLY] Disable paravirtualized VMware
+			scheduler clock and use the default one.
 
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
-	nowb		[ARM]
+	nowb		[ARM,EARLY]
 
-	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
+	nox2apic	[X86-64,APIC,EARLY] Do not enable x2APIC mode.
 
 			NOTE: this parameter will be ignored on systems with the
 			LEGACY_XAPIC_DISABLED bit set in the
@@ -4042,7 +4052,7 @@
 			purges which is reported from either PAL_VM_SUMMARY or
 			SAL PALO.
 
-	nr_cpus=	[SMP] Maximum number of processors that	an SMP kernel
+	nr_cpus=	[SMP,EARLY] Maximum number of processors that an SMP kernel
 			could support.  nr_cpus=n : n >= 1 limits the kernel to
 			support 'n' processors. It could be larger than the
 			number of already plugged CPU during bootup, later in
@@ -4053,8 +4063,9 @@
 
 	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
 
-	numa=off 	[KNL, ARM64, PPC, RISCV, SPARC, X86] Disable NUMA, Only
-			set up a single NUMA node spanning all memory.
+	numa=off 	[KNL, ARM64, PPC, RISCV, SPARC, X86, EARLY]
+			Disable NUMA, Only set up a single NUMA node
+			spanning all memory.
 
 	numa_balancing=	[KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
 			NUMA balancing.
@@ -4065,7 +4076,7 @@
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
-	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
+	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
 
@@ -4091,7 +4102,8 @@
 				   Once locked, the boundary cannot be changed.
 				   1 indicates lock status, 0 indicates unlock status.
 
-	oops=panic	Always panic on oopses. Default is to just kill the
+	oops=panic	[KNL,EARLY]
+			Always panic on oopses. Default is to just kill the
 			process, but there is a small probability of
 			deadlocking the machine.
 			This will also cause panics on machine check exceptions.
@@ -4107,13 +4119,13 @@
 			can be read from sysfs at:
 			/sys/module/page_alloc/parameters/shuffle.
 
-	page_owner=	[KNL] Boot-time page_owner enabling option.
+	page_owner=	[KNL,EARLY] Boot-time page_owner enabling option.
 			Storage of the information about who allocated
 			each page is disabled in default. With this switch,
 			we can turn it on.
 			on: enable the feature
 
-	page_poison=	[KNL] Boot-time parameter changing the state of
+	page_poison=	[KNL,EARLY] Boot-time parameter changing the state of
 			poisoning on the buddy allocator, available with
 			CONFIG_PAGE_POISONING=y.
 			off: turn off poisoning (default)
@@ -4131,7 +4143,8 @@
 			timeout < 0: reboot immediately
 			Format: <timeout>
 
-	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
+	panic_on_taint=	[KNL,EARLY]
+			Bitmask for conditionally calling panic() in add_taint()
 			Format: <hex>[,nousertaint]
 			Hexadecimal bitmask representing the set of TAINT flags
 			that will cause the kernel to panic when add_taint() is
@@ -4287,7 +4300,7 @@
 
 	pcbit=		[HW,ISDN]
 
-	pci=option[,option...]	[PCI] various PCI subsystem options.
+	pci=option[,option...]	[PCI,EARLY] various PCI subsystem options.
 
 				Some options herein operate on a specific device
 				or a set of devices (<pci_dev>). These are
@@ -4556,7 +4569,8 @@
 			Format: { 0 | 1 }
 			See arch/parisc/kernel/pdc_chassis.c
 
-	percpu_alloc=	Select which percpu first chunk allocator to use.
+	percpu_alloc=	[MM,EARLY]
+			Select which percpu first chunk allocator to use.
 			Currently supported values are "embed" and "page".
 			Archs may support subset or none of the	selections.
 			See comments in mm/percpu.c for details on each
@@ -4625,12 +4639,12 @@
 			execution priority.
 
 	ppc_strict_facility_enable
-			[PPC] This option catches any kernel floating point,
+			[PPC,ENABLE] This option catches any kernel floating point,
 			Altivec, VSX and SPE outside of regions specifically
 			allowed (eg kernel_enable_fpu()/kernel_disable_fpu()).
 			There is some performance impact when enabling this.
 
-	ppc_tm=		[PPC]
+	ppc_tm=		[PPC,EARLY]
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
@@ -4747,7 +4761,7 @@
 			This option exists only in kernels built with
 			CONFIG_DEBUG_QSPINLOCK_SLOWPATH=y.
 
-	quiet		[KNL] Disable most log messages
+	quiet		[KNL,EARLY] Disable most log messages
 
 	r128=		[HW,DRM]
 
@@ -4764,17 +4778,17 @@
 	ramdisk_start=	[RAM] RAM disk image start address
 
 	random.trust_cpu=off
-			[KNL] Disable trusting the use of the CPU's
+			[KNL,EARLY] Disable trusting the use of the CPU's
 			random number generator (if available) to
 			initialize the kernel's RNG.
 
 	random.trust_bootloader=off
-			[KNL] Disable trusting the use of the a seed
+			[KNL,EARLY] Disable trusting the use of the a seed
 			passed by the bootloader (if available) to
 			initialize the kernel's RNG.
 
 	randomize_kstack_offset=
-			[KNL] Enable or disable kernel stack offset
+			[KNL,EARLY] Enable or disable kernel stack offset
 			randomization, which provides roughly 5 bits of
 			entropy, frustrating memory corruption attacks
 			that depend on stack address determinism or
@@ -5465,7 +5479,7 @@
 			Run specified binary instead of /init from the ramdisk,
 			used for early userspace startup. See initrd.
 
-	rdrand=		[X86]
+	rdrand=		[X86,EARLY]
 			force - Override the decision by the kernel to hide the
 				advertisement of RDRAND support (this affects
 				certain AMD processors because of buggy BIOS
@@ -5554,7 +5568,7 @@
 			them.  If <base> is less than 0x10000, the region
 			is assumed to be I/O ports; otherwise it is memory.
 
-	reservetop=	[X86-32]
+	reservetop=	[X86-32,EARLY]
 			Format: nn[KMG]
 			Reserves a hole at the top of the kernel virtual
 			address space.
@@ -5638,7 +5652,7 @@
 			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
 			CPUs.
 
-	riscv_isa_fallback [RISCV]
+	riscv_isa_fallback [RISCV,EARLY]
 			When CONFIG_RISCV_ISA_FALLBACK is not enabled, permit
 			falling back to detecting extension support by parsing
 			"riscv,isa" property on devicetree systems when the
@@ -5647,13 +5661,14 @@
 
 	ro		[KNL] Mount root device read-only on boot
 
-	rodata=		[KNL]
+	rodata=		[KNL,EARLY]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
 		full	Mark read-only kernel memory and aliases as read-only
 		        [arm64]
 
 	rockchip.usb_uart
+			[EARLY]
 			Enable the uart passthrough on the designated usb port
 			on Rockchip SoCs. When active, the signals of the
 			debug-uart get routed to the D+ and D- pins of the usb
@@ -5713,7 +5728,7 @@
 	sa1100ir	[NET]
 			See drivers/net/irda/sa1100_ir.c.
 
-	sched_verbose	[KNL] Enables verbose scheduler debug messages.
+	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
 			Allowed values are enable and disable. This feature
@@ -5828,7 +5843,7 @@
 			non-zero "wait" parameter.  See weight_single
 			and weight_many.
 
-	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
+	skew_tick=	[KNL,EARLY] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
 			Format: { "0" | "1" }
@@ -5959,10 +5974,10 @@
 				1: Fast pin select (default)
 				2: ATC IRMode
 
-	smt=		[KNL,MIPS,S390] Set the maximum number of threads (logical
-			CPUs) to use per physical CPU on systems capable of
-			symmetric multithreading (SMT). Will be capped to the
-			actual hardware limit.
+	smt=		[KNL,MIPS,S390,EARLY] Set the maximum number of threads
+			(logical CPUs) to use per physical CPU on systems
+			capable of symmetric multithreading (SMT). Will
+			be capped to the actual hardware limit.
 			Format: <integer>
 			Default: -1 (no limit)
 
@@ -5984,7 +5999,7 @@
 	sonypi.*=	[HW] Sony Programmable I/O Control Device driver
 			See Documentation/admin-guide/laptops/sonypi.rst
 
-	spectre_v2=	[X86] Control mitigation of Spectre variant 2
+	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
 			The default operation protects the kernel from
 			user space attacks.
@@ -6064,7 +6079,7 @@
 			spectre_v2_user=auto.
 
 	spec_rstack_overflow=
-			[X86] Control RAS overflow mitigation on AMD Zen CPUs
+			[X86,EARLY] Control RAS overflow mitigation on AMD Zen CPUs
 
 			off		- Disable mitigation
 			microcode	- Enable microcode mitigation only
@@ -6075,7 +6090,7 @@
 					  (cloud-specific mitigation)
 
 	spec_store_bypass_disable=
-			[HW] Control Speculative Store Bypass (SSB) Disable mitigation
+			[HW,EARLY] Control Speculative Store Bypass (SSB) Disable mitigation
 			(Speculative Store Bypass vulnerability)
 
 			Certain CPUs are vulnerable to an exploit against a
@@ -6171,7 +6186,7 @@
 			#DB exception for bus lock is triggered only when
 			CPL > 0.
 
-	srbds=		[X86,INTEL]
+	srbds=		[X86,INTEL,EARLY]
 			Control the Special Register Buffer Data Sampling
 			(SRBDS) mitigation.
 
@@ -6258,7 +6273,7 @@
 			srcutree.convert_to_big must have the 0x10 bit
 			set for contention-based conversions to occur.
 
-	ssbd=		[ARM64,HW]
+	ssbd=		[ARM64,HW,EARLY]
 			Speculative Store Bypass Disable control
 
 			On CPUs that are vulnerable to the Speculative
@@ -6282,7 +6297,7 @@
 			growing up) the main stack are reserved for no other
 			mapping. Default value is 256 pages.
 
-	stack_depot_disable= [KNL]
+	stack_depot_disable= [KNL,EARLY]
 			Setting this to true through kernel command line will
 			disable the stack depot thereby saving the static memory
 			consumed by the stack hash table. By default this is set
@@ -6321,12 +6336,12 @@
 			be used to filter out binaries which have
 			not yet been made aware of AT_MINSIGSTKSZ.
 
-	stress_hpt	[PPC]
+	stress_hpt	[PPC,EARLY]
 			Limits the number of kernel HPT entries in the hash
 			page table to increase the rate of hash page table
 			faults on kernel addresses.
 
-	stress_slb	[PPC]
+	stress_slb	[PPC,EARLY]
 			Limits the number of kernel SLB entries, and flushes
 			them frequently to increase the rate of SLB faults
 			on kernel addresses.
@@ -6386,7 +6401,7 @@
 			This parameter controls use of the Protected
 			Execution Facility on pSeries.
 
-	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
+	swiotlb=	[ARM,IA-64,PPC,MIPS,X86,EARLY]
 			Format: { <int> [,<int>] | force | noforce }
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
@@ -6396,7 +6411,7 @@
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
 
-	switches=	[HW,M68k]
+	switches=	[HW,M68k,EARLY]
 
 	sysctl.*=	[KNL]
 			Set a sysctl parameter, right before loading the init
@@ -6455,11 +6470,11 @@
 			<deci-seconds>: poll all this frequency
 			0: no polling (default)
 
-	threadirqs	[KNL]
+	threadirqs	[KNL,EARLY]
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
-	topology=	[S390]
+	topology=	[S390,EARLY]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
 			topology information if the hardware supports this.
@@ -6700,7 +6715,7 @@
 			can be overridden by a later tsc=nowatchdog.  A console
 			message will flag any such suppression or overriding.
 
-	tsc_early_khz=  [X86] Skip early TSC calibration and use the given
+	tsc_early_khz=  [X86,EARLY] Skip early TSC calibration and use the given
 			value instead. Useful when the early TSC frequency discovery
 			procedure is not reliable, such as on overclocked systems
 			with CPUID.16h support and partial CPUID.15h support.
@@ -6735,7 +6750,7 @@
 			See Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
 			for more details.
 
-	tsx_async_abort= [X86,INTEL] Control mitigation for the TSX Async
+	tsx_async_abort= [X86,INTEL,EARLY] Control mitigation for the TSX Async
 			Abort (TAA) vulnerability.
 
 			Similar to Micro-architectural Data Sampling (MDS)
@@ -6801,7 +6816,7 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
-	unwind_debug	[X86-64]
+	unwind_debug	[X86-64,EARLY]
 			Enable unwinder debug output.  This can be
 			useful for debugging certain unwinder error
 			conditions, including corrupt stacks and
@@ -6988,7 +7003,7 @@
 			Example: user_debug=31
 
 	userpte=
-			[X86] Flags controlling user PTE allocations.
+			[X86,EARLY] Flags controlling user PTE allocations.
 
 				nohigh = do not allocate PTE pages in
 					HIGHMEM regardless of setting
@@ -7017,7 +7032,7 @@
 	vector=		[IA-64,SMP]
 			vector=percpu: enable percpu vector domain
 
-	video=		[FB] Frame buffer configuration
+	video=		[FB,EARLY] Frame buffer configuration
 			See Documentation/fb/modedb.rst.
 
 	video.brightness_switch_enabled= [ACPI]
@@ -7065,13 +7080,13 @@
 			  P	Enable page structure init time poisoning
 			  -	Disable all of the above options
 
-	vmalloc=nn[KMG]	[KNL,BOOT] Forces the vmalloc area to have an exact
-			size of <nn>. This can be used to increase the
-			minimum size (128MB on x86). It can also be used to
-			decrease the size and leave more room for directly
-			mapped kernel RAM.
+	vmalloc=nn[KMG]	[KNL,BOOT,EARLY] Forces the vmalloc area to have an
+			exact size of <nn>. This can be used to increase
+			the minimum size (128MB on x86). It can also be
+			used to decrease the size and leave more room
+			for directly mapped kernel RAM.
 
-	vmcp_cma=nn[MG]	[KNL,S390]
+	vmcp_cma=nn[MG]	[KNL,S390,EARLY]
 			Sets the memory size reserved for contiguous memory
 			allocations for the vmcp device driver.
 
@@ -7084,7 +7099,7 @@
 	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
 			Format: <command>
 
-	vsyscall=	[X86-64]
+	vsyscall=	[X86-64,EARLY]
 			Controls the behavior of vsyscalls (i.e. calls to
 			fixed addresses of 0xffffffffff600x00 from legacy
 			code).  Most statically-linked binaries and older
@@ -7232,13 +7247,13 @@
 			When enabled, memory and cache locality will be
 			impacted.
 
-	writecombine=	[LOONGARCH] Control the MAT (Memory Access Type) of
-			ioremap_wc().
+	writecombine=	[LOONGARCH,EARLY] Control the MAT (Memory Access
+			Type) of ioremap_wc().
 
 			on   - Enable writecombine, use WUC for ioremap_wc()
 			off  - Disable writecombine, use SUC for ioremap_wc()
 
-	x2apic_phys	[X86-64,APIC] Use x2apic physical mode instead of
+	x2apic_phys	[X86-64,APIC,EARLY] Use x2apic physical mode instead of
 			default x2apic cluster mode on platforms
 			supporting x2apic.
 
@@ -7249,7 +7264,7 @@
 			save/restore/migration must be enabled to handle larger
 			domains.
 
-	xen_emul_unplug=		[HW,X86,XEN]
+	xen_emul_unplug=		[HW,X86,XEN,EARLY]
 			Unplug Xen emulated devices
 			Format: [unplug0,][unplug1]
 			ide-disks -- unplug primary master IDE devices
@@ -7261,17 +7276,17 @@
 				the unplug protocol
 			never -- do not unplug even if version check succeeds
 
-	xen_legacy_crash	[X86,XEN]
+	xen_legacy_crash	[X86,XEN,EARLY]
 			Crash from Xen panic notifier, without executing late
 			panic() code such as dumping handler.
 
-	xen_msr_safe=	[X86,XEN]
+	xen_msr_safe=	[X86,XEN,EARLY]
 			Format: <bool>
 			Select whether to always use non-faulting (safe) MSR
 			access functions when running as Xen PV guest. The
 			default value is controlled by CONFIG_XEN_PV_MSR_SAFE.
 
-	xen_nopvspin	[X86,XEN]
+	xen_nopvspin	[X86,XEN,EARLY]
 			Disables the qspinlock slowpath using Xen PV optimizations.
 			This parameter is obsoleted by "nopvspin" parameter, which
 			has equivalent effect for XEN platform.
@@ -7283,7 +7298,7 @@
 			has equivalent effect for XEN platform.
 
 	xen_no_vector_callback
-			[KNL,X86,XEN] Disable the vector callback for Xen
+			[KNL,X86,XEN,EARLY] Disable the vector callback for Xen
 			event channel interrupts.
 
 	xen_scrub_pages=	[XEN]
@@ -7292,7 +7307,7 @@
 			with /sys/devices/system/xen_memory/xen_memory0/scrub_pages.
 			Default value controlled with CONFIG_XEN_SCRUB_PAGES_DEFAULT.
 
-	xen_timer_slop=	[X86-64,XEN]
+	xen_timer_slop=	[X86-64,XEN,EARLY]
 			Set the timer slop (in nanoseconds) for the virtual Xen
 			timers (default is 100000). This adjusts the minimum
 			delta of virtualized Xen timers, where lower values
@@ -7345,7 +7360,7 @@
 			host controller quirks. Meaning of each bit can be
 			consulted in header drivers/usb/host/xhci.h.
 
-	xmon		[PPC]
+	xmon		[PPC,EARLY]
 			Format: { early | on | rw | ro | off }
 			Controls if xmon debugger is enabled. Default is off.
 			Passing only "xmon" is equivalent to "xmon=early".


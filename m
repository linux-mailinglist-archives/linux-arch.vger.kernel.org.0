Return-Path: <linux-arch+bounces-15048-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC6C7C6A4
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 954323636E0
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E869E256C9E;
	Sat, 22 Nov 2025 04:42:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD29246781;
	Sat, 22 Nov 2025 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786576; cv=none; b=rz9JigSeofFl+8BYKcAqV/vGxMhT/qx0nkjRC1VGBh5uWln5QCdBfvXIMLZn/zcY7QNphRwawWql0Wt6uOLyC6UPWe75jVpMKFyVWCC5rOagRynkQ4TCIH+QAR1x89tNyzW2p8+D0aOokPkruq92/RpvfYgibGJHWJbwBymfsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786576; c=relaxed/simple;
	bh=hOJUJTEEDg+tz+JYhaYTqRrErGq34xDsPjk1g0VAr6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+U6LHfkXpyAWt5dFlN2Xb7WAgG9eeAqJLF64oypNSjwhYnopg6ehGCj2aCNiDwQUepTKTrBCudJDSfhBx+/h4OrOEn1vzOIdNRhCHeTWh4cMtA+JM7Yc6b0PEG8D4+cdP05xxZGerVcc7eEuMJAkwt7HSBtXri2pfcoz2yjneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD10FC4CEF5;
	Sat, 22 Nov 2025 04:42:53 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 14/14] LoongArch: Adjust build infrastructure for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:34 +0800
Message-ID: <20251122043634.3447854-15-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122043634.3447854-1-chenhuacai@loongson.cn>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust build infrastructure (Kconfig, Makefile and ld scripts) to let
us enable both 32BIT/64BIT kernel build.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                | 113 ++++++++++++++++++--------
 arch/loongarch/Makefile               |  22 ++++-
 arch/loongarch/boot/Makefile          |   6 ++
 arch/loongarch/kernel/vmlinux.lds.S   |   7 +-
 arch/loongarch/kvm/Kconfig            |   2 +-
 arch/loongarch/lib/Makefile           |   5 +-
 drivers/firmware/efi/libstub/Makefile |   1 +
 drivers/pci/controller/Kconfig        |   2 +-
 lib/crc/Kconfig                       |   2 +-
 9 files changed, 119 insertions(+), 41 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 730f34214519..4bacde9f46d1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -21,11 +21,11 @@ config LOONGARCH
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
-	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if 64BIT && CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PREEMPT_LAZY
-	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_PTE_SPECIAL if 64BIT
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
@@ -60,16 +60,15 @@ config LOONGARCH
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
-	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_SUPPORTS_HUGETLBFS if 64BIT
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
-	select ARCH_SUPPORTS_NUMA_BALANCING
+	select ARCH_SUPPORTS_NUMA_BALANCING if NUMA
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SCHED_SMT if SMP
@@ -79,10 +78,10 @@ config LOONGARCH
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-	select ARCH_WANT_DEFAULT_BPF_JIT
+	select ARCH_WANT_DEFAULT_BPF_JIT if HAVE_EBPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
+	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP if 64BIT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BUILDTIME_TABLE_SORT
@@ -90,13 +89,14 @@ config LOONGARCH
 	select CPU_PM
 	select EDAC_SUPPORT
 	select EFI
+	select GENERIC_ATOMIC64 if 32BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
-	select GENERIC_GETTIMEOFDAY
+	select GENERIC_GETTIMEOFDAY if 64BIT
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
 	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_IRQ_MULTI_HANDLER
@@ -111,15 +111,15 @@ config LOONGARCH
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL
+	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_BITREVERSE if 64BIT
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
-	select HAVE_ARCH_KASAN
-	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KASAN if 64BIT
+	select HAVE_ARCH_KFENCE if 64BIT
 	select HAVE_ARCH_KGDB if PERF_EVENTS
 	select HAVE_ARCH_KSTACK_ERASE
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
@@ -127,8 +127,8 @@ config LOONGARCH
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
-	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT
+	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
@@ -140,7 +140,7 @@ config LOONGARCH
 	select HAVE_FTRACE_REGS_HAVING_PT_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select HAVE_EBPF_JIT
+	select HAVE_EBPF_JIT if 64BIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
 	select HAVE_GENERIC_TIF_BITS
@@ -163,9 +163,9 @@ config LOONGARCH
 	select HAVE_LIVEPATCH
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB
+	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && 64BIT
 	select HAVE_PCI
-	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS if 64BIT
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
@@ -205,18 +205,50 @@ config LOONGARCH
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select SYSCTL_EXCEPTION_TRACE
-	select SWIOTLB
+	select SWIOTLB if 64BIT
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
 	select VDSO_GETRANDOM
-	select ZONE_DMA32
+	select ZONE_DMA32 if 64BIT
+
+menu "Kernel type and options"
+
+choice
+	prompt "Kernel type"
 
 config 32BIT
-	bool
+	bool "32-bit kernel"
+	help
+	  Select this option if you want to build a 32-bit kernel.
 
 config 64BIT
-	def_bool y
+	bool "64-bit kernel"
+	help
+	  Select this option if you want to build a 64-bit kernel.
+
+endchoice
+
+if 32BIT
+
+choice
+	prompt "32-bit kernel sub-type"
+
+config 32BIT_REDUCED
+	bool "32-bit kernel for LA32R"
+	help
+	  Select this option if you want to build a 32-bit kernel for
+	  LoongArch32 Reduced (LA32R).
+
+config 32BIT_STANDARD
+	bool "32-bit kernel for LA32S"
+	help
+	  Select this option if you want to build a 32-bit kernel for
+	  LoongArch32 Standard (LA32S).
+
+endchoice
+
+endif
 
 config GENERIC_BUG
 	def_bool y
@@ -306,8 +338,6 @@ config RUSTC_HAS_ANNOTATE_TABLEJUMP
 	depends on RUST
 	def_bool $(rustc-option,-Cllvm-args=--loongarch-annotate-tablejump)
 
-menu "Kernel type and options"
-
 source "kernel/Kconfig.hz"
 
 choice
@@ -319,8 +349,17 @@ choice
 	  of page size and page table levels. The size of virtual memory
 	  address space are determined by the page table layout.
 
+config 4KB_2LEVEL
+	bool "4KB with 2 levels"
+	select HAVE_PAGE_SIZE_4KB
+	select PGTABLE_2LEVEL
+	help
+	  This option selects 16KB page size with 2 level page tables, which
+	  support a maximum of 32 bits of application virtual memory.
+
 config 4KB_3LEVEL
 	bool "4KB with 3 levels"
+	depends on 64BIT
 	select HAVE_PAGE_SIZE_4KB
 	select PGTABLE_3LEVEL
 	help
@@ -329,6 +368,7 @@ config 4KB_3LEVEL
 
 config 4KB_4LEVEL
 	bool "4KB with 4 levels"
+	depends on 64BIT
 	select HAVE_PAGE_SIZE_4KB
 	select PGTABLE_4LEVEL
 	help
@@ -345,6 +385,7 @@ config 16KB_2LEVEL
 
 config 16KB_3LEVEL
 	bool "16KB with 3 levels"
+	depends on 64BIT
 	select HAVE_PAGE_SIZE_16KB
 	select PGTABLE_3LEVEL
 	help
@@ -361,6 +402,7 @@ config 64KB_2LEVEL
 
 config 64KB_3LEVEL
 	bool "64KB with 3 levels"
+	depends on 64BIT
 	select HAVE_PAGE_SIZE_64KB
 	select PGTABLE_3LEVEL
 	help
@@ -458,6 +500,7 @@ config EFI_STUB
 
 config SMP
 	bool "Multi-Processing support"
+	depends on 64BIT
 	help
 	  This enables support for systems with more than one CPU. If you have
 	  a system with only one CPU, say N. If you have a system with more
@@ -496,6 +539,7 @@ config NR_CPUS
 config NUMA
 	bool "NUMA Support"
 	select SMP
+	depends on 64BIT
 	help
 	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
 	  support.  This option improves performance on systems with more
@@ -578,7 +622,7 @@ config CPU_HAS_FPU
 
 config CPU_HAS_LSX
 	bool "Support for the Loongson SIMD Extension"
-	depends on AS_HAS_LSX_EXTENSION
+	depends on AS_HAS_LSX_EXTENSION && 64BIT
 	help
 	  Loongson SIMD Extension (LSX) introduces 128 bit wide vector registers
 	  and a set of SIMD instructions to operate on them. When this option
@@ -593,7 +637,7 @@ config CPU_HAS_LSX
 config CPU_HAS_LASX
 	bool "Support for the Loongson Advanced SIMD Extension"
 	depends on CPU_HAS_LSX
-	depends on AS_HAS_LASX_EXTENSION
+	depends on AS_HAS_LASX_EXTENSION && 64BIT
 	help
 	  Loongson Advanced SIMD Extension (LASX) introduces 256 bit wide vector
 	  registers and a set of SIMD instructions to operate on them. When this
@@ -607,7 +651,7 @@ config CPU_HAS_LASX
 
 config CPU_HAS_LBT
 	bool "Support for the Loongson Binary Translation Extension"
-	depends on AS_HAS_LBT_EXTENSION
+	depends on AS_HAS_LBT_EXTENSION && 64BIT
 	help
 	  Loongson Binary Translation (LBT) introduces 4 scratch registers (SCR0
 	  to SCR3), x86/ARM eflags (eflags) and x87 fpu stack pointer (ftop).
@@ -635,13 +679,13 @@ config ARCH_SELECTS_KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 
 config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool y
+	def_bool 64BIT
 
 config ARCH_DEFAULT_CRASH_DUMP
-	def_bool y
+	def_bool 64BIT
 
 config ARCH_SELECTS_CRASH_DUMP
-	def_bool y
+	def_bool 64BIT
 	depends on CRASH_DUMP
 	select RELOCATABLE
 
@@ -650,6 +694,7 @@ config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 
 config RELOCATABLE
 	bool "Relocatable kernel"
+	depends on 64BIT
 	select ARCH_HAS_RELR
 	help
 	  This builds the kernel as a Position Independent Executable (PIE),
@@ -686,7 +731,7 @@ source "kernel/livepatch/Kconfig"
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
-	depends on AS_HAS_LVZ_EXTENSION
+	depends on AS_HAS_LVZ_EXTENSION && 64BIT
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
@@ -714,7 +759,7 @@ config ARCH_FLATMEM_ENABLE
 	depends on !NUMA
 
 config ARCH_SPARSEMEM_ENABLE
-	def_bool y
+	def_bool 64BIT
 	select SPARSEMEM_VMEMMAP_ENABLE
 	help
 	  Say Y to support efficient handling of sparse physical memory,
@@ -731,10 +776,12 @@ config MMU
 	default y
 
 config ARCH_MMAP_RND_BITS_MIN
-	default 12
+	default 10 if 32BIT
+	default 12 if 64BIT
 
 config ARCH_MMAP_RND_BITS_MAX
-	default 18
+	default 15 if 32BIT
+	default 18 if 64BIT
 
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index cf9373786969..9d54dccc1625 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -51,7 +51,10 @@ KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
 
-ifdef CONFIG_64BIT
+ifdef CONFIG_32BIT
+tool-archpref		= $(32bit-tool-archpref)
+UTS_MACHINE		:= loongarch32
+else
 tool-archpref		= $(64bit-tool-archpref)
 UTS_MACHINE		:= loongarch64
 endif
@@ -62,9 +65,19 @@ ifneq ($(SUBARCH),$(ARCH))
   endif
 endif
 
+ifdef CONFIG_32BIT
+ifdef CONFIG_32BIT_STANDARD
+ld-emul			= $(32bit-emul)
+cflags-y		+= -march=la32v1.0 -mabi=ilp32s -mcmodel=normal
+else  # CONFIG_32BIT_REDUCED
+ld-emul			= $(32bit-emul)
+cflags-y		+= -march=la32rv1.0 -mabi=ilp32s -mcmodel=normal
+endif
+endif
+
 ifdef CONFIG_64BIT
 ld-emul			= $(64bit-emul)
-cflags-y		+= -mabi=lp64s -mcmodel=normal
+cflags-y		+= -march=loongarch64 -mabi=lp64s -mcmodel=normal
 endif
 
 cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
@@ -140,7 +153,12 @@ ifndef CONFIG_KASAN
 cflags-y += -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-memset
 endif
 
+ifdef CONFIG_32BIT
+load-y		= 0xa0200000
+else
 load-y		= 0x9000000000200000
+endif
+
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
 
 drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
index 4e1c374c5782..8b6d9b42b5f0 100644
--- a/arch/loongarch/boot/Makefile
+++ b/arch/loongarch/boot/Makefile
@@ -20,7 +20,13 @@ $(obj)/vmlinux.efi: vmlinux FORCE
 	$(call if_changed,objcopy)
 
 EFI_ZBOOT_PAYLOAD      := vmlinux.efi
+
+ifdef CONFIG_32BIT
+EFI_ZBOOT_BFD_TARGET   := elf32-loongarch
+EFI_ZBOOT_MACH_TYPE    := LOONGARCH32
+else
 EFI_ZBOOT_BFD_TARGET   := elf64-loongarch
 EFI_ZBOOT_MACH_TYPE    := LOONGARCH64
+endif
 
 include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 08ea921cdec1..b95c0acdab90 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -6,7 +6,12 @@
 
 #define PAGE_SIZE _PAGE_SIZE
 #define RO_EXCEPTION_TABLE_ALIGN	4
-#define PHYSADDR_MASK			0xffffffffffff /* 48-bit */
+
+#ifdef CONFIG_32BIT
+#define PHYSADDR_MASK			0x1fffffff	/* 29-bit */
+#else
+#define PHYSADDR_MASK			0xffffffffffff	/* 48-bit */
+#endif
 
 /*
  * Put .bss..swapper_pg_dir as the first thing in .bss. This will
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index ae64bbdf83a7..3dc5ebc546d5 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -19,7 +19,7 @@ if VIRTUALIZATION
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
-	depends on AS_HAS_LVZ_EXTENSION
+	depends on AS_HAS_LVZ_EXTENSION && 64BIT
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_IRQCHIP
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index ccea3bbd4353..d8f1e8559487 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,8 +3,9 @@
 # Makefile for LoongArch-specific library files.
 #
 
-lib-y	+= delay.o memset.o memcpy.o memmove.o \
-	   clear_user.o copy_user.o csum.o dump_tlb.o unaligned.o
+lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o unaligned.o
+
+lib-$(CONFIG_64BIT) += memset.o memcpy.o memmove.o csum.o
 
 obj-$(CONFIG_ARCH_SUPPORTS_INT128) += tishift.o
 
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 94b05e4451dd..2ba0f7c400a7 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -97,6 +97,7 @@ zboot-obj-$(CONFIG_KERNEL_ZSTD)	:= zboot-decompress-zstd.o lib-xxhash.o
 CFLAGS_zboot-decompress-zstd.o	+= -I$(srctree)/lib/zstd
 
 zboot-obj-$(CONFIG_RISCV)	+= lib-clz_ctz.o lib-ashldi3.o
+zboot-obj-$(CONFIG_LOONGARCH)	+= lib-clz_ctz.o lib-ashldi3.o
 lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
 lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 41748d083b93..35ef71b0695d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -171,7 +171,7 @@ config VMD
 
 config PCI_LOONGSON
 	bool "LOONGSON PCIe controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON32 || MACH_LOONGSON64 || COMPILE_TEST
 	depends on OF || ACPI
 	depends on PCI_QUIRKS
 	default MACH_LOONGSON64
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
index 70e7a6016de3..5bf613405fdd 100644
--- a/lib/crc/Kconfig
+++ b/lib/crc/Kconfig
@@ -65,7 +65,7 @@ config CRC32_ARCH
 	depends on CRC32 && CRC_OPTIMIZATIONS
 	default y if ARM && KERNEL_MODE_NEON
 	default y if ARM64
-	default y if LOONGARCH
+	default y if LOONGARCH && 64BIT
 	default y if MIPS && CPU_MIPSR6
 	default y if PPC64 && ALTIVEC
 	default y if RISCV && RISCV_ISA_ZBC
-- 
2.47.3



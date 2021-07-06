Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8333BC532
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGFEUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEUv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:20:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A89C6198D;
        Tue,  6 Jul 2021 04:18:09 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 03/19] LoongArch: Add build infrastructure
Date:   Tue,  6 Jul 2021 12:18:04 +0800
Message-Id: <20210706041820.1536502-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds Kbuild, Makefile, Kconfig and link script for LoongArch
build infrastructure.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/.gitignore              |  11 +
 arch/loongarch/Kbuild                  |  21 ++
 arch/loongarch/Kbuild.platforms        |   6 +
 arch/loongarch/Kconfig                 | 403 +++++++++++++++++++++++++
 arch/loongarch/Kconfig.debug           |   0
 arch/loongarch/Makefile                | 121 ++++++++
 arch/loongarch/include/asm/Kbuild      |  30 ++
 arch/loongarch/include/uapi/asm/Kbuild |   2 +
 arch/loongarch/kernel/Makefile         |  24 ++
 arch/loongarch/kernel/vmlinux.lds.S    | 112 +++++++
 arch/loongarch/lib/Makefile            |   7 +
 arch/loongarch/loongson64/Makefile     |   8 +
 arch/loongarch/loongson64/Platform     |  14 +
 arch/loongarch/mm/Makefile             |  10 +
 arch/loongarch/pci/Makefile            |   9 +
 scripts/subarch.include                |   2 +-
 16 files changed, 779 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/.gitignore
 create mode 100644 arch/loongarch/Kbuild
 create mode 100644 arch/loongarch/Kbuild.platforms
 create mode 100644 arch/loongarch/Kconfig
 create mode 100644 arch/loongarch/Kconfig.debug
 create mode 100644 arch/loongarch/Makefile
 create mode 100644 arch/loongarch/include/asm/Kbuild
 create mode 100644 arch/loongarch/include/uapi/asm/Kbuild
 create mode 100644 arch/loongarch/kernel/Makefile
 create mode 100644 arch/loongarch/kernel/vmlinux.lds.S
 create mode 100644 arch/loongarch/lib/Makefile
 create mode 100644 arch/loongarch/loongson64/Makefile
 create mode 100644 arch/loongarch/loongson64/Platform
 create mode 100644 arch/loongarch/mm/Makefile
 create mode 100644 arch/loongarch/pci/Makefile

diff --git a/arch/loongarch/.gitignore b/arch/loongarch/.gitignore
new file mode 100644
index 000000000000..7e6b000a7f3e
--- /dev/null
+++ b/arch/loongarch/.gitignore
@@ -0,0 +1,11 @@
+*.lds
+*.raw
+calc_vmlinuz_load_addr
+elf-entry
+relocs
+vmlinux.*
+vmlinuz.*
+vdso/genvdso
+vdso/vdso-image.c
+
+!kernel/vmlinux.lds.S
diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
new file mode 100644
index 000000000000..e997ba117bd9
--- /dev/null
+++ b/arch/loongarch/Kbuild
@@ -0,0 +1,21 @@
+# Fail on warnings - also for files referenced in subdirs
+# -Werror can be disabled for specific files using:
+# CFLAGS_<file.o> := -Wno-error
+ifeq ($(W),)
+subdir-ccflags-y := -Werror
+endif
+
+# platform specific definitions
+include arch/loongarch/Kbuild.platforms
+obj-y := $(platform-y)
+
+# make clean traverses $(obj-) without having included .config, so
+# everything ends up here
+obj- := $(platform-)
+
+# LoongArch object files
+# The object files are linked as core-y files would be linked
+
+obj-y += kernel/
+obj-y += mm/
+obj-y += vdso/
diff --git a/arch/loongarch/Kbuild.platforms b/arch/loongarch/Kbuild.platforms
new file mode 100644
index 000000000000..ad390d5c00f2
--- /dev/null
+++ b/arch/loongarch/Kbuild.platforms
@@ -0,0 +1,6 @@
+# All platforms listed in alphabetic order
+
+platforms += loongson64
+
+# include the platform specific files
+include $(patsubst %, $(srctree)/arch/loongarch/%/Platform, $(platforms))
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
new file mode 100644
index 000000000000..7d5889a264c6
--- /dev/null
+++ b/arch/loongarch/Kconfig
@@ -0,0 +1,403 @@
+# SPDX-License-Identifier: GPL-2.0
+config LOONGARCH
+	bool
+	default y
+	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ARCH_BINFMT_ELF_STATE
+	select ARCH_DISCARD_MEMBLOCK
+	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_PTE_SPECIAL if !32BIT
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_INLINE_READ_LOCK if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_SUPPORTS_ACPI
+	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select BUILDTIME_TABLE_SORT
+	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE
+	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IOMAP
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_UCMPDI2
+	select GENERIC_TIME_VSYSCALL
+	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_COMPILER_H
+	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ASM_MODVERSIONS
+	select HAVE_CBPF_JIT if !64BIT
+	select HAVE_EBPF_JIT if 64BIT
+	select HAVE_CONTEXT_TRACKING
+	select HAVE_COPY_THREAD_TLS
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_CONTIGUOUS
+	select HAVE_EXIT_THREAD
+	select HAVE_FAST_GUP
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_GENERIC_VDSO
+	select HAVE_IDE
+	select HAVE_IOREMAP_PROT
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NMI
+	select HAVE_PERF_EVENTS
+	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT
+	select IRQ_FORCED_THREADING
+	select MODULES_USE_ELF_RELA if MODULES && 64BIT
+	select MODULES_USE_ELF_REL if MODULES
+	select PCI_DOMAINS if PCI
+	select PCI_MSI_ARCH_FALLBACKS
+	select PERF_USE_VMALLOC
+	select RTC_LIB
+	select SYSCTL_EXCEPTION_TRACE
+	select VIRT_TO_BUS
+
+menu "Machine selection"
+
+choice
+	prompt "System type"
+	default MACH_LOONGSON64
+
+config MACH_LOONGSON64
+	bool "Loongson 64-bit family of machines"
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO
+	select GENERIC_ISA_DMA
+	select HAVE_PCI
+	select ISA
+	select PCI
+	select IRQ_LOONGARCH_CPU
+	select NR_CPUS_DEFAULT_4
+	select SPARSE_IRQ
+	select SYS_HAS_CPU_LOONGSON64
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select ZONE_DMA32
+	help
+	  This enables the support of Loongson 64-bit family of machines. These
+	  machines are based on new Loongson-3 processors (Old Loongson is MIPS
+	  compatible, while new Loongson is based on LoongArch ISA).
+
+endchoice
+
+endmenu
+
+config GENERIC_HWEIGHT
+	bool
+	default y
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config SCHED_OMIT_FRAME_POINTER
+	bool
+	default y
+
+config GENERIC_CSUM
+	def_bool y
+
+config GENERIC_ISA_DMA
+	bool
+
+config L1_CACHE_SHIFT
+	int
+	default "6"
+
+menu "CPU selection"
+
+choice
+	prompt "CPU type"
+	default CPU_LOONGSON64
+
+config CPU_LOONGSON64
+	bool "Loongson 64-bit CPU"
+	depends on SYS_HAS_CPU_LOONGSON64
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select GPIOLIB
+	select SWIOTLB
+	select ARCH_SUPPORTS_ATOMIC_RMW
+	help
+	  The Loongson 64-bit processor implements the LoongArch64 (the 64-bit
+	  version of LoongArch) instruction set.
+
+endchoice
+
+config SYS_HAS_CPU_LOONGSON64
+	bool
+
+endmenu
+
+config SYS_SUPPORTS_32BIT_KERNEL
+	bool
+config SYS_SUPPORTS_64BIT_KERNEL
+	bool
+config CPU_SUPPORTS_32BIT_KERNEL
+	bool
+config CPU_SUPPORTS_64BIT_KERNEL
+	bool
+
+menu "Kernel type"
+
+choice
+	prompt "Kernel code model"
+	help
+	  You should only select this option if you have a workload that
+	  actually benefits from 64-bit processing or if your machine has
+	  large memory.  You will only be presented a single option in this
+	  menu if your system does not support both 32-bit and 64-bit kernels.
+
+config 32BIT
+	bool "32-bit kernel"
+	depends on CPU_SUPPORTS_32BIT_KERNEL && SYS_SUPPORTS_32BIT_KERNEL
+	help
+	  Select this option if you want to build a 32-bit kernel.
+
+config 64BIT
+	bool "64-bit kernel"
+	depends on CPU_SUPPORTS_64BIT_KERNEL && SYS_SUPPORTS_64BIT_KERNEL
+	help
+	  Select this option if you want to build a 64-bit kernel.
+
+endchoice
+
+choice
+	prompt "Kernel page size"
+	default PAGE_SIZE_16KB
+
+config PAGE_SIZE_4KB
+	bool "4kB"
+	help
+	  This option select the standard 4kB Linux page size.
+
+config PAGE_SIZE_16KB
+	bool "16kB"
+	help
+	  This option select the standard 16kB Linux page size.
+
+config PAGE_SIZE_64KB
+	bool "64kB"
+	help
+	  This option select the standard 64kB Linux page size.
+
+endchoice
+
+choice
+	prompt "Virtual memory address space bits"
+	default VA_BITS_40
+	help
+	  Allows choosing one of multiple possible virtual memory
+	  address space bits for applications. The level of page
+	  translation table is determined by a combination of page
+	  size and virtual memory address space bits.
+
+config VA_BITS_40
+	bool "40-bits"
+	depends on 64BIT
+	help
+	  Support a maximum at least 40 bits of application virtual memory.
+
+config VA_BITS_48
+	bool "48-bits"
+	depends on 64BIT
+	help
+	  Support a maximum at least 48 bits of application virtual memory.
+
+endchoice
+
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	range 14 64 if PAGE_SIZE_64KB
+	default "14" if PAGE_SIZE_64KB
+	range 12 64 if PAGE_SIZE_16KB
+	default "12" if PAGE_SIZE_16KB
+	range 11 64
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
+	  The page size is not necessarily 4KB.  Keep this in mind
+	  when choosing a value for this option.
+
+config CPU_HAS_PREFETCH
+	bool
+	default y
+
+config CPU_HAS_FPU
+	bool
+	default y
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool y
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_STATIC
+	help
+	  Say Y to support efficient handling of sparse physical memory,
+	  for architectures which are either NUMA (Non-Uniform Memory Access)
+	  or have huge holes in the physical address space for other reasons.
+	  See <file:Documentation/vm/numa.rst> for more.
+
+config DMI
+	bool "Enable DMI scanning"
+	select DMI_SCAN_MACHINE_NON_EFI_FALLBACK
+	default y
+	help
+	  Enabled scanning of DMI to identify machine quirks. Say Y
+	  here unless you have verified that your setup is not
+	  affected by entries in the DMI blacklist. Required by PNP
+	  BIOS code.
+
+config EFI
+	bool "EFI runtime service support"
+	select UCS2_STRING
+	select EFI_RUNTIME_WRAPPERS
+	help
+	  This enables the kernel to use EFI runtime services that are
+	  available (such as the EFI variable services).
+
+	  This option is only useful on systems that have EFI firmware.
+	  In addition, you should use the latest ELILO loader available
+	  at <http://elilo.sourceforge.net> in order to take advantage
+	  of EFI runtime services. However, even with this option, the
+	  resultant kernel should continue to boot on existing non-EFI
+	  platforms.
+
+source "kernel/Kconfig.hz"
+
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	depends on PROC_FS
+	default y
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via /proc/<pid>/seccomp, it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
+endmenu
+
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+	depends on LOONGARCH
+
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
+config PGTABLE_LEVELS
+	int
+	default 4 if PAGE_SIZE_4KB && VA_BITS_48
+	default 2 if PAGE_SIZE_64KB && VA_BITS_40
+	default 3
+
+config MMU
+	bool
+	default y
+
+config ARCH_MMAP_RND_BITS_MIN
+	default 12 if 64BIT
+	default 8
+
+config ARCH_MMAP_RND_BITS_MAX
+	default 18 if 64BIT
+	default 15
+
+config ZONE_DMA
+	bool
+
+config ZONE_DMA32
+	bool
+
+menu "Bus options"
+
+config ISA
+	bool
+
+config PCI_MMCONFIG
+	bool
+	default y
+	depends on PCI && ACPI
+
+endmenu
+
+menu "Power management options"
+
+source "drivers/acpi/Kconfig"
+
+endmenu
+
+source "drivers/firmware/Kconfig"
diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
new file mode 100644
index 000000000000..d339049e9022
--- /dev/null
+++ b/arch/loongarch/Makefile
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Author: Huacai Chen <chenhuacai@loongson.cn>
+# Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+
+#
+# Select the object file format to substitute into the linker script.
+#
+64bit-tool-archpref	= loongarch64
+32bit-bfd		= elf32-loongarch
+64bit-bfd		= elf64-loongarch
+32bit-emul		= elf32loongarch
+64bit-emul		= elf64loongarch
+
+ifdef CONFIG_64BIT
+tool-archpref		= $(64bit-tool-archpref)
+UTS_MACHINE		:= loongarch64
+endif
+
+ifneq ($(SUBARCH),$(ARCH))
+  ifeq ($(CROSS_COMPILE),)
+    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
+  endif
+endif
+
+cflags-y += $(call cc-option, -mno-check-zero-division)
+
+ifdef CONFIG_64BIT
+ld-emul			= $(64bit-emul)
+cflags-y		+= -mabi=lp64
+endif
+
+all-y			:= vmlinux
+
+#
+# GCC uses -G 0 -mabicalls -fpic as default.  We don't want PIC in the kernel
+# code since it only slows down the whole thing.  At some point we might make
+# use of global pointer optimizations but their use of $r2 conflicts with
+# the current pointer optimization.
+#
+cflags-y			+= -G 0 -pipe
+cflags-y			+= -msoft-float
+LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
+KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
+KBUILD_CFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
+KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
+KBUILD_CFLAGS_MODULE		+= -fno-plt -Wa,-mla-global-with-abs,-mla-local-with-abs
+
+cflags-y += -ffreestanding
+
+# Some distribution-specific toolchains might pass the -fstack-check
+# option during the build, which adds a simple stack-probe at the beginning
+# of every function.  This stack probe is to ensure that there is enough
+# stack space, else a SEGV is generated.  This is not desirable for LoongArch
+# as kernel stacks are small, placed in unmapped virtual memory, and do not
+# grow when overflowed.
+#
+cflags-y += -fno-stack-check
+
+#
+# Board-dependent options and extra files
+#
+include arch/loongarch/Kbuild.platforms
+
+ifdef CONFIG_PHYSICAL_START
+load-y				= $(CONFIG_PHYSICAL_START)
+endif
+
+drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
+
+KBUILD_AFLAGS	+= $(cflags-y)
+KBUILD_CFLAGS	+= $(cflags-y)
+KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
+
+bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) PLATFORM="$(platform-y)"
+
+ifdef CONFIG_64BIT
+bootvars-y	+= ADDR_BITS=64
+endif
+
+# This is required to get dwarf unwinding tables into .debug_frame
+# instead of .eh_frame so we don't discard them.
+KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
+
+KBUILD_LDFLAGS	+= -m $(ld-emul)
+
+ifdef CONFIG_LOONGARCH
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
+	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
+endif
+
+head-y := arch/loongarch/kernel/head.o
+
+libs-y += arch/loongarch/lib/
+
+# See arch/loongarch/Kbuild for content of core part of the kernel
+core-y += arch/loongarch/
+
+# boot image targets (arch/loongarch/boot/)
+boot-y			:= vmlinux.bin
+
+all:	$(all-y)
+
+# boot
+$(boot-y): vmlinux FORCE
+	$(Q)$(MAKE) $(build)=arch/loongarch/boot VMLINUX=vmlinux \
+		$(bootvars-y) arch/loongarch/boot/$@
+
+CLEAN_FILES += vmlinux
+
+install:
+	$(Q)install -D -m 755 vmlinux $(INSTALL_PATH)/vmlinux-$(KERNELRELEASE)
+	$(Q)install -D -m 644 .config $(INSTALL_PATH)/config-$(KERNELRELEASE)
+	$(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KERNELRELEASE)
+
+define archhelp
+	echo '  install              - install kernel into $(INSTALL_PATH)'
+	echo '  vmlinux.bin          - Raw binary boot image'
+	echo
+endef
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
new file mode 100644
index 000000000000..10d6c39eb8b1
--- /dev/null
+++ b/arch/loongarch/include/asm/Kbuild
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+generic-y += dma-contiguous.h
+generic-y += export.h
+generic-y += mcs_spinlock.h
+generic-y += parport.h
+generic-y += early_ioremap.h
+generic-y += qrwlock.h
+generic-y += qspinlock.h
+generic-y += rwsem.h
+generic-y += segment.h
+generic-y += user.h
+generic-y += rwsem.h
+generic-y += stat.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += statfs.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += termios.h
+generic-y += termbits.h
+generic-y += poll.h
+generic-y += param.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += kvm_para.h
diff --git a/arch/loongarch/include/uapi/asm/Kbuild b/arch/loongarch/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..4aa680ca2e5f
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+generic-y += kvm_para.h
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
new file mode 100644
index 000000000000..e37f8016d93c
--- /dev/null
+++ b/arch/loongarch/kernel/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux/LoongArch kernel.
+#
+
+extra-y		:= head.o vmlinux.lds
+
+obj-y		+= cmpxchg.o cpu-probe.o elf.o entry.o genex.o idle.o irq.o \
+		   process.o ptrace.o reset.o setup.o signal.o io.o \
+		   syscall.o time.o topology.o traps.o unaligned.o \
+		   cmdline.o switch.o cacheinfo.o vdso.o
+
+obj-$(CONFIG_ACPI)		+= acpi.o
+obj-$(CONFIG_EFI) 		+= efi.o
+
+obj-$(CONFIG_MODULES)		+= module.o
+
+obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
+
+obj-$(CONFIG_64BIT)		+= scall64.o
+
+obj-$(CONFIG_PROC_FS)		+= proc.o
+
+CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..3ae212100de5
--- /dev/null
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+
+#define PAGE_SIZE _PAGE_SIZE
+
+/*
+ * Put .bss..swapper_pg_dir as the first thing in .bss. This will
+ * ensure that it has .bss alignment (64K).
+ */
+#define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
+
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_ARCH(loongarch)
+ENTRY(kernel_entry)
+PHDRS {
+	text PT_LOAD FLAGS(7);	/* RWX */
+	note PT_NOTE FLAGS(4);	/* R__ */
+}
+
+jiffies	 = jiffies_64;
+
+SECTIONS
+{
+	. = VMLINUX_LOAD_ADDRESS;
+	/* Read-only */
+	_text = .;	/* Text and read-only data */
+	.text : {
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+		*(.fixup)
+		*(.gnu.warning)
+	} :text = 0
+	_etext = .;	/* End of text section */
+
+	EXCEPTION_TABLE(16)
+
+	_sdata = .;			/* Start of data section */
+	RO_DATA(4096)
+	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
+
+	/* We want the small data sections together, so single-instruction offsets
+	   can access them all, and initialized data all before uninitialized, so
+	   we can shorten the on-disk segment size.  */
+	.sdata : {
+		*(.sdata)
+	}
+	_edata =  .;			/* End of data section */
+
+	/* Will be freed after init */
+	. = ALIGN(PAGE_SIZE);		/* Init code and data */
+	__init_begin = .;
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+
+	. = ALIGN(4);
+
+	/* .exit.text is discarded at runtime, not link time, to deal with
+	 * references from .rodata
+	 */
+	.exit.text : {
+		EXIT_TEXT
+	}
+	.exit.data : {
+		EXIT_DATA
+	}
+
+	/*
+	 * Align to 64K in attempt to eliminate holes before the
+	 * .bss..swapper_pg_dir section at the start of .bss.  This
+	 * also satisfies PAGE_SIZE alignment as the largest page size
+	 * allowed is 64K.
+	 */
+	. = ALIGN(0x10000);
+	__init_end = .;
+	/* freed after init ends here */
+
+	/*
+	 * Force .bss to 64K alignment so that .bss..swapper_pg_dir
+	 * gets that alignment.	 .sbss should be empty, so there will be
+	 * no holes after __init_end. */
+	BSS_SECTION(0, 0x10000, 8)
+
+	_end = . ;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	/* These must appear regardless of  .  */
+	.gptab.sdata : {
+		*(.gptab.data)
+		*(.gptab.sdata)
+	}
+	.gptab.sbss : {
+		*(.gptab.bss)
+		*(.gptab.sbss)
+	}
+
+	/* Sections to be discarded */
+	DISCARDS
+	/DISCARD/ : {
+		*(.gnu.attributes)
+		*(.options)
+		*(.eh_frame)
+	}
+}
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
new file mode 100644
index 000000000000..04916bcde679
--- /dev/null
+++ b/arch/loongarch/lib/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for LoongArch-specific library files..
+#
+
+lib-y	+= delay.o memcpy.o memset.o \
+	   strncpy_user.o strnlen_user.o dump_tlb.o
diff --git a/arch/loongarch/loongson64/Makefile b/arch/loongarch/loongson64/Makefile
new file mode 100644
index 000000000000..42e92e5e12be
--- /dev/null
+++ b/arch/loongarch/loongson64/Makefile
@@ -0,0 +1,8 @@
+#
+# All Loongson based systems
+#
+
+obj-y += setup.o init.o env.o reset.o irq.o mem.o \
+	 rtc.o boardinfo.o
+
+obj-$(CONFIG_PCI_MSI)	+= msi.o
diff --git a/arch/loongarch/loongson64/Platform b/arch/loongarch/loongson64/Platform
new file mode 100644
index 000000000000..387e9ae38a51
--- /dev/null
+++ b/arch/loongarch/loongson64/Platform
@@ -0,0 +1,14 @@
+#
+# Loongson Processors' Support
+#
+
+cflags-$(CONFIG_CPU_LOONGSON64)	+= $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
+cflags-$(CONFIG_CPU_LOONGSON64) += -U_LOONGARCH_ISA -D_LOONGARCH_ISA=_LOONGARCH_ISA_LOONGARCH64
+
+#
+# Loongson Machines Support
+#
+
+platform-$(CONFIG_MACH_LOONGSON64) += loongson64/
+cflags-$(CONFIG_MACH_LOONGSON64)   += -I$(srctree)/arch/loongarch/include/asm/mach-loongson64
+load-$(CONFIG_MACH_LOONGSON64)     += 0x9000000000200000
diff --git a/arch/loongarch/mm/Makefile b/arch/loongarch/mm/Makefile
new file mode 100644
index 000000000000..a3a137709650
--- /dev/null
+++ b/arch/loongarch/mm/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux/LoongArch-specific parts of the memory manager.
+#
+
+obj-y				+= init.o cache.o tlb.o tlbex.o extable.o \
+				   fault.o ioremap.o maccess.o mmap.o pgtable.o page.o
+
+obj-$(CONFIG_64BIT)		+= pgtable-64.o
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/loongarch/pci/Makefile b/arch/loongarch/pci/Makefile
new file mode 100644
index 000000000000..113a395ad4a3
--- /dev/null
+++ b/arch/loongarch/pci/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the PCI specific kernel interface routines under Linux.
+#
+
+obj-y				+= pci.o
+obj-$(CONFIG_ACPI)		+= acpi.o
+obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig.o
+obj-$(CONFIG_MACH_LOONGSON64)	+= pci-loongson.o
diff --git a/scripts/subarch.include b/scripts/subarch.include
index 650682821126..c79e0d0b1a19 100644
--- a/scripts/subarch.include
+++ b/scripts/subarch.include
@@ -10,4 +10,4 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
 				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
 				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-				  -e s/riscv.*/riscv/)
+				  -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
-- 
2.27.0


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9752B728
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 12:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiERJcG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiERJcF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 05:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90D9D4F5;
        Wed, 18 May 2022 02:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5666561738;
        Wed, 18 May 2022 09:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAE5C385AA;
        Wed, 18 May 2022 09:31:56 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V11 05/22] LoongArch: Add build infrastructure
Date:   Wed, 18 May 2022 17:26:02 +0800
Message-Id: <20220518092619.1269111-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518092619.1269111-1-chenhuacai@loongson.cn>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add Kbuild, Makefile, Kconfig and link script for LoongArch build
infrastructure.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kbuild                  |   6 +
 arch/loongarch/Kconfig                 | 395 +++++++++++++++++++++++++
 arch/loongarch/Kconfig.debug           |   0
 arch/loongarch/Makefile                | 105 +++++++
 arch/loongarch/boot/.gitignore         |   2 +
 arch/loongarch/boot/Makefile           |  20 ++
 arch/loongarch/boot/dts/Makefile       |   4 +
 arch/loongarch/include/asm/Kbuild      |  30 ++
 arch/loongarch/include/uapi/asm/Kbuild |   2 +
 arch/loongarch/kernel/.gitignore       |   2 +
 arch/loongarch/kernel/Makefile         |  21 ++
 arch/loongarch/kernel/vmlinux.lds.S    | 117 ++++++++
 arch/loongarch/lib/Makefile            |   6 +
 arch/loongarch/mm/Makefile             |   9 +
 arch/loongarch/pci/Makefile            |   7 +
 arch/loongarch/vdso/.gitignore         |   2 +
 scripts/subarch.include                |   2 +-
 17 files changed, 729 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/Kbuild
 create mode 100644 arch/loongarch/Kconfig
 create mode 100644 arch/loongarch/Kconfig.debug
 create mode 100644 arch/loongarch/Makefile
 create mode 100644 arch/loongarch/boot/.gitignore
 create mode 100644 arch/loongarch/boot/Makefile
 create mode 100644 arch/loongarch/boot/dts/Makefile
 create mode 100644 arch/loongarch/include/asm/Kbuild
 create mode 100644 arch/loongarch/include/uapi/asm/Kbuild
 create mode 100644 arch/loongarch/kernel/.gitignore
 create mode 100644 arch/loongarch/kernel/Makefile
 create mode 100644 arch/loongarch/kernel/vmlinux.lds.S
 create mode 100644 arch/loongarch/lib/Makefile
 create mode 100644 arch/loongarch/mm/Makefile
 create mode 100644 arch/loongarch/pci/Makefile
 create mode 100644 arch/loongarch/vdso/.gitignore

diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
new file mode 100644
index 000000000000..ab5373d0a24f
--- /dev/null
+++ b/arch/loongarch/Kbuild
@@ -0,0 +1,6 @@
+obj-y += kernel/
+obj-y += mm/
+obj-y += vdso/
+
+# for cleaning
+subdir- += boot
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
new file mode 100644
index 000000000000..09902903bba8
--- /dev/null
+++ b/arch/loongarch/Kconfig
@@ -0,0 +1,395 @@
+# SPDX-License-Identifier: GPL-2.0
+config LOONGARCH
+	bool
+	default y
+	select ACPI_MCFG if ACPI
+	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ARCH_BINFMT_ELF_STATE
+	select ARCH_ENABLE_MEMORY_HOTPLUG
+	select ARCH_ENABLE_MEMORY_HOTREMOVE
+	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_PTE_SPECIAL
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
+	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_SUPPORTS_ACPI
+	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_USE_BUILTIN_BSWAP
+	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANTS_NO_INSTR
+	select BUILDTIME_TABLE_SORT
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE
+	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_ENTRY
+	select GENERIC_FIND_FIRST_BIT
+	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IRQ_MULTI_HANDLER
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_LSHRDI3
+	select GENERIC_LIB_UCMPDI2
+	select GENERIC_PCI_IOMAP
+	select GENERIC_SCHED_CLOCK
+	select GENERIC_TIME_VSYSCALL
+	select GPIOLIB
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_COMPILER_H
+	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select HAVE_ASM_MODVERSIONS
+	select HAVE_CONTEXT_TRACKING
+	select HAVE_COPY_THREAD_TLS
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_DEBUG_STACKOVERFLOW
+	select HAVE_DMA_CONTIGUOUS
+	select HAVE_EXIT_THREAD
+	select HAVE_FAST_GUP
+	select HAVE_GENERIC_VDSO
+	select HAVE_IOREMAP_PROT
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
+	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NMI
+	select HAVE_PCI
+	select HAVE_PERF_EVENTS
+	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_TIF_NOHZ
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select IRQ_FORCED_THREADING
+	select IRQ_LOONGARCH_CPU
+	select MODULES_USE_ELF_RELA if MODULES
+	select OF
+	select OF_EARLY_FLATTREE
+	select PCI
+	select PCI_DOMAINS_GENERIC
+	select PCI_ECAM if ACPI
+	select PCI_MSI_ARCH_FALLBACKS
+	select PERF_USE_VMALLOC
+	select RTC_LIB
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select SWIOTLB
+	select TRACE_IRQFLAGS_SUPPORT
+	select ZONE_DMA32
+
+config 32BIT
+	bool
+
+config 64BIT
+	def_bool y
+
+config CPU_HAS_FPU
+	bool
+	default y
+
+config CPU_HAS_PREFETCH
+	bool
+	default y
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config GENERIC_CSUM
+	def_bool y
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config L1_CACHE_SHIFT
+	int
+	default "6"
+
+config LOCKDEP_SUPPORT
+	bool
+	default y
+
+# MACH_LOONGSON32 and MACH_LOONGSON64 are delibrately carried over from the
+# MIPS Loongson code, to preserve Loongson-specific code paths in drivers that
+# are shared between architectures, and specifically expecting the symbols.
+config MACH_LOONGSON32
+	def_bool 32BIT
+
+config MACH_LOONGSON64
+	def_bool 64BIT
+
+config PAGE_SIZE_4KB
+	bool
+
+config PAGE_SIZE_16KB
+	bool
+
+config PAGE_SIZE_64KB
+	bool
+
+config PGTABLE_2LEVEL
+	bool
+
+config PGTABLE_3LEVEL
+	bool
+
+config PGTABLE_4LEVEL
+	bool
+
+config PGTABLE_LEVELS
+	int
+	default 2 if PGTABLE_2LEVEL
+	default 3 if PGTABLE_3LEVEL
+	default 4 if PGTABLE_4LEVEL
+
+config SCHED_OMIT_FRAME_POINTER
+	bool
+	default y
+
+menu "Kernel type and options"
+
+source "kernel/Kconfig.hz"
+
+choice
+	prompt "Page Table Layout"
+	default 16KB_2LEVEL if 32BIT
+	default 16KB_3LEVEL if 64BIT
+	help
+	  Allows choosing the page table layout, which is a combination
+	  of page size and page table levels. The size of virtual memory
+	  address space are determined by the page table layout.
+
+config 4KB_3LEVEL
+	bool "4KB with 3 levels"
+	select PAGE_SIZE_4KB
+	select PGTABLE_3LEVEL
+	help
+	  This option selects 4KB page size with 3 level page tables, which
+	  support a maximum of 39 bits of application virtual memory.
+
+config 4KB_4LEVEL
+	bool "4KB with 4 levels"
+	select PAGE_SIZE_4KB
+	select PGTABLE_4LEVEL
+	help
+	  This option selects 4KB page size with 4 level page tables, which
+	  support a maximum of 48 bits of application virtual memory.
+
+config 16KB_2LEVEL
+	bool "16KB with 2 levels"
+	select PAGE_SIZE_16KB
+	select PGTABLE_2LEVEL
+	help
+	  This option selects 16KB page size with 2 level page tables, which
+	  support a maximum of 36 bits of application virtual memory.
+
+config 16KB_3LEVEL
+	bool "16KB with 3 levels"
+	select PAGE_SIZE_16KB
+	select PGTABLE_3LEVEL
+	help
+	  This option selects 16KB page size with 3 level page tables, which
+	  support a maximum of 47 bits of application virtual memory.
+
+config 64KB_2LEVEL
+	bool "64KB with 2 levels"
+	select PAGE_SIZE_64KB
+	select PGTABLE_2LEVEL
+	help
+	  This option selects 64KB page size with 2 level page tables, which
+	  support a maximum of 42 bits of application virtual memory.
+
+config 64KB_3LEVEL
+	bool "64KB with 3 levels"
+	select PAGE_SIZE_64KB
+	select PGTABLE_3LEVEL
+	help
+	  This option selects 64KB page size with 3 level page tables, which
+	  support a maximum of 55 bits of application virtual memory.
+
+endchoice
+
+config CMDLINE
+	string "Built-in kernel command line"
+	help
+	  For most platforms, the arguments for the kernel's command line
+	  are provided at run-time, during boot. However, there are cases
+	  where either no arguments are being provided or the provided
+	  arguments are insufficient or even invalid.
+
+	  When that occurs, it is possible to define a built-in command
+	  line here and choose how the kernel should use it later on.
+
+choice
+	prompt "Kernel command line type"
+	default CMDLINE_BOOTLOADER
+	help
+	  Choose how the kernel will handle the provided built-in command
+	  line.
+
+config CMDLINE_BOOTLOADER
+	bool "Use bootloader kernel arguments if available"
+	help
+	  Prefer the command-line passed by the boot loader if available.
+	  Use the built-in command line as fallback in case we get nothing
+	  during boot. This is the default behaviour.
+
+config CMDLINE_EXTEND
+	bool "Use built-in to extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided during boot will be
+	  appended to the built-in command line. This is useful in
+	  cases where the provided arguments are insufficient and
+	  you don't want to or cannot modify them.
+
+config CMDLINE_FORCE
+	bool "Always use the built-in kernel command string"
+	help
+	  Always use the built-in command line, even if we get one during
+	  boot. This is useful in case you need to override the provided
+	  command line on systems where you don't have or want control
+	  over it.
+
+endchoice
+
+config DMI
+	bool "Enable DMI scanning"
+	select DMI_SCAN_MACHINE_NON_EFI_FALLBACK
+	default y
+	help
+	  This enables SMBIOS/DMI feature for systems, and scanning of
+	  DMI to identify machine quirks.
+
+config EFI
+	bool "EFI runtime service support"
+	select UCS2_STRING
+	select EFI_PARAMS_FROM_FDT
+	select EFI_RUNTIME_WRAPPERS
+	help
+	  This enables the kernel to use EFI runtime services that are
+	  available (such as the EFI variable services).
+
+config EFI_STUB
+	bool "EFI boot stub support"
+	default y
+	depends on EFI
+	select EFI_GENERIC_STUB
+	help
+	  This kernel feature allows the kernel to be loaded directly by
+	  EFI firmware without the use of a bootloader.
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
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool y
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	help
+	  Say Y to support efficient handling of sparse physical memory,
+	  for architectures which are either NUMA (Non-Uniform Memory Access)
+	  or have huge holes in the physical address space for other reasons.
+	  See <file:Documentation/vm/numa.rst> for more.
+
+config ARCH_ENABLE_THP_MIGRATION
+	def_bool y
+	depends on TRANSPARENT_HUGEPAGE
+
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
+config MMU
+	bool
+	default y
+
+config ARCH_MMAP_RND_BITS_MIN
+	default 12
+
+config ARCH_MMAP_RND_BITS_MAX
+	default 18
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
index 000000000000..6dcc0495bec9
--- /dev/null
+++ b/arch/loongarch/Makefile
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Author: Huacai Chen <chenhuacai@loongson.cn>
+# Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+
+boot	:= arch/loongarch/boot
+
+ifndef CONFIG_EFI_STUB
+KBUILD_IMAGE	= $(boot)/vmlinux
+else
+KBUILD_IMAGE	= $(boot)/vmlinux.efi
+endif
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
+ifdef CONFIG_64BIT
+ld-emul			= $(64bit-emul)
+cflags-y		+= -mabi=lp64s
+endif
+
+cflags-y			+= -G0 -pipe -msoft-float
+LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
+KBUILD_AFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
+KBUILD_CFLAGS_KERNEL		+= -Wa,-mla-global-with-pcrel
+KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
+KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
+
+cflags-y += -ffreestanding
+cflags-y += $(call cc-option, -mno-check-zero-division)
+
+load-y		= 0x9000000000200000
+bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
+
+drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
+
+KBUILD_AFLAGS	+= $(cflags-y)
+KBUILD_CFLAGS	+= $(cflags-y)
+KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
+
+# This is required to get dwarf unwinding tables into .debug_frame
+# instead of .eh_frame so we don't discard them.
+KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
+
+# Don't emit unaligned accesses.
+# Not all LoongArch cores support unaligned access, and as kernel we can't
+# rely on others to provide emulation for these accesses.
+KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+
+KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
+
+KBUILD_LDFLAGS	+= -m $(ld-emul)
+
+ifdef CONFIG_LOONGARCH
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
+	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
+endif
+
+head-y := arch/loongarch/kernel/head.o
+
+libs-y += arch/loongarch/lib/
+libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+
+ifeq ($(KBUILD_EXTMOD),)
+prepare: vdso_prepare
+vdso_prepare: prepare0
+	$(Q)$(MAKE) $(build)=arch/loongarch/vdso include/generated/vdso-offsets.h
+endif
+
+PHONY += vdso_install
+vdso_install:
+	$(Q)$(MAKE) $(build)=arch/loongarch/vdso $@
+
+all:	$(KBUILD_IMAGE)
+
+$(KBUILD_IMAGE): vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $@
+
+install:
+	$(Q)install -D -m 755 $(KBUILD_IMAGE) $(INSTALL_PATH)/vmlinux-$(KERNELRELEASE)
+	$(Q)install -D -m 644 .config $(INSTALL_PATH)/config-$(KERNELRELEASE)
+	$(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KERNELRELEASE)
+
+define archhelp
+	echo '  install              - install kernel into $(INSTALL_PATH)'
+	echo
+endef
diff --git a/arch/loongarch/boot/.gitignore b/arch/loongarch/boot/.gitignore
new file mode 100644
index 000000000000..49423ee96ef3
--- /dev/null
+++ b/arch/loongarch/boot/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vmlinux*
diff --git a/arch/loongarch/boot/Makefile b/arch/loongarch/boot/Makefile
new file mode 100644
index 000000000000..b39d50a7a3df
--- /dev/null
+++ b/arch/loongarch/boot/Makefile
@@ -0,0 +1,20 @@
+#
+# arch/loongarch/boot/Makefile
+#
+# Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+#
+
+drop-sections := .comment .note .options .note.gnu.build-id
+strip-flags   := $(addprefix --remove-section=,$(drop-sections)) -S
+OBJCOPYFLAGS_vmlinux.efi := -O binary $(strip-flags)
+
+targets := vmlinux
+quiet_cmd_strip = STRIP	  $@
+      cmd_strip = $(STRIP) -s -o $@ $<
+
+$(obj)/vmlinux: vmlinux FORCE
+	$(call if_changed,strip)
+
+targets += vmlinux.efi
+$(obj)/vmlinux.efi: $(obj)/vmlinux FORCE
+	$(call if_changed,objcopy)
diff --git a/arch/loongarch/boot/dts/Makefile b/arch/loongarch/boot/dts/Makefile
new file mode 100644
index 000000000000..5f1f55e911ad
--- /dev/null
+++ b/arch/loongarch/boot/dts/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+dtstree	:= $(srctree)/$(src)
+
+dtb-y := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
new file mode 100644
index 000000000000..83bc0681e72b
--- /dev/null
+++ b/arch/loongarch/include/asm/Kbuild
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+generic-y += dma-contiguous.h
+generic-y += export.h
+generic-y += parport.h
+generic-y += early_ioremap.h
+generic-y += qrwlock.h
+generic-y += qrwlock_types.h
+generic-y += spinlock.h
+generic-y += spinlock_types.h
+generic-y += rwsem.h
+generic-y += segment.h
+generic-y += user.h
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
diff --git a/arch/loongarch/kernel/.gitignore b/arch/loongarch/kernel/.gitignore
new file mode 100644
index 000000000000..bbb90f92d051
--- /dev/null
+++ b/arch/loongarch/kernel/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vmlinux.lds
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
new file mode 100644
index 000000000000..e5a3b2fb9961
--- /dev/null
+++ b/arch/loongarch/kernel/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux/LoongArch kernel.
+#
+
+extra-y		:= head.o vmlinux.lds
+
+obj-y		+= cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
+		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
+		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
+
+obj-$(CONFIG_ACPI)		+= acpi.o
+obj-$(CONFIG_EFI) 		+= efi.o
+
+obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
+
+obj-$(CONFIG_MODULES)		+= module.o module-sections.o
+
+obj-$(CONFIG_PROC_FS)		+= proc.o
+
+CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..7da4c4d7c50d
--- /dev/null
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/sizes.h>
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
+#include "image-vars.h"
+
+/*
+ * Max avaliable Page Size is 64K, so we set SectionAlignment
+ * field of EFI application to 64K.
+ */
+PECOFF_FILE_ALIGN = 0x200;
+PECOFF_SEGMENT_ALIGN = 0x10000;
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
+
+	_text = .;
+	HEAD_TEXT_SECTION
+
+	. = ALIGN(PECOFF_SEGMENT_ALIGN);
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
+	. = ALIGN(PECOFF_SEGMENT_ALIGN);
+	_etext = .;
+
+	EXCEPTION_TABLE(16)
+
+	. = ALIGN(PECOFF_SEGMENT_ALIGN);
+	__init_begin = .;
+	__inittext_begin = .;
+
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	.exit.text : {
+		EXIT_TEXT
+	}
+
+	. = ALIGN(PECOFF_SEGMENT_ALIGN);
+	__inittext_end = .;
+
+	__initdata_begin = .;
+
+	INIT_DATA_SECTION(16)
+	.exit.data : {
+		EXIT_DATA
+	}
+
+	.init.bss : {
+		*(.init.bss)
+	}
+	. = ALIGN(PECOFF_SEGMENT_ALIGN);
+	__initdata_end = .;
+
+	__init_end = .;
+
+	_sdata = .;
+	RO_DATA(4096)
+	RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
+
+	.sdata : {
+		*(.sdata)
+	}
+	.edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGN); }
+	_edata =  .;
+
+	BSS_SECTION(0, SZ_64K, 8)
+	. = ALIGN(PECOFF_SEGMENT_ALIGN);
+
+	_end = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	.gptab.sdata : {
+		*(.gptab.data)
+		*(.gptab.sdata)
+	}
+	.gptab.sbss : {
+		*(.gptab.bss)
+		*(.gptab.sbss)
+	}
+
+	DISCARDS
+	/DISCARD/ : {
+		*(.gnu.attributes)
+		*(.options)
+		*(.eh_frame)
+	}
+}
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
new file mode 100644
index 000000000000..e36635fccb69
--- /dev/null
+++ b/arch/loongarch/lib/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for LoongArch-specific library files.
+#
+
+lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o
diff --git a/arch/loongarch/mm/Makefile b/arch/loongarch/mm/Makefile
new file mode 100644
index 000000000000..8ffc6383f836
--- /dev/null
+++ b/arch/loongarch/mm/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux/LoongArch-specific parts of the memory manager.
+#
+
+obj-y				+= init.o cache.o tlb.o tlbex.o extable.o \
+				   fault.o ioremap.o maccess.o mmap.o pgtable.o page.o
+
+obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/loongarch/pci/Makefile b/arch/loongarch/pci/Makefile
new file mode 100644
index 000000000000..8101ef3df71c
--- /dev/null
+++ b/arch/loongarch/pci/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the PCI specific kernel interface routines under Linux.
+#
+
+obj-y				+= pci.o
+obj-$(CONFIG_ACPI)		+= acpi.o
diff --git a/arch/loongarch/vdso/.gitignore b/arch/loongarch/vdso/.gitignore
new file mode 100644
index 000000000000..652e31d82582
--- /dev/null
+++ b/arch/loongarch/vdso/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vdso.lds
diff --git a/scripts/subarch.include b/scripts/subarch.include
index 776849a3c500..4bd327d0ae42 100644
--- a/scripts/subarch.include
+++ b/scripts/subarch.include
@@ -10,4 +10,4 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 				  -e s/s390x/s390/ \
 				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
 				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-				  -e s/riscv.*/riscv/)
+				  -e s/riscv.*/riscv/ -e s/loongarch.*/loongarch/)
-- 
2.27.0


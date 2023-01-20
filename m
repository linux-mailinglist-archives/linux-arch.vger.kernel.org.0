Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67866756AD
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjATOMa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjATOLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:46 -0500
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7DEC79CE
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:11:00 -0800 (PST)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id 195AE35CF8E
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:30 +0100 (CET)
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id D83BF35CFB0; Fri, 20 Jan
 2023 15:10:29 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 35D4435CF76; Fri, 20 Jan
 2023 15:10:29 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id E334C27E043A; Fri, 20 Jan 2023
 15:10:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id CB0C827E0430; Fri, 20 Jan 2023 15:10:28 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 Xz5sHM8fC0-H; Fri, 20 Jan 2023 15:10:28 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 4DB6D27E0439; Fri, 20 Jan 2023
 15:10:28 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1474a.63caa0d5.34a0b.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu CB0C827E0430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223828;
 bh=EuQZx9FUnDiDRTk50xpDbbkQoW5rtljZYfO+Kb3RngA=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=pJAWVR/O4/vNSXgI2fqCq1mzyA4nHvReixv2Rv8rbziGt64b3rKESJ6G/BTtYtP7k
 HN8eWKe3YhaHUmwfMymJf5y/s+APHU15usfVf0MqQsOFPf7Yaejddkwnpw9jWKu3WF
 Pr9oOjDjubHs4HFOGHtGjs+2tlvfCLSzf6UsEuT0=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 09/31] kvx: Add build infrastructure
Date:   Fri, 20 Jan 2023 15:09:40 +0100
Message-ID: <20230120141002.2442-10-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add Kbuild, Makefile, Kconfig and link script for kvx build infrastructure.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jonathan Borne <jborne@kalray.eu>
Signed-off-by: Jonathan Borne <jborne@kalray.eu>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Marc Poulhiès <dkm@kataplop.net>
Signed-off-by: Marc Poulhiès <dkm@kataplop.net>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Samuel Jones <sjones@kalray.eu>
Signed-off-by: Samuel Jones <sjones@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2:
     - typos and formatting fixes, removed int from PGTABLE_LEVELS
     - renamed default_defconfig to defconfig in arch/kvx/Makefile
     - Fix clean target raising an error from gcc (LIBGCC)

 arch/kvx/Kconfig                 | 224 +++++++++++++++++++++++++++++++
 arch/kvx/Kconfig.debug           |  70 ++++++++++
 arch/kvx/Makefile                |  53 ++++++++
 arch/kvx/include/asm/Kbuild      |  20 +++
 arch/kvx/include/uapi/asm/Kbuild |   1 +
 arch/kvx/kernel/Makefile         |  15 +++
 arch/kvx/kernel/kvx_ksyms.c      |  24 ++++
 arch/kvx/kernel/vmlinux.lds.S    | 150 +++++++++++++++++++++
 arch/kvx/lib/Makefile            |   6 +
 arch/kvx/mm/Makefile             |   8 ++
 10 files changed, 571 insertions(+)
 create mode 100644 arch/kvx/Kconfig
 create mode 100644 arch/kvx/Kconfig.debug
 create mode 100644 arch/kvx/Makefile
 create mode 100644 arch/kvx/include/asm/Kbuild
 create mode 100644 arch/kvx/include/uapi/asm/Kbuild
 create mode 100644 arch/kvx/kernel/Makefile
 create mode 100644 arch/kvx/kernel/kvx_ksyms.c
 create mode 100644 arch/kvx/kernel/vmlinux.lds.S
 create mode 100644 arch/kvx/lib/Makefile
 create mode 100644 arch/kvx/mm/Makefile

diff --git a/arch/kvx/Kconfig b/arch/kvx/Kconfig
new file mode 100644
index 000000000000..0bdba6a3b08a
--- /dev/null
+++ b/arch/kvx/Kconfig
@@ -0,0 +1,224 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+config 64BIT
+	def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config FIX_EARLYCON_MEM
+	def_bool y
+
+config MMU
+	def_bool y
+
+config KALLSYMS_BASE_RELATIVE
+	def_bool n
+
+config GENERIC_CSUM
+	def_bool y
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config ARCH_MMAP_RND_BITS_MAX
+	default 24
+
+config ARCH_MMAP_RND_BITS_MIN
+	default 18
+
+config STACKTRACE_SUPPORT
+	def_bool y
+
+config LOCKDEP_SUPPORT
+	def_bool y
+
+config GENERIC_BUG
+	def_bool y
+	depends on BUG
+
+config KVX_4K_PAGES
+	def_bool y
+
+config KVX
+	def_bool y
+	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_DMA_ADDR_T_64BIT
+	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_SETUP_DMA_OPS if IOMMU_SUPPORT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
+	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANT_FRAME_POINTERS
+	select CLKSRC_OF
+	select COMMON_CLK
+	select DMA_DIRECT_REMAP
+	select GENERIC_ALLOCATOR
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CPU_DEVICES
+	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
+	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_SCHED_CLOCK
+	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ASM_MODVERSIONS
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_IOREMAP_PROT
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_PCI
+	select HAVE_STACKPROTECTOR
+	select HAVE_SYSCALL_TRACEPOINTS
+	select IOMMU_DMA if IOMMU_SUPPORT
+	select KVX_APIC_GIC
+	select KVX_APIC_MAILBOX
+	select KVX_CORE_INTC
+	select KVX_ITGEN
+	select KVX_WATCHDOG
+	select MODULES_USE_ELF_RELA
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
+	select PCI_DOMAINS_GENERIC if PCI
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select THREAD_INFO_IN_TASK
+	select TIMER_OF
+	select TRACE_IRQFLAGS_SUPPORT
+	select WATCHDOG
+	select ZONE_DMA32
+
+config PGTABLE_LEVELS
+	default 3
+
+config HAVE_KPROBES
+	def_bool n
+
+menu "System setup"
+
+config POISON_INITMEM
+	bool "Enable to poison freed initmem"
+	default y
+	help
+	  In order to debug initmem, using poison allows to verify if some
+	  data/code is still using them. Enable this for debug purposes.
+
+config KVX_PHYS_OFFSET
+	hex "RAM address of memory base"
+	default 0x100000000
+
+config KVX_PAGE_OFFSET
+	hex "kernel virtual address of memory base"
+	default 0xFFFFFF8000000000
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool ARCH_SPARSEMEM_ENABLE
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool ARCH_SPARSEMEM_ENABLE
+
+config STACK_MAX_DEPTH_TO_PRINT
+	int "Maximum depth of stack to print"
+	range 1 128
+	default "24"
+
+config SECURE_DAME_HANDLING
+	bool "Secure DAME handling"
+	default y
+	help
+	  In order to securely handle Data Asynchronous Memory Errors, we need
+	  to do a barrier upon kernel entry when coming from userspace. This
+	  barrier guarantees us that any pending DAME will be serviced right
+	  away. We also need to do a barrier when returning from kernel to user.
+	  This way, if the kernel or the user triggered a DAME, it will be
+	  serviced by knowing we are coming from kernel or user and avoid
+	  pulling the wrong lever (panic for kernel or sigfault for user).
+	  This can be costly but ensures that user cannot interfere with kernel.
+	  /!\ Do not disable unless you want to open a giant breach between
+	  user and kernel /!\
+
+config CACHECTL_UNSAFE_PHYS_OPERATIONS
+	bool "Enable cachectl syscall unsafe physical operations"
+	default n
+	help
+	  Enable cachectl syscall to allow writebacking/invalidating ranges
+	  based on physical addresses. These operations requires the
+	  CAP_SYS_ADMIN capability.
+
+config ENABLE_TCA
+	bool "Enable TCA coprocessor support"
+	default y
+	help
+	  This option enables TCA coprocessor support. It will allow the user to
+	  use the coprocessor and save registers on context switch if used.
+	  Registers content will also be cleared when switching.
+
+config SMP
+	bool "Symmetric multi-processing support"
+	default n
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IRQ_IPI
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_DOMAIN
+	help
+	  This enables support for systems with more than one CPU. If you have
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
+
+	  If you say N here, the kernel will run on uni- and multiprocessor
+	  machines, but will use only one CPU of a multiprocessor machine. If
+	  you say Y here, the kernel will run on many, but not all,
+	  uniprocessor machines. On a uniprocessor machine, the kernel
+	  will run faster if you say N here.
+
+config NR_CPUS
+	int "Maximum number of CPUs"
+	range 1 16
+	default "16"
+	depends on SMP
+	help
+	  Kalray support can handle a maximum of 16 CPUs.
+
+config KVX_PAGE_SHIFT
+	int
+	default 12
+
+config CMDLINE
+	string "Default kernel command string"
+	default ""
+	help
+	  On some architectures there is currently no way for the boot loader
+	  to pass arguments to the kernel. For these architectures, you should
+	  supply some command-line options at build time by entering them
+	  here.
+
+endmenu
+
+menu "Kernel Features"
+source "kernel/Kconfig.hz"
+endmenu
diff --git a/arch/kvx/Kconfig.debug b/arch/kvx/Kconfig.debug
new file mode 100644
index 000000000000..171f71288ee6
--- /dev/null
+++ b/arch/kvx/Kconfig.debug
@@ -0,0 +1,70 @@
+menu "KVX debugging"
+
+config KVX_DEBUG_ASN
+	bool "Check ASN before writing TLB entry"
+	default n
+	help
+	  This option allows to check if the ASN of the current
+	  process matches the ASN found in MMC. If it is not the
+	  case an error will be printed.
+
+config KVX_DEBUG_TLB_WRITE
+	bool "Enable TLBs write checks"
+	default n
+	help
+	  Enabling this option will enable TLB access checks. This is
+	  particularly helpful when modifying the assembly code responsible
+	  for TLB refill. If set, mmc.e will be checked each time the TLB are
+	  written and a panic will be thrown on error.
+
+config KVX_DEBUG_TLB_ACCESS
+	bool "Enable TLBs accesses logging"
+	default n
+	help
+	  Enabling this option will enable TLB entry manipulation logging.
+	  Each time an entry is added to the TLBs, it is logged in an array
+	  readable via gdb scripts. This can be useful to understand strange
+	  crashes related to suspicious virtual/physical addresses.
+
+config KVX_DEBUG_TLB_ACCESS_BITS
+	int "Number of bits used as index of entries in log table"
+	default 12
+	depends on KVX_DEBUG_TLB_ACCESS
+	help
+	  Set the number of bits used as index of entries that will be logged
+	  in a ring buffer called kvx_tlb_access. One entry in the table
+	  contains registers TEL, TEH and MMC. It also logs the type of the
+	  operations (0:read, 1:write, 2:probe). Buffer is per CPU. For one
+	  entry 24 bytes are used. So by default it uses 96KB of memory per
+	  CPU to store 2^12 (4096) entries.
+
+config KVX_MMU_STATS
+	bool "Register MMU stats debugfs entries"
+	default n
+	depends on DEBUG_FS
+	help
+	  Enable debugfs attribute which will allow inspecting various metrics
+	  regarding MMU:
+	  - Number of nomapping traps handled
+	  - avg/min/max time for nomapping refill (user/kernel)
+
+config DEBUG_EXCEPTION_STACK
+	bool "Enable exception stack debugging"
+	default n
+	help
+	  Enable stack check debugging when entering/exiting
+	  exception handlers.
+	  This can be particularly helpful after modifying stack
+	  handling to see if stack when exiting is the same as the one
+	  when entering exception handler.
+
+config DEBUG_SFR_SET_MASK
+	bool "Enable SFR set_mask debugging"
+	default n
+	help
+	  Verify that values written using kvx_sfr_set_mask match the mask.
+	  This ensure that no extra bits of SFR will be overridden by some
+	  incorrectly truncated values. This can lead to huge problems by
+	  modifying important bits in system registers.
+
+endmenu
diff --git a/arch/kvx/Makefile b/arch/kvx/Makefile
new file mode 100644
index 000000000000..78d6d7c9c43e
--- /dev/null
+++ b/arch/kvx/Makefile
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2018-2023 Kalray Inc.
+
+ifeq ($(CROSS_COMPILE),)
+CROSS_COMPILE := kvx-elf-
+endif
+
+KBUILD_DEFCONFIG := defconfig
+
+LDFLAGS_vmlinux := -X
+OBJCOPYFLAGS := -O binary -R .comment -R .note -R .bootloader -S
+
+DEFAULT_OPTS := -nostdlib -fno-builtin -march=kv3-1
+
+# Link with libgcc to get __div* builtins.
+LIBGCC	:= $(shell $(CC) $(DEFAULT_OPTS) --print-libgcc-file-name)
+
+KBUILD_CFLAGS += $(DEFAULT_OPTS)
+KBUILD_AFLAGS += $(DEFAULT_OPTS)
+KBUILD_CFLAGS_MODULE += -mfarcall
+
+KBUILD_LDFLAGS += -m elf64kvx
+
+head-y	:= arch/kvx/kernel/head.o
+libs-y 	+= $(LIBGCC)
+libs-y  += arch/kvx/lib/
+core-y += arch/kvx/kernel/ \
+          arch/kvx/mm/ \
+          arch/kvx/platform/
+# Final targets
+all: vmlinux
+
+BOOT_TARGETS = bImage bImage.bin bImage.bz2 bImage.gz bImage.lzma bImage.lzo
+
+$(BOOT_TARGETS): vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
+
+define archhelp
+  echo  '* bImage         - Alias to selected kernel format (bImage.gz by default)'
+  echo  '  bImage.bin     - Uncompressed Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.bin)'
+  echo  '  bImage.bz2     - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.bz2)'
+  echo  '* bImage.gz      - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.gz)'
+  echo  '  bImage.lzma    - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.lzma)'
+  echo  '  bImage.lzo     - Kernel-only image for barebox (arch/$(ARCH)/boot/bImage.lzo)'
+  echo  '  install        - Install kernel using'
+  echo  '                     (your) ~/bin/$(INSTALLKERNEL) or'
+  echo  '                     (distribution) PATH: $(INSTALLKERNEL) or'
+  echo  '                     install to $$(INSTALL_PATH)'
+endef
diff --git a/arch/kvx/include/asm/Kbuild b/arch/kvx/include/asm/Kbuild
new file mode 100644
index 000000000000..ea73552faa10
--- /dev/null
+++ b/arch/kvx/include/asm/Kbuild
@@ -0,0 +1,20 @@
+generic-y += asm-offsets.h
+generic-y += clkdev.h
+generic-y += auxvec.h
+generic-y += bpf_perf_event.h
+generic-y += cmpxchg-local.h
+generic-y += errno.h
+generic-y += extable.h
+generic-y += export.h
+generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
+generic-y += mman.h
+generic-y += param.h
+generic-y += qrwlock.h
+generic-y += qspinlock.h
+generic-y += rwsem.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += ucontext.h
+generic-y += user.h
diff --git a/arch/kvx/include/uapi/asm/Kbuild b/arch/kvx/include/uapi/asm/Kbuild
new file mode 100644
index 000000000000..8b137891791f
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/Kbuild
@@ -0,0 +1 @@
+
diff --git a/arch/kvx/kernel/Makefile b/arch/kvx/kernel/Makefile
new file mode 100644
index 000000000000..735ba3893027
--- /dev/null
+++ b/arch/kvx/kernel/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2019-2023 Kalray Inc.
+#
+
+obj-y	:= head.o setup.o process.o traps.o common.o time.o prom.o kvx_ksyms.o \
+	   irq.o cpuinfo.o entry.o ptrace.o syscall_table.o signal.o sys_kvx.o \
+	   stacktrace.o dame_handler.o vdso.o debug.o break_hook.o \
+	   reset.o io.o
+
+obj-$(CONFIG_SMP) 			+= smp.o smpboot.o
+obj-$(CONFIG_MODULES)			+= module.o
+CFLAGS_module.o				+= -Wstrict-overflow -fstrict-overflow
+
+extra-y					+= vmlinux.lds
diff --git a/arch/kvx/kernel/kvx_ksyms.c b/arch/kvx/kernel/kvx_ksyms.c
new file mode 100644
index 000000000000..18990aaf259f
--- /dev/null
+++ b/arch/kvx/kernel/kvx_ksyms.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/nios2/kernel/nios2_ksyms.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+
+/*
+ * libgcc functions - functions that are used internally by the
+ * compiler...  (prototypes are not correct though, but that
+ * doesn't really matter since they're not versioned).
+ */
+#define DECLARE_EXPORT(name)	extern void name(void); EXPORT_SYMBOL(name)
+
+DECLARE_EXPORT(__moddi3);
+DECLARE_EXPORT(__umoddi3);
+DECLARE_EXPORT(__divdi3);
+DECLARE_EXPORT(__udivdi3);
+DECLARE_EXPORT(__multi3);
diff --git a/arch/kvx/kernel/vmlinux.lds.S b/arch/kvx/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..e8772334bd97
--- /dev/null
+++ b/arch/kvx/kernel/vmlinux.lds.S
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ *            Marc Poulhiès
+ *            Yann Sionneau
+ */
+
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+#include <asm/sys_arch.h>
+#include <asm/cache.h>
+#include <asm/rm_fw.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+
+#define BOOT_ENTRY		0x0
+#define DTB_DEFAULT_SIZE	(64 * 1024)
+
+#define LOAD_OFFSET  (PAGE_OFFSET - PHYS_OFFSET)
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT("elf64-kvx")
+ENTRY(kvx_start)
+
+#define HANDLER_SECTION(__sec, __name) \
+	__sec ## _ ## __name ## _start = .; \
+	KEEP(*(.##__sec ##.## __name)); \
+	. = __sec ## _ ##__name ## _start + EXCEPTION_STRIDE;
+
+/**
+ * Generate correct section positioning for exception handling
+ * Since we need it twice for early exception handler and normal
+ * exception handler, factorize it here.
+ */
+#define EXCEPTION_SECTIONS(__sec) \
+	__ ## __sec ## _start = ABSOLUTE(.); \
+	HANDLER_SECTION(__sec,debug) \
+	HANDLER_SECTION(__sec,trap) \
+	HANDLER_SECTION(__sec,interrupt) \
+	HANDLER_SECTION(__sec,syscall)
+
+jiffies = jiffies_64;
+SECTIONS
+{
+	. = BOOT_ENTRY;
+	.boot :
+	{
+		__kernel_smem_code_start = .;
+		KEEP(*(.boot.startup));
+		KEEP(*(.boot.*));
+		__kernel_smem_code_end = .;
+	}
+
+	. = PAGE_OFFSET;
+	_start = .;
+
+	_stext = .;
+	__init_begin = .;
+	__inittext_start = .;
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET)
+	{
+		EXIT_TEXT
+	}
+
+	.early_exception ALIGN(EXCEPTION_ALIGNMENT) :
+				AT(ADDR(.early_exception) - LOAD_OFFSET)
+	{
+		EXCEPTION_SECTIONS(early_exception)
+	}
+
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	. = ALIGN(PAGE_SIZE);
+	__inittext_end = .;
+	__initdata_start = .;
+	INIT_DATA_SECTION(16)
+
+	/* we have to discard exit text and such at runtime, not link time */
+	.exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET)
+	{
+		EXIT_DATA
+	}
+
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	. = ALIGN(PAGE_SIZE);
+	__initdata_end = .;
+	__init_end = .;
+
+	/* Everything below this point will be mapped RO EXEC up to _etext */
+	.text ALIGN(PAGE_SIZE) : AT(ADDR(.text) - LOAD_OFFSET)
+	{
+		_text = .;
+		EXCEPTION_SECTIONS(exception)
+		*(.exception.text)
+		. = ALIGN(PAGE_SIZE);
+		__exception_end = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		ENTRY_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+		*(.fixup)
+	}
+	. = ALIGN(PAGE_SIZE);
+	_etext = .;
+
+	/* Everything below this point will be mapped RO NOEXEC up to _sdata */
+	__rodata_start = .;
+	RO_DATA(PAGE_SIZE)
+	EXCEPTION_TABLE(8)
+	. = ALIGN(32);
+	.dtb : AT(ADDR(.dtb) - LOAD_OFFSET)
+	{
+		__dtb_start = .;
+		. += DTB_DEFAULT_SIZE;
+		__dtb_end = .;
+	}
+	. = ALIGN(PAGE_SIZE);
+	__rodata_end = .;
+
+	/* Everything below this point will be mapped RW NOEXEC up to _end */
+	_sdata = .;
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	_edata = .;
+
+	BSS_SECTION(32, 32, 32)
+	. = ALIGN(PAGE_SIZE);
+	_end = .;
+
+	/* This page will be mapped using a FIXMAP */
+	.gdb_page ALIGN(PAGE_SIZE) : AT(ADDR(.gdb_page) - LOAD_OFFSET)
+	{
+		_debug_start = ADDR(.gdb_page) - LOAD_OFFSET;
+		. += PAGE_SIZE;
+	}
+	_debug_start_lma = ASM_FIX_TO_VIRT(FIX_GDB_MEM_BASE_IDX);
+
+	/* Debugging sections */
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	/* Sections to be discarded -- must be last */
+	DISCARDS
+}
diff --git a/arch/kvx/lib/Makefile b/arch/kvx/lib/Makefile
new file mode 100644
index 000000000000..ddb666c244e1
--- /dev/null
+++ b/arch/kvx/lib/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2017-2023 Kalray Inc.
+#
+
+lib-y := usercopy.o clear_page.o copy_page.o memcpy.o memset.o strlen.o delay.o
diff --git a/arch/kvx/mm/Makefile b/arch/kvx/mm/Makefile
new file mode 100644
index 000000000000..e97662cf5fed
--- /dev/null
+++ b/arch/kvx/mm/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2017-2023 Kalray Inc.
+#
+
+obj-y := init.o mmu.o fault.o tlb.o extable.o dma-mapping.o cacheflush.o
+obj-$(CONFIG_KVX_MMU_STATS) += mmu_stats.o
+obj-$(CONFIG_STRICT_DEVMEM) += mmap.o
-- 
2.37.2






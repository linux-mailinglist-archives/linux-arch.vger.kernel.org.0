Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761983D23C9
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhGVMJL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231961AbhGVMJJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:09:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 546A461377;
        Thu, 22 Jul 2021 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958184;
        bh=sWG0KUDYQCCJ9DGu/nB7GGMtvC1Sb1ddm7/xlS1b/hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYy9V7EFLHTpluNLwaKb/TsyJZxOaytm94ganzLKmiPDtxNauIi1RthzOTN/oVU7I
         VNErJrSG2r+vzVc3ieEgmyVHUzqw7cCo8ifOisy/8M7s2YSkSl4LEkEYxx/5gzzeA8
         9bjiAkI7x8OZ2nxicD6z13Fs3GSqHg/Le9a1yD1DnJP4BN8eobGV/ya1uDRtIGTq4U
         zPvBwaeRZFqxQqX6i4bddN8+vlG6ElZ12x2MekMfTaWEACW5cnb+q9NVeExcVvZESW
         Qzj2bXFDBw0a2pBTVjSxWw0yP+Yzse/8eqXNz3Gk0V+Mf+f6E3WdmY0Uh0hpeqQIds
         LhJZE8aLJmVYA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols
Date:   Thu, 22 Jul 2021 14:48:14 +0200
Message-Id: <20210722124814.778059-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Most architectures do not need a custom implementation, and in most
cases the generic implementation is preferred, so change the polariy
on these Kconfig symbols to require architectures to select them when
they provide their own version.

The new name is CONFIG_ARCH_HAS_{STRNCPY_FROM,STRNLEN}_USER.

The remaining architectures at the moment are: ia64, mips, parisc,
s390, um and xtensa. We should probably convert these as well, but
I was not sure how far to take this series.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/Kconfig                |  2 --
 arch/arc/Kconfig                  |  2 --
 arch/arm/Kconfig                  |  2 --
 arch/arm64/Kconfig                |  2 --
 arch/csky/Kconfig                 |  2 --
 arch/h8300/Kconfig                |  2 --
 arch/hexagon/Kconfig              |  2 --
 arch/ia64/Kconfig                 |  2 ++
 arch/m68k/Kconfig                 |  2 --
 arch/microblaze/Kconfig           |  2 --
 arch/mips/Kconfig                 |  2 ++
 arch/nds32/Kconfig                |  2 --
 arch/nios2/Kconfig                |  2 --
 arch/openrisc/Kconfig             |  2 --
 arch/parisc/Kconfig               |  2 +-
 arch/powerpc/Kconfig              |  2 --
 arch/riscv/Kconfig                |  2 --
 arch/s390/Kconfig                 |  2 ++
 arch/sh/Kconfig                   |  2 --
 arch/sparc/Kconfig                |  2 --
 arch/um/Kconfig                   |  2 ++
 arch/x86/Kconfig                  |  2 --
 arch/xtensa/Kconfig               |  3 ++-
 arch/xtensa/include/asm/uaccess.h |  3 +--
 lib/Kconfig                       | 10 ++++++++--
 25 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 77d3280dc678..62935da8e69e 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -29,8 +29,6 @@ config ALPHA
 	select AUDIT_ARCH
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 64e5f9366401..d8f51eb8963b 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -27,8 +27,6 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 82f908fa5676..e8ebbb9ededf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -63,8 +63,6 @@ config ARM
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5b13a932561..e0c6c14a21d0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -130,8 +130,6 @@ config ARM64
 	select GENERIC_PTDUMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 5043e221ced4..2716f6395ba7 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -35,8 +35,6 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 53dfd2d47e0e..3e3e0f16f7e0 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -11,8 +11,6 @@ config H8300
 	select GENERIC_IRQ_SHOW
 	select FRAME_POINTER
 	select GENERIC_CPU_DEVICES
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select COMMON_CLK
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 3bf4845fed4b..e5a852080730 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -19,8 +19,6 @@ config HEXAGON
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_SHOW
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index cf425c2c63af..7aa5b94464c6 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -9,6 +9,8 @@ menu "Processor type and features"
 config IA64
 	bool
 	select ARCH_HAS_DMA_MARK_CLEAN
+	select ARCH_HAS_STRNCPY_FROM_USER
+	select ARCH_HAS_STRNLEN_USER
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 37a65bed6dfa..7970d316dc9b 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -16,8 +16,6 @@ config M68K
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_SHOW
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HAVE_AOUT if MMU
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 10dfa7b4feff..14a67a42fcae 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -21,8 +21,6 @@ config MICROBLAZE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_HASH
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cee6087cd686..22aa4d75fa34 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -12,6 +12,8 @@ config MIPS
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_STRNCPY_FROM_USER
+	select ARCH_HAS_STRNLEN_USER
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 62313902d75d..9c9f3877abf9 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -26,8 +26,6 @@ config NDS32
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_MULDI3
 	select GENERIC_LIB_UCMPDI2
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index c24955c81c92..3efe5533ea1c 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -13,8 +13,6 @@ config NIOS2
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_KGDB
 	select IRQ_DOMAIN
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 591acc5990dc..50035a9816c8 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -25,8 +25,6 @@ config OPENRISC
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS_BROADCAST
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index bde9907bc5b2..727c823f866e 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -11,6 +11,7 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_STRNLEN_USER
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
 	select ARCH_SUPPORTS_MEMORY_FAILURE
@@ -34,7 +35,6 @@ config PARISC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CPU_DEVICES
-	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d01e3401581d..d2df3d2db3eb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -183,8 +183,6 @@ config PPC
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 47bbbcab91b2..49d642df6ab9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -56,8 +56,6 @@ config RISCV
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a0e2130f0100..f4f39087cad0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -75,6 +75,8 @@ config S390
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_STRNCPY_FROM_USER
+	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 45a0549421cd..5d20509e5556 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -22,8 +22,6 @@ config SUPERH
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP if PCI
 	select GENERIC_SCHED_CLOCK
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c5fa7932b550..9f78822562eb 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -38,8 +38,6 @@ config SPARC
 	select HAVE_EBPF_JIT if SPARC64
 	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select PCI_SYSCALL if PCI
 	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0561b73cfd9a..77e66d3719f6 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -7,6 +7,8 @@ config UML
 	default y
 	select ARCH_EPHEMERAL_INODES
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_STRNCPY_FROM_USER
+	select ARCH_HAS_STRNLEN_USER
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49270655e827..5509c828bc93 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -144,8 +144,6 @@ config X86
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2332b2156993..282fc195680e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -7,6 +7,8 @@ config XTENSA
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
+	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
+	select ARCH_HAS_STRNLEN_USER
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
@@ -20,7 +22,6 @@ config XTENSA
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
-	select GENERIC_STRNCPY_FROM_USER if KASAN
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 5c9fb8005aa8..250ee68e9d82 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -290,8 +290,7 @@ clear_user(void __user *addr, unsigned long size)
 #define __clear_user  __xtensa_clear_user
 
 
-#ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
-
+#ifdef CONFIG_HAS_STRNCPY_FROM_USER
 extern long __strncpy_user(char *dst, const char __user *src, long count);
 
 static inline long
diff --git a/lib/Kconfig b/lib/Kconfig
index d241fe476fda..0e66c9fa636b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -50,12 +50,18 @@ config HAVE_ARCH_BITREVERSE
 	  This option enables the use of hardware bit-reversal instructions on
 	  architectures which support such operations.
 
-config GENERIC_STRNCPY_FROM_USER
+config ARCH_HAS_STRNCPY_FROM_USER
 	bool
 
-config GENERIC_STRNLEN_USER
+config ARCH_HAS_STRNLEN_USER
 	bool
 
+config GENERIC_STRNCPY_FROM_USER
+	def_bool !ARCH_HAS_STRNCPY_FROM_USER
+
+config GENERIC_STRNLEN_USER
+	def_bool !ARCH_HAS_STRNLEN_USER
+
 config GENERIC_NET_UTILS
 	bool
 
-- 
2.29.2


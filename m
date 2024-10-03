Return-Path: <linux-arch+bounces-7657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77698F29C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20C21F22E3E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B71A3A92;
	Thu,  3 Oct 2024 15:29:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E761A4F29;
	Thu,  3 Oct 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969369; cv=none; b=uw69rUI3Jyhp275Zq3hhbHNdWioBFFwCIrJN/gv/J3hWO7GZOK37gkntlFhWpmI0O42IgnDK/t/FwFDC3LCt6FdrjHpMbRR79x1fP7yZaAWj5aAESj/Q+Y8ggfSZNH+zGABuuDV+PcP3fWjSVdx3Np+0lTBOrBM4TjFi7EvTgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969369; c=relaxed/simple;
	bh=aeSksGIJsdihTnrvFwxAwQHQFWnxRDE/7GQu9zRRFJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqY8Prq2XQw6KkvofTlr+0Gz2lVUvwJtE+CbF/0WS+2k2fE9jo2RnnP3xsHYWiyxyJyd0WKxye9M40UYDol1OxPdS1X6ndw5hGq6oQyb3+lOEp/oktDvhksotjk9f9Mojm+8XqRPXylDLsC4vwB95UYKebfO5FKo7DFlmXzFD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72F3F497;
	Thu,  3 Oct 2024 08:29:56 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD6053F640;
	Thu,  3 Oct 2024 08:29:23 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3 2/2] vdso: Introduce vdso/page.h
Date: Thu,  3 Oct 2024 16:29:10 +0100
Message-Id: <20241003152910.3287259-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VDSO implementation includes headers from outside of the
vdso/ namespace.

Introduce vdso/page.h to make sure that the generic library
uses only the allowed namespace.

Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
it supports 64-bit phys_addr_t we might end up in situation in which the
top 32 bit are cleared. To prevent this issue this patch provides
separate macros for PAGE_MASK.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/alpha/include/asm/page.h      |  6 +-----
 arch/arc/include/uapi/asm/page.h   |  7 +++----
 arch/arm/include/asm/page.h        |  5 +----
 arch/arm64/include/asm/page-def.h  |  5 +----
 arch/csky/include/asm/page.h       |  8 ++------
 arch/hexagon/include/asm/page.h    |  4 +---
 arch/loongarch/include/asm/page.h  |  7 +------
 arch/m68k/include/asm/page.h       |  6 ++----
 arch/microblaze/include/asm/page.h |  5 +----
 arch/mips/include/asm/page.h       |  7 +------
 arch/nios2/include/asm/page.h      |  7 +------
 arch/openrisc/include/asm/page.h   | 11 +----------
 arch/parisc/include/asm/page.h     |  4 +---
 arch/powerpc/include/asm/page.h    | 10 +---------
 arch/riscv/include/asm/page.h      |  4 +---
 arch/s390/include/asm/page.h       |  4 +---
 arch/sh/include/asm/page.h         |  6 ++----
 arch/sparc/include/asm/page_32.h   |  4 +---
 arch/sparc/include/asm/page_64.h   |  4 +---
 arch/um/include/asm/page.h         |  5 +----
 arch/x86/include/asm/page_types.h  |  5 +----
 arch/xtensa/include/asm/page.h     |  8 +-------
 include/vdso/page.h                | 23 +++++++++++++++++++++++
 23 files changed, 50 insertions(+), 105 deletions(-)
 create mode 100644 include/vdso/page.h

diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
index 70419e6be1a3..261af54fd601 100644
--- a/arch/alpha/include/asm/page.h
+++ b/arch/alpha/include/asm/page.h
@@ -4,11 +4,7 @@
 
 #include <linux/const.h>
 #include <asm/pal.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arc/include/uapi/asm/page.h b/arch/arc/include/uapi/asm/page.h
index 7fd9e741b527..4606a326af5c 100644
--- a/arch/arc/include/uapi/asm/page.h
+++ b/arch/arc/include/uapi/asm/page.h
@@ -14,7 +14,7 @@
 
 /* PAGE_SHIFT determines the page size */
 #ifdef __KERNEL__
-#define PAGE_SHIFT CONFIG_PAGE_SHIFT
+#include <vdso/page.h>
 #else
 /*
  * Default 8k
@@ -24,11 +24,10 @@
  * not available
  */
 #define PAGE_SHIFT 13
+#define PAGE_SIZE	_BITUL(PAGE_SHIFT)	/* Default 8K */
+#define PAGE_MASK	(~(PAGE_SIZE-1))
 #endif
 
-#define PAGE_SIZE	_BITUL(PAGE_SHIFT)	/* Default 8K */
 #define PAGE_OFFSET	_AC(0x80000000, UL)	/* Kernel starts at 2G onwrds */
 
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
 #endif /* _UAPI__ASM_ARC_PAGE_H */
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 62af9f7f9e96..ef11b721230e 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -7,10 +7,7 @@
 #ifndef _ASMARM_PAGE_H
 #define _ASMARM_PAGE_H
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
index 792e9fe881dc..d402e08442ee 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -10,9 +10,6 @@
 
 #include <linux/const.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #endif /* __ASM_PAGE_DEF_H */
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 0ca6c408c07f..f8beae295afb 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -7,12 +7,8 @@
 #include <asm/cache.h>
 #include <linux/const.h>
 
-/*
- * PAGE_SHIFT determines the page size: 4KB
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
+
 #define THREAD_SIZE	(PAGE_SIZE * 2)
 #define THREAD_MASK	(~(THREAD_SIZE - 1))
 #define THREAD_SHIFT	(PAGE_SHIFT + 1)
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 8a6af57274c2..b01f8df69dd4 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -45,9 +45,7 @@
 #define HVM_HUGEPAGE_SIZE 0x5
 #endif
 
-#define PAGE_SHIFT CONFIG_PAGE_SHIFT
-#define PAGE_SIZE  (1UL << PAGE_SHIFT)
-#define PAGE_MASK  (~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index e85df33f11c7..83f3533e31a4 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -8,12 +8,7 @@
 #include <linux/const.h>
 #include <asm/addrspace.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
 #define HPAGE_SIZE	(_AC(1, UL) << HPAGE_SHIFT)
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 8cfb84b49975..b173ba27d36f 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -6,10 +6,8 @@
 #include <asm/setup.h>
 #include <asm/page_offset.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
+
 #define PAGE_OFFSET	(PAGE_OFFSET_RAW)
 
 #ifndef __ASSEMBLY__
diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index 8810f4f1c3b0..d1ec3806edab 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -19,10 +19,7 @@
 
 #ifdef __KERNEL__
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define LOAD_OFFSET	ASM_CONST((CONFIG_KERNEL_START-CONFIG_KERNEL_BASE_ADDR))
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 4609cb0326cf..bc3e3484c1bf 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -14,12 +14,7 @@
 #include <linux/kernel.h>
 #include <asm/mipsregs.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#include <vdso/page.h>
 
 /*
  * This is used for calculating the real page sizes
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index 0722f88e63cc..2897ec1b74f6 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -18,12 +18,7 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 /*
  * PAGE_OFFSET -- the first address of the first page of memory.
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index 1d5913f67c31..124a2db4b160 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -15,16 +15,7 @@
 #ifndef __ASM_OPENRISC_PAGE_H
 #define __ASM_OPENRISC_PAGE_H
 
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE       (1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK       (~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define PAGE_OFFSET	0xc0000000
 #define KERNELBASE	PAGE_OFFSET
diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 4bea2e95798f..6c4836fb5407 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -4,9 +4,7 @@
 
 #include <linux/const.h>
 
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 83d0a4fc5f75..af9a2628d1df 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -21,8 +21,7 @@
  * page size. When using 64K pages however, whether we are really supporting
  * 64K pages in HW or not is irrelevant to those definitions.
  */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_HUGETLB_PAGE
@@ -41,13 +40,6 @@ extern unsigned int hpage_shift;
 #define HUGE_MAX_HSTATE		(MMU_PAGE_COUNT-1)
 #endif
 
-/*
- * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
- * assign PAGE_MASK to a larger type it gets extended the way we want
- * (i.e. with 1s in the high bits)
- */
-#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
-
 /*
  * KERNELBASE is the virtual address of the start of the kernel, it's often
  * the same as PAGE_OFFSET, but _might not be_.
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 32d308a3355f..9875399827c7 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -12,9 +12,7 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
 
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1, UL) << HPAGE_SHIFT)
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 73e1e03317b4..c949fe7736b9 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -11,9 +11,7 @@
 #include <linux/const.h>
 #include <asm/types.h>
 
-#define _PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define _PAGE_SIZE	(_AC(1, UL) << _PAGE_SHIFT)
-#define _PAGE_MASK	(~(_PAGE_SIZE - 1))
+#include <vdso/page.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	_PAGE_SHIFT
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index f780b467e75d..fc39b8171bfb 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -8,10 +8,8 @@
 
 #include <linux/const.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
+
 #define PTE_MASK	PAGE_MASK
 
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 9977c77374cd..9954254ea569 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -11,9 +11,7 @@
 
 #include <linux/const.h>
 
-#define PAGE_SHIFT   CONFIG_PAGE_SHIFT
-#define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index e9bd24821c93..2a68ff5b6eab 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -4,9 +4,7 @@
 
 #include <linux/const.h>
 
-#define PAGE_SHIFT   CONFIG_PAGE_SHIFT
-#define PAGE_SIZE    (_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK    (~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 /* Flushing for D-cache alias handling is only needed if
  * the page size is smaller than 16K.
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 9ef9a8aedfa6..834313ecd3d6 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -9,10 +9,7 @@
 
 #include <linux/const.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 52f1b4ff0cc1..974688973cf6 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -6,10 +6,7 @@
 #include <linux/types.h>
 #include <linux/mem_encrypt.h>
 
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 4db56ef052d2..595c1037b738 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -18,13 +18,7 @@
 #include <asm/cache.h>
 #include <asm/kmem_layout.h>
 
-/*
- * PAGE_SHIFT determines the page size
- */
-
-#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
-#define PAGE_SIZE	(__XTENSA_UL_CONST(1) << PAGE_SHIFT)
-#define PAGE_MASK	(~(PAGE_SIZE-1))
+#include <vdso/page.h>
 
 #ifdef CONFIG_MMU
 #define PAGE_OFFSET	XCHAL_KSEG_CACHED_VADDR
diff --git a/include/vdso/page.h b/include/vdso/page.h
new file mode 100644
index 000000000000..36693093665b
--- /dev/null
+++ b/include/vdso/page.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_PAGE_H
+#define __VDSO_PAGE_H
+
+#include <uapi/linux/const.h>
+
+/*
+ * PAGE_SHIFT determines the page size.
+ *
+ * Note: This definition is required because PAGE_SHIFT is used
+ * in several places throuout the codebase.
+ */
+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
+
+#define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
+
+#if defined(CONFIG_PHYS_ADDR_T_64BIT)
+#define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
+#else
+#define PAGE_MASK	(~(PAGE_SIZE-1))
+#endif
+
+#endif	/* __VDSO_PAGE_H */
-- 
2.34.1



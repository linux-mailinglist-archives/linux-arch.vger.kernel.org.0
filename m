Return-Path: <linux-arch+bounces-1864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C871B842A26
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 17:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5341F256AD
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 16:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4912DD94;
	Tue, 30 Jan 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Eu9fnlqf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C81129A95;
	Tue, 30 Jan 2024 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633595; cv=none; b=DP9SLfA2YTZUgA0EUiNvkTAzw9XH3l1/c47WXo6cEcYhEq1n/2xpbfp+qurKSRPfe/8ceAJ+wJGuHNEXrifr91q7v21b0WWXVFpnMw4WUxjFzljadXCCIHXhO9on60FfuXWKcH6RjSaPDkw53dV2XToLyLEpQepnC48/66tKpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633595; c=relaxed/simple;
	bh=XuWaMxt4d/3dm7lB6U+HSFTUUg6+UTaS46cwYkLEDis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psaBN/T9WFMsrx03PpyEXK8ZjuCu6YHHqD8UyRgB7q3TQK8rCHysFTJTZUnpfImPYZvJQZI19JXs70oAJEz1Epgd7g/OGVMLlvvAAlvcbS74/ZMKXa2qyjI74W+Uvub6pC9THq5xKq99cVo2crdYlWiFHV8gosxTlwXG/+1/rFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Eu9fnlqf; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706633585;
	bh=XuWaMxt4d/3dm7lB6U+HSFTUUg6+UTaS46cwYkLEDis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eu9fnlqfzhLzucHQO4GXUi5CfnX64GMjpe6VUPPfT4s6bICAVT4o77MD8q7QjAJSP
	 YlOp4I4vA7Bu5BearWb4qzDlQjHp0BPHrxrbBkJPO/2COFYNJx5kdHJuU7fAbWAquJ
	 IzgQPX1lw8z+xki2gN6/qLPbeZeIEJI6bXXh2m7czyaaH5c38KsSz2PfKAh/CGa5w8
	 /pw/3osZ+zO3DcL4GUYFfdb6WlH315jS5xDN3ZakazBLbrXYFJr5CvX74U4sFWhPoR
	 RNBEIN3CJKWHmlzN6rkvu+KirGViahrvLPjkkKihr4Tw4e3UxZnaRtd8yK1Xy8h7pg
	 2c29zPZ8Pv9hg==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPWSc5mWlzVgM;
	Tue, 30 Jan 2024 11:53:04 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [RFC PATCH v2 7/8] Introduce dcache_is_aliasing() across all architectures
Date: Tue, 30 Jan 2024 11:52:54 -0500
Message-Id: <20240130165255.212591-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a generic way to query whether the dcache is virtually aliased
on all architectures. Its purpose is to ensure that subsystems which
are incompatible with virtually aliased data caches (e.g. FS_DAX) can
reliably query this.

For dcache aliasing, there are three scenarios dependending on the
architecture. Here is a breakdown based on my understanding:

A) The dcache is always aliasing:

* arc
* csky
* m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
* sh
* parisc

B) The dcache aliasing is statically known or depends on querying CPU
   state at runtime:

* arm (cache_is_vivt() || cache_is_vipt_aliasing())
* mips (cpu_has_dc_aliases)
* nios2 (NIOS2_DCACHE_SIZE > PAGE_SIZE)
* sparc32 (vac_cache_size > PAGE_SIZE)
* sparc64 (L1DCACHE_SIZE > PAGE_SIZE)
* xtensa (DCACHE_WAY_SIZE > PAGE_SIZE)

C) The dcache is never aliasing:

* alpha
* arm64 (aarch64)
* hexagon
* loongarch (but with incoherent write buffers, which are disabled since
             commit d23b7795 ("LoongArch: Change SHMLBA from SZ_64K to PAGE_SIZE"))
* microblaze
* openrisc
* powerpc
* riscv
* s390
* um
* x86

Require architectures in A) and B) to select ARCH_HAS_CACHE_ALIASING and
implement "dcache_is_aliasing()".

Architectures in C) don't select ARCH_HAS_CACHE_ALIASING, and thus
dcache_is_aliasing() simply evaluates to "false".

Note that this leaves "icache_is_aliasing()" to be implemented as future
work. This would be useful to gate features like XIP on architectures
which have aliasing dcache-icache but not dcache-dcache.

Link: https://lore.kernel.org/lkml/20030910210416.GA24258@mail.jlokier.co.uk/
Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-xfs@vger.kernel.org
---
 arch/arc/Kconfig                    |  1 +
 arch/arc/include/asm/cachetype.h    |  9 +++++++++
 arch/arm/Kconfig                    |  1 +
 arch/arm/include/asm/cachetype.h    |  2 ++
 arch/csky/Kconfig                   |  1 +
 arch/csky/include/asm/cachetype.h   |  9 +++++++++
 arch/m68k/Kconfig                   |  1 +
 arch/m68k/include/asm/cachetype.h   |  9 +++++++++
 arch/mips/Kconfig                   |  1 +
 arch/mips/include/asm/cachetype.h   |  9 +++++++++
 arch/nios2/Kconfig                  |  1 +
 arch/nios2/include/asm/cachetype.h  | 10 ++++++++++
 arch/parisc/Kconfig                 |  1 +
 arch/parisc/include/asm/cachetype.h |  9 +++++++++
 arch/sh/Kconfig                     |  1 +
 arch/sh/include/asm/cachetype.h     |  9 +++++++++
 arch/sparc/Kconfig                  |  1 +
 arch/sparc/include/asm/cachetype.h  | 14 ++++++++++++++
 arch/xtensa/Kconfig                 |  1 +
 arch/xtensa/include/asm/cachetype.h | 10 ++++++++++
 include/linux/cacheinfo.h           |  6 ++++++
 mm/Kconfig                          |  6 ++++++
 22 files changed, 112 insertions(+)
 create mode 100644 arch/arc/include/asm/cachetype.h
 create mode 100644 arch/csky/include/asm/cachetype.h
 create mode 100644 arch/m68k/include/asm/cachetype.h
 create mode 100644 arch/mips/include/asm/cachetype.h
 create mode 100644 arch/nios2/include/asm/cachetype.h
 create mode 100644 arch/parisc/include/asm/cachetype.h
 create mode 100644 arch/sh/include/asm/cachetype.h
 create mode 100644 arch/sparc/include/asm/cachetype.h
 create mode 100644 arch/xtensa/include/asm/cachetype.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 1b0483c51cc1..969e6740bcf7 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
new file mode 100644
index 000000000000..290e3cc85845
--- /dev/null
+++ b/arch/arc/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARC_CACHETYPE_H
+#define __ASM_ARC_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define dcache_is_aliasing()		true
+
+#endif
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98b..5adeee5e421f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index e8c30430be33..18311570d4f0 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -20,6 +20,8 @@ extern unsigned int cacheid;
 #define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
 #define icache_is_pipt()		cacheid_is(CACHEID_PIPT)
 
+#define dcache_is_aliasing()		(cache_is_vivt() || cache_is_vipt_aliasing())
+
 /*
  * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
  * Mask out support which will never be present on newer CPUs.
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index cf2a6fd7dff8..439d7640deb8 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -2,6 +2,7 @@
 config CSKY
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/csky/include/asm/cachetype.h b/arch/csky/include/asm/cachetype.h
new file mode 100644
index 000000000000..fd21c815a8e4
--- /dev/null
+++ b/arch/csky/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_CSKY_CACHETYPE_H
+#define __ASM_CSKY_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define dcache_is_aliasing()		true
+
+#endif
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 4b3e93cac723..216338704f0a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,6 +3,7 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/m68k/include/asm/cachetype.h b/arch/m68k/include/asm/cachetype.h
new file mode 100644
index 000000000000..24298a45b215
--- /dev/null
+++ b/arch/m68k/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_M68K_CACHETYPE_H
+#define __ASM_M68K_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define dcache_is_aliasing()		true
+
+#endif
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..cc21e88b2dc4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 140000
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
diff --git a/arch/mips/include/asm/cachetype.h b/arch/mips/include/asm/cachetype.h
new file mode 100644
index 000000000000..b967c4219c31
--- /dev/null
+++ b/arch/mips/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MIPS_CACHETYPE_H
+#define __ASM_MIPS_CACHETYPE_H
+
+#include <asm/cpu-features.h>
+
+#define dcache_is_aliasing()		cpu_has_dc_aliases
+
+#endif
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index d54464021a61..af3a0631f4f1 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,6 +2,7 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/nios2/include/asm/cachetype.h b/arch/nios2/include/asm/cachetype.h
new file mode 100644
index 000000000000..3027ba4e75ab
--- /dev/null
+++ b/arch/nios2/include/asm/cachetype.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NIOS2_CACHETYPE_H
+#define __ASM_NIOS2_CACHETYPE_H
+
+#include <asm/page.h>
+#include <asm/cache.h>
+
+#define dcache_is_aliasing()		(NIOS2_DCACHE_SIZE > PAGE_SIZE)
+
+#endif
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index d14ccc948a29..e8c217744d83 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -8,6 +8,7 @@ config PARISC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_DMA_ALLOC if PA11
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/parisc/include/asm/cachetype.h b/arch/parisc/include/asm/cachetype.h
new file mode 100644
index 000000000000..a7f49ff26e3f
--- /dev/null
+++ b/arch/parisc/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_PARISC_CACHETYPE_H
+#define __ASM_PARISC_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define dcache_is_aliasing()		true
+
+#endif
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7500521b2b98..6465ef80c055 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,6 +2,7 @@
 config SUPERH
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
diff --git a/arch/sh/include/asm/cachetype.h b/arch/sh/include/asm/cachetype.h
new file mode 100644
index 000000000000..55619e60c55f
--- /dev/null
+++ b/arch/sh/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_CACHETYPE_H
+#define __ASM_SH_CACHETYPE_H
+
+#include <linux/types.h>
+
+#define dcache_is_aliasing()		true
+
+#endif
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49849790e66d..8794e0d0920f 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/sparc/include/asm/cachetype.h b/arch/sparc/include/asm/cachetype.h
new file mode 100644
index 000000000000..3ebc0e08a298
--- /dev/null
+++ b/arch/sparc/include/asm/cachetype.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SPARC_CACHETYPE_H
+#define __ASM_SPARC_CACHETYPE_H
+
+#include <asm/page.h>
+
+#ifdef CONFIG_SPARC32
+extern int vac_cache_size;
+#define dcache_is_aliasing()		(vac_cache_size > PAGE_SIZE)
+#else
+#define dcache_is_aliasing()		(L1DCACHE_SIZE > PAGE_SIZE)
+#endif
+
+#endif
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7d792077e5fd..54dbe9f42ec0 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,6 +2,7 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/xtensa/include/asm/cachetype.h b/arch/xtensa/include/asm/cachetype.h
new file mode 100644
index 000000000000..1de9337e9dbd
--- /dev/null
+++ b/arch/xtensa/include/asm/cachetype.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_XTENSA_CACHETYPE_H
+#define __ASM_XTENSA_CACHETYPE_H
+
+#include <asm/cache.h>
+#include <asm/page.h>
+
+#define dcache_is_aliasing()		(DCACHE_WAY_SIZE > PAGE_SIZE)
+
+#endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d504eb4b49ab..a307916fac40 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -138,4 +138,10 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 #define use_arch_cache_info()	(false)
 #endif
 
+#ifndef CONFIG_ARCH_HAS_CACHE_ALIASING
+#define dcache_is_aliasing()	false
+#else
+#include <asm/cachetype.h>
+#endif
+
 #endif /* _LINUX_CACHEINFO_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 57cd378c73d6..3fa87e45883d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1016,6 +1016,12 @@ config IDLE_PAGE_TRACKING
 	  See Documentation/admin-guide/mm/idle_page_tracking.rst for
 	  more details.
 
+# Architectures which implement dcache_is_aliasing() to query whether
+# the data caches are aliased (VIVT or VIPT with dcache aliasing) need
+# to select this.
+config ARCH_HAS_CACHE_ALIASING
+	bool
+
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
-- 
2.39.2



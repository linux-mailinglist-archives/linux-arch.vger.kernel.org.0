Return-Path: <linux-arch+bounces-1807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCDC8414DF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534C71F259C1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8D159577;
	Mon, 29 Jan 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cc6AJwaW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BE157E62;
	Mon, 29 Jan 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562415; cv=none; b=GY2fhIClxGJDnoYI+3X3U36ysLYZgqnW5rORm8NyjKxajRy8V7J24tkbN5u9i/zNBO2Z6MPnShp7uV+1AAgS9zpm3eIyACuQUG5pXj6XGEmcwHUbGtb+aws8pAKkYq+NhPllIGqkCDCeVpm17R3b7uSaG0PdHU28kD0RuOc5AfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562415; c=relaxed/simple;
	bh=J/9xbvTV5OyXm1sKq5praOxLctUBdW1K5E3YjxgQCJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1AV3KVw5tqJqDuCnDIAW2IhTLpWm51N1pk4megurGCgMNDG/XbooC3UwhqOfkgIVm2RG2PzqZye5STrDmjHKgrPJUB5r5FMbrk1CABRGR8dpa25k8EW5qghm25cYdbM0b6+HWM6NV76mjqytze4Mkwnl7HqgDVT9ypPMqccuPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cc6AJwaW; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706562409;
	bh=J/9xbvTV5OyXm1sKq5praOxLctUBdW1K5E3YjxgQCJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc6AJwaW53TEJB1C0GzSIJUzCi5gxtxRJraR4hxkjY2GxsNHMVrz6uJxMLtQ1zned
	 Ef7iRius/wZhslKg0oQywqcSmk3PGgBdxZ6oGNhuk6jdn6fcLfQujEzp+MVsRJYcUF
	 uZmpH2/Ys3VNZHySEu2ZNYw6+XPlXE7A6OAufT+0Z0TfLAG4YNuhZg/kbKrmnO2n+p
	 PwONvdsMk5OkCjaSh4FhYhYkWT++n20q/PymRiR4jJ+xTPBMtcSZ+gDyadMQZ/xQ5A
	 noWAjPXRAugfKSLLGG14W5SJRQMfmB/jnZWHGL5PKMdfiqGwl2IpZboxy9HzJZhR8p
	 q4TbPNIbozRyQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TP17s32c2zVYT;
	Mon, 29 Jan 2024 16:06:49 -0500 (EST)
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
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: [RFC PATCH 1/7] Introduce cache_is_aliasing() across all architectures
Date: Mon, 29 Jan 2024 16:06:25 -0500
Message-Id: <20240129210631.193493-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a generic way to query whether the dcache is virtually aliased
on all architectures. Its purpose is to ensure that subsystems which
are incompatible with virtually aliased caches (e.g. FS_DAX) can
reliably query this.

For dcache aliasing, there are three scenarios dependending on the
architecture. Here is a breakdown based on my understanding:

A) The dcache is always aliasing:
   (ARCH_HAS_CACHE_ALIASING=y)

* arm V4, V5 (CPU_CACHE_VIVT)
* arc
* csky
* m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
* sh
* parisc

B) The dcache aliasing depends on querying CPU state at runtime:
   (ARCH_HAS_CACHE_ALIASING_DYNAMIC=y)

* arm V6, V6K (CPU_CACHE_VIPT) (cache_is_vipt_aliasing())
* mips (cpu_has_dc_aliases)
* nios2 (NIOS2_DCACHE_SIZE > PAGE_SIZE)
* sparc32 (vac_cache_size > PAGE_SIZE)
* sparc64 (L1DCACHE_SIZE > PAGE_SIZE)
* xtensa (DCACHE_WAY_SIZE > PAGE_SIZE)

C) The dcache is never aliasing:

* arm V7, V7M (unless ARM V6 or V6K are also present) (CPU_CACHE_VIPT)
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

Link: https://lore.kernel.org/lkml/20030910210416.GA24258@mail.jlokier.co.uk/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev
---
 arch/arc/Kconfig                    |  1 +
 arch/arm/include/asm/cachetype.h    |  3 +++
 arch/arm/mm/Kconfig                 |  2 ++
 arch/csky/Kconfig                   |  1 +
 arch/m68k/Kconfig                   |  1 +
 arch/mips/Kconfig                   |  1 +
 arch/mips/include/asm/cachetype.h   |  9 +++++++++
 arch/nios2/Kconfig                  |  1 +
 arch/nios2/include/asm/cachetype.h  | 10 ++++++++++
 arch/parisc/Kconfig                 |  1 +
 arch/sh/Kconfig                     |  1 +
 arch/sparc/Kconfig                  |  1 +
 arch/sparc/include/asm/cachetype.h  | 14 ++++++++++++++
 arch/xtensa/Kconfig                 |  1 +
 arch/xtensa/include/asm/cachetype.h | 10 ++++++++++
 include/linux/cacheinfo.h           |  8 ++++++++
 mm/Kconfig                          | 10 ++++++++++
 17 files changed, 75 insertions(+)
 create mode 100644 arch/mips/include/asm/cachetype.h
 create mode 100644 arch/nios2/include/asm/cachetype.h
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
diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index e8c30430be33..b03054b35c74 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -16,6 +16,9 @@ extern unsigned int cacheid;
 #define cache_is_vipt()			cacheid_is(CACHEID_VIPT)
 #define cache_is_vipt_nonaliasing()	cacheid_is(CACHEID_VIPT_NONALIASING)
 #define cache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_ALIASING)
+#ifdef CONFIG_ARCH_HAS_CACHE_ALIASING_DYNAMIC
+#define cache_is_aliasing()		cache_is_vipt_aliasing()
+#endif
 #define icache_is_vivt_asid_tagged()	cacheid_is(CACHEID_ASID_TAGGED)
 #define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
 #define icache_is_pipt()		cacheid_is(CACHEID_PIPT)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c164cde50243..23af93cdc03d 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -539,9 +539,11 @@ config CPU_CACHE_NOP
 	bool
 
 config CPU_CACHE_VIVT
+	select ARCH_HAS_CACHE_ALIASING
 	bool
 
 config CPU_CACHE_VIPT
+	select ARCH_HAS_CACHE_ALIASING_DYNAMIC if CPU_V6 || CPU_V6K
 	bool
 
 config CPU_CACHE_FA
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
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..46981c507ceb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,7 @@ config MIPS
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
+	select ARCH_HAS_CACHE_ALIASING_DYNAMIC
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 140000
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
diff --git a/arch/mips/include/asm/cachetype.h b/arch/mips/include/asm/cachetype.h
new file mode 100644
index 000000000000..ce16ccde1841
--- /dev/null
+++ b/arch/mips/include/asm/cachetype.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MIPS_CACHETYPE_H
+#define __ASM_MIPS_CACHETYPE_H
+
+#include <asm/cpu-features.h>
+
+#define cache_is_aliasing()		cpu_has_dc_aliases
+
+#endif
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index d54464021a61..949dcf99e147 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -2,6 +2,7 @@
 config NIOS2
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING_DYNAMIC
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/nios2/include/asm/cachetype.h b/arch/nios2/include/asm/cachetype.h
new file mode 100644
index 000000000000..f52a16cdb496
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
+#define cache_is_aliasing()		(NIOS2_DCACHE_SIZE > PAGE_SIZE)
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
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49849790e66d..a5edcbfaf6f8 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_CACHE_ALIASING_DYNAMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/sparc/include/asm/cachetype.h b/arch/sparc/include/asm/cachetype.h
new file mode 100644
index 000000000000..8871e461cf23
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
+#define cache_is_aliasing()		(vac_cache_size > PAGE_SIZE)
+#else
+#define cache_is_aliasing()		(L1DCACHE_SIZE > PAGE_SIZE)
+#endif
+
+#endif
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7d792077e5fd..ae99aa88595a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,6 +2,7 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_CACHE_ALIASING_DYNAMIC
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/xtensa/include/asm/cachetype.h b/arch/xtensa/include/asm/cachetype.h
new file mode 100644
index 000000000000..4329c885fe5f
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
+#define cache_is_aliasing()		(DCACHE_WAY_SIZE > PAGE_SIZE)
+
+#endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d504eb4b49ab..86f9a099fd5d 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -138,4 +138,12 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 #define use_arch_cache_info()	(false)
 #endif
 
+#ifdef CONFIG_ARCH_HAS_CACHE_ALIASING
+#define cache_is_aliasing()	true
+#elif defined(CONFIG_ARCH_HAS_CACHE_ALIASING_DYNAMIC)
+#include <asm/cachetype.h>
+#else
+#define cache_is_aliasing()	false
+#endif
+
 #endif /* _LINUX_CACHEINFO_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 57cd378c73d6..08f6ca0b465a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1016,6 +1016,16 @@ config IDLE_PAGE_TRACKING
 	  See Documentation/admin-guide/mm/idle_page_tracking.rst for
 	  more details.
 
+# Architectures which alias the data cache (VIVT or VIPT with dcache
+# aliasing) need to select this.
+config ARCH_HAS_CACHE_ALIASING
+	bool
+
+# Architectures which need to query at runtime whether the data cache is
+# aliased need to select this.
+config ARCH_HAS_CACHE_ALIASING_DYNAMIC
+	bool
+
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
-- 
2.39.2



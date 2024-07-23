Return-Path: <linux-arch+bounces-5577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFED939ACF
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DBCB21C44
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3114AD1A;
	Tue, 23 Jul 2024 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2VpYoVm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723114AD0A;
	Tue, 23 Jul 2024 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717159; cv=none; b=pMX79aoFs/BlFz8NxVZFx4Y8QpbBFgxDtqPcGf/992AcAnYuRHO+MoVQAsYTeQICdteegPtZ62O6qbcwt36g6Ai1Izp3o0phPNQpRqjm0CKLS3SWCM2hqUhMYeoqLLVPTDGPr7YwYKwEA8bMJ6hTGS4hY7Jh/+qpkrDu3Rex0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717159; c=relaxed/simple;
	bh=rbVckViSVk+mWr74pnwR2o+U7UjRpaIJSEgglVAH+jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nraCNrcyS/xBMiWyRSloQkaHUUKbeT1mkTqGBC6O8rYtRJGYKUXQy9ussSx0CwhzvKimcIC+Iheu772NQYxHf57jUryQa8hi2D2GWH5YY2nO5WvCl0OJVgo0G0eL1cu0uPsz3IeolM83NRejchDrRbLtCUBRo7pEsR15khgG18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2VpYoVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB686C4AF0B;
	Tue, 23 Jul 2024 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717159;
	bh=rbVckViSVk+mWr74pnwR2o+U7UjRpaIJSEgglVAH+jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2VpYoVmHlTiPzU8OqPPA83vMOFMf/PIBBBHYwi5Wo+QDdtmOGBN5Sscv5TCpLxgN
	 NZO/x31toKmJYKIOruH56bVAhmJIg6nm0awNn5f/75Hd+0paV3Uw+mTYwKmGwaC8Zq
	 wb7M9OglSTyQU+edoI3r5AnDjjNVZA7pNqCl13LuGKJXc4OhXnw5Y2jv+06YxhonfG
	 2hX1hXiw8/5LQKlf61IepqOIywzamX/NcfHLYTl5mEaMJIfQdGJ1cGB68C0lPPiz8c
	 IoYAnoWIrKfPiDCSKfBVWMaTsbhpQXAwtUx1ww+ePFzxX42z9MKcussciG9QVw3dBx
	 XAvULj29Krlrw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 19/25] mm: introduce numa_emulation
Date: Tue, 23 Jul 2024 09:41:50 +0300
Message-ID: <20240723064156.4009477-20-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723064156.4009477-1-rppt@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Move numa_emulation codfrom arch/x86 to mm/numa_emulation.c

This code will be later reused by arch_numa.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig                     |  8 --------
 arch/x86/include/asm/numa.h          | 12 ------------
 arch/x86/mm/Makefile                 |  1 -
 arch/x86/mm/numa_internal.h          | 11 -----------
 include/linux/numa_memblks.h         | 17 +++++++++++++++++
 mm/Kconfig                           |  8 ++++++++
 mm/Makefile                          |  1 +
 {arch/x86/mm => mm}/numa_emulation.c |  4 +---
 8 files changed, 27 insertions(+), 35 deletions(-)
 rename {arch/x86/mm => mm}/numa_emulation.c (99%)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d8084f37157c..a42735c126fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1592,14 +1592,6 @@ config X86_64_ACPI_NUMA
 	help
 	  Enable ACPI SRAT based node topology detection.
 
-config NUMA_EMU
-	bool "NUMA emulation"
-	depends on NUMA
-	help
-	  Enable NUMA emulation. A flat machine will be split
-	  into virtual nodes when booted with "numa=fake=N", where N is the
-	  number of nodes. This is only useful for debugging.
-
 config NODES_SHIFT
 	int "Maximum NUMA Nodes (as a power of 2)" if !MAXSMP
 	range 1 10
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 203100500f24..5469d7a7c40f 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -65,16 +65,4 @@ static inline void init_gi_nodes(void)			{ }
 void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable);
 #endif
 
-#ifdef CONFIG_NUMA_EMU
-int numa_emu_cmdline(char *str);
-void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
-					unsigned int nr_emu_nids);
-u64 __init numa_emu_dma_end(void);
-#else /* CONFIG_NUMA_EMU */
-static inline int numa_emu_cmdline(char *str)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_NUMA_EMU */
-
 #endif	/* _ASM_X86_NUMA_H */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 8d3a00e5c528..690fbf48e853 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -57,7 +57,6 @@ obj-$(CONFIG_MMIOTRACE_TEST)	+= testmmiotrace.o
 obj-$(CONFIG_NUMA)		+= numa.o numa_$(BITS).o
 obj-$(CONFIG_AMD_NUMA)		+= amdtopology.o
 obj-$(CONFIG_ACPI_NUMA)		+= srat.o
-obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
diff --git a/arch/x86/mm/numa_internal.h b/arch/x86/mm/numa_internal.h
index 249e3aaeadce..11e1ff370c10 100644
--- a/arch/x86/mm/numa_internal.h
+++ b/arch/x86/mm/numa_internal.h
@@ -7,15 +7,4 @@
 
 void __init x86_numa_init(void);
 
-struct numa_meminfo;
-
-#ifdef CONFIG_NUMA_EMU
-void __init numa_emulation(struct numa_meminfo *numa_meminfo,
-			   int numa_dist_cnt);
-#else
-static inline void numa_emulation(struct numa_meminfo *numa_meminfo,
-				  int numa_dist_cnt)
-{ }
-#endif
-
 #endif	/* __X86_MM_NUMA_INTERNAL_H */
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index 968a590535ac..f81f98678074 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -34,6 +34,23 @@ int __init numa_register_meminfo(struct numa_meminfo *mi);
 void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
 				       const struct numa_meminfo *mi);
 
+#ifdef CONFIG_NUMA_EMU
+int numa_emu_cmdline(char *str);
+void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
+					unsigned int nr_emu_nids);
+u64 __init numa_emu_dma_end(void);
+void __init numa_emulation(struct numa_meminfo *numa_meminfo,
+			   int numa_dist_cnt);
+#else
+static inline void numa_emulation(struct numa_meminfo *numa_meminfo,
+				  int numa_dist_cnt)
+{ }
+static inline int numa_emu_cmdline(char *str)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_NUMA_EMU */
+
 #endif /* CONFIG_NUMA_MEMBLKS */
 
 #endif	/* __NUMA_MEMBLKS_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 15c6efbaa1df..ae58eecdefdc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1252,6 +1252,14 @@ config EXECMEM
 config NUMA_MEMBLKS
 	bool
 
+config NUMA_EMU
+	bool "NUMA emulation"
+	depends on NUMA_MEMBLKS
+	help
+	  Enable NUMA emulation. A flat machine will be split
+	  into virtual nodes when booted with "numa=fake=N", where N is the
+	  number of nodes. This is only useful for debugging.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 17bc4013a2c5..d5b1b30f76e3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -141,3 +141,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_NUMA_MEMBLKS) += numa_memblks.o
+obj-$(CONFIG_NUMA_EMU) += numa_emulation.o
diff --git a/arch/x86/mm/numa_emulation.c b/mm/numa_emulation.c
similarity index 99%
rename from arch/x86/mm/numa_emulation.c
rename to mm/numa_emulation.c
index 33610026b7a3..031fb9961bf7 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -7,9 +7,7 @@
 #include <linux/topology.h>
 #include <linux/memblock.h>
 #include <linux/numa_memblks.h>
-#include <asm/dma.h>
-
-#include "numa_internal.h"
+#include <asm/numa.h>
 
 #define FAKE_NODE_MIN_SIZE	((u64)32 << 20)
 #define FAKE_NODE_MIN_HASH_MASK	(~(FAKE_NODE_MIN_SIZE - 1UL))
-- 
2.43.0



Return-Path: <linux-arch+bounces-3577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13538A1BB9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625D81F21FAD
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD810137744;
	Thu, 11 Apr 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPGaemmP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A313541B;
	Thu, 11 Apr 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851420; cv=none; b=oafjOfmSLxNFA/ZwL2kWFmECwJz9CIXCXl1XzsRJtmsTEwSoxNsdn2ltqyyptk9cqXwV8QPIZpMLggKfGVp2BvKAGZXraSvtsP1A8fB5HsgV4+rbSyFoGxj58KZuKQHahY7yffxTjSMB0mxeE3US5Jhye0eNkTzXRGOXiNOSh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851420; c=relaxed/simple;
	bh=cFR+j2I6I2LOmNSlpqaTUSJw6TmhqAA/ya1HnM1IaC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkH90LhSPIZjqGW7py7Do1BKzEi5queEeh57KTsLOq3DaECUTm4RVb5TIIFIqmx3ShVJP2N43WTjEVvbv05cVZLL5hHYrO6gbgdq9oFo+dppA4L+z6y/VT8T9wCUT2EbHl77IEm0+/D956YCZvrYR0q7A225fet1sRY76QBNcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPGaemmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57135C113CE;
	Thu, 11 Apr 2024 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851420;
	bh=cFR+j2I6I2LOmNSlpqaTUSJw6TmhqAA/ya1HnM1IaC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPGaemmPCkkY5NTA+VP9rIIybNxqm3nxpic0KE7HfnknOHUB35MXKqQ4SmryC9p0h
	 nJXhFD5VfFe2LduN4Mdd5bE7Zou006LABNM6lQKY1K+sro0kqeHvPgyMOQJ/0YFr9R
	 8+HLDbAWuHLO86F30VPuo7WjSELg2/rjRny7yl4Gbqrx1Vpn25ln2H7UI/WJqroDkj
	 62ZMJK0LIxntMqp/Abr9EbMwUVFdNmIor6a5hDTB/EkISOYdjZi2MPvQXL4c5wuxx0
	 0ZYpvmU8lxQAwsEyS538uq9hZa9wTNDkCSULKAfI6nrh4KW2lsOZXCMZSpWQRiWMmG
	 oHbf2JAdcS+Gw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 11/15] arch: make execmem setup available regardless of CONFIG_MODULES
Date: Thu, 11 Apr 2024 19:00:47 +0300
Message-ID: <20240411160051.2093261-12-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160051.2093261-1-rppt@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

execmem does not depend on modules, on the contrary modules use
execmem.

To make execmem available when CONFIG_MODULES=n, for instance for
kprobes, split execmem_params initialization out from
arch/*/kernel/module.c and compile it when CONFIG_EXECMEM=y

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/kernel/module.c       |  40 ----------
 arch/arm/mm/init.c             |  40 ++++++++++
 arch/arm64/kernel/module.c     | 136 ---------------------------------
 arch/arm64/mm/init.c           | 136 +++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/module.c |  18 -----
 arch/loongarch/mm/init.c       |  20 +++++
 arch/mips/kernel/module.c      |  21 -----
 arch/mips/mm/init.c            |  22 ++++++
 arch/nios2/kernel/module.c     |  18 -----
 arch/nios2/mm/init.c           |  19 +++++
 arch/parisc/kernel/module.c    |  19 -----
 arch/parisc/mm/init.c          |  22 +++++-
 arch/powerpc/kernel/module.c   |  63 ---------------
 arch/powerpc/mm/mem.c          |  64 ++++++++++++++++
 arch/riscv/kernel/module.c     |  40 ----------
 arch/riscv/mm/init.c           |  41 ++++++++++
 arch/s390/kernel/module.c      |  25 ------
 arch/s390/mm/init.c            |  28 +++++++
 arch/sparc/kernel/module.c     |  23 ------
 arch/sparc/mm/Makefile         |   2 +
 arch/sparc/mm/execmem.c        |  25 ++++++
 arch/x86/kernel/module.c       |  25 ------
 arch/x86/mm/init.c             |  27 +++++++
 23 files changed, 445 insertions(+), 429 deletions(-)
 create mode 100644 arch/sparc/mm/execmem.c

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 32974758c73b..677f218f7e84 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -12,54 +12,14 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/elf.h>
-#include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/string.h>
-#include <linux/gfp.h>
-#include <linux/execmem.h>
 
 #include <asm/sections.h>
 #include <asm/smp_plat.h>
 #include <asm/unwind.h>
 #include <asm/opcodes.h>
 
-#ifdef CONFIG_XIP_KERNEL
-/*
- * The XIP kernel text is mapped in the module area for modules and
- * some other stuff to work without any indirect relocations.
- * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
- * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
- */
-#undef MODULES_VADDR
-#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
-#endif
-
-#ifdef CONFIG_MMU
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	struct execmem_range *r = &execmem_info.ranges[EXECMEM_DEFAULT];
-
-	r->pgprot = PAGE_KERNEL_EXEC;
-
-	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS)) {
-		r->fallback_start = VMALLOC_START;
-		r->fallback_end = VMALLOC_END;
-	}
-
-	return &execmem_info;
-}
-#endif
-
 bool module_init_section(const char *name)
 {
 	return strstarts(name, ".init") ||
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index e8c6f4be0ce1..e54338825156 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
 #include <linux/swiotlb.h>
+#include <linux/execmem.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
@@ -486,3 +487,42 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
 }
 #endif
+
+#ifdef CONFIG_EXECMEM
+#ifdef CONFIG_XIP_KERNEL
+/*
+ * The XIP kernel text is mapped in the module area for modules and
+ * some other stuff to work without any indirect relocations.
+ * MODULES_VADDR is redefined here and not in asm/memory.h to avoid
+ * recompiling the whole kernel when CONFIG_XIP_KERNEL is turned on/off.
+ */
+#undef MODULES_VADDR
+#define MODULES_VADDR	(((unsigned long)_exiprom + ~PMD_MASK) & PMD_MASK)
+#endif
+
+#ifdef CONFIG_MMU
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	struct execmem_range *r = &execmem_info.ranges[EXECMEM_DEFAULT];
+
+	r->pgprot = PAGE_KERNEL_EXEC;
+
+	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS)) {
+		r->fallback_start = VMALLOC_START;
+		r->fallback_end = VMALLOC_END;
+	}
+
+	return &execmem_info;
+}
+#endif
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index aa9e2b3d7459..36b25af56324 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -12,154 +12,18 @@
 #include <linux/bitops.h>
 #include <linux/elf.h>
 #include <linux/ftrace.h>
-#include <linux/gfp.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/moduleloader.h>
 #include <linux/random.h>
 #include <linux/scs.h>
-#include <linux/vmalloc.h>
-#include <linux/execmem.h>
 
 #include <asm/alternative.h>
 #include <asm/insn.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
 
-static u64 module_direct_base __ro_after_init = 0;
-static u64 module_plt_base __ro_after_init = 0;
-
-/*
- * Choose a random page-aligned base address for a window of 'size' bytes which
- * entirely contains the interval [start, end - 1].
- */
-static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
-{
-	u64 max_pgoff, pgoff;
-
-	if ((end - start) >= size)
-		return 0;
-
-	max_pgoff = (size - (end - start)) / PAGE_SIZE;
-	pgoff = get_random_u32_inclusive(0, max_pgoff);
-
-	return start - pgoff * PAGE_SIZE;
-}
-
-/*
- * Modules may directly reference data and text anywhere within the kernel
- * image and other modules. References using PREL32 relocations have a +/-2G
- * range, and so we need to ensure that the entire kernel image and all modules
- * fall within a 2G window such that these are always within range.
- *
- * Modules may directly branch to functions and code within the kernel text,
- * and to functions and code within other modules. These branches will use
- * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
- * that the entire kernel text and all module text falls within a 128M window
- * such that these are always within range. With PLTs, we can expand this to a
- * 2G window.
- *
- * We chose the 128M region to surround the entire kernel image (rather than
- * just the text) as using the same bounds for the 128M and 2G regions ensures
- * by construction that we never select a 128M region that is not a subset of
- * the 2G region. For very large and unusual kernel configurations this means
- * we may fall back to PLTs where they could have been avoided, but this keeps
- * the logic significantly simpler.
- */
-static int __init module_init_limits(void)
-{
-	u64 kernel_end = (u64)_end;
-	u64 kernel_start = (u64)_text;
-	u64 kernel_size = kernel_end - kernel_start;
-
-	/*
-	 * The default modules region is placed immediately below the kernel
-	 * image, and is large enough to use the full 2G relocation range.
-	 */
-	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
-	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
-
-	if (!kaslr_enabled()) {
-		if (kernel_size < SZ_128M)
-			module_direct_base = kernel_end - SZ_128M;
-		if (kernel_size < SZ_2G)
-			module_plt_base = kernel_end - SZ_2G;
-	} else {
-		u64 min = kernel_start;
-		u64 max = kernel_end;
-
-		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
-			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
-		} else {
-			module_direct_base = random_bounding_box(SZ_128M, min, max);
-			if (module_direct_base) {
-				min = module_direct_base;
-				max = module_direct_base + SZ_128M;
-			}
-		}
-
-		module_plt_base = random_bounding_box(SZ_2G, min, max);
-	}
-
-	pr_info("%llu pages in range for non-PLT usage",
-		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
-	pr_info("%llu pages in range for PLT usage",
-		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
-
-	return 0;
-}
-
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.alignment = MODULE_ALIGN,
-		},
-		[EXECMEM_KPROBES] = {
-			.alignment = 1,
-		},
-		[EXECMEM_BPF] = {
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	struct execmem_range *r = &execmem_info.ranges[EXECMEM_DEFAULT];
-
-	module_init_limits();
-
-	r->pgprot = PAGE_KERNEL;
-
-	/*
-	 * Where possible, prefer to allocate within direct branch range of the
-	 * kernel such that no PLTs are necessary.
-	 */
-	if (module_direct_base) {
-		r->start = module_direct_base;
-		r->end = module_direct_base + SZ_128M;
-
-		if (module_plt_base) {
-			r->fallback_start = module_plt_base;
-			r->fallback_end = module_plt_base + SZ_2G;
-		}
-	} else if (module_plt_base) {
-		r->start = module_plt_base;
-		r->end = module_plt_base + SZ_2G;
-	}
-
-	execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
-	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_info.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
-
-	execmem_info.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
-	execmem_info.ranges[EXECMEM_BPF].start = VMALLOC_START;
-	execmem_info.ranges[EXECMEM_BPF].end = VMALLOC_END;
-
-	return &execmem_info;
-}
-
 enum aarch64_reloc_op {
 	RELOC_OP_NONE,
 	RELOC_OP_ABS,
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 03efd86dce0a..4058447507ae 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -32,6 +32,7 @@
 #include <linux/hugetlb.h>
 #include <linux/acpi_iort.h>
 #include <linux/kmemleak.h>
+#include <linux/execmem.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
@@ -432,3 +433,138 @@ void dump_mem_limit(void)
 		pr_emerg("Memory Limit: none\n");
 	}
 }
+
+#ifdef CONFIG_EXECMEM
+static u64 module_direct_base __ro_after_init = 0;
+static u64 module_plt_base __ro_after_init = 0;
+
+/*
+ * Choose a random page-aligned base address for a window of 'size' bytes which
+ * entirely contains the interval [start, end - 1].
+ */
+static u64 __init random_bounding_box(u64 size, u64 start, u64 end)
+{
+	u64 max_pgoff, pgoff;
+
+	if ((end - start) >= size)
+		return 0;
+
+	max_pgoff = (size - (end - start)) / PAGE_SIZE;
+	pgoff = get_random_u32_inclusive(0, max_pgoff);
+
+	return start - pgoff * PAGE_SIZE;
+}
+
+/*
+ * Modules may directly reference data and text anywhere within the kernel
+ * image and other modules. References using PREL32 relocations have a +/-2G
+ * range, and so we need to ensure that the entire kernel image and all modules
+ * fall within a 2G window such that these are always within range.
+ *
+ * Modules may directly branch to functions and code within the kernel text,
+ * and to functions and code within other modules. These branches will use
+ * CALL26/JUMP26 relocations with a +/-128M range. Without PLTs, we must ensure
+ * that the entire kernel text and all module text falls within a 128M window
+ * such that these are always within range. With PLTs, we can expand this to a
+ * 2G window.
+ *
+ * We chose the 128M region to surround the entire kernel image (rather than
+ * just the text) as using the same bounds for the 128M and 2G regions ensures
+ * by construction that we never select a 128M region that is not a subset of
+ * the 2G region. For very large and unusual kernel configurations this means
+ * we may fall back to PLTs where they could have been avoided, but this keeps
+ * the logic significantly simpler.
+ */
+static int __init module_init_limits(void)
+{
+	u64 kernel_end = (u64)_end;
+	u64 kernel_start = (u64)_text;
+	u64 kernel_size = kernel_end - kernel_start;
+
+	/*
+	 * The default modules region is placed immediately below the kernel
+	 * image, and is large enough to use the full 2G relocation range.
+	 */
+	BUILD_BUG_ON(KIMAGE_VADDR != MODULES_END);
+	BUILD_BUG_ON(MODULES_VSIZE < SZ_2G);
+
+	if (!kaslr_enabled()) {
+		if (kernel_size < SZ_128M)
+			module_direct_base = kernel_end - SZ_128M;
+		if (kernel_size < SZ_2G)
+			module_plt_base = kernel_end - SZ_2G;
+	} else {
+		u64 min = kernel_start;
+		u64 max = kernel_end;
+
+		if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
+			pr_info("2G module region forced by RANDOMIZE_MODULE_REGION_FULL\n");
+		} else {
+			module_direct_base = random_bounding_box(SZ_128M, min, max);
+			if (module_direct_base) {
+				min = module_direct_base;
+				max = module_direct_base + SZ_128M;
+			}
+		}
+
+		module_plt_base = random_bounding_box(SZ_2G, min, max);
+	}
+
+	pr_info("%llu pages in range for non-PLT usage",
+		module_direct_base ? (SZ_128M - kernel_size) / PAGE_SIZE : 0);
+	pr_info("%llu pages in range for PLT usage",
+		module_plt_base ? (SZ_2G - kernel_size) / PAGE_SIZE : 0);
+
+	return 0;
+}
+
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.alignment = MODULE_ALIGN,
+		},
+		[EXECMEM_KPROBES] = {
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	struct execmem_range *r = &execmem_info.ranges[EXECMEM_DEFAULT];
+
+	module_init_limits();
+
+	r->pgprot = PAGE_KERNEL;
+
+	/*
+	 * Where possible, prefer to allocate within direct branch range of the
+	 * kernel such that no PLTs are necessary.
+	 */
+	if (module_direct_base) {
+		r->start = module_direct_base;
+		r->end = module_direct_base + SZ_128M;
+
+		if (module_plt_base) {
+			r->fallback_start = module_plt_base;
+			r->fallback_end = module_plt_base + SZ_2G;
+		}
+	} else if (module_plt_base) {
+		r->start = module_plt_base;
+		r->end = module_plt_base + SZ_2G;
+	}
+
+	execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_info.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
+	execmem_info.ranges[EXECMEM_BPF].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_BPF].end = VMALLOC_END;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 78c6a68f6c3c..36d6d9eeb7c7 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -18,7 +18,6 @@
 #include <linux/ftrace.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/inst.h>
 #include <asm/unwind.h>
@@ -491,23 +490,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-
-	return &execmem_info;
-}
-
 static void module_init_ftrace_plt(const Elf_Ehdr *hdr,
 				   const Elf_Shdr *sechdrs, struct module *mod)
 {
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 4dd53427f657..5a65497c617e 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/gfp.h>
 #include <linux/hugetlb.h>
 #include <linux/mmzone.h>
+#include <linux/execmem.h>
 
 #include <asm/asm-offsets.h>
 #include <asm/bootinfo.h>
@@ -248,3 +249,22 @@ EXPORT_SYMBOL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 50505e910763..ba0f62d8eff5 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -13,14 +13,12 @@
 #include <linux/elf.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
-#include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/jump_label.h>
-#include <linux/execmem.h>
 #include <asm/jump_label.h>
 
 struct mips_hi16 {
@@ -32,25 +30,6 @@ struct mips_hi16 {
 static LIST_HEAD(dbe_list);
 static DEFINE_SPINLOCK(dbe_lock);
 
-#ifdef MODULES_VADDR
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_info;
-}
-#endif
-
 static void apply_r_mips_32(u32 *location, u32 base, Elf_Addr v)
 {
 	*location = base + v;
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 39f129205b0c..6e01697c3eba 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/initrd.h>
+#include <linux/execmem.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -576,3 +577,24 @@ EXPORT_SYMBOL_GPL(invalid_pmd_table);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
 EXPORT_SYMBOL(invalid_pte_table);
+
+#ifdef CONFIG_EXECMEM
+#ifdef MODULES_VADDR
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_info;
+}
+#endif
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
index 2b68ef8aad42..f4483243578d 100644
--- a/arch/nios2/kernel/module.c
+++ b/arch/nios2/kernel/module.c
@@ -13,31 +13,13 @@
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
-#include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/execmem.h>
 
 #include <asm/cacheflush.h>
 
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-			.pgprot = PAGE_KERNEL_EXEC,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	return &execmem_info;
-}
-
 int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 			unsigned int symindex, unsigned int relsec,
 			struct module *mod)
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 7bc82ee889c9..82abb117f851 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -26,6 +26,7 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/binfmts.h>
+#include <linux/execmem.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -143,3 +144,21 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= MKP(1, 1, 1)
 };
 DECLARE_VM_GET_PAGE_PROT
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+			.pgprot = PAGE_KERNEL_EXEC,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index 721324c42b7d..4e5d991b2b65 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -41,7 +41,6 @@
 
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
-#include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/ftrace.h>
 #include <linux/string.h>
@@ -49,7 +48,6 @@
 #include <linux/bug.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/execmem.h>
 
 #include <asm/unwind.h>
 #include <asm/sections.h>
@@ -174,23 +172,6 @@ static inline int reassemble_22(int as22)
 		((as22 & 0x0003ff) << 3));
 }
 
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL_RWX,
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
-
-	return &execmem_info;
-}
-
 #ifndef CONFIG_64BIT
 static inline unsigned long count_gots(const Elf_Rela *rela, unsigned long n)
 {
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index f876af56e13f..22b4a71dc0e9 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/nodemask.h>	/* for node_online_map */
 #include <linux/pagemap.h>	/* for release_pages */
 #include <linux/compat.h>
+#include <linux/execmem.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -481,7 +482,7 @@ void free_initmem(void)
 	/* finally dump all the instructions which were cached, since the
 	 * pages are no-longer executable */
 	flush_icache_range(init_begin, init_end);
-	
+
 	free_initmem_default(POISON_FREE_INITMEM);
 
 	/* set up a new led state on systems shipped LED State panel */
@@ -992,3 +993,22 @@ static const pgprot_t protection_map[16] = {
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= PAGE_RWX
 };
 DECLARE_VM_GET_PAGE_PROT
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL_RWX,
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index a1eaa74f2d41..77ea82e9dc5f 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -7,10 +7,8 @@
 #include <linux/elf.h>
 #include <linux/moduleloader.h>
 #include <linux/err.h>
-#include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/bug.h>
-#include <linux/execmem.h>
 #include <asm/module.h>
 #include <linux/uaccess.h>
 #include <asm/firmware.h>
@@ -89,64 +87,3 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 	return 0;
 }
-
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.alignment = 1,
-		},
-		[EXECMEM_KPROBES] = {
-			.alignment = 1,
-		},
-		[EXECMEM_MODULE_DATA] = {
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
-	struct execmem_range *text = &execmem_info.ranges[EXECMEM_DEFAULT];
-
-	/*
-	 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
-	 * allow allocating data in the entire vmalloc space
-	 */
-#ifdef MODULES_VADDR
-	struct execmem_range *data = &execmem_info.ranges[EXECMEM_MODULE_DATA];
-	unsigned long limit = (unsigned long)_etext - SZ_32M;
-
-	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
-
-	/* First try within 32M limit from _etext to avoid branch trampolines */
-	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
-		text->start = limit;
-		text->end = MODULES_END;
-		text->fallback_start = MODULES_VADDR;
-		text->fallback_end = MODULES_END;
-	} else {
-		text->start = MODULES_VADDR;
-		text->end = MODULES_END;
-	}
-	data->start = VMALLOC_START;
-	data->end = VMALLOC_END;
-	data->pgprot = PAGE_KERNEL;
-	data->alignment = 1;
-#else
-	text->start = VMALLOC_START;
-	text->end = VMALLOC_END;
-#endif
-
-	text->pgprot = prot;
-
-	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
-
-	if (strict_module_rwx_enabled())
-		execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
-	else
-		execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
-
-	return &execmem_info;
-}
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 3a440004b97d..82723dc966e4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -16,6 +16,7 @@
 #include <linux/highmem.h>
 #include <linux/suspend.h>
 #include <linux/dma-direct.h>
+#include <linux/execmem.h>
 
 #include <asm/swiotlb.h>
 #include <asm/machdep.h>
@@ -406,3 +407,66 @@ int devmem_is_allowed(unsigned long pfn)
  * the EHEA driver. Drop this when drivers/net/ethernet/ibm/ehea is removed.
  */
 EXPORT_SYMBOL_GPL(walk_system_ram_range);
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.alignment = 1,
+		},
+		[EXECMEM_KPROBES] = {
+			.alignment = 1,
+		},
+		[EXECMEM_MODULE_DATA] = {
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
+	struct execmem_range *text = &execmem_info.ranges[EXECMEM_DEFAULT];
+
+	/*
+	 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
+	 * allow allocating data in the entire vmalloc space
+	 */
+#ifdef MODULES_VADDR
+	struct execmem_range *data = &execmem_info.ranges[EXECMEM_MODULE_DATA];
+	unsigned long limit = (unsigned long)_etext - SZ_32M;
+
+	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
+
+	/* First try within 32M limit from _etext to avoid branch trampolines */
+	if (MODULES_VADDR < PAGE_OFFSET && MODULES_END > limit) {
+		text->start = limit;
+		text->end = MODULES_END;
+		text->fallback_start = MODULES_VADDR;
+		text->fallback_end = MODULES_END;
+	} else {
+		text->start = MODULES_VADDR;
+		text->end = MODULES_END;
+	}
+	data->start = VMALLOC_START;
+	data->end = VMALLOC_END;
+	data->pgprot = PAGE_KERNEL;
+	data->alignment = 1;
+#else
+	text->start = VMALLOC_START;
+	text->end = VMALLOC_END;
+#endif
+
+	text->pgprot = prot;
+
+	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_END;
+
+	if (strict_module_rwx_enabled())
+		execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	else
+		execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_EXEC;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index aad158bb2022..906f9a3a5d65 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -11,10 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/log2.h>
 #include <linux/moduleloader.h>
-#include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
-#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
 
@@ -906,44 +904,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = 1,
-		},
-		[EXECMEM_KPROBES] = {
-			.pgprot = PAGE_KERNEL_READ_EXEC,
-			.alignment = 1,
-		},
-		[EXECMEM_BPF] = {
-			.pgprot = PAGE_KERNEL,
-			.alignment = PAGE_SIZE,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-#ifdef CONFIG_64BIT
-	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-#else
-	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
-#endif
-
-	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
-	execmem_info.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
-
-	execmem_info.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
-	execmem_info.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
-
-	return &execmem_info;
-}
-#endif
-
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..25d35564be47 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #endif
 #include <linux/kfence.h>
+#include <linux/execmem.h>
 
 #include <asm/fixmap.h>
 #include <asm/io.h>
@@ -1481,3 +1482,43 @@ void __init pgtable_cache_init(void)
 		preallocate_pgd_pages_range(MODULES_VADDR, MODULES_END, "bpf/modules");
 }
 #endif
+
+#ifdef CONFIG_EXECMEM
+#ifdef CONFIG_MMU
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = 1,
+		},
+		[EXECMEM_KPROBES] = {
+			.pgprot = PAGE_KERNEL_READ_EXEC,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = PAGE_SIZE,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+#ifdef CONFIG_64BIT
+	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+#else
+	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+#endif
+
+	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_info.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
+	execmem_info.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_MMU */
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 7d38218bfd27..91e207b50394 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -37,31 +37,6 @@
 
 #define PLT_ENTRY_SIZE 22
 
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-			.pgprot = PAGE_KERNEL,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	unsigned long module_load_offset = 0;
-	unsigned long start;
-
-	if (kaslr_enabled())
-		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
-
-	start = MODULES_VADDR + module_load_offset;
-	execmem_info.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-
-	return &execmem_info;
-}
-
 #ifdef CONFIG_FUNCTION_TRACER
 void module_arch_cleanup(struct module *mod)
 {
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f6391442c0c2..9e25f9bf1445 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -49,6 +49,7 @@
 #include <asm/uv.h>
 #include <linux/virtio_anchor.h>
 #include <linux/virtio_config.h>
+#include <linux/execmem.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[PTRS_PER_PGD] __section(".bss..invalid_pg_dir");
@@ -302,3 +303,30 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+			.pgprot = PAGE_KERNEL,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	unsigned long module_load_offset = 0;
+	unsigned long start;
+
+	if (kaslr_enabled())
+		module_load_offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
+
+	start = MODULES_VADDR + module_load_offset;
+	execmem_info.ranges[EXECMEM_DEFAULT].start = start;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index b70047f944cc..b8c51cc23d96 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
-#include <linux/execmem.h>
 
 #include <asm/processor.h>
 #include <asm/spitfire.h>
@@ -22,28 +21,6 @@
 
 #include "entry.h"
 
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-#ifdef CONFIG_SPARC64
-			.start = MODULES_VADDR,
-			.end = MODULES_END,
-#else
-			.start = VMALLOC_START,
-			.end = VMALLOC_END,
-#endif
-			.alignment = 1,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_info;
-}
-
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
 			      Elf_Shdr *sechdrs,
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 809d993f6d88..2d1752108d77 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -14,3 +14,5 @@ obj-$(CONFIG_SPARC32)   += leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+
+obj-$(CONFIG_EXECMEM)	+= execmem.o
diff --git a/arch/sparc/mm/execmem.c b/arch/sparc/mm/execmem.c
new file mode 100644
index 000000000000..8904545f7814
--- /dev/null
+++ b/arch/sparc/mm/execmem.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/execmem.h>
+
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+#ifdef CONFIG_SPARC64
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
+#else
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+#endif
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_info;
+}
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 8f526f056847..837450b6e882 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -19,7 +19,6 @@
 #include <linux/jump_label.h>
 #include <linux/random.h>
 #include <linux/memory.h>
-#include <linux/execmem.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -37,30 +36,6 @@ do {							\
 } while (0)
 #endif
 
-static struct execmem_info execmem_info __ro_after_init = {
-	.ranges = {
-		[EXECMEM_DEFAULT] = {
-			.flags = EXECMEM_KASAN_SHADOW,
-			.alignment = MODULE_ALIGN,
-		},
-	},
-};
-
-struct execmem_info __init *execmem_arch_setup(void)
-{
-	unsigned long start, offset = 0;
-
-	if (kaslr_enabled())
-		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
-
-	start = MODULES_VADDR + offset;
-	execmem_info.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
-
-	return &execmem_info;
-}
-
 #ifdef CONFIG_X86_32
 int apply_relocate(Elf32_Shdr *sechdrs,
 		   const char *strtab,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..8e8cd0de3af6 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -7,6 +7,7 @@
 #include <linux/swapops.h>
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
+#include <linux/execmem.h>
 
 #include <asm/set_memory.h>
 #include <asm/cpu_device_id.h>
@@ -1099,3 +1100,29 @@ unsigned long arch_max_swapfile_size(void)
 	return pages;
 }
 #endif
+
+#ifdef CONFIG_EXECMEM
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
+			.flags = EXECMEM_KASAN_SHADOW,
+			.alignment = MODULE_ALIGN,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	unsigned long start, offset = 0;
+
+	if (kaslr_enabled())
+		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
+
+	start = MODULES_VADDR + offset;
+	execmem_info.ranges[EXECMEM_DEFAULT].start = start;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_info;
+}
+#endif /* CONFIG_EXECMEM */
-- 
2.43.0



Return-Path: <linux-arch+bounces-3974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5249F8B3296
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 10:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772F51C21711
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95A1420D5;
	Fri, 26 Apr 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+SdxsBb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F613CAB7;
	Fri, 26 Apr 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120232; cv=none; b=VPvW1LT666gMRuTeE4gv3ihAhcoQu99hmZGYYk96fJbiX7nmWdCA4+XylGg4WYGZ9RftAhPlr6XdmI+CVjF0QFuCxQRRUvJWTRK+Opr+giKredRAutDol/M39senhH7A+TplQFu7mlMQzZKMQh/Dm5qGChgUPnNo+QC2xpegB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120232; c=relaxed/simple;
	bh=9vTOQy7Y1G36FAG4wOqEVF4S12BUBGgNzRpGhr66FtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqgktvYTEpiD9Or3si4IaqGk5QwfLoWFysAGd89MwIXnTsiV+UmH9chXyoBWyTlMBxTEJYJ61FMtXeUGlwtTTceLdtoZ0D0H4DVAbCqBzal3lM0lJ/PvwUF6xWqCu20gtqeHNp3x2ymThG2BvuF1/t1vrsZI7p9HdJeXktzVjOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+SdxsBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E685C4AF0D;
	Fri, 26 Apr 2024 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120232;
	bh=9vTOQy7Y1G36FAG4wOqEVF4S12BUBGgNzRpGhr66FtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+SdxsBbtOUdu/kvEcbLF+rBcuO+zU+90hxjouz+iw8dZD6B1gSag4wDecoaRmbwG
	 T1+7kXwIzcwrt9Y9XXqv2RG0O+XKsAwOOkuXy1jPn7WPl69UujHFe41I33euqr9ag9
	 7qkwyqPWWQSAYmqDQvDRPDOsYIJixgvLt9LpVcOWX5zBmyyl4jorPMpIU8m2ixeTCs
	 ZAkE1d7h3Ht9ykwLjb2hB0liWaH7Pc9ZMDY79aWcdmlILb+6GsbL5WXdWT381vBzmy
	 A3v67nvZWbFmCwQqJJIZMNzqaXodAzeEhfq/TKCeFvo2w4Co8ZQCWz9rQmEDv/G/A6
	 gHu/37wPxOFKA==
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
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
Subject: [PATCH v6 07/16] mm/execmem, arch: convert simple overrides of module_alloc to execmem
Date: Fri, 26 Apr 2024 11:28:45 +0300
Message-ID: <20240426082854.7355-8-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426082854.7355-1-rppt@kernel.org>
References: <20240426082854.7355-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Several architectures override module_alloc() only to define address
range for code allocations different than VMALLOC address space.

Provide a generic implementation in execmem that uses the parameters for
address space ranges, required alignment and page protections provided
by architectures.

The architectures must fill execmem_info structure and implement
execmem_arch_setup() that returns a pointer to that structure. This way the
execmem initialization won't be called from every architecture, but rather
from a central place, namely a core_initcall() in execmem.

The execmem provides execmem_alloc() API that wraps __vmalloc_node_range()
with the parameters defined by the architectures.  If an architecture does
not implement execmem_arch_setup(), execmem_alloc() will fall back to
module_alloc().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/loongarch/kernel/module.c | 19 ++++++++--
 arch/mips/kernel/module.c      | 20 ++++++++--
 arch/nios2/kernel/module.c     | 21 ++++++++---
 arch/parisc/kernel/module.c    | 24 ++++++++----
 arch/riscv/kernel/module.c     | 24 ++++++++----
 arch/sparc/kernel/module.c     | 20 ++++++++--
 include/linux/execmem.h        | 47 ++++++++++++++++++++++++
 mm/execmem.c                   | 67 ++++++++++++++++++++++++++++++++--
 mm/mm_init.c                   |  2 +
 9 files changed, 210 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index c7d0338d12c1..ca6dd7ea1610 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -18,6 +18,7 @@
 #include <linux/ftrace.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/inst.h>
 #include <asm/unwind.h>
@@ -490,10 +491,22 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-void *module_alloc(unsigned long size)
+static struct execmem_info execmem_info __ro_after_init;
+
+struct execmem_info __init *execmem_arch_setup(void)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
+	execmem_info = (struct execmem_info){
+		.ranges = {
+			[EXECMEM_DEFAULT] = {
+				.start	= MODULES_VADDR,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = 1,
+			},
+		},
+	};
+
+	return &execmem_info;
 }
 
 static void module_init_ftrace_plt(const Elf_Ehdr *hdr,
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 9a6c96014904..59225a3cf918 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/jump_label.h>
+#include <linux/execmem.h>
 #include <asm/jump_label.h>
 
 struct mips_hi16 {
@@ -32,11 +33,22 @@ static LIST_HEAD(dbe_list);
 static DEFINE_SPINLOCK(dbe_lock);
 
 #ifdef MODULES_VADDR
-void *module_alloc(unsigned long size)
+static struct execmem_info execmem_info __ro_after_init;
+
+struct execmem_info __init *execmem_arch_setup(void)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
-				__builtin_return_address(0));
+	execmem_info = (struct execmem_info){
+		.ranges = {
+			[EXECMEM_DEFAULT] = {
+				.start	= MODULES_VADDR,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = 1,
+			},
+		},
+	};
+
+	return &execmem_info;
 }
 #endif
 
diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
index 9c97b7513853..0d1ee86631fc 100644
--- a/arch/nios2/kernel/module.c
+++ b/arch/nios2/kernel/module.c
@@ -18,15 +18,26 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/execmem.h>
 
 #include <asm/cacheflush.h>
 
-void *module_alloc(unsigned long size)
+static struct execmem_info execmem_info __ro_after_init;
+
+struct execmem_info __init *execmem_arch_setup(void)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				    GFP_KERNEL, PAGE_KERNEL_EXEC,
-				    VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	execmem_info = (struct execmem_info){
+		.ranges = {
+			[EXECMEM_DEFAULT] = {
+				.start	= MODULES_VADDR,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL_EXEC,
+				.alignment = 1,
+			},
+		},
+	};
+
+	return &execmem_info;
 }
 
 int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index d214bbe3c2af..bdfa85e10c1b 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -49,6 +49,7 @@
 #include <linux/bug.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/execmem.h>
 
 #include <asm/unwind.h>
 #include <asm/sections.h>
@@ -173,15 +174,22 @@ static inline int reassemble_22(int as22)
 		((as22 & 0x0003ff) << 3));
 }
 
-void *module_alloc(unsigned long size)
+static struct execmem_info execmem_info __ro_after_init;
+
+struct execmem_info __init *execmem_arch_setup(void)
 {
-	/* using RWX means less protection for modules, but it's
-	 * easier than trying to map the text, data, init_text and
-	 * init_data correctly */
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-				    GFP_KERNEL,
-				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	execmem_info = (struct execmem_info){
+		.ranges = {
+			[EXECMEM_DEFAULT] = {
+				.start	= VMALLOC_START,
+				.end	= VMALLOC_END,
+				.pgprot	= PAGE_KERNEL_RWX,
+				.alignment = 1,
+			},
+		},
+	};
+
+	return &execmem_info;
 }
 
 #ifndef CONFIG_64BIT
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 5e5a82644451..182904127ba0 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
+#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
 
@@ -906,13 +907,22 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 }
 
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
-void *module_alloc(unsigned long size)
-{
-	return __vmalloc_node_range(size, 1, MODULES_VADDR,
-				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
-				    NUMA_NO_NODE,
-				    __builtin_return_address(0));
+static struct execmem_info execmem_info __ro_after_init;
+
+struct execmem_info __init *execmem_arch_setup(void)
+{
+	execmem_info = (struct execmem_info){
+		.ranges = {
+			[EXECMEM_DEFAULT] = {
+				.start	= MODULES_VADDR,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = 1,
+			},
+		},
+	};
+
+	return &execmem_info;
 }
 #endif
 
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index d37adb2a0b54..8b7ee45defc3 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
+#include <linux/execmem.h>
 
 #include <asm/processor.h>
 #include <asm/spitfire.h>
@@ -21,11 +22,22 @@
 
 #include "entry.h"
 
-void *module_alloc(unsigned long size)
+static struct execmem_info execmem_info __ro_after_init;
+
+struct execmem_info __init *execmem_arch_setup(void)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
-				__builtin_return_address(0));
+	execmem_info = (struct execmem_info){
+		.ranges = {
+			[EXECMEM_DEFAULT] = {
+				.start	= MODULES_VADDR,
+				.end	= MODULES_END,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = 1,
+			},
+		},
+	};
+
+	return &execmem_info;
 }
 
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 8eebc8ef66e7..96fc59258467 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -33,6 +33,47 @@ enum execmem_type {
 	EXECMEM_TYPE_MAX,
 };
 
+/**
+ * struct execmem_range - definition of an address space suitable for code and
+ *			  related data allocations
+ * @start:	address space start
+ * @end:	address space end (inclusive)
+ * @pgprot:	permissions for memory in this address space
+ * @alignment:	alignment required for text allocations
+ */
+struct execmem_range {
+	unsigned long   start;
+	unsigned long   end;
+	pgprot_t        pgprot;
+	unsigned int	alignment;
+};
+
+/**
+ * struct execmem_info - architecture parameters for code allocations
+ * @ranges: array of parameter sets defining architecture specific
+ * parameters for executable memory allocations. The ranges that are not
+ * explicitly initialized by an architecture use parameters defined for
+ * @EXECMEM_DEFAULT.
+ */
+struct execmem_info {
+	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
+};
+
+/**
+ * execmem_arch_setup - define parameters for allocations of executable memory
+ *
+ * A hook for architectures to define parameters for allocations of
+ * executable memory. These parameters should be filled into the
+ * @execmem_info structure.
+ *
+ * For architectures that do not implement this method a default set of
+ * parameters will be used
+ *
+ * Return: a structure defining architecture parameters and restrictions
+ * for allocations of executable memory
+ */
+struct execmem_info *execmem_arch_setup(void);
+
 /**
  * execmem_alloc - allocate executable memory
  * @type: type of the allocation
@@ -54,4 +95,10 @@ void *execmem_alloc(enum execmem_type type, size_t size);
  */
 void execmem_free(void *ptr);
 
+#ifdef CONFIG_EXECMEM
+void execmem_init(void);
+#else
+static inline void execmem_init(void) {}
+#endif
+
 #endif /* _LINUX_EXECMEM_ALLOC_H */
diff --git a/mm/execmem.c b/mm/execmem.c
index 480adc69b20d..80e61c1e7319 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -11,14 +11,30 @@
 #include <linux/execmem.h>
 #include <linux/moduleloader.h>
 
-static void *__execmem_alloc(size_t size)
+static struct execmem_info *execmem_info __ro_after_init;
+
+static void *__execmem_alloc(struct execmem_range *range, size_t size)
 {
-	return module_alloc(size);
+	unsigned long start = range->start;
+	unsigned long end = range->end;
+	unsigned int align = range->alignment;
+	pgprot_t pgprot = range->pgprot;
+
+	return __vmalloc_node_range(size, align, start, end,
+				    GFP_KERNEL, pgprot, VM_FLUSH_RESET_PERMS,
+				    NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 void *execmem_alloc(enum execmem_type type, size_t size)
 {
-	return __execmem_alloc(size);
+	struct execmem_range *range;
+
+	if (!execmem_info)
+		return module_alloc(size);
+
+	range = &execmem_info->ranges[type];
+
+	return __execmem_alloc(range, size);
 }
 
 void execmem_free(void *ptr)
@@ -30,3 +46,48 @@ void execmem_free(void *ptr)
 	WARN_ON(in_interrupt());
 	vfree(ptr);
 }
+
+static bool execmem_validate(struct execmem_info *info)
+{
+	struct execmem_range *r = &info->ranges[EXECMEM_DEFAULT];
+
+	if (!r->alignment || !r->start || !r->end || !pgprot_val(r->pgprot)) {
+		pr_crit("Invalid parameters for execmem allocator, module loading will fail");
+		return false;
+	}
+
+	return true;
+}
+
+static void execmem_init_missing(struct execmem_info *info)
+{
+	struct execmem_range *default_range = &info->ranges[EXECMEM_DEFAULT];
+
+	for (int i = EXECMEM_DEFAULT + 1; i < EXECMEM_TYPE_MAX; i++) {
+		struct execmem_range *r = &info->ranges[i];
+
+		if (!r->start) {
+			r->pgprot = default_range->pgprot;
+			r->alignment = default_range->alignment;
+			r->start = default_range->start;
+			r->end = default_range->end;
+		}
+	}
+}
+
+struct execmem_info * __weak execmem_arch_setup(void)
+{
+	return NULL;
+}
+
+void __init execmem_init(void)
+{
+	struct execmem_info *info = execmem_arch_setup();
+
+	if (!info || !execmem_validate(info))
+		return;
+
+	execmem_init_missing(info);
+
+	execmem_info = info;
+}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82..b6a1fcf6e13a 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
+#include <linux/execmem.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -2793,4 +2794,5 @@ void __init mm_core_init(void)
 	pti_init();
 	kmsan_init_runtime();
 	mm_cache_init();
+	execmem_init();
 }
-- 
2.43.0



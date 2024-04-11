Return-Path: <linux-arch+bounces-3572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019908A1B8E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5721F22264
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8512EBE3;
	Thu, 11 Apr 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpDVqzEu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF512F370;
	Thu, 11 Apr 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851368; cv=none; b=RVs1otU8q3mtVN3B/qQSiKHKFd+8iGXQacDtDJsDGV3fVfbUTWcmBq9n52IzO8a3gKh6wM0dtwb5oWNntalcEj9Q/UbZBvzH9hxNTjN+lpOpfZhO19sTSvb6K9l/mD9EWZHBu6ARLPVakQNt//cmFCxanIt0LZAmFPaMRN3nizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851368; c=relaxed/simple;
	bh=YjSuF5EblUCKXiFXU66L3zRneEFjHZ6wJkrEniSnaXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYGT90PrLbgM406DvVdCVlxlWeYuN609s7aOHv20PI4mnA8+NaY/grIBfxhMCRBHY3yrL/VIScXOYj4Sen1FiMAFj8K/OjIKraBHiR98U/LplM1rQKbY3rznA/pzURXXnYB7hYGdfLE4bdJe5mN5Sf5q4X7miYgn+Iw5R7vMGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpDVqzEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45139C072AA;
	Thu, 11 Apr 2024 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851368;
	bh=YjSuF5EblUCKXiFXU66L3zRneEFjHZ6wJkrEniSnaXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SpDVqzEu8i/yJW4fyJAGojQrqTWaYrRvJVDZSJO3AbGiIByB91Yp2NKj54i+xMDC/
	 ecwjIgVmer+5UNAcdfWJ4m4zotBHZ1x4lEVNuU4eFLo/EnNx0CJ+N0/hrqd4mj4AFh
	 i17gy52YIj7YwAVakwn81B8Kadha66ts6pT8RbKX80G+yknx7sujgJj3x/yCu6O3n2
	 EQyvGXsd3RJulwGPOAM6+uvUDw2kfBjpTWBcV3JNSD5+3iD/aYhqwZYw9MNjL9tgWo
	 jIuMEDJqPQ7hhfFA/0r2cZOLKDVGcOJmL+SJrTKBs730xxlf5Q6C2/ichCHYQIgczo
	 faAII27ptGX1A==
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
Subject: [PATCH v4 06/15] mm/execmem, arch: convert simple overrides of module_alloc to execmem
Date: Thu, 11 Apr 2024 19:00:42 +0300
Message-ID: <20240411160051.2093261-7-rppt@kernel.org>
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
 arch/loongarch/kernel/module.c | 18 +++++++--
 arch/mips/kernel/module.c      | 19 +++++++--
 arch/nios2/kernel/module.c     | 19 ++++++---
 arch/parisc/kernel/module.c    | 23 +++++++----
 arch/riscv/kernel/module.c     | 21 +++++++---
 arch/sparc/kernel/module.c     | 41 ++++++++-----------
 include/linux/execmem.h        | 41 +++++++++++++++++++
 mm/execmem.c                   | 73 ++++++++++++++++++++++++++++++++--
 8 files changed, 202 insertions(+), 53 deletions(-)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index c7d0338d12c1..78c6a68f6c3c 100644
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
@@ -490,10 +491,21 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-void *module_alloc(unsigned long size)
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
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
+	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_info;
 }
 
 static void module_init_ftrace_plt(const Elf_Ehdr *hdr,
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 9a6c96014904..50505e910763 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/jump_label.h>
+#include <linux/execmem.h>
 #include <asm/jump_label.h>
 
 struct mips_hi16 {
@@ -32,11 +33,21 @@ static LIST_HEAD(dbe_list);
 static DEFINE_SPINLOCK(dbe_lock);
 
 #ifdef MODULES_VADDR
-void *module_alloc(unsigned long size)
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
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
-				__builtin_return_address(0));
+	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	return &execmem_info;
 }
 #endif
 
diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
index 9c97b7513853..2b68ef8aad42 100644
--- a/arch/nios2/kernel/module.c
+++ b/arch/nios2/kernel/module.c
@@ -18,15 +18,24 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/execmem.h>
 
 #include <asm/cacheflush.h>
 
-void *module_alloc(unsigned long size)
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
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				    GFP_KERNEL, PAGE_KERNEL_EXEC,
-				    VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	return &execmem_info;
 }
 
 int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
index d214bbe3c2af..721324c42b7d 100644
--- a/arch/parisc/kernel/module.c
+++ b/arch/parisc/kernel/module.c
@@ -49,6 +49,7 @@
 #include <linux/bug.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/execmem.h>
 
 #include <asm/unwind.h>
 #include <asm/sections.h>
@@ -173,15 +174,21 @@ static inline int reassemble_22(int as22)
 		((as22 & 0x0003ff) << 3));
 }
 
-void *module_alloc(unsigned long size)
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
 {
-	/* using RWX means less protection for modules, but it's
-	 * easier than trying to map the text, data, init_text and
-	 * init_data correctly */
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-				    GFP_KERNEL,
-				    PAGE_KERNEL_RWX, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+
+	return &execmem_info;
 }
 
 #ifndef CONFIG_64BIT
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 5e5a82644451..ad32e2a8621a 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
+#include <linux/execmem.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
 
@@ -906,13 +907,21 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 }
 
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
-void *module_alloc(unsigned long size)
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
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR,
-				    MODULES_END, GFP_KERNEL,
-				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
-				    NUMA_NO_NODE,
-				    __builtin_return_address(0));
+	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+
+	return &execmem_info;
 }
 #endif
 
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 66c45a2764bc..b70047f944cc 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
+#include <linux/execmem.h>
 
 #include <asm/processor.h>
 #include <asm/spitfire.h>
@@ -21,34 +22,26 @@
 
 #include "entry.h"
 
+static struct execmem_info execmem_info __ro_after_init = {
+	.ranges = {
+		[EXECMEM_DEFAULT] = {
 #ifdef CONFIG_SPARC64
-
-#include <linux/jump_label.h>
-
-static void *module_map(unsigned long size)
-{
-	if (PAGE_ALIGN(size) > MODULES_LEN)
-		return NULL;
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
-				__builtin_return_address(0));
-}
+			.start = MODULES_VADDR,
+			.end = MODULES_END,
 #else
-static void *module_map(unsigned long size)
+			.start = VMALLOC_START,
+			.end = VMALLOC_END,
+#endif
+			.alignment = 1,
+		},
+	},
+};
+
+struct execmem_info __init *execmem_arch_setup(void)
 {
-	return vmalloc(size);
-}
-#endif /* CONFIG_SPARC64 */
-
-void *module_alloc(unsigned long size)
-{
-	void *ret;
-
-	ret = module_map(size);
-	if (ret)
-		memset(ret, 0, size);
+	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
 
-	return ret;
+	return &execmem_info;
 }
 
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 43e7995593a1..89173be320cf 100644
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
diff --git a/mm/execmem.c b/mm/execmem.c
index ed2ea41a2543..d9fb20bc7354 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -5,14 +5,30 @@
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
@@ -24,3 +40,54 @@ void execmem_free(void *ptr)
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
+static int __init execmem_init(void)
+{
+	struct execmem_info *info = execmem_arch_setup();
+
+	if (!info)
+		return 0;
+
+	if (!execmem_validate(info))
+		return -EINVAL;
+
+	execmem_init_missing(info);
+
+	execmem_info = info;
+
+	return 0;
+}
+core_initcall(execmem_init);
-- 
2.43.0



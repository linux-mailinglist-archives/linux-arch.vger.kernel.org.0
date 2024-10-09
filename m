Return-Path: <linux-arch+bounces-7925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B2A997497
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 20:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046631F2449E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269371E8847;
	Wed,  9 Oct 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPcdfoHN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0851E7C07;
	Wed,  9 Oct 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497454; cv=none; b=Pzsm9L2ECUSeupXV8wIDLkS9FQ4i12l1Zzl7e8dklKeNxG9UkNP5smqrUK9uDx3j0RM7RkbEnTPD5us7MPVLQlMOai7k3MonG3PAlLgHdtteK/NgDwMQfRGOMEw7Ok0ZmpfBirY7+TpHOZkzUzNXSaGhbPEKoWGY/TKfBDmxnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497454; c=relaxed/simple;
	bh=aD/WiAG9/yslkFAt0bBosDHF+Af7kD3cn6KL2esOCx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffeAuwVzX7kalswNC5iRFSGnGRkPjfJm/j8o27crQ76YOcQeqJl825LzcYB+sS6IyyQ1GhNFCODQrkvVnnYFgsSuR4BIMCiPRQqDQcEPjf3+r5xGVjV2IeuDLqDYTAkCMU4jOjHyXjevOLq2AO7L6BJJGLSuN9VlK9GJC9cnnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPcdfoHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A47C4CED3;
	Wed,  9 Oct 2024 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497453;
	bh=aD/WiAG9/yslkFAt0bBosDHF+Af7kD3cn6KL2esOCx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPcdfoHNW7dCjISm5p26Y4bDA/3FzuOOo+QuIrfckQwo9OUdfaDZzkmxl3J2O4IXc
	 2vhocHMe5wcNPiSndsIZvEviwM+GH/5eTEkFVSkDp2ku41JfYqsad0VgItt4ReGmzc
	 TCCLLKtIhMeGjPFR1ZRhhXrf8xGXXUrkel53R/amVCsfXkyt6S8XfAIkRoCrYRobJm
	 fywtkK3sX1grPtoeQ8pfqOZ1gx6UTMe2LQysq3oyrSBBNVPyxeGvWi2uN2ogaRqr9v
	 foxX2+JV3+kqmY8GSyuPyqVZ9ECsWYQzpLZ9nLiSOzQssap1YlYpGUZAxr7FPUFhdb
	 QKun7LyjWVM9w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 7/8] execmem: add support for cache of large ROX pages
Date: Wed,  9 Oct 2024 21:08:15 +0300
Message-ID: <20241009180816.83591-8-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009180816.83591-1-rppt@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Using large pages to map text areas reduces iTLB pressure and improves
performance.

Extend execmem_alloc() with an ability to use huge pages with ROX
permissions as a cache for smaller allocations.

To populate the cache, a writable large page is allocated from vmalloc with
VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
ROX.

Portions of that large page are handed out to execmem_alloc() callers
without any changes to the permissions.

When the memory is freed with execmem_free() it is invalidated again so
that it won't contain stale instructions.

The cache is enabled when an architecture sets EXECMEM_ROX_CACHE flag in
definition of an execmem_range.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/execmem.h |   2 +
 mm/execmem.c            | 317 +++++++++++++++++++++++++++++++++++++++-
 mm/internal.h           |   1 +
 mm/vmalloc.c            |   5 +
 4 files changed, 320 insertions(+), 5 deletions(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index dfdf19f8a5e8..7436aa547818 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -77,12 +77,14 @@ struct execmem_range {
 
 /**
  * struct execmem_info - architecture parameters for code allocations
+ * @fill_trapping_insns: set memory to contain instructions that will trap
  * @ranges: array of parameter sets defining architecture specific
  * parameters for executable memory allocations. The ranges that are not
  * explicitly initialized by an architecture use parameters defined for
  * @EXECMEM_DEFAULT.
  */
 struct execmem_info {
+	void (*fill_trapping_insns)(void *ptr, size_t size, bool writable);
 	struct execmem_range	ranges[EXECMEM_TYPE_MAX];
 };
 
diff --git a/mm/execmem.c b/mm/execmem.c
index 0f6691e9ffe6..9c6ff9687860 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -7,28 +7,109 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <linux/execmem.h>
+#include <linux/maple_tree.h>
+#include <linux/set_memory.h>
 #include <linux/moduleloader.h>
 #include <linux/text-patching.h>
 
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
 static struct execmem_info *execmem_info __ro_after_init;
 static struct execmem_info default_execmem_info __ro_after_init;
 
-static void *__execmem_alloc(struct execmem_range *range, size_t size)
+#ifdef CONFIG_MMU
+struct execmem_cache {
+	struct mutex mutex;
+	struct maple_tree busy_areas;
+	struct maple_tree free_areas;
+};
+
+static struct execmem_cache execmem_cache = {
+	.mutex = __MUTEX_INITIALIZER(execmem_cache.mutex),
+	.busy_areas = MTREE_INIT_EXT(busy_areas, MT_FLAGS_LOCK_EXTERN,
+				     execmem_cache.mutex),
+	.free_areas = MTREE_INIT_EXT(free_areas, MT_FLAGS_LOCK_EXTERN,
+				     execmem_cache.mutex),
+};
+
+static inline unsigned long mas_range_len(struct ma_state *mas)
+{
+	return mas->last - mas->index + 1;
+}
+
+static int execmem_set_direct_map_valid(struct vm_struct *vm, bool valid)
+{
+	unsigned int nr = (1 << get_vm_area_page_order(vm));
+	unsigned int updated = 0;
+	int err = 0;
+
+	for (int i = 0; i < vm->nr_pages; i += nr) {
+		err = set_direct_map_valid_noflush(vm->pages[i], nr, valid);
+		if (err)
+			goto err_restore;
+		updated += nr;
+	}
+
+	return 0;
+
+err_restore:
+	for (int i = 0; i < updated; i += nr)
+		set_direct_map_valid_noflush(vm->pages[i], nr, !valid);
+
+	return err;
+}
+
+static void execmem_cache_clean(struct work_struct *work)
+{
+	struct maple_tree *free_areas = &execmem_cache.free_areas;
+	struct mutex *mutex = &execmem_cache.mutex;
+	MA_STATE(mas, free_areas, 0, ULONG_MAX);
+	void *area;
+
+	mutex_lock(mutex);
+	mas_for_each(&mas, area, ULONG_MAX) {
+		size_t size;
+
+		if (!area)
+			continue;
+
+		size = mas_range_len(&mas);
+
+		if (IS_ALIGNED(size, PMD_SIZE) &&
+		    IS_ALIGNED(mas.index, PMD_SIZE)) {
+			struct vm_struct *vm = find_vm_area(area);
+
+			execmem_set_direct_map_valid(vm, true);
+			mas_store_gfp(&mas, NULL, GFP_KERNEL);
+			vfree(area);
+		}
+	}
+	mutex_unlock(mutex);
+}
+
+static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
+
+static void *execmem_vmalloc(struct execmem_range *range, size_t size,
+			     pgprot_t pgprot, unsigned long vm_flags)
 {
 	bool kasan = range->flags & EXECMEM_KASAN_SHADOW;
-	unsigned long vm_flags  = VM_FLUSH_RESET_PERMS;
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_NOWARN;
+	unsigned int align = range->alignment;
 	unsigned long start = range->start;
 	unsigned long end = range->end;
-	unsigned int align = range->alignment;
-	pgprot_t pgprot = range->pgprot;
 	void *p;
 
 	if (kasan)
 		vm_flags |= VM_DEFER_KMEMLEAK;
 
+	if (vm_flags & VM_ALLOW_HUGE_VMAP)
+		align = PMD_SIZE;
+
 	p = __vmalloc_node_range(size, align, start, end, gfp_flags,
 				 pgprot, vm_flags, NUMA_NO_NODE,
 				 __builtin_return_address(0));
@@ -50,8 +131,224 @@ static void *__execmem_alloc(struct execmem_range *range, size_t size)
 		return NULL;
 	}
 
+	return p;
+}
+
+static int execmem_cache_add(void *ptr, size_t size)
+{
+	struct maple_tree *free_areas = &execmem_cache.free_areas;
+	struct mutex *mutex = &execmem_cache.mutex;
+	unsigned long addr = (unsigned long)ptr;
+	MA_STATE(mas, free_areas, addr - 1, addr + 1);
+	unsigned long lower, upper;
+	void *area = NULL;
+	int err;
+
+	lower = addr;
+	upper = addr + size - 1;
+
+	mutex_lock(mutex);
+	area = mas_walk(&mas);
+	if (area && mas.last == addr - 1)
+		lower = mas.index;
+
+	area = mas_next(&mas, ULONG_MAX);
+	if (area && mas.index == addr + size)
+		upper = mas.last;
+
+	mas_set_range(&mas, lower, upper);
+	err = mas_store_gfp(&mas, (void *)lower, GFP_KERNEL);
+	mutex_unlock(mutex);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static bool within_range(struct execmem_range *range, struct ma_state *mas,
+			 size_t size)
+{
+	unsigned long addr = mas->index;
+
+	if (addr >= range->start && addr + size < range->end)
+		return true;
+
+	if (range->fallback_start &&
+	    addr >= range->fallback_start && addr + size < range->fallback_end)
+		return true;
+
+	return false;
+}
+
+static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
+{
+	struct maple_tree *free_areas = &execmem_cache.free_areas;
+	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
+	MA_STATE(mas_free, free_areas, 0, ULONG_MAX);
+	MA_STATE(mas_busy, busy_areas, 0, ULONG_MAX);
+	struct mutex *mutex = &execmem_cache.mutex;
+	unsigned long addr, last, area_size = 0;
+	void *area, *ptr = NULL;
+	int err;
+
+	mutex_lock(mutex);
+	mas_for_each(&mas_free, area, ULONG_MAX) {
+		area_size = mas_range_len(&mas_free);
+
+		if (area_size >= size && within_range(range, &mas_free, size))
+			break;
+	}
+
+	if (area_size < size)
+		goto out_unlock;
+
+	addr = mas_free.index;
+	last = mas_free.last;
+
+	/* insert allocated size to busy_areas at range [addr, addr + size) */
+	mas_set_range(&mas_busy, addr, addr + size - 1);
+	err = mas_store_gfp(&mas_busy, (void *)addr, GFP_KERNEL);
+	if (err)
+		goto out_unlock;
+
+	mas_store_gfp(&mas_free, NULL, GFP_KERNEL);
+	if (area_size > size) {
+		void *ptr = (void *)(addr + size);
+
+		/*
+		 * re-insert remaining free size to free_areas at range
+		 * [addr + size, last]
+		 */
+		mas_set_range(&mas_free, addr + size, last);
+		err = mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
+		if (err) {
+			mas_store_gfp(&mas_busy, NULL, GFP_KERNEL);
+			goto out_unlock;
+		}
+	}
+	ptr = (void *)addr;
+
+out_unlock:
+	mutex_unlock(mutex);
+	return ptr;
+}
+
+static int execmem_cache_populate(struct execmem_range *range, size_t size)
+{
+	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
+	unsigned long start, end;
+	struct vm_struct *vm;
+	size_t alloc_size;
+	int err = -ENOMEM;
+	void *p;
+
+	alloc_size = round_up(size, PMD_SIZE);
+	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
+	if (!p)
+		return err;
+
+	vm = find_vm_area(p);
+	if (!vm)
+		goto err_free_mem;
+
+	/* fill memory with instructions that will trap */
+	execmem_info->fill_trapping_insns(p, alloc_size, /* writable = */ true);
+
+	start = (unsigned long)p;
+	end = start + alloc_size;
+
+	vunmap_range(start, end);
+
+	err = execmem_set_direct_map_valid(vm, false);
+	if (err)
+		goto err_free_mem;
+
+	err = vmap_pages_range_noflush(start, end, range->pgprot, vm->pages,
+				       PMD_SHIFT);
+	if (err)
+		goto err_free_mem;
+
+	err = execmem_cache_add(p, alloc_size);
+	if (err)
+		goto err_free_mem;
+
+	return 0;
+
+err_free_mem:
+	vfree(p);
+	return err;
+}
+
+static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
+{
+	void *p;
+	int err;
+
+	p = __execmem_cache_alloc(range, size);
+	if (p)
+		return p;
+
+	err = execmem_cache_populate(range, size);
+	if (err)
+		return NULL;
+
+	return __execmem_cache_alloc(range, size);
+}
+
+static bool execmem_cache_free(void *ptr)
+{
+	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
+	struct mutex *mutex = &execmem_cache.mutex;
+	unsigned long addr = (unsigned long)ptr;
+	MA_STATE(mas, busy_areas, addr, addr);
+	size_t size;
+	void *area;
+
+	mutex_lock(mutex);
+	area = mas_walk(&mas);
+	if (!area) {
+		mutex_unlock(mutex);
+		return false;
+	}
+	size = mas_range_len(&mas);
+
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mutex_unlock(mutex);
+
+	execmem_info->fill_trapping_insns(ptr, size, /* writable = */ false);
+
+	execmem_cache_add(ptr, size);
+
+	schedule_work(&execmem_cache_clean_work);
+
+	return true;
+}
+
+static void *__execmem_alloc(struct execmem_range *range, size_t size)
+{
+	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
+	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
+	pgprot_t pgprot = range->pgprot;
+	void *p;
+
+	if (use_cache)
+		p = execmem_cache_alloc(range, size);
+	else
+		p = execmem_vmalloc(range, size, pgprot, vm_flags);
+
 	return kasan_reset_tag(p);
 }
+#else
+static void *__execmem_alloc(struct execmem_range *range, size_t size)
+{
+	return vmalloc(size);
+}
+
+static bool execmem_cache_free(void *ptr)
+{
+	return false;
+}
+#endif
 
 void *execmem_alloc(enum execmem_type type, size_t size)
 {
@@ -67,7 +364,9 @@ void execmem_free(void *ptr)
 	 * supported by vmalloc.
 	 */
 	WARN_ON(in_interrupt());
-	vfree(ptr);
+
+	if (!execmem_cache_free(ptr))
+		vfree(ptr);
 }
 
 void *execmem_update_copy(void *dst, const void *src, size_t size)
@@ -92,6 +391,11 @@ static bool execmem_validate(struct execmem_info *info)
 	return true;
 }
 
+static void default_fill_trapping_insns(void *ptr, size_t size, bool writable)
+{
+	memset(ptr, 0, size);
+}
+
 static void execmem_init_missing(struct execmem_info *info)
 {
 	struct execmem_range *default_range = &info->ranges[EXECMEM_DEFAULT];
@@ -112,6 +416,9 @@ static void execmem_init_missing(struct execmem_info *info)
 			r->fallback_end = default_range->fallback_end;
 		}
 	}
+
+	if (!info->fill_trapping_insns)
+		info->fill_trapping_insns = default_fill_trapping_insns;
 }
 
 struct execmem_info * __weak execmem_arch_setup(void)
diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..95befbc19852 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1189,6 +1189,7 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 void __init vmalloc_init(void);
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                 pgprot_t prot, struct page **pages, unsigned int page_shift);
+unsigned int get_vm_area_page_order(struct vm_struct *vm);
 #else
 static inline void vmalloc_init(void)
 {
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 86b2344d7461..f340e38716c0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3007,6 +3007,11 @@ static inline unsigned int vm_area_page_order(struct vm_struct *vm)
 #endif
 }
 
+unsigned int get_vm_area_page_order(struct vm_struct *vm)
+{
+	return vm_area_page_order(vm);
+}
+
 static inline void set_vm_area_page_order(struct vm_struct *vm, unsigned int order)
 {
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
-- 
2.43.0



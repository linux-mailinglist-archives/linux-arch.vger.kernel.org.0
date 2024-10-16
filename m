Return-Path: <linux-arch+bounces-8229-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCE9A09B6
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916211F22F14
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3D209666;
	Wed, 16 Oct 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do/7mGtG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A53207A2E;
	Wed, 16 Oct 2024 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081609; cv=none; b=a9UUP3lCngnJRoXFe5mN6cx5dJo61JZ+y50SzEnhsySOsaNmI8UjDQD7uOLpFjqHtzx3aXltHe/xs0GF/Urj30bvuqjffgeKjDxwmw3Rz7xyefL3QYQt5pNlLCwv+CRtJ8WpXlvoyXwkvtHiKTSLS7Z/TCSHPjsY9pUTxAPY0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081609; c=relaxed/simple;
	bh=NeK3oZ5ARZzJCePz9ZQegaQEqg3r7Egz+KYSlVNOPd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD+IRgdwBcHXWrfik/rrMakpO02KaN++1iKMrBYhExoic4s9fcJQV5K9wxzbBD4EDpfYGccMez47lsnNHJhJG4JUZHl0sEsYMrwRVB9zE5BKKv5bioyYMFGE3Y6jxyvUymc0eiW87LL5fv/892diJ6XUIFgadXDyS9Jg640yH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do/7mGtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1C6C4CED3;
	Wed, 16 Oct 2024 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729081608;
	bh=NeK3oZ5ARZzJCePz9ZQegaQEqg3r7Egz+KYSlVNOPd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do/7mGtGCbVC60vz/EQLI3nHHAwK5S21dQ5HuOnJjYOEEXaFXU+NP1nj1w0ZJgIfY
	 +yQDBelT6C+9T4hYUp/xXz3thuJ2Uy0dcfo9sM4MdRQFe4IJwJFZV/VFKo1CpJfRrH
	 CKO2HNTZZnjWi0+3lfurCHTibqNPL9c5WB3uoycrOHkG7rhddoYJZpvH9iAUyh97ay
	 HO6WP/ExpQ26hRlNoUHg+4Peg7ryop8r8t+jPLSMrvkDoqmpCXXwe2bL3014KaQZa+
	 jv5UMV/WCXvBZnRXP3CD51g4bjgAFRhQRu2qPlxP2IDjMJmTXaJmgk5u5jLSW8wHYn
	 MK4r6jeubJH9Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>
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
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: [PATCH v6 7/8] execmem: add support for cache of large ROX pages
Date: Wed, 16 Oct 2024 15:24:23 +0300
Message-ID: <20241016122424.1655560-8-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016122424.1655560-1-rppt@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
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

The direct map alias of that large page is exculded from the direct map.

Portions of that large page are handed out to execmem_alloc() callers
without any changes to the permissions.

When the memory is freed with execmem_free() it is invalidated again so
that it won't contain stale instructions.

An architecture has to implement execmem_fill_trapping_insns() callback
and select ARCH_HAS_EXECMEM_ROX configuration option to be able to use
the ROX cache.

The cache is enabled on per-range basis when an architecture sets
EXECMEM_ROX_CACHE flag in definition of an execmem_range.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/Kconfig            |   8 +
 include/linux/execmem.h |  14 ++
 mm/execmem.c            | 325 +++++++++++++++++++++++++++++++++++++++-
 mm/internal.h           |   1 +
 mm/vmalloc.c            |   5 +
 5 files changed, 345 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 98157b38f5cf..f4f6e170eb7e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1010,6 +1010,14 @@ config ARCH_WANTS_EXECMEM_LATE
 	  enough entropy for module space randomization, for instance
 	  arm64.
 
+config ARCH_HAS_EXECMEM_ROX
+	bool
+	depends on MMU && !HIGHMEM
+	help
+	  For architectures that support allocations of executable memory
+	  with read-only execute permissions. Architecture must implement
+	  execmem_fill_trapping_insns() callback to enable this.
+
 config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	bool
 	help
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index dfdf19f8a5e8..1517fa196bf7 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -53,6 +53,20 @@ enum execmem_range_flags {
 	EXECMEM_ROX_CACHE	= (1 << 1),
 };
 
+#ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
+/**
+ * execmem_fill_trapping_insns - set memory to contain instructions that
+ *				 will trap
+ * @ptr:	pointer to memory to fill
+ * @size:	size of the range to fill
+ * @writable:	is the memory poited by @ptr is writable or ROX
+ *
+ * A hook for architecures to fill execmem ranges with invalid instructions.
+ * Architectures that use EXECMEM_ROX_CACHE must implement this.
+ */
+void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable);
+#endif
+
 /**
  * struct execmem_range - definition of an address space suitable for code and
  *			  related data allocations
diff --git a/mm/execmem.c b/mm/execmem.c
index 0f6691e9ffe6..576a57e2161f 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -6,29 +6,41 @@
  * Copyright (C) 2024 Mike Rapoport IBM.
  */
 
+#define pr_fmt(fmt) "execmem: " fmt
+
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
@@ -41,7 +53,7 @@ static void *__execmem_alloc(struct execmem_range *range, size_t size)
 	}
 
 	if (!p) {
-		pr_warn_ratelimited("execmem: unable to allocate memory\n");
+		pr_warn_ratelimited("unable to allocate memory\n");
 		return NULL;
 	}
 
@@ -50,14 +62,298 @@ static void *__execmem_alloc(struct execmem_range *range, size_t size)
 		return NULL;
 	}
 
-	return kasan_reset_tag(p);
+	return p;
 }
+#else
+static void *execmem_vmalloc(struct execmem_range *range, size_t size,
+			     pgprot_t pgprot, unsigned long vm_flags)
+{
+	return vmalloc(size);
+}
+#endif /* CONFIG_MMU */
+
+#ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
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
+		size_t size = mas_range_len(&mas);
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
+	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
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
+	execmem_fill_trapping_insns(ptr, size, /* writable = */ false);
+
+	execmem_cache_add(ptr, size);
+
+	schedule_work(&execmem_cache_clean_work);
+
+	return true;
+}
+#else /* CONFIG_ARCH_HAS_EXECMEM_ROX */
+static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
+{
+	return NULL;
+}
+
+static bool execmem_cache_free(void *ptr)
+{
+	return false;
+}
+#endif /* CONFIG_ARCH_HAS_EXECMEM_ROX */
 
 void *execmem_alloc(enum execmem_type type, size_t size)
 {
 	struct execmem_range *range = &execmem_info->ranges[type];
+	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
+	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
+	pgprot_t pgprot = range->pgprot;
+	void *p;
 
-	return __execmem_alloc(range, size);
+	if (use_cache)
+		p = execmem_cache_alloc(range, size);
+	else
+		p = execmem_vmalloc(range, size, pgprot, vm_flags);
+
+	return kasan_reset_tag(p);
 }
 
 void execmem_free(void *ptr)
@@ -67,7 +363,9 @@ void execmem_free(void *ptr)
 	 * supported by vmalloc.
 	 */
 	WARN_ON(in_interrupt());
-	vfree(ptr);
+
+	if (!execmem_cache_free(ptr))
+		vfree(ptr);
 }
 
 void *execmem_update_copy(void *dst, const void *src, size_t size)
@@ -89,6 +387,17 @@ static bool execmem_validate(struct execmem_info *info)
 		return false;
 	}
 
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX)) {
+		for (int i = EXECMEM_DEFAULT; i < EXECMEM_TYPE_MAX; i++) {
+			r = &info->ranges[i];
+
+			if (r->flags & EXECMEM_ROX_CACHE) {
+				pr_warn_once("ROX cache is not supported\n");
+				r->flags &= ~EXECMEM_ROX_CACHE;
+			}
+		}
+	}
+
 	return true;
 }
 
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



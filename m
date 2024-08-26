Return-Path: <linux-arch+bounces-6594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D995E9B7
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 08:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B0A1F21957
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2024 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911113B792;
	Mon, 26 Aug 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6ZyVdwI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2F12C475;
	Mon, 26 Aug 2024 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655461; cv=none; b=gH0Jjqu93H3Qptp8moQwxaNxFfsKqgoG34ZpppiTxG80exdbb+fRWPu1rcKkhhKOEXzIu1p8AZm88l6wn3wXCiB3cD4+nl7Ea7RyoFrQs9ldq95vPy+uRExC0qzWetD1NIC6MK0rQVe4tsPpmwUgEBSbYmuxIgv6l/SEpa/8o3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655461; c=relaxed/simple;
	bh=60YTzdSE6i7e5nDrzqtUhMVWFwXnvzse4OY0JvgSqFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqcBhpL/dTTndx6AQi05W3UqCIERmY9Mkg9cbUY0GjrGyVKBezhCWHDOvziaTvs53Myg7QtUV13dm9/fkBcSyvdQrFfBCCcVxcs6pmkeTCY8uRtl2JlWw5FsuG+MSlDCsO8wLi8XPCkXgNiYgyrqzo35CM5HX/fdxk3dyJlT7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6ZyVdwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B96C5819A;
	Mon, 26 Aug 2024 06:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724655461;
	bh=60YTzdSE6i7e5nDrzqtUhMVWFwXnvzse4OY0JvgSqFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6ZyVdwIdlrhEC6VjJZ0fgcKrogmO8tbfwBw/ARW3MBm8b5naeSJO870VG/7Zc0Sx
	 z8xklW4iH2BY/ocnk31e8T3HGA5Lsu6v0dGc0Ywxgq9qRiqq+kxoeFEvwBPzgm9W+l
	 +RpneR3sVLQRf1q36xGh2c0HbQzqJrF0JCM/67VWkE7sGVz0vcNqXhnPQDBIT8PnqX
	 /3N7DWwyo3yfbCRm7TkkewmQ9Fwxhe6ubFFpBEyncgzMZBymzlW/HYMseTjJnOBZIB
	 ev/JwfnKwLexycTlHfnkA8oyj80FTg22qkCIhfXBQnf/RAkVOhD58H/yq0ZDvFp5Cx
	 ao8cUX++cRVfQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
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
Subject: [PATCH v2 7/8] execmem: add support for cache of large ROX pages
Date: Mon, 26 Aug 2024 09:55:31 +0300
Message-ID: <20240826065532.2618273-8-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826065532.2618273-1-rppt@kernel.org>
References: <20240826065532.2618273-1-rppt@kernel.org>
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

Extend execmem_alloc() with an ability to use PMD_SIZE'ed pages with ROX
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
 mm/execmem.c            | 290 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 287 insertions(+), 5 deletions(-)

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
index 0f6691e9ffe6..3bde0863c50a 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -7,28 +7,88 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <linux/execmem.h>
+#include <linux/maple_tree.h>
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
+		if (!xa_is_value(area))
+			continue;
+
+		size = xa_to_value(area);
+
+		if (IS_ALIGNED(size, PMD_SIZE) &&
+		    IS_ALIGNED(mas.index, PMD_SIZE)) {
+			void *ptr = (void *)mas.index;
+
+			mas_erase(&mas);
+			vfree(ptr);
+		}
+	}
+	mutex_unlock(mutex);
+}
+
+static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
+
+static void execmem_fill_trapping_insns(void *ptr, size_t size, bool writable)
+{
+	if (execmem_info->fill_trapping_insns)
+		execmem_info->fill_trapping_insns(ptr, size, writable);
+	else
+		memset(ptr, 0, size);
+}
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
@@ -50,8 +110,226 @@ static void *__execmem_alloc(struct execmem_range *range, size_t size)
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
+	unsigned long lower, lower_size = 0;
+	unsigned long upper, upper_size = 0;
+	unsigned long area_size;
+	void *area = NULL;
+	int err;
+
+	lower = addr;
+	upper = addr + size - 1;
+
+	mutex_lock(mutex);
+	area = mas_walk(&mas);
+	if (area && xa_is_value(area) && mas.last == addr - 1) {
+		lower = mas.index;
+		lower_size = xa_to_value(area);
+	}
+
+	area = mas_next(&mas, ULONG_MAX);
+	if (area && xa_is_value(area) && mas.index == addr + size) {
+		upper = mas.last;
+		upper_size = xa_to_value(area);
+	}
+
+	mas_set_range(&mas, lower, upper);
+	area_size = lower_size + upper_size + size;
+	err = mas_store_gfp(&mas, xa_mk_value(area_size), GFP_KERNEL);
+	mutex_unlock(mutex);
+	if (err)
+		return -ENOMEM;
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
+		area_size = xa_to_value(area);
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
+	err = mas_store_gfp(&mas_busy, xa_mk_value(size), GFP_KERNEL);
+	if (err)
+		goto out_unlock;
+
+	mas_erase(&mas_free);
+	if (area_size > size) {
+		/*
+		 * re-insert remaining free size to free_areas at range
+		 * [addr + size, last]
+		 */
+		mas_set_range(&mas_free, addr + size, last);
+		size = area_size - size;
+		err = mas_store_gfp(&mas_free, xa_mk_value(size), GFP_KERNEL);
+		if (err) {
+			mas_erase(&mas_busy);
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
+	unsigned long vm_flags = VM_FLUSH_RESET_PERMS | VM_ALLOW_HUGE_VMAP;
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
+	vunmap_range_noflush(start, end);
+	flush_tlb_kernel_range(start, end);
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
+	size = xa_to_value(area);
+	mas_erase(&mas);
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
@@ -67,7 +345,9 @@ void execmem_free(void *ptr)
 	 * supported by vmalloc.
 	 */
 	WARN_ON(in_interrupt());
-	vfree(ptr);
+
+	if (!execmem_cache_free(ptr))
+		vfree(ptr);
 }
 
 void *execmem_update_copy(void *dst, const void *src, size_t size)
-- 
2.43.0



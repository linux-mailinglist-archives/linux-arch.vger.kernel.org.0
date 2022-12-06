Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0640E644861
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiLFPvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 10:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiLFPu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 10:50:59 -0500
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B925C7D;
        Tue,  6 Dec 2022 07:50:57 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 105C8670E6;
        Tue,  6 Dec 2022 15:41:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo09-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo09-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TSw9xhU7nGDB; Tue,  6 Dec 2022 15:41:50 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id 2FE4E670B7;
        Tue,  6 Dec 2022 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 958013EF06;
        Tue,  6 Dec 2022 08:41:48 -0700 (MST)
From:   Khalid Aziz <khalid@gonehiking.org>
To:     akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid@gonehiking.org>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, 21cnbao@gmail.com,
        arnd@arndb.de, ebiederm@xmission.com, elver@google.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 2/2] mm/ptshare: Create a new mm for shared pagetables and add basic page table sharing support
Date:   Tue,  6 Dec 2022 08:41:41 -0700
Message-Id: <9b2679745f94c6bac875abb61e5093d462626a1f.1670287696.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670287695.git.khalid.aziz@oracle.com>
References: <cover.1670287695.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a process mmaps a file with MAP_SHARED flag, it is possible
that any other processes mmaping the same file with MAP_SHARED
flag with same permissions could share the page table entries as
well instead of creating duplicate entries. This patch introduces a
new flag MAP_SHARED_PT which a process can use to hint that it can
share page atbes with other processes using the same mapping. It
creates a new mm struct to hold the shareable page table entries for
the newly mapped region.  This new mm is not associated with a task.
Its lifetime is until the last shared mapping is deleted.  It adds a
new pointer "ptshare_data" to struct address_space which points to
the data structure that will contain pointer to this newly created
mm.

Add support for creating a new set of shared page tables in a new
mm_struct upon mmap of an region that can potentially share page
tables. Add page fault handling for this now shared region. Modify
free_pgtables path to make sure page tables in the shared regions
are kept intact when a process using page table region exits and
there are other mappers for the shared region. Clean up mm_struct
holding shared page tables when the last process sharing the region
exits.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h                     |   1 +
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |  16 ++
 mm/memory.c                            |  52 ++++-
 mm/mmap.c                              |  87 ++++++++
 mm/ptshare.c                           | 262 +++++++++++++++++++++++++
 7 files changed, 418 insertions(+), 3 deletions(-)
 create mode 100644 mm/ptshare.c

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 59ae95ddb679..f940bf03303b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -441,6 +441,7 @@ struct address_space {
 	spinlock_t		private_lock;
 	struct list_head	private_list;
 	void			*private_data;
+	void			*ptshare_data;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..4d23456b5915 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,7 @@
 #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_SHARED_PT		0x200000	/* Shared page table mappings */
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..d9bb14fdf220 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -40,7 +40,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
+			   pgtable-generic.o rmap.o vmalloc.o ptshare.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/internal.h b/mm/internal.h
index 16083eca720e..22cae2ff97fa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -861,4 +861,20 @@ static inline bool vma_is_shared(const struct vm_area_struct *vma)
 	return vma->vm_flags & VM_SHARED_PT;
 }
 
+/*
+ * mm/ptshare.c
+ */
+struct mshare_data {
+	struct mm_struct *mm;
+	refcount_t refcnt;
+	unsigned long start;
+	unsigned long size;
+	unsigned long mode;
+};
+int ptshare_new_mm(struct file *file, struct vm_area_struct *vma);
+void ptshare_del_mm(struct vm_area_struct *vm);
+int ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma);
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vmap,
+				unsigned long *addrp, unsigned int flags);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 8a6d5c823f91..051c82e13627 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -416,15 +416,21 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
+		/*
+		 * If vma is sharing page tables through a host mm, do not
+		 * free page tables for it. Those page tables wil be freed
+		 * when host mm is released.
+		 */
 		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
-		} else {
+		} else if (!vma_is_shared(vma)) {
 			/*
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && !vma_is_shared(next)) {
 				vma = next;
 				next = mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
@@ -5189,6 +5195,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	bool shared = false;
+	struct mm_struct *orig_mm;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5198,6 +5206,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* do counter updates before entering really critical section. */
 	check_sync_rss_stat(current);
 
+	orig_mm = vma->vm_mm;
+	if (unlikely(vma_is_shared(vma))) {
+		ret = find_shared_vma(&vma, &address, flags);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
@@ -5219,6 +5237,36 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_exit_fault();
 
+	/*
+	 * Release the read lock on shared VMA's parent mm unless
+	 * __handle_mm_fault released the lock already.
+	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
+	 * it released mmap lock. If lock was released, that implies
+	 * the lock would have been released on task's original mm if
+	 * this were not a shared PTE vma. To keep lock state consistent,
+	 * make sure to release the lock on task's original mm
+	 */
+	if (shared) {
+		int release_mmlock = 1;
+
+		if (!(ret & VM_FAULT_RETRY)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
+			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		}
+
+		/*
+		 * Reset guest vma pointers that were set up in
+		 * find_shared_vma() to process this fault.
+		 */
+		vma->vm_mm = orig_mm;
+		if (release_mmlock)
+			mmap_read_unlock(orig_mm);
+	}
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mmap.c b/mm/mmap.c
index 74a84eb33b90..c1adb9d52f5d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1245,6 +1245,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	vm_flags_t vm_flags;
 	int pkey = 0;
+	int ptshare = 0;
 
 	validate_mm(mm);
 	*populate = 0;
@@ -1282,6 +1283,21 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/*
+	 * If MAP_SHARED_PT is set, MAP_SHARED or MAP_SHARED_VALIDATE must
+	 * be set as well
+	 */
+	if (flags & MAP_SHARED_PT) {
+#if VM_SHARED_PT
+		if (flags & (MAP_SHARED | MAP_SHARED_VALIDATE))
+			ptshare = 1;
+		else
+			return -EINVAL;
+#else
+		return -EINVAL;
+#endif
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
@@ -1414,6 +1430,60 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
 		*populate = len;
+
+#if VM_SHARED_PT
+	/*
+	 * Check if this mapping is a candidate for page table sharing
+	 * at PMD level. It is if following conditions hold:
+	 *	- It is not anonymous mapping
+	 *	- It is not hugetlbfs mapping (for now)
+	 *	- flags conatins MAP_SHARED or MAP_SHARED_VALIDATE and
+	 *	  MAP_SHARED_PT
+	 *	- Start address is aligned to PMD size
+	 *	- Mapping size is a multiple of PMD size
+	 */
+	if (ptshare && file && !is_file_hugepages(file)) {
+		struct vm_area_struct *vma;
+
+		vma = find_vma(mm, addr);
+		if (!((vma->vm_start | vma->vm_end) & (PMD_SIZE - 1))) {
+			struct mshare_data *info = file->f_mapping->ptshare_data;
+
+			/*
+			 * If this mapping has not been set up for page table
+			 * sharing yet, do so by creating a new mm to hold the
+			 * shared page tables for this mapping
+			 */
+			if (info == NULL) {
+				int ret;
+
+				ret = ptshare_new_mm(file, vma);
+				if (ret < 0)
+					return ret;
+				info = file->f_mapping->ptshare_data;
+				ret = ptshare_insert_vma(info->mm, vma);
+				if (ret < 0)
+					addr = ret;
+				else
+					vma->vm_flags |= VM_SHARED_PT;
+			} else {
+				/*
+				 * Page tables will be shared only if the
+				 * file is mapped in with the same permissions
+				 * across all mappers with same starting
+				 * address and size
+				 */
+				if (((prot & info->mode) == info->mode) &&
+					(addr == info->start) &&
+					(len == info->size)) {
+					vma->vm_flags |= VM_SHARED_PT;
+					refcount_inc(&info->refcnt);
+				}
+			}
+		}
+	}
+#endif
+
 	return addr;
 }
 
@@ -2491,6 +2561,21 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * Check if this vma uses shared page tables
+	 */
+	vma = find_vma_intersection(mm, start, end);
+	if (vma && unlikely(vma_is_shared(vma))) {
+		struct mshare_data *info = NULL;
+
+		if (vma->vm_file && vma->vm_file->f_mapping)
+			info = vma->vm_file->f_mapping->ptshare_data;
+		/* Don't allow partial munmaps */
+		if (info && ((start != info->start) || (len != info->size)))
+			return -EINVAL;
+		ptshare_del_mm(vma);
+	}
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2660,6 +2745,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			}
 		}
 
+		if (vm_flags & VM_SHARED_PT)
+			vma->vm_flags |= VM_SHARED_PT;
 		vm_flags = vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
diff --git a/mm/ptshare.c b/mm/ptshare.c
new file mode 100644
index 000000000000..97322f822233
--- /dev/null
+++ b/mm/ptshare.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Share page table entries when possible to reduce the amount of extra
+ * memory consumed by page tables
+ *
+ * Copyright (C) 2022 Oracle Corp. All rights reserved.
+ * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
+ *		Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <asm/pgalloc.h>
+#include "internal.h"
+
+/*
+ */
+static pmd_t
+*get_pmd(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		p4d = p4d_alloc(mm, pgd, addr);
+		if (!p4d)
+			return NULL;
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		pud = pud_alloc(mm, p4d, addr);
+		if (!pud)
+			return NULL;
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		pmd = pmd_alloc(mm, pud, addr);
+		if (!pmd)
+			return NULL;
+	}
+
+	return pmd;
+}
+
+/*
+ * Find the shared pmd entries in host mm struct and install them into
+ * guest page tables.
+ */
+static int
+ptshare_copy_pmd(struct mm_struct *host_mm, struct mm_struct *guest_mm,
+			struct vm_area_struct *vma, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *host_pmd;
+	spinlock_t *host_ptl, *guest_ptl;
+
+	pgd = pgd_offset(guest_mm, addr);
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		p4d = p4d_alloc(guest_mm, pgd, addr);
+		if (!p4d)
+			return 1;
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		host_pmd = get_pmd(host_mm, addr);
+		if (!host_pmd)
+			return 1;
+
+		get_page(virt_to_page(host_pmd));
+		host_ptl = pmd_lockptr(host_mm, host_pmd);
+		guest_ptl = pud_lockptr(guest_mm, pud);
+		spin_lock(host_ptl);
+		spin_lock(guest_ptl);
+		pud_populate(guest_mm, pud,
+			(pmd_t *)((unsigned long)host_pmd & PAGE_MASK));
+		put_page(virt_to_page(host_pmd));
+		spin_unlock(guest_ptl);
+		spin_unlock(host_ptl);
+	}
+
+	return 0;
+}
+
+/*
+ * Find the shared page tables in hosting mm struct and install those in
+ * the guest mm struct
+ */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp,
+			unsigned int flags)
+{
+	struct mshare_data *info;
+	struct mm_struct *host_mm;
+	struct vm_area_struct *host_vma, *guest_vma = *vmap;
+	unsigned long host_addr;
+	pmd_t *guest_pmd, *host_pmd;
+
+	if ((!guest_vma->vm_file) || (!guest_vma->vm_file->f_mapping))
+		return 0;
+	info = guest_vma->vm_file->f_mapping->ptshare_data;
+	if (!info) {
+		pr_warn("VM_SHARED_PT vma with NULL ptshare_data");
+		dump_stack_print_info(KERN_WARNING);
+		return 0;
+	}
+	host_mm = info->mm;
+
+	mmap_read_lock(host_mm);
+	host_addr = *addrp - guest_vma->vm_start + host_mm->mmap_base;
+	host_pmd = get_pmd(host_mm, host_addr);
+	guest_pmd = get_pmd(guest_vma->vm_mm, *addrp);
+	if (!pmd_same(*guest_pmd, *host_pmd)) {
+		set_pmd(guest_pmd, *host_pmd);
+		mmap_read_unlock(host_mm);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	host_vma = find_vma(host_mm, host_addr);
+	if (!host_vma)
+		return VM_FAULT_SIGSEGV;
+
+	/*
+	 * Point vm_mm for the faulting vma to the mm struct holding shared
+	 * page tables so the fault handling will happen in the right
+	 * shared context
+	 */
+	guest_vma->vm_mm = host_mm;
+
+	return 0;
+}
+
+/*
+ * Create a new mm struct that will hold the shared PTEs. Pointer to
+ * this new mm is stored in the data structure mshare_data which also
+ * includes a refcount for any current references to PTEs in this new
+ * mm. This refcount is used to determine when the mm struct for shared
+ * PTEs can be deleted.
+ */
+int
+ptshare_new_mm(struct file *file, struct vm_area_struct *vma)
+{
+	struct mm_struct *new_mm;
+	struct mshare_data *info = NULL;
+	int retval = 0;
+	unsigned long start = vma->vm_start;
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	new_mm = mm_alloc();
+	if (!new_mm) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	new_mm->mmap_base = start;
+	new_mm->task_size = len;
+	if (!new_mm->task_size)
+		new_mm->task_size--;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	info->mm = new_mm;
+	info->start = start;
+	info->size = len;
+	refcount_set(&info->refcnt, 1);
+	file->f_mapping->ptshare_data = info;
+
+	return retval;
+
+err_free:
+	if (new_mm)
+		mmput(new_mm);
+	kfree(info);
+	return retval;
+}
+
+/*
+ * insert vma into mm holding shared page tables
+ */
+int
+ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	struct vm_area_struct *new_vma;
+	int err = 0;
+
+	new_vma = vm_area_dup(vma);
+	if (!new_vma)
+		return -ENOMEM;
+
+	new_vma->vm_file = NULL;
+	/*
+	 * This new vma belongs to host mm, so clear the VM_SHARED_PT
+	 * flag on this so we know this is the host vma when we clean
+	 * up page tables. Do not use THP for page table shared regions
+	 */
+	new_vma->vm_flags &= ~(VM_SHARED | VM_SHARED_PT);
+	new_vma->vm_flags |= VM_NOHUGEPAGE;
+	new_vma->vm_mm = mm;
+
+	err = insert_vm_struct(mm, new_vma);
+	if (err)
+		return -ENOMEM;
+
+	/*
+	 * Copy the PMD entries from host mm to guest so they use the
+	 * same PTEs
+	 */
+	err = ptshare_copy_pmd(mm, vma->vm_mm, vma, vma->vm_start);
+
+	return err;
+}
+
+/*
+ * Free the mm struct created to hold shared PTEs and associated data
+ * structures
+ */
+static inline void
+free_ptshare_mm(struct mshare_data *info)
+{
+	mmput(info->mm);
+	kfree(info);
+}
+
+/*
+ * This function is called when a reference to the shared PTEs in mm
+ * struct is dropped. It updates refcount and checks to see if last
+ * reference to the mm struct holding shared PTEs has been dropped. If
+ * so, it cleans up the mm struct and associated data structures
+ */
+void
+ptshare_del_mm(struct vm_area_struct *vma)
+{
+	struct mshare_data *info;
+	struct file *file = vma->vm_file;
+
+	if (!file || (!file->f_mapping))
+		return;
+	info = file->f_mapping->ptshare_data;
+	WARN_ON(!info);
+	if (!info)
+		return;
+
+	if (refcount_dec_and_test(&info->refcnt)) {
+		free_ptshare_mm(info);
+		file->f_mapping->ptshare_data = NULL;
+	}
+}
-- 
2.34.1


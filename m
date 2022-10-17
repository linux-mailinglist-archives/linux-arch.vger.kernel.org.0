Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4FF6007C1
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJQHcQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJQHcP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 03:32:15 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA6203;
        Mon, 17 Oct 2022 00:32:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSK0-Ok_1665991930;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VSK0-Ok_1665991930)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 15:32:11 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, baolin.wang@linux.alibaba.com,
        jingshan@linux.alibaba.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: Introduce new MADV_NOMOVABLE behavior
Date:   Mon, 17 Oct 2022 15:32:01 +0800
Message-Id: <bc27af32b0418ed1138a1c3a41e46f54559025a5.1665991453.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When creating a virtual machine, we will use memfd_create() to get
a file descriptor which can be used to create share memory mappings
using the mmap function, meanwhile the mmap() will set the MAP_POPULATE
flag to allocate physical pages for the virtual machine.

When allocating physical pages for the guest, the host can fallback to
allocate some CMA pages for the guest when over half of the zone's free
memory is in the CMA area.

In guest os, when the application wants to do some data transaction with
DMA, our QEMU will call VFIO_IOMMU_MAP_DMA ioctl to do longterm-pin and
create IOMMU mappings for the DMA pages. However, when calling
VFIO_IOMMU_MAP_DMA ioctl to pin the physical pages, we found it will be
failed to longterm-pin sometimes.

After some invetigation, we found the pages used to do DMA mapping can
contain some CMA pages, and these CMA pages will cause a possible
failure of the longterm-pin, due to failed to migrate the CMA pages.
The reason of migration failure may be temporary reference count or
memory allocation failure. So that will cause the VFIO_IOMMU_MAP_DMA
ioctl returns error, which makes the application failed to start.

To fix this issue, this patch introduces a new madvise behavior, named
as MADV_NOMOVABLE, to avoid allocating CMA pages and movable pages if
the users want to do longterm-pin, which can remove the possible failure
of movable or CMA pages migration.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/mm.h                     | 6 ++++++
 include/uapi/asm-generic/mman-common.h | 2 ++
 mm/madvise.c                           | 6 ++++++
 mm/memory.c                            | 6 ++++++
 4 files changed, 20 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c63dfc804f1e..c9b2ab6e96fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -307,6 +307,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
 #define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
+#define VM_NOMOVABLE	0x100000000	/* Avoid movable pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
@@ -661,6 +662,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool vma_no_movable(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_NOMOVABLE;
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..d6e64eda28b6 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_NOMOVABLE	26		/* Avoid movable pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 2baa93ca2310..fc59d4f1f123 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1045,6 +1045,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
+	case MADV_NOMOVABLE:
+		new_flags |= VM_NOMOVABLE;
+		break;
 	case MADV_DODUMP:
 		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL)
 			return -EINVAL;
@@ -1150,6 +1153,7 @@ madvise_behavior_valid(int behavior)
 	case MADV_PAGEOUT:
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
+	case MADV_NOMOVABLE:
 #ifdef CONFIG_KSM
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
@@ -1360,6 +1364,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
  *		triggering read faults if required
  *  MADV_POPULATE_WRITE - populate (prefault) page tables writable by
  *		triggering write faults if required
+ *  MADV_NOMOVABLE - avoid movable pages allocation in the page fault path
+ *		due to longterm-pin required.
  *
  * return values:
  *  zero    - success
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..5b75be6ba659 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5189,6 +5189,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	unsigned long pf_flags;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5203,6 +5204,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 					    flags & FAULT_FLAG_REMOTE))
 		return VM_FAULT_SIGSEGV;
 
+	if (vma_no_movable(vma))
+		pf_flags = memalloc_pin_save();
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
 	 * space.  Kernel faults are handled more gracefully.
@@ -5231,6 +5234,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			mem_cgroup_oom_synchronize(false);
 	}
 
+	if (vma_no_movable(vma))
+		memalloc_pin_restore(pf_flags);
+
 	mm_account_fault(regs, address, flags, ret);
 
 	return ret;
-- 
2.27.0


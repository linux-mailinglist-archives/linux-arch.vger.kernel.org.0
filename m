Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D6213CCE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 17:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCPiP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 11:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCPiP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 11:38:15 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBCE21534;
        Fri,  3 Jul 2020 15:38:12 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v6 22/26] mm: Add arch hooks for saving/restoring tags
Date:   Fri,  3 Jul 2020 16:37:14 +0100
Message-Id: <20200703153718.16973-23-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703153718.16973-1-catalin.marinas@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Steven Price <steven.price@arm.com>

Arm's Memory Tagging Extension (MTE) adds some metadata (tags) to
every physical page, when swapping pages out to disk it is necessary to
save these tags, and later restore them when reading the pages back.

Add some hooks along with dummy implementations to enable the
arch code to handle this.

Three new hooks are added to the swap code:
 * arch_prepare_to_swap() and
 * arch_swap_invalidate_page() / arch_swap_invalidate_area().
One new hook is added to shmem:
 * arch_swap_restore()

Signed-off-by: Steven Price <steven.price@arm.com>
[catalin.marinas@arm.com: add unlock_page() on the error path]
[catalin.marinas@arm.com: dropped the _tags suffix]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---

Notes:
    v6:
    - Added comment on where the arch code should define the overriding
      macros (asm/pgtable.h).
    - Dropped _tags suffix from arch_swap_restore_tags().
    
    New in v4.

 include/linux/pgtable.h | 28 ++++++++++++++++++++++++++++
 mm/page_io.c            | 10 ++++++++++
 mm/shmem.c              |  6 ++++++
 mm/swapfile.c           |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 56c1e8eb7bb0..cbe775d3446f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -631,6 +631,34 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 }
 #endif
 
+/*
+ * Allow architectures to preserve additional metadata associated with
+ * swapped-out pages. The corresponding __HAVE_ARCH_SWAP_* macros and function
+ * prototypes must be defined in the arch-specific asm/pgtable.h file.
+ */
+#ifndef __HAVE_ARCH_PREPARE_TO_SWAP
+static inline int arch_prepare_to_swap(struct page *page)
+{
+	return 0;
+}
+#endif
+
+#ifndef __HAVE_ARCH_SWAP_INVALIDATE
+static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
+{
+}
+
+static inline void arch_swap_invalidate_area(int type)
+{
+}
+#endif
+
+#ifndef __HAVE_ARCH_SWAP_RESTORE
+static inline void arch_swap_restore(swp_entry_t entry, struct page *page)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PGD_OFFSET_GATE
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index e8726f3e3820..9f3835161002 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -252,6 +252,16 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		unlock_page(page);
 		goto out;
 	}
+	/*
+	 * Arch code may have to preserve more data than just the page
+	 * contents, e.g. memory tags.
+	 */
+	ret = arch_prepare_to_swap(page);
+	if (ret) {
+		set_page_dirty(page);
+		unlock_page(page);
+		goto out;
+	}
 	if (frontswap_store(page) == 0) {
 		set_page_writeback(page);
 		unlock_page(page);
diff --git a/mm/shmem.c b/mm/shmem.c
index dacee627dae6..66024b1884c1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1673,6 +1673,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	}
 	wait_on_page_writeback(page);
 
+	/*
+	 * Some architectures may have to restore extra metadata to the
+	 * physical page after reading from swap.
+	 */
+	arch_swap_restore(swap, page);
+
 	if (shmem_should_replace_page(page, gfp)) {
 		error = shmem_replace_page(&page, gfp, info, index);
 		if (error)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 987276c557d1..b7a3ed45e606 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -716,6 +716,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	else
 		swap_slot_free_notify = NULL;
 	while (offset <= end) {
+		arch_swap_invalidate_page(si->type, offset);
 		frontswap_invalidate_page(si->type, offset);
 		if (swap_slot_free_notify)
 			swap_slot_free_notify(si->bdev, offset);
@@ -2675,6 +2676,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	frontswap_map = frontswap_map_get(p);
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
+	arch_swap_invalidate_area(p->type);
 	frontswap_invalidate_area(p->type);
 	frontswap_map_set(p, NULL);
 	mutex_unlock(&swapon_mutex);

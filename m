Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0963F1D5743
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEORRC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:17:02 -0400
Received: from foss.arm.com ([217.140.110.172]:59560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgEORRC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:17:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ECFE1042;
        Fri, 15 May 2020 10:17:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEDA73F305;
        Fri, 15 May 2020 10:16:59 -0700 (PDT)
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
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 20/26] mm: Add arch hooks for saving/restoring tags
Date:   Fri, 15 May 2020 18:16:06 +0100
Message-Id: <20200515171612.1020-21-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
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
 * arch_swap_restore_tags()

Signed-off-by: Steven Price <steven.price@arm.com>
[catalin.marinas@arm.com: add unlock_page() on the error path]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/asm-generic/pgtable.h | 23 +++++++++++++++++++++++
 mm/page_io.c                  | 10 ++++++++++
 mm/shmem.c                    |  6 ++++++
 mm/swapfile.c                 |  2 ++
 4 files changed, 41 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 329b8c8ca703..306cee75b9ec 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -475,6 +475,29 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 }
 #endif
 
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
+#ifndef __HAVE_ARCH_SWAP_RESTORE_TAGS
+static inline void arch_swap_restore_tags(swp_entry_t entry, struct page *page)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PGD_OFFSET_GATE
 #define pgd_offset_gate(mm, addr)	pgd_offset(mm, addr)
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..dae85d56e45b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -253,6 +253,16 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
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
index 73754ed7af69..0e87925a7cb4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1658,6 +1658,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	}
 	wait_on_page_writeback(page);
 
+	/*
+	 * Some architectures may have to restore extra metadata to the
+	 * physical page after reading from swap.
+	 */
+	arch_swap_restore_tags(swap, page);
+
 	if (shmem_should_replace_page(page, gfp)) {
 		error = shmem_replace_page(&page, gfp, info, index);
 		if (error)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..b39c6520b0cf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -722,6 +722,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	else
 		swap_slot_free_notify = NULL;
 	while (offset <= end) {
+		arch_swap_invalidate_page(si->type, offset);
 		frontswap_invalidate_page(si->type, offset);
 		if (swap_slot_free_notify)
 			swap_slot_free_notify(si->bdev, offset);
@@ -2645,6 +2646,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	frontswap_map = frontswap_map_get(p);
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
+	arch_swap_invalidate_area(p->type);
 	frontswap_invalidate_area(p->type);
 	frontswap_map_set(p, NULL);
 	mutex_unlock(&swapon_mutex);

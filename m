Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2166F479C30
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 19:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhLRSxZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 13:53:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:47172 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhLRSxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=uzN42bUaxbLnOTcDR6+nuF+sJu4okjXA65RQ7hXKzsU=; b=wCG6lCPN3E9c
        6DrLs0H/O7VhPBp3E+/yhWxhVJg5l6+P5jyce1PWud6jjkchpfZalxv45YAdIo6BVDcx3MNrZTn2+
        SkGbv0/Pu5dKXyG3mkmfVibUzzS3OLtZ1FM1OapRA9trxbc/luln68gCvu4v/d3hvc69jqm5fd/Hc
        arOO4=;
Received: from [192.168.15.79] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1myepE-003qf7-5g; Sat, 18 Dec 2021 21:52:56 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, kernel@openvz.org
Subject: [PATCH/RFC v2 2/3] mm/swap: introduce free_pages_and_swap_cache_nolru()
Date:   Sat, 18 Dec 2021 21:52:05 +0300
Message-Id: <20211218185205.1744125-3-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
References: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a variant of free_pages_and_swap_cache() that does not call
lru_add_drain(), for better performance in case when the passed pages
are guaranteed to not be in LRU.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 include/linux/swap.h |  5 ++++-
 mm/swap_state.c      | 29 ++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..86a1b0a61889 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -460,6 +460,7 @@ extern void clear_shadow_from_swap_cache(int type, unsigned long begin,
 extern void free_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
+extern void free_pages_and_swap_cache_nolru(struct page **, int);
 extern struct page *lookup_swap_cache(swp_entry_t entry,
 				      struct vm_area_struct *vma,
 				      unsigned long addr);
@@ -565,7 +566,9 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 #define free_page_and_swap_cache(page) \
 	put_page(page)
 #define free_pages_and_swap_cache(pages, nr) \
-	release_pages((pages), (nr));
+	release_pages((pages), (nr))
+#define free_pages_and_swap_cache_nolru(pages, nr) \
+	release_pages((pages), (nr))
 
 static inline void free_swap_cache(struct page *page)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..a5d9fd258f0a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -307,17 +307,32 @@ void free_page_and_swap_cache(struct page *page)
 
 /*
  * Passed an array of pages, drop them all from swapcache and then release
- * them.  They are removed from the LRU and freed if this is their last use.
+ * them.  They are optionally removed from the LRU and freed if this is their
+ * last use.
  */
-void free_pages_and_swap_cache(struct page **pages, int nr)
+static void __free_pages_and_swap_cache(struct page **pages, int nr,
+		bool do_lru)
 {
-	struct page **pagep = pages;
 	int i;
 
-	lru_add_drain();
-	for (i = 0; i < nr; i++)
-		free_swap_cache(pagep[i]);
-	release_pages(pagep, nr);
+	if (do_lru)
+		lru_add_drain();
+	for (i = 0; i < nr; i++) {
+		if (!do_lru)
+			VM_WARN_ON_ONCE_PAGE(PageLRU(pages[i]), pages[i]);
+		free_swap_cache(pages[i]);
+	}
+	release_pages(pages, nr);
+}
+
+void free_pages_and_swap_cache(struct page **pages, int nr)
+{
+	__free_pages_and_swap_cache(pages, nr, true);
+}
+
+void free_pages_and_swap_cache_nolru(struct page **pages, int nr)
+{
+	__free_pages_and_swap_cache(pages, nr, false);
 }
 
 static inline bool swap_use_vma_readahead(void)
-- 
2.30.2


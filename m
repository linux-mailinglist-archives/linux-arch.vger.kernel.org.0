Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD5479C31
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhLRSxZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 13:53:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:47184 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhLRSxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=aWfwX2mHRNfF2FaXfh0qTop90dqeuVpNzzBMwly8DGk=; b=POa1Bqz3g34+
        Xspei19oNpJpkkUmIVuE7HvN7G2z7ZNK4sdG6NZtty/8K4x80FOitCOjAbd0DZy+eXTNjZ81t4wC9
        Qx2elpULmxsc4T5iRPfe6qPCKNSRMrigAQHoRRZUGgA2DMO/eNMvoYRWu0qia1h6V3NbmuwlsBCCW
        oILLE=;
Received: from [192.168.15.79] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1myepE-003qf7-Hf; Sat, 18 Dec 2021 21:52:56 +0300
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
Subject: [PATCH/RFC v2 3/3] tlb: mmu_gather: use batched table free if possible
Date:   Sat, 18 Dec 2021 21:52:06 +0300
Message-Id: <20211218185205.1744125-4-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
References: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In case when __tlb_remove_table() is implemented via
free_page_and_swap_cache(), use free_pages_and_swap_cache_nolru() for
batch table removal.

This enables use of single release_pages() call instead of a loop
calling put_page(). This shall have better performance, especially when
memcg accounting is enabled.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 mm/mmu_gather.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index eb2f30a92462..2e75d396bbad 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -98,15 +98,24 @@ static inline void __tlb_remove_table(void *table)
 {
 	free_page_and_swap_cache((struct page *)table);
 }
-#endif
 
-static void __tlb_remove_table_free(struct mmu_table_batch *batch)
+static inline void __tlb_remove_tables(void **tables, int nr)
+{
+	free_pages_and_swap_cache_nolru((struct page **)tables, nr);
+}
+#else
+static inline void __tlb_remove_tables(void **tables, int nr)
 {
 	int i;
 
-	for (i = 0; i < batch->nr; i++)
-		__tlb_remove_table(batch->tables[i]);
+	for (i = 0; i < nr; i++)
+		__tlb_remove_table(tables[i]);
+}
+#endif
 
+static void __tlb_remove_table_free(struct mmu_table_batch *batch)
+{
+	__tlb_remove_tables(batch->tables, batch->nr);
 	free_page((unsigned long)batch);
 }
 
-- 
2.30.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1C1D5736
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEORQl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:41 -0400
Received: from foss.arm.com ([217.140.110.172]:59430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgEORQl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 512231042;
        Fri, 15 May 2020 10:16:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9C103F305;
        Fri, 15 May 2020 10:16:38 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: [PATCH v4 09/26] arm64: mte: Tags-aware aware memcmp_pages() implementation
Date:   Fri, 15 May 2020 18:15:55 +0100
Message-Id: <20200515171612.1020-10-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the Memory Tagging Extension is enabled, two pages are identical
only if both their data and tags are identical.

Make the generic memcmp_pages() a __weak function and add an
arm64-specific implementation which returns non-zero if any of the two
pages contain valid MTE tags (PG_mte_tagged set). There isn't much
benefit in comparing the tags of two pages since these are normally used
for heap allocations and likely to differ anyway.

Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v4:
    - Remove page tag comparison. This is not very useful to detect
      identical pages as long as set_pte_at() can zero the tags on a page
      without copy-on-write if mapped with PROT_MTE. This can be improved
      if a real case appears but it's unlikely for heap pages to be
      identical across multiple processes.
    - Move the memcmp_pages() function to mte.c.

 arch/arm64/kernel/mte.c | 26 ++++++++++++++++++++++++++
 mm/util.c               |  2 +-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 65a2f8490d18..da2d70178a4b 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitops.h>
 #include <linux/mm.h>
+#include <linux/string.h>
 #include <linux/thread_info.h>
 
 #include <asm/cpufeature.h>
@@ -23,6 +24,31 @@ void mte_sync_tags(pte_t *ptep, pte_t pte)
 	mte_clear_page_tags(page_address(page), page_size(page));
 }
 
+int memcmp_pages(struct page *page1, struct page *page2)
+{
+	char *addr1, *addr2;
+	int ret;
+
+	addr1 = page_address(page1);
+	addr2 = page_address(page2);
+	ret = memcmp(addr1, addr2, PAGE_SIZE);
+
+	if (!system_supports_mte() || ret)
+		return ret;
+
+	/*
+	 * If the page content is identical but at least one of the pages is
+	 * tagged, return non-zero to avoid KSM merging. If only one of the
+	 * pages is tagged, set_pte_at() may zero or change the tags of the
+	 * other page via mte_sync_tags().
+	 */
+	if (test_bit(PG_mte_tagged, &page1->flags) ||
+	    test_bit(PG_mte_tagged, &page2->flags))
+		return addr1 != addr2;
+
+	return ret;
+}
+
 void flush_mte_state(void)
 {
 	if (!system_supports_mte())
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..662fb3da6d01 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -899,7 +899,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	return res;
 }
 
-int memcmp_pages(struct page *page1, struct page *page2)
+int __weak memcmp_pages(struct page *page1, struct page *page2)
 {
 	char *addr1, *addr2;
 	int ret;

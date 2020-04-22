Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62371B472D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Apr 2020 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgDVOZt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Apr 2020 10:25:49 -0400
Received: from foss.arm.com ([217.140.110.172]:50726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgDVOZs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 10:25:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 036B91042;
        Wed, 22 Apr 2020 07:25:48 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D26A3F68F;
        Wed, 22 Apr 2020 07:25:46 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4/4] arm64: mte: Save tags when hibernating
Date:   Wed, 22 Apr 2020 15:25:30 +0100
Message-Id: <20200422142530.32619-5-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422142530.32619-1-steven.price@arm.com>
References: <20200422142530.32619-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When hibernating the contents of all pages in the system are written to
disk, however the MTE tags are not visible to the generic hibernation
code. So just before the hibernation image is created copy the tags out
of the physical tag storage into standard memory so they will be
included in the hibernation image. After hibernation apply the tags back
into the physical tag storage.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/kernel/hibernate.c | 116 ++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 5b73e92c99e3..b89429778b5d 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -31,6 +31,7 @@
 #include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
+#include <asm/mte.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
@@ -277,6 +278,115 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 #define dcache_clean_range(start, end)	__flush_dcache_area(start, (end - start))
 
+#ifdef CONFIG_ARM64_MTE
+
+static DEFINE_XARRAY(mte_pages);
+
+static int save_tags(struct page *page, unsigned long pfn)
+{
+	void *tag_storage, *ret;
+
+	tag_storage = mte_allocate_tag_storage();
+	if (!tag_storage)
+		return -ENOMEM;
+
+	mte_save_page_tags(page_address(page), tag_storage);
+
+	ret = xa_store(&mte_pages, pfn, tag_storage, GFP_KERNEL);
+	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
+		mte_free_tag_storage(tag_storage);
+		return xa_err(ret);
+	} else if (WARN(ret, "swsusp: %s: Duplicate entry", __func__)) {
+		mte_free_tag_storage(ret);
+	}
+
+	return 0;
+}
+
+static void swsusp_mte_free_storage(void)
+{
+	XA_STATE(xa_state, &mte_pages, 0);
+	void *tags;
+
+	xa_lock(&mte_pages);
+	xas_for_each(&xa_state, tags, ULONG_MAX) {
+		mte_free_tag_storage(tags);
+	}
+	xa_unlock(&mte_pages);
+
+	xa_destroy(&mte_pages);
+}
+
+static int swsusp_mte_save_tags(void)
+{
+	struct zone *zone;
+	unsigned long pfn, max_zone_pfn;
+	int ret = 0;
+	int n = 0;
+
+	if (!system_supports_mte())
+		return 0;
+
+	for_each_populated_zone(zone) {
+		max_zone_pfn = zone_end_pfn(zone);
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
+			struct page *page = pfn_to_online_page(pfn);
+
+			if (!page)
+				continue;
+
+			if (!test_bit(PG_mte_tagged, &page->flags))
+				continue;
+
+			ret = save_tags(page, pfn);
+			n++;
+
+			if (ret) {
+				swsusp_mte_free_storage();
+				goto out;
+			}
+		}
+	}
+
+	pr_info("Saved %d MTE pages\n", n);
+
+out:
+	return ret;
+}
+
+static void swsusp_mte_restore_tags(void)
+{
+	XA_STATE(xa_state, &mte_pages, 0);
+	int n = 0;
+	void *tags;
+
+	xa_lock(&mte_pages);
+	xas_for_each(&xa_state, tags, ULONG_MAX) {
+		unsigned long pfn = xa_state.xa_index;
+		struct page *page = pfn_to_online_page(pfn);
+
+		mte_restore_page_tags(page_address(page), tags);
+
+		mte_free_tag_storage(tags);
+		n++;
+	}
+	xa_unlock(&mte_pages);
+
+	pr_info("Restored %d MTE pages\n", n);
+
+	xa_destroy(&mte_pages);
+}
+#else
+static int swsusp_mte_save_tags(void)
+{
+	return 0;
+}
+
+static void swsusp_mte_restore_tags(void)
+{
+}
+#endif
+
 int swsusp_arch_suspend(void)
 {
 	int ret = 0;
@@ -294,6 +404,10 @@ int swsusp_arch_suspend(void)
 		/* make the crash dump kernel image visible/saveable */
 		crash_prepare_suspend();
 
+		ret = swsusp_mte_save_tags();
+		if (ret)
+			return ret;
+
 		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
@@ -307,6 +421,8 @@ int swsusp_arch_suspend(void)
 			dcache_clean_range(__hyp_text_start, __hyp_text_end);
 		}
 
+		swsusp_mte_restore_tags();
+
 		/* make the crash dump kernel image protected again */
 		crash_post_resume();
 
-- 
2.20.1


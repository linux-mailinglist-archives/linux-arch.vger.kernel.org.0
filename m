Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9111D5735
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEORQj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:39 -0400
Received: from foss.arm.com ([217.140.110.172]:59418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgEORQj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 735701063;
        Fri, 15 May 2020 10:16:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D68D93F305;
        Fri, 15 May 2020 10:16:36 -0700 (PDT)
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
Subject: [PATCH v4 08/26] arm64: mte: Tags-aware copy_page() implementation
Date:   Fri, 15 May 2020 18:15:54 +0100
Message-Id: <20200515171612.1020-9-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When the Memory Tagging Extension is enabled, the tags need to be
preserved across page copy (e.g. for copy-on-write).

Introduce MTE-aware copy_page() which preserves the tags across page
copy.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v4:
    - Moved the tag copying to a separate function in mte.S and only called
      if the source page has the PG_mte_tagged flag set.

 arch/arm64/include/asm/mte.h |  4 ++++
 arch/arm64/lib/mte.S         | 19 +++++++++++++++++++
 arch/arm64/mm/copypage.c     | 14 ++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 4310a7ff10c0..c1a09499c678 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -19,6 +19,7 @@ void mte_clear_page_tags(void *addr, size_t size);
 #define PG_mte_tagged	PG_arch_2
 
 void mte_sync_tags(pte_t *ptep, pte_t pte);
+void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
 
 #else
@@ -29,6 +30,9 @@ void flush_mte_state(void);
 static inline void mte_sync_tags(pte_t *ptep, pte_t pte)
 {
 }
+static inline void mte_copy_page_tags(void *kto, const void *kfrom)
+{
+}
 static inline void flush_mte_state(void)
 {
 }
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 130fb7047e17..a531b52fa5ba 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
+#include <asm/page.h>
 
 	.arch	armv8.5-a+memtag
 
@@ -21,3 +22,21 @@ SYM_FUNC_START(mte_clear_page_tags)
 	cbnz	x1, 1b
 	ret
 SYM_FUNC_END(mte_clear_page_tags)
+
+/*
+ * Copy the tags from the source page to the destination one
+ *   x0 - address of the destination page
+ *   x1 - address of the source page
+ */
+SYM_FUNC_START(mte_copy_page_tags)
+	mov	x2, x0
+	mov	x3, x1
+	multitag_transfer_size x5, x6
+1:	ldgm	x4, [x3]
+	stgm	x4, [x2]
+	add	x2, x2, x5
+	add	x3, x3, x5
+	tst	x2, #(PAGE_SIZE - 1)
+	b.ne	1b
+2:
+SYM_FUNC_END(mte_copy_page_tags)
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 2ee7b73433a5..2560ddc479ac 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -6,16 +6,26 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
+#include <linux/bitops.h>
 #include <linux/mm.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
+#include <asm/mte.h>
 
 void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vaddr)
 {
-	struct page *page = virt_to_page(kto);
+	struct page *to_page = virt_to_page(kto);
+	struct page *from_page = virt_to_page(kfrom);
+
 	copy_page(kto, kfrom);
-	flush_dcache_page(page);
+	if (system_supports_mte() &&
+	    test_bit(PG_mte_tagged, &from_page->flags)) {
+		mte_copy_page_tags(kto, kfrom);
+		set_bit(PG_mte_tagged, &to_page->flags);
+	}
+	flush_dcache_page(to_page);
 }
 EXPORT_SYMBOL_GPL(__cpu_copy_user_page);
 

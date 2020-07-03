Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1104F213CC1
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCPhp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 11:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCPhp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 11:37:45 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53FA21534;
        Fri,  3 Jul 2020 15:37:42 +0000 (UTC)
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 09/26] arm64: mte: Tags-aware copy_{user_,}highpage() implementations
Date:   Fri,  3 Jul 2020 16:37:01 +0100
Message-Id: <20200703153718.16973-10-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703153718.16973-1-catalin.marinas@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

When the Memory Tagging Extension is enabled, the tags need to be
preserved across page copy (e.g. for copy-on-write, page migration).

Introduce MTE-aware copy_{user_,}highpage() functions to copy tags to
the destination if the source page has the PG_mte_tagged flag set.
copy_user_page() does not need to handle tag copying since, with this
patch, it is only called by the DAX code where there is no source page
structure (and no source tags).

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    v5:
    - Handle tags in copy_highpage() (previously only copy_user_highpage()).
    - Ignore tags in copy_user_page() since it is only called directly by
      the DAX code where there is no source page structure.
    - Fix missing ret in mte_copy_page_tags().
    
    v4:
    - Moved the tag copying to a separate function in mte.S and only called
      if the source page has the PG_mte_tagged flag set.

 arch/arm64/include/asm/mte.h  |  4 ++++
 arch/arm64/include/asm/page.h | 14 +++++++++++---
 arch/arm64/lib/mte.S          | 19 +++++++++++++++++++
 arch/arm64/mm/copypage.c      | 25 +++++++++++++++++++++----
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 1716b3d02489..b2577eee62c2 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -19,6 +19,7 @@ void mte_clear_page_tags(void *addr);
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
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index c01b52add377..11734ce29702 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -15,18 +15,26 @@
 #include <linux/personality.h> /* for READ_IMPLIES_EXEC */
 #include <asm/pgtable-types.h>
 
+struct page;
+struct vm_area_struct;
+
 extern void __cpu_clear_user_page(void *p, unsigned long user);
-extern void __cpu_copy_user_page(void *to, const void *from,
-				 unsigned long user);
 extern void copy_page(void *to, const void *from);
 extern void clear_page(void *to);
 
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma);
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
+
+void copy_highpage(struct page *to, struct page *from);
+#define __HAVE_ARCH_COPY_HIGHPAGE
+
 #define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
 	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 #define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, vaddr)
-#define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, vaddr)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 typedef struct page *pgtable_t;
 
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index a36705640086..3c3d0edbbca3 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -5,6 +5,7 @@
 #include <linux/linkage.h>
 
 #include <asm/assembler.h>
+#include <asm/page.h>
 #include <asm/sysreg.h>
 
 	.arch	armv8.5-a+memtag
@@ -32,3 +33,21 @@ SYM_FUNC_START(mte_clear_page_tags)
 	b.ne	1b
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
+	ret
+SYM_FUNC_END(mte_copy_page_tags)
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 2ee7b73433a5..4a2233fa674e 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -6,18 +6,35 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
+#include <linux/bitops.h>
 #include <linux/mm.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
+#include <asm/mte.h>
 
-void __cpu_copy_user_page(void *kto, const void *kfrom, unsigned long vaddr)
+void copy_highpage(struct page *to, struct page *from)
 {
-	struct page *page = virt_to_page(kto);
+	struct page *kto = page_address(to);
+	struct page *kfrom = page_address(from);
+
 	copy_page(kto, kfrom);
-	flush_dcache_page(page);
+
+	if (system_supports_mte() && test_bit(PG_mte_tagged, &from->flags)) {
+		set_bit(PG_mte_tagged, &to->flags);
+		mte_copy_page_tags(kto, kfrom);
+	}
+}
+EXPORT_SYMBOL(copy_highpage);
+
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	copy_highpage(to, from);
+	flush_dcache_page(to);
 }
-EXPORT_SYMBOL_GPL(__cpu_copy_user_page);
+EXPORT_SYMBOL_GPL(copy_user_highpage);
 
 void __cpu_clear_user_page(void *kaddr, unsigned long vaddr)
 {

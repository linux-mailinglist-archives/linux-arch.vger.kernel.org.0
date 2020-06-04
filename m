Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A81EDEB5
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jun 2020 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgFDHou (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Jun 2020 03:44:50 -0400
Received: from 8bytes.org ([81.169.241.247]:46146 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgFDHou (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jun 2020 03:44:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A93F826F; Thu,  4 Jun 2020 09:44:48 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     peterz@infradead.org, jroedel@suse.de,
        Andy Lutomirski <luto@kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: Fix pud_alloc_track()
Date:   Thu,  4 Jun 2020 09:44:46 +0200
Message-Id: <20200604074446.23944-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The pud_alloc_track() needs to do different checks based on whether
__ARCH_HAS_5LEVEL_HACK is defined, like it already does in
pud_alloc(). Otherwise it causes boot failures on PowerPC.

Provide the correct implementations for both possible settings of
__ARCH_HAS_5LEVEL_HACK to fix the boot problems.

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Fixes: d8626138009b ("mm: add functions to track page directory modifications")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/asm-generic/5level-fixup.h |  5 +++++
 include/linux/mm.h                 | 26 +++++++++++++-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index 58046ddc08d0..afbab31fbd7e 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -17,6 +17,11 @@
 	((unlikely(pgd_none(*(p4d))) && __pud_alloc(mm, p4d, address)) ? \
 		NULL : pud_offset(p4d, address))
 
+#define pud_alloc_track(mm, p4d, address, mask)					\
+	((unlikely(pgd_none(*(p4d))) &&						\
+	  (__pud_alloc(mm, p4d, address) || ({*(mask)|=PGTBL_P4D_MODIFIED;0;})))?	\
+	  NULL : pud_offset(p4d, address))
+
 #define p4d_alloc(mm, pgd, address)		(pgd)
 #define p4d_alloc_track(mm, pgd, address, mask)	(pgd)
 #define p4d_offset(pgd, start)			(pgd)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66e0977f970a..ad3b31c5bcc3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2088,35 +2088,35 @@ static inline pud_t *pud_alloc(struct mm_struct *mm, p4d_t *p4d,
 		NULL : pud_offset(p4d, address);
 }
 
-static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
+static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
 				     unsigned long address,
 				     pgtbl_mod_mask *mod_mask)
-
 {
-	if (unlikely(pgd_none(*pgd))) {
-		if (__p4d_alloc(mm, pgd, address))
+	if (unlikely(p4d_none(*p4d))) {
+		if (__pud_alloc(mm, p4d, address))
 			return NULL;
-		*mod_mask |= PGTBL_PGD_MODIFIED;
+		*mod_mask |= PGTBL_P4D_MODIFIED;
 	}
 
-	return p4d_offset(pgd, address);
+	return pud_offset(p4d, address);
 }
 
-#endif /* !__ARCH_HAS_5LEVEL_HACK */
-
-static inline pud_t *pud_alloc_track(struct mm_struct *mm, p4d_t *p4d,
+static inline p4d_t *p4d_alloc_track(struct mm_struct *mm, pgd_t *pgd,
 				     unsigned long address,
 				     pgtbl_mod_mask *mod_mask)
+
 {
-	if (unlikely(p4d_none(*p4d))) {
-		if (__pud_alloc(mm, p4d, address))
+	if (unlikely(pgd_none(*pgd))) {
+		if (__p4d_alloc(mm, pgd, address))
 			return NULL;
-		*mod_mask |= PGTBL_P4D_MODIFIED;
+		*mod_mask |= PGTBL_PGD_MODIFIED;
 	}
 
-	return pud_offset(p4d, address);
+	return p4d_offset(pgd, address);
 }
 
+#endif /* !__ARCH_HAS_5LEVEL_HACK */
+
 static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 {
 	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
-- 
2.26.2


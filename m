Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3C6BA6BE
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCOFP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818952748D;
        Tue, 14 Mar 2023 22:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RJm37s6exHMhL80A15n5dqXB4pKNus7yxXTpBOkgNUI=; b=CgXM4A7XHbUEAmUDTF22UPLVCd
        zvb+5FvXwSGpI2Q/Z66mghrtiyZmHXJIph19KRPz/fBfzE/+9CCB0Bmt+elDnjhZ1YDKbiVhfyd3c
        hHd/olfBHzkGv7CkRoS0Vyr5N43mJTWVKq1Ua7jzhPGE8cb1a8qDACgRemAqw2HCP7Y1BbC00UouK
        oZ5b5pVsjuyhG9FxOwaQOqDZ3hceid7bahSI+fqwNsM26XOCuKFQcm3DGZ0GpA0pBkwsxmwsYwIOH
        4FgZp/0MyQGgy6+/6Ma10Q/XbKrp8wIQ1qmoahbMNU/lEca8Nm5MawGg0fp5nL86jr4kr2FyClPHI
        GqqqmsoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTN-00DYD4-MQ; Wed, 15 Mar 2023 05:14:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 27/36] x86: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:35 +0000
Message-Id: <20230315051444.3229621-28-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add PFN_PTE_SHIFT and a noop update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/pgtable.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 1031025730d0..b237878061c4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -184,6 +184,8 @@ static inline int pte_special(pte_t pte)
 
 static inline u64 protnone_mask(u64 val);
 
+#define PFN_PTE_SHIFT	PAGE_SHIFT
+
 static inline unsigned long pte_pfn(pte_t pte)
 {
 	phys_addr_t pfn = pte_val(pte);
@@ -1019,13 +1021,6 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 	return res;
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
-{
-	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
-	set_pte(ptep, pte);
-}
-
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
@@ -1291,6 +1286,10 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
 {
 }
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, unsigned int nr)
+{
+}
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmd)
 {
-- 
2.39.2


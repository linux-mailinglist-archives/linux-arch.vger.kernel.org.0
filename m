Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6874DF9D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGJUpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGJUoQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5DE4D;
        Mon, 10 Jul 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sMQRt4vH1ObkP1bKXMUZ8zoM72SIlxiZjD55fkj3j0k=; b=n3OahCLrH5ynSGq4TtitzKFZCm
        tCz7WUYXNr5RD1i/rXpMMwliW4bONdC7+C/iFgM/tLwwAtd+drGtecPi8nyKP+4KpGdkBguM8BzBL
        qm4OC/hSWVz0SYJS3P3id1s7KFaaC/BcXTAHQVR6MJP3POJnWrGtle2JD+xi7BusE+ns41ORyEKVr
        F1fyClyXhHiAK6uepDxgQX68J0kwUgdcAvl4PT8gRA/6kG2RUQrpaj+XO96r5BPI3XrTI9t9sTWWz
        Z3wad0zjHfsvX1okoo2p+8FuF/jgzM9RVpF49eI4rQ7zbzJbLiurc6Sr6UEju5X1kggGqjnRewSWo
        7Hw+7bSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjU-00Euqd-Cy; Mon, 10 Jul 2023 20:43:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 28/38] x86: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:29 +0100
Message-Id: <20230710204339.3554919-29-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add PFN_PTE_SHIFT and a noop update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/pgtable.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c6242bc58a71..9818f13bfa09 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -185,6 +185,8 @@ static inline int pte_special(pte_t pte)
 
 static inline u64 protnone_mask(u64 val);
 
+#define PFN_PTE_SHIFT	PAGE_SHIFT
+
 static inline unsigned long pte_pfn(pte_t pte)
 {
 	phys_addr_t pfn = pte_val(pte);
@@ -1020,13 +1022,6 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
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
@@ -1292,6 +1287,11 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
 {
 }
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
+{
+}
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmd)
 {
-- 
2.39.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC58B6A617E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjB1Vi5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjB1ViF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5F735277;
        Tue, 28 Feb 2023 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fpcPwGn1cnZkifuBnwEfVFMB8mrQdavgisIkUPDNgF0=; b=NjCRe50+iJnOn2KOisgXMICdJ3
        i3f0pYaSzRdjUJTsp293YdZYI8IxMAOKNR+z7ak18vrhXU29OXtVq/6sl1smHAbHvQAWRAsJuaJO7
        HroZWUZSUw4hmaDi418EyQIjM4I2oPg2mtFYRimli3yyGf5PXj0e2xz6RsaTbj+jUDybB7J7W5GKo
        dCKhrpuyl764OzyK2702Y5Wjet1VVbzltlGR06KAtWjdP9L1uwbYUEQ3eoNlbZp75zltxKplP3zRq
        14sK6gTtCoOIuWPWxnAQmtUIAZJyEmbBaNtkCrRvpb265t+Q1nKN59c9ANqXTk+Bk8/IUKkO5+9dv
        ltuj7eeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fK-0018qN-9o; Tue, 28 Feb 2023 21:37:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 26/34] x86: Implement the new page table range API
Date:   Tue, 28 Feb 2023 21:37:29 +0000
Message-Id: <20230228213738.272178-27-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Convert set_pte_at() into set_ptes() and add a noop
update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/pgtable.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 84be3e07b112..f424371ea143 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1019,13 +1019,22 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 	return res;
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t pte)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
-	set_pte(ptep, pte);
+	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
+
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + PAGE_SIZE);
+	}
 }
 
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
@@ -1291,6 +1300,10 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
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
2.39.1


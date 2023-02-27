Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB2E6A48F6
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjB0R6e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjB0R6Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:58:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E8269E;
        Mon, 27 Feb 2023 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dtiP3hUvA6nDur052lXOuZXkJQbzfHLCDQRu6Y0/CbA=; b=XBOe25D8ILBHFTarSSJcSeNA9I
        1ho9edMN4WMOW+STKHU1Fjrea3rZodyLYFfxge7XDJMmfzMLJ5pCij5ce+T8U8wF/UdpEm7/Bz/qs
        9nM2/FbCHKKykm8iTTCuAlGyTgQE/GycxrAz4ODI7DXc3tJUA+rJSGPORBHP1Q1tDn6els/rAcXNu
        nyYSpLPPd/TdxuXWCWgvTme17TJDDIgRhLDaoyZ4+jc4P1FBu1uKCgWDbTmRzt9YGRbp3MINfC48D
        n14ezuCiX8fXSt33c5Q2tTPA1dQpdTi3Rtl9mrNc5frwFSRQaNc0nMoT7sy55aFkqJjuw/TB8oH1V
        MaBmNMxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhkw-000IYY-7M; Mon, 27 Feb 2023 17:57:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH v2 24/30] um: Implement the new page table range API
Date:   Mon, 27 Feb 2023 17:57:35 +0000
Message-Id: <20230227175741.71216-25-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
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

Add set_ptes() and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/pgtable.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d1618eb35..ca78c90ae74f 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -242,12 +242,20 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *pteptr, pte_t pteval)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	set_pte(pteptr, pteval);
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+	}
 }
 
+#define set_pte_at(mm, addr, ptep, pte)	set_ptes(mm, addr, ptep, pte, 1)
+
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
@@ -290,6 +298,7 @@ struct mm_struct;
 extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 
 #define update_mmu_cache(vma,address,ptep) do {} while (0)
+#define update_mmu_cache_range(vma, address, ptep, nr) do {} while (0)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
-- 
2.39.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718376BA6AF
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjCOFPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A260D2A6F9;
        Tue, 14 Mar 2023 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BhDHElA1+7XNNQUc53zmXL/VNEpjb/1kRYcXHjVwh6U=; b=L3nJEGj//+nPckdFL5A0mFETmy
        lr7XPYbTtAaH2vP0P5HP+wBtnDWlG5b7uYikWQ/fJi0a4Vt9b/xt8Sww93NIb2vKIimPE9Oy6GZdz
        mNvJFBOvv5hx4U2SLTqASBtB1VDHjrNZWSQ+UdnoaSfxl1n7daNmCihmbbled4/1UbvtRe3hhL2pE
        ++KLiRw8n0BqJ1AyiIcC/wm4+19G7IrigGstnEw8/D20hnfrAf+fialHk4Z3PtzZWdFJRgr9KzqBY
        JJ/8fbBrEaXLPR+F5jk9C2hUICZcfm6Hd9VNJs/p60YKGbDlvTMwSV0WS5LbQ7KG72LW5GboZTm3y
        scb/WSSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTN-00DYD1-Ht; Wed, 15 Mar 2023 05:14:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH v4 26/36] um: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:34 +0000
Message-Id: <20230315051444.3229621-27-willy@infradead.org>
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

Add PFN_PTE_SHIFT and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
 arch/um/include/asm/pgtable.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index a70d1618eb35..ea5f8122f128 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -242,11 +242,7 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *pteptr, pte_t pteval)
-{
-	set_pte(pteptr, pteval);
-}
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
@@ -290,6 +286,7 @@ struct mm_struct;
 extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 
 #define update_mmu_cache(vma,address,ptep) do {} while (0)
+#define update_mmu_cache_range(vma, address, ptep, nr) do {} while (0)
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
-- 
2.39.2


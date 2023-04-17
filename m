Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED886E5252
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDQUxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjDQUxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C05582;
        Mon, 17 Apr 2023 13:52:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id sj1-20020a17090b2d8100b00247bd1a66d4so1716469pjb.5;
        Mon, 17 Apr 2023 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764775; x=1684356775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rEN7TkKGGrS4Nr1e9+VSo1FDhdsaSEXyIULzlMdAE4=;
        b=EY4pAo5dPiMdURcOVQM/Apa82VCO0I/XR1aYYt5qSz76HGumyOhUfKwA9+Mr5OFHh6
         y4qX3lmzBRH5sE5hiL3G5H7+P1vU90VNiEuutpY92Aii8KdV81S7nJ0QBzccPQA4L2A1
         H0r+gFj2e0wYN/AG4aVILv2cjCWqAiomeMPXPkWjszJF01iQ5TmXH8Bsz45QUOgwxoQ4
         sHC8DrgU25+a1fsqdhglJSyR11j/cBOYD1x2MxJDA6rfBM+Ci8Y+wWCZicg642iTcaFB
         y1U70avkZLTukuwNbayq0JR0dDmctnOUY0ghxZuZ1egx4BqGjtzmW9DXZrJYTWGZ5wwv
         sRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764775; x=1684356775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rEN7TkKGGrS4Nr1e9+VSo1FDhdsaSEXyIULzlMdAE4=;
        b=Zs4n3immWWinWs6YVXUFCiY6Nov07aEmqO0tasIkN6Fs4fQ4ZiapspIpb01T4U8rO3
         zB9I2kjC9znDQd8EVi6/R/6HKaQHcsrKytAtWSAs3lfKXowPk2RTiSX+JzZiNO9FzYx8
         CL5o0C3KHZd1tBvNlXz/rzcGZ24FTzL80M4WTWgZEj/dEXCFeH5n6tLMFYKFEBHzrnAH
         OaSDZSggZkCxqEkzTCFh+bdsk6E4xrNo4Ck7HxSzlhAmYMuCcPvqdbLo9CdfMNNn+W+O
         3yGemWTVyO5ds0U9thZLPirN456nKIhSxkDuLk+KFxocuxClIez1dAGcbAyEhPslIq0M
         2DNA==
X-Gm-Message-State: AAQBX9dtg584RLQq+VUCQclpqCf60OBI5suxNPs7Gy8ZRTG/MLB6pipR
        W6z/v7AApKyIqbCfdOBK6D0=
X-Google-Smtp-Source: AKy350Yghynh+/JYw1Y4OeSQkY97RuGOXV9v1JZPlpoHn0H6WhBdjqt/CneUg+QzYmLvk18Z1w5zNw==
X-Received: by 2002:a05:6a20:394f:b0:ef:b02a:b35b with SMTP id r15-20020a056a20394f00b000efb02ab35bmr6833020pzg.0.1681764775054;
        Mon, 17 Apr 2023 13:52:55 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:54 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 07/33] mm: Convert ptlock_ptr() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:22 -0700
Message-Id: <20230417205048.15870-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/x86/xen/mmu_pv.c |  2 +-
 include/linux/mm.h    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index fdc91deece7e..a1c9f8dcbb5a 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -651,7 +651,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	spinlock_t *ptl = NULL;
 
 #if USE_SPLIT_PTE_PTLOCKS
-	ptl = ptlock_ptr(page);
+	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17dc6e37ea03..ed8dd0464841 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2789,9 +2789,9 @@ void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return page->ptl;
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
@@ -2807,15 +2807,15 @@ static inline void ptlock_free(struct page *page)
 {
 }
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &page->ptl;
+	return &ptdesc->ptl;
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_page(*pmd));
+	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
 static inline bool ptlock_init(struct page *page)
@@ -2830,7 +2830,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2900,7 +2900,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
+	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
-- 
2.39.2


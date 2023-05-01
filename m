Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A376F373E
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjEAT3p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjEAT3X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FA35A7;
        Mon,  1 May 2023 12:28:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso3333052b3a.3;
        Mon, 01 May 2023 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969325; x=1685561325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsNph+IH8G9kAdlfpPDvdsVRvR3y4GWwc24n4bCHoNE=;
        b=ORzYAt4fgaepA0jj/nxqG5QCQUnwh7Hd86B8NHpvgQ9XS5bxCw6FjAddYAhSWVBGhs
         RguloM+rsX2sX5k8L8jQmcK3uoCnItaXGukxO2sNFKQkHNbJapaDcmG0iMAuRZwI8f8t
         xe4tIz8OOyBZAi/AlwagFAtmsldgUDQdHIa2vdidJh9lpo3fAW1D+2jPZJhQXOxhvdZs
         c4hk+WfixJsxNAANDMRcuNKXIxHiA6rEY6QaL0IGeoKtL1JoS6dBJBARbulTJ6NVKxdj
         8lac9J2KQ3hHBoBfb7fQ//alN+wtsMCP7K7b5tVdh9EZXnnMD2pBGWAPXyEldDpkm7ax
         zAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969325; x=1685561325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsNph+IH8G9kAdlfpPDvdsVRvR3y4GWwc24n4bCHoNE=;
        b=gWSgnGobc0XThJlXPJkM8585jxg/rQbpk+J2Knul0QxabNWNm9/VR7U6+qgeoCQWfm
         MVgLuqJuo3fbHsX+4qATrYrjMVyyURfTESv5Tdn0gbStrtVAty7nje2JEPV4aIGnne0A
         k+QjbBmM0UXN/MGfPt5VfatOx1/VeYqj5n65khXLSAev0qeCWrWWEZVKT1jHxGmoV4qu
         /+hTAnurt5Q2eWjasqFrGa1Z3hoaTLdGfIEtYWHmYFyvWxGQ28THYOWDmlAuheVfnZuW
         XWyH1m3mDTvxf+B6/wVnGaZl75SdJHdJ8j/5+QxRfIbujd/teaSWxm8CBbQ1GVQlRbVg
         RGUA==
X-Gm-Message-State: AC+VfDwi05cJ15RyZIyeLCXoiElf8ouoJlK2nPo/tjkfVrc2ISIt6emT
        EvulrYYBSp+UQDuNxhJ8zPE=
X-Google-Smtp-Source: ACHHUZ6Hyp/uTZNVOfbVle27YVii8Y9q7eyatfM6y5VDboeAGhZWSkyjhlYeOczpnOUzLbM+Y5y88w==
X-Received: by 2002:a17:902:da90:b0:1a9:b902:84b9 with SMTP id j16-20020a170902da9000b001a9b90284b9mr18090785plx.24.1682969325399;
        Mon, 01 May 2023 12:28:45 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:45 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 08/34] mm: Convert ptlock_ptr() to use ptdescs
Date:   Mon,  1 May 2023 12:28:03 -0700
Message-Id: <20230501192829.17086-9-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 565da5f39376..49fdc1199bd4 100644
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


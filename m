Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AB6E5308
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDQUyR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDQUx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4227A91;
        Mon, 17 Apr 2023 13:53:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p17so16171574pla.3;
        Mon, 17 Apr 2023 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764797; x=1684356797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=Bwk4ooUgupEoGCPug2H2Eo/HpnuuhxU7x81C/Qk6PZMSk1B54ZJ/T95wzfLs2bHmOL
         EoIfThp59UctKku6w1OEzm9Tx1+NGxZtvh5x5EZcL/GqxrGONyvWeZgGKJ7IB/ueJlyr
         3shywEfhQgNVSuay+LMKRYZJ2fcroNukWPhJ2nbiEAP2p1v1zQae9MOASciSz7iDNPe8
         PaaHFDAGtzWOJsB/jrA0V4yjZJzVFkj1D7lHE74htYvR1G0N63C9Bb92oSk5fpPTqJrg
         y20llT4kvkmAZ0rau94Yl1KLiffp2Awm3htmoO0PKOmikRHdd7NJITZhSry9QyqyhUwZ
         8Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764797; x=1684356797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pf7K/iFMD6od7/SRYpuPsYcodkkXMgOdjXv5YJvZldk=;
        b=fIM9vJXV4q2wA+fi1fhfk/WCr846AG6KQFVwVp0QJXJg8qN06tFZfql28Rbu6wkwwA
         iU4BFJTHNB0nh/Qhmshpmyz97NPPUUnaEyX4JoTnfB5stJ5zHd9Olu/5gENSXSPDL9G5
         Vyc2V4Hth2ASsR5DFOuDgfSPzuH/FFsHDlNkgh5Dg9qH8hSqbXiId0QzPHUGNyxRbZ9H
         z4oGq5gqV1hmJ8FHqYXwCR78Uc5ktX9+vogIBs4KZdb6Rv9bi71EdVIu4KsJ6YvAL5Ye
         mAA7pUhVtl3VjR435INVoo7EwyJvEH69K3KBQ6qkPPrNFse/kuvxqCbOP4yw9IvMgHZw
         4awA==
X-Gm-Message-State: AAQBX9eLkSeIlBl7cB2SQlQWCbZNN2FTw2COS87M5HtS5b3q7BnA8/tT
        OCAO9iWhEXPBQ3sgwghU0Do=
X-Google-Smtp-Source: AKy350YGLzUMfl8U7k4p6Sd9nO3FUwkbMa1TWeVYLUOOgANIZAClkJJEoJzR0+dt425gFfwmjH24tg==
X-Received: by 2002:a17:90a:ab12:b0:246:8b47:3d5b with SMTP id m18-20020a17090aab1200b002468b473d5bmr16661185pjq.18.1681764797279;
        Mon, 17 Apr 2023 13:53:17 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:17 -0700 (PDT)
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
Subject: [PATCH 23/33] loongarch: Convert various functions to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:38 -0700
Message-Id: <20230417205048.15870-24-vishal.moola@gmail.com>
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/loongarch/include/asm/pgalloc.h | 27 +++++++++++++++------------
 arch/loongarch/mm/pgtable.c          |  7 ++++---
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index af1d1e4a6965..1fe074f85b6b 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -45,9 +45,9 @@ extern void pagetable_init(void);
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -55,18 +55,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_page(GFP_KERNEL_ACCOUNT);
-	if (!pg)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, 0);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_page(pg);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -80,10 +80,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	pud = (pud_t *) __get_free_page(GFP_KERNEL);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = (pud_t *)ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 36a6dc0148ae..ff07b8f1ef30 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -11,10 +11,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
 
-	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *)ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.39.2


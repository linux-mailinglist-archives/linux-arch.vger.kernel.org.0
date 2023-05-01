Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1782C6F37CF
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjEATbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjEAT3q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91A72D67;
        Mon,  1 May 2023 12:29:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaef97652fso11574115ad.0;
        Mon, 01 May 2023 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969352; x=1685561352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=;
        b=bIC3wiMrkZ043YRG29tisEfS2j+UeOAsmyII3EDzrldtjEb8icghvzgUTYdQYM4doj
         vdu0JKDKQcL03t0/j67MJsK3EMdVvlx3Lc/9NrJJJYh+5KdPrYzRKBiHtTGqpBRhkA5a
         ZboUsEenHMS9VrUn3gKI66CrCL9Z8GCruZLIMyl89zj2oR4Tg7uJGI/BsPQUk9uXq4w7
         IEqVWzOt4YqC8i9AxlAbu1JP49n5XnekAOLER4FSWBBd0M0ka47bttpu+oGYYPDkowKQ
         ep35YwloCTCGYeII4Pobz7D0t4NcJCq50AMppyxrvfN/Wt0IBRqMUSxoDgh1JHSYp5Pm
         g50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969352; x=1685561352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyicI3UFSJTH3R33HGjLFGEyUDrTPXlIkqJCgIfzdrc=;
        b=F2U/+JY1qN/CDnxb1Rw57HirIarHPLj85x22Tqh+J5+8k3Ig+DMc1TyNvkzGM/Go+A
         cHQTP7rnbKRn7/tlDJ2nrpOJgr7i3SaGcjdNLYWeSoJ81atukVhT7Yob5TkWxW7c8MrE
         F3y8BSEQ/5r7mMa8m+mLq0NnmlpL0a2gojbWPVTDMTP5T000B/wNvODlqkksnFFKMNWo
         kSBiDAXiWj949mbk56bzIWyVVkiyB7QQntlvFNbSxOeqW3jfIOoMBDBYUSNwnAlb8OOZ
         49CjzMIPVFy9lk0U5zeHwZrFnODFVpBfhq4Dgchi6uMnfY+W5IJb9Ps2G5l3IQgpDi5p
         lFiw==
X-Gm-Message-State: AC+VfDy4Aqvf6tgGhz2UnAqs4QM3m7Yd0HfRlibkpEemo3D1NgCtCOD3
        CjaW28nUYcQAmjjEIZy8k6rYaVqQ4fZRyRj4
X-Google-Smtp-Source: ACHHUZ6JGwiASceIv2N+eQzagLfWHlR6lj5LsM9PIBmbvfqlnJYs1oK6NLyKl7E/zGC8k10AZHOifw==
X-Received: by 2002:a17:902:ea0b:b0:1a6:3b9c:7fea with SMTP id s11-20020a170902ea0b00b001a63b9c7feamr19311944plg.36.1682969351902;
        Mon, 01 May 2023 12:29:11 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:29:11 -0700 (PDT)
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
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v2 26/34] mips: Convert various functions to use ptdescs
Date:   Mon,  1 May 2023 12:28:21 -0700
Message-Id: <20230501192829.17086-27-vishal.moola@gmail.com>
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

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/mips/include/asm/pgalloc.h | 31 +++++++++++++++++--------------
 arch/mips/mm/pgtable.c          |  7 ++++---
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index f72e737dda21..7f7cc3140b27 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -51,13 +51,13 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
+	ptdesc_free(virt_to_ptdesc(pgd));
 }
 
-#define __pte_free_tlb(tlb,pte,address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	ptdesc_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -65,18 +65,18 @@ do {							\
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
-	struct page *pg;
+	struct ptdesc *ptdesc;
 
-	pg = alloc_pages(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
-	if (!pg)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_pages(pg, PMD_TABLE_ORDER);
+	if (!ptdesc_pmd_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = (pmd_t *)ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -90,10 +90,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, PUD_TABLE_ORDER);
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_TABLE_ORDER);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = (pud_t *)ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index b13314be5d0e..d626db9ac224 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -10,10 +10,11 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, PGD_TABLE_ORDER);
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
-	if (ret) {
+	if (ptdesc) {
+		ret = (pgd_t *) ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.39.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEC6773431
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHGXIf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjHGXHL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:07:11 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCFE2101;
        Mon,  7 Aug 2023 16:06:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d479d128596so3766473276.1;
        Mon, 07 Aug 2023 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449565; x=1692054365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCvcoKWLGx6gAjym9VWVFszZElqPM/KxU0nQCUs9lhU=;
        b=UEUmdRWyflXklFyhNX736vuEaqgiuaE747b2iDMdbsntaDVnz91uxqlH5BcdgyOH5x
         uvJaTvPkpQGN9akIqApZ8zKHvLZguej6njtjOnVMX/cM5jmsFezl/LYYVYVkbeho4b0z
         HHNTILzp+Xc4v6kzsuUo73oAPiN0CJazQDUAwcPLlet/lIEFQgMVrv8B24qA6Hz5wjkw
         b8w6Ifa5zhm6L11dsVrnJ9eA4XJTM6QxI5QWilhFcSjtgNKdoGywloLoSOAO6BZpBMSb
         8CiRrKjceUBw/RGFjWiyE5TzR9GZJ5T3ThAn9ujnfgeZbAfe+0n8PqgNKPCIQtpGYCsJ
         QRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449565; x=1692054365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCvcoKWLGx6gAjym9VWVFszZElqPM/KxU0nQCUs9lhU=;
        b=OfhBKV50UdItgef9y5J3YvMKYKZ8Y+Le7uuHKStez4Pj1Z0uc1q80lDEHvMDqZ4uW6
         mt56yy+RvAn0K/EFacvg0FgHjD5dV1cpLvMzcjojQczgZ5W15b6jeh0bTqrZ9DhRTDCi
         eT4KrNHe6PV5ljbIIa1QCVwLbPXuHCRboWskvCIqM4SkZZIJ3c5LpPbj+p4YPNR4/gLU
         Dl7GLbDZ4CAin0NZC13yTJmhi7eC1phs7YQwtEvWIJqcQ35cfQB5KJdYnLQnubalQvMh
         kOsiIMeuMXVVp9VzdLLAKAghXIBXZgeuwhA1PdZ0asQJT5aVwXVgwjLY96V4eiBWL3Eh
         2e6Q==
X-Gm-Message-State: AOJu0YypYNsPhGpQhcpsMnrOXjiUJuKNlyU4NFZfOVpxIvPl3zgmaYDL
        uujpZ+bvmffv+xZ2imj2YMA=
X-Google-Smtp-Source: AGHT+IEqzmUPQsWPkdBtUj3V9QXK122J73o4hp/g5UvHeQgKIN7qrVubtY48PFSpogl4MBW4UXPeVQ==
X-Received: by 2002:a25:944:0:b0:cb4:6167:a69c with SMTP id u4-20020a250944000000b00cb46167a69cmr9868214ybm.8.1691449565251;
        Mon, 07 Aug 2023 16:06:05 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:04 -0700 (PDT)
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
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 23/31] mips: Convert various functions to use ptdescs
Date:   Mon,  7 Aug 2023 16:05:05 -0700
Message-Id: <20230807230513.102486-24-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/mips/include/asm/pgalloc.h | 32 ++++++++++++++++++--------------
 arch/mips/mm/pgtable.c          |  8 +++++---
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index f72e737dda21..40e40a7eb94a 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -51,13 +51,13 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
+	pagetable_free(virt_to_ptdesc(pgd));
 }
 
-#define __pte_free_tlb(tlb,pte,address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
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
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
+	if (!ptdesc)
 		return NULL;
 
-	if (!pgtable_pmd_page_ctor(pg)) {
-		__free_pages(pg, PMD_TABLE_ORDER);
+	if (!pagetable_pmd_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
 
-	pmd = (pmd_t *)page_address(pg);
+	pmd = ptdesc_address(ptdesc);
 	pmd_init(pmd);
 	return pmd;
 }
@@ -90,10 +90,14 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM,
+			PUD_TABLE_ORDER);
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_TABLE_ORDER);
-	if (pud)
-		pud_init(pud);
+	if (!ptdesc)
+		return NULL;
+	pud = ptdesc_address(ptdesc);
+
+	pud_init(pud);
 	return pud;
 }
 
diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
index b13314be5d0e..1506e458040d 100644
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -10,10 +10,12 @@
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	pgd_t *ret, *init;
+	pgd_t *init, *ret = NULL;
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM,
+			PGD_TABLE_ORDER);
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
-	if (ret) {
+	if (ptdesc) {
+		ret = ptdesc_address(ptdesc);
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init(ret);
 		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
-- 
2.40.1


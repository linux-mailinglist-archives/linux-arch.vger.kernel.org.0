Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373416E52ED
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjDQUyC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjDQUx2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92B72BC;
        Mon, 17 Apr 2023 13:53:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i8so18359280plt.10;
        Mon, 17 Apr 2023 13:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764793; x=1684356793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJJ/5JNaAhhn0BtCWyESRHZW29NfaaBB7RT6Dtpfjog=;
        b=VrQ0lWqrs/ZeVvxhrMkEnri25zysQvP6rvUVlziuAvcyoO7aiCs2Ip8nrZdL+4djlt
         EalUxXukap5u9TcR0Ypqd1nj4oCE7Zy1crkVgOFcBvFvQfkcdrgLVV5yu4aZ8sXiNQzS
         MzbdyHaLybqiTpdHLCapkJdM135ufCzQfSX7LCwPasNWotwzcPJsMf59UKAQgZOOczBx
         ZYZuB1ddeu/80rtF2gv16gY+bwHM4NdL4pbXt10qFjUxYFen/hCDj/7OzFab+Hq/fc/w
         UWRA/d9TiIVFZRkxxpOQPugklzg3SfxU/z6fpq4Q2x5DyNF+cvnkXmPJMDWg2KdcBHj4
         X1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764793; x=1684356793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJJ/5JNaAhhn0BtCWyESRHZW29NfaaBB7RT6Dtpfjog=;
        b=L9DOkafzvfMyZgy/UT2lHa+SZidly+EZH319ZEZeF0JWSWyXmww7P+9xtKuKe3B+dO
         UiQDhGwPJqzjxBKCUG9CyzER/jpKf44owQ+sItGVJIjZ2FOmmulU8dBtMojRB14zEAuq
         BfZwG1miuuETvoVADHys2DivnhpfuOboqteO+rXNjSmBjcZRAw6x4xJ9AI3kmih7cz/3
         3m8zMzvUHEbyvVnkjE3alWE34kTb2HePHxnyerRLE2HwtMcxBvFdKzNFRNH32zOWUqFt
         iMN0+gBT1Pd57VoTUS+cr03Hp7klI1wgdLy6+wRqG2DlMNq3+HV9/QKS3QgRocQXzG5g
         31YA==
X-Gm-Message-State: AAQBX9c1j0y3OsL8qY28kThwt/i0iNIsi1EQxcqh2l6T6fHC6rv+PX4o
        SvvHVYkEHn8UNO9EWfOiLd8=
X-Google-Smtp-Source: AKy350Y2w7IaE9PrAymAnxztuomQd4Ga7koe4Zw+ByQfv97VTbICRP51vtaSBBH4u41LkAvC07UcrA==
X-Received: by 2002:a17:902:bd86:b0:1a6:c6d4:5586 with SMTP id q6-20020a170902bd8600b001a6c6d45586mr227041pls.13.1681764792942;
        Mon, 17 Apr 2023 13:53:12 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:12 -0700 (PDT)
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
Subject: [PATCH 20/33] arm64: Convert various functions to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:35 -0700
Message-Id: <20230417205048.15870-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/arm64/include/asm/tlb.h | 14 ++++++++------
 arch/arm64/mm/mmu.c          |  7 ++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f..6cb70c247e30 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -75,18 +75,20 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
-	tlb_remove_table(tlb, pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	ptdesc_pte_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	struct page *page = virt_to_page(pmdp);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pgtable_pmd_page_dtor(page);
-	tlb_remove_table(tlb, page);
+	ptdesc_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
 
@@ -94,7 +96,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pudp));
+	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pudp));
 }
 #endif
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index af6bc8403ee4..5ba005fd607e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -426,6 +426,7 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
 static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	phys_addr_t pa = __pgd_pgtable_alloc(shift);
+	struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
 
 	/*
 	 * Call proper page table ctor in case later we need to
@@ -433,12 +434,12 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 	 * this pre-allocated page table.
 	 *
 	 * We don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK if pmd is
-	 * folded, and if so pgtable_pmd_page_ctor() becomes nop.
+	 * folded, and if so ptdesc_pte_dtor() becomes nop.
 	 */
 	if (shift == PAGE_SHIFT)
-		BUG_ON(!pgtable_pte_page_ctor(phys_to_page(pa)));
+		BUG_ON(!ptdesc_pte_dtor(ptdesc));
 	else if (shift == PMD_SHIFT)
-		BUG_ON(!pgtable_pmd_page_ctor(phys_to_page(pa)));
+		BUG_ON(!ptdesc_pte_dtor(ptdesc));
 
 	return pa;
 }
-- 
2.39.2


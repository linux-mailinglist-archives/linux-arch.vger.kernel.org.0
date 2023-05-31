Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AA718C99
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjEaVdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEaVcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:32:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541810EB;
        Wed, 31 May 2023 14:32:04 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565bd368e19so798247b3.1;
        Wed, 31 May 2023 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568709; x=1688160709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llblHDjuRzdwObovgJjTe//ioNSPoyRpZegKgEWGdOs=;
        b=iH3Uuo4ydabF86Ae3Pt9mqJWCo9Mdl0v853LngJ++ms5qQhJIV2nJMOwvvj1jdSolp
         wkug3c5kE5OyC8B7qbo9EtOWW91dAFU5qbdW1jXEhkmIJBuTnUynbfXIOO6t9HnXXwkE
         IN/6ruRl/K/MZEBNhZ/CMDwD4Ey5RSIokBkrylG9gJyzM17uataBRfYABiymq5L1JBem
         AiofKm4cV+Hpu3+dW3nZQBqxHmZ0U8w75MqODX8zjymWwzwAB9aGsVd720nTIfH2C9wd
         s6EKfpFxPPWRO5hvsFIezwgeyXUB9GISVAQy5eO7rADF0ZyAn64v+X5gTI2GfoMJv3eF
         AD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568709; x=1688160709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llblHDjuRzdwObovgJjTe//ioNSPoyRpZegKgEWGdOs=;
        b=LjaJxVt5u+9itWOwFJ9RgmYgty0HxzRCjCcTVnV5DYIERG1kNbTddFzvFBMPCkHd4V
         f/6NjLW11f6dlIw0t54uT4XwckOcmJSudRbDzy3RV77a39eSPR/CzXb3kI5IajAQFdoJ
         Yd/ckGuwMtvtODdXfRmS/CbNHfGgXKNSd9uQCAdW7pN5b/Q0DyqPyTpxKyWn7PWbtBXb
         KQ6PeEVj9XI/o3OewDPbyxjrR7gbarGUYrPJ+QJowvR7aup5Mvxh3uF4sRVDpo7GYSRC
         6i++YgH0FRuOCJW2Px5mw4OGVL1qaC6+CiNTs1faBAdPMUu0l5WYOQnsr2I9pvKED3ri
         18eg==
X-Gm-Message-State: AC+VfDx6aT4uIfMtpoQtcL7lETTxIh6gqhmZUQy4CEdQGYTQl8Gx171i
        dvK8TB4lhu0D6w+On7T7iuQ=
X-Google-Smtp-Source: ACHHUZ6yD6O1sbMXJdkzsJg9s7w6GLhFX5Kt5hWPrM1g6MrxSM/fcoQvLUKDHg0FsgcJPRMkk3z8xg==
X-Received: by 2002:a0d:e647:0:b0:568:bca8:de50 with SMTP id p68-20020a0de647000000b00568bca8de50mr6918459ywe.17.1685568708928;
        Wed, 31 May 2023 14:31:48 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:48 -0700 (PDT)
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
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 20/34] arm: Convert various functions to use ptdescs
Date:   Wed, 31 May 2023 14:30:18 -0700
Message-Id: <20230531213032.25338-21-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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

late_alloc() also uses the __get_free_pages() helper function. Convert
this to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/arm/include/asm/tlb.h | 12 +++++++-----
 arch/arm/mm/mmu.c          |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..f40d06ad5d2a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	pgtable_pte_page_dtor(pte);
+	struct ptdesc *ptdesc = page_ptdesc(pte);
+
+	pagetable_pte_dtor(ptdesc);
 
 #ifndef CONFIG_ARM_LPAE
 	/*
@@ -50,17 +52,17 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
 #endif
 
-	tlb_remove_table(tlb, pte);
+	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
 static inline void
 __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 {
 #ifdef CONFIG_ARM_LPAE
-	struct page *page = virt_to_page(pmdp);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pgtable_pmd_page_dtor(page);
-	tlb_remove_table(tlb, page);
+	pagetable_pmd_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 22292cf3381c..294518fd0240 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
+	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
 
-	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
+	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
 		BUG();
-	return ptr;
+	return ptdesc;
 }
 
 static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.40.1


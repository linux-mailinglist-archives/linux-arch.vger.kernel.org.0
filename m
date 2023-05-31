Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA6718D00
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjEaVes (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaVeN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:34:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B84138;
        Wed, 31 May 2023 14:32:50 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565a6837a0bso733727b3.3;
        Wed, 31 May 2023 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568731; x=1688160731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GRmBDGAiDB5ohg5xpMsC/Ie0xVPC3qwwrjfZtpy6VU=;
        b=TzIQcYP8UmEvu1XoUXTmQnAashbo2T6eYaCRckVyeMmLMro7gHhzasHCkMcWFCcICP
         qASPopGO4jPsUUoq2oo54YJvtjYAvzC57SSS0Yqri4mv3NjvTdLMSdkLvvM7oA4Ee24y
         wtM1hRp99610fYgP6iNO/jZdKl6qkgz0kh/qsgBmVzQ/w0d6rCW5SOQFK0BhVT7CHUOG
         qPxfe0g3o4O3N6ywZpv0i38BDLHQS9YQOgCA2owyv5y3xv1tuRhfQmBHrNK0am7f5K2A
         BF7Ua5SoJjDL0sDtWpclX2w1tSSbohGXIW608mTIM4bjGCvoZIGoxKxNqCAe4MAT2CZW
         ovbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568731; x=1688160731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GRmBDGAiDB5ohg5xpMsC/Ie0xVPC3qwwrjfZtpy6VU=;
        b=e4QVgz1WK/H/FMkwzYqGwg6Bbdh4V7CAmKH0EVAFiNmtrtsW7mUFaGhtoX/fWz6M9I
         USDexTHntXkHzrDs88bO3BcCQksJFTAwrWTMj839X5+g5TaJj7ztBgtaI/uSyzJE6x/X
         dOfqdoKiRpl947XDHd4Nf1ZP0LW4pSjlFAN5UsAbWs0XACb4iwdp+/yxFgmohJ3VAeYe
         I5DCVI96kkxPOs2Azmh5Xy1kn3DokC3BBcePJ1GH/C0hUctAkBdBRlTup0E9by0CVY7e
         zoGikvAmEzSpwI/n22NyHixU9h8kbUAYsnEzHN31BUpYuABi6ci1Wa3gbMXn0TfzrKAc
         3taQ==
X-Gm-Message-State: AC+VfDzMLj9wqMMVmwSPOcWNVaaHN0sm595YsUoso3bWWkyqkibkxx7u
        TsDI8i4kAAKcjnIeOCgQU8s=
X-Google-Smtp-Source: ACHHUZ5LYpeqVXEBxKdhnKxPXFX2lgcS9ekTnfnLE12pRifhXXzQCAWJFiLd7o1EIw9HUUaJU74F+Q==
X-Received: by 2002:a0d:e24d:0:b0:561:949d:a7fd with SMTP id l74-20020a0de24d000000b00561949da7fdmr7343037ywe.45.1685568730646;
        Wed, 31 May 2023 14:32:10 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:32:10 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 31/34] sparc64: Convert various functions to use ptdescs
Date:   Wed, 31 May 2023 14:30:29 -0700
Message-Id: <20230531213032.25338-32-vishal.moola@gmail.com>
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..8a1618c3b435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!pagetable_pte_ctor(ptdesc)) {
+		pagetable_free(ptdesc);
 		return NULL;
 	}
-	return (pte_t *) page_address(page);
+	return (pte_t *) ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
 static void __pte_free(pgtable_t pte)
 {
-	struct page *page = virt_to_page(pte);
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
+	pagetable_pte_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.40.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568596E5346
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDQUzu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjDQUxy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7774286AE;
        Mon, 17 Apr 2023 13:53:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w11so27337726plp.13;
        Mon, 17 Apr 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764807; x=1684356807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=;
        b=fsz9HBXpyixYv0zGEIQNfLPb4EjMqtI/28pihon+vRduZpglxs4kGo7QlnsgzbeVep
         MUefXrtmBIPAEKph1/xE0Hixz+XFSj9eLb4OXqcCPGwVWZta2b+6OV8DcUNUc3MYWho8
         foQqBfLzT6QF4GBhL/zISw/ZQfIxqSnZu2sd2q6CE2U54ygVclXX08i47edCNHvoHxB+
         sBBNY+ovhIlsXyYoYKNVSm2boGQ3Di1szM5293gnTSGOnWYTxtAAUVimXGr6dZV0Zyrz
         TtkMrcCltGZOVK2SbO9vEj4TQWwRgKIU6/H0ozoMQVL6Kfmq0ZrnJgq0p7Ga0/De5Qi0
         sDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764807; x=1684356807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIsUNYOwSPNxjYFxvF4LgB4Ah8JH2T7Nmtlw8Cz+gsw=;
        b=WkEkdx8F4ryg6buFkGgLvnCO6coFzodqFxzQuQJRKc7Ml6PQb1t4b05aHh/zSj+oc+
         uLsZDPE9qC78OI8I/LLvU5yhc2GFs8eKz5gcTR1G7oFk0gWLbxLOxixoC5t2+mA2J5Gu
         Qkoib55p5K4qC6j/vfTbnoS0OHMB1Kg2UmSKVa3feAO+uUB6UGCZSpLHWMBdPKi3lkHK
         Z5dCLrYIlD1As2+AgYhkNwtdPnYURD6Pm8ht37HfxWU0s0mFs8Hv0TCrYQ0gy3TC7/4m
         MYQRZ2y6Y+6JgTYL6BWFnL/7SnANYxfJphF+MvzQHExvedvSVpObX00kvpRag7p2imn/
         qPkg==
X-Gm-Message-State: AAQBX9cO8PJN4/ch0zwkrluVO2QO8prxFT6onf1zriMMmDQ8l8C2ZP92
        K3BiF/2BHeNhPw7jxjnkoGM=
X-Google-Smtp-Source: AKy350YfnaT8KE6LOLQ9wRoeSIO99cnRXYKnv4nnzRXnI3u1QAONlMDFC8rrZFtHP4TZD3hWsCKEag==
X-Received: by 2002:a17:90a:fa3:b0:237:3dfb:9095 with SMTP id 32-20020a17090a0fa300b002373dfb9095mr16284735pjz.6.1681764806946;
        Mon, 17 Apr 2023 13:53:26 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:26 -0700 (PDT)
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
Subject: [PATCH 30/33] sparc64: Convert various functions to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:45 -0700
Message-Id: <20230417205048.15870-31-vishal.moola@gmail.com>
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

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 04f9db0c3111..eedb3e03b1fe 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+	if (!ptdesc)
 		return NULL;
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!ptdesc_pte_ctor(ptdesc)) {
+		ptdesc_free(ptdesc);
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
+	ptdesc_pte_dtor(ptdesc);
+	ptdesc_free(ptdesc);
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t pte)
-- 
2.39.2


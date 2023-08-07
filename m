Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4D1773429
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjHGXIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHGXHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:07:25 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26B1711;
        Mon,  7 Aug 2023 16:06:24 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a6f87b2993so3745146b6e.3;
        Mon, 07 Aug 2023 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449576; x=1692054376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BaWlDiv5V7gFuBlQl83W1x9C2ZQPjYd5FMjDEEKLfk=;
        b=cpy8Xcl19ScHIaEJohMfnXLz1DqejMUY8L9glfoRJKsJ7GTvGcuQsYlnxy1uVil+vX
         sKLd/jl5n7/nYQY+c94D1q52xLTeGbCjuaSsuOaGb/1E2rdiSHktCUTDo4f7HqbeV+dj
         TPAGwr0CoWyRhx6mzwQflnUob8s/y/rCKdVhSwURC5eFFFvRnN/tn2Qy2PbiuytULAR6
         gF0MKwRWTHX4EnLLnTfGRqqibjjUEq59j99BhXKpF7aj2wSWqBVgMsp2RTnzW+/7J2fC
         DAIl8+bDSwnR/XjlkNOvluV6Us9KQMDrngkUDG9ywXNDgTmwYNXsy+sDpdm8duXtW4+4
         Ov0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449576; x=1692054376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BaWlDiv5V7gFuBlQl83W1x9C2ZQPjYd5FMjDEEKLfk=;
        b=NhqZL1a5TND6TXDhQTHj7C6hOgLYl4aeQUNg/egDJnOUHPFo0KlQzy7WjjLw6s0v3U
         U7N57L8rg9bLgJ3DnPQPiKyHMBX8YUDVBlFcpXAygRd2P92E9lYmxnKazS1S8zMLwZyW
         lq25DlzDoDZ5pkx/+XqmmDGU1HffSEraI8JJDT4VYEOWCJuMiiYPLel7fcuWPuSM7Gdj
         adIBgw6mPfK6YjSU2axEoCDyOf1iZ0QvSNVILyy3+mwjzfv+ScKN6QRySX7C0SUHPrwI
         IbJm3Fo91M9OjO3CXEEIR+LZ78olQygvbS/8WoB3f/WhnBWO4hLH+aWL/u1hyakRJPfp
         cEHA==
X-Gm-Message-State: AOJu0Yzobh4+grrhbs1y9OBxU1mUjWe0sDIMzOLtLzgmWp1zxF4aWpgl
        Ce3F/twKpglx9dRGjmEWjCU=
X-Google-Smtp-Source: AGHT+IHyrg/p55954UWSWEFSK4VAgtzO3wGDAXzmBNoLynnb9Xv8FQKgcm7kods1XM481PofrT4NJA==
X-Received: by 2002:a05:6808:23d3:b0:3a3:e6eb:9c53 with SMTP id bq19-20020a05680823d300b003a3e6eb9c53mr13630414oib.23.1691449576353;
        Mon, 07 Aug 2023 16:06:16 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:16 -0700 (PDT)
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
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 28/31] sparc64: Convert various functions to use ptdescs
Date:   Mon,  7 Aug 2023 16:05:10 -0700
Message-Id: <20230807230513.102486-29-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents, convert various page table functions to use ptdescs.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/init_64.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 680ef206565c..f83017992eaa 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2907,14 +2907,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
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
+	return ptdesc_address(ptdesc);
 }
 
 void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
@@ -2924,10 +2925,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 
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


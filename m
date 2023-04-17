Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599AD6E5292
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjDQUxk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDQUxW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C0B3ABC;
        Mon, 17 Apr 2023 13:53:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso15384045pjb.3;
        Mon, 17 Apr 2023 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764781; x=1684356781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hc0m/U8RaSqOAaIvHe2pZ8la6AwQPtvql1ppirfWYYQ=;
        b=FTIIrhTe8vfWt4jgLQ0zryZ+NfsJ/OFhYpHyrwEJjHtN6fYrjayv1wmbuEiWrZWNBG
         Ab6oC0JEVFKaVtr5ERs/HGyia4m0cuJPp54Y6qKJvGxwoWwnKA3jL+mq6GAMCgFGvFWn
         bEbIp/iuCRzaSQasJ9iYfHsEIZ8C5L6UBjIsqJjVLRNCdj3wFA0VCJaoyvqsQShlPxAr
         nn14k2m42+J6xR2hfl2ffw8tFItkZsF+DKNsuBC18vZWoMB4mE4FcDOZiJ4pqP0DqYky
         PjLPxBMY5gAsTXZg/iGvnD4lxFGHfkuFymQLt7EWHTlIBpCDY+iSj33ZpMo6EFdNFztz
         HYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764781; x=1684356781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hc0m/U8RaSqOAaIvHe2pZ8la6AwQPtvql1ppirfWYYQ=;
        b=MTFMeBxFMlPbgAe5gYqCXZTaw1wzkjlqBV6krtmQ9Amzi1k62NjZeWlQqzKGUhGV55
         sg6x579oVVBiexyhtTL1fucKn3270FFTjbeUh9v/nSpEweiYdGkh0zaj1ak+ofrsyPYR
         u9nmQxWUPWGbuySfgrPb3PCWzQA+bMLEpyCWbekM7X+ZukbFqluRVt0anMJlXGHQqGDr
         RFY003M4l/m8r1CELKeGg8BVxD90UabnU6K3PnDB/APXWTTNnvNcwk9UPuT6hJc0vYB0
         yeW/ua7KjCyH2os7XZnq4qFp4zVezpAJoIAtyQJaUz4R7FLznevbRRBFwg/Cx7af3rFK
         weAg==
X-Gm-Message-State: AAQBX9eVh7ATQfmX06/mkym2Q0pU5doLxJkujUu3Ua7e8uwnTm85GZAH
        huOgKOf/lB/+3fcS99j3sMs=
X-Google-Smtp-Source: AKy350ZMofF2taT9lCtSfGwXj3mTLikp6R4dNTLL/p579XSegIqzslR/71TUEAWTkG6EWBZpLey91g==
X-Received: by 2002:a17:90a:d143:b0:23b:2c51:6e7 with SMTP id t3-20020a17090ad14300b0023b2c5106e7mr16554327pjw.21.1681764780697;
        Mon, 17 Apr 2023 13:53:00 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:00 -0700 (PDT)
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
Subject: [PATCH 11/33] mm: Convert ptlock_free() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:26 -0700
Message-Id: <20230417205048.15870-12-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2390fc2542aa..17a64cfd1430 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2787,7 +2787,7 @@ static inline void ptdesc_clear(void *x)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2803,7 +2803,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2844,7 +2844,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2858,7 +2858,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2916,7 +2916,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 37d408ac1b8d..ca74425c9405 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5937,8 +5937,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-void ptlock_free(struct page *page)
+void ptlock_free(struct ptdesc *ptdesc)
 {
-	kmem_cache_free(page_ptl_cachep, page->ptl);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
-- 
2.39.2


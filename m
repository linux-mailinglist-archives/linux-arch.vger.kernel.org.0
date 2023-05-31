Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29699718C5F
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjEaVcr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjEaVcB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:32:01 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF59E51;
        Wed, 31 May 2023 14:31:33 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-565eb83efe4so949597b3.0;
        Wed, 31 May 2023 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568693; x=1688160693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JALdXD/M7jBu0Q8jfR4m4Tx9IinYQtlxZ5YXkrMJ3RM=;
        b=SDECzrupkY8P71D5Bx9Ena6q3wieNwuGBpSv8ettDWf4PjEIxkW1kzC+/sNtzTCciF
         08YPq8+A8ip8H8kzMs94GMf7GyNCyBFe+MQWmq4tDFaYpFFNOE6UTqgnOULDbhNW0X9R
         mptdXbgDm5NvfVfzaMpwLm1cS6nmZ7EARb4uqJGF+rFwJSp8Gd0Dc+nu6W5F2EiHrPlp
         wvBO17QGrS6gAkojPK4/lKp5/gxat5ehsK5W06KJyleVWDfyXvKL/KtB/UxjcTPMijxH
         kcvx1/i/I9fdgW5R6GrMiCaj6gwLScpZ5XR6LtwZa6L23gJoAxE1JEulvsNvUD9DStHW
         I/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568693; x=1688160693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JALdXD/M7jBu0Q8jfR4m4Tx9IinYQtlxZ5YXkrMJ3RM=;
        b=fu3SE6xc61Of0WIbPGDpDZZAKrwaYGZM2fbClvVvtKp6wJI33pFl98b0s5LMVAiY56
         LEeKJF5q1r5AW1KoroacmKniUNReQqNda8XKz1n2g3nQXuebOx7ew294gEKwYfnjrmbH
         OrkD5z+AJl/Ktozy2+1aXEZptjx9zD70Vz0l4rewoizqV13NUSZLtIem+B9nRSImOPbM
         r7prbO3dU6wP7d0LCttHnNNE245Nk/tiOfEiF5nC9f85FahGtY5vPef2LCVP+1n80a9K
         iaEwRRy7/hpUbrz9Ycz3d2S2KyDrc1g2F+ubRpHBYM31VusGk1Yz7jmQhUzXGrqmsPts
         sajA==
X-Gm-Message-State: AC+VfDw0lwCjTiMtNteU6xKpI+ngyegZlF1cS98r6cQ2q8BgsmMT0aJW
        rVOWWaLsBcxzsGT+79vXf2g=
X-Google-Smtp-Source: ACHHUZ7Dif7B1ZpmhmssBZICB8FP9/M3ln6TJpLdw+EDe49hetyZ/pJac8jXPpLostqsKq4KAza0XA==
X-Received: by 2002:a81:4ed2:0:b0:568:4ef1:ba63 with SMTP id c201-20020a814ed2000000b005684ef1ba63mr7706752ywb.14.1685568692854;
        Wed, 31 May 2023 14:31:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:32 -0700 (PDT)
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
Subject: [PATCH v3 12/34] mm: Convert ptlock_free() to use ptdescs
Date:   Wed, 31 May 2023 14:30:10 -0700
Message-Id: <20230531213032.25338-13-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ffc82355fea6..72725aa6c30d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2807,7 +2807,7 @@ static inline void pagetable_clear(void *x)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2823,7 +2823,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2864,7 +2864,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2878,7 +2878,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2936,7 +2936,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 8d37dd302f2f..df0251243dfa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5949,8 +5949,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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
2.40.1


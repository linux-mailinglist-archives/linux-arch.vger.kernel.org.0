Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0062772D215
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjFLVIv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbjFLVIC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A7295C;
        Mon, 12 Jun 2023 14:05:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bcde2b13fe2so878570276.3;
        Mon, 12 Jun 2023 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603910; x=1689195910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3tBY7hT3/idMeTvV/y5HT5RaeYwytDxSu3wHZHQdRM=;
        b=RjdfKdwo6GGvbEWocjhzyfrIG+s4yeNfDttrrqwnEGORQ/YPC7ZVmdyS10JF0LYqJm
         b6bU5xmGwzXI5ZQkTCKkSHLlY6xUp5TM7mFPqEQ9UqdLvwpNas5BJtZzv+iakqyWNnr7
         ZbUjNLXHM5JpGCASroX3mIknKspaiVxCKS4EWppAxztT7eGSIBBwCNu77Cy7Q7mvbAeg
         nTWfF3Iwgf3p1K6E3gymTY1cP1wx9AawPcYyp7n9Z4TFzq2NVk0pgr/BAa6wSZIWoNVz
         1+4z+b7cL83but8FZFxeoUPYZLJOz76q6IoC2hSwlZOG2NbQ38EQV2G66LjHRDN0bxiF
         BZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603910; x=1689195910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3tBY7hT3/idMeTvV/y5HT5RaeYwytDxSu3wHZHQdRM=;
        b=Qe4wsX4xPumpiTLCZeuAN5JBebiQflQRvbzL9lqUaEjBvFkyreP4Pe4SMdwXqPIF8G
         5VdNKofe2an67uYfxpu8HM/1rha1QvnTBX1rNPoVHA70quOu1j4PmuIRjPTgP1ftKAtw
         xNkibvo875SOeDuQQuVe2EX8IDKokSyo1V+kNxPw+Fjp1COnbO0NzBIg0w5qaivDs2eZ
         wKn5baSJZczhgdVX2OMpeQSLLANiwWl97ZNuVR4GZSL5rC2jlORssu5AKclmX4ydI0cc
         8S/mopLCJdIVSzGwA9zdXRw/RvAibY9q2n9MP6yTeR+HVhCw+WS7FVn1cwmVkCcoewvy
         BCmg==
X-Gm-Message-State: AC+VfDziTCkkUcMSfVBM+r8Qf0gjoFFTfQzxrpiDai7obGQ5U+Xs/kVs
        Tg0gWOPy/OF/qUARh5yJrBTvD8+FNKeFQQ==
X-Google-Smtp-Source: ACHHUZ7G4LX/rzVzMPXBxUvcWoM4NVaiAOMXANZTQdr/GK3rhr2fg9ZSIMvpPffGov7SQ8stbPFS3w==
X-Received: by 2002:a05:6902:2c7:b0:ba6:e17a:abc2 with SMTP id w7-20020a05690202c700b00ba6e17aabc2mr8959494ybh.63.1686603910188;
        Mon, 12 Jun 2023 14:05:10 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:09 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 12/34] mm: Convert ptlock_free() to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:01 -0700
Message-Id: <20230612210423.18611-13-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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
index 3b54bb4c9753..a1af7983e1bd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2826,7 +2826,7 @@ static inline void pagetable_clear(void *x)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2842,7 +2842,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2883,7 +2883,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2897,7 +2897,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2955,7 +2955,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index ba9579117686..d4d2ea5cf0fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5945,8 +5945,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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


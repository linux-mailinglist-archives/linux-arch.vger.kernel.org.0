Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A26E5249
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDQUxV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDQUw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:52:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD649C3;
        Mon, 17 Apr 2023 13:52:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i8so18357571plt.10;
        Mon, 17 Apr 2023 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764771; x=1684356771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73w88W+Bv7iZwJaXp6X3OPD7H4X7IV5/5eDbDnIxbNE=;
        b=W9nPVyoXWKBUEnGfTyhkHARBTsZqdpJrkrNTKo667lyZEzjN6PxmFbbY0YylZMq9yl
         YfrdFmghyeO5HwXhYCrYBTje7eKqSW91jSFSDlT0dbMWvyCEN9ttpAXe7AFMT1oxAH0K
         BCnetbVzBpycS1Tax/m+o/Gfxhef/Kkj1D6sF8rcDiRlOa7VvGL8i+xK5Gl2/zoIf4yK
         M/9RMi7Hd+G3wH7cuJrpgQnusczVewZS29/AobewpqmBg09r8g/9YIIka/gTIbj6DHBc
         MFg7CjS5kCFyT6XG4/q3MJQ78bnC2QIXJhA82Tu9j9zbgdzbLpx3IE+L7G092ISLAdCE
         r0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764771; x=1684356771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73w88W+Bv7iZwJaXp6X3OPD7H4X7IV5/5eDbDnIxbNE=;
        b=Te6MV/AiBHKaEJ6l1TQKjBKaJJw8+yQG51jiY2PNRKJIuYncjv1wBbGpmY2oM361hT
         Ta21/3Vy0AfbY+ph97CuLc3sbD58wbXVrv7XKSJsqHmyddGayNrevUL5iAUZuujwQkiV
         Bjf4wBHHmuQBAQsd1nRqBEtMyEUUXPk1x5THKL2WnJO2WWcy8OE7E0ohEm6kjwjNRoMr
         d5+xTYrs9rYgO1guzfoxdZ+iVoMrW3J597TghPSE7/EVBBETaGGn9ywvjvtVF5Qposfe
         SKym/UqNMf7wJQu41dvQmOY5wFB6IoZMuxVbidMsxsZFpCiNrQQ4g/Ob3D5U6MzvLDbF
         kh8w==
X-Gm-Message-State: AAQBX9ehBYayugYIBdddB/WsXl47cxdu1ZpNZHHkNjp6LLc9FXebhouq
        +eNW/whHJrExr8AOByQNwYA=
X-Google-Smtp-Source: AKy350ZgO/j6WOIysdkqHxj8eua8dcgo+KDK2FD0csNlrjJfCGtmgVmsUk4Xos3l7Ag2y16revzrHg==
X-Received: by 2002:a17:902:8bc6:b0:1a2:8924:224a with SMTP id r6-20020a1709028bc600b001a28924224amr205356plo.25.1681764770838;
        Mon, 17 Apr 2023 13:52:50 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:50 -0700 (PDT)
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
Subject: [PATCH 04/33] mm: add utility functions for ptdesc
Date:   Mon, 17 Apr 2023 13:50:19 -0700
Message-Id: <20230417205048.15870-5-vishal.moola@gmail.com>
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

Introduce utility functions setting the foundation for ptdescs. These
will also assist in the splitting out of ptdesc from struct page.

ptdesc_alloc() is defined to allocate new ptdesc pages as compound
pages. This is to standardize ptdescs by allowing for one allocation
and one free function, in contrast to 2 allocation and 2 free functions.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/asm-generic/tlb.h | 11 ++++++++++
 include/linux/mm.h        | 44 +++++++++++++++++++++++++++++++++++++++
 include/linux/pgtable.h   | 13 ++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b46617207c93..6bade9e0e799 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -481,6 +481,17 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
+static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+{
+	tlb_remove_table(tlb, pt);
+}
+
+/* Like tlb_remove_ptdesc, but for page-like page directories. */
+static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
+{
+	tlb_remove_page(tlb, ptdesc_page(pt));
+}
+
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b18848ae7e22..ec3cbe2fa665 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2744,6 +2744,45 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
 }
 #endif /* CONFIG_MMU */
 
+static inline struct ptdesc *virt_to_ptdesc(const void *x)
+{
+	return page_ptdesc(virt_to_head_page(x));
+}
+
+static inline void *ptdesc_to_virt(struct ptdesc *pt)
+{
+	return page_to_virt(ptdesc_page(pt));
+}
+
+static inline void *ptdesc_address(struct ptdesc *pt)
+{
+	return folio_address(ptdesc_folio(pt));
+}
+
+static inline bool ptdesc_is_reserved(struct ptdesc *pt)
+{
+	return folio_test_reserved(ptdesc_folio(pt));
+}
+
+static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int order)
+{
+	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
+
+	return page_ptdesc(page);
+}
+
+static inline void ptdesc_free(struct ptdesc *pt)
+{
+	struct page *page = ptdesc_page(pt);
+
+	__free_pages(page, compound_order(page));
+}
+
+static inline void ptdesc_clear(void *x)
+{
+	clear_page(x);
+}
+
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
@@ -2970,6 +3009,11 @@ static inline void mark_page_reserved(struct page *page)
 	adjust_managed_page_count(page, -1);
 }
 
+static inline void free_reserved_ptdesc(struct ptdesc *pt)
+{
+	free_reserved_page(ptdesc_page(pt));
+}
+
 /*
  * Default method to free all the __init memory into the buddy system.
  * The freed pages will be poisoned with pattern "poison" if it's within
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 7cc6ea057ee9..7cd803aa38eb 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -97,6 +97,19 @@ TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
+#define ptdesc_page(pt)			(_Generic((pt),			\
+	const struct ptdesc *:		(const struct page *)(pt),	\
+	struct ptdesc *:		(struct page *)(pt)))
+
+#define ptdesc_folio(pt)		(_Generic((pt),			\
+	const struct ptdesc *:		(const struct folio *)(pt),	\
+	struct ptdesc *:		(struct folio *)(pt)))
+
+static inline struct ptdesc *page_ptdesc(struct page *page)
+{
+	return (struct ptdesc *)page;
+}
+
 /*
  * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
  *
-- 
2.39.2


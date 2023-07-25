Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D36760777
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 06:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGYEWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 00:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGYEVi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 00:21:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5271BC7;
        Mon, 24 Jul 2023 21:21:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-cb19b1b9a36so5683213276.0;
        Mon, 24 Jul 2023 21:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258881; x=1690863681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0E0BACLvXh2vpBt6imfUOZqEuzu1odD4oW+AaIJCus=;
        b=jYui+PKKLrYwW/9bkeBCxZuH30ZLFCfjk6k83i08YHGZs5qBvg098warmUkrhehPA7
         w4YGyti6UCNUragO2itKU02HUpV/ViBpQF9TFUZFW/NNv47MTUMBLJ+3J2/znigqsRJs
         QhHBOUaU/0pdlJBDEn1DtnKR6Jjb52zcMeUqfdcetzMdFupe+5WkVJfD4fN5fJJOsgL0
         e1lfCQXQItA0Ro7t73ofq2YB2adhnzcCWoT2HIbviNcoaPhOqdkOZB4a44aYijkjfd8z
         BHV0Z8ytCVZzLV7QMejslcSqJexW00RaRFmpSqinl2bowLcrU0F1887NS/OPVowYeO94
         sAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258881; x=1690863681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0E0BACLvXh2vpBt6imfUOZqEuzu1odD4oW+AaIJCus=;
        b=LzjdyKv/Xe7LLa0i/n0x8F/gGXLxmXEZlJGlY7tdsU5vLp7ww3ErIrY3Ug6A+Mv0kS
         lKinIDVONbTg1aXNMA9bgsCouPQK5g9F9g+Ojpjn7szMK4gv77KUAxtBsfMl9OjmyW4o
         SoiGk7KJ5AsirWsDyuyGkdSG07K01CBgY3rDRTNobdxPvpZsN2lY2gFVHcg29FB52HUI
         gncuG2QfabEDwruwAvi1ayyc08gloivznRxvoL1xFxdp5/JeJwZgYLT0JBI4fOR7CSf2
         i56Je5XJwWAtLKSbY76r4ojd88qGpo7ncmjhAJz9rB+fiYo4+EK6xFkZiIVe80SblJwg
         7nGQ==
X-Gm-Message-State: ABy/qLaKMiO5ii6kjq2X+LyrjuYYYpqfUj4FQoLhyHMHGqK9YMk2JYuc
        y4HfW/IY5BKWpMKAIDxvV3w=
X-Google-Smtp-Source: APBJJlGCGmZmbOTlDUcCFEi74mEzBDVKNi9w9+0D8ZZZqBiNJxZc6NQL85g34qQbwNZIlG7Tv+r/mA==
X-Received: by 2002:a25:356:0:b0:d0b:ed07:7f56 with SMTP id 83-20020a250356000000b00d0bed077f56mr5325321ybd.18.1690258881187;
        Mon, 24 Jul 2023 21:21:21 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:20 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 07/31] mm: Convert pmd_ptlock_init() to use ptdescs
Date:   Mon, 24 Jul 2023 21:20:27 -0700
Message-Id: <20230725042051.36691-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
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
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c155f82dd2cc..52ef09c100a2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2974,12 +2974,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
-static inline bool pmd_ptlock_init(struct page *page)
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(page);
+	return ptlock_init(ptdesc_page(ptdesc));
 }
 
 static inline void pmd_ptlock_free(struct page *page)
@@ -2999,7 +2999,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -3015,7 +3015,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


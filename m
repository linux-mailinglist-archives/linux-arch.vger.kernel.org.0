Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B87733A7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjHGXGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjHGXGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032510C0;
        Mon,  7 Aug 2023 16:05:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d16889b3e93so5396097276.0;
        Mon, 07 Aug 2023 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449534; x=1692054334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSt61pcnVgNBhKAHMe8eO3a6G9ChrNL9Px0NKJkznSI=;
        b=doFuHRFvbyMJN61tPnMQYXox+6stb50QdP4/3C93sFPuLhCWwxu1z+tfNZJ4b6Wpl+
         E3E2D7c/fVsu9NK1PuuCIKOAph+/dD0UwiupTdpLzihtqamhwaXNn1+eSFxg36XE1nAW
         9YCYbT+6Netay+dE7igP1FbsCv8QYjddLC3kVasHRyFjUe3vhlHJ5pPzAaFOmunT+EhT
         TypcY3libiW+1xTSZsvLq3CfCOXA2FWQUiU+MigDUHm3gt0TV6nV3mcKzhVGZgr0Qhni
         PeipZMs+ho2QZuOrtBA9RQFaTSU/S0o5wnK6eQ2hY8zhXlVshk/VfS/NqhE6JdbcRNTR
         jImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449534; x=1692054334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSt61pcnVgNBhKAHMe8eO3a6G9ChrNL9Px0NKJkznSI=;
        b=KjZBBStwiAcomgy/jGr5WB6aDhmzEtLWEK+Fcmv1Rdte96n/hoCFJIkcN0Dm8Sz1rV
         Df5GFAw06iocu4sxg484040jbVX69DcT3T0wKPwp+R3AQ1voWi8ALdl4Fu3EsgTGynpR
         m1RuqtSK2BMHkQQNq8TN24ABZeZ6iHjhUUoZKWCkWR8+vLyyMPXgOiqxDTASHKiV605y
         bM9T2JS3RWD/y03aa/FH17nMhx/O33FQOt60h7s6raeSDfWYaBQxy9RRUCV6wPDgA7op
         PPtJT+ULin6MZyxrPI9n9IN7Gn8plKN9B9KTKIds+x8hZh2wEo6FFLEtehohHnjLuctR
         tf1Q==
X-Gm-Message-State: AOJu0YwEXpRJMHhr+0uumCA8OLxg1LwF3qT4L2spb0+GDcq3WZticB9P
        +oKy4ZXkuqa/jxhZBMKp0uwa8p55Yy0oKg==
X-Google-Smtp-Source: AGHT+IH78clSYv8jjRwrTCz7hdEyV6ONxxFaBIBEI75jS+XpTOJin8WaSgmj5CyKgW8Moog6FuLvdA==
X-Received: by 2002:a25:4c86:0:b0:d0a:d15b:3b0f with SMTP id z128-20020a254c86000000b00d0ad15b3b0fmr10002278yba.33.1691449534448;
        Mon, 07 Aug 2023 16:05:34 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:34 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 08/31] mm: Convert ptlock_init() to use ptdescs
Date:   Mon,  7 Aug 2023 16:04:50 -0700
Message-Id: <20230807230513.102486-9-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 040982fe9063..13947b17f25e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2892,7 +2892,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2901,10 +2901,10 @@ static inline bool ptlock_init(struct page *page)
 	 * It can happen if arch try to use slab for page table allocation:
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page_ptdesc(page)))
+	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
+	if (!ptlock_alloc(ptdesc))
 		return false;
-	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
+	spin_lock_init(ptlock_ptr(ptdesc));
 	return true;
 }
 
@@ -2917,13 +2917,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
+static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
@@ -2998,7 +2998,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.40.1


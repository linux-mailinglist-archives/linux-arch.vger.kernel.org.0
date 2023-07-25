Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A8760753
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 06:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGYEVb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 00:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjGYEVT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 00:21:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111DBE71;
        Mon, 24 Jul 2023 21:21:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d124309864dso1372601276.3;
        Mon, 24 Jul 2023 21:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258877; x=1690863677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLtCJBysrabsGyMeKlbK2lKTjEzHhmjaMpElw0hOQuQ=;
        b=gPFq/JoYwJjLf9rVCoB8Lw8LOssqafkFQKm1MRAos7/YFfmCVQ5zZtnC0rhhBdQCXk
         N7cP2rb2Gc3I1sIFDEA6WDVqpFvuzV9g0ksMwxcFOLrW1SrVCbGbF2JEMKH7iGrlo6kh
         szCDqr3K9qHITaCMG+6I4Bv2DGuidVlNjZotb70C80Hqf3ER0SLHbbdax/uMFjYuJbcP
         w5E647QIdwTWza0fMIXSMCOI01eppzdj1zv2JddPFf9pPmBUxHnIhf/jhE5I9HeeHTOn
         pGU0qrcAaECYa9O8B/YJzvoVn8SSXjyAEPRTA5PEQfVza6O4EJzAJ9koweASwJRx6Tml
         xocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258877; x=1690863677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLtCJBysrabsGyMeKlbK2lKTjEzHhmjaMpElw0hOQuQ=;
        b=IBFmUbLEb1L1eZHk01iUkLjF3H4nXDClJMEI45rL+teaXmkpHR+iKSe7YyrdVau+Ao
         pSiM0h9QDh9tfw74cI9NxV5EYH65k0lc9IyOlUxD/aNSOvroleKqqC12j+LOInfNxCiP
         stvoeQj0XNE4JrZ295uPpzgzYTmxcoQWXMI7nEVEuhuUPtd/K0ww3IYlcBwyKWRU4HAX
         kAjKZf11J4eAPqWWFZFRapze7Wy01lZgMejMOWtQ3ZBJiOVrrdPfAbqBtj53M2+IfgQG
         vgCj5WQU+q+xWvzjoGZKY2z/yFT/5lUp4mqzundpxmXW6WP4LhdHWBJ28jyO9z6MOh2h
         zLVQ==
X-Gm-Message-State: ABy/qLbHYdSVqP9/LIfOgZueVMY40cCcXhh9BfjtCZe/AYgmvp8RChC7
        9c+XSOioFO1TcIwpFFVVido=
X-Google-Smtp-Source: APBJJlHyqmJ7X8HSspT6LddsJqdqN9Il/WFvcTF4BUwycttfbECYy8j8wA/EIsdExukzdWEa0jT4RQ==
X-Received: by 2002:a25:4cca:0:b0:d01:52da:9625 with SMTP id z193-20020a254cca000000b00d0152da9625mr7877273yba.13.1690258877265;
        Mon, 24 Jul 2023 21:21:17 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:16 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 05/31] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon, 24 Jul 2023 21:20:25 -0700
Message-Id: <20230725042051.36691-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf552a106e4a..b3fce0bfe201 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2841,7 +2841,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2853,7 +2853,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2883,7 +2883,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 2130bad76eb1..4fee273595e2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6231,14 +6231,14 @@ void __init ptlock_cache_init(void)
 			SLAB_PANIC, NULL);
 }
 
-bool ptlock_alloc(struct page *page)
+bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	spinlock_t *ptl;
 
 	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
 	if (!ptl)
 		return false;
-	page->ptl = ptl;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-- 
2.40.1


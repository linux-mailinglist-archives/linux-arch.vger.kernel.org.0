Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A8769DDD
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjGaREt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGaREO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 13:04:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B21BF4;
        Mon, 31 Jul 2023 10:03:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d35e565071aso479680276.2;
        Mon, 31 Jul 2023 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823028; x=1691427828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLtCJBysrabsGyMeKlbK2lKTjEzHhmjaMpElw0hOQuQ=;
        b=XxfUVCtc+QbMuKLsIQZYFotQjD1uPn39bJPNzHnLSpRxaT3fJeSLcUYSJwnJQ3Db/g
         leWI/21K6KvWZhIzEH7DHukGj5D7XdCtwzeO763ZUH4LeT7PuPE1GzPcQcYVnv/vf13j
         n79Pu8SKl7LjDKW1vidx9U3g5HX3hsbCLIInKKKoydsrph/bfVYnRh1jLyq8obFjpp4I
         8/fNfhvrK0O+QQmUluanQgTc5DFDNrxKYjhdFJW8WfDVLkfAQZABhu93QV+IfN33Z8yL
         iOGQEq8tdk7NtoCkxwkrl9w2lNi5iRHnhmaZ+oTac0bEezCH6FvgLddmkBsJ59So10Oj
         RPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823028; x=1691427828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLtCJBysrabsGyMeKlbK2lKTjEzHhmjaMpElw0hOQuQ=;
        b=bAJXXEwt7IeIzRe2ubW27yAyOduGAH+xqWwvXlZdqEAuG2PFlvT0PiCXrC3QHzvbQm
         VqL5qrvIUdw9S4OXk3uXXU4g2p4vpTUK+/LMV3pmltDLcFHAucBIJPwZwtiCXwMtZv0k
         YOEsuNHifShcS54ChkbZ1LW/SaO80TNPybsEalZ81SoVei2N/MlrpTBW/Q+vUXzVFBdg
         dNYEZfEoY1bwl+F1uaH4HCuYkhhBwXXEYm25FhThcLoEhroYXrUYmVQfPEI4jgE9bWNE
         /PLDKkVLKNeaiSL/Tyks6uivWdznNZrgbuIb7UvV5jtXB9U1Ic9nIb8BdRz3wdZXSzkg
         c4xQ==
X-Gm-Message-State: ABy/qLaAnAUYH2aPVNELuN+qDFA4yyUeml4+FsKUbRmXLb6VRvdqecyI
        xarRH8hoQI68XL/3ENmE2ZA=
X-Google-Smtp-Source: APBJJlGaLQRI5Q0HqdaC/SmgbvgNuoyQchTQtq0hJYQ2S7wch31RC4bpLlQZjYY1DDyT4+2cD/rUkg==
X-Received: by 2002:a25:9bc8:0:b0:c91:cc0e:1aef with SMTP id w8-20020a259bc8000000b00c91cc0e1aefmr8613166ybo.58.1690823027825;
        Mon, 31 Jul 2023 10:03:47 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id x31-20020a25ac9f000000b00c832ad2e2eesm2511833ybi.60.2023.07.31.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:03:47 -0700 (PDT)
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
Subject: [PATCH mm-unstable v8 05/31] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon, 31 Jul 2023 10:03:06 -0700
Message-Id: <20230731170332.69404-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
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


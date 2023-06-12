Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440F872D1A4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjFLVIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbjFLVHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:07:54 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCCF19A7;
        Mon, 12 Jun 2023 14:05:01 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-56d4f50427cso6510907b3.3;
        Mon, 12 Jun 2023 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603900; x=1689195900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csibueTQMI8hz/axFpDokmCUVKS4XWTLf0OEMRBu+sg=;
        b=FDAUnHm2faFSWGwfZS5hO+D9w8GP4e4g1ML7/tmHqNMsyYqyAD51ooe/UZAynheb45
         JUNAZVEGWiy3FM+aYWlvoHKaBUFoNzNTwUdIl4kQAVJN12Picp2GbnIh1UwydO/qddyi
         DCuNf5aNp8X4OTmdAm+cAeL3CGsOgaZ27ub95e/8MTqIlBQGK4N048waW9QZBpSO9XHI
         sWfFM9CmbvJbA3uGm5rS2JNk4GtvKzbhh98S182OZhG/f2sSkxT71cjOLs4vhjGq3bqf
         ArQftxucDa5+VY1eeLZl1/JDXSt6Px6z9h8EFmxArPTIN+H3XkndN1zswUa8dX9vrXU3
         5Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603900; x=1689195900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csibueTQMI8hz/axFpDokmCUVKS4XWTLf0OEMRBu+sg=;
        b=LiEySVJNcLE9qMiwIh52LiKd/n1Np5LA6mMtE3T3ixz4XgHQZI1EbfO7UD/6q/lhyu
         RutLjQ6/DC16rh9RAM6Nx7t/ciNllSUEWSZ7DMwgruPXFG1/kkqi75PQwLmm7xKVcLvY
         HLUwO425FZ2bVFp2doD7buYkTk42h/Vb21daf5LYqUwal/r1KR6MsR7sJJxgAMRAgk5N
         Chwp6ckOrJeRDZgn/Vv38/kSESKicF7Uf5H+u1Ny1gP1gH05GdeMgeEcgk410YQnSQTW
         6ci+8CbbwAl56p5xE5MNUTzcC9Q81YHELMZXcIaUPPqosvLYs014mqNch8in+lm7PJVZ
         hSRw==
X-Gm-Message-State: AC+VfDwU/VF/nFod2/LdSGfFRyfdOP3J4P/vCMRROjYdUNNOmB+6yiER
        X8M8mkRPkyHUFxV3PajhbyE=
X-Google-Smtp-Source: ACHHUZ7XKzfLRWmcjDH1kOSVD0e6fKxxbDH/DoQa8Wv3QDYuxgXM2gpDCQ5rMsZn09dpzldtR2HsSA==
X-Received: by 2002:a0d:e294:0:b0:56d:5041:78b with SMTP id l142-20020a0de294000000b0056d5041078bmr1552114ywe.2.1686603900209;
        Mon, 12 Jun 2023 14:05:00 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:04:59 -0700 (PDT)
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
Subject: [PATCH v4 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon, 12 Jun 2023 14:03:56 -0700
Message-Id: <20230612210423.18611-8-vishal.moola@gmail.com>
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
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 088b7664f897..e6f1be2a405e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2825,7 +2825,7 @@ static inline void pagetable_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2837,7 +2837,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2867,7 +2867,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 80ce9dda2779..ba9579117686 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5934,14 +5934,14 @@ void __init ptlock_cache_init(void)
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


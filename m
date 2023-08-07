Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9977338F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHGXGa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHGXGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E61BF0;
        Mon,  7 Aug 2023 16:05:49 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a3efebcc24so3748054b6e.1;
        Mon, 07 Aug 2023 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449528; x=1692054328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo55EeeiRtqMJzFppY7LfosEC+4EKSW+Y1wbH/R/zko=;
        b=Q3CUliICB5ucW5n1+cyfiOVvgvAwhYv3ZRrcZge/C2xN1y7mPAKTaAhnTC4tg457In
         GS5yV5pdx2fEbQ6Paw0G9gZpAwxLk7uLiA6v3+SIa2nM9cjP9BC4TMrWHjABBg1TkaAc
         jFqkxuJnd0T58a+3c4oi7Pn3k6jPqHaryISvoGLWFF1pysLGpyRN4pc1ANxWoEwI+30p
         K69XzaaIceuwI5auke9JvMGfHaTbti7Lrj0CNiE6K9RZ1Cm9I6s2gJdVHKhyUn9Bc8fw
         XFhL6ezBClgRYA33kHsXSFVngHlISmggGRScePESZQUU6OPVK5MugkAHJIXH8vtrGuLn
         AiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449528; x=1692054328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo55EeeiRtqMJzFppY7LfosEC+4EKSW+Y1wbH/R/zko=;
        b=kqaVRWqZw58CliANewfuxDdrWAHk4J9AzYQiCN1kN/PnwqSnckP30bgjdjnFR1eabK
         9Pdvx86ExIGRqQr3HRxAAbk+aC+/kfggYPNWc9yRCVWU+5SrzKc8HSJuJI7kOisqs1NW
         /YDrxa8GAiBZ2abHpTKddG07leUOY7GHY996g6f/SybNOzF7YeY8QUR0lPXQ9vlkzR2a
         XqK+AkpwNQSjDrTuNP5mTP5usCVMHthUrQYxLqK/MHUavZbHk5MkWAJepGSR7GUHebNn
         KsBBTcIx62Gvgj61rP7mNtsIWGzPvZG0p6c2wzmWDmm+GHjQ8marzqBBFx/glKZ2H+kn
         KrHw==
X-Gm-Message-State: AOJu0YyWX1S1OcIsBW9nidw+z1b4kVVYonwRjGcweIiMUEuvrhl6dRL0
        rGdZiFdB7StUGFedSQWSVf8=
X-Google-Smtp-Source: AGHT+IEuvpqTpP0gccwCdePAresyzfHn008a21Ty6dvsje55NxjSSMn6qMCPG3M+rc/X2+vc3Y/lYA==
X-Received: by 2002:a54:4886:0:b0:3a7:238a:143e with SMTP id r6-20020a544886000000b003a7238a143emr10421463oic.2.1691449528538;
        Mon, 07 Aug 2023 16:05:28 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:28 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 05/31] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon,  7 Aug 2023 16:04:47 -0700
Message-Id: <20230807230513.102486-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6d14a5fe747..6aea8fb671f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2860,7 +2860,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2872,7 +2872,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2902,7 +2902,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 956aad8aff34..3606ef72ba70 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6134,14 +6134,14 @@ void __init ptlock_cache_init(void)
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


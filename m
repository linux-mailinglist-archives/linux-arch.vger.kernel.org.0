Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF89718C2D
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjEaVbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjEaVbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:31:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA6188;
        Wed, 31 May 2023 14:31:24 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565c7399afaso813447b3.1;
        Wed, 31 May 2023 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568683; x=1688160683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27lyfpZ04FD2UDRY/I33l74zvzgaqoXO3tIGNjTPBPg=;
        b=ekb2h5vYZpG+cwgCVg4fQK7EHYCXZwnN3tICBhvbAXV/qaJ4duvuh8+ArMRtJnIp/1
         3RGo21yGJSysDJalslm0N3KJ+xBemufNmCM4QUS+AlLps3g1asXmgD446fAwgWFlRe+6
         a7aoyacEmBOwDL/dieiMjv/UIxc7tBtkwjPRg8HdgpDriWcSnd2JpyypDy8aN9IwIMR1
         dAM+p/G53wM0julinDJp886bQVRAOW6SvsbsPDW7Xp4BxlToFfeY++p5U7tcCmWgdlyl
         aRBYNbpeHC4ndh8fG8DxUBYpHsoQ7lFfl1tkv5LwqehXHAbOBlEVGGEVzchpWOIR1fN9
         uokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568683; x=1688160683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27lyfpZ04FD2UDRY/I33l74zvzgaqoXO3tIGNjTPBPg=;
        b=Jv3ZWUPy3GXfqdniEB1i2xJ/BZXTcnJG+ThP0uqdc+KAtXuR0sg9Mc4W561CZ5iTZ2
         KNEfHnygGwww5t8kQZArRg3Xoy1bhzZNGFuQ+51D+TdmlW0L5oyIEsX0RF6nsGwMggu3
         WdpquFm3/pNLz7iZ7yLkhYp4THvC1dNnlM0zKnF1HJRpzjY43gmoobD2bYrHjPIUn050
         4MF73uTivs48INL3Qq5lwHOSBuTcNuIgV5mAcYGznd9lpm+FUQaYq9EdgRGhC4UxvMou
         l9cNT6r4BspCYXvkdAeG0QcqftNVde6NdK+xRoC2kNLzyij/lkaXnplpCD2LyMMITskR
         VVzQ==
X-Gm-Message-State: AC+VfDwdyNQKHmLw1KN+PbWYwQfwIK+U8viSm5y85OZXGmIPTXoV+u5a
        qv81vb7P/oFJ4XdxQ/0OdPA=
X-Google-Smtp-Source: ACHHUZ6dr8MPeM7AL/jHaXXQ52piABkpCgdGqBTW+dyh+LgB10RRsXu3Y1HlJGFoY/78HDuWSu9FGg==
X-Received: by 2002:a0d:d741:0:b0:565:dff1:d1e2 with SMTP id z62-20020a0dd741000000b00565dff1d1e2mr7923571ywd.18.1685568683472;
        Wed, 31 May 2023 14:31:23 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:23 -0700 (PDT)
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
Subject: [PATCH v3 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date:   Wed, 31 May 2023 14:30:05 -0700
Message-Id: <20230531213032.25338-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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
---
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3a9c40e90dd7..1fd16ac96036 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2806,7 +2806,7 @@ static inline void pagetable_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2818,7 +2818,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2848,7 +2848,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index 8358f3b853f2..8d37dd302f2f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5938,14 +5938,14 @@ void __init ptlock_cache_init(void)
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


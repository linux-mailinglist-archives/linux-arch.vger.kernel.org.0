Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102596E524D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjDQUxW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDQUxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F501726;
        Mon, 17 Apr 2023 13:52:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id sj1-20020a17090b2d8100b00247bd1a66d4so1716379pjb.5;
        Mon, 17 Apr 2023 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764774; x=1684356774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seoMdP0S43tB5tHiAJsyEn/McuL6oTkl/wxfiJ8zej0=;
        b=m9/ZIcz+Tqctc8DsupfPgmRFjJ+xGEJ5QFcDJn618MR0YPogH6sfzkHf8JHJze9cJp
         x5NQYQBUB4f261Rif3c3u/e/lVyrkb7fkfJolfOwhFk6XOwO7D63t/TQQqs9S95k9Ae8
         FKQXzDTaphWXYOHY2MRQP+XNQ8wh3L+YHkBgztA18oGJHjweyg/A/nWWIx5QMqDpAEPB
         X0wu3GkIqgBlm9RuBmiAr6UEFrV7LCwD9Gy8HkrUbR2REAIxrVGyinkjPCtpi11n6vo5
         ARCTsKi2jOZHutSbPq4tlksgdP3OAZq4N0EqMo6MlYwn+u6KLBtMzuBeO5yqTZEreTX6
         9o+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764774; x=1684356774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seoMdP0S43tB5tHiAJsyEn/McuL6oTkl/wxfiJ8zej0=;
        b=UdTtPr/zNM6Bb4nxxF1QY8V8RGd28TaOblJq/Ex+oU99KSpSCOOQU+6xw5Zuj6XS/s
         mfgvytQ5mBLNvSOyD/oFdNJntGKX2E7uiLuuFTVagNKU33OvQmAsPiCGINkon9vY5f8K
         bnwczg2yDF5ldPZ4hflu2O3tG9EYqH/MBoruOjDBKGkhJsgRgHRQU2iFKG/MzEy7bPl/
         q78Zj9CQ4wGrJz1XG35HTtMLicqPRx5w87AKGTN8Q1my8FWec5OJy1yPVJJIu09O1TSd
         lLaZtt/EJx4tPTUvq/Q5UWgd5/Ujnm/Gxxs3hbG7mDupaUQgVpEyczKHm93jhZw2n2s4
         xWng==
X-Gm-Message-State: AAQBX9fcAIE+2QUwBT+ljJWxyx0xjsbpAswbrtvFACX6a1B8+HpbEPRm
        HTCIgIN3+Xu049lMTkTYGNo=
X-Google-Smtp-Source: AKy350aUejw0DeO6puoaXC3R5n6x3DzcxqacgAq+Qj51dxkW8glMsrCpGOXbLfdvjTORWF+TApg9qw==
X-Received: by 2002:a05:6a20:b21:b0:eb:8d47:332a with SMTP id x33-20020a056a200b2100b000eb8d47332amr14024065pzf.36.1681764773709;
        Mon, 17 Apr 2023 13:52:53 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:53 -0700 (PDT)
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
Subject: [PATCH 06/33] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:21 -0700
Message-Id: <20230417205048.15870-7-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 6 +++---
 mm/memory.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 069187e84e35..17dc6e37ea03 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2786,7 +2786,7 @@ static inline void ptdesc_clear(void *x)
 #if USE_SPLIT_PTE_PTLOCKS
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
-extern bool ptlock_alloc(struct page *page);
+bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
 static inline spinlock_t *ptlock_ptr(struct page *page)
@@ -2798,7 +2798,7 @@ static inline void ptlock_cache_init(void)
 {
 }
 
-static inline bool ptlock_alloc(struct page *page)
+static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 {
 	return true;
 }
@@ -2828,7 +2828,7 @@ static inline bool ptlock_init(struct page *page)
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page))
+	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
 	spin_lock_init(ptlock_ptr(page));
 	return true;
diff --git a/mm/memory.c b/mm/memory.c
index d4d7df041b6f..37d408ac1b8d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5926,14 +5926,14 @@ void __init ptlock_cache_init(void)
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
2.39.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C206F375F
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjEATaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjEAT3X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B8130D5;
        Mon,  1 May 2023 12:28:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf70676b6so9588195ad.3;
        Mon, 01 May 2023 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969324; x=1685561324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5AaOHEPf+h0pPpRdylr/G5bcmt7vW9RVYKqYfsRH1I=;
        b=roKi10VJs9dRiilqVeW0uT+zBJLQBRTUlVbgvCysCoLkLcBaFtSDJFWEbNs2bywIGo
         H3vsreWJ1ZpYCtBmz7ULTfsdWW+yedXBXQs/IwteaEsgFryEWzy4p352hRLq6aefxJE1
         6kRZZ9T8eU7cXFjWBj8Pc1GfIk6+0XR5y+mT0ED8uGwr4lyimQw2Z0aiiwvL0/TUCnLz
         1YAzhf+9hpLKk/t8M1Z7w1Ox1h7cTnYF1yo9NW5nVgHqgkVIivMOhZpN29c9g57SmIug
         sEztd2i0kQBJZgz4HOMkQSUf4qdi6lxWXkVGt+hsJgx7i60d4BQr0JdQ/AyxEv6LKtIb
         /zeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969324; x=1685561324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5AaOHEPf+h0pPpRdylr/G5bcmt7vW9RVYKqYfsRH1I=;
        b=N/MfAomu8m4l6i6IJYOz6TbmVEbuzGux3ZIr8w4f/KVFzI5D+KHddGoli+iXQxXqCk
         ranCgeigoa8NbbD6TspHp0+k+X7qrPYhFLqJPSnRpOjsphtJV6rRPCJ7q915wR9wIhDq
         TvkH96CFfbB5/FiO65yn6TZFyF41Dr+snC8AzeYybatjV7MEGnT7aRq3R1qi3l2p8qvd
         nydDCsoEvl4hDDj8UwdnBq5lc5okWFiYvyOcC5krUjz9fRAh+MXykgiQou34q3bKWtys
         VAhPikhOX//0O0M8DkCbvwv5zqjJqQ5dOjwStgihKiTvNAes+spU9pDzV4XD1CUV5pWT
         X11Q==
X-Gm-Message-State: AC+VfDzBM1rVB4au6H6gZ6pnAZZmJLBmhuDjqfOffDczOiwfLkvF6l+N
        00mvgjfmfaDRBxkSuGHEBFc=
X-Google-Smtp-Source: ACHHUZ4PPvDcr1ZSfGKsFuoX96n8X09PGID8nEMj55TFVd8R4rz9suoKbv6A+ENi8FZ5wQLN727S7w==
X-Received: by 2002:a17:902:ca0d:b0:1a6:5274:c1b0 with SMTP id w13-20020a170902ca0d00b001a65274c1b0mr12751445pld.60.1682969324101;
        Mon, 01 May 2023 12:28:44 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:43 -0700 (PDT)
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
Subject: [PATCH v2 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date:   Mon,  1 May 2023 12:28:02 -0700
Message-Id: <20230501192829.17086-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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
index 62c1635a9d44..565da5f39376 100644
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
index 5e2c6b1fc00e..ba0dd1b2d616 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5939,14 +5939,14 @@ void __init ptlock_cache_init(void)
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


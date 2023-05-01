Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45C6F375A
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjEATaQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbjEAT3X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1C2D7B;
        Mon,  1 May 2023 12:28:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a9253d4551so21236465ad.0;
        Mon, 01 May 2023 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969327; x=1685561327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr6GrFg3nf2tpOD8Orpodgx1J1bZoReYY/j4MOttH8M=;
        b=UIGt4Rxs2HkrsHutpAYaiWsjpykN6YUUd9E7lUyM0xl9pxC5slr+PivAMCf0kJWRtN
         +uixoPZwp4Vkl4YHEUToQjjzNjvIathQteky2ye14eE7NbHDFgUdPJKRNVXQAhEugOmA
         SnKo0+DWLOVbHHUZvAiFOaLnHaj2/1PYZhJmFGNiABpmjR+0nby25eJKrDAKj84VfLsp
         mCPKXur9uRrX02YRe2GBv91KFh4j6FQNTVZMtFBm8+b26dYihW/DQX+FZ7CAta9Gp4QP
         rZEIiymi83HRxeSWeuBi69l3Fo9OQWMSSxYcww0ZzqBAzl9SsUUSi153JEf/pt3dBwk3
         OFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969327; x=1685561327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr6GrFg3nf2tpOD8Orpodgx1J1bZoReYY/j4MOttH8M=;
        b=KSpDfKd+c/GWKf+a1QgwoqUydKfzNT/OQOQO8dQaOV7GUMzW1DfAhK0tB19Wi8hWKi
         aJSQWOetaXFf1PlMYazlOhW1iySxRI019GlRSin7qFKt+0bBpdSPTstLpQe76FGShYOx
         rl2nAqvcE8gSxsKrHby1/YqLcNRYM86TR2nWI6/nCoSkQpray0VxMpyk3y1XtzFavOS+
         L/3+POUraNY3RYv4/gmRYy7Hl4wFGKKFw1AtLBX8OJIbhAq+LQP8NAr/s00YuanV/zI6
         0Mtp1etovjUlNCA7oG8JojtzD3ri2o8Po6b58Ya7Lp5QVID6yOopjZjVJCrgEw8PM1Kc
         y6tA==
X-Gm-Message-State: AC+VfDyJaw0j7fT5Yo+EetMN9LreVSZvyo63UMqXwpGOCLczOJkvEVeI
        GoRPNRHUp3gg1/1w0AMA+KzoTCKJXzix+gGJ
X-Google-Smtp-Source: ACHHUZ7U6exPykPvKxCgekHmX9KTHTAx49eIcN0vG+aTw+3qX+uTyRXMYpekTZ9RZqGTjPxZ9ZewtA==
X-Received: by 2002:a17:902:ecca:b0:1a6:4127:857 with SMTP id a10-20020a170902ecca00b001a641270857mr17426348plh.5.1682969326811;
        Mon, 01 May 2023 12:28:46 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:46 -0700 (PDT)
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
Subject: [PATCH v2 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Date:   Mon,  1 May 2023 12:28:04 -0700
Message-Id: <20230501192829.17086-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
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
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 49fdc1199bd4..044c9f874b47 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2903,12 +2903,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2928,7 +2928,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2944,7 +2944,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.39.2


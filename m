Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811D72D1B6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbjFLVIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbjFLVH4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:07:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381DD269A;
        Mon, 12 Jun 2023 14:05:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56ce53c0040so30129677b3.2;
        Mon, 12 Jun 2023 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603904; x=1689195904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVa9cggtOHSUJO/ogR1wMW2sjtZWNjmDdrC369SVqz0=;
        b=LGp0peHnuaxYbTi1TrslUjQMitjh+h/buXXjte+rmzMq8EerSk6fzj/9MIVxfmxSpM
         Omqu6nYebae8kl4QHV1G7ATHJ83nT9wNtbqIHtA4KnlPAvi/4+5X0WEOsthQhJoYwmhG
         x7qZZcT6GxEhvCZo0gV9yDh1XejrVy2crvGhXSgjUWCF1D9y073Dss7gKb2gKwKJeIqg
         gITOZuL6QQ3v0Ru0LyolXLQ7MXgbRP8zVbSmn+AuXiGssqL0cYBREi8V1ugxeRNuLvvw
         6oKvVZRZlVRzitWHyvf0O6G2XA5TATPVxsClJqIqIlKCoZg9JlGxlBuUR1XF5sExgOF1
         +mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603904; x=1689195904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVa9cggtOHSUJO/ogR1wMW2sjtZWNjmDdrC369SVqz0=;
        b=BXFUltoppuS1OPcv7EBkyxn6E5X3R5kncGQLM95G/5W1YQwjgmthk03mbWZHDA1m/Z
         FUWiZvM6elQF7QQIBOn9aJ8iqCS8p+FcJdsyHw9Rh7/OnJYcS8J79OxOyTF4+c5mVlls
         uVi9Hp+rVuMRM25ZRuibbS6fcmV1qQvJyXxVl/aCcTkcv4k4cKLfHyfeEK3DgMXv5piw
         h2agv9fof5yqdZRBKXYDViimxyTfPwKcGpimN8DyxtGoep0hdFfY8SfxzwuK1s39s3z5
         NfJ4B1otGIT3Dvk4w0Z/KOn+dsh607V86ilvvhFMJ0iu9A53CPPZzkpmTbe+KgwJez71
         WhgA==
X-Gm-Message-State: AC+VfDxVnjZYKLdngVgyI4j6ch6jSEy9n7XAwKgD6DEBQiWWLH3mOoza
        a7Y8F/cMffDT8BNjGxPCXFo=
X-Google-Smtp-Source: ACHHUZ4LesFNmga2zNafYd025bzkWSSIKRSwmwCXoFtNtSsfVvER7X6NaAl79hSVn0sQ3cUacFJw5w==
X-Received: by 2002:a0d:eb83:0:b0:56d:7c4:8be8 with SMTP id u125-20020a0deb83000000b0056d07c48be8mr6827241ywe.16.1686603904409;
        Mon, 12 Jun 2023 14:05:04 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:04 -0700 (PDT)
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
Subject: [PATCH v4 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Date:   Mon, 12 Jun 2023 14:03:58 -0700
Message-Id: <20230612210423.18611-10-vishal.moola@gmail.com>
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
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb934d51390f..daecf1db6cf1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2942,12 +2942,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2967,7 +2967,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2983,7 +2983,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


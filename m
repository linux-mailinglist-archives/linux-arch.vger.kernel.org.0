Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2696718C44
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjEaVcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEaVbs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:31:48 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13112196;
        Wed, 31 May 2023 14:31:28 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565c9109167so783367b3.2;
        Wed, 31 May 2023 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568687; x=1688160687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8eY/8E6JF8s/V5NNW8TZkaDOnTKuaiqrBMcG8UrW5A=;
        b=F74YoiyArmyQwVgOOUW2kfK/7YQSeytT5Qdq4W7jztqrHFW+OxsR62y2z0sZiEV/Pj
         CHUjkMgQ+tHkrFh4S6EPBTtuP0+8wu5BQZyij+e15SnoNrkShPqGZvWdjF5BKJMv2Qv9
         d//2kHJUZF8y/wk4PqE5bOyyg7AT91rLlQi2SzidEtRHvmTf0yi6wamtogBgC9EY9N9P
         uw5EAPHRhzcCUSce1FYm7EE8CHhgk2SNgdWG+thFtb+Fd9K9ZtkE1HL6Lqu8zbrIjBxa
         OBo4gwjzqO/AwYTPpiaC4MdC5Mq0f0RkoLNLDnNUh3I4ll9vsxHX0eJNI6QQ67EeV90U
         TdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568687; x=1688160687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8eY/8E6JF8s/V5NNW8TZkaDOnTKuaiqrBMcG8UrW5A=;
        b=DKpMMPNvD1O3ESv4NwI/AeEhN7IG1ALdGQ0cInnpZ2BfgCDZc7S6DWrU0OrvvnG4JB
         jfZZ9D1iyDiEisq42A5r2jrBKKt9GuqTzSCkq6eaVNeUpxZLQoiNuH/1clQHgo+uTLaW
         YZuDKqESs8iZTNMGv7JGn7gjA3vZ8+uhgHdmETlGS6RhTeFcUSMvwFCQtmXu5TpD40UU
         sQPJA3kKpv+qXrwKf7TWCdcISEVcwHyXyECBCDZ74EO0SIg+pJuVgK9ivzY7WqH4HBWy
         KmbiB3kQteN7441LFQyLMlLXZ4MAvuGjukGDT2LxtZ+ajZ9Bed8x/I4q5GZA90oKOaOH
         XxzA==
X-Gm-Message-State: AC+VfDzy0ZMo91V8AlkLlbmmilE512L2JC+AwWBBk6xcnRCiBF8xCSnr
        wP7qrZmUFAJUZ/O8A9vasIw=
X-Google-Smtp-Source: ACHHUZ7+UFYbIzpavTgJ7f/w4fvGAPRL0PNa3hATkUDplqTdJkdO52BS/n5X3DMJ5Uv/pNitevHZ/Q==
X-Received: by 2002:a0d:dd92:0:b0:568:be91:c2c0 with SMTP id g140-20020a0ddd92000000b00568be91c2c0mr6597562ywe.6.1685568687247;
        Wed, 31 May 2023 14:31:27 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:26 -0700 (PDT)
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
Subject: [PATCH v3 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Date:   Wed, 31 May 2023 14:30:07 -0700
Message-Id: <20230531213032.25338-10-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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
index 6f7263fcd821..8e63e60c399c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2923,12 +2923,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -2948,7 +2948,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2964,7 +2964,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1


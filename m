Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07751718C39
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjEaVcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjEaVbi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:31:38 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C171AB;
        Wed, 31 May 2023 14:31:26 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-568f9caff33so798857b3.2;
        Wed, 31 May 2023 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568685; x=1688160685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzKQXlz5IDfPvgDKTOeCKkz+dXM61NoKgwUhpTupiUw=;
        b=hIfmjb5X06SZ3BaD9NYBS6hgA+ayAquIKaVHr2BHnLBOPZKQ/J4ZAsHZVuEaw1F1C0
         DLhGZpjTZZFs02UVgouMcVD7Om43dfavrY/9B0xqLArccnIFv4HyErh7ebqkxAVmYpAt
         c44ATu4lPRNkYKf1axyVO8gXjPrDMUnXOwNjgt4KrmrL4IpwwDNTjXfR8pLFfm5hWJH3
         A3an9It/QF6RuKMl0LJM9Di6sd8T8h9NIoEvAXZjtMgMuUIFQhhIMF5orERUADpDZzUC
         JdcxeDPS4ad7hb6jzXYz7QYZfeE2bjaq1vVtDaxxKS7PVXsoR09l6Ff83vLOpPnhM1WL
         QcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568685; x=1688160685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzKQXlz5IDfPvgDKTOeCKkz+dXM61NoKgwUhpTupiUw=;
        b=SB7r6F00Lx+aKhOJViFuq2qH5KpCnHUbtu4mXLZNmhp4REBzCs2MikRFYkpLmHSnw6
         0vPetVRaG8ZNmE+/srfdUZ4iREzWHKwRcmQVmSoRt4JeiaJ6vurwXyxo4Qv/aLOkcnMC
         wUJcYo1gYPvcZu7ucU5po4AmamGiUfo6yRBOIVrbNtGffwcoVe6qcaFiCoMNOrGi5wjS
         nFvJYDfQItae58nnEirCBmC8s7J644q8XMaryGjMgiSe1WxmWiuIGcI1rcrUyUjrh1Xk
         emAfpN8WcN9bZd7Q4uTs66Op28Wnjed0EPEB/AxhVLntZau4peN5/TNMsYeNJKhmfhYy
         nNIA==
X-Gm-Message-State: AC+VfDwZMMa3wmrT1OOBN1cpHZgv38TBkmZfuPWNcCRpqMSoHLq5HkX1
        HheleBukvXX2yAyg6YjcGbw=
X-Google-Smtp-Source: ACHHUZ4penqUBoef5VZ7RS39HNNXGjV3amJwKYqX+6tsdiojUfn+sW0Rg5ayNGX0C78Cc9bsT/rYzg==
X-Received: by 2002:a81:a113:0:b0:54f:752e:9e60 with SMTP id y19-20020a81a113000000b0054f752e9e60mr6993857ywg.37.1685568685351;
        Wed, 31 May 2023 14:31:25 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:25 -0700 (PDT)
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
Subject: [PATCH v3 08/34] mm: Convert ptlock_ptr() to use ptdescs
Date:   Wed, 31 May 2023 14:30:06 -0700
Message-Id: <20230531213032.25338-9-vishal.moola@gmail.com>
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
 arch/x86/xen/mmu_pv.c |  2 +-
 include/linux/mm.h    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b3b8d289b9ab..f469862e3ef4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -651,7 +651,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 	spinlock_t *ptl = NULL;
 
 #if USE_SPLIT_PTE_PTLOCKS
-	ptl = ptlock_ptr(page);
+	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1fd16ac96036..6f7263fcd821 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2809,9 +2809,9 @@ void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
 extern void ptlock_free(struct page *page);
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return page->ptl;
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
@@ -2827,15 +2827,15 @@ static inline void ptlock_free(struct page *page)
 {
 }
 
-static inline spinlock_t *ptlock_ptr(struct page *page)
+static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &page->ptl;
+	return &ptdesc->ptl;
 }
 #endif /* ALLOC_SPLIT_PTLOCKS */
 
 static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_page(*pmd));
+	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
 static inline bool ptlock_init(struct page *page)
@@ -2850,7 +2850,7 @@ static inline bool ptlock_init(struct page *page)
 	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
 	if (!ptlock_alloc(page_ptdesc(page)))
 		return false;
-	spin_lock_init(ptlock_ptr(page));
+	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
 	return true;
 }
 
@@ -2920,7 +2920,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
+	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
-- 
2.40.1


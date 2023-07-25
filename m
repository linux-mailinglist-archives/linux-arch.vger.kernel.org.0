Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEAF760796
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjGYEXG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 00:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjGYEWX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 00:22:23 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED21BFE;
        Mon, 24 Jul 2023 21:21:28 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d0548cf861aso3999108276.3;
        Mon, 24 Jul 2023 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690258887; x=1690863687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EZnRhm4Fj3KaK4sFjI+P1mIVDNOtVXSgVauozi7/LE=;
        b=RYLJ+HHhZ3SW3XdvMN1AzT9gPBErVqrhuCtcU9fNt2oY7ALxgSJoFkBn6Vm9nhRIfL
         WiTjjdSQLpNPnjH/5n9WBm6wJTnH8dJRd1NltGEZ286BUnLn7Q2MMvQIs7uIZqTwGdGS
         eL9nBqdaNLlYe8KWVzFFhBRvhsKclpu6/YA+4Q97+gqJ/tvmMP0hkmlN965zL32r5aWq
         lGDtyvV+tLl+Z/pogbSTjxnJu1qRtO3WfiwXTUnVp3YPllt2BfK2Izz7z0ivGxPYpzFU
         UjwvvFWDj18TjEMiWj89EXU3QbdGQMvzZCK7ByPk/vtnFluG2/Q0k/42+A+1E3bms/jl
         vfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690258887; x=1690863687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EZnRhm4Fj3KaK4sFjI+P1mIVDNOtVXSgVauozi7/LE=;
        b=eky9a9mtzof0022ZQiIzSVkeUNzAEI4ez0C1eCUIworlOfwIM4eeK/YUpnrVu+0pu/
         1N86r+av346gx165H2Y3iMK1sPfcNhoWWCEef27kKZxOjNCaeW9WfU9vzIH1y+C+boA5
         OXsrAjkQalioT736rydRhR95xkErniH+u6ueSdQY/pkuolGNCMGG//FQpebLLtsuZkfI
         ZMQuPeYVEkZMHYoY3+sJSZMOqHWGfs4DVqFLVDOKIoVYlmUCH2/wuTW9u/EZShGrfrdt
         XJkSoYAdp3N9yQhz2D4xlWyFIfl3zeMZpzknVLUMmEG5G+ZD4CpE7sU4MmDPaY1nLr/e
         t3Fw==
X-Gm-Message-State: ABy/qLZxm/uNa7qktUGOO1K41VI1SB+ELOG6jQYtwmnqbFLYtNOvGcgu
        6L/Pi3Jxm2Rkf6GXLw5/YMY=
X-Google-Smtp-Source: APBJJlEDrySQ7FY0Or7EcCMVmcmwbMMbiMSaZShCmPSyL8HtQQZFeTHHFjIo1cF+xzs4edAkc8Gy+Q==
X-Received: by 2002:a5b:782:0:b0:c91:cc0e:1aef with SMTP id b2-20020a5b0782000000b00c91cc0e1aefmr9011877ybq.58.1690258887257;
        Mon, 24 Jul 2023 21:21:27 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id h9-20020a25b189000000b00d0db687ef48sm1175540ybj.61.2023.07.24.21.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 21:21:27 -0700 (PDT)
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
Subject: [PATCH mm-unstable v7 10/31] mm: Convert ptlock_free() to use ptdescs
Date:   Mon, 24 Jul 2023 21:20:30 -0700
Message-Id: <20230725042051.36691-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725042051.36691-1-vishal.moola@gmail.com>
References: <20230725042051.36691-1-vishal.moola@gmail.com>
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
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 774fe83c0c16..ffddae95af78 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2842,7 +2842,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2858,7 +2858,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2899,7 +2899,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2913,7 +2913,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -2987,7 +2987,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 4fee273595e2..e5e370cdac23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6242,8 +6242,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-void ptlock_free(struct page *page)
+void ptlock_free(struct ptdesc *ptdesc)
 {
-	kmem_cache_free(page_ptl_cachep, page->ptl);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
-- 
2.40.1


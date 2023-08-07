Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E27733C1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjHGXHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjHGXG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:26 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C541BC2;
        Mon,  7 Aug 2023 16:06:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d2b8437d825so5087529276.3;
        Mon, 07 Aug 2023 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449538; x=1692054338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO3hRWVBo6Y9vRkkphMYimV7kP+YdlMpTAZzrYQT330=;
        b=Xru6G6uiZe/OuMY5nm6nRGhKKZT+cMjFr3ywYmjJVtK6bJQBvGQe4lb67TeNeIpRR1
         vU6ROYd5sljoul9DQ182dcYNUtIjSE0g9ryH9BBQnyweF2i9F3a0tNr39lnubSpEzEzx
         D9dlEQ3L7Z6V9tMyRKOuG3jp1VK2LuxNqNXMsa/r8JF3v1c5M1/VvDBiBALX9JEbGcjF
         BYD5zunEjYtVpsA/+5S4bzMaVg5Xls19tVXYJS5Y3GWWrR9cQxHo66Iare/M20jic/7P
         QScGaLnDnqCa6oKmv6Q3fNTRqyTkrnI7S8dkrsktkT3ibHnZIlamT/1RRAzAV+HV4mnX
         P1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449538; x=1692054338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rO3hRWVBo6Y9vRkkphMYimV7kP+YdlMpTAZzrYQT330=;
        b=Q7vgn/EXMeJXFoXLViRcSebZvAWl6kIq6AG0gZr+GiMyvDLUqdlOPXudplVLK94KAh
         ykN3rSe6hHbWcHDuKIDnSaBFi+0FSnrtf3i/h3EPA41cfTGgNQE39klPASjLYehBAf7S
         rqshlK3rB6OqF8sL166TALG78f6TzgAGCI8RJ2StJUXLqADB+R52Vrv7rEq4Xv1aVbkT
         MWkCnFY+GlRRJ9mV8ipwO1UT0YXZj4DqZWHoJsLCUHcwakzQDgMztAS7CYjd/X+jyq9R
         1AabyfGs2xn3ay0BTQ8hwz0dgNeot/TEK13EmoY9PHzZLO+xG8PFjaeStYQhJhUqQnMt
         B8Qw==
X-Gm-Message-State: AOJu0YybTlL61psycY00h/WG9vJpM6zejTVW5fz+8y6HIKqfEtvMNDkm
        sMZrVYjgekPnKlYOdxMlT24=
X-Google-Smtp-Source: AGHT+IFQ1sRvJZAfCY+VUYCk9fa9DxUgaBX+22XersqRcqzji4wcHGi6IN2gPixXkKaq4oGn1g4mnw==
X-Received: by 2002:a25:8001:0:b0:d0f:ea4b:1dff with SMTP id m1-20020a258001000000b00d0fea4b1dffmr9335056ybk.8.1691449538435;
        Mon, 07 Aug 2023 16:05:38 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:38 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 10/31] mm: Convert ptlock_free() to use ptdescs
Date:   Mon,  7 Aug 2023 16:04:52 -0700
Message-Id: <20230807230513.102486-11-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 include/linux/mm.h | 10 +++++-----
 mm/memory.c        |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index aa6f77c71453..94984d49ab01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2861,7 +2861,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
-extern void ptlock_free(struct page *page);
+void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
@@ -2877,7 +2877,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline void ptlock_free(struct page *page)
+static inline void ptlock_free(struct ptdesc *ptdesc)
 {
 }
 
@@ -2918,7 +2918,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void ptlock_free(struct page *page) {}
+static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
@@ -2932,7 +2932,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page);
+	ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
@@ -3006,7 +3006,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(ptdesc_page(ptdesc));
+	ptlock_free(ptdesc);
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
diff --git a/mm/memory.c b/mm/memory.c
index 3606ef72ba70..d003076b218d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6145,8 +6145,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
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


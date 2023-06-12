Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2572D2AA
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjFLVLN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbjFLVH5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:07:57 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6172717;
        Mon, 12 Jun 2023 14:05:07 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1a67ea77c3bso1704160fac.3;
        Mon, 12 Jun 2023 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603906; x=1689195906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r19jukxjbsIB2/Mx0wfUFI2Md2D0Tal9unGSXZoJa8=;
        b=bBBhxHhwNc0dlcaV8h2a4XYBtWHGe22hvKvpniF7KzCYgALGdtw6ZDxkDC9x8Aeb3u
         L7SfltNSUTPpMMAZAPZwSuq1VjJBBWwWiBaC+Bz46NWJJnZ6VvwLLTRGFLrpelYb2La+
         Z5XBEGo2Lx+4Q4s65Lii1xiAS9gXRmCdJj9fBmU+7pl8WPQzciZNN9tEea4s2EymiOfj
         uSb7iAfMXBR2nKnU1BBVn2AVnOIW9drJ/7GGkqivFyyrk3Sd/OJyxdPtL4bbaX3dpY3E
         iXz0Nc/l9PDCGRHW4+I9NS6xogIi8lZKNWODyR8ULfa6yt07nj/HtSeI3w5uor1wLjvR
         igBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603906; x=1689195906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r19jukxjbsIB2/Mx0wfUFI2Md2D0Tal9unGSXZoJa8=;
        b=erjTxUAnoLFUJ4ShjbZxYazk5fXvO/CHCpRAGlNb8dCa+dPMW6OPItzk6H0rmWMGii
         OMl/wZXu8l8irkCIXMdmOn1yLRWEAILH+NCp2znGAeziIxCjlZ+d5pewfKdB+D/jo8wa
         w5oJvBJZ3qtCYKbWPkZfZ9ZAj/A+PMNN3NY0OvFfbtIXdgkLP15foJERMTFRObpbM0jj
         3Dx5SOonXffyGoiMOEc1kiSx0lom9qOWGBkzPUouG8bvXcA/RQ6zywuU53hvq3JDa9Zw
         EVUWL7L2zLJuREd7OuF/nMJEp1AvVo3U8fn18GOjjUdKPcKH7RDpcIa80+KGfH+Cmobh
         Jc6g==
X-Gm-Message-State: AC+VfDzrXdGLk2QEX2aPydbSM9KnvycVLtH050Y6kqYe+MD1QXwl9FvR
        9R2IlwPIC9LL62fytDQmx+c=
X-Google-Smtp-Source: ACHHUZ6a/96wj8UsR1eewejCsUK79jNNmW6NRKVRY6WskMtRjwMJM0HWL1CF60/WviLDJygSxMchcw==
X-Received: by 2002:a05:6870:989c:b0:1a3:4072:58f1 with SMTP id eg28-20020a056870989c00b001a3407258f1mr7318868oab.6.1686603906371;
        Mon, 12 Jun 2023 14:05:06 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:06 -0700 (PDT)
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
Subject: [PATCH v4 10/34] mm: Convert ptlock_init() to use ptdescs
Date:   Mon, 12 Jun 2023 14:03:59 -0700
Message-Id: <20230612210423.18611-11-vishal.moola@gmail.com>
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
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index daecf1db6cf1..f48e626d9c98 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2857,7 +2857,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
-static inline bool ptlock_init(struct page *page)
+static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
 	 * prep_new_page() initialize page->private (and therefore page->ptl)
@@ -2866,10 +2866,10 @@ static inline bool ptlock_init(struct page *page)
 	 * It can happen if arch try to use slab for page table allocation:
 	 * slab code uses page->slab_cache, which share storage with page->ptl.
 	 */
-	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
-	if (!ptlock_alloc(page_ptdesc(page)))
+	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
+	if (!ptlock_alloc(ptdesc))
 		return false;
-	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
+	spin_lock_init(ptlock_ptr(ptdesc));
 	return true;
 }
 
@@ -2882,13 +2882,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 static inline void ptlock_cache_init(void) {}
-static inline bool ptlock_init(struct page *page) { return true; }
+static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline bool pgtable_pte_page_ctor(struct page *page)
 {
-	if (!ptlock_init(page))
+	if (!ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
@@ -2947,7 +2947,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(ptdesc_page(ptdesc));
+	return ptlock_init(ptdesc);
 }
 
 static inline void pmd_ptlock_free(struct page *page)
-- 
2.40.1


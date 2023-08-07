Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F217D7733D2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjHGXHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjHGXG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:26 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEF619BC;
        Mon,  7 Aug 2023 16:06:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d0728058651so5368051276.1;
        Mon, 07 Aug 2023 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449540; x=1692054340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBjJ/e2vPX4j94DTkAO9XQqqbwuOMqryYrtpznFEgGY=;
        b=aasPlAtm5Pcd0yp6duryP473IaipZJS0bWZ4Z8XEGwFlj43AOqpIIC6FhirKlPve9C
         F1vUSIrLW1oYFLLrLilYCJzqaLsw1rmRGBb+Z5eKzeBY0HVz8f1HGASCxMQ2qqkeDt1/
         NUUsoQwBHF6NBLlkSQcHcy9LC4jgcOdJmOlAy/6h3iyfEMCFdLo7Fk1Bu4KWGLpiNsE1
         KzSFxNl6DRl46MY838sL7FF+wIJkc1YVhg5kJdFIQoWHplt5NksftMQPYk7wCakllMw/
         EceX3OKTdEGMJ4GdFrkX3TffvwqD7i/AFN0kCIklmMB/JORnudk4URx0r/bcoO+F1Yl1
         rD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449540; x=1692054340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBjJ/e2vPX4j94DTkAO9XQqqbwuOMqryYrtpznFEgGY=;
        b=athysRw1zpTQA63d2IcX0+LwErVLcnuSJztv4QxQyjCTUk24mp5Wx8jz2UTUeMsudJ
         t0nHCwAr4bQZiHhsF0kBMfy4UjezmpF2+3F2iMGjmGThGDp3kzx6lJ7bR/DMK9arWBKb
         Vrw3sqCfTF8XKkbveT0yiuSggZenZJ/92lqo69tflEW1YNKvqX85d/5WalVFQpgRko6W
         4/CgUqNku+StUwDbBmEDDqoDdWb6REfNtUaAHCI7Gm3xezjW21qcdAMLlq+vsS86NSNq
         Xi4kgC219D2R2CTSGJ9Niy/eLZ51SQXXEBx0PK4/3VZDSa028+PifrAr6AEQ6bUU0USW
         BZfQ==
X-Gm-Message-State: AOJu0YzNNN6HtKtt4cQDgT9zaRGYhiEWSfQSsJl0HUuvbKMkXE67+e5t
        tVY8n5lEsgAoj+sKAN+duwo=
X-Google-Smtp-Source: AGHT+IEw8LfaxYvauKrU5QG8lz4qzDMmMrsNvSvomqfZDfXz4mmURgWJbxHCG9LEh9h57v96do4e4w==
X-Received: by 2002:a25:8251:0:b0:cb9:41ad:8938 with SMTP id d17-20020a258251000000b00cb941ad8938mr12329076ybn.3.1691449540449;
        Mon, 07 Aug 2023 16:05:40 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:40 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 11/31] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date:   Mon,  7 Aug 2023 16:04:53 -0700
Message-Id: <20230807230513.102486-12-vishal.moola@gmail.com>
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

Create pagetable_pte_ctor(), pagetable_pmd_ctor(), pagetable_pte_dtor(),
and pagetable_pmd_dtor() and make the original pgtable
constructor/destructors wrappers.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 94984d49ab01..6310e0c59efe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2921,20 +2921,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline bool pgtable_pte_page_ctor(struct page *page)
+static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
-	if (!ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pte_page_ctor(struct page *page)
+{
+	return pagetable_pte_ctor(page_ptdesc(page));
+}
+
+static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	ptlock_free(ptdesc);
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pte_page_dtor(struct page *page)
 {
-	ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pagetable_pte_dtor(page_ptdesc(page));
 }
 
 pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
@@ -3032,20 +3046,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
 {
-	if (!pmd_ptlock_init(page_ptdesc(page)))
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	if (!pmd_ptlock_init(ptdesc))
 		return false;
-	__SetPageTable(page);
-	inc_lruvec_page_state(page, NR_PAGETABLE);
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
 
+static inline bool pgtable_pmd_page_ctor(struct page *page)
+{
+	return pagetable_pmd_ctor(page_ptdesc(page));
+}
+
+static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	pmd_ptlock_free(ptdesc);
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page_ptdesc(page));
-	__ClearPageTable(page);
-	dec_lruvec_page_state(page, NR_PAGETABLE);
+	pagetable_pmd_dtor(page_ptdesc(page));
 }
 
 /*
-- 
2.40.1


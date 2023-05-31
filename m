Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0B718C64
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEaVcs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjEaVcB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:32:01 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0543E5A;
        Wed, 31 May 2023 14:31:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-568a1011488so971507b3.0;
        Wed, 31 May 2023 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568695; x=1688160695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oaubVECbDcpncGofy3SyRxI7NQgpixW3FZHbyn9Yjk=;
        b=ditcnS71SBC9ni8k286RH+lbOQgfG7PCRFPFB/+gsGtd91WJDFwTiqS8wSFxx5SqNm
         NDEu55kAliwqkv4+OeAiBx4Dtlk6APsI2JGOnAuJmD3QcfvBggdvrn23yK3wDSKM6a8t
         e32asmJ/Rn3K4ua1Ni58ZwRhYlStsE+77Viu6GCYO1u0Ujf908XsQZtJlTqrHFJAkKkK
         Mjajw5BTeegwx0KghNxbnl2uzVS9ZiBwBGYnqna7EVzWEplqQfDV4S8WEKdXyIryNNy8
         tJSCeZKUks8IOUQQh+yhMBSuygAiQUvt/2CrjYMsfZwcI4YczZhuoKfku3jgAV+GNYVx
         ktNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568695; x=1688160695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oaubVECbDcpncGofy3SyRxI7NQgpixW3FZHbyn9Yjk=;
        b=AS4G6NLZrPkE4UeYPo7vh33GXw86t4CIbqu63pjfKWPmoAi2B2Wvx9JTvcfFfhhOPT
         l02vCjAajzeXsYEBouQKlkRpqHIuQa3fXDykUKk38d9FrWb2g/kODFDAZkmhWbw8NNWV
         GlqaPhsfKUYHuhP5qhrpxCLwqNkr2co4nsK+bY3LxxIneXklhBVJIYgf51S3XQ1GjhEP
         DfVBJs1GVHVWgGPEyScMTIT6Yf2jvTahirva0fZpybNH8VlPqKfePoXbKCi46AlEaAJR
         61C0NG84KC7WDafPXaeqffo8UPYqut6hv6EoHOM5DeUPixVRMRJcSLeovADmLFd+swuU
         2Z+g==
X-Gm-Message-State: AC+VfDxdWbMVfUDojQBtjMCFnSOKExHrNrP6aEUgurvFwa57BF3Q2vs6
        hFgx6rnKspjiLXtbmLHSzbc=
X-Google-Smtp-Source: ACHHUZ5aCiPljYuheD8NnJvwTTWKzTm6/fHh7z9wHXOX5DNM+ib+INiEbpn3KPIafpnwazjaJRxT7w==
X-Received: by 2002:a81:5294:0:b0:561:e540:b1b3 with SMTP id g142-20020a815294000000b00561e540b1b3mr7813627ywb.38.1685568694951;
        Wed, 31 May 2023 14:31:34 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:34 -0700 (PDT)
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
Subject: [PATCH v3 13/34] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date:   Wed, 31 May 2023 14:30:11 -0700
Message-Id: <20230531213032.25338-14-vishal.moola@gmail.com>
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

Creates pagetable_pte_ctor(), pagetable_pmd_ctor(), pagetable_pte_dtor(),
and pagetable_pmd_dtor() and make the original pgtable
constructor/destructors wrappers.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 72725aa6c30d..2c7d27348ea9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2867,20 +2867,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
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
+	__folio_set_table(folio);
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
+	__folio_clear_table(folio);
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
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2962,20 +2976,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
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
+	__folio_set_table(folio);
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
+	__folio_clear_table(folio);
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


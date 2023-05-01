Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5F6F3725
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjEATaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjEAT3k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7A01708;
        Mon,  1 May 2023 12:29:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115e652eeso29039019b3a.0;
        Mon, 01 May 2023 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969332; x=1685561332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/HbzXYZlFs8Glr3mCgcQ6yZjaq6zFAfxmTJm9brDXY=;
        b=YU74FvpHQCK1VqAuVX8r2BjduNpUerOh1yATlR8mKQ/tJLpS2WI1LKB7NUnPZev+ku
         rfgntGzBluAMKuHfK/jms2NgctRzUuZHcxtFDuNiPPeXkbQ7Z48v/aLnoLGhmcKi5okk
         NTHNilz0HthKY/XHg97rKwZvMnLAYPI7U1eBqYo3DUIS7zYhW0tg5v9W5kNg2nZAJHx+
         0W0xkqlDIUsVkMuesra65fGttpYRxCYfqsHDDsc8zlGh06W2A2UnpmXTtrAlRE/I54n/
         9b61gxsFscmWDNDgpJxss4pOhFtz/pn5R4Qs2mfASivX3bx3H5gbzbMc69UUOvWi91zv
         pr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969332; x=1685561332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/HbzXYZlFs8Glr3mCgcQ6yZjaq6zFAfxmTJm9brDXY=;
        b=TK966p3RH7VZ+1nEowWYKCZcxZDbsEu054RwPH/5aBgI5AnnfMJ5JMFEF26u7igIdn
         k6tVOaRaZPrgQHEvXWDvTLOLIoY3B3LwWqdSmcZUYhY1r65W/2KnVE+ao5PYquoKYyLB
         jZKUiB9X5qclybREtBGfqf+Dru5QZ/H+NdwXAX6HX7uqYBWjN6+cgkkfcwDCb+30VldX
         h3N4bAIQyy9H4gE5I2NDUYMhmyd1rcG/HtoGcVLgaYsU6zrFJpQFgWOfYYaKZ/GqXZzL
         BysNotDK6dsskmGMFD/qjZgOVDpIYaNy1GHSZ3LdgcRSA/GIaIx8DnmF2FLydu+vL0tt
         y3Ow==
X-Gm-Message-State: AC+VfDzmwtw8nXQPjJGuwogFnduQ+EqU3OiJTQAh0CvQXjbfPSJjNVaj
        xGzZRwTOd6u/gYbjYVmmQENkabeVxx9ASr2v
X-Google-Smtp-Source: ACHHUZ5tlVMWyUaJdG9fqFVZnpLPEvgTINU205p9ECnUgFr/jtV6hdVvJcRfvr33OgCYwfP6dTnMLg==
X-Received: by 2002:a17:902:c94f:b0:19a:727e:d4f3 with SMTP id i15-20020a170902c94f00b0019a727ed4f3mr22987004pla.5.1682969332204;
        Mon, 01 May 2023 12:28:52 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:51 -0700 (PDT)
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
Subject: [PATCH v2 13/34] mm: Create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
Date:   Mon,  1 May 2023 12:28:08 -0700
Message-Id: <20230501192829.17086-14-vishal.moola@gmail.com>
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

Creates ptdesc_pte_ctor(), ptdesc_pmd_ctor(), ptdesc_pte_dtor(), and
ptdesc_pmd_dtor() and make the original pgtable constructor/destructors
wrappers.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 58c911341a33..dc61aeca9077 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2847,20 +2847,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
-static inline bool pgtable_pte_page_ctor(struct page *page)
+static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
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
+	return ptdesc_pte_ctor(page_ptdesc(page));
+}
+
+static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
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
+	ptdesc_pte_dtor(page_ptdesc(page));
 }
 
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
@@ -2942,20 +2956,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
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
+	return ptdesc_pmd_ctor(page_ptdesc(page));
+}
+
+static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
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
+	ptdesc_pmd_dtor(page_ptdesc(page));
 }
 
 /*
-- 
2.39.2


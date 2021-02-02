Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E8930BC8D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBBLGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBBLGK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:06:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168FDC06174A;
        Tue,  2 Feb 2021 03:05:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id j2so13013955pgl.0;
        Tue, 02 Feb 2021 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAbu4uylyD/1yZsJCHQjYIcITelz2x29iNZ/QiXVtA4=;
        b=XB61lX1Z4jTiaTn6F2TEgL9yy2HEpkCa4LEy14gBY61wcjtayhfijNdSUiYWEKnC0b
         Gr4gY14wuTx4N3GPxjmBQgPPbflA14HDXrkIMpvUCKjUM+ZvCd2V9RHJLqhnnykGpnmi
         ii4PbA6qaK5JS6pCJ08xdnIfLVbWR+I/7jOtTWQu7ZOjGOtox6vyFQ269nfVDTSaBGKF
         73ya1YZU3m7dknQ7mYnJLQ+8idRn2Jf81SlidA9eaXQzYa3JAWDtCWGnZMbrQeUPMtKF
         QnBcajgu8RWGcSenhBxa7ensCih8tLH9hK6GnxPxKBbZO5ySSgTv2JlKOx8Hg/NpJG7s
         R/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAbu4uylyD/1yZsJCHQjYIcITelz2x29iNZ/QiXVtA4=;
        b=sLNaVEjXV6M8Jo2IZrV0U4ISKhzJxvYv9KdDduIFY3/dqmke75xEKiXgxj/83BhDQ3
         5++8OwSGh+wSKexFmoMF9Op1qY7x7WleONwO1+w8FLZKe0V5ULAINYdxU0cg9C6paXhN
         +8a/QL80osjD++WpKBrJgrAtTcH1tCe2it055muYbWA/a0PsEuqIb1kAiBB5raqNd2Nq
         Hh4vBKWMV2Cl39v2v5Ma4wF3aW58sFhqI3qdgbyIVUBScLBBML5yz5IHk/ZiVcozqmjw
         hdyZVTHlPnioPZUKKJcD7IhuYXDfJ+MRaXaJw38ojOOOcT/KEClIxGuK03MaWf/oD+qY
         EO9w==
X-Gm-Message-State: AOAM531y69dzc83KOvDIb1bHG4BNms+o7/quNWoAadFgShXfPT2SO1EZ
        b5XbG9unzaRFSzUNZioi9mw=
X-Google-Smtp-Source: ABdhPJxVMcdgA1+Y8LqXd2e61PK20uUftYJf8JWfAFkTyxXbbKor8wFP6q9LQTBVsxFGjf6kJasOew==
X-Received: by 2002:aa7:9694:0:b029:1bc:d0ba:10ff with SMTP id f20-20020aa796940000b02901bcd0ba10ffmr20855469pfk.18.1612263929711;
        Tue, 02 Feb 2021 03:05:29 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:05:29 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v12 01/14] ARM: mm: add missing pud_page define to 2-level page tables
Date:   Tue,  2 Feb 2021 21:05:02 +1000
Message-Id: <20210202110515.3575274-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARM uses its own PMD folding scheme which is missing pud_page which
should just pass through to pmd_page. Move this from the 3-level
page table to common header.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Ding Tianhong <dingtianhong@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm/include/asm/pgtable-3level.h | 2 --
 arch/arm/include/asm/pgtable.h        | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 2b85d175e999..d4edab51a77c 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -186,8 +186,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 #define pmd_write(pmd)		(pmd_isclear((pmd), L_PMD_SECT_RDONLY))
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
-#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
-#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index c02f24400369..d63a5bb6bd0c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -166,6 +166,9 @@ extern struct page *empty_zero_page;
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
+#define pud_page(pud)		pmd_page(__pmd(pud_val(pud)))
+#define pud_write(pud)		pmd_write(__pmd(pud_val(pud)))
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
-- 
2.23.0


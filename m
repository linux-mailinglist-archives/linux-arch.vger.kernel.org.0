Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D0301A87
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbhAXIYQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 03:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbhAXIXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 03:23:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9DC061756;
        Sun, 24 Jan 2021 00:23:09 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q2so2976139plk.4;
        Sun, 24 Jan 2021 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5+HXwlV+fH03hyDjK/J9gg0LI2GnzY0puUeRChOcaU=;
        b=FJfdd+BvQdR6QZkiZ000WG4imKauyp2TKUd7ov3ARyWxKn9AdZ+Iu4WtGCe5ie6eDS
         vVUlTE6CnRm3Tadsj4m7umH0Ualy1+haHVe8kCZNtzl9/N4AfiAvBwK7MM8SVDRkcxx2
         uIFx9idE1UVJeHCqo40pWH9whW3qPus1jrBhVSn7VsTMtSoq5vEiAKcLtbvAsvScqrMZ
         jd+hUZtOerguD/k/PIucqPjZFFFSamH4N15v7pMpk+eRk5kpVc+M0lyg9OPkFFsDD6tv
         EobQG4c2j9PZ8ppw8yGmN596LFVFT4SFzF6UBSPS8AGKM8et8PuJoy7zc8LxFndX5Mt2
         rsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5+HXwlV+fH03hyDjK/J9gg0LI2GnzY0puUeRChOcaU=;
        b=SiTzJDKvp6d4/bIIBabxipCnsDkv7v3rcSqtllJEJ20BVSImBt4a/26anG6NPQE/PR
         43F+LcJXpNVRl2OyvokT/tmI7ycQ+9KLNhlUQuY2tSM9uZGfCKy6xQtROY93/ZeHGaY0
         OuLjOBU5b6algk4NfpRvmNRNLwE/zMXo6NZrdDVAz+H55iT388XVmbR2rFr2Md+UPQBu
         F4SFc4KMdRWp3aYRIZhuU34x7K1sDolkSyBOfuCBg+J7yLDAmuhT4r/aYoN/0DZzbyl6
         jpinJB+qQ+b8Ny9eWXAss/YM+cX2aY3zHG9reyJz+bxtrLvabwnF//HWLY9BQx51NFB/
         agbw==
X-Gm-Message-State: AOAM530vlhNnNGv568VWvvqE0Pe0tCzQtysgOqM/aMh9IIlOw74GuZqE
        UBa+QdgYgy1RsiMF+xjH9sw=
X-Google-Smtp-Source: ABdhPJxD5UwSXKWxq077HcNekHjHCxP9n4SGcDoENgLvY1RR9GktbirNa0o0jUS4EhthEUeob+SvKw==
X-Received: by 2002:a17:90a:ce10:: with SMTP id f16mr1347598pju.136.1611476589276;
        Sun, 24 Jan 2021 00:23:09 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gb12sm11799757pjb.51.2021.01.24.00.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 00:23:08 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v10 03/12] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Sun, 24 Jan 2021 18:22:21 +1000
Message-Id: <20210124082230.2118861-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210124082230.2118861-1-npiggin@gmail.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 62372f9e0167..7f2f36116980 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -189,7 +189,7 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -217,7 +217,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -229,13 +229,13 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -247,13 +247,13 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -265,7 +265,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -306,7 +306,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
-- 
2.23.0


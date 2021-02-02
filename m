Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6403F30BC8E
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBBLGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBBLGQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:06:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA0C0613D6;
        Tue,  2 Feb 2021 03:05:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e12so3065116pls.4;
        Tue, 02 Feb 2021 03:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7TTkxjv7kH92yRavCWr3ozA0ymdaV4WqylsmXEFcEA=;
        b=X5Gmr6o7rZjWh4lQKjrWeIYtAjKZBhAPpZ6EkV4pPSkfSRtBYS+uElKVbsnZiEW6cS
         m8CDnvh0qc/Jj/m3uarRKf2oOLvDBe55eJ8Uu57rkYcGqLnBwzdzgPSnwEzswltDa0Mt
         Tmg8CP/KMkbZT2OcCkrEgoc3plgljVApF5YJ6FRFMAY6Vk7/+35PTv5vVn4WQaAq606l
         sg3X2gqkeodFfjyiIUr1QGmo1qVXzh/l2JLSr89Us38X3nFd1j6Nukqt1Tih6QxKsRYd
         ZYYLl3hzlnxoxzlrP6dNi52Ha+RWjNZY/AMvLdZgNKjHgjuiB3rG2432oa6NK2xDudLc
         9AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7TTkxjv7kH92yRavCWr3ozA0ymdaV4WqylsmXEFcEA=;
        b=SSuLKdMpPuLZmz0PFSEEjrmWKHu1Jo3t+2Ln7UJSKUCJtvXRZdlRMGue65QUV7N473
         QcuPMZBj4V4D1PrZ6Ny8dIL+9p0pN8SMoI7wdrqPFbDarixgrgGQrQ0664+ah1nIQHZx
         F3xAyXqzspJ5ycbyXj8a6GLo9irmZ87cl768owxcwumMQyyaXaZf5a2+R+o8Lc7kdy7/
         S6eMyfkNzprVaukSUMtpUhwp/mc52cv0sImSSeDRUcGoljclhQp5jvOw/TERGL8xnkw0
         lTserDGkCGP2zOEA1YMb3J+PVzxHH2WHAe3TML8ymQ5BapSAT8TrnNPZeV2KpdCwbQfB
         luoQ==
X-Gm-Message-State: AOAM530lSJiupFoWYYEnPysT4VC+IHtMuQxZJZ/613gHrnhwfBtpHvEE
        HETTC4UfZhnFavviNlFO2sRASuYPcag=
X-Google-Smtp-Source: ABdhPJyzdK/FxUKtd6l8H2RxfDW8ApCyd9jou0qkaEA9aLGxxC+wSN16PnxrQHqgaZoLGKTYswrK6Q==
X-Received: by 2002:a17:90a:6288:: with SMTP id d8mr3775240pjj.49.1612263935550;
        Tue, 02 Feb 2021 03:05:35 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:05:35 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 02/14] mm/vmalloc: fix HUGE_VMAP regression by enabling huge pages in vmalloc_to_page
Date:   Tue,  2 Feb 2021 21:05:03 +1000
Message-Id: <20210202110515.3575274-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
Whether or not a vmap is huge depends on the architecture details,
alignments, boot options, etc., which the caller can not be expected
to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.

This change teaches vmalloc_to_page about larger pages, and returns
the struct page that corresponds to the offset within the large page.
This makes the API agnostic to mapping implementation details.

[*] As explained by commit 029c54b095995 ("mm/vmalloc.c: huge-vmap:
    fail gracefully on unexpected huge vmap mappings")

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e6f352bf0498..62372f9e0167 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -34,7 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
-
+#include <linux/pgtable.h>
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
@@ -343,7 +343,9 @@ int is_vmalloc_or_module_addr(const void *x)
 }
 
 /*
- * Walk a vmap address to the struct page it maps.
+ * Walk a vmap address to the struct page it maps. Huge vmap mappings will
+ * return the tail page that corresponds to the base page address, which
+ * matches small vmap mappings.
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
@@ -363,25 +365,33 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 
 	if (pgd_none(*pgd))
 		return NULL;
+	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+		return NULL; /* XXX: no allowance for huge pgd */
+	if (WARN_ON_ONCE(pgd_bad(*pgd)))
+		return NULL;
+
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d))
 		return NULL;
-	pud = pud_offset(p4d, addr);
+	if (p4d_leaf(*p4d))
+		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(p4d_bad(*p4d)))
+		return NULL;
 
-	/*
-	 * Don't dereference bad PUD or PMD (below) entries. This will also
-	 * identify huge mappings, which we may encounter on architectures
-	 * that define CONFIG_HAVE_ARCH_HUGE_VMAP=y. Such regions will be
-	 * identified as vmalloc addresses by is_vmalloc_addr(), but are
-	 * not [unambiguously] associated with a struct page, so there is
-	 * no correct value to return for them.
-	 */
-	WARN_ON_ONCE(pud_bad(*pud));
-	if (pud_none(*pud) || pud_bad(*pud))
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+	if (pud_leaf(*pud))
+		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pud_bad(*pud)))
 		return NULL;
+
 	pmd = pmd_offset(pud, addr);
-	WARN_ON_ONCE(pmd_bad(*pmd));
-	if (pmd_none(*pmd) || pmd_bad(*pmd))
+	if (pmd_none(*pmd))
+		return NULL;
+	if (pmd_leaf(*pmd))
+		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pmd_bad(*pmd)))
 		return NULL;
 
 	ptep = pte_offset_map(pmd, addr);
@@ -389,6 +399,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	if (pte_present(pte))
 		page = pte_page(pte);
 	pte_unmap(ptep);
+
 	return page;
 }
 EXPORT_SYMBOL(vmalloc_to_page);
-- 
2.23.0


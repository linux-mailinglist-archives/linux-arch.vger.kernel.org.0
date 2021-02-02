Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF6430BC95
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBBLGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhBBLG1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:06:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8027C061786;
        Tue,  2 Feb 2021 03:05:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q72so645978pjq.2;
        Tue, 02 Feb 2021 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+2EgAIhGTTse8b+E+9Hf45DrzJMmCtp0U7AjAQfN8I=;
        b=uZOsM1Oa1wBSEyJaD5TLxkV3c4vw+3dLuwTKngo1PampwYDVLBRdxK4OdSVGPqGQ/b
         shWgHjLDWZbZzClH2Qep9MYEvKL36CGn1uFm33NLYLzPvz1Fh2Kj1wAvNKHWGN7gJP0e
         gerI1kjJIAnIQdDEX0If7X70GAwtv/sifeti3p11TKAzmAljx4gG9I7ZTpJ2bwY+5UeO
         XUUx1mG8g3dkjSRw3ivwHQWZ4J7ptJhFb209u9yNgJFTDs6X4R8Z2moN00HRrMtgyrpA
         zaumTRSH+OiAk1Gvn+x0wx1eVq/J4DvLJy+CQM/31wr4JgrleqzVcVa+FrM5HnaC7E8v
         ChFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+2EgAIhGTTse8b+E+9Hf45DrzJMmCtp0U7AjAQfN8I=;
        b=O3M1V+kwLkFm6qWjS6Uh8zK11NuK2lKtjEd4zjxzxJD1t/Bh9QHEpSzp12oso7CEwQ
         4BoVbei3KbK9mcavzqOilyIJB7XD9Q8PNsGEF8N1Zv4thm1JsOYEcW+e4Moa8GB7IAlt
         hX8yvNLLrTdSuzjQM6tHkK7puZtZ66QKbMRHuMR8GmYI6ql3lVVApwwETf0i6Zjg6WJM
         KKXCFW30hZ1WKQBpd9upYzgRL9NaC7r8NHP/DL4KlbZCeTHzak9jEmVYw3+EQTnZ69KW
         Hi2wxxIizBD623FcBKCBpUG9t1d7PQQBQipVn7SizYeaZr8PYruUCFSxQ5CH6U+/a2UT
         1T5w==
X-Gm-Message-State: AOAM533MXn4cbrOB42g5EsKlwAMLevxTwE15mq5qGEDAKgmQadOAPOpi
        4B6RM6YvYGaZaLvQpS5/CVs=
X-Google-Smtp-Source: ABdhPJwaR2Bb0JXFdZBuyi1lv6jRMbgUP/VjBu4qZRccLPfnbDkpnPbWOkKknA3n0/zqafzqaoXEsw==
X-Received: by 2002:a17:90a:9310:: with SMTP id p16mr3810901pjo.211.1612263946582;
        Tue, 02 Feb 2021 03:05:46 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:05:46 -0800 (PST)
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
Subject: [PATCH v12 04/14] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Tue,  2 Feb 2021 21:05:05 +1000
Message-Id: <20210202110515.3575274-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


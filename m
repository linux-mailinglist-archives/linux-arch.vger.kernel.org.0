Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C32400D8
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHJC2D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Aug 2020 22:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHJC2D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2020 22:28:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A0CC061756;
        Sun,  9 Aug 2020 19:28:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so3978870pfd.1;
        Sun, 09 Aug 2020 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoa50mjKdO+6rEo7JFgsM1iktECeAufQruBypQNx5uU=;
        b=SMQPO07308HbTz5R2bXEM/3gc3ItFl6g5ePYDHuBQx4pD8Y6rKeRum7JmixNo2JTPy
         F8e1S2IG7aEYVgVAu8HIbxKoAlslBlF27d5piH2FeaWK1c7upqS585JDLUhCBcKzQHTn
         wr9L/QH+bZwdnlKEEWwiDjWifyVhnVJzNCNcb2NqGD0npXFc9c+tb2z8LGK1AJDVAsNZ
         XiIbv0FFtFNWpoJD4OnZR6JRnhsts/5+BHgl3O3yu2m4Rl8JzRD3sJ042T61COweBtFC
         EM1Y+FQW7Nrt8jT95YSaPBYerMpBnEsZSojnMJJMiWbq+fSUxZ6KLcRbExu4ZjJFbrx8
         PSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoa50mjKdO+6rEo7JFgsM1iktECeAufQruBypQNx5uU=;
        b=ILoWhD+Kz2JWsurz4ZsjO8PTzBsQ1544u5gtOz7S7/sFygLSx6tPnUSs9S8YxhRdcQ
         Y5fornsYWVIGobOjG5ZJP3EWe5AVsI2Kg9IUCpa81miZ59gbP7mLeeKSxjFL07iArlNK
         up9t6ztDpq86N5p+r0WBXHdOKgb/srO/panzsi73o7xJNUyN8xhpI+coX3edx+xi1PTD
         uDhZL6OZM79KURJtpxbga3OaJzUz3OdFubXvGmLFPluAb7MFkUm1zCptlkhoROvyXtIa
         ruKYZ5yF/NaOhYxqlCGtypI4HLy9jthFhoCbEWfo4+HzhZbmQN9JUv2nR51Acr0Q7bTw
         Ifug==
X-Gm-Message-State: AOAM530r25ne4DNZE6tpKOWYLjmZKBFoEV6+6yrou8dbWpxSRmV1yJL9
        dha7HTUeBoKp0dmi7DufpOmkW/ib
X-Google-Smtp-Source: ABdhPJyF0v331ifmF6+EZbg+clfmQWCPigoJ9Z+l4oz8cqoLCgmGsSnYR+bh1HGTwKbaJ/maQnmNDA==
X-Received: by 2002:a62:6083:: with SMTP id u125mr24178457pfb.286.1597026482560;
        Sun, 09 Aug 2020 19:28:02 -0700 (PDT)
Received: from bobo.ibm.com (193-116-100-32.tpgi.com.au. [193.116.100.32])
        by smtp.gmail.com with ESMTPSA id l17sm21863475pff.126.2020.08.09.19.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 19:28:02 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3 3/8] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Mon, 10 Aug 2020 12:27:27 +1000
Message-Id: <20200810022732.1150009-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200810022732.1150009-1-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 49f225b0f855..3a1e45fd1626 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -190,9 +190,8 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 
@@ -218,9 +217,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -230,15 +228,14 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
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
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -248,15 +245,14 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
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
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -266,7 +262,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -307,7 +303,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
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


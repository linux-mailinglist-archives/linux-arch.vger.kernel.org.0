Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32C2CFA1A
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 08:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgLEG6q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgLEG6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:58:39 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926FC061A53;
        Fri,  4 Dec 2020 22:57:59 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so4918336pgg.13;
        Fri, 04 Dec 2020 22:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Y/hT12bvV3dyctfA7PHWDL72BJBoDG5OIVFWS0o/KA=;
        b=r3yXRuwHIyOw4PWIDNvlN60onX907p/oyXm4aLxiAVEu7zPB03gzfxLjbv6ANoeqFy
         Jr1/9cwMh+nYoZHJ0RBpC6PN01EZkoSbwaZ1wZ20JitN+P8CCNr/0DE2pYY3aPNIPMLd
         mtxAjY2rgDI88u50tQvLr+MvL36Jdnkx/bMaran2vgFDFOaH8beiFEj0arm/g4MupleP
         yzLVhgUprH/6de4+ae8oDvIox+M3jYdd1AQCmVWYuwNnqSIkEdseDCg4hlCv8C/KWyZS
         CmrkV/2clgtutIJUk4Hyjjc/v8etndujoRcmO7g3CQTnfIPWHX3g87uSJMYOoFoZcpuv
         m1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Y/hT12bvV3dyctfA7PHWDL72BJBoDG5OIVFWS0o/KA=;
        b=CA8HmtNJpvhRdiPQnM7XHzhotBkMqIQKVNyZyVfsrYqFuD3b1YniJxz4XNjxwnK+xx
         XBd5oK4OGXyNmhw2ICgUK+oeh+0gK47FyoXfZ8KhaRM8zirYcZFYCJKzs9KtBwsc6sPz
         SMB+uneXMLTJ+sn5DTPGYIuBI4aBXei7Z2Cy5k5FHdDLXcbSIx073Dhl50ko4RFG6q6a
         6V/OzLDXO1CQslu+NoU9Ya+auzduc575OEjcY9Htr84V7g+okTJW+VxgtrL6hWDPtnN4
         aGut9DzNPKLPRV97PdMJoGT25cSGKRSerSofjK991AV7hr2UmwzoBUUcxw/iUJG3iMkH
         PPpw==
X-Gm-Message-State: AOAM530kKVG1ryv7SgjleCNHOMDUpDmdj7w6+kijloxhCqQsAS/hK0+b
        ajQeHgwYUGwx2TbcccJ2iN8=
X-Google-Smtp-Source: ABdhPJzY1w9SJtkFAhYcQ52KUb3NWH4L2iEK2AG9tjVfRUxzdSM3BeB7THCA5DFKn413NTM9lXb2AA==
X-Received: by 2002:a63:ce17:: with SMTP id y23mr3622288pgf.444.1607151478939;
        Fri, 04 Dec 2020 22:57:58 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:57:58 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 04/12] mm/ioremap: rename ioremap_*_range to vmap_*_range
Date:   Sat,  5 Dec 2020 16:57:17 +1000
Message-Id: <20201205065725.1286370-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This will be used as a generic kernel virtual mapping function, so
re-name it in preparation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/ioremap.c | 64 +++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fa1ab41d152..3f4d36f9745a 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -61,9 +61,9 @@ static inline int ioremap_pud_enabled(void) { return 0; }
 static inline int ioremap_pmd_enabled(void) { return 0; }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
-static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 	u64 pfn;
@@ -81,9 +81,8 @@ static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
+static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	if (!ioremap_pmd_enabled())
 		return 0;
@@ -103,9 +102,9 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 	return pmd_set_huge(pmd, phys_addr, prot);
 }
 
-static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -116,20 +115,19 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 
-		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
 
-		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot, mask))
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
+static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	if (!ioremap_pud_enabled())
 		return 0;
@@ -149,9 +147,9 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 	return pud_set_huge(pud, phys_addr, prot);
 }
 
-static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -162,20 +160,19 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 
-		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_PUD_MODIFIED;
 			continue;
 		}
 
-		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot, mask))
+		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
+static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	if (!ioremap_p4d_enabled())
 		return 0;
@@ -195,9 +192,9 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 	return p4d_set_huge(p4d, phys_addr, prot);
 }
 
-static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -208,19 +205,19 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 
-		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_P4D_MODIFIED;
 			continue;
 		}
 
-		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot, mask))
+		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-int ioremap_page_range(unsigned long addr,
-		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+static int vmap_range(unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -235,8 +232,7 @@ int ioremap_page_range(unsigned long addr,
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot,
-					&mask);
+		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, &mask);
 		if (err)
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
@@ -249,6 +245,12 @@ int ioremap_page_range(unsigned long addr,
 	return err;
 }
 
+int ioremap_page_range(unsigned long addr,
+		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+{
+	return vmap_range(addr, end, phys_addr, prot);
+}
+
 #ifdef CONFIG_GENERIC_IOREMAP
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 {
-- 
2.23.0


Return-Path: <linux-arch+bounces-6198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E55951EDA
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 17:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98EF1C22E03
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE971B5806;
	Wed, 14 Aug 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIsNq+CQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BD1B5801;
	Wed, 14 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650278; cv=none; b=oNImJjd8rzuyeM1l4eEGUcnCPlIRMB4EPT+pvUGkTEZUe3BENtwCAyEzGhn3ymKwsyayFWvIIDvzhORqR/ihQf/zjccpGb3KQE8CyopGv+e7m7BsNUP7HNYhNCVYrRoUg6NPXJ7umJ5cT04I5TjxMgyJLNfuA96z+u3UXrH2WS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650278; c=relaxed/simple;
	bh=dxXJQBqbwhkPx8MZ/FHCIGrpxbGyS9S19pPxBnwr5to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGUMjqz4G6iD7+FRidEOpwv57xl0dxzv8eOIzgdFehxTNFKZPMzVaWerB/KJ/u2LfLBjQe1ZyCsMgp4AN5Rl6PGUl/yf3Uy4ySd27R7c80asntvBJ6T+OHDZa68oM6AydD7UNKtkp41z7hd0Ft6Q66oXk6/8YOFc041ZegPEsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dIsNq+CQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=33UCl0Co8i3PNxF7TNO2g0opNXJUnYgo70pV3HV1tcI=; b=dIsNq+CQflIlXtOXmQTqb8pXRY
	oZqzwxIWI5YvxpP4/j2cyaUs/F+SRrHagsggKoL0vGKsexxHrjHORIlOlRnWyWreUtLEU384QLk7G
	9xy/Kq44WGvy3tBpQggevSL4bfHSCSHK+R+SUs/YM7Nq45lxf5DNRTk/qNcXE+6Z4ZtOpYtr7rcUD
	/NZqx1otFZnfV8ukq8ni6hn+tG1lztLatVpBF+aeWCIRciarfr/XjIMiMWU7tm+LCY2pCLlsCstZF
	6gTHeQMb7xlQmbogxzWyxViBZBTk2F5stHLfKgnMSLhKKvWud5/XOuKxAevKTe+B0jdBaHDVIDD/c
	JGh0gQFA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHM-11f1;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 3/5] um: Remove custom definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:23 +0100
Message-ID: <20240814154427.162475-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814154427.162475-1-willy@infradead.org>
References: <20240814154427.162475-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pfn_pte() definitions from the 2level and 3level files to
the generic pgtable.h, move the setting of newprot and newpage bits
into pfn_pte() and delete the custom definition of mk_pte() so that
we use the central definition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/um/include/asm/pgtable-2level.h |  1 -
 arch/um/include/asm/pgtable-3level.h |  9 ---------
 arch/um/include/asm/pgtable.h        | 17 ++++++++++-------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 8256ecc5b919..2be7ba470abb 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -37,7 +37,6 @@ static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 #define pte_pfn(x) phys_to_pfn(pte_val(x))
-#define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
 
 #endif
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 8a5032ec231f..20870be83cfa 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -82,15 +82,6 @@ static inline unsigned long pte_pfn(pte_t pte)
 	return phys_to_pfn(pte_val(pte));
 }
 
-static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
-{
-	pte_t pte;
-	phys_t phys = pfn_to_phys(page_nr);
-
-	pte_set_val(pte, phys, pgprot);
-	return pte;
-}
-
 static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 {
 	return __pmd((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 5bb397b65efb..6ecc4c4ffeab 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -292,13 +292,16 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 #define page_to_phys(page) pfn_to_phys(page_to_pfn(page))
 #define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
-#define mk_pte(page, pgprot) \
-	({ pte_t pte;					\
-							\
-	pte_set_val(pte, page_to_phys(page), (pgprot));	\
-	if (pte_present(pte))				\
-		pte_mknewprot(pte_mknewpage(pte));	\
-	pte;})
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	pte_t pte;
+
+	pte_set_val(pte, pfn * PAGE_SIZE, pgprot);
+	if (pte_present(pte))
+		pte_mknewprot(pte_mknewpage(pte));
+
+	return pte;
+}
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
2.43.0



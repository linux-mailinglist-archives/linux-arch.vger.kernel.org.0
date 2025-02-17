Return-Path: <linux-arch+bounces-10157-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050FA38C18
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBCF3B5223
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3B2376FD;
	Mon, 17 Feb 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YXhaJWKL"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C82376E1;
	Mon, 17 Feb 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819322; cv=none; b=aWDaxIW+WqaL61IleAs1ODE9c2AdGiSuyudxPIadhhQ59ZePba074rF1B/FLrmT1vPd0HYGQ732I9U/hk9yQdVlDMtyUUsAnEi7pMrVUSvzC87kt/aI+phyL/RdEh+6YbnoUKYvfRDZImZUcmML1KxKpKl+M74vsCzRFyZoDMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819322; c=relaxed/simple;
	bh=TMlu7q35x8ePoU/AEfNcaTeRK9ethMI4E4nTTXvpeTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmwy4yzm2wCTKf/XX+gU6HWMPDXBF8Lf2TCbuQIPitqY8BurZv4ayRa6NksPmbGx+/HH/PmX2co9oG0SItzMGKxzb62Xv1ztZSReD5WlBlHe7PIEy7tPX5G/qCbFulA2VN126QN1POublZr5sQa8QJVCvaLZBxmsGKwLUGy5id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YXhaJWKL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=irsUPCJDDf9sWPbOR5tfnHLkyAVI2ujQHmur4Rc6/5I=; b=YXhaJWKLYm+FmviTMlIhMOBmPJ
	PdTTcuf/M3ukyskR8HsQNa9WRzD5eyRz2Y8U5uC+ZBVNLRmB/zBDIZriJnVP4mUqtZLb8CrAPmfbw
	r1jHXZk3tuoSZ+tMoN/W7PZnxDKajMvW+2F7/ap+qB8onNjw2rwB4S3+Zp6LbX9wAkbFZQly0p7Xm
	wKAjrJYQrOzYpalnDopo1OtWgGHqxi0cPxuHXbDMxHMAGmv1cCuh7GpDCZjDsCTfhtqUYInwMM3cN
	oXU4pgZO6LzJ4Pht2G+33kYABnQ6jUlUv6v3ogxyM8XV+Zub6EQJCrLrvMKMbmtFQeZMRgquxNLIC
	NZu0XKhA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tv-00000001pBP-01vp;
	Mon, 17 Feb 2025 19:08:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 5/7] um: Remove custom definition of mk_pte()
Date: Mon, 17 Feb 2025 19:08:32 +0000
Message-ID: <20250217190836.435039-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the pfn_pte() definitions from the 2level and 4level files to the
generic pgtable.h and delete the custom definition of mk_pte() so that
we use the central definition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/um/include/asm/pgtable-2level.h |  1 -
 arch/um/include/asm/pgtable-4level.h |  9 ---------
 arch/um/include/asm/pgtable.h        | 18 ++++++++----------
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index ab0c8dd86564..14ec16f92ce4 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -37,7 +37,6 @@ static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 #define pte_pfn(x) phys_to_pfn(pte_val(x))
-#define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
 
 #endif
diff --git a/arch/um/include/asm/pgtable-4level.h b/arch/um/include/asm/pgtable-4level.h
index 0d279caee93c..7a271b7b83d2 100644
--- a/arch/um/include/asm/pgtable-4level.h
+++ b/arch/um/include/asm/pgtable-4level.h
@@ -102,15 +102,6 @@ static inline unsigned long pte_pfn(pte_t pte)
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
index 5601ca98e8a6..ca2a519d53ab 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -260,19 +260,17 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 	return !((pte_val(pte_a) ^ pte_val(pte_b)) & ~_PAGE_NEEDSYNC);
 }
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-
 #define __virt_to_page(virt) phys_to_page(__pa(virt))
 #define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
-#define mk_pte(page, pgprot) \
-	({ pte_t pte;					\
-							\
-	pte_set_val(pte, page_to_phys(page), (pgprot));	\
-	pte;})
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	pte_t pte;
+
+	pte_set_val(pte, pfn_to_phys(pfn), pgprot);
+
+	return pte;
+}
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
2.47.2



Return-Path: <linux-arch+bounces-10159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145F5A38C0A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667C816DBCB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3826237705;
	Mon, 17 Feb 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yjd8aRGz"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF498237194;
	Mon, 17 Feb 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819322; cv=none; b=IbQTWNMPFVNGXrOAbaBNLsL8SoVxqqM3b+JhGzIgjhvPuoyIOJKLcLZ98EGWKK+aN0wmH1j0vDeFGQPp4LUzBpspdwOefuQqIAlpAJQ1hGtDPFLv7o3rAQSPsIs1GlVvMk62K86GAHJGQF4+DbGhBKhBfAaw8I5a+66pGO/75L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819322; c=relaxed/simple;
	bh=FvUMhsaQhDd2ssuuJoiPAcKveZZ41XpdHDFchAJXbls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqqxxCMU4OJTs750d/oCpEYWLciHt7KKkFOJDxJZIP1863oHCHvfX8/pp4UIHg9Jd+GBuEdz5E2y5xT5EniHPBPFHprX2F6yG/jrRy3COnguNZEM3iNFJhm+aKx//NPgFEYbFD4PgCv+ro3YS3UldfXhogpDcvf+CTTgjEm5xZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yjd8aRGz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=F91J/zBN9mXNlWAyjwC2ekau5s1Hok6GIOYF8L/kjeM=; b=Yjd8aRGz2wgGTd2aQB03xz1svM
	pad6TWhGTet5r5tkDe5SPhvMligYOVpyvs8WL4GxNO3hvIiEeBBIeCu/08/Luori/Y3kOo7Y6a6ls
	g/RoDjqKdMXrQyVKmAGtS1ozR0x2KsU9A2P0tsGgkGZVKEuthTil9oVE1RihJ3Y71jZzs1PKj8FzN
	zpO1z7+a8WFQeCo4AOBmoLja/ks9OdskhNB1xSwp9dHSHwK0Rs8lvQQZ2z21oHVDaiIfYXt6S3ASX
	Lyueov9us25LJavEjIEBNwgmazTmKMGvvc10FWFfHGwQXXr4Qo+EwBPukrmN6+DbyBLrqDZhjxErB
	EbkbBikA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBJ-3kf2;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 4/7] x86: Remove custom definition of mk_pte()
Date: Mon, 17 Feb 2025 19:08:31 +0000
Message-ID: <20250217190836.435039-5-willy@infradead.org>
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

Move the shadow stack check to pfn_pte() which lets us use the common
definition of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/include/asm/pgtable.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 593f10aabd45..9f480bdafd20 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -784,6 +784,9 @@ static inline pgprotval_t check_pgprot(pgprot_t pgprot)
 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
 	phys_addr_t pfn = (phys_addr_t)page_nr << PAGE_SHIFT;
+	/* This bit combination is used to mark shadow stacks */
+	WARN_ON_ONCE((pgprot_val(pgprot) & (_PAGE_DIRTY | _PAGE_RW)) ==
+			_PAGE_DIRTY);
 	pfn ^= protnone_mask(pgprot_val(pgprot));
 	pfn &= PTE_PFN_MASK;
 	return __pte(pfn | check_pgprot(pgprot));
@@ -1080,22 +1083,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  */
 #define pmd_page(pmd)	pfn_to_page(pmd_pfn(pmd))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- *
- * (Currently stuck as a macro because of indirect forward reference
- * to linux/mm.h:page_to_nid())
- */
-#define mk_pte(page, pgprot)						  \
-({									  \
-	pgprot_t __pgprot = pgprot;					  \
-									  \
-	WARN_ON_ONCE((pgprot_val(__pgprot) & (_PAGE_DIRTY | _PAGE_RW)) == \
-		    _PAGE_DIRTY);					  \
-	pfn_pte(page_to_pfn(page), __pgprot);				  \
-})
-
 static inline int pmd_bad(pmd_t pmd)
 {
 	return (pmd_flags(pmd) & ~(_PAGE_USER | _PAGE_ACCESSED)) !=
-- 
2.47.2



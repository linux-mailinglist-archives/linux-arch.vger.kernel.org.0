Return-Path: <linux-arch+bounces-10158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CFA38C09
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7BF1696E3
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B20236455;
	Mon, 17 Feb 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnkS/IDl"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64D2376E2;
	Mon, 17 Feb 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819322; cv=none; b=Brm+fWmon4zPPW9AFDwiAXLf19DTFTXpTT0pcpOvYKMCNJNREZX0n6Q1Ll8J0pO0jXiokwRIFtZFh0cCWzZ1mvJ7S+J0JVV6n//z1en3yx1hp6h20hkn+dvrDq+VxXiJpca21nXDAo8S5TcLrVjSiwCigfQXcimdtUes/S2eJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819322; c=relaxed/simple;
	bh=N6lLtEtD5e3DUSEroe3nxqo3knEOvwGyImZBlGbS06c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jja0JdB0HzBDMYk5Bbl0Ma7ksnMnfJ9dNFZFoLTKuP7Dm/h/W9sd2lfgp8QMT/Yfs04HlPDlJ5P2V1h+BmqjyODggemEGKk2Q3ZtNzsRor+uxoFYWpp6cgRHVtPF8S0n4mjDlTKdryLuJRJri00hqXP58d2Rna2heGlqg5f2rFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QnkS/IDl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=j0C36cwE02tcp83xir3MVAFQIG4vvurnU5t2AtfKn0w=; b=QnkS/IDlpFNbxP+1NPSLKrdsh0
	W3YPFFdUYdE5bv+IkKv1DttNFhjdfeK3JoNCcH2tDcwHkIiWvg/C2a4wH/u3IHTb4YM/lxTlMkakQ
	MgeRGI7FcqDMPeId+YYyjBB4W86R7pZIdHQq7dYEXsK1M2u2KGFAQTokc2mFFTRlaoenqS0bKIjqZ
	aJ6NzWzfDrjw12g+GkzYADGVkGEOfzkaxmBopCBOeVfBtOQq/NWVXjDBWokSfk0bSXo2D78KbAe3A
	Xdwcq0TaABahPOiqCpI7JbV5wN8PwHPqxR0WfXpLKmBzkFD+B3iU+27xyl7mm17JJpUaSP1DZgs8B
	tKN5k9xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBH-3P3E;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 3/7] sparc32: Remove custom definition of mk_pte()
Date: Mon, 17 Feb 2025 19:08:30 +0000
Message-ID: <20250217190836.435039-4-willy@infradead.org>
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

Instead of defining pfn_pte() in terms of mk_pte(), make pfn_pte() the
base implementation.  That lets us use the generic definition of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/sparc/include/asm/pgtable_32.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 62bcafe38b1f..1454ebe91539 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -255,7 +255,11 @@ static inline pte_t pte_mkyoung(pte_t pte)
 }
 
 #define PFN_PTE_SHIFT			(PAGE_SHIFT - 4)
-#define pfn_pte(pfn, prot)		mk_pte(pfn_to_page(pfn), prot)
+
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
+{
+	return __pte((pfn << PFN_PTE_SHIFT) | pgprot_val(pgprot));
+}
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
@@ -272,15 +276,6 @@ static inline unsigned long pte_pfn(pte_t pte)
 
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- */
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	return __pte((page_to_pfn(page) << (PAGE_SHIFT-4)) | pgprot_val(pgprot));
-}
-
 static inline pte_t mk_pte_phys(unsigned long page, pgprot_t pgprot)
 {
 	return __pte(((page) >> 4) | pgprot_val(pgprot));
-- 
2.47.2



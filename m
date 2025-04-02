Return-Path: <linux-arch+bounces-11232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53660A794F5
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A7718927A2
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F91C84AF;
	Wed,  2 Apr 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AGMdqYWW"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297851DB95E
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617840; cv=none; b=QfgoeCJBtFz99PuGjHb+yGz4+YXGYT6z3tb4zr2BfY8qJGgv6PvVV+gBEIot3uSgHHxXmU0HGJn2ATT5avo9OPpFk6dBmLmfcVPEfR9t/B4LtTiSvMVyF0L6zodF8lfHj+INqolcW2qiMP0F3Nm+bxdDiFgorUrcJV5f4z16rWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617840; c=relaxed/simple;
	bh=N6lLtEtD5e3DUSEroe3nxqo3knEOvwGyImZBlGbS06c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcUe26znWebYKzi+SeifkmVxSivsF+jr2LjGzPhzJBaX8OtHNGLnkhxvsuoxuv10nciuh6B8ToCtHgzAg4tXtbHNS4IHSAQNttPB8NEA/3be6SUO+yUzVCyTjqtq7bfOEjc7TMubCjhxcgE+QIWlrK2+veK8tJxT76gH5lMm3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AGMdqYWW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=j0C36cwE02tcp83xir3MVAFQIG4vvurnU5t2AtfKn0w=; b=AGMdqYWWGQSORj9lU/Z8Sy1eH9
	tIHnQDCaBsu30kPuU4g0U+oHAqpw9pYvrGDhW+hJVCo4yCYZTURo4QuY1+owis/vl5TmOvxIiR+oc
	N+v+tMBiZBS3VlUtABggFTeGRqBB//GTNzKGXykjmH+7cA2ti/VMfv/MYKRpfL7cktkEwRIDp+PhN
	CdhSPOZ3gdcLjcYwq79JWFPRrfEndBSzLCrSwod1NGqavu3KNYLNi0bvEaa6+WY5xTnKwDlJXGVe2
	/ld56D9mczQUqaFcYQYBh31qKiO2L0EuFhG2Na2FV580cZ9D6gzfanPPc4yvoXCF/IdcKwWaSWsKF
	e3bbMJMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0iY-0rHI;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 03/11] sparc32: Remove custom definition of mk_pte()
Date: Wed,  2 Apr 2025 19:16:57 +0100
Message-ID: <20250402181709.2386022-4-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402181709.2386022-1-willy@infradead.org>
References: <20250402181709.2386022-1-willy@infradead.org>
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



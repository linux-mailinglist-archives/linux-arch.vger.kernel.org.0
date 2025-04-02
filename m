Return-Path: <linux-arch+bounces-11227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE9BA794ED
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2240216DE69
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E11DB15F;
	Wed,  2 Apr 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mVU4fMKY"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75A1D79A0
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617836; cv=none; b=LhGe8E0+qOkGS310Kt66fR890TTXdQpm09upygm16Lo7IqRp1UbKhggEAt9/V+CDssw5T2SjJ1D4l0nEn6FWQUnXdHfzl98ch4/yJZcY5zSmWaszM4NbtIiUwyTQ4mWC+6ImBQckxNyaG3yfLM7E/h0wsEscF6QyII87SBnMsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617836; c=relaxed/simple;
	bh=KiUulUAJz0QAEuY3fcAdRgnET75IQjpUZmha4kFOjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ7syQIxWJoGHnNscVeA3mi7QiCFHV8CHU9u07OMZxeX+fqT0CWWsGdEVa3GgM0cq2/LR8WEsL6rtFipu/pm/pkh6KubRp7LgARYK3netfjrkBg1b6DAKlbTmw63cg3JcQP1L8wesOVvvM+RsIqMRpXqGVtNHC5qPXgaPdm++kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mVU4fMKY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lQt3ECF7HP7bKw8TGZlgthrOL2Fo1yD9YApfXehCXOA=; b=mVU4fMKYZo4fhGv5FW3wmjkyha
	8dHahroqgFb7sZtNN2N+AHtl+dt2Ff+FfCd4lL+h/tMyoMn/FyLIkwpK2QAI+JxgljprXpxK8nHz9
	SX0gs9Wny+MF7sDRAOxub0bkZea7+as8ouymgZxreUFJ4DiLQPM0KWS+7V4l9z609wCP5icxwhCcY
	0NsLvQq3fRfXgvyeWPA4vT64X6UTn7Xuw32h98DvGzCHe2rRFE+IrmZZyGeDOhDiksLgQvMRTVaRm
	zVBBnin0afWIEBR5+q3BDEE+MC8QytkOMKTHUdxyomgJ2xH3rdz/VUZSDUfoeTNYhFx3z9MeUx7yu
	1qHOeZYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0ia-1FWC;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 04/11] x86: Remove custom definition of mk_pte()
Date: Wed,  2 Apr 2025 19:16:58 +0100
Message-ID: <20250402181709.2386022-5-willy@infradead.org>
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

Move the shadow stack check to pfn_pte() which lets us use the common
definition of mk_pte().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7bd6bd6df4a1..2ce98b547a25 100644
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



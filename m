Return-Path: <linux-arch+bounces-10163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D27DA38C0F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF71F16C107
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5552228CBA;
	Mon, 17 Feb 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VviXey2+"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801423716B;
	Mon, 17 Feb 2025 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819330; cv=none; b=FKPoroWbLy3w6ofyQXsTgJXOWCUPRkz9hmh1m22iMPrHL3WcyuxuAzgFq5fqUH1i02gGbclboVke4f46T9oLVIkPGHFnp7TUeeWmYYqj2XP3OyRHuYg+2maA5MFyA4EEyj21Omjuo88phrcppyvTG1ozY2nLdn/tNeMzFPpTpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819330; c=relaxed/simple;
	bh=p3k7P2FcOpMBcBQksYZOQpetCvUNIZbDu47lFM8WPeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1hG1kcV3l3hQ9yp3mphkL8/rjNTnw1jc0sts//8MTKunP5wtJ7y40YYCbQpuuZKPjRF+0KNXpPF73aA6VUbHyw1+VbLCXVcPZ9agARNbeuWGYt2GGoNENI68kkYlUy1eAqGWCdqTJYaoZ6DAzoI1tjKPHxbL4AE5RVw795Ohew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VviXey2+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DQ8pEjsubtBd0+r7ArW3+Pwnui7gFm3cbKmo8d222fI=; b=VviXey2+gk7RQlHla7fyP62RbI
	TWt5oMDGkBP4sH/ZbqUgWk8bfKkMHOigOck3TrdZiCNDAVRbOYFTGqv5DDvX6UgttQFSlvwPw9TsP
	NLCPz9fidRWT/lWflrucyZKu1lXBP23nJGb0UafoScOJ+2xcIjlAcbGJMsM2zrZXqcmVXIjmeSe70
	VL1w0cEd8G7h/4R9o4P/G74QbYHA+UQJmatysUlnLAXoPic8p1UTx+k06XYAUa5hXp5ikTZ/C8t5t
	ckJWGnG7IdVoN3DVdUN95CMcdnIYHnW+v4WLn46jowGmawC3q3v17uKqvUt3MTrWYlS4Vm4MxDull
	HBNOJXwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tu-00000001pBD-2cvi;
	Mon, 17 Feb 2025 19:08:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Date: Mon, 17 Feb 2025 19:08:28 +0000
Message-ID: <20250217190836.435039-2-willy@infradead.org>
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

If the first access to a folio is a read that is then followed by a
write, we can save a page fault.  s390 implemented this in their
mk_pte() in commit abf09bed3cce ("s390/mm: implement software dirty
bits"), but other architectures can also benefit from this.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/include/asm/pgtable.h | 7 +------
 mm/memory.c                     | 2 ++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3ca5af4cfe43..3ee495b5171e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
-	unsigned long physpage = page_to_phys(page);
-	pte_t __pte = mk_pte_phys(physpage, pgprot);
-
-	if (pte_write(__pte) && PageDirty(page))
-		__pte = pte_mkdirty(__pte);
-	return __pte;
+	return mk_pte_phys(page_to_phys(page), pgprot);
 }
 
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..4330560eee55 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5124,6 +5124,8 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	else if (pte_write(entry) && folio_test_dirty(folio))
+		entry = pte_mkdirty(entry);
 	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
-- 
2.47.2



Return-Path: <linux-arch+bounces-10301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACDAA3F74B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 15:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BD019C605D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C4194AEC;
	Fri, 21 Feb 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3UvakpE"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462F7080D
	for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148270; cv=none; b=AHfQllWX9Wc7dUcf8o2/R0OMFs2+k5YKzaZHrRAopBFilVNQh3y8L8xU0yO8TYtNLIOays96uakS4QRY3kLBA3CTZX0GEmBLpU7aLG3MMb4yZpi6dve3vj4PCwnyb+FjEUyOySUoNZPLYOzHd86qPXiB2qvjcKJ9jv6tNNBWMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148270; c=relaxed/simple;
	bh=kVll+QCYmomDl9UQDCODy6CBFQA7xboK3X8hOFEmO4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1xGWT9GZqBSq7U6vy5cGwKQ0df71It3KG2N10v3tvhNAhqCFqZRMrDynD4Dx+IZrpfBMhi8Xj1e6uF9ueoBSWOZkdahi6FjXdNsBJ4Q5AFICI3N/KZZREQ3zPg9M+WK6ikulhyprzOuwYmjruNOgb5KKviUnJiMRliz6493o74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o3UvakpE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zdGcBGocRVUf83mumdTbIyeWsFhknXwHzV984ys0qcg=; b=o3UvakpEQP967j2RbIBr0H3+96
	qPEz02hALIe/XHBzdPZ7ZRKN0v6N9Y/q6I5QG+AgfHJz9oqp8/07hRViCDTCmb0SdfjwDHphz7SMG
	2QE5X4/BplHfWmHOtP3bRyN/txqRcNRH2iDGGxUIWjZEnrcAV4jYoC4650M/W3mU2QTKHNk7lawIQ
	00hYVVLJjgd1wIBLBFysw2Z1xRy7Q1dJUKBbUylNfELY8/igAf+Sh7HkrJ+n9XaHWKnbHhe1NPv08
	CpViN/SRZeLMTDrjMUwKwn5W5tTa/Yqun1xhEBybjIQAmMTz+tKx4raIW9pCNq2SQQpfKBbjKVa3p
	Et9b3KGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlU3W-0000000DzWS-2Drz;
	Fri, 21 Feb 2025 14:31:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/4] mm: Remove mk_huge_pte()
Date: Fri, 21 Feb 2025 14:30:59 +0000
Message-ID: <20250221143104.3334444-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221143104.3334444-1-willy@infradead.org>
References: <20250221143104.3334444-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only remaining user of mk_huge_pte() is the debug code, so remove
the API and replace its use with pfn_pte() which lets us remove the
conversion to a page first.  We should always call arch_make_huge_pte()
to turn this PTE into a huge PTE before operating on it with
huge_pte_mkdirty() etc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/asm-generic/hugetlb.h |  5 -----
 mm/debug_vm_pgtable.c         | 18 +++++-------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index f42133dae68e..710b77a1e0e8 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -5,11 +5,6 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
-static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
-{
-	return mk_pte(page, pgprot);
-}
-
 static inline unsigned long huge_pte_write(pte_t pte)
 {
 	return pte_write(pte);
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bc748f700a9e..7731b238b534 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -910,26 +910,18 @@ static void __init swap_migration_tests(struct pgtable_debug_args *args)
 #ifdef CONFIG_HUGETLB_PAGE
 static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 {
-	struct page *page;
 	pte_t pte;
 
 	pr_debug("Validating HugeTLB basic\n");
-	/*
-	 * Accessing the page associated with the pfn is safe here,
-	 * as it was previously derived from a real kernel symbol.
-	 */
-	page = pfn_to_page(args->fixed_pmd_pfn);
-	pte = mk_huge_pte(page, args->page_prot);
+	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
+	pte = arch_make_huge_pte(pte, PMD_SHIFT, VM_ACCESS_FLAGS);
 
+#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
+	WARN_ON(!pte_huge(pte));
+#endif
 	WARN_ON(!huge_pte_dirty(huge_pte_mkdirty(pte)));
 	WARN_ON(!huge_pte_write(huge_pte_mkwrite(huge_pte_wrprotect(pte))));
 	WARN_ON(huge_pte_write(huge_pte_wrprotect(huge_pte_mkwrite(pte))));
-
-#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
-
-	WARN_ON(!pte_huge(arch_make_huge_pte(pte, PMD_SHIFT, VM_ACCESS_FLAGS)));
-#endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 }
 #else  /* !CONFIG_HUGETLB_PAGE */
 static void __init hugetlb_basic_tests(struct pgtable_debug_args *args) { }
-- 
2.47.2



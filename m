Return-Path: <linux-arch+bounces-11236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79125A794F4
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F916E02A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF511CBA;
	Wed,  2 Apr 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N5iTz+gB"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F619D8BE
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617853; cv=none; b=XMnTUiDm0TSQmEPQ5xIksHwAYxX/Gz96Vvq3TrC9vbM31/C+x/9/rjWtw36S8mjnJkJFNROObK94A9GEqHv0W0tCEIzjkCXTChMX/mOX4zctknKTzuNL27SKD9h6AOboD8CBkdt0Z13wqzMScCosyA8y25Rv5jIQEFsplzQYEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617853; c=relaxed/simple;
	bh=nqxSI7eeawq3PG9R9cAd2o6G5LFsHEcFeCK/i6Z+Bws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUXFu3nPkMVmiTxldEp+G4Jnhl7sy4UvmSH6tuvtxgRqlSSjCeA5fxWp3C9t6JfZVuZJRTBdzeN04MYoWB9wFfxG6fhpWK/88r31CnUnJYRKsF/QJWfpQJFnEoxDEK+39ZfUNIWC+4Hrf9v5dCvw2+Zfxt6dv08YfZz0upnjN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N5iTz+gB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ryaa6rOT3ubAlWnemzdFbAbwh8PCgJz1kds6GBMukSk=; b=N5iTz+gBXug4FAnm6+9WRrVDV5
	N5OwVI3QLw6iDzLQfZCZcslVW62ZuycySPvBm3xIBto/uwwBx2OhcddV5uJhSMI97jW/ZXpoFqX+X
	VhIZc2A+9E1BWxZu/xIz+KKIdhF+oIqDPteqhpNml00kdtNM4paJfX5OjpT6Bxl12ocBS2sB8Maan
	tiX4bMbTvDEHfx4UysgRjKNgz45cXpVG6NG3nFlzYZbO8L6FNOJIAWtl5btGM0s5mfYpLyc7vUoi8
	0B1K0CNi/pLXeBxMKLXOTZ9Uq4FUZPzmHQxkp76p+HEkeyjC8ZwYtsp+tLgP3x/YoQYk/ou8RpykR
	hA2Yk0Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0ik-347A;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 09/11] mm: Remove mk_huge_pte()
Date: Wed,  2 Apr 2025 19:17:03 +0100
Message-ID: <20250402181709.2386022-10-willy@infradead.org>
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
index 2afc95bf1655..3e0a8fe9b108 100644
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



Return-Path: <linux-arch+bounces-6201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592F951EDF
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 17:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991631C22D1F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA8D1B5838;
	Wed, 14 Aug 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHUARuZI"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77181B580C;
	Wed, 14 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650278; cv=none; b=Mbv2qkySw+GKxC5F455aC9NOIarjLtR33bCJsaK4sX5PaTais1R+F1tGUzOvcSueSEeeKLDzRj11dujBJMimUsOi1/tVADv16KsRKobbwhIPdx2GMgHMW4csLjfNEYN9E9FfA9p5bSgSo0/hzVcledP/6YatnNAytXcYIlwBmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650278; c=relaxed/simple;
	bh=Oeqy5cdGRTPrbwIISUZ+NUUpzgU4uP+YE9v3VdANxwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOcHWfvXdWWXPgdYVzmPXbCp/h5iQKVtx42mjsWBhKHcB8BLROi6jidwlAKnAAAptq1ffHuqu3zS/k9Y8qYN3nc1lMH3SxZGvMUyR0acWHkmkPgU8AswIY4XWdn3uQa7zIrvRgoep51r71a0/ZmcIgw8gooc/Op5gTOOOTaIpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eHUARuZI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RiQi1xwu7xn6bnJpfQHAtVQLm2/6ihErCEfVj9tkBvo=; b=eHUARuZI/k2Siw5xMucTFO1tFs
	05neo4SYQKbnin4Egz7zuBogKPG7eGd9qUe7d4gppGr4IWqI61e9aBFE0AMunOrIKk369OGVndms1
	9RaI4Kvd8Hw6ZxPySlCYJ9s5YkPUOWlsq11SKMfD40O2Q9Ik/HDtitTLPVqcHmFnclYyvmjKD+7Ct
	oF+1Ux/f0lDn/OUtQAziz0DQupDEF0WHKsIVzAN5EUjXqCZhBKwAr1Oqn2ubs+PYN6cGLQYDKbgha
	LK0VRLXkQXOb7gRUbIOhFqZMEhlXSt6QSbUkVgKguotrrcms4P06UNwWnMMeMAk8rfvoAYzYdVEN1
	1vZAwaZw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHU-1YgC;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 4/5] s390: Remove custom definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:24 +0100
Message-ID: <20240814154427.162475-5-willy@infradead.org>
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

I believe the test for PageDirty() is no longer needed.  The
commit adding it was abf09bed3cce with the rationale that this
avoided faults for tmpfs and shmem pages.  shmem does not mark
newly allocated folios as dirty since 2016 (commit 75edd345e8ed)
so this test has been ineffective since then.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/include/asm/pgtable.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 6a21d947a687..1bb7f33394d0 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1413,17 +1413,6 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 	return pte_mkyoung(__pte);
 }
 
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
-{
-	unsigned long physpage = page_to_phys(page);
-	pte_t __pte = mk_pte_phys(physpage, pgprot);
-
-	if (pte_write(__pte) && PageDirty(page))
-		__pte = pte_mkdirty(__pte);
-	return __pte;
-}
-#define mk_pte mk_pte
-
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 #define p4d_index(address) (((address) >> P4D_SHIFT) & (PTRS_PER_P4D-1))
 #define pud_index(address) (((address) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-- 
2.43.0



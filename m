Return-Path: <linux-arch+bounces-4170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4A8BB028
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 17:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F57E1F236A3
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87A4F605;
	Fri,  3 May 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC5UMjqB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CC1BF24;
	Fri,  3 May 2024 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750899; cv=none; b=MTmm+pWnuLR71QAUgvxlHavM49vL3D1DDdfOvemsQv6JySgmuXtu5khDi4KJo16wne3fGrBD1CWj7uZ1tmJLI60DSzB7ts7e9Eo7zysKeCU4SS8i18l51zFXyoPwDK5t3KXfIBwlKgwvQySIHvnMWUHsDLRzV2D0EXpFehdZQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750899; c=relaxed/simple;
	bh=NXDwdw0s6ey0Tqc/WOg49E6dFyaj1/dtGK5jv81gJAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbPoueY/G0j5aT/Fqd/ZDs57rEnkp6ipAIwNZrCh4BCt/eQidul7LoBP+AK5EhzmryKzaCHQxBizhlmNa3FnwWs1a7/Pj+RphdHWLGrIdT55gRFJV4YI+0jlDUqCeQ5lnqagRmNsUkueStY5pqEOwM0WW3xRGfE/weaGza2OQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC5UMjqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCDAC116B1;
	Fri,  3 May 2024 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714750899;
	bh=NXDwdw0s6ey0Tqc/WOg49E6dFyaj1/dtGK5jv81gJAY=;
	h=From:To:Cc:Subject:Date:From;
	b=HC5UMjqBNrG11LoYvGJUxh6V0s85FOxUe/fb0Pe5Q6TMksVNwg7o07RwKIT8yNDEX
	 qaymiHGHVC3r/rJpRlJPu/xPYKAlbzGXympjNkzbLWLMEpj3Kg3PZ6YR4OXP1kk0QV
	 WewEr2pSwUSP4308/K/YCgPreUZoBzk4Is6l0eTV6Jqz3g5xpbDWI6dTJYqSbT41u4
	 OHZ06hCoBNYqdOMhbyAynYoCVqmx9sF6YGjZ1xRSxsk54WfhSq0BnWAJRsQa9/IEOj
	 u7nRn+5dvlt4WttYbtalhsa0LKA5K31ChMFvoScSnDeVNmOBcdJZDbNKyyHgXlDVKc
	 uZh4mcdlRaTjQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic: remove unused asm-generic/page.h
Date: Fri,  3 May 2024 17:41:26 +0200
Message-Id: <20240503154135.385642-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This file was used by c6x and blackfin in the past, but no architecture uses
it any more, and it is only useful for architectures that do not support
an MMU in the first place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/page.h | 103 -------------------------------------
 1 file changed, 103 deletions(-)
 delete mode 100644 include/asm-generic/page.h

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
deleted file mode 100644
index 9773582fd96e..000000000000
--- a/include/asm-generic/page.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_PAGE_H
-#define __ASM_GENERIC_PAGE_H
-/*
- * Generic page.h implementation, for NOMMU architectures.
- * This provides the dummy definitions for the memory management.
- */
-
-#ifdef CONFIG_MMU
-#error need to provide a real asm/page.h
-#endif
-
-
-/* PAGE_SHIFT determines the page size */
-
-#define PAGE_SHIFT	12
-#ifdef __ASSEMBLY__
-#define PAGE_SIZE	(1 << PAGE_SHIFT)
-#else
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
-#endif
-#define PAGE_MASK	(~(PAGE_SIZE-1))
-
-#include <asm/setup.h>
-
-#ifndef __ASSEMBLY__
-
-#define clear_page(page)	memset((page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
-
-#define clear_user_page(page, vaddr, pg)	clear_page(page)
-#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
-
-/*
- * These are used to make use of C type-checking..
- */
-typedef struct {
-	unsigned long pte;
-} pte_t;
-typedef struct {
-	unsigned long pmd[16];
-} pmd_t;
-typedef struct {
-	unsigned long pgd;
-} pgd_t;
-typedef struct {
-	unsigned long pgprot;
-} pgprot_t;
-typedef struct page *pgtable_t;
-
-#define pte_val(x)	((x).pte)
-#define pmd_val(x)	((&x)->pmd[0])
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
-
-#define __pte(x)	((pte_t) { (x) } )
-#define __pmd(x)	((pmd_t) { (x) } )
-#define __pgd(x)	((pgd_t) { (x) } )
-#define __pgprot(x)	((pgprot_t) { (x) } )
-
-extern unsigned long memory_start;
-extern unsigned long memory_end;
-
-#endif /* !__ASSEMBLY__ */
-
-#define PAGE_OFFSET		(0)
-
-#ifndef ARCH_PFN_OFFSET
-#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
-#endif
-
-#ifndef __ASSEMBLY__
-
-#define __va(x) ((void *)((unsigned long) (x)))
-#define __pa(x) ((unsigned long) (x))
-
-static inline unsigned long virt_to_pfn(const void *kaddr)
-{
-	return __pa(kaddr) >> PAGE_SHIFT;
-}
-#define virt_to_pfn virt_to_pfn
-static inline void *pfn_to_virt(unsigned long pfn)
-{
-	return __va(pfn) << PAGE_SHIFT;
-}
-#define pfn_to_virt pfn_to_virt
-
-#define virt_to_page(addr)	pfn_to_page(virt_to_pfn(addr))
-#define page_to_virt(page)	pfn_to_virt(page_to_pfn(page))
-
-#ifndef page_to_phys
-#define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
-#endif
-
-#define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
-				((void *)(kaddr) < (void *)memory_end))
-
-#endif /* __ASSEMBLY__ */
-
-#include <asm-generic/memory_model.h>
-#include <asm-generic/getorder.h>
-
-#endif /* __ASM_GENERIC_PAGE_H */
-- 
2.39.2



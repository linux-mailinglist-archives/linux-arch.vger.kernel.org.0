Return-Path: <linux-arch+bounces-10156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B12A38C16
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BFD3B51E2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65C2376FC;
	Mon, 17 Feb 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="thrH97rg"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5252376E0;
	Mon, 17 Feb 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819322; cv=none; b=Mv7pA0AB5mC5PkwCGqAgTmBK+RjkJlPWZTG7v/3Wygwp615lZseYwBdNFTRh5ZX8hIf9L9dZZkd82t4oROa7SKJeebYjR5lTCIQipOI6lzEgkn5erdPKI0VOJqq8+kb0UJwKMbSPMWgaBSlM07kbC1jfCzy3Xq97vspoKTV/0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819322; c=relaxed/simple;
	bh=LPpP5moBq1x1B8T44YYF74TxHRr/1vdCj8Jq2sELHVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0kQz6aokTyCzb9F17eWBMxDOET5lmmcaut4+OBG80XVe8Ab8YA5kbHdS/oARSBHTMKb8UU5LsDi66f0xZefHHP0OJxAFlBxvA8vVjFKWLyUjEdPSMn0B27EnyFK5RXcjeFXRgSzSVUhcl/z89xaMmDBlC891nWG5d9UK4cFi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=thrH97rg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=atMZRm9oTSJ7EdJlQ3h7iJvkLCf12vGPXz2zKSkO6zo=; b=thrH97rgQk5cY6SsCjZalRSn93
	HEQL4Fk+SimS8m8tDxDCmy2Unz81Dre8AePAFchB1p5SNzijFyHibJ6leOgVkq7ydpyDSd1Hm5diu
	lFGZZqXQR5j2Tf4MB9wann/BnSax/OOuva/9PjoPPkSnezTUoKZpBEA/tIukuYEAm9AD5qRyIh4lW
	Y1jjuvk2H/pOVPtbROx5QUrqcuMMBMlVw5lALGiInZjC638qVSFtxWjFoKxtL2gYFsWl3fdFPcDEh
	IaffNaod96rCTnh7P8Ih+8Zbq/i1e1Ux3LterFamX4KVy9Th0HjUymOZL87+i9HUhimY9zJy/brrk
	4dPWDbnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6Tv-00000001pBc-0Zy7;
	Mon, 17 Feb 2025 19:08:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH 6/7] mm: Make mk_pte() definition unconditional
Date: Mon, 17 Feb 2025 19:08:33 +0000
Message-ID: <20250217190836.435039-7-willy@infradead.org>
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

All architectures now use the common mk_pte() definition, so we
can remove the condition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3ef11ff3922f..62dccde9c561 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1916,14 +1916,12 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
-#ifndef mk_pte
 #ifdef CONFIG_MMU
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
 #endif
-#endif
 
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
-- 
2.47.2



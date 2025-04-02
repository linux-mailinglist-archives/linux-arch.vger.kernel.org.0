Return-Path: <linux-arch+bounces-11234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D39A794F6
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DCA1892F79
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A41A316B;
	Wed,  2 Apr 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4mVtz/r"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01719E826
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617846; cv=none; b=IAURTQMi6HCCAQmOb3fOkd8NmaP6mZg275K+9vv9Utkxk1aux+4f+XRvtnXUa/evuNezyMGXKibxiTLy9TkL56WkTbnHTSUXrtLiH+A5g25ZCOmS+8DKsU3Ny1J7eEKD1OasoR9txFLHjBP9fgizS1aC/0XhumAWhuAi/HSkEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617846; c=relaxed/simple;
	bh=pH7jFs25RC7evnn0RxnErf/Wnd3An0o63vKEk4Iqv/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqpLA3R8VVpLElOGy1A/JcLN4yp0feQhBUWM+a2SxmuE0hnLsW70gd/pXGcOB7XfowavgN5CvpWweLlD89qMiokpP8cgkBek4C+FPDLIPz1pCQR/etzZZH11eM8wHFhTyznyezrqL6E7SOd289kM/p4p5FI1nKnQXBrbDskLo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A4mVtz/r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1R/HHCzGcwjg+fBXbbAq3H5FDI7HZRKgEBZ7xd5xOnk=; b=A4mVtz/rbieK66CYPTXQ2f2CIZ
	uWjFJipDitx7TfiRyvzMSpRtcElQyboe3flkofx0qSYFgFKXlH3FF3QGRMAHjw64A0MlPmh+WPYaD
	cEbjJNyGR3JP6P/0XT412dtDt1skwUnhFCu4kiHeuLNg2qvrhkSNe2c9XybdpbfU3JWLAS42SwoC0
	NZQthenBY1B2DTuXQn+LEZw50bKmccoKAlu59MKPRqOH44YXDz2mp0G87vJJB6sKIgDgkcDzNfodN
	nRsxRBNQZNkGuYCUk/TU/gJx45KbMgv373+YEdJN7AOiqPynm37z/17jXE9k1iAtQqkaVtRywdXfm
	+i/NJPyA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eF-0000000A0ie-22tt;
	Wed, 02 Apr 2025 18:17:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 06/11] mm: Make mk_pte() definition unconditional
Date: Wed,  2 Apr 2025 19:17:00 +0100
Message-ID: <20250402181709.2386022-7-willy@infradead.org>
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

All architectures now use the common mk_pte() definition, so we
can remove the condition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2bdfd7afb1b..5dc097b5d646 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1987,14 +1987,12 @@ static inline struct folio *pfn_folio(unsigned long pfn)
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
 
 static inline bool folio_has_pincount(const struct folio *folio)
 {
-- 
2.47.2



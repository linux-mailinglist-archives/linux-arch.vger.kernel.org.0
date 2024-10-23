Return-Path: <linux-arch+bounces-8438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2429ABE10
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 07:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC13284A0F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 05:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADB14A0B5;
	Wed, 23 Oct 2024 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h3p8AkRX"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB90149E09;
	Wed, 23 Oct 2024 05:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661815; cv=none; b=s2jJsoSCCXOIdBRyZi0SzBxFY7o1GpYnJPrkTU4IjgVEFXlklssW+3egxYsSlCX1VMHO62Y5qr+muyemV5ID1H+XuHDgOBfzuKG6MuEG6EATM65bepdR1ndQjGto1P/2MiXeMA8DAeMlNX9cq4lHdS061k0YCjSn3MwRONRnjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661815; c=relaxed/simple;
	bh=ClvX9P0YomXUmyBHowrG7BxBjln1Yzy53NGFXrXeMOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL0XVyjSTLguf4px08v6b6Q9AwEMdTAUzEKqBtojs1y9z6E1nBqkpZfP7VIri7ckmRi3zE08yqN5/gY5DQ8g9J01fivOZHQNPa4FaFndTdDTPkhbry6euOoPgc0K5dd0NlQC58wwmoPBqshG0jiibRofRPpVq0LOcGWw2dCz1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h3p8AkRX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pMVglSrzfw659uFTl63Kmjtp2oxz/obCT3ExoMvUsd0=; b=h3p8AkRXGihxrDLi0oq5AhmjrT
	sTISKsZ7wx8jV9O21Ahj8jdqo90qdhmRBhAZz6XhMrq1rXwehioiPD6gl5siWuIOERts7rl0d6BoC
	3RXx6Ufopbo8/Ijiz2CMgtPiWHqU9iDJBhboPe53eyEGZezeZeQr+LrYePax3DOdL5SmXQOPwk7tK
	4JCXJSs0b2T4XEPEy9UvFFL59NVLAw9aBC9j8arBo/tX4fX+Qev54AaYCEE2jWENLGxtGguKSu9Cd
	uqSZBqpqJY7atLAmszcql9T2iUE9VUXqWmY35nWH5Ppdmsc8z7fVK9ofvS2xayhi0AEqU/zp51pos
	/x8WzO4A==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3U3A-0000000D4L4-25Zx;
	Wed, 23 Oct 2024 05:36:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/2] asm-generic: add an optional pfn_valid check to page_to_phys
Date: Wed, 23 Oct 2024 07:36:37 +0200
Message-ID: <20241023053644.311692-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023053644.311692-1-hch@lst.de>
References: <20241023053644.311692-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

page_to_pfn is usually implemented by pointer arithmetics on the memory
map, which means that bogus input can lead to even more bogus output.

Powerpc had a pfn_valid check on the intermediate pfn in the page_to_phys
implementation when CONFIG_DEBUG_VIRTUAL is defined, which seems
generally useful, so add that to the generic version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/memory_model.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index a73a140cbecd..6d1fb6162ac1 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -64,7 +64,17 @@ static inline int pfn_valid(unsigned long pfn)
 #define page_to_pfn __page_to_pfn
 #define pfn_to_page __pfn_to_page
 
+#ifdef CONFIG_DEBUG_VIRTUAL
+#define page_to_phys(page)						\
+({									\
+	unsigned long __pfn = page_to_pfn(page);			\
+									\
+	WARN_ON_ONCE(!pfn_valid(__pfn));				\
+	PFN_PHYS(__pfn);						\
+})
+#else
 #define page_to_phys(page)	PFN_PHYS(page_to_pfn(page))
+#endif /* CONFIG_DEBUG_VIRTUAL */
 #define phys_to_page(phys)	pfn_to_page(PHYS_PFN(phys))
 
 #endif /* __ASSEMBLY__ */
-- 
2.45.2



Return-Path: <linux-arch+bounces-959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCAB81091C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 05:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11712818B2
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 04:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30414660EC;
	Wed, 13 Dec 2023 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fY9UFcRb"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A67AC;
	Tue, 12 Dec 2023 20:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3zU9qWCg0noGR4z5kjUevqgcV3l4ea81bsNQeNCgnKI=; b=fY9UFcRbBEqeM3Op5saC6LJCof
	Cepvl1xAzVKC2SZhPrbOeKAYl7OTb9zd2qVJIWXpPgTpMU2JP/jmWVPyCZs9EDW2T3YO/S0S+ngq1
	HsBvdfR/dnZq8SlPn6QZe83UCGsWBTaxWzy3RfUh6upreoet0m/mL/lT2h7ZjWX6x/vh07K1K7FbT
	3IKCMITH3cD5DAQNuI9AgUyeuxm/qgiuWpXrSPjZZeoBUXK33jN669oZ2W3hCXbKKgX/UOjkzPr5W
	Ih75xbhD47fUtKiJ4iQIaptomk4D6nIpC7CzEygBOGpT+k4M5kYGb+uU4qostqcKP/HhFdcQPRyUF
	AfBukSWQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDGtA-00Da4K-0C;
	Wed, 13 Dec 2023 04:30:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic/io.h: fix grammar typos
Date: Tue, 12 Dec 2023 20:30:27 -0800
Message-ID: <20231213043027.9884-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct grammar mistakes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/asm-generic/io.h b/include/asm-generic/io.h
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1019,12 +1019,12 @@ static inline void *phys_to_virt(unsigne
  *
  * Architectures with an MMU are expected to provide ioremap() and iounmap()
  * themselves or rely on GENERIC_IOREMAP.  For NOMMU architectures we provide
- * a default nop-op implementation that expect that the physical address used
+ * a default nop-op implementation that expects that the physical addresses used
  * for MMIO are already marked as uncached, and can be used as kernel virtual
  * addresses.
  *
  * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
- * for specific drivers if the architecture choses to implement them.  If they
+ * for specific drivers if the architecture chooses to implement them.  If they
  * are not implemented we fall back to plain ioremap. Conversely, ioremap_np()
  * can provide stricter non-posted write semantics if the architecture
  * implements them.


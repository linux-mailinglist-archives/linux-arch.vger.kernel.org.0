Return-Path: <linux-arch+bounces-6202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB3951EE2
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF951C21B71
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F791B5824;
	Wed, 14 Aug 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nlp68Wv4"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024531B582B;
	Wed, 14 Aug 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650278; cv=none; b=uj23HwJMDowyIvLJWWV6RN6yWh4b/h3GdROMBgCHO8XTVNhVFCbN20Usd6uMFZ2NA43nnvFg0I8E2hOaqylBunbt6WWP0weJw8Ir5LOCwp0BAFZAd31w0r77sWAxwwiGOHt1U8OdEKuALj/f587kPKLkV7B2/tKmu3+1G/xQmPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650278; c=relaxed/simple;
	bh=U7WuHYR57mLXTPaEpqW6Wd2ZQf59JaIgOYyS+tdv5xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAw4KtLV8kS69IFmow5Mf6Nh5tCWHOeAyG588t6zHfKr9yB4bmqx6e14jy0Rqtx9qAJINT6ru++kwzYEmcx3pNt3HAU6EqPvWr7J3P6XchW5i36ummUx1KNyc+KbibxyhRl97AjMgKGcyGY3CaspNM75MdomRHMTSjlo8Inn39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nlp68Wv4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Y8GzTtU2QoStw/WgTavIsPk3vntaV6mcfxUlw+vTkw4=; b=Nlp68Wv4gWlG8g9amXu9RSnoTE
	bGIkORrON8YDkyXuNB3pHR0x3EWS8Cj46g5V0nmkoNra8NLu3eoLcdQDcSfXtQUcNoQv73JbO5irY
	YO/2KtHV5uYXpcKre5wKy5/4Hv3pAdgjf5CgBoylTiilTIclax+k/Y1qqeGMWDIu25oBopw+ZSuo/
	+PbCg3gzutTroTrptbNhWjqMZBqJlVGdigr+h7eL9Gwfxuq3uaXQEiYu6lJesN6VHloOF2NJxcVQ5
	g8Bi5zp2BmmvlEC8p4EYP5Qf2CZacyuv2wEMcW0vqzDern12I/bCWq9yZIfLqu4qinNlF3KSoMUbe
	DgnzBqVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAr-00000000gH2-3gSE;
	Wed, 14 Aug 2024 15:44:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 0/5] Provide a single definition of mk_pte()
Date: Wed, 14 Aug 2024 16:44:20 +0100
Message-ID: <20240814154427.162475-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each architecturee must provide a definition of mk_pte() today.  They must
also provide pfn_pte().  Usually the former is defined in terms of the
latter, but not on some architectures.  I was trying to decide what we
should do for creating PTEs in a folio world, and it struck me that we
should have architectures only provide pfn_pte() and then I don't need
to trouble the arch maintainers with whatever MM API I come up with.

The architectures not on the cc list I considered trivial.  The
architectures who have named patches are less trivial, and I did my
best to write a decent commit message explaining why I did what I did
to each architecture.

I have some followup patches which remove folio->page conversions, but
if this set of patches are wrong on any architecture, then they'll also
be wrong, so I'm not sending them right now.

Matthew Wilcox (Oracle) (5):
  mm: Introduce a common definition of mk_pte()
  x86: Remove custom definition of mk_pte()
  um: Remove custom definition of mk_pte()
  s390: Remove custom definition of mk_pte()
  mm: Make mk_pte() definition unconditional

 arch/alpha/include/asm/pgtable.h         |  7 -------
 arch/arc/include/asm/pgtable-levels.h    |  1 -
 arch/arm/include/asm/pgtable.h           |  1 -
 arch/arm64/include/asm/pgtable.h         |  6 ------
 arch/csky/include/asm/pgtable.h          |  5 -----
 arch/hexagon/include/asm/pgtable.h       |  3 ---
 arch/loongarch/include/asm/pgtable.h     |  6 ------
 arch/m68k/include/asm/mcf_pgtable.h      |  6 ------
 arch/m68k/include/asm/motorola_pgtable.h |  6 ------
 arch/m68k/include/asm/sun3_pgtable.h     |  6 ------
 arch/microblaze/include/asm/pgtable.h    |  8 --------
 arch/mips/include/asm/pgtable.h          |  6 ------
 arch/nios2/include/asm/pgtable.h         |  6 ------
 arch/openrisc/include/asm/pgtable.h      |  2 --
 arch/parisc/include/asm/pgtable.h        |  2 --
 arch/powerpc/include/asm/pgtable.h       |  1 -
 arch/riscv/include/asm/pgtable.h         |  2 --
 arch/s390/include/asm/pgtable.h          | 10 ----------
 arch/sh/include/asm/pgtable_32.h         |  8 --------
 arch/sparc/include/asm/pgtable_32.h      |  9 ++-------
 arch/sparc/include/asm/pgtable_64.h      |  1 -
 arch/um/include/asm/pgtable-2level.h     |  1 -
 arch/um/include/asm/pgtable-3level.h     |  9 ---------
 arch/um/include/asm/pgtable.h            | 17 ++++++++++-------
 arch/x86/include/asm/pgtable.h           | 19 +++----------------
 arch/xtensa/include/asm/pgtable.h        |  1 -
 include/linux/pgtable.h                  |  5 +++++
 27 files changed, 20 insertions(+), 134 deletions(-)

-- 
2.43.0



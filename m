Return-Path: <linux-arch+bounces-8436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D609ABDEF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 07:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02594284489
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 05:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433CF13D8B0;
	Wed, 23 Oct 2024 05:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e3yKJui3"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8E20323;
	Wed, 23 Oct 2024 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661810; cv=none; b=WXm+XzVgq1WHtMhe/z9UCSYR/dOgC64z8kzAVySfy7ANjhfIR7QBibyQ8Q45TFMMNWxNnQpM++e/WPLEYhbYKJ+OlMRDajKWp/sEtVIkvTybbag/tNnaRrCkhgq/mL8RXVsqR+eM21ZZAxUZxmvYDVUkMRqkP/0NZ3wWCoonRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661810; c=relaxed/simple;
	bh=yyqjrNra2qrWk/SlCt8CsJRxIaNpgya75gxtX8qBAdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqSddQ+vg3a1tbXKgGnJSmYLFQ7MQTkNa6OfDUEeAS9JtH49EQIZXKXAs5FlB9z6zhfp8v6EmpDdWbtq+tIerOcSd/51z6CKa+h4c66E99fDu9Akjb8M1UhrRxw3sp4XctqbwOxUG+BE3hxwLcBaA/6NlYmxV+Y3dJmojq7HkCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e3yKJui3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fLRpNAyXDIDQIA7HSndcO831t3mGv6BkJWEZG/+8nHM=; b=e3yKJui3E1F31NYxpyaXDU9W7H
	+UGx5mo0sIV2J4IRe3S0lKmAIwjnMnBQslhfMHmdi/AtNvCPQq8jOwp/ruOtXaFiw4c3pJcP7Slky
	PbaGDyP3HGNONuiaY/ACmdbI+BgedQmkkMQaSH4AioQhoJ7QRjxFz7MjTi/c01vFbTn9sHdxiMohI
	6JbxnMeER1pWyG8JXPtFYAEvUzIpMbKe30FHv1KAJDyxneeYpqjBh8LWHkoC5Ijd6IeGCCS15Sz8z
	Nj2X7+iDJITPMDsaPbrq7AWNeuDcMxHMRhSoEw7840C58hpQ3F3tqw//Ij4z5zduWot2M0oEg5VbW
	cuU3mdNA==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3U34-0000000D4Ir-2Mk1;
	Wed, 23 Oct 2024 05:36:47 +0000
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
Subject: provide generic page_to_phys and phys_to_page implementations v3
Date: Wed, 23 Oct 2024 07:36:35 +0200
Message-ID: <20241023053644.311692-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

page_to_phys is duplicated by all architectures, and from some strange
reason placed in <asm/io.h> where it doesn't fit at all.  

phys_to_page is only provided by a few architectures despite having a lot 
of open coded users.

Provide generic versions in <asm-generic/memory_model.h> to make these
helpers more easily usable.

Changes since v2:
 - spelling fixes

Changes since v1:
 - use slightly less nested macros
 - port a debug check from the old powerpc version to the generic code

Diffstat:
 arch/alpha/include/asm/io.h         |    1 -
 arch/arc/include/asm/io.h           |    3 ---
 arch/arm/include/asm/memory.h       |    6 ------
 arch/arm64/include/asm/memory.h     |    6 ------
 arch/csky/include/asm/page.h        |    3 ---
 arch/hexagon/include/asm/page.h     |    6 ------
 arch/loongarch/include/asm/page.h   |    3 ---
 arch/m68k/include/asm/virtconvert.h |    3 ---
 arch/microblaze/include/asm/page.h  |    1 -
 arch/mips/include/asm/io.h          |    5 -----
 arch/nios2/include/asm/io.h         |    3 ---
 arch/openrisc/include/asm/page.h    |    2 --
 arch/parisc/include/asm/page.h      |    1 -
 arch/powerpc/include/asm/io.h       |   12 ------------
 arch/riscv/include/asm/page.h       |    3 ---
 arch/s390/include/asm/page.h        |    2 --
 arch/sh/include/asm/page.h          |    1 -
 arch/sparc/include/asm/page.h       |    2 --
 arch/um/include/asm/pgtable.h       |    2 --
 arch/x86/include/asm/io.h           |    5 -----
 arch/xtensa/include/asm/page.h      |    1 -
 include/asm-generic/memory_model.h  |   13 +++++++++++++
 22 files changed, 13 insertions(+), 71 deletions(-)


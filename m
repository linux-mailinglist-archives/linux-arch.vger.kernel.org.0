Return-Path: <linux-arch+bounces-7904-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD7996908
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7801C22FEE
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 11:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945511922DA;
	Wed,  9 Oct 2024 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2+yJsVy9"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618718FC83;
	Wed,  9 Oct 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474220; cv=none; b=idoJnBWB/L1mswfrSjdaNA32vmTmlpB9o/9tZTyQ2XWKIXc1xgMgY8cSLPSv2kyZKTOMU+8hU7xem5H+zY5qPSFW57vlX2G+FhZwpyRszPiGpQapyu0IN1kHxxKEqqVNp14lh3w0TTembtAPu011j1pvoWjZU/bFj+A1uke6F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474220; c=relaxed/simple;
	bh=GiKm2C7tdhc3dZ/L+F0NUN76VQ7J4IRQ3C3VO5kmDzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qe4hbJnfY1RMtCcxTu6RrrAL0r87YNNhAJzop+wgqxbKugRzzyAdn7a0fcRCy0NBmfcEsObOKiwb3Fk/eS76bj6R2Ve8pw9C552FsqKrk/EoBI3HkYN4Dz/Fqv2EVvybE4+gCyMDZm1uzPD9UJD4Ecpv7eAzLf5RxfS9F/U3iJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2+yJsVy9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kWHm4EzhmcRIg2+TkegJgMDV+hPGEBlUxndw3Jlx9rs=; b=2+yJsVy9LAMPiwBw1DaQUCVfFe
	QyJY3aXFefdtcO1fkvZGljTkLYposSgsM7AZReMFMa5vMMuXMOgGVdcU9zQdIJwBYrbb16tnCmCtE
	vNOARAY2QdRbLhLzwCmJJITCkzHE+z2s4LxbFJLnQnz72E/EgOytYrBCmqGlXUueTH43Zvn3iwPd5
	vtEkG0pez/ZHGQMmeP+HFbbWklO8Hx4jhRbB8X2oYTSaDFCiFaZqmXPSiknGB7DisHeJxUIdziTnh
	aK+QEe9gB1/Npt1KOI0PymNgFjaI09mZBm6jnkU8fF5L/BXNREkq5Tt9t1WB+iiUWzLTi/2D6PVUw
	TOOwM4Jg==;
Received: from 2a02-8389-2341-5b80-164d-fdb4-bac5-9f5e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:164d:fdb4:bac5:9f5e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syV6O-000000095ov-1DQp;
	Wed, 09 Oct 2024 11:43:36 +0000
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
Subject: provide generic page_to_phys and phys_to_page implementations
Date: Wed,  9 Oct 2024 13:43:21 +0200
Message-ID: <20241009114334.558004-1-hch@lst.de>
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
 include/asm-generic/memory_model.h  |    3 +++
 22 files changed, 3 insertions(+), 71 deletions(-)


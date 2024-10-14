Return-Path: <linux-arch+bounces-8087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC699CEA0
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE01F23B71
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A344C77;
	Mon, 14 Oct 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zjgp4OV1"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0384087C;
	Mon, 14 Oct 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917116; cv=none; b=j3sk3L/ZC/WgE2cNTnmVGF/aq3cg2TLUNtqmPq8BKtKOIevpVuBOvbexacUat5d/GwqwCB5NHndJdcdO6wDRqH+x+SqV7cbowGhs3JoztlordK3xDchtIHjoIO/7AUKQ6bwij1IiG09q+U6zZwfVimHgk8AYLtk1PKfRCg0okkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917116; c=relaxed/simple;
	bh=USf3mOjcc4EbkfsF8JFSgG2+R6s4sBCB/bgd7X09PNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/RhKmt4hAoZS/zexl7D1Q6/Da9QsTGCKvZo0vZtjKODiLgMFSBKl1Lrk0Gj6EQd6zzaIUDMs/gGhUsaZXGkKcnV+pn3iwaxJ501+dKjvVx63hCwlz8sSvntYls6kkHCIQB1KXXiS7o4H4USu5f66Sgw4067XHYFOcDeePyrgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zjgp4OV1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JoE9ZLXQHasCpAyzCryklYyAUInrPL5J/td+VUG8jMM=; b=zjgp4OV182malEVjeuLfhFAUAR
	xmTaQT0HuCKSDx2IeDd/JBjTrHhqfkl+Szn05qpqjKrNvmUj8/JaHpK4FQPUoWvdby2QX+YDppFJa
	fnVcfeymjbZ+yecTEh2dm6XsNLVzI5ocOjktQESgNxyVQvf/SXfGcfj0WOu3VujjnpBn73fMAqL+W
	EY565OnheiCX/9V1yI1if+1b6NMtjJahWCqdR9GQsw1Cmsiob/nR6QE1ApdS1HOXhB84T3t0hTNqY
	nqzVIESwCP4qeX4nf2DTEium4B9G5m9Aho7sQY9luxIGrSRJicrUhobTxscGaEVZSz5dyzs4FThd6
	p88G2Leg==;
Received: from 2a02-8389-2341-5b80-350d-7b06-b28a-173d.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:350d:7b06:b28a:173d] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0MJq-00000005Wvb-2tip;
	Mon, 14 Oct 2024 14:45:11 +0000
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
Subject: provide generic page_to_phys and phys_to_page implementations v2
Date: Mon, 14 Oct 2024 16:44:57 +0200
Message-ID: <20241014144506.51754-1-hch@lst.de>
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


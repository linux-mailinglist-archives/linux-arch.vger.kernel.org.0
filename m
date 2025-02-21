Return-Path: <linux-arch+bounces-10298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FEA3F74C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D070D17C046
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703FC20D4E4;
	Fri, 21 Feb 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ND0yGIRU"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14685194AEC
	for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148270; cv=none; b=setVQJAx6/bnxYo5jkHWgic5Ty6lb+EqdQkjPlfuyTQ+tuR1CIYrsJF1sG4rExn0h2oyklxfbzBGScIfQQmNsu5wImqN5Kf/Ngp4V7FchpdIy+78+hzCUEsLcDbM/v2umT+r8ZkThwLZ/cxFxXupBUoDtz9g/XbiZsv8X6X6diY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148270; c=relaxed/simple;
	bh=/2u8iDqLbTj208j4VsCc2S1TC04CWPP7/mqUtIU3TQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Msb1dBGc7hQGiw9Ej+vd0XpSn0GbMorllxdCr/NfHoPKguz8ft256G0QLampVNa3/igYcTL7Oe7V6flm099OdCX5FXOaghUTNcpoKkUkxrcVTYMtJUHKaScvUiWtkBPkHMuVICDxpDsMfbMuA7RNaIrKnwvtz3kf4ChnE+lCn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ND0yGIRU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zL+A5D2d25ndZh+AaMayRlslnobCPBcZRJXpvFNHLB0=; b=ND0yGIRUI6vJu/csS6HPJhyE0n
	OB8Btgd8gQFy+E6F7oc9lMYUw/cw4gq7oIOng5F4Of5UXQI2pkjYGXpXr4HlaDsGJUXsba06unQWp
	IDLUdHyZAxtLYR6VYGy6VuSIrCHAD2sDLaCGyoNQB63wzjcQ9KB/rBnK2SrGnHee0kxCQLvrEAiRR
	vyeCFgoLuEiRokoRbpso0DFjODZ15kGObiYa1SlZHAAPGJLVDy+hHs9sS/h8kESC4Q8d6TwLSYeLK
	QbbS2am2YleBQQojT6cYO8EEo98Zsh9XBzwbktCxJQoHgOB2gD5sQzMe6QsISTISE8VAvQl/jXGzp
	Lq5ws8fQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlU3W-0000000DzWC-064W;
	Fri, 21 Feb 2025 14:31:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/4] Some uses of folio_mk_pte()
Date: Fri, 21 Feb 2025 14:30:57 +0000
Message-ID: <20250221143104.3334444-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building on top of my earlier series to add folio_mk_pte(), I'm
simplifying both hugetlb and thp.  I dislike that we still have
pmd_mkhuge() (we shouldn't be able to create a PMD entry that isn't
huge!) and I continue to dislike the 'huge pte' concept in hugetlb,
but this is a step in the right direction.

Matthew Wilcox (Oracle) (4):
  hugetlb: Simplify make_huge_pte()
  mm: Remove mk_huge_pte()
  mm: Add folio_mk_pmd()
  arch: Remove mk_pmd()

 arch/arc/include/asm/hugepage.h              |  2 --
 arch/arc/include/asm/pgtable-levels.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/arm64/include/asm/pgtable.h             |  1 -
 arch/loongarch/include/asm/pgtable.h         |  1 -
 arch/loongarch/mm/pgtable.c                  |  9 ---------
 arch/mips/include/asm/pgtable.h              |  3 ---
 arch/mips/mm/pgtable-32.c                    | 10 ----------
 arch/mips/mm/pgtable-64.c                    |  9 ---------
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/powerpc/mm/book3s64/pgtable.c           |  5 -----
 arch/riscv/include/asm/pgtable-64.h          |  2 --
 arch/s390/include/asm/pgtable.h              |  1 -
 arch/sparc/include/asm/pgtable_64.h          |  1 -
 arch/x86/include/asm/pgtable.h               |  2 --
 fs/dax.c                                     |  3 +--
 include/asm-generic/hugetlb.h                |  5 -----
 include/linux/huge_mm.h                      |  2 --
 include/linux/mm.h                           | 17 +++++++++++++++++
 mm/debug_vm_pgtable.c                        | 18 +++++-------------
 mm/huge_memory.c                             | 11 +++++------
 mm/hugetlb.c                                 | 18 ++++++++----------
 mm/khugepaged.c                              |  2 +-
 mm/memory.c                                  |  2 +-
 24 files changed, 38 insertions(+), 89 deletions(-)

-- 
2.47.2



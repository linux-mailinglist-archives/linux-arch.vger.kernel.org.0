Return-Path: <linux-arch+bounces-11226-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B90EA794EC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 20:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40273AED00
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68319E826;
	Wed,  2 Apr 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHinc/Ya"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9F11CBA
	for <linux-arch@vger.kernel.org>; Wed,  2 Apr 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617835; cv=none; b=Dr2Iemu9zCxB86J+Cyh/7if1+RjKpK6lMieEwavUTo2X8wUsGtIBkntA5VoXDdi1Siw8ROP3R+EiRYLt2yidZcDiGCleXpDVxb21oC8X9ftdMOdr52ltYeuaeGP6KjWOrudTirmZ60gcX29qImBf/ckFskk1Ltbdfq+lLTc1KLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617835; c=relaxed/simple;
	bh=5wr/Pzh9SloOBb23xMWxC998ypj7nbmh4knbpy7YrZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i90EO80q+u5mOOfzJvruAy5QtyVRuLeYW5fdFE1MXsitTClBY2cswNX6fw1u96hVBABk6PCWcpJBMcY3QsaSBoLfgozxwSP+gjjlpnRhNVnXMZ4agmo6GjpEwqFuTSRgLolg6yH3TvZkwa3rniwpn2wDAOnYVRmAlWW+2tOp+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eHinc/Ya; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zG2qmgB6DXXFbFEthdWezekiUiX40srjLv1CpeHkOow=; b=eHinc/YaxLLePph24M06pCnLgJ
	bE96zoPlL1xm/GGN3DoLBC7F5eOZAK1AyP4TFlhzEs7FjGqp1EnZFAHmN9snpWUrbctRpfk2+EeDT
	NYV155tbJAXBOvneD0/61fXySPQDdVfz+E1kimvMYRMi70YC0jf/9+sn2sTsssCKGQXCr7DkzV+rF
	AOLTa+l7bqxsXgFWAv3JZYs+Ta4VtJDowudjyKCzklAYzWPUixc/TommQ185GKTcUbh9UJDDNuMfN
	LPv13C2v7V5VTwh9TiA15UDaKxXL0bEywUIH9ie3fpeKgdNRcPU3S8d2bTB46/ui9IHBcD+3Ozsom
	TQk4iQ1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02eE-0000000A0iS-3uhT;
	Wed, 02 Apr 2025 18:17:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 00/11] Add folio_mk_pte()
Date: Wed,  2 Apr 2025 19:16:54 +0100
Message-ID: <20250402181709.2386022-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today if you have a folio and want to create a PTE that points to
the first page in it, you have to convert from a folio to a page.
That's zero-cost today but will be more expensive in the future.

I didn't want to add folio_mk_pte() to each architecture, and I didn't
want to lose any optimisations that architectures have from their own
implementation of mk_pte().  Fortunately, most architectures have by
now turned their mk_pte() into a fairly bland variant of pfn_pte(),
but s390 has a special optimisation that needs to be moved into generic
code in the first patch.

At the end of this patch set, we have mk_pte() and folio_mk_pte() in
mm.h and each architecture only has to implement pfn_pte().  We've also
eliminated mk_huge_pte(), mk_huge_pmd() and mk_pmd().

Matthew Wilcox (Oracle) (11):
  mm: Set the pte dirty if the folio is already dirty
  mm: Introduce a common definition of mk_pte()
  sparc32: Remove custom definition of mk_pte()
  x86: Remove custom definition of mk_pte()
  um: Remove custom definition of mk_pte()
  mm: Make mk_pte() definition unconditional
  mm: Add folio_mk_pte()
  hugetlb: Simplify make_huge_pte()
  mm: Remove mk_huge_pte()
  mm: Add folio_mk_pmd()
  arch: Remove mk_pmd()

 arch/alpha/include/asm/pgtable.h             |  7 ----
 arch/arc/include/asm/hugepage.h              |  2 -
 arch/arc/include/asm/pgtable-levels.h        |  2 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/arm/include/asm/pgtable.h               |  1 -
 arch/arm64/include/asm/pgtable.h             |  7 ----
 arch/csky/include/asm/pgtable.h              |  5 ---
 arch/hexagon/include/asm/pgtable.h           |  3 --
 arch/loongarch/include/asm/pgtable.h         |  7 ----
 arch/loongarch/mm/pgtable.c                  |  9 -----
 arch/m68k/include/asm/mcf_pgtable.h          |  6 ---
 arch/m68k/include/asm/motorola_pgtable.h     |  6 ---
 arch/m68k/include/asm/sun3_pgtable.h         |  6 ---
 arch/microblaze/include/asm/pgtable.h        |  8 ----
 arch/mips/include/asm/pgtable.h              |  9 -----
 arch/mips/mm/pgtable-32.c                    | 10 -----
 arch/mips/mm/pgtable-64.c                    |  9 -----
 arch/nios2/include/asm/pgtable.h             |  6 ---
 arch/openrisc/include/asm/pgtable.h          |  2 -
 arch/parisc/include/asm/pgtable.h            |  6 ---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 -
 arch/powerpc/include/asm/pgtable.h           |  3 +-
 arch/powerpc/mm/book3s64/pgtable.c           |  5 ---
 arch/riscv/include/asm/pgtable-64.h          |  2 -
 arch/riscv/include/asm/pgtable.h             |  2 -
 arch/s390/include/asm/pgtable.h              | 11 ------
 arch/sh/include/asm/pgtable_32.h             |  8 ----
 arch/sparc/include/asm/pgtable_32.h          | 15 +++-----
 arch/sparc/include/asm/pgtable_64.h          |  2 -
 arch/um/include/asm/pgtable-2level.h         |  1 -
 arch/um/include/asm/pgtable-4level.h         |  9 -----
 arch/um/include/asm/pgtable.h                | 18 ++++-----
 arch/x86/include/asm/pgtable.h               | 21 ++---------
 arch/xtensa/include/asm/pgtable.h            |  6 ---
 fs/dax.c                                     |  3 +-
 include/asm-generic/hugetlb.h                |  5 ---
 include/linux/huge_mm.h                      |  2 -
 include/linux/mm.h                           | 39 ++++++++++++++++++++
 mm/debug_vm_pgtable.c                        | 18 +++------
 mm/huge_memory.c                             | 11 +++---
 mm/hugetlb.c                                 | 18 ++++-----
 mm/khugepaged.c                              |  2 +-
 mm/memory.c                                  | 10 +++--
 mm/userfaultfd.c                             |  2 +-
 44 files changed, 83 insertions(+), 243 deletions(-)

-- 
2.47.2



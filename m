Return-Path: <linux-arch+bounces-9572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B24A00DC0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 19:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D5B3A3F27
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE7E1F9F7D;
	Fri,  3 Jan 2025 18:44:33 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38E11F9F6B;
	Fri,  3 Jan 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735929872; cv=none; b=aqrU1REqtTkZ5oY8i5izm8Vhx6uy5dEiVMz7GaUnX73Ka9wjeEDpYQuXKNbo0PMF+Tx6B/bCRGvf2aWW06Koey5YjNyThEwNfZq72cTS5NWGFkT9gX7vTS34ELb2a9ulZD3SZXxmf6N/GCIu4a9abXXVEDQSJPaQ86FMtpDp3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735929872; c=relaxed/simple;
	bh=LfBLl9xHKsxmTEzMaL6DzsDWOdNj/upe0IaJWPpE4IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XieW9XzaOOoRbNqyO3ozUaPDCFQC5fEgRka+XgomaL/aNfg5rAhAuVZNfK3OgD3hg2SGZjJn7Mk5rDfuhe1lcF6jeMNb2qDA4FjO1nEpQr60ECRMNHRtLP+tLqRwUPLj4DC0zYPDFWL00e85yKoh1xnLepRGuqNeqIJGLTNdcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561C61480;
	Fri,  3 Jan 2025 10:44:57 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D3DB3F673;
	Fri,  3 Jan 2025 10:44:24 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH v2 0/6] Account page tables at all levels
Date: Fri,  3 Jan 2025 18:44:09 +0000
Message-ID: <20250103184415.2744423-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-mm/20241219164425.2277022-1-kevin.brodsky@arm.com/

This series should be considered in conjunction with Qi's series [1].
Together, they ensure that page table ctor/dtor are called at all levels
(PTE to PGD) and all architectures, where page tables are regular pages.
Besides the improvement in accounting and general cleanup, this also
create a single place where construction/destruction hooks can be called
for all page tables, namely the now-generic pagetable_dtor() introduced
by Qi, and __pagetable_ctor() introduced in this series.

v2 is essentially v1 rebased on top of mm-unstable, which includes Qi's
v4 series. A number of patches from v1 were dropped:

* v1 patch 4 is superseded by patch 6 in Qi's series.
* v1 patch 5 and 6 moved to Qi's series from v3 onwards.
* v1 patch 7 is superseded by patch 4 in Qi's series.

Changes from v1 in the remaining patches:

* Patch 1 only introduces __pagetable_ctor() as there is now a single
  generic pagetable_dtor(). 

* Patch 3 and 6: in arch/m68k/mm/motorola.c, free_pointer_table() can
  now unconditionally call pagetable_dtor() since it is the same for all
  levels.

* Patch 6 just uses pagetable_dtor() instead of introducing
  pagetable_pgd_dtor().

* Added Dave Hansen's Acked-by to all patches.

- Kevin

[1] https://lore.kernel.org/linux-mm/cover.1735549103.git.zhengqi.arch@bytedance.com/
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: loongarch@lists.linux.dev
Cc: x86@kernel.org
---
Kevin Brodsky (6):
  mm: Move common part of pagetable_*_ctor to helper
  parisc: mm: Ensure pagetable_pmd_[cd]tor are called
  m68k: mm: Add calls to pagetable_pmd_[cd]tor
  ARM: mm: Rename PGD helpers
  asm-generic: pgalloc: Provide generic __pgd_{alloc,free}
  mm: Introduce ctor/dtor at PGD level

 arch/alpha/mm/init.c                     |  2 +-
 arch/arc/include/asm/pgalloc.h           |  9 ++----
 arch/arm/mm/pgd.c                        | 16 +++++-----
 arch/arm64/mm/pgd.c                      |  4 +--
 arch/csky/include/asm/pgalloc.h          |  2 +-
 arch/hexagon/include/asm/pgalloc.h       |  2 +-
 arch/loongarch/mm/pgtable.c              |  7 ++---
 arch/m68k/include/asm/mcf_pgalloc.h      |  3 +-
 arch/m68k/include/asm/motorola_pgalloc.h |  6 ++--
 arch/m68k/include/asm/sun3_pgalloc.h     |  2 +-
 arch/m68k/mm/motorola.c                  | 21 +++++++++----
 arch/microblaze/include/asm/pgalloc.h    |  7 +----
 arch/mips/include/asm/pgalloc.h          |  6 ----
 arch/mips/mm/pgtable.c                   |  8 ++---
 arch/nios2/mm/pgtable.c                  |  3 +-
 arch/openrisc/include/asm/pgalloc.h      |  6 ++--
 arch/parisc/include/asm/pgalloc.h        | 39 ++++++++----------------
 arch/riscv/include/asm/pgalloc.h         |  3 +-
 arch/s390/include/asm/pgalloc.h          |  9 +++++-
 arch/um/kernel/mem.c                     |  7 ++---
 arch/x86/mm/pgtable.c                    | 24 +++++++--------
 arch/xtensa/include/asm/pgalloc.h        |  2 +-
 include/asm-generic/pgalloc.h            | 28 ++++++++++++++++-
 include/linux/mm.h                       | 31 ++++++++++---------
 24 files changed, 126 insertions(+), 121 deletions(-)


base-commit: e2ce19225db5818f5dc22864cd225f8c425c3775
-- 
2.47.0



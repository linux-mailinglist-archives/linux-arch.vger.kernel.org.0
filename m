Return-Path: <linux-arch+bounces-9433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A846F9F8039
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2445216A19D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632D153598;
	Thu, 19 Dec 2024 16:46:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9B4EB48;
	Thu, 19 Dec 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626774; cv=none; b=FELZh4sOmnb3FiRUljIRE0Vw2ULBEBEoUrHO2phDvdgVVOgSezyS9YT3pScvdK2B3nu2VX7M24gqb9I1exxheTuYjehB/UTBsQIeA7rfWYOophI3ga3BEdo96M2yQomWtrnZvDWpm7ms1Z+gLGUqvzAJlGLaXpMY/qREorYgobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626774; c=relaxed/simple;
	bh=3q80Bx5bppZj+CXnaPreUsTLT6OlZBNzKMfGvb3ctc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ds1lWfbmy62Wdxq5egDhUGME4CohT0tpWlz6kagmDPMe3nnkbtIwariESJbcvqGwR5KutQmPI6zFw0Pfk1ik3IYrhbaR9MzmRPMyqZ0aJFKLOzbcyjpKwmms2eCJQsGMPrydcbEvjBNTkGFLGsJRdc1IY414MvGucz6Y+/loJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3235D1480;
	Thu, 19 Dec 2024 08:46:39 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E9D63F58B;
	Thu, 19 Dec 2024 08:46:07 -0800 (PST)
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
Subject: [PATCH 00/10] Account page tables at all levels
Date: Thu, 19 Dec 2024 16:44:15 +0000
Message-ID: <20241219164425.2277022-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We currently have a pair of ctor/dtor calls for lower page table levels,
up to PUD. At PTE and PMD level, these handle split locks,
if supported. Additionally, the helpers ensure correct accounting of
page table pages to the corresponding process.

This series takes that principle to its logical conclusion: account all
page table pages, at all levels and on all architectures (see caveat
below), through suitable ctor/dtor calls. This means concretely:

* Ensuring that the existing pagetable_{pte,pmd,pud}_[cd]tor are called
  on all architectures.

* Introduce pagetable_{p4d,pgd}_[cd]tor and call them at P4D/PGD level.

The primary motivation for this series is not page accounting, though.
P4D/PGD-level pages represent a tiny proportion of the memory used by a
process. Rather, the appeal comes from the introduction of a single,
generic place where construction/destruction hooks can be called for all
page table pages at all levels. This will come in handy for protecting
page tables using kpkeys [1]. Peter Zijlstra suggested this approach [2]
to avoid handling this in arch code.

With this series, __pagetable_ctor() and __pagetable_dtor() (introduced
in patch 1) should be called when page tables are allocated/freed at any
level on any architecture. Note however that only P*D that consist of
one or more regular pages are handled. This excludes:

* All P*D allocated from a kmem_cache (or kmalloc).
* P*D that are not allocated via GFP (only an issue on sparc).

The table at the end of this email gives more details for each
architecture.

Patches in details:

* Patch 1 factors out the common implementation of all
  pagetable_*_[cd]tor.

* Patch 2-4: PMD/PUD; add missing calls to pagetable_{pmd,pud}_[cd]tor
  on various architectures.

* Patch 5-7: P4D; move most arch to using generic alloc/free functions
  at P4D level, and then have them call pagetable_p4d_[cd]tor.

* Patch 8-10: PGD; same principle at PGD level.

The patches were build-tested on all architectures (thanks Linus Walleij
for triggering the LKP CI for me!), and boot-tested on arm64 and x86_64.

- Kevin

[1] https://lore.kernel.org/linux-hardening/20241206101110.1646108-1-kevin.brodsky@arm.com/
[2] https://lore.kernel.org/linux-hardening/20241210122355.GN8562@noisy.programming.kicks-ass.net/
---

Overview of the situation on all arch after this series is applied:

  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | arch          | #include                | Complete ctor/dtor    | ctor/dtor    | Notes                              |
  |               | <asm-generic/pgalloc.h> | calls up to p4d level | at pgd level |                                    |
  +===============+=========================+=======================+==============+====================================+
  | alpha         | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | arc           | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | arm           | Y                       | Y                     | Y/N          | kmalloc at pgd level if LPAE       |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | arm64         | Y                       | Y                     | Y/N          | kmem_cache if pgd not page-sized   |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | csky          | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | hexagon       | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | loongarch     | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | m68k (Sun3)   | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | m68k (others) | N                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | microblaze    | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | mips          | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | nios2         | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | openrisc      | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | parisc        | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | powerpc       | N                       | Y/N                   | N            | kmem_cache at:                     |
  |               |                         |                       |              | - pgd level                        |
  |               |                         |                       |              | - pud level in 64-bit              |
  |               |                         |                       |              | - pmd level in 64-bit on !book3s   |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | riscv         | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | s390          | N                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | sh            | Y                       | N                     | N            | kmem_cache at pmd/pgd level        |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | sparc         | N                       | N                     | N            | 32-bit: special memory             |
  |               |                         |                       |              | 64-bit: kmem_cache above pte level |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | um            | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | x86           | Y                       | Y                     | Y/N          | kmem_cache at pgd level if PAE     |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+
  | xtensa        | Y                       | Y                     | Y            |                                    |
  +---------------+-------------------------+-----------------------+--------------+------------------------------------+

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
Kevin Brodsky (10):
  mm: Move common parts of pagetable_*_[cd]tor to helpers
  parisc: mm: Ensure pagetable_pmd_[cd]tor are called
  m68k: mm: Add calls to pagetable_pmd_[cd]tor
  s390/mm: Add calls to pagetable_pud_[cd]tor
  riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
  asm-generic: pgalloc: Provide generic p4d_{alloc_one,free}
  mm: Introduce ctor/dtor at P4D level
  ARM: mm: Rename PGD helpers
  asm-generic: pgalloc: Provide generic __pgd_{alloc,free}
  mm: Introduce ctor/dtor at PGD level

 arch/alpha/mm/init.c                     |  2 +-
 arch/arc/include/asm/pgalloc.h           |  9 +--
 arch/arm/mm/pgd.c                        | 16 +++--
 arch/arm64/include/asm/pgalloc.h         | 17 ------
 arch/arm64/mm/pgd.c                      |  4 +-
 arch/csky/include/asm/pgalloc.h          |  2 +-
 arch/hexagon/include/asm/pgalloc.h       |  2 +-
 arch/loongarch/mm/pgtable.c              |  7 +--
 arch/m68k/include/asm/mcf_pgalloc.h      |  2 +
 arch/m68k/include/asm/motorola_pgalloc.h |  6 +-
 arch/m68k/include/asm/sun3_pgalloc.h     |  2 +-
 arch/m68k/mm/motorola.c                  | 31 ++++++++--
 arch/microblaze/include/asm/pgalloc.h    |  7 +--
 arch/mips/include/asm/pgalloc.h          |  6 --
 arch/mips/mm/pgtable.c                   |  8 +--
 arch/nios2/mm/pgtable.c                  |  3 +-
 arch/openrisc/include/asm/pgalloc.h      |  6 +-
 arch/parisc/include/asm/pgalloc.h        | 39 ++++--------
 arch/riscv/include/asm/pgalloc.h         | 46 ++------------
 arch/s390/include/asm/pgalloc.h          | 33 +++++++---
 arch/um/kernel/mem.c                     |  7 +--
 arch/x86/include/asm/pgalloc.h           | 18 ------
 arch/x86/mm/pgtable.c                    | 27 +++++----
 arch/xtensa/include/asm/pgalloc.h        |  2 +-
 include/asm-generic/pgalloc.h            | 76 +++++++++++++++++++++++-
 include/linux/mm.h                       | 64 +++++++++++++-------
 26 files changed, 234 insertions(+), 208 deletions(-)


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.0



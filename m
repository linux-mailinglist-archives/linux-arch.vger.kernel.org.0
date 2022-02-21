Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F664BD645
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbiBUGjK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:39:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345259AbiBUGjK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:39:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE1A5654D;
        Sun, 20 Feb 2022 22:38:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95DCA113E;
        Sun, 20 Feb 2022 22:38:46 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EF0F3F70D;
        Sun, 20 Feb 2022 22:38:43 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 00/30] mm/mmap: Drop protection_map[] and platform's __SXXX/__PXXX requirements
Date:   Mon, 21 Feb 2022 12:08:09 +0530
Message-Id: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

protection_map[] is an array based construct that translates given vm_flags
combination. This array contains page protection map, which is populated by
the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
Primary usage for protection_map[] is for vm_get_page_prot(), which is used
to determine page protection value for a given vm_flags. vm_get_page_prot()
implementation, could again call platform overrides arch_vm_get_page_prot()
and arch_filter_pgprot(). Some platforms override protection_map[] that was
originally built with __SXXX/__PXXX with different runtime values.

Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
, protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
between the platform and generic MM, finally defining vm_get_page_prot().

Hence this series proposes to drop all these abstraction levels and instead
just move the responsibility of defining vm_get_page_prot() to the platform
itself making it clean and simple.

This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
to define custom vm_get_page_prot(). This starts converting platforms that
either change protection_map[] or define the overrides arch_filter_pgprot()
or arch_vm_get_page_prot() which enables for those constructs to be dropped
off completely. This series then converts remaining platforms which enables
for __SXXX/__PXXX constructs to be dropped off completely. Finally it drops
the generic vm_get_page_prot() and then ARCH_HAS_VM_GET_PAGE_PROT as every
platform now defines their own vm_get_page_prot().

The series has been inspired from an earlier discuss with Christoph Hellwig

https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/

This series applies on 5.17-rc5 after the following patch.

https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/

This series has been cross built for multiple platforms.

- Anshuman

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in V2:

- Dropped the entire comment block in [PATCH 30/30] per Geert
- Replaced __P010 (although commented) with __PAGE_COPY on arm platform
- Replaced __P101 with PAGE_READONLY on um platform

Changes in V1:

https://lore.kernel.org/all/1644805853-21338-1-git-send-email-anshuman.khandual@arm.com/

- Add white spaces around the | operators 
- Moved powerpc_vm_get_page_prot() near vm_get_page_prot() on powerpc
- Moved arm64_vm_get_page_prot() near vm_get_page_prot() on arm64
- Moved sparc_vm_get_page_prot() near vm_get_page_prot() on sparc
- Compacted vm_get_page_prot() switch cases on all platforms
-  _PAGE_CACHE040 inclusion is dependent on CPU_IS_040_OR_060
- VM_SHARED case should return PAGE_NONE (not PAGE_COPY) on SH platform
- Reorganized VM_SHARED, VM_EXEC, VM_WRITE, VM_READ
- Dropped the last patch [RFC V1 31/31] which added macros for vm_flags combinations
  https://lore.kernel.org/all/1643029028-12710-32-git-send-email-anshuman.khandual@arm.com/

Changes in RFC:

https://lore.kernel.org/all/1643029028-12710-1-git-send-email-anshuman.khandual@arm.com/

Anshuman Khandual (29):
  mm/debug_vm_pgtable: Drop protection_map[] usage
  mm/mmap: Clarify protection_map[] indices
  mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
  powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop protection_map[]
  mm/mmap: Drop arch_filter_pgprot()
  mm/mmap: Drop arch_vm_get_page_pgprot()
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  alpha/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sh/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  extensa/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  microblaze/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nds32/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  ia64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop generic vm_get_page_prot()
  mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT

Christoph Hellwig (1):
  x86/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/alpha/include/asm/pgtable.h          |  17 ----
 arch/alpha/mm/init.c                      |  37 ++++++++
 arch/arc/include/asm/pgtable-bits-arcv2.h |  17 ----
 arch/arc/mm/mmap.c                        |  41 +++++++++
 arch/arm/include/asm/pgtable.h            |  18 ----
 arch/arm/lib/uaccess_with_memcpy.c        |   2 +-
 arch/arm/mm/mmu.c                         |  44 +++++++--
 arch/arm64/Kconfig                        |   1 -
 arch/arm64/include/asm/mman.h             |  24 -----
 arch/arm64/include/asm/pgtable-prot.h     |  18 ----
 arch/arm64/include/asm/pgtable.h          |  11 ---
 arch/arm64/mm/mmap.c                      |  78 ++++++++++++++++
 arch/csky/include/asm/pgtable.h           |  18 ----
 arch/csky/mm/init.c                       |  32 +++++++
 arch/hexagon/include/asm/pgtable.h        |  24 -----
 arch/hexagon/mm/init.c                    |  67 ++++++++++++++
 arch/ia64/include/asm/pgtable.h           |  17 ----
 arch/ia64/mm/init.c                       |  41 ++++++++-
 arch/m68k/include/asm/mcf_pgtable.h       |  59 ------------
 arch/m68k/include/asm/motorola_pgtable.h  |  22 -----
 arch/m68k/include/asm/sun3_pgtable.h      |  22 -----
 arch/m68k/mm/init.c                       | 104 ++++++++++++++++++++++
 arch/m68k/mm/motorola.c                   |  48 +++++++++-
 arch/microblaze/include/asm/pgtable.h     |  17 ----
 arch/microblaze/mm/init.c                 |  41 +++++++++
 arch/mips/include/asm/pgtable.h           |  22 -----
 arch/mips/mm/cache.c                      |  60 +++++++------
 arch/nds32/include/asm/pgtable.h          |  17 ----
 arch/nds32/mm/mmap.c                      |  37 ++++++++
 arch/nios2/include/asm/pgtable.h          |  16 ----
 arch/nios2/mm/init.c                      |  45 ++++++++++
 arch/openrisc/include/asm/pgtable.h       |  18 ----
 arch/openrisc/mm/init.c                   |  41 +++++++++
 arch/parisc/include/asm/pgtable.h         |  20 -----
 arch/parisc/mm/init.c                     |  40 +++++++++
 arch/powerpc/include/asm/mman.h           |  12 ---
 arch/powerpc/include/asm/pgtable.h        |  19 ----
 arch/powerpc/mm/mmap.c                    |  59 ++++++++++++
 arch/riscv/include/asm/pgtable.h          |  16 ----
 arch/riscv/mm/init.c                      |  42 +++++++++
 arch/s390/include/asm/pgtable.h           |  17 ----
 arch/s390/mm/mmap.c                       |  33 +++++++
 arch/sh/include/asm/pgtable.h             |  17 ----
 arch/sh/mm/mmap.c                         |  38 ++++++++
 arch/sparc/include/asm/mman.h             |   6 --
 arch/sparc/include/asm/pgtable_32.h       |  19 ----
 arch/sparc/include/asm/pgtable_64.h       |  19 ----
 arch/sparc/mm/init_32.c                   |  35 ++++++++
 arch/sparc/mm/init_64.c                   |  70 +++++++++++----
 arch/um/include/asm/pgtable.h             |  17 ----
 arch/um/kernel/mem.c                      |  35 ++++++++
 arch/x86/Kconfig                          |   1 -
 arch/x86/include/asm/pgtable.h            |   5 --
 arch/x86/include/asm/pgtable_types.h      |  19 ----
 arch/x86/include/uapi/asm/mman.h          |  14 ---
 arch/x86/mm/Makefile                      |   2 +-
 arch/x86/mm/mem_encrypt_amd.c             |   4 -
 arch/x86/mm/pgprot.c                      |  71 +++++++++++++++
 arch/x86/um/mem_32.c                      |   2 +-
 arch/xtensa/include/asm/pgtable.h         |  18 ----
 arch/xtensa/mm/init.c                     |  35 ++++++++
 include/linux/mm.h                        |   6 --
 include/linux/mman.h                      |   4 -
 mm/Kconfig                                |   3 -
 mm/debug_vm_pgtable.c                     |  31 ++++---
 mm/mmap.c                                 |  42 ---------
 66 files changed, 1142 insertions(+), 705 deletions(-)
 create mode 100644 arch/x86/mm/pgprot.c

-- 
2.25.1


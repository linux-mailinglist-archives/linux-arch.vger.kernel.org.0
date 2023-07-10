Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7457E74DF97
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjGJUpD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjGJUoF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8937FE74;
        Mon, 10 Jul 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AHrvjsSlB3AvxFpbcmxD6qg2xOdDO2yFi0PSqletee8=; b=Bkk1kR7oUJZg4z6x0qCDVhpoN/
        c4RWivVYHqTrMoNJgE4NQVePYB/AgiZOga/ktVEwfICvWuK4NWyDb2UFVFaX2yeSZTpxaz5vpyoJu
        AR9g5vFbA1R0ULNoJvj3TpWDD5cZRrf2QfTkFCsZiF3ukL2S32fJcWAFzDfyYipJ/nLnGhNDPQmru
        MN43JfSlyaAaoVNdNgdSq84xA7806Zyb+DPvobf4XR0TaEQuI1egD+eEr9y1Y36HZVVFP8YcjfY5C
        Pq/ho7Xg6KcGJWrs0u55WWpixCBRzmlf2BoYd1R/xPACfklnLj1kJWkOxeoSGKOrMLcqj/nYLK9Sz
        3LDIoHrg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjQ-00EuoC-Vl; Mon, 10 Jul 2023 20:43:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/38] New page table range API
Date:   Mon, 10 Jul 2023 21:43:01 +0100
Message-Id: <20230710204339.3554919-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patchset changes the API used by the MM to set up page table entries.
The four APIs are:
    set_ptes(mm, addr, ptep, pte, nr)
    update_mmu_cache_range(vma, addr, ptep, nr)
    flush_dcache_folio(folio) 
    flush_icache_pages(vma, page, nr)

flush_dcache_folio() isn't technically new, but no architecture
implemented it, so I've done that for them.  The old APIs remain around
but are mostly implemented by calling the new interfaces.

The new APIs are based around setting up N page table entries at once.
The N entries belong to the same PMD, the same folio and the same VMA,
so ptep++ is a legitimate operation, and locking is taken care of for
you.  Some architectures can do a better job of it than just a loop,
but I have hesitated to make too deep a change to architectures I don't
understand well.

One thing I have changed in every architecture is that PG_arch_1 is now a
per-folio bit instead of a per-page bit.  This was something that would
have to happen eventually, and it makes sense to do it now rather than
iterate over every page involved in a cache flush and figure out if it
needs to happen.

The point of all this is better performance, and Fengwei Yin has
measured improvement on x86.  I suspect you'll see improvement on
your architecture too.  Try the new will-it-scale test mentioned here:
https://lore.kernel.org/linux-mm/20230206140639.538867-5-fengwei.yin@intel.com/
You'll need to run it on an XFS filesystem and have
CONFIG_TRANSPARENT_HUGEPAGE set.

This patchset is the basis for much of the anonymous large folio work
being done by Ryan Roberts, so it's received quite a lot of testing over
the last few months.  My thanks to Ryan & Fengwei Yin for all their help
with this patchset.

v5:
 - Add in_range() macro
 - Fix numerous compilation problems on minority architectures (thanks LKP!)
 - Add the 'vmf' argument to update_mmu_cache_range() to help MIPS
   and other architectures that insert TLB entries in software,
   rather than using a hardware page table walker
 - Get rid of first_map_page() and next_map_page(); use
   next_uptodate_folio() directly
 - Actually move the mmap_miss accounting in filemap.c
 - Add kernel-doc for set_pte_range()
 - Correct determination of prefaulting in set_pte_range()
 - More Acked & Reviewed tags

v4:
 - Fix a few compile errors (mostly Mike Rapoport)
 - Incorporate Mike's suggestion to avoid having to define set_ptes()
   or set_pte_at() on the majority of architectures
 - Optimise m68k's __flush_pages_to_ram (Geert Uytterhoeven)
 - Fix sun3 (me)
 - Fix sparc32 (me)
 - Pick up a few more Ack/Reviewed tags

v3:
 - Reinstate flush_dcache_icache_phys() on PowerPC
 - Fix folio_flush_mapping().  The documentation was correct and the
   implementation was completely wrong
 - Change the flush_dcache_page() documentation to describe
   flush_dcache_folio() instead
 - Split ARM from ARC.  I messed up my git commands
 - Remove page_mapping_file()
 - Rationalise how flush_icache_pages() and flush_icache_page() are defined
 - Use flush_icache_pages() in do_set_pmd()
 - Pick up Guo Ren's Ack for csky

Matthew Wilcox (Oracle) (34):
  minmax: Add in_range() macro
  mm: Convert page_table_check_pte_set() to page_table_check_ptes_set()
  mm: Add generic flush_icache_pages() and documentation
  mm: Add folio_flush_mapping()
  mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
  mm: Add default definition of set_ptes()
  alpha: Implement the new page table range API
  arc: Implement the new page table range API
  arm: Implement the new page table range API
  arm64: Implement the new page table range API
  csky: Implement the new page table range API
  hexagon: Implement the new page table range API
  ia64: Implement the new page table range API
  loongarch: Implement the new page table range API
  m68k: Implement the new page table range API
  microblaze: Implement the new page table range API
  mips: Implement the new page table range API
  nios2: Implement the new page table range API
  openrisc: Implement the new page table range API
  parisc: Implement the new page table range API
  powerpc: Implement the new page table range API
  riscv: Implement the new page table range API
  s390: Implement the new page table range API
  sh: Implement the new page table range API
  sparc32: Implement the new page table range API
  sparc64: Implement the new page table range API
  um: Implement the new page table range API
  x86: Implement the new page table range API
  xtensa: Implement the new page table range API
  mm: Remove page_mapping_file()
  mm: Rationalise flush_icache_pages() and flush_icache_page()
  mm: Tidy up set_ptes definition
  mm: Use flush_icache_pages() in do_set_pmd()
  mm: Call update_mmu_cache_range() in more page fault handling paths

Yin Fengwei (4):
  filemap: Add filemap_map_folio_range()
  rmap: add folio_add_file_rmap_range()
  mm: Convert do_set_pte() to set_pte_range()
  filemap: Batch PTE mappings

 Documentation/core-api/cachetlb.rst          |  55 ++++-----
 Documentation/filesystems/locking.rst        |   2 +-
 arch/alpha/include/asm/cacheflush.h          |  13 +-
 arch/alpha/include/asm/pgtable.h             |  10 +-
 arch/arc/include/asm/cacheflush.h            |  14 +--
 arch/arc/include/asm/pgtable-bits-arcv2.h    |  12 +-
 arch/arc/include/asm/pgtable-levels.h        |   1 +
 arch/arc/mm/cache.c                          |  61 +++++----
 arch/arc/mm/tlb.c                            |  18 +--
 arch/arm/include/asm/cacheflush.h            |  29 +++--
 arch/arm/include/asm/pgtable.h               |   5 +-
 arch/arm/include/asm/tlbflush.h              |  14 ++-
 arch/arm/mm/copypage-v4mc.c                  |   5 +-
 arch/arm/mm/copypage-v6.c                    |   5 +-
 arch/arm/mm/copypage-xscale.c                |   5 +-
 arch/arm/mm/dma-mapping.c                    |  24 ++--
 arch/arm/mm/fault-armv.c                     |  16 +--
 arch/arm/mm/flush.c                          |  99 +++++++++------
 arch/arm/mm/mm.h                             |   2 +-
 arch/arm/mm/mmu.c                            |  14 ++-
 arch/arm/mm/nommu.c                          |   6 +
 arch/arm64/include/asm/cacheflush.h          |   4 +-
 arch/arm64/include/asm/pgtable.h             |  26 ++--
 arch/arm64/mm/flush.c                        |  36 +++---
 arch/csky/abiv1/cacheflush.c                 |  32 +++--
 arch/csky/abiv1/inc/abi/cacheflush.h         |   3 +-
 arch/csky/abiv2/cacheflush.c                 |  32 ++---
 arch/csky/abiv2/inc/abi/cacheflush.h         |  11 +-
 arch/csky/include/asm/pgtable.h              |   8 +-
 arch/hexagon/include/asm/cacheflush.h        |  10 +-
 arch/hexagon/include/asm/pgtable.h           |   9 +-
 arch/ia64/hp/common/sba_iommu.c              |  26 ++--
 arch/ia64/include/asm/cacheflush.h           |  14 ++-
 arch/ia64/include/asm/pgtable.h              |   4 +-
 arch/ia64/mm/init.c                          |  28 +++--
 arch/loongarch/include/asm/cacheflush.h      |   1 -
 arch/loongarch/include/asm/pgtable-bits.h    |   4 +-
 arch/loongarch/include/asm/pgtable.h         |  33 ++---
 arch/loongarch/mm/pgtable.c                  |   2 +-
 arch/loongarch/mm/tlb.c                      |   2 +-
 arch/m68k/include/asm/cacheflush_mm.h        |  26 ++--
 arch/m68k/include/asm/mcf_pgtable.h          |   1 +
 arch/m68k/include/asm/motorola_pgtable.h     |   1 +
 arch/m68k/include/asm/pgtable_mm.h           |  10 +-
 arch/m68k/include/asm/sun3_pgtable.h         |   1 +
 arch/m68k/mm/motorola.c                      |   2 +-
 arch/microblaze/include/asm/cacheflush.h     |   8 ++
 arch/microblaze/include/asm/pgtable.h        |  15 +--
 arch/microblaze/include/asm/tlbflush.h       |   4 +-
 arch/mips/bcm47xx/prom.c                     |   2 +-
 arch/mips/include/asm/cacheflush.h           |  32 ++---
 arch/mips/include/asm/pgtable-32.h           |  10 +-
 arch/mips/include/asm/pgtable-64.h           |   6 +-
 arch/mips/include/asm/pgtable-bits.h         |   6 +-
 arch/mips/include/asm/pgtable.h              |  63 ++++++----
 arch/mips/mm/c-r4k.c                         |   5 +-
 arch/mips/mm/cache.c                         |  56 ++++-----
 arch/mips/mm/init.c                          |  21 ++--
 arch/mips/mm/pgtable-32.c                    |   2 +-
 arch/mips/mm/pgtable-64.c                    |   2 +-
 arch/mips/mm/tlbex.c                         |   2 +-
 arch/nios2/include/asm/cacheflush.h          |   6 +-
 arch/nios2/include/asm/pgtable.h             |  28 +++--
 arch/nios2/mm/cacheflush.c                   |  79 ++++++------
 arch/openrisc/include/asm/cacheflush.h       |   8 +-
 arch/openrisc/include/asm/pgtable.h          |  15 ++-
 arch/openrisc/mm/cache.c                     |  12 +-
 arch/parisc/include/asm/cacheflush.h         |  14 ++-
 arch/parisc/include/asm/pgtable.h            |  37 +++---
 arch/parisc/kernel/cache.c                   | 107 +++++++++++-----
 arch/powerpc/include/asm/book3s/32/pgtable.h |   5 -
 arch/powerpc/include/asm/book3s/64/pgtable.h |   6 +-
 arch/powerpc/include/asm/book3s/pgtable.h    |  11 +-
 arch/powerpc/include/asm/cacheflush.h        |  14 ++-
 arch/powerpc/include/asm/kvm_ppc.h           |  10 +-
 arch/powerpc/include/asm/nohash/pgtable.h    |  16 +--
 arch/powerpc/include/asm/pgtable.h           |  12 ++
 arch/powerpc/mm/book3s64/hash_utils.c        |  11 +-
 arch/powerpc/mm/cacheflush.c                 |  40 ++----
 arch/powerpc/mm/nohash/e500_hugetlbpage.c    |   3 +-
 arch/powerpc/mm/pgtable.c                    |  51 ++++----
 arch/riscv/include/asm/cacheflush.h          |  19 ++-
 arch/riscv/include/asm/pgtable.h             |  38 ++++--
 arch/riscv/mm/cacheflush.c                   |  13 +-
 arch/s390/include/asm/pgtable.h              |  33 +++--
 arch/sh/include/asm/cacheflush.h             |  21 ++--
 arch/sh/include/asm/pgtable.h                |   7 +-
 arch/sh/include/asm/pgtable_32.h             |   5 +-
 arch/sh/mm/cache-j2.c                        |   4 +-
 arch/sh/mm/cache-sh4.c                       |  26 ++--
 arch/sh/mm/cache-sh7705.c                    |  26 ++--
 arch/sh/mm/cache.c                           |  52 ++++----
 arch/sh/mm/kmap.c                            |   3 +-
 arch/sparc/include/asm/cacheflush_32.h       |   9 +-
 arch/sparc/include/asm/cacheflush_64.h       |  19 +--
 arch/sparc/include/asm/pgtable_32.h          |   8 +-
 arch/sparc/include/asm/pgtable_64.h          |  24 +++-
 arch/sparc/kernel/smp_64.c                   |  56 ++++++---
 arch/sparc/mm/init_32.c                      |  13 +-
 arch/sparc/mm/init_64.c                      |  78 +++++++-----
 arch/sparc/mm/tlb.c                          |   5 +-
 arch/um/include/asm/pgtable.h                |   7 +-
 arch/x86/include/asm/pgtable.h               |  14 +--
 arch/xtensa/include/asm/cacheflush.h         |  11 +-
 arch/xtensa/include/asm/pgtable.h            |  18 ++-
 arch/xtensa/mm/cache.c                       |  83 +++++++------
 include/asm-generic/cacheflush.h             |   7 --
 include/linux/cacheflush.h                   |  13 +-
 include/linux/minmax.h                       |  26 ++++
 include/linux/mm.h                           |   3 +-
 include/linux/page_table_check.h             |  14 +--
 include/linux/pagemap.h                      |  28 +++--
 include/linux/pgtable.h                      |  31 +++++
 include/linux/rmap.h                         |   2 +
 mm/filemap.c                                 | 123 +++++++++++--------
 mm/memory.c                                  |  56 +++++----
 mm/page_table_check.c                        |  14 ++-
 mm/rmap.c                                    |  60 ++++++---
 mm/util.c                                    |   2 +-
 119 files changed, 1452 insertions(+), 974 deletions(-)

-- 
2.39.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28712488F1
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHRPQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHRPQt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 11:16:49 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140422054F;
        Tue, 18 Aug 2020 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763808;
        bh=pWqW8YgLG90UU3p8BWQ4xo9QKFARTHRes7KpRDQutEY=;
        h=From:To:Cc:Subject:Date:From;
        b=mZ4Dw/78TkBwbT4zckybu8GS6IeYljCyckNW7F7V9LPqkH0uP6lZLns364B8ofjDq
         g40MFxNJ9gEv01k6pNkEpjYOvmf4wvbJAjpvy8rkOX3Ub/pu7s4r9Q//DEwKnW4wz3
         DIa8FLdmh9cooXoz1dI6BSyEhKPCYBl/+8BDlFOg=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Axtens <dja@axtens.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: [PATCH v3 00/17] memblock: seasonal cleaning^w cleanup
Date:   Tue, 18 Aug 2020 18:16:17 +0300
Message-Id: <20200818151634.14343-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches simplify several uses of memblock iterators and hide some of
the memblock implementation details from the rest of the system.

The patches are on top of v5.9-rc1

v3 changes:
* rebase on v5.9-rc1, as the result this required some non-trivial changes
  in patches 10 and 16. I didn't add Baoquan's Reviewed-by to theses
  patches, but I keept Thomas and Miguel
* Add Acked-by from Thomas and Miguel as there were changes in MIPS and
  only trivial changes in .clang-format
* Added Reviewed-by from Baoquan except for the patches 10 and 16
* Fixed misc build errors and warnings reported by kbuild bot
* Updated PowerPC KVM reservation size (patch 2), as per Daniel's comment

v2 changes:
* replace for_each_memblock() with two versions, one for memblock.memory
  and another one for memblock.reserved
* fix overzealous cleanup of powerpc fadamp: keep the traversal over the
  memblocks, but use better suited iterators
* don't remove traversal over memblock.reserved in x86 numa cleanup but
  replace for_each_memblock() with new for_each_reserved_mem_region()
* simplify ramdisk and crash kernel allocations on x86
* drop more redundant and unused code: __next_reserved_mem_region() and
  memblock_mem_size()
* add description of numa initialization fix on arm64 (thanks Jonathan)
* add Acked and Reviewed tags

Mike Rapoport (17):
  KVM: PPC: Book3S HV: simplify kvm_cma_reserve()
  dma-contiguous: simplify cma_early_percent_memory()
  arm, xtensa: simplify initialization of high memory pages
  arm64: numa: simplify dummy_numa_init()
  h8300, nds32, openrisc: simplify detection of memory extents
  riscv: drop unneeded node initialization
  mircoblaze: drop unneeded NUMA and sparsemem initializations
  memblock: make for_each_memblock_type() iterator private
  memblock: make memblock_debug and related functionality private
  memblock: reduce number of parameters in for_each_mem_range()
  arch, mm: replace for_each_memblock() with for_each_mem_pfn_range()
  arch, drivers: replace for_each_membock() with for_each_mem_range()
  x86/setup: simplify initrd relocation and reservation
  x86/setup: simplify reserve_crashkernel()
  memblock: remove unused memblock_mem_size()
  memblock: implement for_each_reserved_mem_region() using
    __next_mem_region()
  memblock: use separate iterators for memory and reserved regions

 .clang-format                            |  5 +-
 arch/arm/kernel/setup.c                  | 18 +++--
 arch/arm/mm/init.c                       | 59 +++------------
 arch/arm/mm/mmu.c                        | 39 ++++------
 arch/arm/mm/pmsa-v7.c                    | 23 +++---
 arch/arm/mm/pmsa-v8.c                    | 17 ++---
 arch/arm/xen/mm.c                        |  7 +-
 arch/arm64/kernel/machine_kexec_file.c   |  6 +-
 arch/arm64/kernel/setup.c                |  4 +-
 arch/arm64/mm/init.c                     | 11 +--
 arch/arm64/mm/kasan_init.c               | 10 +--
 arch/arm64/mm/mmu.c                      | 11 +--
 arch/arm64/mm/numa.c                     | 15 ++--
 arch/c6x/kernel/setup.c                  |  9 ++-
 arch/h8300/kernel/setup.c                |  8 +-
 arch/microblaze/mm/init.c                | 21 ++----
 arch/mips/cavium-octeon/dma-octeon.c     | 12 +--
 arch/mips/kernel/setup.c                 | 31 ++++----
 arch/mips/netlogic/xlp/setup.c           |  2 +-
 arch/nds32/kernel/setup.c                |  8 +-
 arch/openrisc/kernel/setup.c             |  9 +--
 arch/openrisc/mm/init.c                  |  8 +-
 arch/powerpc/kernel/fadump.c             | 57 +++++++-------
 arch/powerpc/kexec/file_load_64.c        | 16 ++--
 arch/powerpc/kvm/book3s_hv_builtin.c     | 12 +--
 arch/powerpc/mm/book3s64/hash_utils.c    | 16 ++--
 arch/powerpc/mm/book3s64/radix_pgtable.c | 10 +--
 arch/powerpc/mm/kasan/kasan_init_32.c    |  8 +-
 arch/powerpc/mm/mem.c                    | 33 ++++----
 arch/powerpc/mm/numa.c                   |  7 +-
 arch/powerpc/mm/pgtable_32.c             |  8 +-
 arch/riscv/mm/init.c                     | 36 +++------
 arch/riscv/mm/kasan_init.c               | 10 +--
 arch/s390/kernel/setup.c                 | 27 ++++---
 arch/s390/mm/page-states.c               |  6 +-
 arch/s390/mm/vmem.c                      |  7 +-
 arch/sh/mm/init.c                        |  9 +--
 arch/sparc/mm/init_64.c                  | 12 +--
 arch/x86/kernel/setup.c                  | 56 +++++---------
 arch/x86/mm/numa.c                       |  2 +-
 arch/xtensa/mm/init.c                    | 55 +++-----------
 drivers/bus/mvebu-mbus.c                 | 12 +--
 drivers/irqchip/irq-gic-v3-its.c         |  2 +-
 include/linux/memblock.h                 | 88 +++++++++++++---------
 kernel/dma/contiguous.c                  | 11 +--
 mm/memblock.c                            | 95 ++++++++++--------------
 mm/page_alloc.c                          | 11 ++-
 mm/sparse.c                              | 10 +--
 48 files changed, 387 insertions(+), 562 deletions(-)

-- 
2.26.2


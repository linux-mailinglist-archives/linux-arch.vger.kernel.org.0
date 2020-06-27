Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374A20C215
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgF0OfH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 10:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0OfG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 10:35:06 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341C22089D;
        Sat, 27 Jun 2020 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593268505;
        bh=qu2PC/KfnpK0kWKvuL7CXpDG7X/LanYdYjS7VhuA2tc=;
        h=From:To:Cc:Subject:Date:From;
        b=FBB5WzdHZCyO5w4PctPzcY7Z3LAstOygEoRUhk/Ng1G+Z4/lWOJE048kW7zjqiOhR
         IdlIfwSDXvF8p9LDdqBSj5MmgeYKrg3f6jEZKT4anjo+p6hHbu6Ts9fIOvn7KQVkjy
         XGJTIYBUuYdW9Ish6HFB+sclhFQo+pGzuMIA9dOg=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 0/8] mm: cleanup usage of <asm/pgalloc.h>
Date:   Sat, 27 Jun 2020 17:34:45 +0300
Message-Id: <20200627143453.31835-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Most architectures have very similar versions of pXd_alloc_one() and
pXd_free_one() for intermediate levels of page table. 
These patches add generic versions of these functions in
<asm-generic/pgalloc.h> and enable use of the generic functions where
appropriate.

In addition, functions declared and defined in <asm/pgalloc.h> headers
are used mostly by core mm and early mm initialization in arch and there is
no actual reason to have the <asm/pgalloc.h> included all over the place.
The first patch in this series removes unneeded includes of <asm/pgalloc.h>

In the end it didn't work out as neatly as I hoped and moving
pXd_alloc_track() definitions to <asm-generic/pgalloc.h> would require
unnecessary changes to arches that have custom page table allocations, so
I've decided to move lib/ioremap.c to mm/ and make pgalloc-track.h local to
mm/.

Joerg Roedel (1):
  mm: move p?d_alloc_track to separate header file

Mike Rapoport (7):
  mm: remove unneeded includes of <asm/pgalloc.h>
  opeinrisc: switch to generic version of pte allocation
  xtensa: switch to generic version of pte allocation
  asm-generic: pgalloc: provide generic pmd_alloc_one() and pmd_free_one()
  asm-generic: pgalloc: provide generic pud_alloc_one() and pud_free_one()
  asm-generic: pgalloc: provide generic pgd_free()
  mm: move lib/ioremap.c to mm/

 arch/alpha/include/asm/pgalloc.h             | 21 +----
 arch/alpha/include/asm/tlbflush.h            |  1 -
 arch/alpha/kernel/core_irongate.c            |  1 -
 arch/alpha/kernel/core_marvel.c              |  1 -
 arch/alpha/kernel/core_titan.c               |  1 -
 arch/alpha/kernel/machvec_impl.h             |  2 -
 arch/alpha/kernel/smp.c                      |  1 -
 arch/alpha/mm/numa.c                         |  1 -
 arch/arc/mm/fault.c                          |  1 -
 arch/arc/mm/init.c                           |  1 -
 arch/arm/include/asm/pgalloc.h               | 12 +--
 arch/arm/include/asm/tlb.h                   |  1 -
 arch/arm/kernel/machine_kexec.c              |  1 -
 arch/arm/kernel/smp.c                        |  1 -
 arch/arm/kernel/suspend.c                    |  1 -
 arch/arm/mach-omap2/omap-mpuss-lowpower.c    |  1 -
 arch/arm/mm/hugetlbpage.c                    |  1 -
 arch/arm/mm/mmu.c                            |  1 +
 arch/arm64/include/asm/pgalloc.h             | 39 +---------
 arch/arm64/kernel/smp.c                      |  1 -
 arch/arm64/mm/hugetlbpage.c                  |  1 -
 arch/arm64/mm/ioremap.c                      |  1 -
 arch/arm64/mm/mmu.c                          |  1 +
 arch/csky/include/asm/pgalloc.h              |  7 +-
 arch/csky/kernel/smp.c                       |  1 -
 arch/hexagon/include/asm/pgalloc.h           |  7 +-
 arch/ia64/include/asm/pgalloc.h              | 24 ------
 arch/ia64/include/asm/tlb.h                  |  1 -
 arch/ia64/kernel/process.c                   |  1 -
 arch/ia64/kernel/smp.c                       |  1 -
 arch/ia64/kernel/smpboot.c                   |  1 -
 arch/ia64/mm/contig.c                        |  1 -
 arch/ia64/mm/discontig.c                     |  1 -
 arch/ia64/mm/hugetlbpage.c                   |  1 -
 arch/ia64/mm/tlb.c                           |  1 -
 arch/m68k/include/asm/mmu_context.h          |  2 +-
 arch/m68k/include/asm/sun3_pgalloc.h         |  7 +-
 arch/m68k/kernel/dma.c                       |  2 +-
 arch/m68k/kernel/traps.c                     |  3 +-
 arch/m68k/mm/cache.c                         |  2 +-
 arch/m68k/mm/fault.c                         |  1 -
 arch/m68k/mm/kmap.c                          |  2 +-
 arch/m68k/mm/mcfmmu.c                        |  1 +
 arch/m68k/mm/memory.c                        |  1 -
 arch/m68k/sun3x/dvma.c                       |  2 +-
 arch/microblaze/include/asm/pgalloc.h        |  6 --
 arch/microblaze/include/asm/tlbflush.h       |  1 -
 arch/microblaze/kernel/process.c             |  1 -
 arch/microblaze/kernel/signal.c              |  1 -
 arch/mips/include/asm/pgalloc.h              | 19 +----
 arch/mips/sgi-ip32/ip32-memory.c             |  1 -
 arch/nds32/mm/mm-nds32.c                     |  2 +
 arch/nios2/include/asm/pgalloc.h             |  7 +-
 arch/openrisc/include/asm/pgalloc.h          | 33 +-------
 arch/openrisc/include/asm/tlbflush.h         |  1 -
 arch/openrisc/kernel/or32_ksyms.c            |  1 -
 arch/parisc/include/asm/mmu_context.h        |  1 -
 arch/parisc/include/asm/pgalloc.h            | 12 +--
 arch/parisc/kernel/cache.c                   |  1 -
 arch/parisc/kernel/pci-dma.c                 |  1 -
 arch/parisc/kernel/process.c                 |  1 -
 arch/parisc/kernel/signal.c                  |  1 -
 arch/parisc/kernel/smp.c                     |  1 -
 arch/parisc/mm/hugetlbpage.c                 |  1 -
 arch/parisc/mm/ioremap.c                     |  2 +-
 arch/powerpc/include/asm/tlb.h               |  1 -
 arch/powerpc/mm/book3s64/hash_hugetlbpage.c  |  1 -
 arch/powerpc/mm/book3s64/hash_pgtable.c      |  1 -
 arch/powerpc/mm/book3s64/hash_tlb.c          |  1 -
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c |  1 -
 arch/powerpc/mm/init_32.c                    |  1 -
 arch/powerpc/mm/kasan/8xx.c                  |  1 -
 arch/powerpc/mm/kasan/book3s_32.c            |  1 -
 arch/powerpc/mm/mem.c                        |  1 -
 arch/powerpc/mm/nohash/40x.c                 |  1 -
 arch/powerpc/mm/nohash/8xx.c                 |  1 -
 arch/powerpc/mm/nohash/fsl_booke.c           |  1 -
 arch/powerpc/mm/nohash/kaslr_booke.c         |  1 -
 arch/powerpc/mm/pgtable.c                    |  1 -
 arch/powerpc/mm/pgtable_64.c                 |  1 -
 arch/powerpc/mm/ptdump/hashpagetable.c       |  2 +-
 arch/powerpc/mm/ptdump/ptdump.c              |  1 -
 arch/powerpc/platforms/pseries/cmm.c         |  1 -
 arch/riscv/include/asm/pgalloc.h             | 18 +----
 arch/riscv/mm/fault.c                        |  1 -
 arch/s390/include/asm/tlb.h                  |  1 -
 arch/s390/include/asm/tlbflush.h             |  1 -
 arch/s390/kernel/machine_kexec.c             |  1 -
 arch/s390/kernel/ptrace.c                    |  1 -
 arch/s390/kvm/diag.c                         |  1 -
 arch/s390/kvm/priv.c                         |  1 -
 arch/s390/kvm/pv.c                           |  1 -
 arch/s390/mm/cmm.c                           |  1 -
 arch/s390/mm/mmap.c                          |  1 -
 arch/s390/mm/pgtable.c                       |  1 -
 arch/sh/include/asm/pgalloc.h                |  4 +
 arch/sh/kernel/idle.c                        |  1 -
 arch/sh/kernel/machine_kexec.c               |  1 -
 arch/sh/mm/cache-sh3.c                       |  1 -
 arch/sh/mm/cache-sh7705.c                    |  1 -
 arch/sh/mm/hugetlbpage.c                     |  1 -
 arch/sh/mm/init.c                            |  1 +
 arch/sh/mm/ioremap_fixed.c                   |  1 -
 arch/sh/mm/tlb-sh3.c                         |  1 -
 arch/sparc/include/asm/ide.h                 |  1 -
 arch/sparc/include/asm/tlb_64.h              |  1 -
 arch/sparc/kernel/leon_smp.c                 |  1 -
 arch/sparc/kernel/process_32.c               |  1 -
 arch/sparc/kernel/signal_32.c                |  1 -
 arch/sparc/kernel/smp_32.c                   |  1 -
 arch/sparc/kernel/smp_64.c                   |  1 +
 arch/sparc/kernel/sun4m_irq.c                |  1 -
 arch/sparc/mm/highmem.c                      |  1 -
 arch/sparc/mm/io-unit.c                      |  1 -
 arch/sparc/mm/iommu.c                        |  1 -
 arch/sparc/mm/tlb.c                          |  1 -
 arch/um/include/asm/pgalloc.h                |  9 +--
 arch/um/include/asm/pgtable-3level.h         |  3 -
 arch/um/kernel/mem.c                         | 17 -----
 arch/x86/ia32/ia32_aout.c                    |  1 -
 arch/x86/include/asm/mmu_context.h           |  1 -
 arch/x86/include/asm/pgalloc.h               | 42 +---------
 arch/x86/kernel/alternative.c                |  1 +
 arch/x86/kernel/apic/apic.c                  |  1 -
 arch/x86/kernel/mpparse.c                    |  1 -
 arch/x86/kernel/traps.c                      |  1 -
 arch/x86/mm/fault.c                          |  1 -
 arch/x86/mm/hugetlbpage.c                    |  1 -
 arch/x86/mm/kaslr.c                          |  1 -
 arch/x86/mm/pgtable_32.c                     |  1 -
 arch/x86/mm/pti.c                            |  1 -
 arch/x86/platform/uv/bios_uv.c               |  1 +
 arch/xtensa/include/asm/pgalloc.h            | 40 ++++------
 arch/xtensa/kernel/xtensa_ksyms.c            |  1 -
 arch/xtensa/mm/cache.c                       |  1 -
 arch/xtensa/mm/fault.c                       |  1 -
 drivers/block/xen-blkback/common.h           |  1 -
 drivers/iommu/ipmmu-vmsa.c                   |  1 -
 drivers/xen/balloon.c                        |  1 -
 drivers/xen/privcmd.c                        |  1 -
 fs/binfmt_elf_fdpic.c                        |  1 -
 include/asm-generic/pgalloc.h                | 80 ++++++++++++++++++++
 include/asm-generic/tlb.h                    |  1 -
 include/linux/mm.h                           | 45 -----------
 lib/Makefile                                 |  1 -
 mm/Makefile                                  |  2 +-
 mm/hugetlb.c                                 |  1 +
 {lib => mm}/ioremap.c                        |  2 +
 mm/pgalloc-track.h                           | 51 +++++++++++++
 mm/sparse.c                                  |  1 -
 mm/vmalloc.c                                 |  1 +
 151 files changed, 194 insertions(+), 451 deletions(-)
 rename {lib => mm}/ioremap.c (99%)
 create mode 100644 mm/pgalloc-track.h

-- 
2.26.2


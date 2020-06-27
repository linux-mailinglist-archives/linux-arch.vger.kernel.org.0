Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39DA20C21F
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgF0OfS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 10:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgF0OfR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 10:35:17 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CCC21883;
        Sat, 27 Jun 2020 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593268514;
        bh=Upcx5YXpXc1/2z61L5MYFWAiQMVURxec4fvWjCUtfOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btfs2U/uQrv0j/2rDQcAgVB9BJ+mEXjhIUfVV7HZilgyFXxpLsAJjpmAWlBVSqhGY
         S2rbcSkx8BB5gV0gTVjtCKC4bVgCBxHm0SWPhWD84wNELcHQOjjQW8VpQSQbU9eglX
         WfDsDl2551Y2y2Fr8jSLVcrLUW2Z38WiSTf0fXH8=
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
Subject: [PATCH 1/8] mm: remove unneeded includes of <asm/pgalloc.h>
Date:   Sat, 27 Jun 2020 17:34:46 +0300
Message-Id: <20200627143453.31835-2-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

In the most cases <asm/pgalloc.h> header is required only for allocations
of page table memory. Most of the .c files that include that header do not
use symbols declared in <asm/pgalloc.h> and do not require that header.

As for the other header files that used to include <asm/pgalloc.h>, it is
possible to move that include into the .c file that actually uses symbols
from <asm/pgalloc.h> and drop the include from the header file.

The process was somewhat automated using

	sed -i -E '/[<"]asm\/pgalloc\.h/d' \
                $(grep -L -w -f /tmp/xx \
                        $(git grep -E -l '[<"]asm/pgalloc\.h'))

where /tmp/xx contains all the symbols defined in
arch/*/include/asm/pgalloc.h.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/tlbflush.h            | 1 -
 arch/alpha/kernel/core_irongate.c            | 1 -
 arch/alpha/kernel/core_marvel.c              | 1 -
 arch/alpha/kernel/core_titan.c               | 1 -
 arch/alpha/kernel/machvec_impl.h             | 2 --
 arch/alpha/kernel/smp.c                      | 1 -
 arch/alpha/mm/numa.c                         | 1 -
 arch/arc/mm/fault.c                          | 1 -
 arch/arc/mm/init.c                           | 1 -
 arch/arm/include/asm/tlb.h                   | 1 -
 arch/arm/kernel/machine_kexec.c              | 1 -
 arch/arm/kernel/smp.c                        | 1 -
 arch/arm/kernel/suspend.c                    | 1 -
 arch/arm/mach-omap2/omap-mpuss-lowpower.c    | 1 -
 arch/arm/mm/hugetlbpage.c                    | 1 -
 arch/arm/mm/mmu.c                            | 1 +
 arch/arm64/kernel/smp.c                      | 1 -
 arch/arm64/mm/hugetlbpage.c                  | 1 -
 arch/arm64/mm/ioremap.c                      | 1 -
 arch/arm64/mm/mmu.c                          | 1 +
 arch/csky/kernel/smp.c                       | 1 -
 arch/ia64/include/asm/tlb.h                  | 1 -
 arch/ia64/kernel/process.c                   | 1 -
 arch/ia64/kernel/smp.c                       | 1 -
 arch/ia64/kernel/smpboot.c                   | 1 -
 arch/ia64/mm/contig.c                        | 1 -
 arch/ia64/mm/discontig.c                     | 1 -
 arch/ia64/mm/hugetlbpage.c                   | 1 -
 arch/ia64/mm/tlb.c                           | 1 -
 arch/m68k/include/asm/mmu_context.h          | 2 +-
 arch/m68k/kernel/dma.c                       | 2 +-
 arch/m68k/kernel/traps.c                     | 3 +--
 arch/m68k/mm/cache.c                         | 2 +-
 arch/m68k/mm/fault.c                         | 1 -
 arch/m68k/mm/kmap.c                          | 2 +-
 arch/m68k/mm/mcfmmu.c                        | 1 +
 arch/m68k/mm/memory.c                        | 1 -
 arch/m68k/sun3x/dvma.c                       | 2 +-
 arch/microblaze/include/asm/tlbflush.h       | 1 -
 arch/microblaze/kernel/process.c             | 1 -
 arch/microblaze/kernel/signal.c              | 1 -
 arch/mips/sgi-ip32/ip32-memory.c             | 1 -
 arch/openrisc/include/asm/tlbflush.h         | 1 -
 arch/openrisc/kernel/or32_ksyms.c            | 1 -
 arch/parisc/include/asm/mmu_context.h        | 1 -
 arch/parisc/kernel/cache.c                   | 1 -
 arch/parisc/kernel/pci-dma.c                 | 1 -
 arch/parisc/kernel/process.c                 | 1 -
 arch/parisc/kernel/signal.c                  | 1 -
 arch/parisc/kernel/smp.c                     | 1 -
 arch/parisc/mm/hugetlbpage.c                 | 1 -
 arch/parisc/mm/ioremap.c                     | 2 +-
 arch/powerpc/include/asm/tlb.h               | 1 -
 arch/powerpc/mm/book3s64/hash_hugetlbpage.c  | 1 -
 arch/powerpc/mm/book3s64/hash_pgtable.c      | 1 -
 arch/powerpc/mm/book3s64/hash_tlb.c          | 1 -
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c | 1 -
 arch/powerpc/mm/init_32.c                    | 1 -
 arch/powerpc/mm/kasan/8xx.c                  | 1 -
 arch/powerpc/mm/kasan/book3s_32.c            | 1 -
 arch/powerpc/mm/mem.c                        | 1 -
 arch/powerpc/mm/nohash/40x.c                 | 1 -
 arch/powerpc/mm/nohash/8xx.c                 | 1 -
 arch/powerpc/mm/nohash/fsl_booke.c           | 1 -
 arch/powerpc/mm/nohash/kaslr_booke.c         | 1 -
 arch/powerpc/mm/pgtable.c                    | 1 -
 arch/powerpc/mm/pgtable_64.c                 | 1 -
 arch/powerpc/mm/ptdump/hashpagetable.c       | 2 +-
 arch/powerpc/mm/ptdump/ptdump.c              | 1 -
 arch/powerpc/platforms/pseries/cmm.c         | 1 -
 arch/riscv/mm/fault.c                        | 1 -
 arch/s390/include/asm/tlb.h                  | 1 -
 arch/s390/include/asm/tlbflush.h             | 1 -
 arch/s390/kernel/machine_kexec.c             | 1 -
 arch/s390/kernel/ptrace.c                    | 1 -
 arch/s390/kvm/diag.c                         | 1 -
 arch/s390/kvm/priv.c                         | 1 -
 arch/s390/kvm/pv.c                           | 1 -
 arch/s390/mm/cmm.c                           | 1 -
 arch/s390/mm/mmap.c                          | 1 -
 arch/s390/mm/pgtable.c                       | 1 -
 arch/sh/kernel/idle.c                        | 1 -
 arch/sh/kernel/machine_kexec.c               | 1 -
 arch/sh/mm/cache-sh3.c                       | 1 -
 arch/sh/mm/cache-sh7705.c                    | 1 -
 arch/sh/mm/hugetlbpage.c                     | 1 -
 arch/sh/mm/init.c                            | 1 +
 arch/sh/mm/ioremap_fixed.c                   | 1 -
 arch/sh/mm/tlb-sh3.c                         | 1 -
 arch/sparc/include/asm/ide.h                 | 1 -
 arch/sparc/include/asm/tlb_64.h              | 1 -
 arch/sparc/kernel/leon_smp.c                 | 1 -
 arch/sparc/kernel/process_32.c               | 1 -
 arch/sparc/kernel/signal_32.c                | 1 -
 arch/sparc/kernel/smp_32.c                   | 1 -
 arch/sparc/kernel/smp_64.c                   | 1 +
 arch/sparc/kernel/sun4m_irq.c                | 1 -
 arch/sparc/mm/highmem.c                      | 1 -
 arch/sparc/mm/io-unit.c                      | 1 -
 arch/sparc/mm/iommu.c                        | 1 -
 arch/sparc/mm/tlb.c                          | 1 -
 arch/x86/ia32/ia32_aout.c                    | 1 -
 arch/x86/include/asm/mmu_context.h           | 1 -
 arch/x86/kernel/alternative.c                | 1 +
 arch/x86/kernel/apic/apic.c                  | 1 -
 arch/x86/kernel/mpparse.c                    | 1 -
 arch/x86/kernel/traps.c                      | 1 -
 arch/x86/mm/fault.c                          | 1 -
 arch/x86/mm/hugetlbpage.c                    | 1 -
 arch/x86/mm/kaslr.c                          | 1 -
 arch/x86/mm/pgtable_32.c                     | 1 -
 arch/x86/mm/pti.c                            | 1 -
 arch/x86/platform/uv/bios_uv.c               | 1 +
 arch/xtensa/kernel/xtensa_ksyms.c            | 1 -
 arch/xtensa/mm/cache.c                       | 1 -
 arch/xtensa/mm/fault.c                       | 1 -
 drivers/block/xen-blkback/common.h           | 1 -
 drivers/iommu/ipmmu-vmsa.c                   | 1 -
 drivers/xen/balloon.c                        | 1 -
 drivers/xen/privcmd.c                        | 1 -
 fs/binfmt_elf_fdpic.c                        | 1 -
 include/asm-generic/tlb.h                    | 1 -
 mm/hugetlb.c                                 | 1 +
 mm/sparse.c                                  | 1 -
 124 files changed, 16 insertions(+), 118 deletions(-)

diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index f8b492408f51..94dc37cf873a 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -5,7 +5,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <asm/compiler.h>
-#include <asm/pgalloc.h>
 
 #ifndef __EXTERN_INLINE
 #define __EXTERN_INLINE extern inline
diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index a9fd133a7fb2..72af1e72d833 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -302,7 +302,6 @@ irongate_init_arch(void)
 #include <linux/agp_backend.h>
 #include <linux/agpgart.h>
 #include <linux/export.h>
-#include <asm/pgalloc.h>
 
 #define GET_PAGE_DIR_OFF(addr) (addr >> 22)
 #define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr))
diff --git a/arch/alpha/kernel/core_marvel.c b/arch/alpha/kernel/core_marvel.c
index 1db9d0eb2922..4c80d992a659 100644
--- a/arch/alpha/kernel/core_marvel.c
+++ b/arch/alpha/kernel/core_marvel.c
@@ -23,7 +23,6 @@
 #include <asm/ptrace.h>
 #include <asm/smp.h>
 #include <asm/gct.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/vga.h>
 
diff --git a/arch/alpha/kernel/core_titan.c b/arch/alpha/kernel/core_titan.c
index 2a2820fb1be6..77f5d68ed04b 100644
--- a/arch/alpha/kernel/core_titan.c
+++ b/arch/alpha/kernel/core_titan.c
@@ -20,7 +20,6 @@
 
 #include <asm/ptrace.h>
 #include <asm/smp.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/vga.h>
 
diff --git a/arch/alpha/kernel/machvec_impl.h b/arch/alpha/kernel/machvec_impl.h
index 38f045ec5cd2..393d5d6ca5d2 100644
--- a/arch/alpha/kernel/machvec_impl.h
+++ b/arch/alpha/kernel/machvec_impl.h
@@ -7,8 +7,6 @@
  * This file has goodies to help simplify instantiation of machine vectors.
  */
 
-#include <asm/pgalloc.h>
-
 /* Whee.  These systems don't have an HAE:
        IRONGATE, MARVEL, POLARIS, TSUNAMI, TITAN, WILDFIRE
    Fix things up for the GENERIC kernel by defining the HAE address
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 631cc17410d1..f4dd9f3f3001 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -36,7 +36,6 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index 5ad6087de1d6..0636e254a22f 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 
 #include <asm/hwrpb.h>
-#include <asm/pgalloc.h>
 #include <asm/sections.h>
 
 pg_data_t node_data[MAX_NUMNODES];
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 72f5405a7ec5..7287c793d1c9 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -13,7 +13,6 @@
 #include <linux/kdebug.h>
 #include <linux/perf_event.h>
 #include <linux/mm_types.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu.h>
 
 /*
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index e7bdc2ac1c87..f886ac69d8ad 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/arcregs.h>
 
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 4d4e7b6aabff..9415222b49ad 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -27,7 +27,6 @@
 #else /* !CONFIG_MMU */
 
 #include <linux/swap.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 974b6c64d3e6..5d84ad333f05 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -11,7 +11,6 @@
 #include <linux/irq.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/fncpy.h>
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 9a6432557871..5d9da61eff62 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -37,7 +37,6 @@
 #include <asm/idmap.h>
 #include <asm/topology.h>
 #include <asm/mmu_context.h>
-#include <asm/pgalloc.h>
 #include <asm/procinfo.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index d2c9338d74e8..24bd20564be7 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -7,7 +7,6 @@
 #include <asm/bugs.h>
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
-#include <asm/pgalloc.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 67fa28532a3a..9fba98c2313a 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -42,7 +42,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/smp_scu.h>
-#include <asm/pgalloc.h>
 #include <asm/suspend.h>
 #include <asm/virt.h>
 #include <asm/hardware/cache-l2x0.h>
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index a1e5aace897a..dd7a0277c5c0 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -17,7 +17,6 @@
 #include <asm/mman.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
-#include <asm/pgalloc.h>
 
 /*
  * On ARM, huge pages are backed by pmd's rather than pte's, so we do a lot
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 628028bfbb92..cecf5a5e0f6f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -29,6 +29,7 @@
 #include <asm/traps.h>
 #include <asm/procinfo.h>
 #include <asm/memory.h>
+#include <asm/pgalloc.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index e43a8ff19f0f..8059d50bc8cb 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -43,7 +43,6 @@
 #include <asm/kvm_mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/smp_plat.h>
 #include <asm/sections.h>
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 0a52ce46f020..e8a9842157f5 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -17,7 +17,6 @@
 #include <asm/mman.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
-#include <asm/pgalloc.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h)
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 9be71bee902c..b5e83c46b23e 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -16,7 +16,6 @@
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
-#include <asm/pgalloc.h>
 
 static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
 				      pgprot_t prot, void *caller)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..cafefb147a5e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -35,6 +35,7 @@
 #include <asm/mmu_context.h>
 #include <asm/ptdump.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b5c5bc3afeb5..938910280ddc 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -21,7 +21,6 @@
 #include <asm/traps.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
-#include <asm/pgalloc.h>
 #ifdef CONFIG_CPU_HAS_FPU
 #include <abi/fpu.h>
 #endif
diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
index f1f257d632b3..8d9da6f08a62 100644
--- a/arch/ia64/include/asm/tlb.h
+++ b/arch/ia64/include/asm/tlb.h
@@ -42,7 +42,6 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 96dfb9e4b16f..77e0f6242bf9 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -40,7 +40,6 @@
 #include <asm/elf.h>
 #include <asm/irq.h>
 #include <asm/kexec.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/sal.h>
 #include <asm/switch_to.h>
diff --git a/arch/ia64/kernel/smp.c b/arch/ia64/kernel/smp.c
index bbfd421e6deb..0e2742003121 100644
--- a/arch/ia64/kernel/smp.c
+++ b/arch/ia64/kernel/smp.c
@@ -39,7 +39,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 016683b743c2..c29c600d7967 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -49,7 +49,6 @@
 #include <asm/irq.h>
 #include <asm/mca.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index d7d31c718d2d..e30e360beef8 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -21,7 +21,6 @@
 #include <linux/swap.h>
 
 #include <asm/meminit.h>
-#include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/mca.h>
 
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index dd8284bcbf16..51f3de976da7 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -24,7 +24,6 @@
 #include <linux/efi.h>
 #include <linux/nodemask.h>
 #include <linux/slab.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index 32352a73df0c..b331f94d20ac 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -18,7 +18,6 @@
 #include <linux/sysctl.h>
 #include <linux/log2.h>
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/ia64/mm/tlb.c b/arch/ia64/mm/tlb.c
index 72cc568bc841..fdc0b6f75dd5 100644
--- a/arch/ia64/mm/tlb.c
+++ b/arch/ia64/mm/tlb.c
@@ -27,7 +27,6 @@
 
 #include <asm/delay.h>
 #include <asm/mmu_context.h>
-#include <asm/pgalloc.h>
 #include <asm/pal.h>
 #include <asm/tlbflush.h>
 #include <asm/dma.h>
diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index cac9f289d1f6..993fd7e37069 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -222,7 +222,7 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 
 #include <asm/setup.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
 
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 871a0e11da34..b1ca3522eccc 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -15,7 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/export.h>
 
-#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
 void arch_dma_prep_coherent(struct page *page, size_t size)
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index df6fc782754f..546e81935fe8 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -35,10 +35,9 @@
 #include <asm/fpu.h>
 #include <linux/uaccess.h>
 #include <asm/traps.h>
-#include <asm/pgalloc.h>
 #include <asm/machdep.h>
 #include <asm/siginfo.h>
-
+#include <asm/tlbflush.h>
 
 static const char *vec_names[] = {
 	[VEC_RESETSP]	= "RESET SP",
diff --git a/arch/m68k/mm/cache.c b/arch/m68k/mm/cache.c
index 5ecb3310e874..b486c0889eec 100644
--- a/arch/m68k/mm/cache.c
+++ b/arch/m68k/mm/cache.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/module.h>
-#include <asm/pgalloc.h>
+#include <asm/cacheflush.h>
 #include <asm/traps.h>
 
 
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index a94a814ad6ad..508abb63da67 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -15,7 +15,6 @@
 
 #include <asm/setup.h>
 #include <asm/traps.h>
-#include <asm/pgalloc.h>
 
 extern void die_if_kernel(char *, struct pt_regs *, long);
 
diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 14d31d216cef..1269d513b221 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -19,8 +19,8 @@
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/io.h>
+#include <asm/tlbflush.h>
 
 #undef DEBUG
 
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 29f47923aa46..bd01b693f225 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -20,6 +20,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mcf_pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 #define KMAPAREA(x)	((x >= VMALLOC_START) && (x < KMAP_END))
 
diff --git a/arch/m68k/mm/memory.c b/arch/m68k/mm/memory.c
index 65e0c4071912..fe75aecfb238 100644
--- a/arch/m68k/mm/memory.c
+++ b/arch/m68k/mm/memory.c
@@ -17,7 +17,6 @@
 #include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/traps.h>
 #include <asm/machdep.h>
 
diff --git a/arch/m68k/sun3x/dvma.c b/arch/m68k/sun3x/dvma.c
index fef52d222d46..08bb92113026 100644
--- a/arch/m68k/sun3x/dvma.c
+++ b/arch/m68k/sun3x/dvma.c
@@ -22,7 +22,7 @@
 #include <asm/dvma.h>
 #include <asm/io.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 
 /* IOMMU support */
 
diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/include/asm/tlbflush.h
index 6f8f5c77a050..1200e2bf14bb 100644
--- a/arch/microblaze/include/asm/tlbflush.h
+++ b/arch/microblaze/include/asm/tlbflush.h
@@ -15,7 +15,6 @@
 #include <asm/processor.h>	/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 extern void _tlbie(unsigned long address);
 extern void _tlbia(void);
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index 6527ec22f158..1f7662185d93 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -18,7 +18,6 @@
 #include <linux/tick.h>
 #include <linux/bitops.h>
 #include <linux/ptrace.h>
-#include <asm/pgalloc.h>
 #include <linux/uaccess.h> /* for USER_DS macros */
 #include <asm/cacheflush.h>
 
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index bdd6d0c86e16..65bf5fd8d473 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -35,7 +35,6 @@
 #include <asm/entry.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
 #include <asm/syscalls.h>
diff --git a/arch/mips/sgi-ip32/ip32-memory.c b/arch/mips/sgi-ip32/ip32-memory.c
index be1b2cfc4c3e..62b956cc2d1d 100644
--- a/arch/mips/sgi-ip32/ip32-memory.c
+++ b/arch/mips/sgi-ip32/ip32-memory.c
@@ -14,7 +14,6 @@
 #include <asm/ip32/crime.h>
 #include <asm/bootinfo.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 extern void crime_init(void);
 
diff --git a/arch/openrisc/include/asm/tlbflush.h b/arch/openrisc/include/asm/tlbflush.h
index 4a4639c65cbb..185dcd3731ed 100644
--- a/arch/openrisc/include/asm/tlbflush.h
+++ b/arch/openrisc/include/asm/tlbflush.h
@@ -17,7 +17,6 @@
 
 #include <linux/mm.h>
 #include <asm/processor.h>
-#include <asm/pgalloc.h>
 #include <asm/current.h>
 #include <linux/sched.h>
 
diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 277ac7a55752..212e5f85004c 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -26,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/hardirq.h>
 #include <asm/delay.h>
-#include <asm/pgalloc.h>
 
 #define DECLARE_EXPORT(name) extern void name(void); EXPORT_SYMBOL(name)
 
diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/asm/mmu_context.h
index 07b89c74abeb..cb5f2f730421 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -5,7 +5,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/atomic.h>
-#include <asm/pgalloc.h>
 #include <asm-generic/mm_hooks.h>
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 1eedfecc5137..b5e1d9f1b440 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -24,7 +24,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/shmparam.h>
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index 70cd24bdcfec..642b3d9c8a88 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -32,7 +32,6 @@
 #include <asm/dma.h>    /* for DMA_CHUNK_SIZE */
 #include <asm/io.h>
 #include <asm/page.h>	/* get_order */
-#include <asm/pgalloc.h>
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>	/* for purge_tlb_*() macros */
 
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index b7abb12edd3a..c74008821075 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -47,7 +47,6 @@
 #include <asm/assembly.h>
 #include <asm/pdc.h>
 #include <asm/pdc_chassis.h>
-#include <asm/pgalloc.h>
 #include <asm/unwind.h>
 #include <asm/sections.h>
 
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
index 02895a8f2c55..5df5d4cd5d4c 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -30,7 +30,6 @@
 #include <asm/ucontext.h>
 #include <asm/rt_sigframe.h>
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/asm-offsets.h>
 
diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
index f8a842ddd82d..6271139d2213 100644
--- a/arch/parisc/kernel/smp.c
+++ b/arch/parisc/kernel/smp.c
@@ -39,7 +39,6 @@
 #include <asm/irq.h>		/* for CPU_IRQ_REGION and friends */
 #include <asm/mmu_context.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index 0e1e212f1c96..d7ba014a7fbb 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -15,7 +15,6 @@
 #include <linux/sysctl.h>
 
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index 6e7c005aa09b..345ff0b66499 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -11,7 +11,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/io.h>
-#include <asm/pgalloc.h>
+#include <linux/mm.h>
 
 /*
  * Generic mapping function (not visible outside):
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 862985cf5180..fbc6f3002f23 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -12,7 +12,6 @@
 #ifndef __powerpc64__
 #include <linux/pgtable.h>
 #endif
-#include <asm/pgalloc.h>
 #ifndef __powerpc64__
 #include <asm/page.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/mm/book3s64/hash_hugetlbpage.c b/arch/powerpc/mm/book3s64/hash_hugetlbpage.c
index 25acb9c5ee1b..964467b3a776 100644
--- a/arch/powerpc/mm/book3s64/hash_hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/hash_hugetlbpage.c
@@ -10,7 +10,6 @@
 
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
 
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 2a99167afbaf..fd9c7f91b092 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -9,7 +9,6 @@
 #include <linux/mm_types.h>
 #include <linux/mm.h>
 
-#include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/mmu.h>
 #include <asm/tlb.h>
diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 0fbf3dc9f2c2..eb0bccaf221e 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -21,7 +21,6 @@
 #include <linux/mm.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/bug.h>
diff --git a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
index c812b401b66c..cb91071eef52 100644
--- a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
@@ -2,7 +2,6 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/security.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/machdep.h>
 #include <asm/mman.h>
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 5a5469eb3174..7ea19dc4883b 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
index 569d98a41881..2784224054f8 100644
--- a/arch/powerpc/mm/kasan/8xx.c
+++ b/arch/powerpc/mm/kasan/8xx.c
@@ -5,7 +5,6 @@
 #include <linux/kasan.h>
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
-#include <asm/pgalloc.h>
 
 static int __init
 kasan_init_shadow_8M(unsigned long k_start, unsigned long k_end, void *block)
diff --git a/arch/powerpc/mm/kasan/book3s_32.c b/arch/powerpc/mm/kasan/book3s_32.c
index a32b4640b9de..202bd260a009 100644
--- a/arch/powerpc/mm/kasan/book3s_32.c
+++ b/arch/powerpc/mm/kasan/book3s_32.c
@@ -4,7 +4,6 @@
 
 #include <linux/kasan.h>
 #include <linux/memblock.h>
-#include <asm/pgalloc.h>
 #include <mm/mmu_decl.h>
 
 int __init kasan_init_region(void *start, size_t size)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c2c11eb8dcfc..ab12916ec1a7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -34,7 +34,6 @@
 #include <linux/dma-direct.h>
 #include <linux/kprobes.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
diff --git a/arch/powerpc/mm/nohash/40x.c b/arch/powerpc/mm/nohash/40x.c
index 13e74bc39ba5..95751c322f6c 100644
--- a/arch/powerpc/mm/nohash/40x.c
+++ b/arch/powerpc/mm/nohash/40x.c
@@ -32,7 +32,6 @@
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 92e8929cbe3e..d2b37146ae6c 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -13,7 +13,6 @@
 #include <asm/fixmap.h>
 #include <asm/code-patching.h>
 #include <asm/inst.h>
-#include <asm/pgalloc.h>
 
 #include <mm/mmu_decl.h>
 
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
index c06dfbb771f4..0c294827d6e5 100644
--- a/arch/powerpc/mm/nohash/fsl_booke.c
+++ b/arch/powerpc/mm/nohash/fsl_booke.c
@@ -37,7 +37,6 @@
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/mmu_context.h>
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 4a75f2d9bf0e..c6ee6e50a7d5 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -14,7 +14,6 @@
 #include <linux/memblock.h>
 #include <linux/libfdt.h>
 #include <linux/crash_core.h>
-#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/kdump.h>
 #include <mm/mmu_decl.h>
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 1136257c3a99..9c0547d77af3 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -23,7 +23,6 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/hugetlb.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <asm/hugetlb.h>
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index bb43a8c04bee..cc6e2f94517f 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
 
-#include <asm/pgalloc.h>
 #include <asm/page.h>
 #include <asm/prom.h>
 #include <asm/mmu_context.h>
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index a2c33efc7ce8..ff4b05a9e7f0 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -17,10 +17,10 @@
 #include <linux/seq_file.h>
 #include <linux/const.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/plpar_wrappers.h>
 #include <linux/memblock.h>
 #include <asm/firmware.h>
+#include <asm/pgalloc.h>
 
 struct pg_state {
 	struct seq_file *seq;
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index de6e05ef871c..f7ba13c41d13 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -21,7 +21,6 @@
 #include <asm/fixmap.h>
 #include <linux/const.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/hugetlb.h>
 
 #include <mm/mmu_decl.h>
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 9dba7e880885..45a3a3022a85 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -26,7 +26,6 @@
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/mmu.h>
-#include <asm/pgalloc.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
 #include <asm/plpar_wrappers.h>
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index ae7b7fe24658..5873835a3e6b 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -14,7 +14,6 @@
 #include <linux/signal.h>
 #include <linux/uaccess.h>
 
-#include <asm/pgalloc.h>
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index aa406c05a350..954fa8ca6cbd 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -36,7 +36,6 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
 #define p4d_free_tlb p4d_free_tlb
 #define pud_free_tlb pud_free_tlb
 
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm-generic/tlb.h>
 
diff --git a/arch/s390/include/asm/tlbflush.h b/arch/s390/include/asm/tlbflush.h
index 2204704840ea..acce6a08a1fa 100644
--- a/arch/s390/include/asm/tlbflush.h
+++ b/arch/s390/include/asm/tlbflush.h
@@ -5,7 +5,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <asm/processor.h>
-#include <asm/pgalloc.h>
 
 /*
  * Flush all TLB entries on the local CPU.
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 93c6b8932fbd..d91989c7bd6a 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -16,7 +16,6 @@
 #include <linux/debug_locks.h>
 #include <asm/cio.h>
 #include <asm/setup.h>
-#include <asm/pgalloc.h>
 #include <asm/smp.h>
 #include <asm/ipl.h>
 #include <asm/diag.h>
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 3cc15c066298..3c72a3b77253 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -25,7 +25,6 @@
 #include <linux/compat.h>
 #include <trace/syscall.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/switch_to.h>
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 563429dece03..5b8ec1c447e1 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -10,7 +10,6 @@
 
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
-#include <asm/pgalloc.h>
 #include <asm/gmap.h>
 #include <asm/virtio-ccw.h>
 #include "kvm-s390.h"
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 96ae368aa0a2..2f721a923b54 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -22,7 +22,6 @@
 #include <asm/ebcdic.h>
 #include <asm/sysinfo.h>
 #include <asm/page-states.h>
-#include <asm/pgalloc.h>
 #include <asm/gmap.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 63e330109b63..eb99e2f95ebe 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -9,7 +9,6 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/sched/signal.h>
-#include <asm/pgalloc.h>
 #include <asm/gmap.h>
 #include <asm/uv.h>
 #include <asm/mman.h>
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 36bce727897b..04cb0956da8a 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -21,7 +21,6 @@
 #include <linux/oom.h>
 #include <linux/uaccess.h>
 
-#include <asm/pgalloc.h>
 #include <asm/diag.h>
 
 #ifdef CONFIG_CMM_IUCV
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 1b78f630a9ca..e54f928503c5 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -17,7 +17,6 @@
 #include <linux/random.h>
 #include <linux/compat.h>
 #include <linux/security.h>
-#include <asm/pgalloc.h>
 #include <asm/elf.h>
 
 static unsigned long stack_maxrandom_size(void)
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 2e0cc19f4cd7..0d25f743b270 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -19,7 +19,6 @@
 #include <linux/ksm.h>
 #include <linux/mman.h>
 
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index c20fc5487e05..0dc0f52f9bb8 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -14,7 +14,6 @@
 #include <linux/irqflags.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
-#include <asm/pgalloc.h>
 #include <asm/smp.h>
 #include <asm/bl_bit.h>
 
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 4a98980b8a07..223c14f44af7 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -14,7 +14,6 @@
 #include <linux/ftrace.h>
 #include <linux/suspend.h>
 #include <linux/memblock.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sh/mm/cache-sh3.c b/arch/sh/mm/cache-sh3.c
index 26f3bd43e850..bc595982d396 100644
--- a/arch/sh/mm/cache-sh3.c
+++ b/arch/sh/mm/cache-sh3.c
@@ -16,7 +16,6 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
index 48978293226c..4c67b3d88775 100644
--- a/arch/sh/mm/cache-sh7705.c
+++ b/arch/sh/mm/cache-sh7705.c
@@ -20,7 +20,6 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index acd5652a0de3..220d7bc43d2b 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -17,7 +17,6 @@
 #include <linux/sysctl.h>
 
 #include <asm/mman.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a70ba0fdd0b3..a86ce13f392c 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -27,6 +27,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/cache.h>
+#include <asm/pgalloc.h>
 #include <linux/sizes.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
index 07e744d75fa0..aab3f82856bb 100644
--- a/arch/sh/mm/ioremap_fixed.c
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -18,7 +18,6 @@
 #include <linux/proc_fs.h>
 #include <asm/fixmap.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/addrspace.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
diff --git a/arch/sh/mm/tlb-sh3.c b/arch/sh/mm/tlb-sh3.c
index 869243518bb3..fb400afc2a49 100644
--- a/arch/sh/mm/tlb-sh3.c
+++ b/arch/sh/mm/tlb-sh3.c
@@ -21,7 +21,6 @@
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
diff --git a/arch/sparc/include/asm/ide.h b/arch/sparc/include/asm/ide.h
index 499aa2e6e276..904cc6cbc155 100644
--- a/arch/sparc/include/asm/ide.h
+++ b/arch/sparc/include/asm/ide.h
@@ -13,7 +13,6 @@
 
 #include <asm/io.h>
 #ifdef CONFIG_SPARC64
-#include <asm/pgalloc.h>
 #include <asm/spitfire.h>
 #include <asm/cacheflush.h>
 #include <asm/page.h>
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index 6820d357581c..e841cae544c2 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -4,7 +4,6 @@
 
 #include <linux/swap.h>
 #include <linux/pagemap.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 41829c024f92..1eed26d423fb 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -38,7 +38,6 @@
 #include <asm/delay.h>
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/oplib.h>
 #include <asm/cpudata.h>
 #include <asm/asi.h>
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 13cb5638fab8..18e5b31a30ea 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -34,7 +34,6 @@
 #include <asm/oplib.h>
 #include <linux/uaccess.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/processor.h>
 #include <asm/psr.h>
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 3b005b6c3e0f..f1f8c8ebe641 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -23,7 +23,6 @@
 
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>	/* flush_sig_insns */
 #include <asm/switch_to.h>
 
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 76ce290c67cf..50c127ab46d5 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -29,7 +29,6 @@
 
 #include <asm/irq.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/oplib.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 0085e28bf019..e286e2badc8a 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -47,6 +47,7 @@
 #include <linux/uaccess.h>
 #include <asm/starfire.h>
 #include <asm/tlb.h>
+#include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/prom.h>
 #include <asm/mdesc.h>
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 91b61f012d19..1079638986b5 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -16,7 +16,6 @@
 
 #include <asm/timer.h>
 #include <asm/traps.h>
-#include <asm/pgalloc.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sparc/mm/highmem.c b/arch/sparc/mm/highmem.c
index d1fc9a7b7d78..8f2a2afb048a 100644
--- a/arch/sparc/mm/highmem.c
+++ b/arch/sparc/mm/highmem.c
@@ -29,7 +29,6 @@
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
-#include <asm/pgalloc.h>
 #include <asm/vaddrs.h>
 
 static pte_t *kmap_pte;
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index bfcc04bfce54..430a47a1b6ae 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <asm/pgalloc.h>
 #include <asm/io.h>
 #include <asm/io-unit.h>
 #include <asm/mxcc.h>
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 35b002eb312e..3a388b1c5d4b 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -16,7 +16,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 
-#include <asm/pgalloc.h>
 #include <asm/io.h>
 #include <asm/mxcc.h>
 #include <asm/mbus.h>
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index a32a16c18617..20ee14739333 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -10,7 +10,6 @@
 #include <linux/swap.h>
 #include <linux/preempt.h>
 
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index 385d3d172ee1..ca8a657edf59 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -30,7 +30,6 @@
 #include <linux/sched/task_stack.h>
 
 #include <linux/uaccess.h>
-#include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 #include <asm/user32.h>
 #include <asm/ia32.h>
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..d98016b83755 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -9,7 +9,6 @@
 
 #include <trace/events/tlb.h>
 
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/debugreg.h>
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff74a49..ef28efb48c85 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
+#include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e0e2f020ec02..ccf726cc87b7 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -40,7 +40,6 @@
 #include <asm/irq_remapping.h>
 #include <asm/perf_event.h>
 #include <asm/x86_init.h>
-#include <asm/pgalloc.h>
 #include <linux/atomic.h>
 #include <asm/mpspec.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index afac7ccce72f..c27b82b62c8b 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -22,7 +22,6 @@
 #include <asm/irqdomain.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
-#include <asm/pgalloc.h>
 #include <asm/io_apic.h>
 #include <asm/proto.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f9727b96961f..8002b8a7b4cb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -62,7 +62,6 @@
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
-#include <asm/pgalloc.h>
 #include <asm/proto.h>
 #else
 #include <asm/processor-flags.h>
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1ead568c0101..02536b04d9f3 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -21,7 +21,6 @@
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
-#include <asm/pgalloc.h>		/* pgd_*(), ...			*/
 #include <asm/fixmap.h>			/* VSYSCALL_ADDR		*/
 #include <asm/vsyscall.h>		/* emulate_vsyscall		*/
 #include <asm/vm86.h>			/* struct vm86			*/
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index cf5781142716..a0d023cb4292 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -17,7 +17,6 @@
 #include <asm/mman.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
-#include <asm/pgalloc.h>
 #include <asm/elf.h>
 
 #if 0	/* This is just for testing */
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index fb620fd9dae9..6e6b39710e5f 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -26,7 +26,6 @@
 #include <linux/memblock.h>
 #include <linux/pgtable.h>
 
-#include <asm/pgalloc.h>
 #include <asm/setup.h>
 #include <asm/kaslr.h>
 
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index 1953685c2ddf..c234634e26ba 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -11,7 +11,6 @@
 #include <linux/spinlock.h>
 
 #include <asm/cpu_entry_area.h>
-#include <asm/pgalloc.h>
 #include <asm/fixmap.h>
 #include <asm/e820/api.h>
 #include <asm/tlb.h>
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a8a924b3c335..1aab92930569 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -34,7 +34,6 @@
 #include <asm/vsyscall.h>
 #include <asm/cmdline.h>
 #include <asm/pti.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/sections.h>
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4494589a288a..c84f83ed0749 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <asm/efi.h>
 #include <linux/io.h>
+#include <asm/pgalloc.h>
 #include <asm/uv/bios.h>
 #include <asm/uv/uv_hub.h>
 
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index 4092555828b1..2975f559272e 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -25,7 +25,6 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/ftrace.h>
 #ifdef CONFIG_BLK_DEV_FD
 #include <asm/floppy.h>
diff --git a/arch/xtensa/mm/cache.c b/arch/xtensa/mm/cache.c
index 2369433b734a..5835406b3cec 100644
--- a/arch/xtensa/mm/cache.c
+++ b/arch/xtensa/mm/cache.c
@@ -31,7 +31,6 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 /* 
  * Note:
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index c4decc73fd86..c128dcc7c85b 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -20,7 +20,6 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/hardirq.h>
-#include <asm/pgalloc.h>
 
 DEFINE_PER_CPU(unsigned long, asid_cache) = ASID_USER_FIRST;
 void bad_page_fault(struct pt_regs*, unsigned long, int);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index a3eeccf3ac5f..c6ea5d38c509 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -36,7 +36,6 @@
 #include <linux/io.h>
 #include <linux/rbtree.h>
 #include <asm/setup.h>
-#include <asm/pgalloc.h>
 #include <asm/hypervisor.h>
 #include <xen/grant_table.h>
 #include <xen/page.h>
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 4c2972f3153b..6de86e73dfc3 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -28,7 +28,6 @@
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
-#include <asm/pgalloc.h>
 #else
 #define arm_iommu_create_mapping(...)	NULL
 #define arm_iommu_attach_device(...)	-ENODEV
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 77c57568e5d7..f5c838a92b01 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -58,7 +58,6 @@
 #include <linux/sysctl.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 #include <asm/xen/hypervisor.h>
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index a250d118144a..5dfc59fd9f16 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -25,7 +25,6 @@
 #include <linux/miscdevice.h>
 #include <linux/moduleparam.h>
 
-#include <asm/pgalloc.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 0f45521b237c..cf306e0798fd 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -38,7 +38,6 @@
 
 #include <linux/uaccess.h>
 #include <asm/param.h>
-#include <asm/pgalloc.h>
 
 typedef char *elf_caddr_t;
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 3f1649a8cf55..36ac65f4744f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -14,7 +14,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
 #include <linux/hugetlb_inline.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..3566d369eaee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -31,6 +31,7 @@
 #include <linux/cma.h>
 
 #include <asm/page.h>
+#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 
 #include <linux/io.h>
diff --git a/mm/sparse.c b/mm/sparse.c
index b2b9a3e34696..97179d27801a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -16,7 +16,6 @@
 
 #include "internal.h"
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 
 /*
  * Permanent SPARSEMEM data:
-- 
2.26.2


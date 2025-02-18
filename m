Return-Path: <linux-arch+bounces-10167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB8A398A3
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E754D1621C0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D69523237C;
	Tue, 18 Feb 2025 10:20:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978D323237A;
	Tue, 18 Feb 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874016; cv=none; b=ZlawHo7jzWVDMBm2QYYzty+hkbLxo5rCIPZzhZFnvdowAsFHw+TFS8okYIJedO/+ZYZEF/sw+e3M1iJuRXtGIsOZd16MphyhTe3CZZ79FEqqpCP2+b0GJTx3pw+1Rkx+XcYvkMs0xsFZ03Ep+Q+8rIJrM/a33U9pHrZUN+740E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874016; c=relaxed/simple;
	bh=vnlzfbORGowl+04xlYi/6j0LT+jeasXwzvsBE9C6lns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsQ0/J/mwfr5yswiTA2C3xLxISsk0loYFOd7afLErvA6mZOYf9o+TXbKA4bgXbImwaC2dX6R693sXC5Jra3dbUp5YlkszRkiheA7D/3WCrvw7MQMN0Y99njSuwvcmek0w3SH5ZK16o+WskGJDvDsV0AUjwHe/+MHCFBikvt96S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93C613D5;
	Tue, 18 Feb 2025 02:20:31 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.37.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A36363F6A8;
	Tue, 18 Feb 2025 02:20:04 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] mm/ioremap: Pass pgprot_t to ioremap_prot() instead of unsigned long
Date: Tue, 18 Feb 2025 15:49:54 +0530
Message-Id: <20250218101954.415331-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

ioremap_prot() currently accepts pgprot_val parameter as an unsigned long,
thus implicitly assuming that pgprot_val and pgprot_t could never be bigger
than unsigned long. But this assumption soon will not be true on arm64 when
using D128 pgtables. In 128 bit page table configuration, unsigned long is
64 bit, but pgprot_t is 128 bit.

Passing platform abstracted pgprot_t argument is better as compared to size
based data types. Let's change the parameter to directly pass pgprot_t like
another similar helper generic_ioremap_prot().

Without this change in place, D128 configuration does not work on arm64 as
the top 64 bits gets silently stripped when passing the protection value to
this function.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-csky@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Co-developed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc3 and has been tested on arm64 platform.
Although it builds on multiple platforms here.

 arch/arc/mm/ioremap.c               |  6 ++----
 arch/arm64/include/asm/io.h         |  6 +++---
 arch/arm64/kernel/acpi.c            |  2 +-
 arch/arm64/mm/ioremap.c             |  3 +--
 arch/csky/include/asm/io.h          |  2 +-
 arch/loongarch/include/asm/io.h     | 10 +++++-----
 arch/mips/include/asm/io.h          |  8 ++++----
 arch/mips/mm/ioremap.c              |  4 ++--
 arch/mips/mm/ioremap64.c            |  4 ++--
 arch/parisc/include/asm/io.h        |  2 +-
 arch/parisc/mm/ioremap.c            |  4 ++--
 arch/powerpc/include/asm/io.h       |  2 +-
 arch/powerpc/mm/ioremap.c           |  4 ++--
 arch/powerpc/platforms/ps3/spu.c    |  4 ++--
 arch/riscv/include/asm/io.h         |  2 +-
 arch/riscv/kernel/acpi.c            |  2 +-
 arch/s390/include/asm/io.h          |  4 ++--
 arch/s390/pci/pci.c                 |  4 ++--
 arch/sh/boards/mach-landisk/setup.c |  2 +-
 arch/sh/boards/mach-lboxre2/setup.c |  2 +-
 arch/sh/boards/mach-sh03/setup.c    |  2 +-
 arch/sh/include/asm/io.h            |  2 +-
 arch/sh/mm/ioremap.c                |  3 +--
 arch/x86/include/asm/io.h           |  2 +-
 arch/x86/mm/ioremap.c               |  4 ++--
 arch/xtensa/include/asm/io.h        |  6 +++---
 arch/xtensa/mm/ioremap.c            |  4 ++--
 include/asm-generic/io.h            |  4 ++--
 mm/ioremap.c                        |  4 ++--
 mm/memory.c                         |  6 +++---
 30 files changed, 55 insertions(+), 59 deletions(-)

diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index b07004d53267..fd8897a0e52c 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -32,7 +32,7 @@ void __iomem *ioremap(phys_addr_t paddr, unsigned long size)
 		return (void __iomem *)(u32)paddr;
 
 	return ioremap_prot(paddr, size,
-			    pgprot_val(pgprot_noncached(PAGE_KERNEL)));
+			    pgprot_noncached(PAGE_KERNEL));
 }
 EXPORT_SYMBOL(ioremap);
 
@@ -44,10 +44,8 @@ EXPORT_SYMBOL(ioremap);
  * might need finer access control (R/W/X)
  */
 void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
-			   unsigned long flags)
+			   pgprot_t prot)
 {
-	pgprot_t prot = __pgprot(flags);
-
 	/* force uncached */
 	return generic_ioremap_prot(paddr, size, pgprot_noncached(prot));
 }
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 76ebbdc6ffdd..9b96840fb979 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -270,9 +270,9 @@ int arm64_ioremap_prot_hook_register(const ioremap_prot_hook_t hook);
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
 #define ioremap_wc(addr, size)	\
-	ioremap_prot((addr), (size), PROT_NORMAL_NC)
+	ioremap_prot((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_np(addr, size)	\
-	ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
+	ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
 
 /*
  * io{read,write}{16,32,64}be() macros
@@ -293,7 +293,7 @@ static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
 	if (pfn_is_map_memory(__phys_to_pfn(addr)))
 		return (void __iomem *)__phys_to_virt(addr);
 
-	return ioremap_prot(addr, size, PROT_NORMAL);
+	return ioremap_prot(addr, size, __pgprot(PROT_NORMAL));
 }
 
 /*
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e6f66491fbe9..b9a66fc146c9 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -379,7 +379,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 				prot = __acpi_get_writethrough_mem_attribute();
 		}
 	}
-	return ioremap_prot(phys, size, pgprot_val(prot));
+	return ioremap_prot(phys, size, prot);
 }
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 6cc0b7e7eb03..10e246f11271 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -15,10 +15,9 @@ int arm64_ioremap_prot_hook_register(ioremap_prot_hook_t hook)
 }
 
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+			   pgprot_t pgprot)
 {
 	unsigned long last_addr = phys_addr + size - 1;
-	pgprot_t pgprot = __pgprot(prot);
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index ed53f0b47388..536d3bf32ff1 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -36,7 +36,7 @@
  */
 #define ioremap_wc(addr, size) \
 	ioremap_prot((addr), (size), \
-		(_PAGE_IOREMAP & ~_CACHE_MASK) | _CACHE_UNCACHED)
+		__pgprot((_PAGE_IOREMAP & ~_CACHE_MASK) | _CACHE_UNCACHED))
 
 #include <asm-generic/io.h>
 
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index e77a56eaf906..eaff72b38dc8 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -23,9 +23,9 @@ extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 #ifdef CONFIG_ARCH_IOREMAP
 
 static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-					 unsigned long prot_val)
+					 pgprot_t prot)
 {
-	switch (prot_val & _CACHE_MASK) {
+	switch (pgprot_val(prot) & _CACHE_MASK) {
 	case _CACHE_CC:
 		return (void __iomem *)(unsigned long)(CACHE_BASE + offset);
 	case _CACHE_SUC:
@@ -38,7 +38,7 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 }
 
 #define ioremap(offset, size)		\
-	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_SUC))
+	ioremap_prot((offset), (size), PAGE_KERNEL_SUC)
 
 #define iounmap(addr) 			((void)(addr))
 
@@ -55,10 +55,10 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  */
 #define ioremap_wc(offset, size)	\
 	ioremap_prot((offset), (size),	\
-		pgprot_val(wc_enabled ? PAGE_KERNEL_WUC : PAGE_KERNEL_SUC))
+		     wc_enabled ? PAGE_KERNEL_WUC : PAGE_KERNEL_SUC)
 
 #define ioremap_cache(offset, size)	\
-	ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
+	ioremap_prot((offset), (size), PAGE_KERNEL)
 
 #define mmiowb() wmb()
 
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 0bddb568af7c..4dacf40ebefd 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -126,7 +126,7 @@ static inline unsigned long isa_virt_to_bus(volatile void *address)
 }
 
 void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-		unsigned long prot_val);
+			   pgprot_t prot);
 void iounmap(const volatile void __iomem *addr);
 
 /*
@@ -141,7 +141,7 @@ void iounmap(const volatile void __iomem *addr);
  * address.
  */
 #define ioremap(offset, size)						\
-	ioremap_prot((offset), (size), _CACHE_UNCACHED)
+	ioremap_prot((offset), (size), __pgprot(_CACHE_UNCACHED))
 
 /*
  * ioremap_cache -	map bus memory into CPU space
@@ -159,7 +159,7 @@ void iounmap(const volatile void __iomem *addr);
  * memory-like regions on I/O busses.
  */
 #define ioremap_cache(offset, size)					\
-	ioremap_prot((offset), (size), _page_cachable_default)
+	ioremap_prot((offset), (size), __pgprot(_page_cachable_default))
 
 /*
  * ioremap_wc     -   map bus memory into CPU space
@@ -180,7 +180,7 @@ void iounmap(const volatile void __iomem *addr);
  * _CACHE_UNCACHED option (see cpu_probe() method).
  */
 #define ioremap_wc(offset, size)					\
-	ioremap_prot((offset), (size), boot_cpu_data.writecombine)
+	ioremap_prot((offset), (size), __pgprot(boot_cpu_data.writecombine))
 
 #if defined(CONFIG_CPU_CAVIUM_OCTEON)
 #define war_io_reorder_wmb()		wmb()
diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index d8243d61ef32..c6c4576cd4a8 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -44,9 +44,9 @@ static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
  * ioremap_prot gives the caller control over cache coherency attributes (CCA)
  */
 void __iomem *ioremap_prot(phys_addr_t phys_addr, unsigned long size,
-		unsigned long prot_val)
+			   pgprot_t prot)
 {
-	unsigned long flags = prot_val & _CACHE_MASK;
+	unsigned long flags = pgprot_val(prot) & _CACHE_MASK;
 	unsigned long offset, pfn, last_pfn;
 	struct vm_struct *area;
 	phys_addr_t last_addr;
diff --git a/arch/mips/mm/ioremap64.c b/arch/mips/mm/ioremap64.c
index 15e7820d6a5f..acc03ba20098 100644
--- a/arch/mips/mm/ioremap64.c
+++ b/arch/mips/mm/ioremap64.c
@@ -3,9 +3,9 @@
 #include <ioremap.h>
 
 void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-		unsigned long prot_val)
+			   pgprot_t prot)
 {
-	unsigned long flags = prot_val & _CACHE_MASK;
+	unsigned long flags = pgprot_val(prot) & _CACHE_MASK;
 	u64 base = (flags == _CACHE_UNCACHED ? IO_BASE : UNCAC_BASE);
 	void __iomem *addr;
 
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 3143cf29ce27..04b783e2a6d1 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -131,7 +131,7 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 		       _PAGE_ACCESSED | _PAGE_NO_CACHE)
 
 #define ioremap_wc(addr, size)  \
-	ioremap_prot((addr), (size), _PAGE_IOREMAP)
+	ioremap_prot((addr), (size), __pgprot(_PAGE_IOREMAP))
 
 #define pci_iounmap			pci_iounmap
 
diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index fd996472dfe7..0b65c4b3baee 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -14,7 +14,7 @@
 #include <linux/mm.h>
 
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+			   pgprot_t prot)
 {
 #ifdef CONFIG_EISA
 	unsigned long end = phys_addr + size - 1;
@@ -41,6 +41,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 		}
 	}
 
-	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, prot);
 }
 EXPORT_SYMBOL(ioremap_prot);
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index fd92ac450169..0436cdc7cfcc 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -895,7 +895,7 @@ void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
 
 void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
 #define ioremap_cache(addr, size) \
-	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
+	ioremap_prot((addr), (size), PAGE_KERNEL)
 
 #define iounmap iounmap
 
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 7b0afcabd89f..0d6615620ada 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -41,9 +41,9 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 	return __ioremap_caller(addr, size, prot, caller);
 }
 
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long flags)
+void __iomem *ioremap_prot(phys_addr_t addr, size_t size, pgprot_t prot)
 {
-	pte_t pte = __pte(flags);
+	pte_t pte = __pte(pgprot_val(prot));
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index 4a2520ec6d7f..61b37c9400b2 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -190,10 +190,10 @@ static void spu_unmap(struct spu *spu)
 static int __init setup_areas(struct spu *spu)
 {
 	struct table {char* name; unsigned long addr; unsigned long size;};
-	unsigned long shadow_flags = pgprot_val(pgprot_noncached_wc(PAGE_KERNEL_RO));
 
 	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
-					      sizeof(struct spe_shadow), shadow_flags);
+					      sizeof(struct spe_shadow),
+					      pgprot_noncached_wc(PAGE_KERNEL_RO));
 	if (!spu_pdata(spu)->shadow) {
 		pr_debug("%s:%d: ioremap shadow failed\n", __func__, __LINE__);
 		goto fail_ioremap;
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641075d2..0536846db9b6 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -137,7 +137,7 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size)	\
-	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
+	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 2fd29695a788..3f6d5a6789e8 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -305,7 +305,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		}
 	}
 
-	return ioremap_prot(phys, size, pgprot_val(prot));
+	return ioremap_prot(phys, size, prot);
 }
 
 #ifdef CONFIG_PCI
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index fc9933a743d6..82f1043a4fc3 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -33,9 +33,9 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 #define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
 
 #define ioremap_wc(addr, size)  \
-	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
+	ioremap_prot((addr), (size), pgprot_writecombine(PAGE_KERNEL))
 #define ioremap_wt(addr, size)  \
-	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
+	ioremap_prot((addr), (size), pgprot_writethrough(PAGE_KERNEL))
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..9fdcd733d40e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -255,7 +255,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 }
 
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+			   pgprot_t prot)
 {
 	/*
 	 * When PCI MIO instructions are unavailable the "physical" address
@@ -265,7 +265,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	if (!static_branch_unlikely(&have_mio))
 		return (void __iomem *)phys_addr;
 
-	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, prot);
 }
 EXPORT_SYMBOL(ioremap_prot);
 
diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index 2c44b94f82fb..1b3f43c3ac46 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -58,7 +58,7 @@ static int __init landisk_devices_setup(void)
 	/* open I/O area window */
 	paddrbase = virt_to_phys((void *)PA_AREA5_IO);
 	prot = PAGE_KERNEL_PCC(1, _PAGE_PCC_IO16);
-	cf_ide_base = ioremap_prot(paddrbase, PAGE_SIZE, pgprot_val(prot));
+	cf_ide_base = ioremap_prot(paddrbase, PAGE_SIZE, prot);
 	if (!cf_ide_base) {
 		printk("allocate_cf_area : can't open CF I/O window!\n");
 		return -ENOMEM;
diff --git a/arch/sh/boards/mach-lboxre2/setup.c b/arch/sh/boards/mach-lboxre2/setup.c
index 20d01b430f2a..e95bde207adb 100644
--- a/arch/sh/boards/mach-lboxre2/setup.c
+++ b/arch/sh/boards/mach-lboxre2/setup.c
@@ -53,7 +53,7 @@ static int __init lboxre2_devices_setup(void)
 	paddrbase = virt_to_phys((void*)PA_AREA5_IO);
 	psize = PAGE_SIZE;
 	prot = PAGE_KERNEL_PCC(1, _PAGE_PCC_IO16);
-	cf0_io_base = (u32)ioremap_prot(paddrbase, psize, pgprot_val(prot));
+	cf0_io_base = (u32)ioremap_prot(paddrbase, psize, prot);
 	if (!cf0_io_base) {
 		printk(KERN_ERR "%s : can't open CF I/O window!\n" , __func__ );
 		return -ENOMEM;
diff --git a/arch/sh/boards/mach-sh03/setup.c b/arch/sh/boards/mach-sh03/setup.c
index 3901b6031ad5..5c9312f334d3 100644
--- a/arch/sh/boards/mach-sh03/setup.c
+++ b/arch/sh/boards/mach-sh03/setup.c
@@ -75,7 +75,7 @@ static int __init sh03_devices_setup(void)
 	/* open I/O area window */
 	paddrbase = virt_to_phys((void *)PA_AREA5_IO);
 	prot = PAGE_KERNEL_PCC(1, _PAGE_PCC_IO16);
-	cf_ide_base = ioremap_prot(paddrbase, PAGE_SIZE, pgprot_val(prot));
+	cf_ide_base = ioremap_prot(paddrbase, PAGE_SIZE, prot);
 	if (!cf_ide_base) {
 		printk("allocate_cf_area : can't open CF I/O window!\n");
 		return -ENOMEM;
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf5eab840d57..531ec49b878d 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -299,7 +299,7 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL_NOCACHE)
 
 #define ioremap_cache(addr, size)  \
-	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
+	ioremap_prot((addr), (size), PAGE_KERNEL)
 #endif /* CONFIG_MMU */
 
 #include <asm-generic/io.h>
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 33d20f34560f..5bbde53fb32d 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -73,10 +73,9 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #endif /* CONFIG_29BIT */
 
 void __iomem __ref *ioremap_prot(phys_addr_t phys_addr, size_t size,
-				 unsigned long prot)
+				 pgprot_t pgprot)
 {
 	void __iomem *mapped;
-	pgprot_t pgprot = __pgprot(prot);
 
 	mapped = __ioremap_trapped(phys_addr, size);
 	if (mapped)
diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ed580c7f9d0a..0794936ec187 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -170,7 +170,7 @@ extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
 #define ioremap_uc ioremap_uc
 extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
 #define ioremap_cache ioremap_cache
-extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
+extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size,  pgprot_t prot);
 #define ioremap_prot ioremap_prot
 extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long size);
 #define ioremap_encrypted ioremap_encrypted
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 38ff7791a9c7..d501f0871aa5 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -440,10 +440,10 @@ void __iomem *ioremap_cache(resource_size_t phys_addr, unsigned long size)
 EXPORT_SYMBOL(ioremap_cache);
 
 void __iomem *ioremap_prot(resource_size_t phys_addr, unsigned long size,
-				unsigned long prot_val)
+			   pgprot_t prot)
 {
 	return __ioremap_caller(phys_addr, size,
-				pgprot2cachemode(__pgprot(prot_val)),
+				pgprot2cachemode(prot),
 				__builtin_return_address(0), false);
 }
 EXPORT_SYMBOL(ioremap_prot);
diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index 934e58399c8c..7cdcc2deab3e 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -29,7 +29,7 @@
  * I/O memory mapping functions.
  */
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot);
+			   pgprot_t prot);
 #define ioremap_prot ioremap_prot
 #define iounmap iounmap
 
@@ -40,7 +40,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_BYPASS_VADDR);
 	else
 		return ioremap_prot(offset, size,
-			pgprot_val(pgprot_noncached(PAGE_KERNEL)));
+				    pgprot_noncached(PAGE_KERNEL));
 }
 #define ioremap ioremap
 
@@ -51,7 +51,7 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
 	    && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
 		return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
 	else
-		return ioremap_prot(offset, size, pgprot_val(PAGE_KERNEL));
+		return ioremap_prot(offset, size, PAGE_KERNEL);
 
 }
 #define ioremap_cache ioremap_cache
diff --git a/arch/xtensa/mm/ioremap.c b/arch/xtensa/mm/ioremap.c
index 8ca660b7ab49..26f238fa9d0d 100644
--- a/arch/xtensa/mm/ioremap.c
+++ b/arch/xtensa/mm/ioremap.c
@@ -11,12 +11,12 @@
 #include <asm/io.h>
 
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+			   pgprot_t prot)
 {
 	unsigned long pfn = __phys_to_pfn((phys_addr));
 	WARN_ON(pfn_valid(pfn));
 
-	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, prot);
 }
 EXPORT_SYMBOL(ioremap_prot);
 
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a5cbbf3e26ec..402020b23423 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1111,7 +1111,7 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 				   pgprot_t prot);
 
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot);
+			   pgprot_t prot);
 void iounmap(volatile void __iomem *addr);
 void generic_iounmap(volatile void __iomem *addr);
 
@@ -1120,7 +1120,7 @@ void generic_iounmap(volatile void __iomem *addr);
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
 {
 	/* _PAGE_IOREMAP needs to be supplied by the architecture */
-	return ioremap_prot(addr, size, _PAGE_IOREMAP);
+	return ioremap_prot(addr, size, __pgprot(_PAGE_IOREMAP));
 }
 #endif
 #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 3e049dfb28bd..c36dd9f62fd5 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -50,9 +50,9 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
 
 #ifndef ioremap_prot
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+			   pgprot_t prot)
 {
-	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, prot);
 }
 EXPORT_SYMBOL(ioremap_prot);
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..76e35979cbc0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6636,7 +6636,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write)
 {
 	resource_size_t phys_addr;
-	unsigned long prot = 0;
+	pgprot_t prot = __pgprot(0);
 	void __iomem *maddr;
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
@@ -6646,7 +6646,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 retry:
 	if (follow_pfnmap_start(&args))
 		return -EINVAL;
-	prot = pgprot_val(args.pgprot);
+	prot = args.pgprot;
 	phys_addr = (resource_size_t)args.pfn << PAGE_SHIFT;
 	writable = args.writable;
 	follow_pfnmap_end(&args);
@@ -6661,7 +6661,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (follow_pfnmap_start(&args))
 		goto out_unmap;
 
-	if ((prot != pgprot_val(args.pgprot)) ||
+	if ((pgprot_val(prot) != pgprot_val(args.pgprot)) ||
 	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
 	    (writable != args.writable)) {
 		follow_pfnmap_end(&args);
-- 
2.25.1



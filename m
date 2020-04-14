Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61211A79DC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439545AbgDNLpQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 07:45:16 -0400
Received: from foss.arm.com ([217.140.110.172]:53730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439533AbgDNLpH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Apr 2020 07:45:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10ADC1FB;
        Tue, 14 Apr 2020 04:45:06 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0806F3F6C4;
        Tue, 14 Apr 2020 04:44:55 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/hugetlb: Introduce HAVE_ARCH_IS_HUGEPAGE_ONLY_RANGE
Date:   Tue, 14 Apr 2020 17:14:29 +0530
Message-Id: <1586864670-21799-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
References: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are multiple similar definitions for is_hugepage_only_range() across
platforms. This introduces HAVE_ARCH_IS_HUGEPAGE_ONLY_RANGE for platforms
that need to define their own is_hugepage_only_range() but otherwise there
is a generic fallback definition for others to use. This help reduce code
duplication.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: x86@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm/include/asm/hugetlb.h     | 6 ------
 arch/arm64/include/asm/hugetlb.h   | 6 ------
 arch/ia64/include/asm/hugetlb.h    | 1 +
 arch/mips/include/asm/hugetlb.h    | 7 -------
 arch/parisc/include/asm/hugetlb.h  | 6 ------
 arch/powerpc/include/asm/hugetlb.h | 1 +
 arch/riscv/include/asm/hugetlb.h   | 6 ------
 arch/s390/include/asm/hugetlb.h    | 7 -------
 arch/sh/include/asm/hugetlb.h      | 6 ------
 arch/sparc/include/asm/hugetlb.h   | 6 ------
 arch/x86/include/asm/hugetlb.h     | 6 ------
 include/linux/hugetlb.h            | 8 ++++++++
 12 files changed, 10 insertions(+), 56 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 318dcf5921ab..9ecd516d1ff7 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -14,12 +14,6 @@
 #include <asm/hugetlb-3level.h>
 #include <asm-generic/hugetlb.h>
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr, unsigned long len)
-{
-	return 0;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index b88878ddc88b..8f58e052697a 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -17,12 +17,6 @@
 extern bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr, unsigned long len)
-{
-	return 0;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index 36cc0396b214..f17c1e228045 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -13,6 +13,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 int prepare_hugepage_range(struct file *file,
 			unsigned long addr, unsigned long len);
 
+#define HAVE_ARCH_IS_HUGEPAGE_ONLY_RANGE
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
 					 unsigned long len)
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 425bb6fc3bda..8b201e281f67 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -11,13 +11,6 @@
 
 #include <asm/page.h>
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr,
-					 unsigned long len)
-{
-	return 0;
-}
-
 #define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 					 unsigned long addr,
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 7cb595dcb7d7..411d9d867baa 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -12,12 +12,6 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep);
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr,
-					 unsigned long len) {
-	return 0;
-}
-
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index bd6504c28c2f..9dd50e1e4fe5 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -22,6 +22,7 @@ void flush_dcache_icache_hugepage(struct page *page);
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len);
 
+#define HAVE_ARCH_IS_HUGEPAGE_ONLY_RANGE
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr,
 					 unsigned long len)
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 728a5db66597..866f6ae6467c 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -5,12 +5,6 @@
 #include <asm-generic/hugetlb.h>
 #include <asm/page.h>
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr,
-					 unsigned long len) {
-	return 0;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index de8f0bf5f238..7d27ea96ec2f 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -21,13 +21,6 @@ pte_t huge_ptep_get(pte_t *ptep);
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep);
 
-static inline bool is_hugepage_only_range(struct mm_struct *mm,
-					  unsigned long addr,
-					  unsigned long len)
-{
-	return false;
-}
-
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index 6f025fe18146..536ad2cb8aa4 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -5,12 +5,6 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr,
-					 unsigned long len) {
-	return 0;
-}
-
 /*
  * If the arch doesn't supply something else, assume that hugepage
  * size aligned regions are ok without further preparation.
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 3963f80d1cb3..a056fe1119f5 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -20,12 +20,6 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep);
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr,
-					 unsigned long len) {
-	return 0;
-}
-
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index f65cfb48cfdd..cc98f79074d0 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -7,12 +7,6 @@
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
 
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					 unsigned long addr,
-					 unsigned long len) {
-	return 0;
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1e897e4168ac..2342e5a8d1dd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -536,6 +536,14 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 
 #include <asm/hugetlb.h>
 
+#ifndef HAVE_ARCH_IS_HUGEPAGE_ONLY_RANGE
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					unsigned long addr, unsigned long len)
+{
+	return 0;
+}
+#endif
+
 #ifndef arch_make_huge_pte
 static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 				       struct page *page, int writable)
-- 
2.20.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB639F1F2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhFHJQQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 05:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhFHJQB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 05:16:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AA3861263;
        Tue,  8 Jun 2021 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623143648;
        bh=qtLyGf4vOvwEQ4V6NpeybsroEnpC9HLrj/S5SXiLLF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXjyyZdeHeuQup7ihRXT9g5Rcqskz7kAtycgK25ESN+vrnwhal3M07GJrwtMpl/C4
         AZoRmPM2WuCrAq9yFweXg2NonAq30t2uM2IMJkXsciSFm6AImoov5zH2BhrtmaTMlO
         pLgHE7HhAtnkiYCzbRAkozpnvaUq2X6BYWdsFid+O3M5UBDH9EFhjJKEfIEVr9svqk
         47CXSd2jgYa5bLhOY3TC+e2H2+gbfBVWCDrFYcsSKaxsUPiWu3pqmbz6VWz2Yzr9um
         2lhpyvxjitdGpzdWmkvgvj2LsuFPpe8IvqLi0D98Wet+sUDoHGrHN2+PipapH1ilB1
         d49xLqOZmw5zQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH v3 6/9] arch, mm: remove stale mentions of DISCONIGMEM
Date:   Tue,  8 Jun 2021 12:13:13 +0300
Message-Id: <20210608091316.3622-7-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210608091316.3622-1-rppt@kernel.org>
References: <20210608091316.3622-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are several places that mention DISCONIGMEM in comments or have stale
code guarded by CONFIG_DISCONTIGMEM.

Remove the dead code and update the comments.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/kernel/topology.c     | 5 ++---
 arch/ia64/mm/numa.c             | 5 ++---
 arch/mips/include/asm/mmzone.h  | 6 ------
 arch/mips/mm/init.c             | 3 ---
 arch/nds32/include/asm/memory.h | 6 ------
 arch/xtensa/include/asm/page.h  | 4 ----
 include/linux/gfp.h             | 4 ++--
 7 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 09fc385c2acd..3639e0a7cb3b 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -3,9 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * This file contains NUMA specific variables and functions which can
- * be split away from DISCONTIGMEM and are used on NUMA machines with
- * contiguous memory.
+ * This file contains NUMA specific variables and functions which are used on
+ * NUMA machines with contiguous memory.
  * 		2002/08/07 Erich Focht <efocht@ess.nec.de>
  * Populate cpu entries in sysfs for non-numa systems as well
  *  	Intel Corporation - Ashok Raj
diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
index 46b6e5f3a40f..d6579ec3ea32 100644
--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -3,9 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * This file contains NUMA specific variables and functions which can
- * be split away from DISCONTIGMEM and are used on NUMA machines with
- * contiguous memory.
+ * This file contains NUMA specific variables and functions which are used on
+ * NUMA machines with contiguous memory.
  * 
  *                         2002/08/07 Erich Focht <efocht@ess.nec.de>
  */
diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index b826b8473e95..7649ab45e80c 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -20,10 +20,4 @@
 #define nid_to_addrbase(nid) 0
 #endif
 
-#ifdef CONFIG_DISCONTIGMEM
-
-#define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
-
-#endif /* CONFIG_DISCONTIGMEM */
-
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index c36358758969..97f6ca341448 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -454,9 +454,6 @@ void __init mem_init(void)
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT));
 
 #ifdef CONFIG_HIGHMEM
-#ifdef CONFIG_DISCONTIGMEM
-#error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
-#endif
 	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
 #else
 	max_mapnr = max_low_pfn;
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
index 940d32842793..62faafbc28e4 100644
--- a/arch/nds32/include/asm/memory.h
+++ b/arch/nds32/include/asm/memory.h
@@ -76,18 +76,12 @@
  *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(k)	indicates whether a virtual address is valid
  */
-#ifndef CONFIG_DISCONTIGMEM
-
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
 
 #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 
-#else /* CONFIG_DISCONTIGMEM */
-#error CONFIG_DISCONTIGMEM is not supported yet.
-#endif /* !CONFIG_DISCONTIGMEM */
-
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 #endif
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 37ce25ef92d6..493eb7083b1a 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -192,10 +192,6 @@ static inline unsigned long ___pa(unsigned long va)
 #define pfn_valid(pfn) \
 	((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
 
-#ifdef CONFIG_DISCONTIGMEM
-# error CONFIG_DISCONTIGMEM not supported
-#endif
-
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 11da8af06704..dbe1f5fc901d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -494,8 +494,8 @@ static inline int gfp_zonelist(gfp_t flags)
  * There are two zonelists per node, one for all zones with memory and
  * one containing just zones from the node the zonelist belongs to.
  *
- * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
- * optimized to &contig_page_data at compile-time.
+ * For the case of non-NUMA systems the NODE_DATA() gets optimized to
+ * &contig_page_data at compile-time.
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
-- 
2.28.0


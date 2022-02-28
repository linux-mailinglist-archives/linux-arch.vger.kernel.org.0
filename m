Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8354C67A7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiB1Ku3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiB1KuP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:50:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68B0E606F8;
        Mon, 28 Feb 2022 02:49:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35EC9106F;
        Mon, 28 Feb 2022 02:49:36 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CFEF3F73D;
        Mon, 28 Feb 2022 02:49:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [PATCH V3 06/30] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 28 Feb 2022 16:17:29 +0530
Message-Id: <1646045273-9343-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed. This also localizes the
helper arch_vm_get_page_prot() as sparc_vm_get_page_prot() and moves near
vm_get_page_prot().

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Khalid Aziz <khalid.aziz@oracle.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sparc/Kconfig                  |  2 +
 arch/sparc/include/asm/mman.h       |  6 ---
 arch/sparc/include/asm/pgtable_32.h | 19 --------
 arch/sparc/include/asm/pgtable_64.h | 19 --------
 arch/sparc/mm/init_32.c             | 35 +++++++++++++++
 arch/sparc/mm/init_64.c             | 70 +++++++++++++++++++++--------
 6 files changed, 88 insertions(+), 63 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1cab1b284f1a..ff29156f2380 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -59,6 +59,7 @@ config SPARC32
 	select HAVE_UID16
 	select OLD_SIGACTION
 	select ZONE_DMA
+	select ARCH_HAS_VM_GET_PAGE_PROT
 
 config SPARC64
 	def_bool 64BIT
@@ -84,6 +85,7 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index 274217e7ed70..af9c10c83dc5 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -46,12 +46,6 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
 	}
 }
 
-#define arch_vm_get_page_prot(vm_flags) sparc_vm_get_page_prot(vm_flags)
-static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
-{
-	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
-}
-
 #define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
 static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 {
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index ffccfe3b22ed..060a435f96d6 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -64,25 +64,6 @@ void paging_init(void);
 
 extern unsigned long ptr_in_current_pgd;
 
-/*         xwr */
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_COPY
-#define __P011  PAGE_COPY
-#define __P100  PAGE_READONLY
-#define __P101  PAGE_READONLY
-#define __P110  PAGE_COPY
-#define __P111  PAGE_COPY
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED
-
 /* First physical page can be anywhere, the following is needed so that
  * va-->pa and vice versa conversions work properly without performance
  * hit for all __pa()/__va() operations.
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4679e45c8348..a779418ceba9 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -187,25 +187,6 @@ bool kern_addr_valid(unsigned long addr);
 #define _PAGE_SZHUGE_4U	_PAGE_SZ4MB_4U
 #define _PAGE_SZHUGE_4V	_PAGE_SZ4MB_4V
 
-/* These are actually filled in at boot time by sun4{u,v}_pgprot_init() */
-#define __P000	__pgprot(0)
-#define __P001	__pgprot(0)
-#define __P010	__pgprot(0)
-#define __P011	__pgprot(0)
-#define __P100	__pgprot(0)
-#define __P101	__pgprot(0)
-#define __P110	__pgprot(0)
-#define __P111	__pgprot(0)
-
-#define __S000	__pgprot(0)
-#define __S001	__pgprot(0)
-#define __S010	__pgprot(0)
-#define __S011	__pgprot(0)
-#define __S100	__pgprot(0)
-#define __S101	__pgprot(0)
-#define __S110	__pgprot(0)
-#define __S111	__pgprot(0)
-
 #ifndef __ASSEMBLY__
 
 pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 1e9f577f084d..348cbfe08b60 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -302,3 +302,38 @@ void sparc_flush_page_to_ram(struct page *page)
 		__flush_page_to_ram(vaddr);
 }
 EXPORT_SYMBOL(sparc_flush_page_to_ram);
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+		return PAGE_READONLY;
+	case VM_WRITE:
+	case VM_WRITE | VM_READ:
+		return PAGE_COPY;
+	case VM_EXEC:
+	case VM_EXEC | VM_READ:
+		return PAGE_READONLY;
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_COPY;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_SHARED;
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1b23639e2fcd..a390116d371b 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -50,6 +50,7 @@
 #include <asm/cpudata.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
+#include <asm/mman.h>
 
 #include "init_64.h"
 
@@ -2641,29 +2642,13 @@ static void prot_init_common(unsigned long page_none,
 {
 	PAGE_COPY = __pgprot(page_copy);
 	PAGE_SHARED = __pgprot(page_shared);
-
-	protection_map[0x0] = __pgprot(page_none);
-	protection_map[0x1] = __pgprot(page_readonly & ~page_exec_bit);
-	protection_map[0x2] = __pgprot(page_copy & ~page_exec_bit);
-	protection_map[0x3] = __pgprot(page_copy & ~page_exec_bit);
-	protection_map[0x4] = __pgprot(page_readonly);
-	protection_map[0x5] = __pgprot(page_readonly);
-	protection_map[0x6] = __pgprot(page_copy);
-	protection_map[0x7] = __pgprot(page_copy);
-	protection_map[0x8] = __pgprot(page_none);
-	protection_map[0x9] = __pgprot(page_readonly & ~page_exec_bit);
-	protection_map[0xa] = __pgprot(page_shared & ~page_exec_bit);
-	protection_map[0xb] = __pgprot(page_shared & ~page_exec_bit);
-	protection_map[0xc] = __pgprot(page_readonly);
-	protection_map[0xd] = __pgprot(page_readonly);
-	protection_map[0xe] = __pgprot(page_shared);
-	protection_map[0xf] = __pgprot(page_shared);
 }
 
+static unsigned long page_none, page_shared, page_copy, page_readonly;
+static unsigned long page_exec_bit;
+
 static void __init sun4u_pgprot_init(void)
 {
-	unsigned long page_none, page_shared, page_copy, page_readonly;
-	unsigned long page_exec_bit;
 	int i;
 
 	PAGE_KERNEL = __pgprot (_PAGE_PRESENT_4U | _PAGE_VALID |
@@ -3183,3 +3168,50 @@ void copy_highpage(struct page *to, struct page *from)
 	}
 }
 EXPORT_SYMBOL(copy_highpage);
+
+static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __pgprot(page_none);
+	case VM_READ:
+		return __pgprot(page_readonly & ~page_exec_bit);
+	case VM_WRITE:
+	case VM_WRITE | VM_READ:
+		return __pgprot(page_copy & ~page_exec_bit);
+	case VM_EXEC:
+	case VM_EXEC | VM_READ:
+		return __pgprot(page_readonly);
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(page_copy);
+	case VM_SHARED:
+		return __pgprot(page_none);
+	case VM_SHARED | VM_READ:
+		return __pgprot(page_readonly & ~page_exec_bit);
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return __pgprot(page_shared & ~page_exec_bit);
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(page_readonly);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(page_shared);
+	default:
+		BUILD_BUG();
+	}
+}
+
+static pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
+}
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
+	       pgprot_val(sparc_vm_get_page_prot(vm_flags)));
+
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


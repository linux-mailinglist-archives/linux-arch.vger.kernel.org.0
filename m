Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4D500601
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 08:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiDNGYS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 02:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiDNGYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 02:24:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A41771F601;
        Wed, 13 Apr 2022 23:21:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64ECA1650;
        Wed, 13 Apr 2022 23:21:29 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.37.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBDBF3F70D;
        Wed, 13 Apr 2022 23:21:23 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V7 5/7] x86/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Thu, 14 Apr 2022 11:51:23 +0530
Message-Id: <20220414062125.609297-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062125.609297-1-anshuman.khandual@arm.com>
References: <20220414062125.609297-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. This also unsubscribes from config
ARCH_HAS_FILTER_PGPROT, after dropping off arch_filter_pgprot() and
arch_vm_get_page_prot().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/Kconfig                 |  2 +-
 arch/x86/include/asm/pgtable.h   |  5 -----
 arch/x86/include/uapi/asm/mman.h | 14 -------------
 arch/x86/mm/Makefile             |  2 +-
 arch/x86/mm/pgprot.c             | 35 ++++++++++++++++++++++++++++++++
 5 files changed, 37 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/mm/pgprot.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..c355c420150e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -76,7 +76,6 @@ config X86
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
-	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
@@ -95,6 +94,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..3563f4645fa1 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -649,11 +649,6 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 
 #define canon_pgprot(p) __pgprot(massage_pgprot(p))
 
-static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-{
-	return canon_pgprot(prot);
-}
-
 static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 					 enum page_cache_mode pcm,
 					 enum page_cache_mode new_pcm)
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index d4a8d0424bfb..775dbd3aff73 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,20 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-/*
- * Take the 4 protection key bits out of the vma->vm_flags
- * value and turn them in to the bits that we can put in
- * to a pte.
- *
- * Only override these if Protection Keys are available
- * (which is only on 64-bit).
- */
-#define arch_vm_get_page_prot(vm_flags)	__pgprot(	\
-		((vm_flags) & VM_PKEY_BIT0 ? _PAGE_PKEY_BIT0 : 0) |	\
-		((vm_flags) & VM_PKEY_BIT1 ? _PAGE_PKEY_BIT1 : 0) |	\
-		((vm_flags) & VM_PKEY_BIT2 ? _PAGE_PKEY_BIT2 : 0) |	\
-		((vm_flags) & VM_PKEY_BIT3 ? _PAGE_PKEY_BIT3 : 0))
-
 #define arch_calc_vm_prot_bits(prot, key) (		\
 		((key) & 0x1 ? VM_PKEY_BIT0 : 0) |      \
 		((key) & 0x2 ? VM_PKEY_BIT1 : 0) |      \
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index fe3d3061fc11..fb6b41a48ae5 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -20,7 +20,7 @@ CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
 obj-y				:=  init.o init_$(BITS).o fault.o ioremap.o extable.o mmap.o \
-				    pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o
+				    pgtable.o physaddr.o setup_nx.o tlb.o cpu_entry_area.o maccess.o pgprot.o
 
 obj-y				+= pat/
 
diff --git a/arch/x86/mm/pgprot.c b/arch/x86/mm/pgprot.c
new file mode 100644
index 000000000000..763742782286
--- /dev/null
+++ b/arch/x86/mm/pgprot.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <asm/pgtable.h>
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	unsigned long val = pgprot_val(protection_map[vm_flags &
+				      (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+	/*
+	 * Take the 4 protection key bits out of the vma->vm_flags value and
+	 * turn them in to the bits that we can put in to a pte.
+	 *
+	 * Only override these if Protection Keys are available (which is only
+	 * on 64-bit).
+	 */
+	if (vm_flags & VM_PKEY_BIT0)
+		val |= _PAGE_PKEY_BIT0;
+	if (vm_flags & VM_PKEY_BIT1)
+		val |= _PAGE_PKEY_BIT1;
+	if (vm_flags & VM_PKEY_BIT2)
+		val |= _PAGE_PKEY_BIT2;
+	if (vm_flags & VM_PKEY_BIT3)
+		val |= _PAGE_PKEY_BIT3;
+#endif
+
+	val = __sme_set(val);
+	if (val & _PAGE_PRESENT)
+		val &= __supported_pte_mask;
+	return __pgprot(val);
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


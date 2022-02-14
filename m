Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8D24B3F76
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 03:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiBNCb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Feb 2022 21:31:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiBNCb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2022 21:31:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C5D5548A;
        Sun, 13 Feb 2022 18:31:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5317DED1;
        Sun, 13 Feb 2022 18:31:15 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 088413F718;
        Sun, 13 Feb 2022 18:31:11 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/30] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 14 Feb 2022 08:00:27 +0530
Message-Id: <1644805853-21338-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
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
macros can be dropped which are no longer needed. While here, this also
localizes arch_vm_get_page_prot() as powerpc_vm_get_page_prot() and moves
it near vm_get_page_prot().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/mman.h    | 12 ------
 arch/powerpc/include/asm/pgtable.h | 19 ----------
 arch/powerpc/mm/mmap.c             | 59 ++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b779603978e1..ddb4a3687c05 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -135,6 +135,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 7cb6d18f5cd6..1b024e64c8ec 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -24,18 +24,6 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
-{
-#ifdef CONFIG_PPC_MEM_KEYS
-	return (vm_flags & VM_SAO) ?
-		__pgprot(_PAGE_SAO | vmflag_to_pte_pkey_bits(vm_flags)) :
-		__pgprot(0 | vmflag_to_pte_pkey_bits(vm_flags));
-#else
-	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
-#endif
-}
-#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
-
 static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index d564d0ecd4cd..3cbb6de20f9d 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,25 +20,6 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
-/* Note due to the way vm flags are laid out, the bits are XWR */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
-
 #ifndef __ASSEMBLY__
 
 #ifndef MAX_PTRS_PER_PGD
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index c475cf810aa8..ee275937fe19 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -254,3 +254,62 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
+
+static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
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
+		return PAGE_READONLY_X;
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_COPY_X;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_READONLY_X;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_SHARED_X;
+	default:
+		BUILD_BUG();
+	}
+}
+
+#ifdef CONFIG_PPC64
+static pgprot_t powerpc_vm_get_page_prot(unsigned long vm_flags)
+{
+#ifdef CONFIG_PPC_MEM_KEYS
+	return (vm_flags & VM_SAO) ?
+		__pgprot(_PAGE_SAO | vmflag_to_pte_pkey_bits(vm_flags)) :
+		__pgprot(0 | vmflag_to_pte_pkey_bits(vm_flags));
+#else
+	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
+#endif
+}
+#else
+static pgprot_t powerpc_vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(0);
+}
+#endif /* CONFIG_PPC64 */
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
+	       pgprot_val(powerpc_vm_get_page_prot(vm_flags)));
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


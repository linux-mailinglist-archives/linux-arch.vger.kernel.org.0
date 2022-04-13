Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCC4FEEE4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 07:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiDMGA4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDMGAx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:00:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7FC65045D;
        Tue, 12 Apr 2022 22:58:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 870B0150C;
        Tue, 12 Apr 2022 22:58:29 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EDF53F70D;
        Tue, 12 Apr 2022 22:58:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH V6 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Wed, 13 Apr 2022 11:28:35 +0530
Message-Id: <20220413055840.392628-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413055840.392628-1-anshuman.khandual@arm.com>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
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

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. While here, this also localizes
arch_vm_get_page_prot() as __vm_get_page_prot() and moves it near
vm_get_page_prot().

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/powerpc/Kconfig               |  1 +
 arch/powerpc/include/asm/mman.h    | 12 ------------
 arch/powerpc/mm/book3s64/pgtable.c | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..69e44358a235 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VM_GET_PAGE_PROT	if PPC_BOOK3S_64
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
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 052e6590f84f..8b474ab32f67 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -7,6 +7,7 @@
 #include <linux/mm_types.h>
 #include <linux/memblock.h>
 #include <linux/memremap.h>
+#include <linux/pkeys.h>
 #include <linux/debugfs.h>
 #include <misc/cxl-base.h>
 
@@ -549,3 +550,19 @@ unsigned long memremap_compat_align(void)
 }
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	unsigned long prot = pgprot_val(protection_map[vm_flags &
+					(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+
+	if (vm_flags & VM_SAO)
+		prot |= _PAGE_SAO;
+
+#ifdef CONFIG_PPC_MEM_KEYS
+	prot |= vmflag_to_pte_pkey_bits(vm_flags);
+#endif
+
+	return __pgprot(prot);
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


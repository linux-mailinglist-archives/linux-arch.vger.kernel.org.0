Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594D14C68DD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiB1Kzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiB1Kyt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:54:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 608F465B9;
        Mon, 28 Feb 2022 02:52:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DC19106F;
        Mon, 28 Feb 2022 02:52:44 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D472D3F73D;
        Mon, 28 Feb 2022 02:52:35 -0800 (PST)
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
        linux-arch@vger.kernel.org
Subject: [PATCH V3 28/30] ia64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 28 Feb 2022 16:17:51 +0530
Message-Id: <1646045273-9343-29-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/ia64/Kconfig               |  1 +
 arch/ia64/include/asm/pgtable.h | 17 --------------
 arch/ia64/mm/init.c             | 41 ++++++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index a7e01573abd8..0ab15e8d5783 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -11,6 +11,7 @@ config IA64
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 9584b2c5f394..8154c78bba56 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -161,23 +161,6 @@
  * attempts to write to the page.
  */
 	/* xwr */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_READONLY	/* write to priv pg -> copy & make writable */
-#define __P011	PAGE_READONLY	/* ditto */
-#define __P100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
-#define __P101	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define __P110	PAGE_COPY_EXEC
-#define __P111	PAGE_COPY_EXEC
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED	/* we don't have (and don't need) write-only */
-#define __S011	PAGE_SHARED
-#define __S100	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX)
-#define __S101	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX)
-#define __S110	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
-#define __S111	__pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX)
 
 #define pgd_ERROR(e)	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
 #if CONFIG_PGTABLE_LEVELS == 4
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 5d165607bf35..2a922883e30f 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -273,7 +273,7 @@ static int __init gate_vma_init(void)
 	gate_vma.vm_start = FIXADDR_USER_START;
 	gate_vma.vm_end = FIXADDR_USER_END;
 	gate_vma.vm_flags = VM_READ | VM_MAYREAD | VM_EXEC | VM_MAYEXEC;
-	gate_vma.vm_page_prot = __P101;
+	gate_vma.vm_page_prot = __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX);
 
 	return 0;
 }
@@ -492,3 +492,42 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	__remove_pages(start_pfn, nr_pages, altmap);
 }
 #endif
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+	/* write to priv pg -> copy & make writable */
+	case VM_WRITE:
+	/* write to priv pg -> copy & make writable */
+	case VM_WRITE | VM_READ:
+		return PAGE_READONLY;
+	case VM_EXEC:
+		return __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX);
+	case VM_EXEC | VM_READ:
+		return __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX);
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_COPY_EXEC;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	/* we don't have (and don't need) write-only */
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+		return __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_X_RX);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RX);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(__ACCESS_BITS | _PAGE_PL_3 | _PAGE_AR_RWX);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


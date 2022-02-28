Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074644C68B0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiB1KzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiB1Kyq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:54:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC01AF19;
        Mon, 28 Feb 2022 02:52:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AD69106F;
        Mon, 28 Feb 2022 02:52:26 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4B533F73D;
        Mon, 28 Feb 2022 02:52:18 -0800 (PST)
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
        linux-arch@vger.kernel.org, Brian Cain <bcain@codeaurora.org>
Subject: [PATCH V3 26/30] hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 28 Feb 2022 16:17:49 +0530
Message-Id: <1646045273-9343-27-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
macros can be dropped which are no longer needed.

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/hexagon/Kconfig               |  1 +
 arch/hexagon/include/asm/pgtable.h | 24 -----------
 arch/hexagon/mm/init.c             | 67 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 15dd8f38b698..cdc5df32a1e3 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -6,6 +6,7 @@ config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_NO_PREEMPT
 	select DMA_GLOBAL_POOL
 	# Other pending projects/to-do items.
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 18cd6ea9ab23..5eceddfe013d 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -127,31 +127,7 @@ extern unsigned long _dflt_cache_att;
 #define CACHEDEF	(CACHE_DEFAULT << 6)
 
 /* Private (copy-on-write) page protections. */
-#define __P000 __pgprot(_PAGE_PRESENT | _PAGE_USER | CACHEDEF)
-#define __P001 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | CACHEDEF)
-#define __P010 __P000	/* Write-only copy-on-write */
-#define __P011 __P001	/* Read/Write copy-on-write */
-#define __P100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __P101 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_EXECUTE | \
-			_PAGE_READ | CACHEDEF)
-#define __P110 __P100	/* Write/execute copy-on-write */
-#define __P111 __P101	/* Read/Write/Execute, copy-on-write */
-
 /* Shared page protections. */
-#define __S000 __P000
-#define __S001 __P001
-#define __S010 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S011 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_WRITE | CACHEDEF)
-#define __S100 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | CACHEDEF)
-#define __S101 __P101
-#define __S110 __pgprot(_PAGE_PRESENT | _PAGE_USER | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
-#define __S111 __pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | \
-			_PAGE_EXECUTE | _PAGE_WRITE | CACHEDEF)
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];  /* located in head.S */
 
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index f01e91e10d95..b53595fc4103 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -236,3 +236,70 @@ void __init setup_arch_memory(void)
 	 *  which is called by start_kernel() later on in the process
 	 */
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				CACHEDEF);
+	case VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_READ | CACHEDEF);
+	/* Write-only copy-on-write */
+	case VM_WRITE:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				CACHEDEF);
+	/* Read/Write copy-on-write */
+	case VM_WRITE | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_READ | CACHEDEF);
+	case VM_EXEC:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | CACHEDEF);
+	case VM_EXEC | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | _PAGE_READ |
+				CACHEDEF);
+	/* Write/execute copy-on-write */
+	case VM_EXEC | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | CACHEDEF);
+	/* Read/Write/Execute, copy-on-write */
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | _PAGE_READ |
+				CACHEDEF);
+	case VM_SHARED:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				CACHEDEF);
+	case VM_SHARED | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_READ | CACHEDEF);
+	case VM_SHARED | VM_WRITE:
+		return  __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_WRITE | CACHEDEF);
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_READ | _PAGE_WRITE |
+				CACHEDEF);
+	case VM_SHARED | VM_EXEC:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | CACHEDEF);
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | _PAGE_READ |
+				CACHEDEF);
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_EXECUTE | _PAGE_WRITE |
+				CACHEDEF);
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return __pgprot(_PAGE_PRESENT | _PAGE_USER |
+				_PAGE_READ | _PAGE_EXECUTE |
+				_PAGE_WRITE | CACHEDEF);
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


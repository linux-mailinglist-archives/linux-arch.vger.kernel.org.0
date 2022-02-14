Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F804B3FA3
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 03:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiBNCdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Feb 2022 21:33:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239624AbiBNCcV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2022 21:32:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5DAB580D8;
        Sun, 13 Feb 2022 18:32:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B09BC106F;
        Sun, 13 Feb 2022 18:32:04 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC9383F718;
        Sun, 13 Feb 2022 18:32:01 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Guo Ren <guoren@kernel.org>, linux-xtensa@linux-xtensa.org,
        linux-csky@vger.kernel.org
Subject: [PATCH 20/30] extensa/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 14 Feb 2022 08:00:43 +0530
Message-Id: <1644805853-21338-21-git-send-email-anshuman.khandual@arm.com>
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
macros can be dropped which are no longer needed.

Cc: Chris Zankel <chris@zankel.net>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/include/asm/pgtable.h | 18 ----------------
 arch/xtensa/mm/init.c             | 35 +++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8ac599aa6d99..1608f7517546 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -9,6 +9,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index bd5aeb795567..ed6e93097142 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -200,24 +200,6 @@
  * What follows is the closest we can get by reasonable means..
  * See linux/mm/mmap.c for protection_map[] array that uses these definitions.
  */
-#define __P000	PAGE_NONE		/* private --- */
-#define __P001	PAGE_READONLY		/* private --r */
-#define __P010	PAGE_COPY		/* private -w- */
-#define __P011	PAGE_COPY		/* private -wr */
-#define __P100	PAGE_READONLY_EXEC	/* private x-- */
-#define __P101	PAGE_READONLY_EXEC	/* private x-r */
-#define __P110	PAGE_COPY_EXEC		/* private xw- */
-#define __P111	PAGE_COPY_EXEC		/* private xwr */
-
-#define __S000	PAGE_NONE		/* shared  --- */
-#define __S001	PAGE_READONLY		/* shared  --r */
-#define __S010	PAGE_SHARED		/* shared  -w- */
-#define __S011	PAGE_SHARED		/* shared  -wr */
-#define __S100	PAGE_READONLY_EXEC	/* shared  x-- */
-#define __S101	PAGE_READONLY_EXEC	/* shared  x-r */
-#define __S110	PAGE_SHARED_EXEC	/* shared  xw- */
-#define __S111	PAGE_SHARED_EXEC	/* shared  xwr */
-
 #ifndef __ASSEMBLY__
 
 #define pte_ERROR(e) \
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 6a32b2cf2718..5f090749e9e0 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -216,3 +216,38 @@ static int __init parse_memmap_opt(char *str)
 	return 0;
 }
 early_param("memmap", parse_memmap_opt);
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
+		return PAGE_READONLY_EXEC;
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_COPY_EXEC;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_READONLY;
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PAGE_SHARED;
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_READONLY_EXEC;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_SHARED_EXEC;
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


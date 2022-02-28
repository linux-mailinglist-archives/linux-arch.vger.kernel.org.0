Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564E44C67C8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiB1KvY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiB1KvR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:51:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1263B66AE0;
        Mon, 28 Feb 2022 02:50:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D633511FB;
        Mon, 28 Feb 2022 02:50:18 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 479283F73D;
        Mon, 28 Feb 2022 02:50:11 -0800 (PST)
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
Subject: [PATCH V3 11/30] mm/mmap: Drop protection_map[]
Date:   Mon, 28 Feb 2022 16:17:34 +0530
Message-Id: <1646045273-9343-12-git-send-email-anshuman.khandual@arm.com>
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

There are no other users for protection_map[]. Hence just drop this array
construct and instead define __vm_get_page_prot() which will provide page
protection map based on vm_flags combination switch.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/gpu/drm/drm_vm.c |  4 +--
 include/linux/mm.h       |  6 ----
 mm/mmap.c                | 63 ++++++++++++++++++++++++++--------------
 3 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index e957d4851dc0..14862df7532f 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -482,7 +482,7 @@ static int drm_mmap_dma(struct file *filp, struct vm_area_struct *vma)
 #else
 		/* Ye gads this is ugly.  With more thought
 		   we could move this up higher and use
-		   `protection_map' instead.  */
+		   `vm_get_page_prot()' instead.  */
 		vma->vm_page_prot =
 		    __pgprot(pte_val
 			     (pte_wrprotect
@@ -566,7 +566,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 #else
 		/* Ye gads this is ugly.  With more thought
 		   we could move this up higher and use
-		   `protection_map' instead.  */
+		   `vm_get_page_prot()' instead.  */
 		vma->vm_page_prot =
 		    __pgprot(pte_val
 			     (pte_wrprotect
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..ff74bd2d7850 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -418,12 +418,6 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
-/*
- * mapping from the currently active vm_flags protection bits (the
- * low four bits) to a page protection mask..
- */
-extern pgprot_t protection_map[16];
-
 /*
  * The default fault flags that should be used by most of the
  * arch-specific page fault handlers.
diff --git a/mm/mmap.c b/mm/mmap.c
index f2310f6e7466..78eeac277a80 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,24 +102,6 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-pgprot_t protection_map[16] __ro_after_init = {
-	[VM_NONE]					= __P000,
-	[VM_READ]					= __P001,
-	[VM_WRITE]					= __P010,
-	[VM_WRITE | VM_READ]				= __P011,
-	[VM_EXEC]					= __P100,
-	[VM_EXEC | VM_READ]				= __P101,
-	[VM_EXEC | VM_WRITE]				= __P110,
-	[VM_EXEC | VM_WRITE | VM_READ]			= __P111,
-	[VM_SHARED]					= __S000,
-	[VM_SHARED | VM_READ]				= __S001,
-	[VM_SHARED | VM_WRITE]				= __S010,
-	[VM_SHARED | VM_WRITE | VM_READ]		= __S011,
-	[VM_SHARED | VM_EXEC]				= __S100,
-	[VM_SHARED | VM_EXEC | VM_READ]			= __S101,
-	[VM_SHARED | VM_EXEC | VM_WRITE]		= __S110,
-	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
-};
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
@@ -128,10 +110,49 @@ static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
 }
 #endif
 
+static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return __P000;
+	case VM_READ:
+		return __P001;
+	case VM_WRITE:
+		return __P010;
+	case VM_READ | VM_WRITE:
+		return __P011;
+	case VM_EXEC:
+		return __P100;
+	case VM_EXEC | VM_READ:
+		return __P101;
+	case VM_EXEC | VM_WRITE:
+		return __P110;
+	case VM_EXEC | VM_READ | VM_WRITE:
+		return __P111;
+	case VM_SHARED:
+		return __S000;
+	case VM_SHARED | VM_READ:
+		return __S001;
+	case VM_SHARED | VM_WRITE:
+		return __S010;
+	case VM_SHARED | VM_READ | VM_WRITE:
+		return __S011;
+	case VM_SHARED | VM_EXEC:
+		return __S100;
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return __S101;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+		return __S110;
+	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
+		return __S111;
+	default:
+		BUILD_BUG();
+	}
+}
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
-				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
+	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
 
 	return arch_filter_pgprot(ret);
@@ -1684,7 +1705,7 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 /*
  * Some shared mappings will want the pages marked read-only
  * to track write events. If so, we'll downgrade vm_page_prot
- * to the private version (using protection_map[] without the
+ * to the private version (using vm_get_page_prot() without the
  * VM_SHARED bit).
  */
 int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
-- 
2.25.1


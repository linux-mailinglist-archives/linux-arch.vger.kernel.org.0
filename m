Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8404B3F87
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 03:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiBNCcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Feb 2022 21:32:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbiBNCb7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2022 21:31:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 852215B3D4;
        Sun, 13 Feb 2022 18:31:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53DAF1396;
        Sun, 13 Feb 2022 18:31:37 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E3CE3F718;
        Sun, 13 Feb 2022 18:31:35 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 11/30] mm/mmap: Drop protection_map[]
Date:   Mon, 14 Feb 2022 08:00:34 +0530
Message-Id: <1644805853-21338-12-git-send-email-anshuman.khandual@arm.com>
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

There are no other users for protection_map[]. Hence just drop this array
construct and instead define __vm_get_page_prot() which will provide page
protection map based on vm_flags combination switch.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h |  6 -----
 mm/mmap.c          | 61 +++++++++++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 26 deletions(-)

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
index ffd70a0c8ddf..f61f74a61f62 100644
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
-- 
2.25.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CA4BD68E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiBUGkn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:40:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345419AbiBUGkA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:40:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3ACA26AC3;
        Sun, 20 Feb 2022 22:39:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3BF8113E;
        Sun, 20 Feb 2022 22:39:33 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 703623F70D;
        Sun, 20 Feb 2022 22:39:29 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH V2 14/30] s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Mon, 21 Feb 2022 12:08:23 +0530
Message-Id: <1645425519-9034-15-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
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

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/pgtable.h | 17 -----------------
 arch/s390/mm/mmap.c             | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index be9f39fd06df..cb1b487e8201 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -78,6 +78,7 @@ config S390
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 008a6c856fa4..3893ef64b439 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -422,23 +422,6 @@ static inline int is_module_addr(void *addr)
  * implies read permission.
  */
          /*xwr*/
-#define __P000	PAGE_NONE
-#define __P001	PAGE_RO
-#define __P010	PAGE_RO
-#define __P011	PAGE_RO
-#define __P100	PAGE_RX
-#define __P101	PAGE_RX
-#define __P110	PAGE_RX
-#define __P111	PAGE_RX
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_RO
-#define __S010	PAGE_RW
-#define __S011	PAGE_RW
-#define __S100	PAGE_RX
-#define __S101	PAGE_RX
-#define __S110	PAGE_RWX
-#define __S111	PAGE_RWX
 
 /*
  * Segment entry (large page) protection definitions.
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index e54f928503c5..e99c198aa5de 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -188,3 +188,36 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
 	}
 }
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
+	case VM_NONE:
+		return PAGE_NONE;
+	case VM_READ:
+	case VM_WRITE:
+	case VM_WRITE | VM_READ:
+		return PAGE_RO;
+	case VM_EXEC:
+	case VM_EXEC | VM_READ:
+	case VM_EXEC | VM_WRITE:
+	case VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_RX;
+	case VM_SHARED:
+		return PAGE_NONE;
+	case VM_SHARED | VM_READ:
+		return PAGE_RO;
+	case VM_SHARED | VM_WRITE:
+	case VM_SHARED | VM_WRITE | VM_READ:
+		return PAGE_RW;
+	case VM_SHARED | VM_EXEC:
+	case VM_SHARED | VM_EXEC | VM_READ:
+		return PAGE_RX;
+	case VM_SHARED | VM_EXEC | VM_WRITE:
+	case VM_SHARED | VM_EXEC | VM_WRITE | VM_READ:
+		return PAGE_RWX;
+	default:
+		BUILD_BUG();
+	}
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


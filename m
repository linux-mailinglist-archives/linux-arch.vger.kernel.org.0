Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D514BD69C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiBUGkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:40:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345343AbiBUGj6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:39:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2267339688;
        Sun, 20 Feb 2022 22:39:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8561476;
        Sun, 20 Feb 2022 22:39:28 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BAA653F70D;
        Sun, 20 Feb 2022 22:39:26 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 13/30] mm/mmap: Drop arch_vm_get_page_pgprot()
Date:   Mon, 21 Feb 2022 12:08:22 +0530
Message-Id: <1645425519-9034-14-git-send-email-anshuman.khandual@arm.com>
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

There are no platforms left which use arch_vm_get_page_prot(). Just drop
arch_vm_get_page_prot() construct and simplify remaining code.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mman.h |  4 ----
 mm/mmap.c            | 10 +---------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index b66e91b8176c..58b3abd457a3 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -93,10 +93,6 @@ static inline void vm_unacct_memory(long pages)
 #define arch_calc_vm_flag_bits(flags) 0
 #endif
 
-#ifndef arch_vm_get_page_prot
-#define arch_vm_get_page_prot(vm_flags) __pgprot(0)
-#endif
-
 #ifndef arch_validate_prot
 /*
  * This is called from mprotect().  PROT_GROWSDOWN and PROT_GROWSUP have
diff --git a/mm/mmap.c b/mm/mmap.c
index 70a75ea91e94..2fc597cf8b8d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,7 +102,7 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
 	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
 	case VM_NONE:
@@ -141,14 +141,6 @@ static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
 		BUILD_BUG();
 	}
 }
-
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
-{
-	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
-			pgprot_val(arch_vm_get_page_prot(vm_flags)));
-
-	return ret;
-}
 EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
-- 
2.25.1


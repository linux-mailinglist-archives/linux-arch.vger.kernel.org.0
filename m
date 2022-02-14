Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A504B3F8A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 03:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiBNCcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Feb 2022 21:32:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiBNCb7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2022 21:31:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CFFC55489;
        Sun, 13 Feb 2022 18:31:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18941424;
        Sun, 13 Feb 2022 18:31:39 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD3963F718;
        Sun, 13 Feb 2022 18:31:37 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 12/30] mm/mmap: Drop arch_filter_pgprot()
Date:   Mon, 14 Feb 2022 08:00:35 +0530
Message-Id: <1644805853-21338-13-git-send-email-anshuman.khandual@arm.com>
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

There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
just drop arch_filter_pgprot() and also the config ARCH_HAS_FILTER_PGPROT.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/Kconfig |  3 ---
 mm/mmap.c  | 10 +---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index fa436478a94c..212fb6e1ddaa 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -744,9 +744,6 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
-config ARCH_HAS_FILTER_PGPROT
-	bool
-
 config ARCH_HAS_VM_GET_PAGE_PROT
 	bool
 
diff --git a/mm/mmap.c b/mm/mmap.c
index f61f74a61f62..70a75ea91e94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,14 +102,6 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-
-#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-{
-	return prot;
-}
-#endif
-
 static inline pgprot_t __vm_get_page_prot(unsigned long vm_flags)
 {
 	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
@@ -155,7 +147,7 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	pgprot_t ret = __pgprot(pgprot_val(__vm_get_page_prot(vm_flags)) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
 
-	return arch_filter_pgprot(ret);
+	return ret;
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
-- 
2.25.1


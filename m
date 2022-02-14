Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06AA4B3FB5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 03:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiBNCdy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Feb 2022 21:33:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbiBNCda (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Feb 2022 21:33:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0208760A8B;
        Sun, 13 Feb 2022 18:32:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E1461424;
        Sun, 13 Feb 2022 18:32:30 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 568453F718;
        Sun, 13 Feb 2022 18:32:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 29/30] mm/mmap: Drop generic vm_get_page_prot()
Date:   Mon, 14 Feb 2022 08:00:52 +0530
Message-Id: <1644805853-21338-30-git-send-email-anshuman.khandual@arm.com>
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

All available platforms export their own vm_get_page_prot() implementation
via ARCH_HAS_VM_GET_PAGE_PROT. Hence a generic implementation is no longer
needed.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/mmap.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2fc597cf8b8d..368bc8aee45b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,46 +102,6 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
-pgprot_t vm_get_page_prot(unsigned long vm_flags)
-{
-	switch (vm_flags & (VM_READ | VM_WRITE | VM_EXEC | VM_SHARED)) {
-	case VM_NONE:
-		return __P000;
-	case VM_READ:
-		return __P001;
-	case VM_WRITE:
-		return __P010;
-	case VM_READ | VM_WRITE:
-		return __P011;
-	case VM_EXEC:
-		return __P100;
-	case VM_EXEC | VM_READ:
-		return __P101;
-	case VM_EXEC | VM_WRITE:
-		return __P110;
-	case VM_EXEC | VM_READ | VM_WRITE:
-		return __P111;
-	case VM_SHARED:
-		return __S000;
-	case VM_SHARED | VM_READ:
-		return __S001;
-	case VM_SHARED | VM_WRITE:
-		return __S010;
-	case VM_SHARED | VM_READ | VM_WRITE:
-		return __S011;
-	case VM_SHARED | VM_EXEC:
-		return __S100;
-	case VM_SHARED | VM_EXEC | VM_READ:
-		return __S101;
-	case VM_SHARED | VM_EXEC | VM_WRITE:
-		return __S110;
-	case VM_SHARED | VM_EXEC | VM_READ | VM_WRITE:
-		return __S111;
-	default:
-		BUILD_BUG();
-	}
-}
-EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
-- 
2.25.1


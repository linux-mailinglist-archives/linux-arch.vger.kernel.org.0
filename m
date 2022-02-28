Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D54C68D7
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 11:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiB1K4C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 05:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiB1Kyt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 05:54:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1580712601;
        Mon, 28 Feb 2022 02:52:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD662106F;
        Mon, 28 Feb 2022 02:52:51 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.47.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A59CF3F73D;
        Mon, 28 Feb 2022 02:52:44 -0800 (PST)
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
Subject: [PATCH V3 29/30] mm/mmap: Drop generic vm_get_page_prot()
Date:   Mon, 28 Feb 2022 16:17:52 +0530
Message-Id: <1646045273-9343-30-git-send-email-anshuman.khandual@arm.com>
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
index c13dd9c37866..ff343f76a825 100644
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


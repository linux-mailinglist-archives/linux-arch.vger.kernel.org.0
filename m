Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A14FEEF0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiDMGBc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDMGBR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:01:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76F7A50E22;
        Tue, 12 Apr 2022 22:58:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3176113D5;
        Tue, 12 Apr 2022 22:58:56 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0B0A3F70D;
        Tue, 12 Apr 2022 22:58:50 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 6/7] mm/mmap: Drop arch_filter_pgprot()
Date:   Wed, 13 Apr 2022 11:28:39 +0530
Message-Id: <20220413055840.392628-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413055840.392628-1-anshuman.khandual@arm.com>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
drop generic arch_filter_pgprot() and also config ARCH_HAS_FILTER_PGPROT.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/Kconfig |  3 ---
 mm/mmap.c  | 13 ++-----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b1f7624276f8..3f7b6d7b69df 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -762,9 +762,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.
 
-config ARCH_HAS_FILTER_PGPROT
-	bool
-
 config ARCH_HAS_VM_GET_PAGE_PROT
 	bool
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 87cb2eaf7e1a..b96e995f3733 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -107,20 +107,11 @@ pgprot_t protection_map[16] __ro_after_init = {
 };
 
 #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
-#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
-{
-	return prot;
-}
-#endif
-
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
-				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
+	return __pgprot(pgprot_val(protection_map[vm_flags &
+			(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
-
-	return arch_filter_pgprot(ret);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
-- 
2.25.1


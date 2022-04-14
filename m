Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86145005E8
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiDNGXw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiDNGXl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 02:23:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 185584D26C;
        Wed, 13 Apr 2022 23:21:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA2515BF;
        Wed, 13 Apr 2022 23:21:16 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.37.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B7423F70D;
        Wed, 13 Apr 2022 23:21:11 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: [PATCH V7 3/7] arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Thu, 14 Apr 2022 11:51:21 +0530
Message-Id: <20220414062125.609297-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062125.609297-1-anshuman.khandual@arm.com>
References: <20220414062125.609297-1-anshuman.khandual@arm.com>
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

This defines and exports a platform specific custom vm_get_page_prot() via
subscribing ARCH_HAS_VM_GET_PAGE_PROT. It localizes arch_vm_get_page_prot()
and moves it near vm_get_page_prot().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/mman.h | 24 ------------------------
 arch/arm64/mm/mmap.c          | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 57c4c995965f..dd0b15162bb3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -45,6 +45,7 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index e3e28f7daf62..5966ee4a6154 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -35,30 +35,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 }
 #define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
 
-static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
-{
-	pteval_t prot = 0;
-
-	if (vm_flags & VM_ARM64_BTI)
-		prot |= PTE_GP;
-
-	/*
-	 * There are two conditions required for returning a Normal Tagged
-	 * memory type: (1) the user requested it via PROT_MTE passed to
-	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
-	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
-	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
-	 * mmap() call since mprotect() does not accept MAP_* flags.
-	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
-	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
-	 */
-	if (vm_flags & VM_MTE)
-		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
-
-	return __pgprot(prot);
-}
-#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
-
 static inline bool arch_validate_prot(unsigned long prot,
 	unsigned long addr __always_unused)
 {
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 77ada00280d9..78e9490f748d 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -55,3 +55,28 @@ static int __init adjust_protection_map(void)
 	return 0;
 }
 arch_initcall(adjust_protection_map);
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	pteval_t prot = pgprot_val(protection_map[vm_flags &
+				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+
+	if (vm_flags & VM_ARM64_BTI)
+		prot |= PTE_GP;
+
+	/*
+	 * There are two conditions required for returning a Normal Tagged
+	 * memory type: (1) the user requested it via PROT_MTE passed to
+	 * mmap() or mprotect() and (2) the corresponding vma supports MTE. We
+	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
+	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
+	 * mmap() call since mprotect() does not accept MAP_* flags.
+	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
+	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
+	 */
+	if (vm_flags & VM_MTE)
+		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
+
+	return __pgprot(prot);
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


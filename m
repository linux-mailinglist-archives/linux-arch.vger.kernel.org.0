Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1E4FCE24
	for <lists+linux-arch@lfdr.de>; Tue, 12 Apr 2022 06:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346701AbiDLElT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiDLElG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 00:41:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07EBE2A267;
        Mon, 11 Apr 2022 21:38:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45A116F8;
        Mon, 11 Apr 2022 21:38:44 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5B8F3F70D;
        Mon, 11 Apr 2022 21:38:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [PATCH V5 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date:   Tue, 12 Apr 2022 10:08:45 +0530
Message-Id: <20220412043848.80464-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412043848.80464-1-anshuman.khandual@arm.com>
References: <20220412043848.80464-1-anshuman.khandual@arm.com>
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
as sparc_vm_get_page_prot() and moves near vm_get_page_prot().

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Khalid Aziz <khalid.aziz@oracle.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sparc/Kconfig            |  1 +
 arch/sparc/include/asm/mman.h |  6 ------
 arch/sparc/mm/init_64.c       | 13 +++++++++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9200bc04701c..85b573643af6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -84,6 +84,7 @@ config SPARC64
 	select PERF_USE_VMALLOC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
+	select ARCH_HAS_VM_GET_PAGE_PROT
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index 274217e7ed70..af9c10c83dc5 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -46,12 +46,6 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
 	}
 }
 
-#define arch_vm_get_page_prot(vm_flags) sparc_vm_get_page_prot(vm_flags)
-static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
-{
-	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
-}
-
 #define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
 static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 {
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 8b1911591581..dcb17763c1f2 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -3184,3 +3184,16 @@ void copy_highpage(struct page *to, struct page *from)
 	}
 }
 EXPORT_SYMBOL(copy_highpage);
+
+static pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
+{
+	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
+}
+
+pgprot_t vm_get_page_prot(unsigned long vm_flags)
+{
+	return __pgprot(pgprot_val(protection_map[vm_flags &
+			(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
+			pgprot_val(sparc_vm_get_page_prot(vm_flags)));
+}
+EXPORT_SYMBOL(vm_get_page_prot);
-- 
2.25.1


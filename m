Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D905005D9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 08:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiDNGXb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 02:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiDNGX2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 02:23:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D81DD1EEF8;
        Wed, 13 Apr 2022 23:21:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91AE41424;
        Wed, 13 Apr 2022 23:21:03 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.37.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 863553F70D;
        Wed, 13 Apr 2022 23:20:57 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     christophe.leroy@csgroup.eu, catalin.marinas@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/7] mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
Date:   Thu, 14 Apr 2022 11:51:19 +0530
Message-Id: <20220414062125.609297-2-anshuman.khandual@arm.com>
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

Add a new config ARCH_HAS_VM_GET_PAGE_PROT, which when subscribed enables a
given platform to define its own vm_get_page_prot() but still utilizing the
generic protection_map[] array.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/Kconfig | 3 +++
 mm/mmap.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..b1f7624276f8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -765,6 +765,9 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 config ARCH_HAS_FILTER_PGPROT
 	bool
 
+config ARCH_HAS_VM_GET_PAGE_PROT
+	bool
+
 config ARCH_HAS_PTE_DEVMAP
 	bool
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..87cb2eaf7e1a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -106,6 +106,7 @@ pgprot_t protection_map[16] __ro_after_init = {
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
+#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
 {
@@ -122,6 +123,7 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
 	return arch_filter_pgprot(ret);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
+#endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
 
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
-- 
2.25.1


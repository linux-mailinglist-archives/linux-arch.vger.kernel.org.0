Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3437529ABE
	for <lists+linux-arch@lfdr.de>; Tue, 17 May 2022 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiEQH1h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 May 2022 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiEQH13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2022 03:27:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC3743EF4;
        Tue, 17 May 2022 00:27:28 -0700 (PDT)
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2SL90wTHzGpxl;
        Tue, 17 May 2022 15:24:33 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 15:27:26 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 15:27:25 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: [PATCH -next 2/2] arm64/mm: fix page table check compile error for CONFIG_PGTABLE_LEVELS=2
Date:   Tue, 17 May 2022 07:45:48 +0000
Message-ID: <20220517074548.2227779-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517074548.2227779-1-tongtiangen@huawei.com>
References: <20220517074548.2227779-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If CONFIG_PGTABLE_LEVELS=2 and CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y,
then we trigger a compile error:

  error: implicit declaration of function 'pte_user_accessible_page'

Move the definition of page table check helper out of branch
CONFIG_PGTABLE_LEVELS > 2

Fixes: daf214c14dbe ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/pgtable.h | 33 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4e61cde27f9f..979601528f1e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -667,22 +667,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
 #define pud_user(pud)		pte_user(pud_pte(pud))
 
-#ifdef CONFIG_PAGE_TABLE_CHECK
-static inline bool pte_user_accessible_page(pte_t pte)
-{
-	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
-}
-
-static inline bool pmd_user_accessible_page(pmd_t pmd)
-{
-	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
-}
-
-static inline bool pud_user_accessible_page(pud_t pud)
-{
-	return pud_present(pud) && pud_user(pud);
-}
-#endif
 
 static inline void set_pud(pud_t *pudp, pud_t pud)
 {
@@ -855,6 +839,23 @@ static inline int pgd_devmap(pgd_t pgd)
 }
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_CHECK
+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
+}
+
+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
+}
+
+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_present(pud) && pud_user(pud);
+}
+#endif
+
 /*
  * Atomic pte/pmd modifications.
  */
-- 
2.25.1


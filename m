Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5C3B4D5D
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFZH32 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5432 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhFZH3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBljC64ZZz74Ts;
        Sat, 26 Jun 2021 15:23:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/9] kallsyms: Remove arch specific text and data check
Date:   Sat, 26 Jun 2021 15:34:31 +0800
Message-ID: <20210626073439.150586-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After commit 4ba66a976072 ("arch: remove blackfin port"),
no need arch-specific text/data check.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/sections.h | 16 ----------------
 include/linux/kallsyms.h       |  3 +--
 kernel/locking/lockdep.c       |  3 ---
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d16302d3eb59..817309e289db 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -64,22 +64,6 @@ extern __visible const void __nosave_begin, __nosave_end;
 #define dereference_kernel_function_descriptor(p) ((void *)(p))
 #endif
 
-/* random extra sections (if any).  Override
- * in asm/sections.h */
-#ifndef arch_is_kernel_text
-static inline int arch_is_kernel_text(unsigned long addr)
-{
-	return 0;
-}
-#endif
-
-#ifndef arch_is_kernel_data
-static inline int arch_is_kernel_data(unsigned long addr)
-{
-	return 0;
-}
-#endif
-
 /*
  * Check if an address is part of freed initmem. This is needed on architectures
  * with virt == phys kernel mapping, for code that wants to check if an address
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 1a7968cf7679..d773732cc8eb 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -33,8 +33,7 @@ static inline int is_kernel_inittext(unsigned long addr)
 
 static inline int is_kernel_text(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) ||
-	    arch_is_kernel_text(addr))
+	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 922288b7c03d..8a9c6c9fd0a3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -803,9 +803,6 @@ static int static_obj(const void *obj)
 	if ((addr >= start) && (addr < end))
 		return 1;
 
-	if (arch_is_kernel_data(addr))
-		return 1;
-
 	/*
 	 * in-kernel percpu var?
 	 */
-- 
2.26.2


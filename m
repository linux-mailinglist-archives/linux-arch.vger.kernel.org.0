Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FAE41D40E
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 09:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbhI3HLQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 03:11:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27937 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348542AbhI3HLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 03:11:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKklQ2FYTzbn06;
        Thu, 30 Sep 2021 15:05:06 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:14 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:13 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <ryabinin.a.a@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <bpf@vger.kernel.org>,
        <linux-alpha@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 01/11] kallsyms: Remove arch specific text and data check
Date:   Thu, 30 Sep 2021 15:11:33 +0800
Message-ID: <20210930071143.63410-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210930071143.63410-1-wangkefeng.wang@huawei.com>
References: <20210930071143.63410-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index 6851c2313cad..2a241e3f063f 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -34,8 +34,7 @@ static inline int is_kernel_inittext(unsigned long addr)
 
 static inline int is_kernel_text(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) ||
-	    arch_is_kernel_text(addr))
+	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7096384dc60f..dcdbcee391cd 100644
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


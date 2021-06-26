Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E43B4D66
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhFZH3j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFZH3a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBljH4xk9z74Wk;
        Sat, 26 Jun 2021 15:23:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:00 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: [PATCH 6/9] sections: Add new is_kernel() and is_kernel_text()
Date:   Sat, 26 Jun 2021 15:34:36 +0800
Message-ID: <20210626073439.150586-7-wangkefeng.wang@huawei.com>
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

The new is_kernel() check the kernel address ranges, and the
new is_kernel_text() check the kernel text section ranges.

Then use them to make some code clear.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/sections.h | 27 +++++++++++++++++++++++++++
 include/linux/kallsyms.h       |  4 ++--
 kernel/extable.c               |  3 +--
 mm/kasan/report.c              |  2 +-
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 9d622416a59c..06066d89137d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -170,6 +170,20 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+/**
+ * is_kernel_text - checks if the pointer address is located in the
+ *                  .text section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .text, false otherwise.
+ */
+static inline bool is_kernel_text(unsigned long addr)
+{
+	return addr >= (unsigned long)_stext &&
+	       addr < (unsigned long)_etext;
+}
+
 /**
  * is_kernel_inittext - checks if the pointer address is located in the
  *                    .init.text section
@@ -184,4 +198,17 @@ static inline bool is_kernel_inittext(unsigned long addr)
 	       addr < (unsigned long)_einittext;
 }
 
+/**
+ * is_kernel - checks if the pointer address is located in the kernel range
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in kernel range, false otherwise.
+ */
+static inline bool is_kernel(unsigned long addr)
+{
+	return addr >= (unsigned long)_stext &&
+	       addr < (unsigned long)_end;
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 814e1cc8eabf..60460df66e83 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -25,14 +25,14 @@ struct module;
 
 static inline int is_kernel_text_or_gate_area(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
+	if (is_kernel_text(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
 
 static inline int is_kernel_or_gate_area(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
+	if (is_kernel(addr))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
diff --git a/kernel/extable.c b/kernel/extable.c
index 98ca627ac5ef..0ba383d850ff 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -64,8 +64,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
 
 int notrace core_kernel_text(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext &&
-	    addr < (unsigned long)_etext)
+	if (is_kernel_text(addr))
 		return 1;
 
 	if (system_state < SYSTEM_RUNNING &&
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8fff1825b22c..3971917c73c5 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -212,7 +212,7 @@ static void describe_object(struct kmem_cache *cache, void *object,
 
 static inline bool kernel_or_module_addr(const void *addr)
 {
-	if (addr >= (void *)_stext && addr < (void *)_end)
+	if (is_kernel((unsigned long)addr))
 		return true;
 	if (is_module_address((unsigned long)addr))
 		return true;
-- 
2.26.2


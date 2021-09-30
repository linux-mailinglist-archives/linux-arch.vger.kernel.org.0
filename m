Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B61F41D403
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348568AbhI3HLK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 03:11:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13007 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348549AbhI3HLJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 03:11:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKkpr2LXzzWXwS;
        Thu, 30 Sep 2021 15:08:04 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:16 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:15 +0800
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
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
Subject: [PATCH v4 04/11] sections: Move is_kernel_inittext() into sections.h
Date:   Thu, 30 Sep 2021 15:11:36 +0800
Message-ID: <20210930071143.63410-5-wangkefeng.wang@huawei.com>
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

The is_kernel_inittext() and init_kernel_text() are with same
functionality, let's just keep is_kernel_inittext() and move
it into sections.h, then update all the callers.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/x86/kernel/unwind_orc.c   |  2 +-
 include/asm-generic/sections.h | 14 ++++++++++++++
 include/linux/kallsyms.h       |  8 --------
 include/linux/kernel.h         |  1 -
 kernel/extable.c               | 12 ++----------
 5 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index a1202536fc57..d92ec2ced059 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -175,7 +175,7 @@ static struct orc_entry *orc_find(unsigned long ip)
 	}
 
 	/* vmlinux .init slow lookup: */
-	if (init_kernel_text(ip))
+	if (is_kernel_inittext(ip))
 		return __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
 				  __stop_orc_unwind_ip - __start_orc_unwind_ip, ip);
 
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 24780c0f40b1..811583ca8bd0 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -172,4 +172,18 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+/**
+ * is_kernel_inittext - checks if the pointer address is located in the
+ *                      .init.text section
+ *
+ * @addr: address to check
+ *
+ * Returns: true if the address is located in .init.text, false otherwise.
+ */
+static inline bool is_kernel_inittext(unsigned long addr)
+{
+	return addr >= (unsigned long)_sinittext &&
+	       addr < (unsigned long)_einittext;
+}
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index b016c62f30a6..8a9d329c927c 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -24,14 +24,6 @@
 struct cred;
 struct module;
 
-static inline int is_kernel_inittext(unsigned long addr)
-{
-	if (addr >= (unsigned long)_sinittext
-	    && addr < (unsigned long)_einittext)
-		return 1;
-	return 0;
-}
-
 static inline int is_kernel_text(unsigned long addr)
 {
 	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e5a9af8a4e20..445d0dceefb8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -229,7 +229,6 @@ extern bool parse_option_str(const char *str, const char *option);
 extern char *next_arg(char *args, char **param, char **val);
 
 extern int core_kernel_text(unsigned long addr);
-extern int init_kernel_text(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
diff --git a/kernel/extable.c b/kernel/extable.c
index da26203841d4..98ca627ac5ef 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -62,14 +62,6 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
 	return e;
 }
 
-int init_kernel_text(unsigned long addr)
-{
-	if (addr >= (unsigned long)_sinittext &&
-	    addr < (unsigned long)_einittext)
-		return 1;
-	return 0;
-}
-
 int notrace core_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext &&
@@ -77,7 +69,7 @@ int notrace core_kernel_text(unsigned long addr)
 		return 1;
 
 	if (system_state < SYSTEM_RUNNING &&
-	    init_kernel_text(addr))
+	    is_kernel_inittext(addr))
 		return 1;
 	return 0;
 }
@@ -94,7 +86,7 @@ int __kernel_text_address(unsigned long addr)
 	 * Since we are after the module-symbols check, there's
 	 * no danger of address overlap:
 	 */
-	if (init_kernel_text(addr))
+	if (is_kernel_inittext(addr))
 		return 1;
 	return 0;
 }
-- 
2.26.2


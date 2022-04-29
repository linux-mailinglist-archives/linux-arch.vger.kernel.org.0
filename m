Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560DD5145CC
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiD2Jsa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350258AbiD2Js3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 05:48:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D637167C6;
        Fri, 29 Apr 2022 02:45:11 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqSHc5151zfZtl;
        Fri, 29 Apr 2022 17:44:12 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:09 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 17:45:09 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>,
        <herbert@gondor.apana.org.au>, <mark.rutland@arm.com>,
        <davem@davemloft.net>, <ardb@kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <luc.vanoostenryck@gmail.com>,
        <chenzhongjin@huawei.com>
Subject: [RFC PATCH v4 01/37] tools: Add some generic functions and headers
Date:   Fri, 29 Apr 2022 17:43:19 +0800
Message-ID: <20220429094355.122389-2-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429094355.122389-1-chenzhongjin@huawei.com>
References: <20220429094355.122389-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

These will be needed to be able to use arm64 instruction decoder in
userland tools.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/include/asm-generic/bitops/__ffs.h | 11 +++++++
 tools/include/linux/kernel.h             | 21 +++++++++++++
 tools/include/linux/printk.h             | 40 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tools/include/linux/printk.h

diff --git a/tools/include/asm-generic/bitops/__ffs.h b/tools/include/asm-generic/bitops/__ffs.h
index 9d1310519497..963f8a22212f 100644
--- a/tools/include/asm-generic/bitops/__ffs.h
+++ b/tools/include/asm-generic/bitops/__ffs.h
@@ -42,4 +42,15 @@ static __always_inline unsigned long __ffs(unsigned long word)
 	return num;
 }
 
+static inline unsigned long __ffs64(u64 word)
+{
+#if BITS_PER_LONG == 32
+	if (((u32)word) == 0UL)
+		return __ffs((u32)(word >> 32)) + 32;
+#elif BITS_PER_LONG != 64
+#error BITS_PER_LONG not 32 or 64
+#endif
+	return __ffs((unsigned long)word);
+}
+
 #endif /* _TOOLS_LINUX_ASM_GENERIC_BITOPS___FFS_H_ */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 4b0673bf52c2..47f24f07e8f1 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -102,6 +102,27 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 #endif
 
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ *
+ * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
+ * the "right shift count >= width of type" warning when that quantity is
+ * 32-bits.
+ */
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((u32)(n))
+
+/* Inspired from ALIGN_*_KERNEL */
+#define __ALIGN_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+#define __ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a) - 1)
+#define ALIGN_DOWN(x, a)	__ALIGN((x) - ((a) - 1), (a))
+
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
diff --git a/tools/include/linux/printk.h b/tools/include/linux/printk.h
new file mode 100644
index 000000000000..515ebdc47e6e
--- /dev/null
+++ b/tools/include/linux/printk.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_KERNEL_PRINTK_H_
+#define _TOOLS_LINUX_KERNEL_PRINTK_H_
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define printk(fmt, ...) fprintf(stdout, fmt, ##__VA_ARGS__)
+#define pr_info printk
+#define pr_notice printk
+#define pr_cont printk
+
+#define pr_warn(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+#define pr_err pr_warn
+#define pr_alert pr_warn
+#define pr_emerg pr_warn
+#define pr_crit pr_warn
+
+/*
+ * Dummy printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define no_printk(fmt, ...)				\
+({							\
+	if (0)						\
+		printk(fmt, ##__VA_ARGS__);		\
+	0;						\
+})
+
+/* pr_devel() should produce zero code unless DEBUG is defined */
+#ifdef DEBUG
+#define pr_devel(fmt, ...) printk
+#else
+#define pr_devel(fmt, ...) no_printk
+#endif
+
+#define pr_debug pr_devel
+
+#endif /* _TOOLS_LINUX_KERNEL_PRINTK_H_ */
-- 
2.17.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADA1706FA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 19:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBZSFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 13:05:50 -0500
Received: from foss.arm.com ([217.140.110.172]:40146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgBZSFu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:05:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B84331B;
        Wed, 26 Feb 2020 10:05:49 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DE473F881;
        Wed, 26 Feb 2020 10:05:47 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 08/19] arm64: Tags-aware memcmp_pages() implementation
Date:   Wed, 26 Feb 2020 18:05:15 +0000
Message-Id: <20200226180526.3272848-9-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the Memory Tagging Extension is enabled, two pages are identical
only if both their data and tags are identical.

Make the generic memcmp_pages() a __weak function and add an
arm64-specific implementation which takes care of the tags comparison.

Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/mte.h | 11 +++++++++
 arch/arm64/lib/Makefile      |  2 ++
 arch/arm64/lib/mte.S         | 46 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile       |  1 +
 arch/arm64/mm/cmppages.c     | 26 ++++++++++++++++++++
 mm/util.c                    |  2 +-
 6 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/cmppages.c

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
new file mode 100644
index 000000000000..64e814273659
--- /dev/null
+++ b/arch/arm64/include/asm/mte.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MTE_H
+#define __ASM_MTE_H
+
+#ifndef __ASSEMBLY__
+
+/* Memory Tagging API */
+int mte_memcmp_pages(const void *page1_addr, const void *page2_addr);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_MTE_H  */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 2fc253466dbf..d31e1169d9b8 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -16,3 +16,5 @@ lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 obj-$(CONFIG_CRC32) += crc32.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+
+obj-$(CONFIG_ARM64_MTE) += mte.o
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
new file mode 100644
index 000000000000..d41955ab4134
--- /dev/null
+++ b/arch/arm64/lib/mte.S
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2019 ARM Ltd.
+ */
+#include <linux/linkage.h>
+
+#include <asm/assembler.h>
+
+/*
+ * Compare tags of two pages
+ *   x0 - page1 address
+ *   x1 - page2 address
+ * Returns:
+ *   w0 - negative, zero or positive value if the tag in the first page is
+ *	  less than, equal to or greater than the tag in the second page
+ */
+ENTRY(mte_memcmp_pages)
+	multitag_transfer_size x7, x5
+1:
+	ldgm	x2, [x0]
+	ldgm	x3, [x1]
+
+	eor	x4, x2, x3
+	cbnz	x4, 2f
+
+	add	x0, x0, x7
+	add	x1, x1, x7
+
+	tst	x0, #(PAGE_SIZE - 1)
+	b.ne	1b
+
+	mov	w0, #0
+	ret
+2:
+	rbit	x4, x4
+	clz	x4, x4			// count the least significant equal bits
+	and	x4, x4, #~3		// round down to a multiple of 4 (bits per tag)
+
+	lsr	x2, x2, x4		// remove equal tags
+	lsr	x3, x3, x4
+
+	lsl	w2, w2, #28		// compare the differing tags
+	sub	w0, w2, w3, lsl #28
+
+	ret
+ENDPROC(mte_memcmp_pages)
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index d91030f0ffee..e93d696295d0 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PTDUMP_CORE)	+= dump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
+obj-$(CONFIG_ARM64_MTE)		+= cmppages.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/cmppages.c b/arch/arm64/mm/cmppages.c
new file mode 100644
index 000000000000..943c1877e014
--- /dev/null
+++ b/arch/arm64/mm/cmppages.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 ARM Ltd.
+ */
+
+#include <linux/mm.h>
+#include <linux/string.h>
+
+#include <asm/cpufeature.h>
+#include <asm/mte.h>
+
+int memcmp_pages(struct page *page1, struct page *page2)
+{
+	char *addr1, *addr2;
+	int ret;
+
+	addr1 = page_address(page1);
+	addr2 = page_address(page2);
+
+	ret = memcmp(addr1, addr2, PAGE_SIZE);
+	/* if page content identical, check the tags */
+	if (ret == 0 && system_supports_mte())
+		ret = mte_memcmp_pages(addr1, addr2);
+
+	return ret;
+}
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..662fb3da6d01 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -899,7 +899,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	return res;
 }
 
-int memcmp_pages(struct page *page1, struct page *page2)
+int __weak memcmp_pages(struct page *page1, struct page *page2)
 {
 	char *addr1, *addr2;
 	int ret;

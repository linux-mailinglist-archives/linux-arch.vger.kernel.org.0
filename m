Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B534F64AB
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiDFQDL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiDFQCG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2022 12:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC1B34DD24;
        Wed,  6 Apr 2022 06:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0AE615F2;
        Wed,  6 Apr 2022 13:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B71BC385A1;
        Wed,  6 Apr 2022 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251956;
        bh=yVtK4OSU/dz7cCD7phTmXOaCwuF/h2svpJZzwvXXAsA=;
        h=From:To:Cc:Subject:Date:From;
        b=m2E73t23BrnyOD/+HPsx4+PRxqhU25KUf8RwocNfFy4KvnbUQtYBgALtv/829Y+Yj
         EdSgOtO/TWXv7i5tweZFPLGDroNAQ2bY1WhKvG6ulS0xD7TNOgDi8Fav8N8I9p00vE
         KvsEohRTPQqFs4z8wLlPGkELTD7+4w0aYM9ah4w6L4ZHhugxDP048LB6acYzE7dBHp
         zHCFoUGv4/qZ0fMNzhNkUj41DSkP+cOeDk7tDlZEkLlhvnmKr8dDhvC/s+7DAWePo5
         Z8lQ7Gp9rvnD0VnV8Ju0QBUnNgEU708dAWpHw91y0vUbZEw83dIl/NfQEJLpf45gdj
         +Z21D2+nf6wQQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] csky: optimize memcpy_{from,to}io() and memset_io()
Date:   Wed,  6 Apr 2022 21:32:22 +0800
Message-Id: <20220406133222.724347-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Optimize memcpy_{from,to}io() and memset_io() by transferring in
64 bit as much as possible with minimized barrier usage.  This
simplest optimization brings faster throughput compare to current
byte-by-byte read and write with barrier in the loop. Code's
skeleton is taken from the powerpc & arm64.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
Changes in V2:
 - Fixup compile error by Makefile missing io.o
---
 arch/csky/include/asm/io.h | 11 +++++
 arch/csky/kernel/Makefile  |  2 +-
 arch/csky/kernel/io.c      | 91 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index f82654053dc0..adb64e26194f 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -32,6 +32,17 @@
 #define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); mb(); })
 #endif
 
+/*
+ * String version of I/O memory access operations.
+ */
+extern void __memcpy_fromio(void *, const volatile void __iomem *, size_t);
+extern void __memcpy_toio(volatile void __iomem *, const void *, size_t);
+extern void __memset_io(volatile void __iomem *, int, size_t);
+
+#define memset_io(c,v,l)        __memset_io((c),(v),(l))
+#define memcpy_fromio(a,c,l)    __memcpy_fromio((a),(c),(l))
+#define memcpy_toio(c,a,l)      __memcpy_toio((c),(a),(l))
+
 /*
  * I/O memory mapping functions.
  */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 6c0f36010ed0..4eb41421ca5b 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -2,7 +2,7 @@
 extra-y := head.o vmlinux.lds
 
 obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
-obj-y += power.o syscall.o syscall_table.o setup.o
+obj-y += power.o syscall.o syscall_table.o setup.o io.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
 
diff --git a/arch/csky/kernel/io.c b/arch/csky/kernel/io.c
new file mode 100644
index 000000000000..5883f13fa2b1
--- /dev/null
+++ b/arch/csky/kernel/io.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+/*
+ * Copy data from IO memory space to "real" memory space.
+ */
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, 4)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 4) {
+		*(u32 *)to = __raw_readl(from);
+		from += 4;
+		to += 4;
+		count -= 4;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+/*
+ * Copy data from "real" memory space to IO memory space.
+ */
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, 4)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 4) {
+		__raw_writel(*(u32 *)from, to);
+		from += 4;
+		to += 4;
+		count -= 4;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+/*
+ * "memset" on IO memory space.
+ */
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	u32 qc = (u8)c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+
+	while (count && !IS_ALIGNED((unsigned long)dst, 4)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= 4) {
+		__raw_writel(qc, dst);
+		dst += 4;
+		count -= 4;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
-- 
2.25.1


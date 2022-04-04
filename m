Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1154F1781
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351755AbiDDOs5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378639AbiDDOsr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 10:48:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B442740907;
        Mon,  4 Apr 2022 07:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32424B8171B;
        Mon,  4 Apr 2022 14:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2E7C340EE;
        Mon,  4 Apr 2022 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649083485;
        bh=hfIqoM3h/gz+tByTCRoRc0EQZSOX5qfDE+fO89hWlj0=;
        h=From:To:Cc:Subject:Date:From;
        b=GcAaiI9iWaGMwggzARvbZP6s+jScCgB92HITxahAIxTos8ySrkjWS/7/FF8ZEgcsI
         iR1iTIb8FgwbkVquVEBOtQI7RnuJdMJaAAs2yW5z1XXNcZPBIe54tKTE51YhV+ry/U
         4nt4LiXVwXc5U+Nkj76JzQlY+Miq7LOtFet/isPZZD+ymi87TzMk0L+x5wPwzspAdR
         7+FT2JnNqfSQ6jse9ENuHWnJEft40JBlld49Oa54b8FAQ4z0mzISE0u1z0WUbVnJUR
         vnGs81zo/1e4dYke+kN6l3AtWJ6vn2Nqq7DswY/BATuMfM8AdO56sn2o3E8VcMNG2Z
         kt8P09vYiulWQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: optimize memcpy_{from,to}io() and memset_io()
Date:   Mon,  4 Apr 2022 22:44:27 +0800
Message-Id: <20220404144427.2793051-1-guoren@kernel.org>
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
---
 arch/csky/include/asm/io.h | 11 +++++
 arch/csky/kernel/io.c      | 91 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
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


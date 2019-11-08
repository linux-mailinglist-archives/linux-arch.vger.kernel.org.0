Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72783F3F26
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfKHFD0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34694 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfKHFD0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id e4so3315420pgs.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGtkTBZpxEydn7204V+K9Ob540QWyH8edeC1/SVqIqA=;
        b=OnypEktdHx3AdQPR/aQRy5WpM6z25JvuIKryqXtv12QKTznIXltXlHmGtdd3FHksOd
         7pxkfo+l816Ia5g8NTBls7FB2sa5/Woqyd5sVymjLmFf5KkqXT9k5utHnvWzbCT5mgbS
         VMwrHQVhCWc0KdqEtXJnl849vus7BmJqcoBsm/nRRGV77qI5FZ5Vg7d0+dBCyr/tAtYI
         rrXVzPuXO38rrFNimZ3YlZITmcQXvALjCkd4rhTd5auwnmTVXAqFfp1Z8ie5uJkpi5vw
         14sGc2460t1pxxm74WhMKfMYp1zj1EoC0/2JwTi1nNq4/aRbD+aTGzqUpU8ozn7c9dk1
         ByhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGtkTBZpxEydn7204V+K9Ob540QWyH8edeC1/SVqIqA=;
        b=rZL8QEQO5V1Z1E5c08pIjgqtHl3me/ntHMe7rBSWYV973tGiHb1Zp1E559bV7lm6hX
         M/xGTBLz3cZLbZTYMULSE9oql/6ZkPP1lPZBpBXnMGDbd3j+5SwVqSFClg3XRn2BvfX5
         ew30nQS9hhA8Y4UkSIBbbUDgY9U/FettYgXW1eseTJiNwHB9inV9v+b0aZM+2NIfhlKw
         4wxuJjrx+B1v3li6rRVV0CvuZpRptsF84lBIG+XdUEBjsI8goVm3dAT0rYFpWLkXnyu3
         gZy07Cy0bNvdG0LGsZMTH0wP56cptqh1oUXvUNrMYVgt18O0dmgoIEORSWCD0O4pn2oJ
         6mTg==
X-Gm-Message-State: APjAAAVQRVp35XtEeo9rASWk8l5+4tReZeCkrmioM7+mZLKaTL1zcyCV
        LiUdBZIVdIfcXga8qsoDY5A=
X-Google-Smtp-Source: APXvYqwQNuS0tBssSO6lhkP8SdQq6aBpm2DFZzEY1HUq+aGs2wdXWFTYIoh7yLwP1OTa76j2+7wW0w==
X-Received: by 2002:a63:5949:: with SMTP id j9mr9335097pgm.371.1573189404544;
        Thu, 07 Nov 2019 21:03:24 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id 26sm3559133pjg.21.2019.11.07.21.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:23 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id C0A6F201ACFCD7; Fri,  8 Nov 2019 14:03:21 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 10/37] lkl: memory mapped I/O support
Date:   Fri,  8 Nov 2019 14:02:25 +0900
Message-Id: <9790d0a835b5f29c02caaaa5b82e2a2bfba74a9a.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

All memory mapped I/O access is redirected to the host via the
iomem_access host operation. The host can setup the memory mapped I/O
region via the ioremap operation.

This allows the host to implement support for various devices, such as
block or network devices.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/io.h            | 104 ++++++++++++++++++++++++
 arch/um/lkl/include/uapi/asm/host_ops.h |  10 +++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/io.h

diff --git a/arch/um/lkl/include/asm/io.h b/arch/um/lkl/include/asm/io.h
new file mode 100644
index 000000000000..33d4e1a7feb2
--- /dev/null
+++ b/arch/um/lkl/include/asm/io.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_IO_H
+#define _ASM_LKL_IO_H
+
+#include <asm/bug.h>
+#include <asm/host_ops.h>
+
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	int ret;
+	u8 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	int ret;
+	u16 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	int ret;
+	u32 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+
+#ifdef CONFIG_64BIT
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	int ret;
+	u64 value;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 0);
+	WARN(ret, "error reading iomem %p", addr);
+
+	return value;
+}
+#endif /* CONFIG_64BIT */
+
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+
+#ifdef CONFIG_64BIT
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
+{
+	int ret;
+
+	ret = lkl_ops->iomem_access(addr, &value, sizeof(value), 1);
+	WARN(ret, "error writing iomem %p", addr);
+}
+#endif /* CONFIG_64BIT */
+
+#define ioremap ioremap
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	return (void __iomem *)lkl_ops->ioremap(offset, size);
+}
+
+#include <asm-generic/io.h>
+
+#endif /* _ASM_LKL_IO_H */
diff --git a/arch/um/lkl/include/uapi/asm/host_ops.h b/arch/um/lkl/include/uapi/asm/host_ops.h
index c9f77dd7fbe7..7c0c0967c44a 100644
--- a/arch/um/lkl/include/uapi/asm/host_ops.h
+++ b/arch/um/lkl/include/uapi/asm/host_ops.h
@@ -55,6 +55,12 @@ struct lkl_jmp_buf {
  * @timer_set_periodic - arm the timer to fire periodically, with a period of
  * delta ns.
  *
+ * @ioremap - searches for an I/O memory region identified by addr and size and
+ * returns a pointer to the start of the address range that can be used by
+ * iomem_access
+ * @iomem_access - reads or writes to and I/O memory region; addr must be in the
+ * range returned by ioremap
+ *
  * @gettid - returns the host thread id of the caller, which need not
  * be the same as the handle returned by thread_create
  *
@@ -101,6 +107,10 @@ struct lkl_host_operations {
 	int (*timer_set_oneshot)(void *timer, unsigned long delta);
 	void (*timer_free)(void *timer);
 
+	void *(*ioremap)(long addr, int size);
+	int (*iomem_access)(const volatile void *addr, void *val, int size,
+			    int write);
+
 	long (*gettid)(void);
 
 	void (*jmp_buf_set)(struct lkl_jmp_buf *jmpb, void (*f)(void));
-- 
2.20.1 (Apple Git-117)


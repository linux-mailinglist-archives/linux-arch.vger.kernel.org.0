Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8DF3F35
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbfKHFDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:03:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41769 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHFDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:03:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id h4so3274058pgv.8
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfNQn8OmpEQe7PuufbSc2R/Ylz+WhZJhzX5oX3JXDtI=;
        b=rjudR4ZBD9RMwoX12aFqlMNUqjA+EHD+rMAzBKB88iubl6GyKQXY/PV7MtKr7VO+Bs
         NqaPYjwLlfWJtTcjQo2+6RY7GGAncBGeNwzbtFeBafXHUXYrOuBo+X/URmUT3H3hxfQ/
         Ia+thrPKKCJ+up4KkdBYrMttTL2FbXaTcTxGeg/8GsH4DwkRELDZnHrktu+mLwzeO/BE
         Lhy1+7+hQ11r8KZQpP1HuYDlympDbzXH0+SXRQRF0fE6/E/3Fx9w+YkEKLhHxT1hunj3
         TJnkPvcrmJxoZg8XPGNISo33LdYE/oCgwLP6PGais1Yx59FYbEJcqrjLHR4OOtnSKK/9
         EBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfNQn8OmpEQe7PuufbSc2R/Ylz+WhZJhzX5oX3JXDtI=;
        b=mDu3rVFwv/ZScxydyEBz0q2hn4ulM3OIXr4APbjqZSPpAIW+IKR1/mlgKPcl8BX6Er
         183FP+qhZC5ukuRzPT8w7rsgIR5/vlGfWcZ+JGSP8VJ0q3LnlQCSUIn4BMeMkgzQFiE9
         /NuldZpSeuA2RZR+AdD/uMmBZuwrRAdDTqd0CZgqQSV3S3gFTyL6FhV6NVqJLV/RLUfK
         ZAP6uGWg7ZvP2RdYHw+oByOl/coc+NO9vUVJR0+dnQ0g+SfKOcpzC9ycDIHGEWq0/0nu
         oLqK/pfShGsgc8cyE1MMf8XVcTtIm2pOOZ42pVAkDxj8S8js1hsmGTHNUssXrtl3HkYI
         VQ8w==
X-Gm-Message-State: APjAAAXMhHhDsB532UmbOZdNOjrXR5Vuy74h+ihQxXgLZ1E/kn4K3IzU
        2DjmK4zYkkMRQsBkSxuG7Do=
X-Google-Smtp-Source: APXvYqx/+TPiGz53Nzo/oGZfAogy+jlBzwiBAjuCEKhSk9zEy4pE6GD46cCM7PcTTGNdqji4EQOPdQ==
X-Received: by 2002:a63:4721:: with SMTP id u33mr9531143pga.159.1573189423904;
        Thu, 07 Nov 2019 21:03:43 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id x125sm4815866pfb.93.2019.11.07.21.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:03:43 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0870B201ACFD67; Fri,  8 Nov 2019 14:03:42 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 16/37] lkl tools: host lib: memory mapped I/O helpers
Date:   Fri,  8 Nov 2019 14:02:31 +0900
Message-Id: <a28bfc994d7a836817f99540115392256635e64f.1573179553.git.thehajime@gmail.com>
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

This patch adds helpers for implementing the memory mapped I/O host
operations that can be used by code that implements host
devices. Generic host operations for lkl_ioremap and lkl_iomem_access
are provided that allows multiplexing multiple I/O memory mapped
regions.

The host device code can create a new memory mapped I/O region with
register_iomem(). Read and write access functions need to be provided
by the caller.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/lib/Build   |  1 +
 tools/lkl/lib/iomem.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 tools/lkl/lib/iomem.h | 15 ++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 tools/lkl/lib/iomem.c
 create mode 100644 tools/lkl/lib/iomem.h

diff --git a/tools/lkl/lib/Build b/tools/lkl/lib/Build
index 658bfa865b9c..8d01982638f8 100644
--- a/tools/lkl/lib/Build
+++ b/tools/lkl/lib/Build
@@ -1,5 +1,6 @@
 CFLAGS_config.o += -I$(srctree)/tools/perf/pmu-events
 
+liblkl-y += iomem.o
 liblkl-y += jmp_buf.o
 liblkl-y += utils.o
 liblkl-y += dbg.o
diff --git a/tools/lkl/lib/iomem.c b/tools/lkl/lib/iomem.c
new file mode 100644
index 000000000000..2301fe4e5ad5
--- /dev/null
+++ b/tools/lkl/lib/iomem.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <stdint.h>
+#include <lkl_host.h>
+
+#include "iomem.h"
+
+#define IOMEM_OFFSET_BITS		24
+#define MAX_IOMEM_REGIONS		256
+
+#define IOMEM_ADDR_TO_INDEX(addr) \
+	(((uintptr_t)addr) >> IOMEM_OFFSET_BITS)
+#define IOMEM_ADDR_TO_OFFSET(addr) \
+	(((uintptr_t)addr) & ((1 << IOMEM_OFFSET_BITS) - 1))
+#define IOMEM_INDEX_TO_ADDR(i) \
+	(void *)(uintptr_t)(i << IOMEM_OFFSET_BITS)
+
+static struct iomem_region {
+	void *data;
+	int size;
+	const struct lkl_iomem_ops *ops;
+} iomem_regions[MAX_IOMEM_REGIONS];
+
+void *register_iomem(void *data, int size, const struct lkl_iomem_ops *ops)
+{
+	int i;
+
+	if (size > (1 << IOMEM_OFFSET_BITS) - 1)
+		return NULL;
+
+	for (i = 1; i < MAX_IOMEM_REGIONS; i++)
+		if (!iomem_regions[i].ops)
+			break;
+
+	if (i >= MAX_IOMEM_REGIONS)
+		return NULL;
+
+	iomem_regions[i].data = data;
+	iomem_regions[i].size = size;
+	iomem_regions[i].ops = ops;
+	return IOMEM_INDEX_TO_ADDR(i);
+}
+
+void unregister_iomem(void *base)
+{
+	unsigned int index = IOMEM_ADDR_TO_INDEX(base);
+
+	if (index >= MAX_IOMEM_REGIONS) {
+		lkl_printf("%s: invalid iomem_addr %p\n", __func__, base);
+		return;
+	}
+
+	iomem_regions[index].size = 0;
+	iomem_regions[index].ops = NULL;
+}
+
+void *lkl_ioremap(long addr, int size)
+{
+	int index = IOMEM_ADDR_TO_INDEX(addr);
+	struct iomem_region *iomem = &iomem_regions[index];
+
+	if (index >= MAX_IOMEM_REGIONS)
+		return NULL;
+
+	if (iomem->ops && size <= iomem->size)
+		return IOMEM_INDEX_TO_ADDR(index);
+
+	return NULL;
+}
+
+int lkl_iomem_access(const volatile void *addr, void *res, int size, int write)
+{
+	int index = IOMEM_ADDR_TO_INDEX(addr);
+	struct iomem_region *iomem = &iomem_regions[index];
+	int offset = IOMEM_ADDR_TO_OFFSET(addr);
+	int ret;
+
+	if (index > MAX_IOMEM_REGIONS || !iomem_regions[index].ops ||
+	    offset + size > iomem_regions[index].size)
+		return -1;
+
+	if (write)
+		ret = iomem->ops->write(iomem->data, offset, res, size);
+	else
+		ret = iomem->ops->read(iomem->data, offset, res, size);
+
+	return ret;
+}
diff --git a/tools/lkl/lib/iomem.h b/tools/lkl/lib/iomem.h
new file mode 100644
index 000000000000..0ad80ccc2626
--- /dev/null
+++ b/tools/lkl/lib/iomem.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_IOMEM_H
+#define _LKL_LIB_IOMEM_H
+
+struct lkl_iomem_ops {
+	int (*read)(void *data, int offset, void *res, int size);
+	int (*write)(void *data, int offset, void *value, int size);
+};
+
+void *register_iomem(void *data, int size, const struct lkl_iomem_ops *ops);
+void unregister_iomem(void *iomem_base);
+void *lkl_ioremap(long addr, int size);
+int lkl_iomem_access(const volatile void *addr, void *res, int size, int write);
+
+#endif /* _LKL_LIB_IOMEM_H */
-- 
2.20.1 (Apple Git-117)


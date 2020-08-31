Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D174257F78
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 19:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgHaRR6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 13:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgHaRRq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 13:17:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E2C061573;
        Mon, 31 Aug 2020 10:17:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so4503081wrn.0;
        Mon, 31 Aug 2020 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gGZxgvlTARaKucMxqVABiCjM6gJ2kfiSzxtTcKqrJ4=;
        b=EuAtdL6mjxEzUPoywmYmcyiBSfVq3qUISoZV/BoWJeEfilqbBSrWwbERlTNgHDqkjY
         PVDgYn386QDlPb96mS5mXKmljlNswSIkGKvZkN1bhLjdaxdzmM8vU/905C/qEI6D5vsF
         GZqalnNgxl8pnDZoqT7+02sQpso+YjPCyHNAVQRBTpG7TNTesCOmvJAA1ARUs93VSpXY
         69wGtM/4P6KdkqHynidcAp5RK1gGcBQ48lHjnuJ/u//RmVY5YXsPyhaBNuWhIZFlY52/
         1IKKWo40wkvGkoltlRNMTU0bI300zV+UaiACofJ6v9PkJiIz0d26LsK+R9R9zAK4lfkh
         YtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gGZxgvlTARaKucMxqVABiCjM6gJ2kfiSzxtTcKqrJ4=;
        b=RxOQua9W6YUmjnjwusnq4aSxqTf2pmtxQ5eKHL5CiyKWkb9x5o6/IY0PDFJAJevtoq
         aIOx60iX9P37dHRtCbvU6TU5IGaDoLsPtnWQoPGkqWfUR7uyYEbOBGEsynvhtE3Dh3nz
         T42qalMaGJOgEddzigy/vxYZyXDVslajmWH2/GgwlWTCA1Oj9ZY86xaEsHe/PqrSKdvg
         UDwES7fUv15EMU/DuIPTJ07NgGm4s6Jwsq1XzsHt+VEUpPn6r7wLO9WMfuH+E56gtqj7
         X3CCZodE7VJQV//9ZiBetpF6w5504+qfBt2JOlRnzHRfDe66bVrQl1mLm1G6RXCo7vea
         jYZg==
X-Gm-Message-State: AOAM531k6axsPhROVcNRyOgam1kENBdf2nuWj/l6oMAYdmfz5l7GfxQd
        M5g01QEsOR7Y5W8UrXZsuQ4=
X-Google-Smtp-Source: ABdhPJwnozj4gSlVmyms9gfmOiQ/InAFzbmkpS9IESX4C/+nlkrrlGOOWXm4eXgWB06bN9NzhXytkQ==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr2420957wrw.378.1598894262881;
        Mon, 31 Aug 2020 10:17:42 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id w15sm840978wro.46.2020.08.31.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:17:41 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de,
        peterz@infradead.org
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, albert.linde@gmail.com,
        Albert van der Linde <alinde@google.com>
Subject: [PATCH v3 1/3] lib, include/linux: add usercopy failure capability
Date:   Mon, 31 Aug 2020 17:17:31 +0000
Message-Id: <20200831171733.955393-2-alinde@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200831171733.955393-1-alinde@google.com>
References: <20200831171733.955393-1-alinde@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

Add a failure injection capability to improve testing of fault-tolerance
in usages of user memory access functions.

Add CONFIG_FAULT_INJECTION_USERCOPY to enable faults in usercopy
functions. The should_fail_usercopy function is to be called by these
functions (copy_from_user, get_user, ...) in order to fail or not.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Albert van der Linde <alinde@google.com>
---
v2:
 - adressed comments from Dmitry Vyukov
 - removed failsize
 - changed should_fail function to return bool

v3:
 - no changes
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 .../fault-injection/fault-injection.rst       |  7 +++-
 include/linux/fault-inject-usercopy.h         | 22 +++++++++++
 lib/Kconfig.debug                             |  7 ++++
 lib/Makefile                                  |  1 +
 lib/fault-inject-usercopy.c                   | 39 +++++++++++++++++++
 6 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/fault-inject-usercopy.h
 create mode 100644 lib/fault-inject-usercopy.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..790e54988d4f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1332,6 +1332,7 @@
 			current integrity status.
 
 	failslab=
+	fail_usercopy=
 	fail_page_alloc=
 	fail_make_request=[KNL]
 			General fault injection mechanism.
diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index f850ad018b70..31ecfe44e5b4 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -16,6 +16,10 @@ Available fault injection capabilities
 
   injects page allocation failures. (alloc_pages(), get_free_pages(), ...)
 
+- fail_usercopy
+
+  injects failures in user memory access functions. (copy_from_user(), get_user(), ...)
+
 - fail_futex
 
   injects futex deadlock and uaddr fault errors.
@@ -177,6 +181,7 @@ use the boot option::
 
 	failslab=
 	fail_page_alloc=
+	fail_usercopy=
 	fail_make_request=
 	fail_futex=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
@@ -222,7 +227,7 @@ How to add new fault injection capability
 
 - debugfs entries
 
-  failslab, fail_page_alloc, and fail_make_request use this way.
+  failslab, fail_page_alloc, fail_usercopy, and fail_make_request use this way.
   Helper functions:
 
 	fault_create_debugfs_attr(name, parent, attr);
diff --git a/include/linux/fault-inject-usercopy.h b/include/linux/fault-inject-usercopy.h
new file mode 100644
index 000000000000..56c3a693fdd9
--- /dev/null
+++ b/include/linux/fault-inject-usercopy.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_FAULT_INJECT_USERCOPY_H__
+#define __LINUX_FAULT_INJECT_USERCOPY_H__
+
+/*
+ * This header provides a wrapper for injecting failures to user space memory
+ * access functions.
+ */
+
+#include <linux/types.h>
+
+#ifdef CONFIG_FAULT_INJECTION_USERCOPY
+
+bool should_fail_usercopy(void);
+
+#else
+
+static inline bool should_fail_usercopy(void) { return false; }
+
+#endif /* CONFIG_FAULT_INJECTION_USERCOPY */
+
+#endif /* __LINUX_FAULT_INJECT_USERCOPY_H__ */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..2fc5049fba4e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1770,6 +1770,13 @@ config FAIL_PAGE_ALLOC
 	help
 	  Provide fault-injection capability for alloc_pages().
 
+config FAULT_INJECTION_USERCOPY
+	bool "Fault injection capability for usercopy functions"
+	depends on FAULT_INJECTION
+	help
+	  Provides fault-injection capability to inject failures
+	  in usercopy functions (copy_from_user(), get_user(), ...).
+
 config FAIL_MAKE_REQUEST
 	bool "Fault-injection capability for disk IO"
 	depends on FAULT_INJECTION && BLOCK
diff --git a/lib/Makefile b/lib/Makefile
index a4a4c6864f51..18daad2bc606 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -207,6 +207,7 @@ obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
+obj-$(CONFIG_FAULT_INJECTION_USERCOPY) += fault-inject-usercopy.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_PM_NOTIFIER_ERROR_INJECT) += pm-notifier-error-inject.o
 obj-$(CONFIG_NETDEV_NOTIFIER_ERROR_INJECT) += netdev-notifier-error-inject.o
diff --git a/lib/fault-inject-usercopy.c b/lib/fault-inject-usercopy.c
new file mode 100644
index 000000000000..77558b6c29ca
--- /dev/null
+++ b/lib/fault-inject-usercopy.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/fault-inject.h>
+#include <linux/fault-inject-usercopy.h>
+
+static struct {
+	struct fault_attr attr;
+} fail_usercopy = {
+	.attr = FAULT_ATTR_INITIALIZER,
+};
+
+static int __init setup_fail_usercopy(char *str)
+{
+	return setup_fault_attr(&fail_usercopy.attr, str);
+}
+__setup("fail_usercopy=", setup_fail_usercopy);
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+static int __init fail_usercopy_debugfs(void)
+{
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_usercopy", NULL,
+					&fail_usercopy.attr);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	return 0;
+}
+
+late_initcall(fail_usercopy_debugfs);
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+bool should_fail_usercopy(void)
+{
+	return should_fail(&fail_usercopy.attr, 1);
+}
+EXPORT_SYMBOL_GPL(should_fail_usercopy);
-- 
2.28.0.402.g5ffc5be6b7-goog


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9B24D329
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHUKuz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgHUKuu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 06:50:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4DC061386;
        Fri, 21 Aug 2020 03:50:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so1491535wrs.11;
        Fri, 21 Aug 2020 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HKo3kC3FwOTF/iDBgJOeGe9NLgR36qLnZq3Gih6uHs=;
        b=N0+LSjwf8lb9wTmHgmNlKlNlycB3uWTE3JGPTm3uFDwsg2AYEGY5xXnFth0resju4G
         lcxWLjxMOMtkZpqUXjv/DjTusqD+HIdF4mlHr5JMIf1KdOdRjqd/igNXu3HEoe5luCKL
         XbOcw2OU0iRC3xazwukIdpsXjpVBPqTUnxYD05dnKGFOLc9YD6pmQzW4CPPcw8dGUyi1
         jCZ1ksNIMVKFGNdUTKfZPwQbybE3moFa0UjZvVnWYls15wqDMuCHb6udHzZ0p4GA+dPD
         OdwiXOfrBXYimU2yCld243vqzqXbTeDwX8i7LSp46LCMQup14gzxEkoiPR0MhRJhekkc
         ZF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HKo3kC3FwOTF/iDBgJOeGe9NLgR36qLnZq3Gih6uHs=;
        b=HoMCfDK4CglkGIqxFeJ8AAqKvW4b0ZK+3nGuO8SsBun04koSV6HbfIF/mAuQL8ucvA
         bXP/nhNBXIOd1VVzSClUGTLsglgIwsvLNlTVGh48H2tFe2zmL5zobqHmcWEbCnBjeEtx
         pmi51UAyXN9AUbCIpL1N6hr/gJndop7QGfyBX3Ip0+d+2oKFo1PLPzEGFCT7HkdazJBL
         0y4lO8t4RfZ69+sYxnDGKbS0MQWvnllFw35jTZj6yd3ixL2Bn47Psb1ObT+cXYAd9BCG
         YjvYufbiZ0VbGuJScfdPSo4j22DFE3VOXjpqKyzCFIWdEo0GVO6UNTCEO37oH7uFj+eh
         S2LQ==
X-Gm-Message-State: AOAM531Dg1/BRv2XHXthuGAt6aaatuNCiVAgdh1Czxhe+xSocngeTLRT
        LmQF5BLFLIs6z8uLNUSx0vo=
X-Google-Smtp-Source: ABdhPJwOs4GrZQtWHobvWCXZVcRnuPUXiqbeiXnBE8PUL5g/L5XzzxgU4Poez/Z6BV4qDHXxcY2jxg==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr2097413wrh.181.1598007047956;
        Fri, 21 Aug 2020 03:50:47 -0700 (PDT)
Received: from alinde.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 8sm3784911wrl.7.2020.08.21.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:50:46 -0700 (PDT)
From:   albert.linde@gmail.com
X-Google-Original-From: alinde@google.com
To:     akpm@linux-foundation.org, bp@alien8.de, mingo@redhat.com,
        corbet@lwn.net, tglx@linutronix.de, arnd@arndb.de
Cc:     akinobu.mita@gmail.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        glider@google.com, andreyknvl@google.com, dvyukov@google.com,
        elver@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Albert van der Linde <alinde@google.com>
Subject: [PATCH 1/3] lib, include/linux: add usercopy failure capability
Date:   Fri, 21 Aug 2020 10:49:23 +0000
Message-Id: <20200821104926.828511-2-alinde@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821104926.828511-1-alinde@google.com>
References: <20200821104926.828511-1-alinde@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Albert van der Linde <alinde@google.com>

Add a failure injection capability to improve testing of fault-tolerance
in usages of user memory access functions.

Adds CONFIG_FAULT_INJECTION_USERCOPY to enable faults in usercopy
functions. By default functions are to either fail with -EFAULT or
return that no bytes were copied. To use partial copies (e.g.,
copy_from_user permits partial failures) the number of bytes not to copy
must be written to /sys/kernel/debug/fail_usercopy/failsize.

Signed-off-by: Albert van der Linde <alinde@google.com>
---
 .../fault-injection/fault-injection.rst       | 64 ++++++++++++++++++
 include/linux/fault-inject-usercopy.h         | 20 ++++++
 lib/Kconfig.debug                             |  7 ++
 lib/Makefile                                  |  1 +
 lib/fault-inject-usercopy.c                   | 66 +++++++++++++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 include/linux/fault-inject-usercopy.h
 create mode 100644 lib/fault-inject-usercopy.c

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index f850ad018b70..cf52eabde332 100644
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
@@ -138,6 +142,12 @@ configuration of fault-injection capabilities.
 	specifies the minimum page allocation order to be injected
 	failures.
 
+- /sys/kernel/debug/fail_usercopy/failsize:
+
+	specifies the error code to return or amount of bytes not to copy.
+	If set to 0 then -EFAULT is returned instead. Positive values can be
+	used to inject partial copies (copy_from_user(), ...)
+
 - /sys/kernel/debug/fail_futex/ignore-private:
 
 	Format: { 'Y' | 'N' }
@@ -177,6 +187,7 @@ use the boot option::
 
 	failslab=
 	fail_page_alloc=
+	fail_usercopy=
 	fail_make_request=
 	fail_futex=
 	mmc_core.fail_request=<interval>,<probability>,<space>,<times>
@@ -383,6 +394,59 @@ allocation failure::
 		./tools/testing/fault-injection/failcmd.sh --times=100 \
 		-- make -C tools/testing/selftests/ run_tests
 
+
+Fail usercopy functions
+---------------------------------
+
+The following code fails the usercopy call in stat: copy_to_user is only
+partially completed.
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/sendfile.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+
+void inject_size()
+{
+	int fd = open("/sys/kernel/debug/fail_usercopy/failsize", O_RDWR);
+	char buf[16];
+	sprintf(buf, "%d", 60);
+	write(fd, buf, strlen(buf));
+}
+
+void inject_fault()
+{
+	int fd = open("/proc/thread-self/fail-nth", O_RDWR);
+	char buf[16];
+	sprintf(buf, "%d", 4);
+	write(fd, buf, strlen(buf));
+}
+
+int main()
+{
+	struct stat sb;
+	inject_size();
+	inject_fault();
+	stat(".", &sb);
+	printf("Stat error code:          %d\n", errno);
+	printf("Last status change:       %s", ctime(&sb.st_ctime));
+	printf("Last file access:         %s", ctime(&sb.st_atime));
+	printf("Last file modification:   %s", ctime(&sb.st_mtime));
+	return 0;
+}
+
+Example output:
+Stat error code:          14
+Last status change:       Thu Jan  1 00:00:00 1970
+Last file access:         Tue Aug 18 14:09:34 2020
+Last file modification:   Sun Dec 12 00:19:57 2989041
+
 Systematic faults using fail-nth
 ---------------------------------
 
diff --git a/include/linux/fault-inject-usercopy.h b/include/linux/fault-inject-usercopy.h
new file mode 100644
index 000000000000..95dad8ddb56f
--- /dev/null
+++ b/include/linux/fault-inject-usercopy.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This header provides a wrapper for partial failures on usercopy functions.
+ * For usage see Documentation/fault-injection/fault-injection.rst
+ */
+#ifndef __LINUX_FAULT_INJECT_USERCOPY_H__
+#define __LINUX_FAULT_INJECT_USERCOPY_H__
+
+#ifdef CONFIG_FAULT_INJECTION_USERCOPY
+
+long should_fail_usercopy(unsigned long n);
+
+#else
+
+static inline long should_fail_usercopy(unsigned long n) { return 0; }
+
+#endif /* CONFIG_FAULT_INJECTION_USERCOPY */
+
+#endif /* __LINUX_FAULT_INJECT_USERCOPY_H__ */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..bd0ec3ddb459 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1770,6 +1770,13 @@ config FAIL_PAGE_ALLOC
 	help
 	  Provide fault-injection capability for alloc_pages().
 
+config FAULT_INJECTION_USERCOPY
+	bool "Fault injection capability for usercopy functions"
+	depends on FAULT_INJECTION
+	help
+	  Provides fault-injection capability to inject failures and
+	  partial copies in usercopy functions.
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
index 000000000000..c151e0817ca7
--- /dev/null
+++ b/lib/fault-inject-usercopy.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/fault-inject.h>
+#include <linux/fault-inject-usercopy.h>
+#include <linux/random.h>
+
+static struct {
+	struct fault_attr attr;
+	u32 failsize;
+} fail_usercopy = {
+	.attr = FAULT_ATTR_INITIALIZER,
+	.failsize = 0,
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
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_usercopy", NULL,
+					&fail_usercopy.attr);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	debugfs_create_u32("failsize", mode, dir,
+			   &fail_usercopy.failsize);
+	return 0;
+}
+
+late_initcall(fail_usercopy_debugfs);
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+/**
+ * should_fail_usercopy() - Failure code or amount of bytes not to copy.
+ * @n: Size of the original copy call.
+ *
+ * The general idea is to have a method which returns the amount of bytes not
+ * to copy, a failure to return, or 0 if the calling function should progress
+ * without a failure. E.g., copy_{to,from}_user should NOT copy the amount of
+ * bytes returned by should_fail_usercopy, returning this value (in addition
+ * to any bytes that could actually not be copied) or a failure.
+ *
+ * Return: one of:
+ * negative, failure to return;
+ * 0, progress normally;
+ * a number in ]0, n], the number of bytes not to copy.
+ *
+ */
+long should_fail_usercopy(unsigned long n)
+{
+	if (should_fail(&fail_usercopy.attr, n)) {
+		if (fail_usercopy.failsize > 0)
+			return fail_usercopy.failsize % (n + 1);
+		return -EFAULT;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(should_fail_usercopy);
-- 
2.28.0.297.g1956fa8f8d-goog


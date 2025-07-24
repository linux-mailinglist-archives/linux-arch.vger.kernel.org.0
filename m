Return-Path: <linux-arch+bounces-12907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1BBB10C4D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E13BAED8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B82DFA4D;
	Thu, 24 Jul 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbnWXcrm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F742DE6E9
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365385; cv=none; b=R26HLgUqkW8xkdYwDNRP4w1paz12+gNyl/e2iItBVGVmvA0tt9QAZXFR4QJtEV+k9UiPVEm+rmME0CKgOViV8MSyUoRB54RQAZJju5JcI9G/rSuFbgF8NvIomc0twDZpsYuKQIadikXdTTlyi4ERKMzlV3iZ6m3tGYrzv/y/V/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365385; c=relaxed/simple;
	bh=pR8R1VGCZlGNtznMO1/mkl55J+MjIdrJJJqQz17xvb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpjDTVBI6enQYjG7MAC42/zhobRl/NyK7ZREr27UQAkv8ke9Un2b4C9mSb5HUK4eilDnkP9wvJHiuUCxQQbQtd5DLtKgO7gm/SpEWEZ+iqZDmqQB5W7Ybb8ChNeqmh4aBoyzD4LXH/PodfjZAQuBSaklxgKEo3mrMMcS4Qpz9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbnWXcrm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b77377858bso230707f8f.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365381; x=1753970181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN2zEFDyKGDBFhODZpN5vP0Lq5DSvoJDRdz0YaUUvGk=;
        b=AbnWXcrmkrGSJqGTnB8bNlVUsCpEuhREjWU5eIx5jI7WqwLiIBWWA8BZznvQ8Fg3CI
         pMKR42Zd7zindJ3bgpxZEux7cx6C1TEbAx26vMFWTfP4bYCu43Xh4deh/WTJIW7KpcXA
         8BWkXZ54F4uqfKjwiNVKYNMFGxCcFH0+3tO86D8ONQrwM9kZgN8bYZWYAjm/Z5HeDg+T
         83IS/mOP0/khcLFylAOUxldt6mRS73O1WIdpEzYuQPazjccG+XZjuvsrN4tocDWLrkJR
         D8/wIJNF6Eym+tJH7N2/b3UyE73AZy6mKKan9VvaDOYeEY61JxyDd+2hBKsXY2T3ZymW
         HArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365381; x=1753970181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN2zEFDyKGDBFhODZpN5vP0Lq5DSvoJDRdz0YaUUvGk=;
        b=ab/Z2aMopYJnZ77bvxbG9VskJIZqwx3Wd2jWzCtBYN5wVOGVxRQRxHMuXD+w7JS3SX
         El1UnN4y06WulrguZDvWtv1iZe+Kq8V1xx704Swc5pbBZYfVWZyzp/WL5/Gd3SvAnoWw
         bxnwhXJ2qniodoxz1rsxQK0r2dy1T6fJVyiihrGrV+NNrQGG2Mvfk4E+JZKMhnZjAEYb
         4V52+7u2ZuVMy0QDxBiBdUFtPC7k9xYrMUoE+d2U+5lMDi3a1ei4/jR1NGm7LWxmk+IM
         wYuXSINmFc2K7TfDNz+FKkurjIHXQYasqE1FJjzQUFi0arqVjoWrhRg8lJcrjDIGxc4j
         PD5A==
X-Forwarded-Encrypted: i=1; AJvYcCXOn0F/vjAyPnLbAps0VohKWHENQwG5zymDR3scz48nV6TwgwqavY4BS7mnAXo8V2LLCBsIOhz+JdXd@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaXIqk26aij+iJCdFB1gFlRMy1gzLJ4k5wyWti3vX9rO6hHBh
	QgEQKW/e/1JxUB4JASkwNYYYfizplAHRNRecyOKTnAXqWth+OwYhvUuluhOzjipWDGA=
X-Gm-Gg: ASbGncvaMKUNOiMiA6WA6JvRySHi+Rda8XskVP8UzUKUAVJZvqEqlbWH7swEYnV2I2n
	1f0E7qD2aCcKnqSMj3kCBvGuTjitDRa/dPBlw4rqn1QlNjvIJVYU9HSXVG6WjjorxJcswejyvKx
	aGT/XXhgkIaTQMZnaA6jPrCvSpJrNVqsPR0pPb9ycSQBH+0m3Ujyc3SEJZw42kCEfm27W7avFnN
	AB9nb2/Zy6IpJ2npoHLssyr64UOlTeFfOROzRY4Mtxhxj3m6dgT+VrVCg+V+5I3G4NvRF9pWcLS
	+fbmyO4gTBeTRHGRaZTczMjmCzeKQyA3+CwQtt7uccadicZ20b56VOP6gUlJjXA9jQ7dIyqjDod
	3D22u81tq+3oGiGG4xhxL6hwYzv/UzoWHXKohiHLEKlaMtw2zO7/XVQzI2o9SyUHXb0s5WrcdzI
	qxGeQmUyTvJZFR+Fbyf3eT7xw=
X-Google-Smtp-Source: AGHT+IHTmHRuZDTBifWGKFIc3eVCp5M+8i6pzB5UkemP/rWgYq+QJTPTzxAD1akVwZJswOYtPp8y1A==
X-Received: by 2002:a05:6000:144c:b0:3b5:dc2a:ee74 with SMTP id ffacd0b85a97d-3b768eb427amr6529079f8f.24.1753365381251;
        Thu, 24 Jul 2025 06:56:21 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:20 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 01/29] kmemdump: introduce kmemdump
Date: Thu, 24 Jul 2025 16:54:44 +0300
Message-ID: <20250724135512.518487-2-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kmemdump mechanism allows any driver to mark a specific memory area
for later dumping purpose, depending on the functionality
of the attached backend. The backend would interface any hardware
mechanism that will allow dumping to complete regardless of the
state of the kernel (running, frozen, crashed, or any particular
state).

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 MAINTAINERS                       |   6 +
 drivers/Kconfig                   |   4 +
 drivers/Makefile                  |   2 +
 drivers/debug/Kconfig             |  16 +++
 drivers/debug/Makefile            |   3 +
 drivers/debug/kmemdump.c          | 214 ++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  13 ++
 include/linux/kmemdump.h          | 135 +++++++++++++++++++
 8 files changed, 393 insertions(+)
 create mode 100644 drivers/debug/Kconfig
 create mode 100644 drivers/debug/Makefile
 create mode 100644 drivers/debug/kmemdump.c
 create mode 100644 include/linux/kmemdump.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 70d1a0a62a8e..7e8da575025c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13617,6 +13617,12 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/accel/kionix-kx022a*
 
+KMEMDUMP
+M:	Eugen Hristev <eugen.hristev@linaro.org>
+S:	Maintained
+F:	drivers/debug/kmemdump.c
+F:	include/linux/kmemdump.h
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
diff --git a/drivers/Kconfig b/drivers/Kconfig
index e0777f5ed543..412ef182d5c2 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -245,4 +245,8 @@ source "drivers/hte/Kconfig"
 
 source "drivers/cdx/Kconfig"
 
+source "drivers/dpll/Kconfig"
+
+source "drivers/debug/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index b5749cf67044..e4cc23f4aba2 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -196,3 +196,5 @@ obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
 
 obj-$(CONFIG_S390)		+= s390/
+
+obj-y				+= debug/
diff --git a/drivers/debug/Kconfig b/drivers/debug/Kconfig
new file mode 100644
index 000000000000..b86585c5d621
--- /dev/null
+++ b/drivers/debug/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Generic Debug Options"
+
+config KMEMDUMP
+	bool "Allow the kernel to register memory regions for dumping purpose"
+	help
+	  Kmemdump mechanism allows any driver to register a specific memory
+	  area for later dumping purpose, depending on the functionality
+	  of the attached backend. The backend would interface any hardware
+	  mechanism that will allow dumping to happen regardless of the
+	  state of the kernel (running, frozen, crashed, or any particular
+	  state).
+
+	  Note that modules using this feature must be rebuilt if option
+	  changes.
+endmenu
diff --git a/drivers/debug/Makefile b/drivers/debug/Makefile
new file mode 100644
index 000000000000..8ed6ec2d8a0d
--- /dev/null
+++ b/drivers/debug/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_KMEMDUMP) += kmemdump.o
diff --git a/drivers/debug/kmemdump.c b/drivers/debug/kmemdump.c
new file mode 100644
index 000000000000..b6d418aafbef
--- /dev/null
+++ b/drivers/debug/kmemdump.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/kmemdump.h>
+
+#define MAX_ZONES 201
+
+static int default_register_region(const struct kmemdump_backend *be,
+				   enum kmemdump_uid id, void *area, size_t sz)
+{
+	return 0;
+}
+
+static int default_unregister_region(const struct kmemdump_backend *be,
+				     enum kmemdump_uid id)
+{
+	return 0;
+}
+
+static const struct kmemdump_backend kmemdump_default_backend = {
+	.name = "default",
+	.register_region = default_register_region,
+	.unregister_region = default_unregister_region,
+};
+
+static const struct kmemdump_backend *backend = &kmemdump_default_backend;
+static DEFINE_MUTEX(kmemdump_lock);
+static struct kmemdump_zone kmemdump_zones[MAX_ZONES];
+
+static int __init init_kmemdump(void)
+{
+	const struct kmemdump_zone *e;
+
+	/* Walk the kmemdump section for static variables and register them */
+	for_each_kmemdump_entry(e)
+		kmemdump_register_id(e->id, e->zone, e->size);
+
+	return 0;
+}
+late_initcall(init_kmemdump);
+
+/**
+ * kmemdump_register_id() - Register region into kmemdump with given ID.
+ * @req_id: Requested unique kmemdump_uid that identifies the region
+ *	This can be KMEMDUMP_ID_NO_ID, in which case the function will
+ *	find an unused ID and return it.
+ * @zone: pointer to the zone of memory
+ * @size: region size
+ *
+ * Return: On success, it returns the unique id for the region.
+ *	 On failure, it returns negative error value.
+ */
+int kmemdump_register_id(enum kmemdump_uid req_id, void *zone, size_t size)
+{
+	struct kmemdump_zone *z;
+	enum kmemdump_uid uid = req_id;
+	int ret;
+
+	if (uid < KMEMDUMP_ID_START)
+		return -EINVAL;
+
+	if (uid >= MAX_ZONES)
+		return -ENOSPC;
+
+	mutex_lock(&kmemdump_lock);
+
+	if (uid == KMEMDUMP_ID_NO_ID)
+		while (uid < MAX_ZONES) {
+			if (!kmemdump_zones[uid].id)
+				break;
+			uid++;
+		}
+
+	if (uid == MAX_ZONES) {
+		mutex_unlock(&kmemdump_lock);
+		return -ENOSPC;
+	}
+
+	z = &kmemdump_zones[uid];
+
+	if (z->id) {
+		mutex_unlock(&kmemdump_lock);
+		return -EALREADY;
+	}
+
+	ret = backend->register_region(backend, uid, zone, size);
+	if (ret) {
+		mutex_unlock(&kmemdump_lock);
+		return ret;
+	}
+
+	z->zone = zone;
+	z->size = size;
+	z->id = uid;
+
+	mutex_unlock(&kmemdump_lock);
+
+	return uid;
+}
+EXPORT_SYMBOL_GPL(kmemdump_register_id);
+
+/**
+ * kmemdump_unregister() - Unregister region from kmemdump.
+ * @id: unique id that was returned when this region was successfully
+ *	registered initially.
+ *
+ * Return: None
+ */
+void kmemdump_unregister(enum kmemdump_uid id)
+{
+	struct kmemdump_zone *z = NULL;
+
+	mutex_lock(&kmemdump_lock);
+
+	z = &kmemdump_zones[id];
+	if (!z->id) {
+		mutex_unlock(&kmemdump_lock);
+		return;
+	}
+
+	backend->unregister_region(backend, z->id);
+
+	memset(z, 0, sizeof(*z));
+
+	mutex_unlock(&kmemdump_lock);
+}
+EXPORT_SYMBOL_GPL(kmemdump_unregister);
+
+/**
+ * kmemdump_register_backend() - Register a backend into kmemdump.
+ * @be: Pointer to a driver allocated backend. This backend must have
+ *	two callbacks for registering and deregistering a zone from the
+ *	backend.
+ *
+ * Only one backend is supported at a time.
+ *
+ * Return: On success, it returns 0, negative error value otherwise.
+ */
+int kmemdump_register_backend(const struct kmemdump_backend *be)
+{
+	enum kmemdump_uid uid;
+	int ret;
+
+	if (!be || !be->register_region || !be->unregister_region)
+		return -EINVAL;
+
+	mutex_lock(&kmemdump_lock);
+
+	/* Try to call the old backend for all existing regions */
+	for (uid = KMEMDUMP_ID_START; uid < MAX_ZONES; uid++)
+		if (kmemdump_zones[uid].id)
+			backend->unregister_region(backend,
+						   kmemdump_zones[uid].id);
+
+	backend = be;
+	pr_debug("kmemdump backend %s registered successfully.\n",
+		 backend->name);
+
+	/* Call the new backend for all existing regions */
+	for (uid = KMEMDUMP_ID_START; uid < MAX_ZONES; uid++) {
+		if (!kmemdump_zones[uid].id)
+			continue;
+		ret = backend->register_region(backend,
+					       kmemdump_zones[uid].id,
+					       kmemdump_zones[uid].zone,
+					       kmemdump_zones[uid].size);
+		if (ret)
+			pr_debug("register region failed with %d\n", ret);
+	}
+
+	mutex_unlock(&kmemdump_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kmemdump_register_backend);
+
+/**
+ * kmemdump_unregister_backend() - Unregister the backend from kmemdump.
+ * @be: Pointer to a driver allocated backend. This backend must match
+ *	the initially registered backend.
+ *
+ * Only one backend is supported at a time.
+ * Before deregistering, this will call the backend to unregister all the
+ * previously registered zones.
+ *
+ * Return: None
+ */
+void kmemdump_unregister_backend(const struct kmemdump_backend *be)
+{
+	enum kmemdump_uid uid;
+
+	mutex_lock(&kmemdump_lock);
+
+	if (backend != be) {
+		mutex_unlock(&kmemdump_lock);
+		return;
+	}
+
+	/* Try to call the old backend for all existing regions */
+	for (uid = KMEMDUMP_ID_START; uid < MAX_ZONES; uid++)
+		if (kmemdump_zones[uid].id)
+			backend->unregister_region(backend,
+						   kmemdump_zones[uid].id);
+
+	pr_debug("kmemdump backend %s removed successfully.\n", be->name);
+
+	backend = &kmemdump_default_backend;
+
+	mutex_unlock(&kmemdump_lock);
+}
+EXPORT_SYMBOL_GPL(kmemdump_unregister_backend);
+
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fa5f19b8d53a..433719442a5e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -488,6 +488,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	FW_LOADER_BUILT_IN_DATA						\
 	TRACEDATA							\
 									\
+	KMEMDUMP_TABLE							\
+									\
 	PRINTK_INDEX							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
@@ -891,6 +893,17 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TRACEDATA
 #endif
 
+#ifdef CONFIG_KMEMDUMP
+#define KMEMDUMP_TABLE							\
+	. = ALIGN(8);							\
+	.kmemdump : AT(ADDR(.kmemdump) - LOAD_OFFSET) {			\
+		BOUNDED_SECTION_POST_LABEL(.kmemdump, __kmemdump_table,	\
+					   , _end)			\
+	}
+#else
+#define KMEMDUMP_TABLE
+#endif
+
 #ifdef CONFIG_PRINTK_INDEX
 #define PRINTK_INDEX							\
 	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
diff --git a/include/linux/kmemdump.h b/include/linux/kmemdump.h
new file mode 100644
index 000000000000..c3690423a347
--- /dev/null
+++ b/include/linux/kmemdump.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _KMEMDUMP_H
+#define _KMEMDUMP_H
+
+enum kmemdump_uid {
+	KMEMDUMP_ID_START = 0,
+	KMEMDUMP_ID_USER_START,
+	KMEMDUMP_ID_USER_END,
+	KMEMDUMP_ID_NO_ID,
+};
+
+#ifdef CONFIG_KMEMDUMP
+/**
+ * struct kmemdump_zone - region mark zone information
+ * @id: unique id for this zone
+ * @zone: pointer to the memory area for this zone
+ * @size: size of the memory area of this zone
+ */
+struct kmemdump_zone {
+	enum kmemdump_uid	id;
+	void			*zone;
+	size_t			size;
+};
+
+/* kmemdump section table markers*/
+extern const struct kmemdump_zone __kmemdump_table[];
+extern const struct kmemdump_zone __kmemdump_table_end[];
+
+/* Annotate a variable into the given kmemdump UID */
+#define KMEMDUMP_VAR_ID(idx, sym, sz)						\
+	static const struct kmemdump_zone __UNIQUE_ID(__kmemdump_entry_##sym)	\
+	__used __section(".kmemdump") = { .id = idx,				\
+					  .zone = (void *)&(sym),		\
+					  .size = (sz),				\
+					}
+
+/* Iterate through kmemdump section entries */
+#define for_each_kmemdump_entry(__entry)		\
+	for (__entry = __kmemdump_table;		\
+	     __entry < __kmemdump_table_end;		\
+	     __entry++)
+
+#else
+#define KMEMDUMP_VAR_ID(...)
+#endif
+/*
+ * Wrapper over an existing fn allocator
+ * It will :
+ *	- unregister the memory already registered into kmemdump at the given UID
+ *	- register the memory into kmemdump at the given UID
+ *	- take an argument for the ID and the wanted size
+ */
+#define kmemdump_alloc_id_size_replace(id, sz, fn, ...)			\
+	({								\
+		void *__p = fn(__VA_ARGS__);				\
+									\
+		if (__p) {						\
+			kmemdump_unregister(id);			\
+			kmemdump_register_id(id, __p, sz);		\
+		}							\
+		__p;							\
+	})
+/*
+ * Wrapper over an existing fn allocator
+ * It will :
+ *	- fail if the given UID is already registered
+ *	- register the memory into kmemdump at the given UID
+ *	- take an argument for the ID and the wanted size
+ */
+
+#define kmemdump_alloc_id_size(id, sz, fn, ...)				\
+	({								\
+	void *__p = fn(__VA_ARGS__);				\
+									\
+		if (__p)						\
+			kmemdump_register_id(id, __p, sz);		\
+		__p;							\
+	})
+
+#define kmemdump_alloc_size(...)					\
+	kmemdump_alloc_id_size(KMEMDUMP_ID_NO_ID, __VA_ARGS__)
+
+#define kmemdump_phys_alloc_id_size(id, sz, fn, ...)			\
+	({								\
+		phys_addr_t __p = fn(__VA_ARGS__);			\
+									\
+		if (__p)						\
+			kmemdump_register_id(id, __va(__p), sz);	\
+		__p;							\
+	})
+
+#define kmemdump_phys_alloc_size(...)					\
+	kmemdump_phys_alloc_id_size(KMEMDUMP_ID_NO_ID, __VA_ARGS__)
+
+#define kmemdump_free_id(id, fn, ...)					\
+	({								\
+		kmemdump_unregister(id);				\
+		fn(__VA_ARGS__);					\
+	})
+
+#ifdef CONFIG_KMEMDUMP
+
+#define KMEMDUMP_BACKEND_MAX_NAME 128
+/**
+ * struct kmemdump_backend - region mark backend information
+ * @name: the name of the backend
+ * @register_region: callback to register region in the backend
+ * @unregister_region: callback to unregister region in the backend
+ */
+struct kmemdump_backend {
+	char name[KMEMDUMP_BACKEND_MAX_NAME];
+	int (*register_region)(const struct kmemdump_backend *be,
+			       enum kmemdump_uid uid, void *vaddr, size_t size);
+	int (*unregister_region)(const struct kmemdump_backend *be,
+				 enum kmemdump_uid uid);
+};
+
+int kmemdump_register_backend(const struct kmemdump_backend *backend);
+void kmemdump_unregister_backend(const struct kmemdump_backend *backend);
+
+int kmemdump_register_id(enum kmemdump_uid id, void *zone, size_t size);
+void kmemdump_unregister(enum kmemdump_uid id);
+#else
+static inline int kmemdump_register_id(enum kmemdump_uid uid, void *area,
+				       size_t size)
+{
+	return 0;
+}
+
+static inline void kmemdump_unregister(enum kmemdump_uid id)
+{
+}
+#endif
+
+#endif
-- 
2.43.0



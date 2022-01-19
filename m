Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49F4936A9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jan 2022 09:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352674AbiASI6B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jan 2022 03:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352608AbiASI57 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2022 03:57:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4EC06161C
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 00:57:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso12705123wmj.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2022 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnhZj/9Mg3uDWbdA8BAR3iGD0nHR50Pcm6mLxqECe0c=;
        b=PNm0VpWPk0+lPEuZ8kBffhhv/vJW300oM/nIRWMgql4Z6Exa1C22Ys4z/5arCk8gIO
         APJu8yTgdDJYLaHxb6JSPUCnHY31+pmxrs4KiOr8xOeg6hog03UgQZx5gQurjsE5LPqZ
         s1Q1BFSwNuFRum/mWzAcTz+nqT8GFH8n8sdau1n4kUlIVX7VmR21OO0/czCpDIDlD12T
         paH+eJbn4y2m+yTbQlGSKF+v7docQADTVz5jdzvYpKNbPK1dv45cUG8CsBRHMxnEo/IU
         Pivccxd20zyRNpSm0IvCWW9+2+0urxAR3BfnuG5BLPEdVNsr5WNE6SScNDENv6wWM0ly
         7UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnhZj/9Mg3uDWbdA8BAR3iGD0nHR50Pcm6mLxqECe0c=;
        b=4iOfDDu76pMqVswH2Tpig1p1e3kgDwAclRnZ1Bn40e+DCKMGEz9MXmu1qGwxyKi+MH
         8X7QdeC+jzNgEBk/99ky6wA2ZzKP4ap/BdqJ5ZmwUKzB9YWkPTdldqznDfvrN4hY8i4F
         vjwQs35TZQEVL91FXB/9UTB8Y/NhoFiH9AgA6hbz4aDbxhTK1UFYiN0J/ymnw0rbSzbz
         NgIJOu/Z+9nZT9OP7/MMfFOy/KvOjyX3hCjN9N+HaQH2DX3qdlb4OnPHDyX6bTNSvF/E
         /UoyDTjGnp4qsZ+SrV1otSPXfsjAq7UQZ6DeuRPwxHcyPdZiWgBs4zKhjM1jev2adt91
         ncuw==
X-Gm-Message-State: AOAM533x/oHl9pj8YxzaiKrsPbvfHH96hgPEfK6fh3T7NSHFNF0BG5OZ
        tRl5PZA9GxkmKfElvD2tDjemYA==
X-Google-Smtp-Source: ABdhPJwE4E4mJ7k1qL2f+MAoscgTtq2+OIpP/e10mhyF6kajkU2juT1b80rKoVl+TopMxxKutY+1ZQ==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr28833643wrw.624.1642582677766;
        Wed, 19 Jan 2022 00:57:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ef34:de48:dc4e:ad87])
        by smtp.gmail.com with ESMTPSA id 10sm4491454wmc.44.2022.01.19.00.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:57:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v6 1/5] powercap/drivers/dtpm: Convert the init table section to a simple array
Date:   Wed, 19 Jan 2022 09:57:15 +0100
Message-Id: <20220119085719.1357874-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The init table section is freed after the system booted. However the
next changes will make per module the DTPM description, so the table
won't be accessible when the module is loaded.

In order to fix that, we should move the table to the data section
where there are very few entries and that makes strange to add it
there.

The main goal of the table was to keep self-encapsulated code and we
can keep it almost as it by using an array instead.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c           |  2 ++
 drivers/powercap/dtpm_cpu.c       |  5 ++++-
 drivers/powercap/dtpm_subsys.h    | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 -----------
 include/linux/dtpm.h              | 24 +++---------------------
 5 files changed, 27 insertions(+), 33 deletions(-)
 create mode 100644 drivers/powercap/dtpm_subsys.h

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 8cb45f2d3d78..0e5c93443c70 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 
+#include "dtpm_subsys.h"
+
 #define DTPM_POWER_LIMIT_FLAG 0
 
 static const char *constraint_name[] = {
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..5763e0ce2af5 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -269,4 +269,7 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
+struct dtpm_subsys_ops dtpm_cpu_ops = {
+	.name = KBUILD_MODNAME,
+	.init = dtpm_cpu_init,
+};
diff --git a/drivers/powercap/dtpm_subsys.h b/drivers/powercap/dtpm_subsys.h
new file mode 100644
index 000000000000..2a3a2055f60e
--- /dev/null
+++ b/drivers/powercap/dtpm_subsys.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#ifndef ___DTPM_SUBSYS_H__
+#define ___DTPM_SUBSYS_H__
+
+extern struct dtpm_subsys_ops dtpm_cpu_ops;
+
+struct dtpm_subsys_ops *dtpm_subsys[] = {
+#ifdef CONFIG_DTPM_CPU
+	&dtpm_cpu_ops,
+#endif
+};
+
+#endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..2a10db2f0bc5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -321,16 +321,6 @@
 #define THERMAL_TABLE(name)
 #endif
 
-#ifdef CONFIG_DTPM
-#define DTPM_TABLE()							\
-	. = ALIGN(8);							\
-	__dtpm_table = .;						\
-	KEEP(*(__dtpm_table))						\
-	__dtpm_table_end = .;
-#else
-#define DTPM_TABLE()
-#endif
-
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -723,7 +713,6 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
-	DTPM_TABLE()							\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index d37e5d06a357..506048158a50 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -32,29 +32,11 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
-typedef int (*dtpm_init_t)(void);
-
-struct dtpm_descr {
-	dtpm_init_t init;
+struct dtpm_subsys_ops {
+	const char *name;
+	int (*init)(void);
 };
 
-/* Init section thermal table */
-extern struct dtpm_descr __dtpm_table[];
-extern struct dtpm_descr __dtpm_table_end[];
-
-#define DTPM_TABLE_ENTRY(name, __init)				\
-	static struct dtpm_descr __dtpm_table_entry_##name	\
-	__used __section("__dtpm_table") = {			\
-		.init = __init,					\
-	}
-
-#define DTPM_DECLARE(name, init)	DTPM_TABLE_ENTRY(name, init)
-
-#define for_each_dtpm_table(__dtpm)	\
-	for (__dtpm = __dtpm_table;	\
-	     __dtpm < __dtpm_table_end;	\
-	     __dtpm++)
-
 static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
 {
 	return container_of(zone, struct dtpm, zone);
-- 
2.25.1


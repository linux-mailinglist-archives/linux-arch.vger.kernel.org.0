Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2502C0339
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgKWKZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:25:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44227 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgKWKZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:25:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id d20so7104967lfe.11;
        Mon, 23 Nov 2020 02:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0R5B5NEv7oqTPvl5L6QmigBIM00NjEd6sjsvZWW1R4A=;
        b=RabaZ/Hv7ZdMdkJMHwtUZLbcSay6nMj3Frz5WIFQiZIgJ2u4Peu0OvUOvht1+PPn6e
         JUYDqovbRK2Bmzn6UBLJScBWdnyBgWtyrdzrdpk1uuUyLrisu30WH/qkoCqfPBMNjavq
         NwVl+Il2kJXdBp4/36EAGCI4WIZHOFQwMArQ7hIhGybk57KhSnkkurIXaO338B8CpTco
         N0pIs9pbqW1osW3kVLMJ8kjVzlDVZxREvnJSmaYUw5EAQ4/I+lqgIpmRO6gVwogGvt8H
         aJeCWccWiVl//m1dFuSAbzO3fVeWJNwdrImD3O8caWwZYSLfCFqnMylz7kbP8gv5LfNC
         bxeQ==
X-Gm-Message-State: AOAM533b0qCrNWnwhVAcm+9knmpXrAKyV9mpm7SsRJfcQXCnGp+7U92b
        y1siNmLJBeqt6JRXN2og8qI=
X-Google-Smtp-Source: ABdhPJzg8syGN8Z5PZT9JURA0pE0JMS+anhz0oG1XKKRmwEDBBg3hlO3N0RWYpGP0xVsjCD7fELdsw==
X-Received: by 2002:a19:7fcd:: with SMTP id a196mr12426890lfd.53.1606127096822;
        Mon, 23 Nov 2020 02:24:56 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 7sm430133ljq.34.2020.11.23.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:24:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kh91q-000281-D3; Mon, 23 Nov 2020 11:25:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 4/8] module: simplify version-attribute handling
Date:   Mon, 23 Nov 2020 11:23:15 +0100
Message-Id: <20201123102319.8090-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201123102319.8090-1-johan@kernel.org>
References: <20201123102319.8090-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of using the array-of-pointers trick to avoid having gcc mess up
the built-in module-version array stride, specify type alignment when
declaring entries to prevent gcc from increasing alignment.

This is essentially an alternative (one-line) fix to the problem
addressed by commit b4bc842802db ("module: deal with alignment issues in
built-in module versions").

gcc can increase the alignment of larger objects with static extent as
an optimisation, but this can be suppressed by using the aligned
attribute when declaring variables.

Note that we have been relying on this behaviour for kernel parameters
for 16 years and it indeed hasn't changed since the introduction of the
aligned attribute in gcc-3.1.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/module.h | 26 +++++++++++++-------------
 kernel/params.c        | 10 ++++------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 735f2931ea47..ebe2641d7b0b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -266,20 +266,20 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 #else
 #define MODULE_VERSION(_version)					\
 	MODULE_INFO(version, _version);					\
-	static struct module_version_attribute ___modver_attr = {	\
-		.mattr	= {						\
-			.attr	= {					\
-				.name	= "version",			\
-				.mode	= S_IRUGO,			\
+	static struct module_version_attribute __modver_attr		\
+		__used __section("__modver")				\
+		__aligned(__alignof__(struct module_version_attribute)) \
+		= {							\
+			.mattr	= {					\
+				.attr	= {				\
+					.name	= "version",		\
+					.mode	= S_IRUGO,		\
+				},					\
+				.show	= __modver_version_show,	\
 			},						\
-			.show	= __modver_version_show,		\
-		},							\
-		.module_name	= KBUILD_MODNAME,			\
-		.version	= _version,				\
-	};								\
-	static const struct module_version_attribute			\
-	__used __section("__modver")					\
-	* __moduleparam_const __modver_attr = &___modver_attr
+			.module_name	= KBUILD_MODNAME,		\
+			.version	= _version,			\
+		};
 #endif
 
 /* Optional firmware file (or files) needed by the module
diff --git a/kernel/params.c b/kernel/params.c
index 164d79330849..2daa2780a92c 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -843,18 +843,16 @@ ssize_t __modver_version_show(struct module_attribute *mattr,
 	return scnprintf(buf, PAGE_SIZE, "%s\n", vattr->version);
 }
 
-extern const struct module_version_attribute *__start___modver[];
-extern const struct module_version_attribute *__stop___modver[];
+extern const struct module_version_attribute __start___modver[];
+extern const struct module_version_attribute __stop___modver[];
 
 static void __init version_sysfs_builtin(void)
 {
-	const struct module_version_attribute **p;
+	const struct module_version_attribute *vattr;
 	struct module_kobject *mk;
 	int err;
 
-	for (p = __start___modver; p < __stop___modver; p++) {
-		const struct module_version_attribute *vattr = *p;
-
+	for (vattr = __start___modver; vattr < __stop___modver; vattr++) {
 		mk = locate_module_kobject(vattr->module_name);
 		if (mk) {
 			err = sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
-- 
2.26.2


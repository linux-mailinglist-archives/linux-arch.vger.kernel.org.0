Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658622A4DF4
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgKCSMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39608 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgKCSMF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id m16so20087005ljo.6;
        Tue, 03 Nov 2020 10:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjuGehr4XknYYBgxjDQlTnP9rZe3czEuMZ+c8GBcVIs=;
        b=eyUk9M3d0gRbUqzUn5L7mHbsiICExTp0iFSKmFNmhg9SPLjRUOocp3Mr7fMO0ByIUf
         Jn0IPxBXhUyr9azeXC4/qGn1+S3rMXgyjg1XDaA2BRBWaruNkxjJr4odOP52vnn07ucg
         GfCoDoAEFKpYlC73nsqXj/g0yNISueFJFPXcQiBGDpgnoA5NqYaFV/PHdsUwjumqpjOM
         YjPla8Cc0Qxsa5p6EDi8RzOgJDi38yCK403gOSQxWEPEs0nZDpzoKtDCiOCSu8kG+Wc7
         bVaJJNylSEXfNohhpbmY6HesLtF6fhoZ0/MUSQdnXnVzFAil/reyLukST8fQjhe0ZscG
         X6Vg==
X-Gm-Message-State: AOAM533boOEyNbDIPnTXNUz8DMmhERM/aS3EpN4+5c9NO2/pXnlRZqfI
        h9/tPdKMCc2B+PWrN8ZsECNLLHI2c2ldNA==
X-Google-Smtp-Source: ABdhPJyy4ScccKitgsgLmfW4+7RpegTCk9j7/oY7fM88C4FjnN07f4OIgFsfgAaoXJfSheheELK2gA==
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr8938849ljc.257.1604427122745;
        Tue, 03 Nov 2020 10:12:02 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id j10sm3655725lfr.288.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:12:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mn-0002rg-Sf; Tue, 03 Nov 2020 19:12:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
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
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/8] module: simplify version-attribute handling
Date:   Tue,  3 Nov 2020 18:57:07 +0100
Message-Id: <20201103175711.10731-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103175711.10731-1-johan@kernel.org>
References: <20201103175711.10731-1-johan@kernel.org>
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

Note that we have been relying on this gcc behaviour for kernel
parameters for 16 years and it indeed hasn't changed since the
introduction of the aligned attribute in gcc-3.1.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/module.h | 26 +++++++++++++-------------
 kernel/params.c        | 10 ++++------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 293250958512..5958075ea3f4 100644
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
index 3835fb82c64b..aa7d6f2213f1 100644
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


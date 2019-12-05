Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09B1148D4
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfLEVwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Dec 2019 16:52:11 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36839 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbfLEVwL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 16:52:11 -0500
Received: by mail-io1-f67.google.com with SMTP id l17so5270267ioj.3;
        Thu, 05 Dec 2019 13:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e87BZGmWkpLZLDiE87VOkYIktS/iX8I8E4fJx5a9NY=;
        b=vec6PHQ65zFZ2AkEnLw268Kc2K0MR2UyTczNzpYXosCpx4+PN+NNkl8QjdysVOwrA8
         xXFACPKcNfr0dz/2BqFFsKbAjquNsT+9p/dTGLBuEoOYryMjQ3UJrz7cYVJyAbEpLtQ8
         KEZYXG7PD6GZl9MMrVPGTNWb9ymhE1IGtsfooGAX6huHWmbYd1Mch0N3yol2Cy2B+UKX
         6yFkSKbpRK4Y1iJGBv2ttuzxsMySdegy0pXBw4eCvjzVTMvUNFHMZVn8j0ObxZVwIuM8
         yI4daHXMFaW62aTyy5UgPJbvpYGFJ4M45ul9koCD7p9zrkhXDOBPPvOivFbIp7sdwEKp
         4xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e87BZGmWkpLZLDiE87VOkYIktS/iX8I8E4fJx5a9NY=;
        b=Or/yBkNaboyz1VqsN4zukYnKSJSuKofa4aGt8wA+wzwUbcOeJwF2uG+Ut3BprvWoV7
         +w73Gf0+plZcjr8iETmDfUUc/pDo49azcr+6mo5X84wqLLhNT51Z4l4T+6gaWLVU9DJs
         xPlmznrnV9daRWtQYutNiH3fOm/HWpT7IzCPVDYAAHPo8zXmzD8Tavp7zU7CIot/lnHN
         3BMYE/7HE7WVW16sNywpVCRYy80FV2yIZ4wzQTkQvtkSRfwDqMAJGiSHR5Oqxt/GwU/W
         UZYAv0wOH4FP0G/f4M1eQB3Wc4nV1w9aR1N5xCUhmjtSm51qyvd2omQGzEK9zqIFwogD
         69CA==
X-Gm-Message-State: APjAAAWg+yo/rmaHJ8e5znw9iX+w0CGtvi3DUjkuFQS+G91ZITjNA62H
        sBGrhC+MoWBlMvWKdAJJw4AR+XH1sAY=
X-Google-Smtp-Source: APXvYqw/su3Vu7qa5e4mwi0F+jZd4UYho+yw8impxRonTbKcXyESHJeH/YsM3ggchsm3ujlmrvxHNg==
X-Received: by 2002:a5e:db0d:: with SMTP id q13mr8056229iop.199.1575582730008;
        Thu, 05 Dec 2019 13:52:10 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:09 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 04/18] dyndbg: rename __verbose section to __dyndbg
Date:   Thu,  5 Dec 2019 14:51:35 -0700
Message-Id: <20191205215151.421926-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dyndbg populates its callsite info into __verbose section, change that
to a more specific and descriptive name, __dyndbg.

Also, per checkpatch:
  simplify __attribute(..) to __section(__dyndbg) declaration.

and 1 spelling fix

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  6 +++---
 include/linux/dynamic_debug.h     |  4 ++--
 kernel/module.c                   |  2 +-
 lib/dynamic_debug.c               | 12 ++++++------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dae64600ccbf..82694efe3a83 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -285,9 +285,9 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	__start___verbose = .;						\
-	KEEP(*(__verbose))                                              \
-	__stop___verbose = .;						\
+	__start___dyndbg = .;						\
+	KEEP(*(__dyndbg))						\
+	__stop___dyndbg = .;						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4cf02ecd67de..802480ea8708 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -80,7 +80,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
-	__attribute__((section("__verbose"))) name = {		\
+	__section(__dyndbg) name = {				\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
@@ -133,7 +133,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 /*
  * "Factory macro" for generating a call to func, guarded by a
- * DYNAMIC_DEBUG_BRANCH. The dynamic debug decriptor will be
+ * DYNAMIC_DEBUG_BRANCH. The dynamic debug descriptor will be
  * initialized using the fmt argument. The function will be called with
  * the address of the descriptor as first argument, followed by all
  * the varargs. Note that fmt is repeated in invocations of this
diff --git a/kernel/module.c b/kernel/module.c
index ff2d7359a418..a9c052cc30c5 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3237,7 +3237,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__verbose",
+	info->debug = section_objs(info, "__dyndbg",
 				   sizeof(*info->debug), &info->num_debug);
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c86c97154657..0a4588fe342e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -39,8 +39,8 @@
 
 #include <rdma/ib_verbs.h>
 
-extern struct _ddebug __start___verbose[];
-extern struct _ddebug __stop___verbose[];
+extern struct _ddebug __start___dyndbg[];
+extern struct _ddebug __stop___dyndbg[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -1010,14 +1010,14 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (__start___verbose == __stop___verbose) {
+	if (__start___dyndbg == __stop___dyndbg) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 		return 1;
 	}
-	iter = __start___verbose;
+	iter = __start___dyndbg;
 	modname = iter->modname;
 	iter_start = iter;
-	for (; iter < __stop___verbose; iter++) {
+	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
 		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
 			+ strlen(iter->filename) + strlen(iter->format);
@@ -1040,7 +1040,7 @@ static int __init dynamic_debug_init(void)
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
+		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.23.0


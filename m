Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726EF10B4C6
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2019 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK0Ru4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Nov 2019 12:50:56 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35663 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Ruz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Nov 2019 12:50:55 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so25865212ior.2;
        Wed, 27 Nov 2019 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e87BZGmWkpLZLDiE87VOkYIktS/iX8I8E4fJx5a9NY=;
        b=BwJRO9m5excznuQCr5fYQ2w+2qS1FNgdVkq1dGMLZlGYvibpEqO3sZwyR5frNg6dJk
         biR9BA/xygxtM9WdMnI4iNy3hR/f6ejrSDAFuXgnnOTklYvRuRfQEo5IkR60xCkVcEda
         lzs/zzRrZlShaaryRYw1thLDnUMmHz0Bczjggnbu+Qgh2bd+MkmcIW2QIDJBobEKNliV
         rg+oVTfS7fMeiMXq0LkS0r3OCt05u5i35t9AiaS4CloAZXJiIijsY884Zq6Z1ywjvOBG
         75oyGMIHSEGJgKFmpG9b9tdvb7zg/R//19lOc/Od4X6527zqlUFCEJ/iPIn96llggtsf
         CZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0e87BZGmWkpLZLDiE87VOkYIktS/iX8I8E4fJx5a9NY=;
        b=NZQ4ix33EnEbOCgkmwwkEdr/Z5GqfjIJijOhTOpPKAQ1VW8Zlr7arvPaldb5Ne1Ytu
         f6d9BpUJYL+aXPlqWMvfQ5T0k7YwzX2hfMrIruM89FyEq6dYuelhVvbrvryiNR2xfV+b
         F+bAc45JZ1YJlT8AgDygjsULnPcOSsNIp6keI9CQUKHYgaqx+FYxDb+PGen+VE2rqKDC
         MCgPfRqj49FdH4lvdj4bWYy58cc/W3QlPnPFcwacUUDIlzjRAbYaAcFtIPWdDq7qbq5B
         A6UrLBeSasZWQ7gc46fHi7pi1bbNf1ZSRnksPN1cstQiKNFAhssPhWDnFVSV1QoaIb2k
         lJAQ==
X-Gm-Message-State: APjAAAXlh6CRtfgEUZoWnTzpCagv6ciYbxQBnof9hQtFOHwD5/D38s30
        +xQQNmx3DDY27XvcjCqWxj8=
X-Google-Smtp-Source: APXvYqxfuDkQk7T2rw14N8PYKNtZLqWGSWC1fRZggHXkx/NdeUswPZbrHxNG/kNiLN3HDYPMsdhygg==
X-Received: by 2002:a02:95c3:: with SMTP id b61mr5965190jai.21.1574877054516;
        Wed, 27 Nov 2019 09:50:54 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id r16sm4588493ilk.63.2019.11.27.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:50:53 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
Date:   Wed, 27 Nov 2019 10:50:50 -0700
Message-Id: <20191127175051.1351346-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
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


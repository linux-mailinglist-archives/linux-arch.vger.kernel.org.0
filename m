Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 468F5E9071
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 21:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJ2UAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 16:00:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44589 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 16:00:31 -0400
Received: by mail-il1-f195.google.com with SMTP id h5so9206973ilh.11;
        Tue, 29 Oct 2019 13:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bu4PP+wJkjM5bi6322bHd0AxHFp4lCpFeh1PdkwmHBk=;
        b=fplGulajZVpAdflG13/yIqglx2D6pxh56BOa83UAXk2PkpiRYJPL3ZbbD7wVV/IufL
         klm4Y+5Oing3KpDZU1HrKN5lqD0oRSS2de0fcCUezY2rN3tv5u5M5c4XxiZmEUc8gSpU
         xeQG0QUE585150c7vNMyFFtwPSznefjMFjfssgQIU+Om+eIEWSULxSFTFUymfsqi9Diq
         VRJw9AFgMCcn93RdISsSbJle3wYFMxHaAdvrDWdYutHgWXSuzKnrMPawQsPvIb0+g7a0
         NGfUKKkIB0SEOYrkmeroB46bfphwLknHnl4paYoEd3HKyWbU2mZw3mKwHH3Yw1FS2CAf
         57MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bu4PP+wJkjM5bi6322bHd0AxHFp4lCpFeh1PdkwmHBk=;
        b=Clx9kxpzEKnF765cKDZQVPCvnMz2c6F2F8fXKTKY5g35mqTGYjJXljKWweHbAFFJTw
         w0qiKzSPdO4JayJQgqcBrltCfVMSsnT/deq3HUHm7c+Bxh8gE+jMEl81HZr1QO5fZYQM
         4+IZvhRBiPfzE1sndcZ3vERLNlZvUlGQMOng1FF8sls0HkvSBD7B/234e6+g1kksFjKa
         EcaEq28Gmkwu/nBKe30ERqcNU5MA3mJGbWH6+yl25HjdD4b9Wrxy22io3/KEfW2SKlgq
         QmNTi0jbmV3oqZ7ar9Pbfl7hLIxy6r64+6Z8G193RfsecmWsuli1KtXBQv800bhrMuvE
         Fymg==
X-Gm-Message-State: APjAAAVNl2LeUnDX0R8PCA2vwdddQgKDwVGVhMWWEneG6VK9s6U+pM4E
        fsWL5ZxTqX4lfcvvFvGdxnddYFB/rjs=
X-Google-Smtp-Source: APXvYqyQ0KUz1jjiNNFmGGB3B/uoOdvBvoJgjReqc6P0tueuivrb6mzJDHnmEXhyejMMWv9aZUSvfQ==
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr29743941ili.269.1572379230435;
        Tue, 29 Oct 2019 13:00:30 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y5sm1960ioa.13.2019.10.29.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
Date:   Tue, 29 Oct 2019 14:00:26 -0600
Message-Id: <20191029200026.9790-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

dyndbg populates its callsite info into __verbose section, change that
to a more specific and descriptive name, __dyndbg.

Also, per checkpatch:
  move extern struct _ddebug __(start|stop)__dyndbg[] to header file
  simplify __attribute(..) to __section(__dyndbg) declaration.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  6 +++---
 include/linux/dynamic_debug.h     |  4 +++-
 kernel/module.c                   |  2 +-
 lib/dynamic_debug.c               | 10 ++++------
 4 files changed, 11 insertions(+), 11 deletions(-)

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
index 6c809440f319..a829c86364d4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -46,6 +46,8 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
+extern struct _ddebug __start___dyndbg[];
+extern struct _ddebug __stop___dyndbg[];
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
@@ -80,7 +82,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
 	static struct _ddebug  __aligned(8)			\
-	__attribute__((section("__verbose"))) name = {		\
+	__section(__dyndbg) name = {				\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
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
index f82ec49e5916..6eec5bd559fe 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -39,8 +39,6 @@
 
 #include <rdma/ib_verbs.h>
 
-extern struct _ddebug __start___verbose[];
-extern struct _ddebug __stop___verbose[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -997,14 +995,14 @@ static int __init dynamic_debug_init(void)
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
@@ -1027,7 +1025,7 @@ static int __init dynamic_debug_init(void)
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
+		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.21.0


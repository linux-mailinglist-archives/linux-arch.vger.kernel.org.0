Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6281EFDDD
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jun 2020 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFEQ2i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Jun 2020 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFEQ1l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jun 2020 12:27:41 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA9C08C5C2;
        Fri,  5 Jun 2020 09:27:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v13so8077422otp.4;
        Fri, 05 Jun 2020 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUCJSurd1+2mih37yJICMDA0iRTJL0v8tyZ1IpuaG+8=;
        b=Uyo+mH9X1aBtxkmIuq4QbBFF+YchMadv/oubGzNwTi8c5SWHwOdtN8sDfQ6MCApNOm
         VSplXDTjILJhdGUKYne5sjnuycUNvmGpJk0vqE7JvovGyRRiPO72/84Bi05PZVlDHVE1
         qn4PHhSN3cZRFhhskf+tAoDBtJxjy0Ob8uqM+mvgtFYZ86CN+01frlTMMQRboQs2yoaY
         9JZ7ZvybXv2c54SEl2ykQcrUYyxhTOM4XbNKdh6XDiOeZobsM3etBlueZmVkCoQ0tLjo
         1HV/7PiZy5dcbtS37T4qHbUkwlOtszseBHpzjvLYQ17myMtqOEHXkRfJCzSvKE+7rIMW
         wibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUCJSurd1+2mih37yJICMDA0iRTJL0v8tyZ1IpuaG+8=;
        b=nzskQxARd94iKS1SIl2Qv8YmB1v2Ejlh5ykL8m1FqqSdbp3Mk5JoTkPUpKYu3nstRR
         AmXx8IYbmsdhFUySBMIvpsW/8jU/pxK/h6CGuMMaW4MaB3Z8cuzkAKv0M0irJFelo6DH
         FFfYy9ivGx8llxIglo5npJTL/1oLsx8D/WkL/8dKD1NHEY2inY+aoFv/tt9a8s5pnuph
         VcCAC+SEEwSjP94hDd3ASzn9mvMKQqC1GZPgfeY1SYfg1aE6IJCWAnfSewpQJ6ZYymP2
         O1KlsolpJ3SVJr4vVHWE2Ql8wjloypClK1waH6DQB3ApE44/MuZvbLPTVPfX+9y1ZX2e
         p3uw==
X-Gm-Message-State: AOAM532WdDPWbrRALG+rlxnkHZY890uQceK+zgw+IuQnuokBCpNFT/4P
        +jppc1Lq1R84qtGIPuyrE/Q=
X-Google-Smtp-Source: ABdhPJxLVoZCXKxpWmkB6pKQ9FNKprWw7ILYevffof0FspBctnSHnNMPLP4lBdgmwjld96TqRQyA2g==
X-Received: by 2002:a9d:560d:: with SMTP id e13mr8184619oti.55.1591374461205;
        Fri, 05 Jun 2020 09:27:41 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
Date:   Fri,  5 Jun 2020 10:26:33 -0600
Message-Id: <20200605162645.289174-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
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
index 71e387a5fe90..a117f2757a0d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -320,9 +320,9 @@
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
index 646f1e2330d2..c66b18261a6e 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3200,7 +3200,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__verbose",
+	info->debug = section_objs(info, "__dyndbg",
 				   sizeof(*info->debug), &info->num_debug);
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5900c043e979..e17d4e2661d8 100644
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
@@ -1019,14 +1019,14 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (&__start___verbose == &__stop___verbose) {
+	if (&__start___dyndbg == &__stop___dyndbg) {
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
@@ -1049,7 +1049,7 @@ static int __init dynamic_debug_init(void)
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
+		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2


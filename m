Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017F61F840F
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jun 2020 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFMP6F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Jun 2020 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFMP6E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jun 2020 11:58:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A599C03E96F;
        Sat, 13 Jun 2020 08:58:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so9733671ote.11;
        Sat, 13 Jun 2020 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZljagVJnqhfl0YwcFuuFKru4fP+VT2YvztPNpox2KUk=;
        b=RAu3m2brdgBK1nUtH4zjIHjGdj9CjbKR67xoRKUkOjDfGMl3dqTK9P1+nMVxoEcV+h
         xpZ+YtELxio33nO8LraZyXcLMPMUQhj5d/IyFFMxOllQVO0mmRcuv/dxToK/R6glpBgC
         RFWq7RQzn8l7+KVGbpzj03T/Iawa1ur9qVkdxKZD3M+l5o+xjcYMnBT63Hy8MpazWjWd
         gr4q3V+vMQRvk3vLz/D3RrqlP4CkkNPb0FQBF4pTO0eAcI8QvXbdDzwJJbjZsjJG8th9
         HQlzAypGJhzEZXo9Lz3/jUtGIBcCHEY+JJ6sbWZBGq7+xItVHIxOe91bQy8WXmIapdZX
         scHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZljagVJnqhfl0YwcFuuFKru4fP+VT2YvztPNpox2KUk=;
        b=f6Z+Tl/7pWrs5L+00Edrgnbf1uONuznbyBWDLxD93u9rpCDRph27k4+8e8bWgWBNZ+
         1Ef2n5KtjTDEnoFR49zLcQmt4sRZJSY2E7LMnTMDeVSimxtUelCerkioTbjYfsLKOFhU
         DLnfEqR8wioEDL13AbY+7iDIq7zz/sKnAL9qhz6azdbnVkFqgNGGS+qd/k+1CX1iwyp4
         5CnUUTIfCMCRezEW2+tPp+fYQdu8UL0K5moEuTUDM8RsKDNG9RJf4k/3mUFQk6bJ4WWq
         oIxo0TbfRvcUJIs7+WUodS4eYmG6o6j17Ds4t+95lIOecfvFw0ko8ITgQ1qdvIdvspDC
         j4pQ==
X-Gm-Message-State: AOAM532mjxMlxIBpqk7fnXFGROchgYRfU90VjVkOEkdF+gNduOcHiDHz
        Vut64KkOWBjbdodrMSG4wlY=
X-Google-Smtp-Source: ABdhPJzmlNFeyZKdWmmuZ8RXgiPBMkZblBfMhSz0WdiosJdEVyPJZdu+N+zOOozGtiDRDgdtEPLmdw==
X-Received: by 2002:a05:6830:14c2:: with SMTP id t2mr14709202otq.5.1592063883585;
        Sat, 13 Jun 2020 08:58:03 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:03 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 05/24] dyndbg: rename __verbose section to __dyndbg
Date:   Sat, 13 Jun 2020 09:57:19 -0600
Message-Id: <20200613155738.2249399-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
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

and 1 spelling fix, decriptor
---
 include/asm-generic/vmlinux.lds.h |  6 +++---
 include/linux/dynamic_debug.h     |  4 ++--
 kernel/module.c                   |  2 +-
 lib/dynamic_debug.c               | 12 ++++++------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..05af5cef1ad6 100644
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
index abcd5fde30eb..aa9ff9e1c0b3 100644
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
index e8a198588f26..1fb493167b9c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3232,7 +3232,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-	info->debug = section_objs(info, "__verbose",
+	info->debug = section_objs(info, "__dyndbg",
 				   sizeof(*info->debug), &info->num_debug);
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c97872cffc8e..66c0bdf06ce7 100644
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
@@ -1019,7 +1019,7 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (&__start___verbose == &__stop___verbose) {
+	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 			return 1;
@@ -1028,10 +1028,10 @@ static int __init dynamic_debug_init(void)
 		ddebug_init_success = 1;
 		return 0;
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
@@ -1054,7 +1054,7 @@ static int __init dynamic_debug_init(void)
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___verbose - __start___verbose));
+		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.26.2


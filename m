Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBB2C4887
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 20:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgKYThd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 14:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgKYTha (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2020 14:37:30 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921CC0617A7;
        Wed, 25 Nov 2020 11:37:20 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id t8so3273284iov.8;
        Wed, 25 Nov 2020 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wea6QiUzhXHIk6esfYL2NcPGJp+vK9+oW+T7p8v+MVM=;
        b=fN+uRnZ99+vArdZ7qGdLFv2fXyLT97QaDYrm+jZ5HKLfS57NEKy4sD5H++6zBVGUI/
         D2DxrGZ/bVZuBhsZ9NnrshtE2YPL2JdWW9Wwb3NJSJVFfVtP2p70FAm/Z4Jz01+qvLcD
         y5YVI0m92711ZYUVnXOnmN7oJ2LjuFkJfdzq2BKPhslS5A/QNwRliB+T8aidweIXl/9Y
         p9FXo7s9s/ABMl6W7t7HWVzEUQu1nXStyd7zUtTRQntG3gc1H30CTgAjiFgt4gsvBRkI
         woyr8EsTE1aXJnd+aaMPoH6mUDR6kzKboBd8NERzJCf42yOYZNkCSWC9Tw7nRg4r0Y0b
         zsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wea6QiUzhXHIk6esfYL2NcPGJp+vK9+oW+T7p8v+MVM=;
        b=jxPhk/qqH1g8Lc79gP+Fh41iJs6UexUFKA6GLfdYpKfdFiTzOqiGqd2iaZfS0jnGEj
         wt36X+tldaWe58o2CJrW9Mw2MyJuQbBXbNhL/MWnDb4kWryS5NZ7onNri83pAPjryUuv
         tYdCTREho7ZPrCK4g1NmGicwPXV9rnCU/k6rpuacaZNqvHnx/V+H7VNOtFIWCNuOv3uD
         5kehvbrD+HjzR0icT24zKIdoZZp6sKB1bE9iO5bJMuso56Mat3KaSP3IKax/JonIuXkq
         iEPpZ6DmDv7US7VFm/XGcU8YHQShGn2QczFQLnfSAPmBxPKBiLa6ltDyalzPRe2JDBm0
         vEAg==
X-Gm-Message-State: AOAM530ZIC95NoORtd+FUuFVe9AJJOpEyxtxPJyF154Dv8V4aWLwKnv+
        0aatbv/sNyh/Y7JV5mu/LmE=
X-Google-Smtp-Source: ABdhPJy/fLRTYIcRihiDuFlvRFnWseq05Er1A0QQbGgD++9qfoiAQHZHYX7mL+hj2EJ3K6nnjEtEhg==
X-Received: by 2002:a02:3846:: with SMTP id v6mr4986390jae.8.1606333039581;
        Wed, 25 Nov 2020 11:37:19 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id f8sm1435548ioc.24.2020.11.25.11.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 11:37:19 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-mm@kvack.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dyndbg: move struct _ddebug's display fields to new _ddebug_callsite
Date:   Wed, 25 Nov 2020 12:36:20 -0700
Message-Id: <20201125193626.2266995-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201125193626.2266995-1-jim.cromie@gmail.com>
References: <20201125193626.2266995-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

struct _ddebug has 5 fields used to display and select pr_debug
callsites, move these to a new struct _ddebug_callsite, and add ptr to
link 1st to 2nd.  While this increases memory footprint by 1 ptr per
pr_debug, the indirection gives several advantages:

- we can allocate storage only for enabled callsites.  Since pr_debugs
  are 99% disabled, we should see savings.

- the display fields are inherently hierarchical, and the linker
  section is ordered; so (module, file, function) have redundant
  values (90%, 85%, 45%).  This is readily compressible, even with a
  simple field-wise run length encoding.  Because theyre placed in a
  separate linker section, theyre in a contiguous block of memory,
  which should simplify that compression.

Looking forward, there are several approaches to get the advantages.

A - copy each callsite to zram, save to new .zhandle member, and
update site pointers.  Must later retire __dyndbg_callsite section
afterwards to actually recover memory.

I did this (next patches), and get 3:1 zs_page:page compression.  It
works when sites are zs_mapped in just for the print.  But if I leave
them mapped in cuz the pr_debug is enabled, locking conflicts & panic
ensue.  Patches follow.

B - compress __dyndbg_callsite linker section, using some format which
is good at random-index decompression.

I did objcopy --dump-sections .. vmlinux.o, got mostly empty data,
like Im getting values before the final link.  Im missing some
understanding.

C - field-wise RLE.  This is feeling increasingly suitable.

Whats actually done here:

dynamic_debug.h:

I cut struct _ddebug in half, renamed top-half (body), kept __align(8)
on both head & body, added a forward decl for a unified comment for
both head & body.  And added head.site to point at body.

DECLARE_DYNAMIC_DEBUG_METADATA does the core of the work; it declares
and initializes both static struct vars together, and refs one to the
other.

And since Im rejiggering the structs:

- I moved static_key key to front of struct _ddebug; its the biggest
  member, and most alignment sensitive, so moving it to front may
  improve ambient pahole conditions.

- reorder display fields to match the hierarchy.  This should help
  improve compressability, particularly for field-wise RLE.  With
  this, consecutive records are tail-different.

Also
- reserved a flag bit for zram mapping (no use yet)
- I shrunk lineno member from 18 to 16 bits, and made it const.
  No source file is near 64k-lines, I doubt any could get added.

dynamic_debug.c:

dynamic_debug_init() mem-usage now counts callsites.

The 3 funcs which use _ddebug* pointers (ddebug_change,
dynamic_emit_prefix, ddebug_proc_show) each get an auto-var, inited
with ->site, and s/dp/dc/ as needed.  These once-per-func dp->site
derefs are also a setup for the next commit.

vmlinux.lds.h:

add __ddebug_callsites section, with the same align(8) and KEEP as
used in the __ddebug section.

TBD:

_align(8) may be unnecessary on struct _ddebug_callsite, I think its
there for the static_key member.  I do wonder if its arch dependent, 8
seems big for i686 at least.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  4 +++
 include/linux/dynamic_debug.h     | 41 +++++++++++++++---------
 lib/dynamic_debug.c               | 52 +++++++++++++++++--------------
 3 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..1ef1efc73d20 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -340,6 +340,10 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
+	__start___dyndbg_callsites = .;					\
+	KEEP(*(__dyndbg_callsites))					\
+	__stop___dyndbg_callsites = .;					\
+	. = ALIGN(8);							\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a57ee75342cf..0bf7036bcdb2 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -7,11 +7,14 @@
 #endif
 
 /*
- * An instance of this structure is created in a special
- * ELF section at every dynamic debug callsite.  At runtime,
- * the special section is treated as an array of these.
+ * a pair of these structs are created in 2 special ELF sections
+ * (__dyndbg, __dyndbg_callsites) for every dynamic debug callsite.
+ * During init, __dyndbg_callsites is copied to zram, and links to
+ * them in _ddebug are updated.  At runtime, the __dyndbg section is
+ * treated as an array of struct _ddebugs.
  */
-struct _ddebug {
+struct _ddebug;
+struct _ddebug_callsite {
 	/*
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
@@ -20,7 +23,17 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
-	unsigned int lineno:18;
+	const unsigned int lineno:16;
+} __aligned(8);
+
+struct _ddebug {
+#ifdef CONFIG_JUMP_LABEL
+	union {
+		struct static_key_true dd_key_true;
+		struct static_key_false dd_key_false;
+	} key;
+#endif
+	struct _ddebug_callsite *site;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -32,20 +45,14 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_MAPPED		(1<<7) /* reserved */
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
-#ifdef CONFIG_JUMP_LABEL
-	union {
-		struct static_key_true dd_key_true;
-		struct static_key_false dd_key_false;
-	} key;
-#endif
-} __attribute__((aligned(8)));
-
+} __aligned(8);
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -83,13 +90,17 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	static struct _ddebug_callsite  __aligned(8)		\
+	__section("__dyndbg_callsites") name##_site = {		\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
+	};							\
+	static struct _ddebug  __aligned(8)			\
+	__section("__dyndbg") name = {				\
+		.site = &name##_site,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
 		_DPRINTK_KEY_INIT				\
 	}
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 711a9def8c83..2e4a39c349a5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -165,19 +165,20 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
+			struct _ddebug_callsite *dc = dp->site;
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, dc->filename) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					   kbasename(dc->filename)) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					   trim_prefix(dc->filename)))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, dc->function))
 				continue;
 
 			/* match against the format */
@@ -185,19 +186,19 @@ static int ddebug_change(const struct ddebug_query *query,
 				if (*query->format == '^') {
 					char *p;
 					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
+					p = strstr(dc->format, query->format+1);
+					if (p != dc->format)
 						continue;
-				} else if (!strstr(dp->format, query->format))
+				} else if (!strstr(dc->format, query->format))
 					continue;
 			}
 
 			/* match against the line number range */
 			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
+			    dc->lineno < query->first_lineno)
 				continue;
 			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			    dc->lineno > query->last_lineno)
 				continue;
 
 			nfound++;
@@ -214,8 +215,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dc->filename), dc->lineno,
+				 dt->mod_name, dc->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
@@ -587,14 +588,15 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	const struct _ddebug_callsite *desc = dp->site;
 
 	*buf = '\0';
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -602,13 +604,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (dp->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
 	if (pos - pos_after_tid)
@@ -880,6 +882,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
+	struct _ddebug_callsite *dc = dp->site;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -889,10 +892,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dc->filename), dc->lineno,
+		   iter->table->mod_name, dc->function,
 		   ddebug_describe_flags(dp->flags, &flags));
-	seq_escape(m, dp->format, "\t\r\n\"");
+	seq_escape(m, dc->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
 
 	return 0;
@@ -1094,17 +1097,17 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 	iter = __start___dyndbg;
-	modname = iter->modname;
+	modname = iter->site->modname;
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, iter->site->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
 				goto out_err;
 			n = 0;
-			modname = iter->modname;
+			modname = iter->site->modname;
 			iter_start = iter;
 		}
 		n++;
@@ -1114,9 +1117,10 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_callsites section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+		 (int)(entries * sizeof(struct _ddebug)),
+		 (int)(entries * sizeof(struct _ddebug_callsite)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.28.0


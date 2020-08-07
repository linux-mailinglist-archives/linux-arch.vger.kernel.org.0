Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31523F398
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 22:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHGUKt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 16:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgHGUKW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2020 16:10:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B950C061757;
        Fri,  7 Aug 2020 13:10:22 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so2997483oie.11;
        Fri, 07 Aug 2020 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ngo0dsxuAtkNMK9hISQVKp+CqKo7kyzE35EnNB4eOLg=;
        b=CLzIo8/AdR49+D8fVkJ1grL8XDs9M/t2pmOfAhJt/xMOOOq1U0MGACP5aeBBOSgzYN
         NKCFki8bAYCUN7ZtEco7F701C8TjnwsbQCMm6TFchK4sxPeRhHOOa2ZzJAL1LBgruFuv
         6Hcoj5dZooZa+C+RrblVscMUjwAgnqWvkIqhe2QBk9+ldi6QzSiqbrnsnJZOUgfYxXNH
         /cgrswOueEFzFsJXe8hRbyQ4i4uh7kk7pxvV88/ayYxMNrtbpMGyN80mxA843hBm088t
         sQ9MKAhLi4DM10KUTS0FpR12Z99J7NGB7WQUmm11JkrAQ93Cbmn4t8n7Oy0VuS5ddCkY
         XrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ngo0dsxuAtkNMK9hISQVKp+CqKo7kyzE35EnNB4eOLg=;
        b=uTMRkzzngG3bIWPZ2yVdU5bFsX0d41ED07rnxDz0U+XS1jvZMO5eds30mTEgbxOJGU
         hFEHU/m8xCqq0C1A/I6WMNXf3o1O/GN3vG2A1/P+5n5GREkf+1UYVm56YZUAvxqVbmmr
         iTS1e83lVRzRwDAJP9WdwNUiiEsvS4zh/HWsWY31Vqd0AgY3Go52C0HUWsbNlWP308mC
         NLiqrXKHg1MOOC83YCq/qGGIobls7qV2Yhqd7H2PWr8F0C+QEOrd+Im8kB2sMQqy4nz0
         cmB6vxnua2U6uYq+QkXNzaT8vcCYBoq8GTdmVRb2Ep6R+D0dLTqDU/ZR2eH5qi+pkU0a
         0zzA==
X-Gm-Message-State: AOAM5322JSGiFCt5rY4neH4SGpaN9ZH28SUxNKZgHkdG3r/9MLm/sVCt
        30V9RMIA4vtuC/ZGdSeA3/Y=
X-Google-Smtp-Source: ABdhPJz5zGc6rv9BIco+41NDFxevrdWSK7isc3Djm1d2Q05kA8t8VJbMRLbtMTFbhgo2nWKJgYVrQg==
X-Received: by 2002:aca:ad57:: with SMTP id w84mr12800995oie.40.1596831021718;
        Fri, 07 Aug 2020 13:10:21 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Subject: [PATCH 4/7] dyndbg: split struct _ddebug in 2, creating _ddebug_callsite
Date:   Fri,  7 Aug 2020 14:09:51 -0600
Message-Id: <20200807200957.1269454-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Split the struct into 2 linked parts (head & body) so that next,
struct _ddebug_callsite can be off-lined to zram, and only mapped in
as needed.  The split increases overall memory use by 1 pointer per
callsite, but 4 pointers and a short are now 99% likely to be off-line
(once implemented), and compressed.

 dyndbg: 264 modules, 2541 entries and 10560 bytes in ddebug tables,\
   81312 bytes in __dyndbg section, 101640 bytes in __dyndbg_callsites section

zram should give us some compression on the _ddebug_callsite data, and
if it doesn't, a simple run-length-encoder would be effective enough,
given the repetition on (modname,filename,function) of (90%,84%,45%)
and the highly ordered contents of the __ddebug_callsites section.

I wanted to also put the key field into _ddebug_callsite, since its
use is super rare; it is only used when enabling/disabling a callsite,
ie only when >control is being actively exersized.  But that blew up
with asm goto errors, so I punted.

So struct _ddebug_callsite is all const, RO data. Maybe thats
advantageous later, but with key there too, we can shrink the online
struct _ddebug further.

details of how:

dynamic_debug.h:

I literally cut struct _ddebug in half, renamed top-half, kept
__align(8) on both, added forward decl for unified comment (not needed
by compiler), and a site pointer from _ddebug to _ddebug_callsite, and
a few "->site" additions.

DECLARE_DYNAMIC_DEBUG_METADATA does the rest; it declares and
initializes both static struct vars together, and refs one to the
other.  Note: this may conflict with new guards against cross-linked
sections, but __init work on __initdata seems a fair loophole.

dynamic_debug.c:

dynamic_debug_init() gets "->site" added everywhere needed.

Other 3 runtime users get a new _ddebug_callsite *dc pointer,
initialized with a single dp->site deref, and s/dp/dc/ as needed.
These once-per-func dp->site derefs are a setup for the next commit.

vmlinux.lds.h:

add __ddebug_callsites section, with the same align(8) and KEEP as
used in the __ddebug section.  I suspect keep may go as a part of
effecting the section reclaim.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  4 +++
 include/linux/dynamic_debug.h     | 35 +++++++++++++++------
 lib/dynamic_debug.c               | 52 +++++++++++++++++--------------
 3 files changed, 58 insertions(+), 33 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c78629ec79b6..c874216c01f5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -320,6 +320,10 @@
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
index aa9ff9e1c0b3..bbb06a44c0cf 100644
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
@@ -20,7 +23,11 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
-	unsigned int lineno:18;
+	const unsigned int lineno:16;
+} __aligned(8);
+
+struct _ddebug {
+	struct _ddebug_callsite *site;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -32,20 +39,26 @@ struct _ddebug {
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
+	/*
+	 * TODO: key probably should be in _callsite, based upon how
+	 * little it is used (only on callsite enable/disable).  But
+	 * that gave weird asm goto errors in jump_label.h and I
+	 * punted.
+	 */
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
 		struct static_key_false dd_key_false;
 	} key;
 #endif
-} __attribute__((aligned(8)));
-
+} __aligned(8);
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -79,13 +92,17 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
-	__section(__dyndbg) name = {				\
+	static struct _ddebug_callsite  __aligned(8)		\
+	__section(__dyndbg_callsites) name##_site = {		\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
+	};							\
+	static struct _ddebug  __aligned(8)			\
+	__section(__dyndbg) name = {				\
+		.site = &name##_site,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
 		_DPRINTK_KEY_INIT				\
 	}
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 691e79826fc2..9161f345e3c9 100644
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
@@ -568,14 +569,15 @@ static int remaining(int wrote)
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
@@ -583,13 +585,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
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
@@ -861,6 +863,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
+	struct _ddebug_callsite *dc = dp->site;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -870,10 +873,10 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
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
@@ -1076,7 +1079,7 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 	iter = __start___dyndbg;
-	modname = iter->modname;
+	modname = iter->site->modname;
 	iter_start = iter;
 	for (prev = iter; iter < __stop___dyndbg; iter++) {
 		if (entries) {
@@ -1089,13 +1092,13 @@ static int __init dynamic_debug_init(void)
 			prev++; /* one behind iter */
 		}
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
@@ -1105,9 +1108,10 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_callsites section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+		 (int)(entries * sizeof(struct _ddebug)),
+		 (int)(entries * sizeof(struct _ddebug_callsite)));
 
 	vpr_info("%d entries. repeated entries: %d module %d file %d func\n",
 		 entries, modreps, filereps, funcreps);
-- 
2.26.2


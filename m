Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3176937AEB4
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 20:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhEKSwa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSwa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 14:52:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78016C061574;
        Tue, 11 May 2021 11:51:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id l21so19198220iob.1;
        Tue, 11 May 2021 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANa3RrA8GQr0AoP/19LhHIjfuWvBcIu4Kb3z3nXIqtc=;
        b=qYbO3nNzd+G95xmvT1sXJWHSXDZnN3Kc2IM9OMUMm0RcS59Zdwb1Rk+OqTPk3ZcWnv
         vRT/Ku+pPGbKCmdJvDImSzDKuGelMWBOCUQp9+dHqhzdBSc5On1RIVppqozqNq5MlMy/
         Rz6zEn5Oh7VYALMrNjpDJIj6b8pypLGkIW2etZwvyaDTcQbRFSpV9fZvoBd+BCdl+tjc
         Dxo13ZWqxif3Tqic8R0CgrfQBzazQZPP6ikR+fXZdtkVBRB6qL1JXA1xETB2u7QMYnPb
         5ODSYug0mYWoCtu2k7/LnUoyO8QKGhRwbywtw4mIPprUwAgxMC0TdJXAMhyf5AtBYMc2
         iURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANa3RrA8GQr0AoP/19LhHIjfuWvBcIu4Kb3z3nXIqtc=;
        b=VdRiJ22K/FPXcQiGm+h/ChgYnOWb2f+xEq0BXp7rZXq1s2PIaYry6H5IbSiDgADMWD
         UbhwnXjYCU+SSd1VAa3iYLJEoHRynxzSo4KccuannP8y6WIN2q2kdHOQw1fTLHdWvXJq
         3FTTBlmFAjjjbMxKUotW7NUcdlyOSidr1qaS1UOmfBD3Z54OUvcWO7DH9JrDDXPXJrBg
         68C87tWHWjc/lEn4LzS9FMH4uu4H5S+yZxIz0wAVhQY2gk2H5RB6CfijRfFgBQf4I8H3
         kgkg5DYCmwbF60tosxHAEfypvZEBFctglFosLktjIvWN6bdPXtvf6uAZTRWH7oXgqBwb
         lGDg==
X-Gm-Message-State: AOAM530mPSTyVw6HGYE1RN5cTMOcC6sHnfT9K6CQbMoFzP8tUDe/SCK8
        GyeH6VWw8oC2gD8z1YfarII=
X-Google-Smtp-Source: ABdhPJwQ0jsvbKpZ/nPHup3oWgJuFJjfpY0pyZZeKcAbTFoPpJCEo+httTZOyguCTVAyymZwIrKJNw==
X-Received: by 2002:a02:cac6:: with SMTP id f6mr28031950jap.118.1620759082905;
        Tue, 11 May 2021 11:51:22 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 03/28] dyndbg: split struct _ddebug's display fields to new _ddebug_site
Date:   Tue, 11 May 2021 12:50:32 -0600
Message-Id: <20210511185057.3815777-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Struct _ddebug has 2 kinds of fields: essential & optional/compressible.
Move the 3 optional fields: module, function, file into a new struct
_ddebug_site, and add pointer to it from _ddebug.

These fields are optional in that they are primarily used to generate
the optional "module:func:line" log prefix.  They're also used to
display control, and to select callsites to >control.  lineno is
arguably optional too, but it uses spare bytes in struct _ddebug, so
leaving it is free.

The "__dyndbg" ELF section contains the array of struct _ddebugs for
all the pr-debugs in the kernel/module.  Reuse this pattern for the
new "__dyndbg_sites" section.

The new ptr increases memory footprint, but it is temporary
scaffolding; once we can map from _ddebugs[N] --> _ddebug_sites[N]
indirectly, we can drop site pointer, regaining worst case memory
parity with master.

The indirection gives several advantages:

- site ptr lets us decouple the 2 arrays
  we can properly isolate dependencies by allowing null site

- the moved display fields are inherently hierarchical, and the linker
  section is ordered; so (module, file, function) have repeating
  values (90%, 85%, 45%).  This is readily compressible, even with a
  simple field-wise run length encoding.  Since I'm splitting the struct,
  I also reordered the fields to match the hierarchy.

- the separate linker section sets up naturally for block compression.
  section compression at build time is practical - how ?
  include/linux/decompress/generic.h has no corresponding compression

- we could drop sites and their storage opportunistically.
  this could reduce per-site mem by 24/56.

  Subsystems may not need/want "module:func:line:" in their logs.
  If they already use format-prefixes such as "drm:kms:",
  they can select on those, and don't need the site info for that.
  forex:
  #> echo module drm format "^drm:kms: " +p >control
  ie: dynamic_debug_exec_queries("format '^drm:kms: '", "drm");

Once we can map: ddebugs[N] -> ddebug_sites[N], we can:

- compress __dyndbg_sites during __init, and mark section __initdata
- store the compressed block instead.
- decompress on-demand, stream for `cat control`
- save chunks of decompressed buffer for enabled callsites
- free chunks on site disable, or on memory pressure.

Whats actually done here is ths rather mechanical, and preparatory.

dynamic_debug.h:

I cut struct _ddebug in half, renamed the optional top-half to
_ddebug_site, kept __align(8) for both halves.  I added a forward decl
for a unified comment for both head & body, and added _ddebug.site to
point at body.

DEFINE_DYNAMIC_DEBUG_METADATA now declares and initializes a 2nd
static struct var holding the _ddebug_site, and refs _ddebug to it.

dynamic_debug.c:

dynamic_debug_init() mem-usage now also counts sites.

dynamic_emit_prefix() & ddebug_change() use those moved fields; they
get a new initialized auto-var, and the field refs get adjusted as
needed to follow the field moves from one struct to the other.

   struct _ddebug_site *dc = dp->site;

ddebug_proc_show() differs slightly; it assigns to (not initializes)
the autovar, to avoid a panic when p == SEQ_START_TOKEN.

vmlinux.lds.h:

add __dyndbg_sites section, with the same align(8) and KEEP as
used in the __dyndbg section.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  3 +++
 include/linux/dynamic_debug.h     | 37 +++++++++++++++++---------
 lib/dynamic_debug.c               | 44 ++++++++++++++++++-------------
 3 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0331d5d49551..4f2af9de2f03 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -353,6 +353,9 @@
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
+	__start___dyndbg_sites = .;					\
+	KEEP(*(__dyndbg_sites))					\
+	__stop___dyndbg_sites = .;					\
 	__start___dyndbg = .;						\
 	KEEP(*(__dyndbg))						\
 	__stop___dyndbg = .;						\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..d56c02ed0c45 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -7,20 +7,28 @@
 #endif
 
 /*
- * An instance of this structure is created in a special
- * ELF section at every dynamic debug callsite.  At runtime,
- * the special section is treated as an array of these.
+ * A pair of these structs are created in 2 special ELF sections
+ * (__dyndbg, __dyndbg_sites) for every dynamic debug callsite.
+ * At runtime, the sections are treated as arrays.
  */
-struct _ddebug {
+struct _ddebug;
+struct _ddebug_site {
 	/*
-	 * These fields are used to drive the user interface
-	 * for selecting and displaying debug callsites.
+	 * These fields (and lineno) are used to:
+	 * - decorate log messages per _ddebug.flags
+	 * - select callsites for modification via >control
+	 * - display callsites & settings in `cat control`
 	 */
 	const char *modname;
-	const char *function;
 	const char *filename;
+	const char *function;
+} __aligned(8);
+
+struct _ddebug {
+	struct _ddebug_site *site;
+	/* format is always needed, lineno shares word with flags */
 	const char *format;
-	unsigned int lineno:18;
+	const unsigned lineno:18;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -49,8 +57,7 @@ struct _ddebug {
 		struct static_key_false dd_key_false;
 	} key;
 #endif
-} __attribute__((aligned(8)));
-
+} __aligned(8);
 
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
@@ -88,11 +95,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	static struct _ddebug_site  __aligned(8)		\
+	__section("__dyndbg_sites") name##_site = {		\
 		.modname = KBUILD_MODNAME,			\
-		.function = __func__,				\
 		.filename = __FILE__,				\
+		.function = __func__,				\
+	};							\
+	static struct _ddebug  __aligned(8)			\
+	__section("__dyndbg") name = {				\
+		.site = &name##_site,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3a7d1f9bcf4d..c1c2c90ed944 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -165,19 +165,20 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
+			struct _ddebug_site *dc = dp->site;
 
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
@@ -214,8 +215,8 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			dp->flags = newflags;
 			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dp->filename), dp->lineno,
-				 dt->mod_name, dp->function,
+				 trim_prefix(dc->filename), dp->lineno,
+				 dt->mod_name, dc->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
 		}
 	}
@@ -586,12 +587,13 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
+	const struct _ddebug_site *desc = dp->site;
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -599,15 +601,15 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
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
-				desc->lineno);
+				dp->lineno);
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
@@ -884,6 +886,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
+	struct _ddebug_site *dc;
 	struct flagsbuf flags;
 
 	if (p == SEQ_START_TOKEN) {
@@ -892,9 +895,11 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
+	dc = dp->site;
+
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(dc->filename), dp->lineno,
+		   iter->table->mod_name, dc->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape(m, dp->format, "\t\r\n\"");
 	seq_puts(m, "\"\n");
@@ -1097,17 +1102,17 @@ static int __init dynamic_debug_init(void)
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
@@ -1117,9 +1122,10 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_sites section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+		 (int)(entries * sizeof(struct _ddebug)),
+		 (int)(entries * sizeof(struct _ddebug_site)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.31.1


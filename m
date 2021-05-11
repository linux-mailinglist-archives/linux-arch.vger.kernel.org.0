Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106C537AEC4
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEKSxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhEKSwy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 14:52:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE947C06138A;
        Tue, 11 May 2021 11:51:46 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so18069842ilb.2;
        Tue, 11 May 2021 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmFJIyUaXJT257OL/LmtMVaV16lked49orHA6dOpiLw=;
        b=XRpp9WtoJag16JQlFNYd3Z4dVHrz7VWz/k2R1ZNTPMXy38+H1Rp1iygfzynxNNf6y9
         RcI0C7QVxcOcfqWKLIM7fhQQN06WyIgsHiQwdt9tOIqFzEnPQh3pKC5JIU884IBR7wYu
         MtcoBTyEAHy9SFqqAMShxbCn7sdQjukd2qZAwGPO6Y/+Jj0zZ+MDO/JI2VPbCspmaXk4
         n5iWvrKC7dXHZ8kqmUQfd/ejuxK2Vcfn6dlTLSmpI1AyZ5BXWFO6UlSzGj0XykiTLESx
         WLRZD/db8Ut9PcS/uXO9iBaNNnvhaxOzj/rDo0PnEJPcdXNXvAuhTrwHhollK+kr/Efv
         Ne1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmFJIyUaXJT257OL/LmtMVaV16lked49orHA6dOpiLw=;
        b=QSl/BnvdggYaR2pM5XWzaaOSkAUTDZ+RYsUpVvQ5Ubac5dBgKPtXOC/EKTmQyjyAUv
         0gpnjs8cPlGHsWFqpQnumhbrjmPPOeFUERNrWqi5S/eI9EhR8c1urgfbRE/PA/i/Gvr8
         nrhPp8yRTQTFToeg4x/QT3qdi3EVuNdbAMqAJ6bE6LiOvpyeiQOWv+CGai2CNyQc5rUp
         B+YtvdLZEjN+Qp5iMOalZB3UVbMX9Bdqa+kQPOr8ykaWZYb2gOhHnvvfVBeZp/PY5bE+
         q5tJu2QFRZYbSonGtz8rSeZ3iGcnfDx3fU23DH/aoVonKUNEz/FKEvBvsmc+vlnCcroe
         FMxQ==
X-Gm-Message-State: AOAM532Cj7RnJQrOGPfpdxj3xzDbXOUh2Xqx3bAzxmzhkfzZz4AlZM2g
        Egcg56aRTgpDK4G3t8ryhGE=
X-Google-Smtp-Source: ABdhPJwAIWEWqcGtjz/0v8UZKqFhezkQ4HVghcAKCXOZQSajWCJQ1PG5ZoVf78BE73tfRClYkjyiwA==
X-Received: by 2002:a05:6e02:e0a:: with SMTP id a10mr26327480ilk.271.1620759106391;
        Tue, 11 May 2021 11:51:46 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 18/28] dyndbg: RFC - DEFINE_DYNAMIC_DEBUG_TABLE
Date:   Tue, 11 May 2021 12:50:47 -0600
Message-Id: <20210511185057.3815777-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DEFINE_DYNAMIC_DEBUG_TABLE is based on DEFINE_DYNAMIC_DEBUG_METADATA.
Like its model, it creates/allocates a pair of structs: _ddebug &
_ddebug_site.  It inits them distinctively, so is_dyndbg_header_pair()
macro can verify them.

Its purpose is to reserve a single pair of header records in the front
of the "__dyndbg" & "__dyndbg_sites" sections.  This has several parts;

- the pair of structs are placed into 2 .gnu.linkonce.dyndbg* sections
  corresponding to the 2 dyndbg* sections populated by _METADATA

- vmlinux.lds.h places these 2 new sections into the dyndbg* sections,
  at the start___dyndbg*s.

- the pair has "__used __weak" to qualm compiler concerns.
  explicit externs were problematic with initialization, static decls too.

With this, the header record is now really __dyndbg[0].

Notes:

DYNAMIC_DEBUG is a 'transparent' facility, in that pr_debug() users
get extra features without additional api.  Because of this,
DEFINE_DYNAMIC_DEBUG_TABLE is invoked by dynamic_debug.h on behalf of
all its (indirect) users, including printk.h.

IOW this has wide effects; it results in multiple redundant
declarations of header records, even single object files may get
multiple copies.  Placing these records into .gnu.linkonce. sections
with "__used __weak " seems to resolve the redundancies.  This may
well be the cause of the need for HEAD~1.

In vmlinux-lds.h, I added 2 more KEEPs to place the .gnu.linkonce.*
headers at the front of their respective __dyndbg* sections.  I moved
the __dyndbg lines into a new macro, which maybe should be done as a
separate commit, or in the earlier commit that touched it. RFC.

The headers are really just struct _ddebug*s, they are initialized
distinctively so that they're recogizable by code, using macro
is_dyndbg_header_pair(dbg, dbgsite).

DECLARE_DYNAMIC_DEBUG_TABLE() initializes the header record pairs with
values which are "impossible" for pr_debug()s:

- lineno == 0
- site == iter->site
- modname == function		not possible in proper linkage
- modname == format		not possible in normal linkage
- filename = (void*) iter	forced loopback

Next:

Get __dyndbg[0] from any *dp within __dyndbg[N].  Then with
__dyndbg[0].site, we can get __dyndbg_sites[N].  This is a little
slower than a direct pointer, but this is an unlikely debug path, so
this 'up-N-over-down-N' access is ok.

Eventually we can adapt the header (as a new struct/union) to keep its
pointer to the __dyndbg_sites[] section/block, while allowing us to
drop it from struct _ddebug, regaining memory parity with master.  But
for now, we keep .site, and will soon use it to validate the
'up-N-over-down-N' computation.

For clarity, N is _ddebug._index.  For both builtins & loadable
modules, it is init'd to remember the fixed offset from the beginning
of the section/block/memory-allocation (actual elf sections for *ko's,
and a __start/__stop delineated part of .data for builtins).

N/_index will be used solely to get to __debugs[0] and over to
__debug_sites[N].  It is distinct from a module's numdbgs, which is
used mainly when walking control, and is kept in struct _ddeug_table.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 27 ++++++++++++-------
 include/linux/dynamic_debug.h     | 45 +++++++++++++++++++++++++++++++
 lib/dynamic_debug.c               | 18 ++++++-------
 3 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 4f2af9de2f03..189286405b40 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -335,6 +335,22 @@
 	KEEP(*(.dtb.init.rodata))					\
 	__dtb_end = .;
 
+/* implement dynamic printk debug */
+#if defined(CONFIG_DYNAMIC_DEBUG) || defined(CONFIG_DYNAMIC_DEBUG_CORE)
+#define DYNAMIC_DEBUG_DATA()						\
+	. = ALIGN(8);							\
+	__start___dyndbg_sites = .;					\
+	KEEP(*(.gnu.linkonce.dyndbg_site))				\
+	KEEP(*(__dyndbg_sites))						\
+	__stop___dyndbg_sites = .;					\
+	__start___dyndbg = .;						\
+	KEEP(*(.gnu.linkonce.dyndbg))					\
+	KEEP(*(__dyndbg))						\
+	__stop___dyndbg = .;
+#else
+#define DYNAMIC_DEBUG_DATA()
+#endif
+
 /*
  * .data section
  */
@@ -351,15 +367,8 @@
 	__end_once = .;							\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
-	/* implement dynamic printk debug */				\
-	. = ALIGN(8);							\
-	__start___dyndbg_sites = .;					\
-	KEEP(*(__dyndbg_sites))					\
-	__stop___dyndbg_sites = .;					\
-	__start___dyndbg = .;						\
-	KEEP(*(__dyndbg))						\
-	__stop___dyndbg = .;						\
-	LIKELY_PROFILE()		       				\
+	DYNAMIC_DEBUG_DATA()						\
+	LIKELY_PROFILE()						\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a15e417cbba8..06ae1d8d8c10 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -113,6 +113,43 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		_DPRINTK_KEY_INIT				\
 	}
 
+/*
+ * DEFINE_DYNAMIC_DEBUG_TABLE(): This is a special version of
+ * DEFINE_DYNAMIC_DEBUG_METADATA().  It creates a single pair of
+ * header records, which linker scripts place into __dyndbg[0] &
+ * __dyndbg_sites[0].
+ * To allow a robust runtime test for is_dyndbg_header_pair(I,S),
+ * force-initialize S->filename to point back to I, an otherwize
+ * pathological condition.
+ */
+#define DEFINE_DYNAMIC_DEBUG_TABLE()				\
+	/* forward decl, allowing loopback pointer */		\
+	__weak struct _ddebug __used __aligned(8)		\
+		__section(".gnu.linkonce.dyndbg")		\
+		_LINKONCE_dyndbg_header;			\
+	__weak struct _ddebug_site __used __aligned(8)		\
+		__section(".gnu.linkonce.dyndbg_site")		\
+	_LINKONCE_dyndbg_site_header = {			\
+		.modname = KBUILD_MODNAME,			\
+		.function = KBUILD_MODNAME,			\
+		/* forced pointer loopback, for distinction */	\
+		.filename = (void *) &_LINKONCE_dyndbg_header	\
+	};							\
+	__weak struct _ddebug __used __aligned(8)		\
+		__section(".gnu.linkonce.dyndbg")		\
+	_LINKONCE_dyndbg_header = {				\
+		.site = &_LINKONCE_dyndbg_site_header,		\
+		.format = KBUILD_MODNAME			\
+	}
+
+/* The header initializations as a distinguishing predicate */
+#define is_dyndbg_header_pair(iter, sitep)			\
+	(sitep == iter->site					\
+	 && (!iter->lineno)					\
+	 && (iter->format == sitep->modname)			\
+	 && (sitep->modname == sitep->function)			\
+	 && ((void *)sitep->filename == (void *)iter))
+
 #ifdef CONFIG_JUMP_LABEL
 
 #ifdef DEBUG
@@ -243,4 +280,12 @@ static inline int dynamic_debug_exec_queries(const char *query, const char *modn
 
 #endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
+#if ((defined(CONFIG_DYNAMIC_DEBUG) ||						\
+      (defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE)))	\
+     && defined(KBUILD_MODNAME) && !defined(NO_DYNAMIC_DEBUG_TABLE))
+
+/* transparently invoked, except when -DNO_DYNAMIC_DEBUG_TABLE */
+DEFINE_DYNAMIC_DEBUG_TABLE();
+#endif
+
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c5927b6c1c0c..9d9cb36f40a6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1190,8 +1190,7 @@ static int __init dynamic_debug_init(void)
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
-	int site_ct = 0, entries = 0, modct = 0;
-	int mod_index = 0;
+	int i, site_ct = 0, modct = 0, mod_index = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1207,10 +1206,9 @@ static int __init dynamic_debug_init(void)
 	site = site_mod_start = __start___dyndbg_sites;
 	modname = site->modname;
 
-	for (; iter < __stop___dyndbg; iter++, site++) {
+	for (i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
 
-		BUG_ON(site != iter->site);
-		entries++;
+		WARN_ON(site != iter->site);
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
@@ -1219,10 +1217,12 @@ static int __init dynamic_debug_init(void)
 						  site_ct, mod_index, modname);
 			if (ret)
 				goto out_err;
-			site_ct = 0;
+
 			modname = site->modname;
 			iter_mod_start = iter;
 			site_mod_start = site;
+			mod_index += site_ct;
+			site_ct = 0;
 		}
 		site_ct++;
 	}
@@ -1232,9 +1232,9 @@ static int __init dynamic_debug_init(void)
 
 	ddebug_init_success = 1;
 	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section, %d bytes in __dyndbg_sites section\n",
-		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)),
-		 (int)(entries * sizeof(struct _ddebug_site)));
+		 modct, i, (int)(modct * sizeof(struct ddebug_table)),
+		 (int)(i * sizeof(struct _ddebug)),
+		 (int)(i * sizeof(struct _ddebug_site)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.31.1


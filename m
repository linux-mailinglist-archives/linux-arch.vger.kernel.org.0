Return-Path: <linux-arch+bounces-6330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5991956E71
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E08528205A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5804085D;
	Mon, 19 Aug 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FH3tsRql"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D236130
	for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080521; cv=none; b=Fs4bdB5P3PXK19wTl+b7sULCaL31sbAS8BWUS/PCU0ALovZ61ivVNHfvVIAxgdoADciFBAOrHG7iV3x3NVdOZpyD/FvucOeqLrxfr2F9y3YsKvrONb8fjPmsGHTzo2hm8l9BbLdJ0nrHKoCI7kqjbYaWxE/sdvRx6FE9HkDExKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080521; c=relaxed/simple;
	bh=O4WkhD1fNis7ifQN1+DMez2up2B7ham28U2MicuNKig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3seUch2pJDYX3pwotBF92E1hXTmMHGXmDQAooqWM3zxb54HCxQ6fOk2Uol0ZYL6f+Vgod9BcSgJ1kWmPnj/1je8FhHWV7+lzWjYs1CgsiVMqDM+7Ant/n1Us8nDCGXeHwtewgp6pGP0vpxlrpGtuZnLuTAO9QzuYp9xPBaxrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FH3tsRql; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b8f13f2965so23234867b3.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080517; x=1724685317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vP5Y3+St8DLMnl+ojNb4BcLnBgri+HpVXEz96Xrg0no=;
        b=FH3tsRqlG8oIJPRvrIgO3tn1eL8N/A4o4D4fnXQSvGTv+mE//2gnvx5qsUlPB46CzP
         pTSvUQnv8vs/NAe/epJIZ2WCyTig8n0OhBykccy5ylV16OZiStbttE1D64BaNJKyywY8
         msdYKwVjIv1qHxqrlrlPFWsE2G4x1ACNwx6qvYRqFV/wIhDDi9zNYuC029pWBDX1pze0
         +DBMh46h6/pbN23pg0dHQp1OG2JXaPfLHW8+CXVOuSG2oSPeyyvqeqFnAzl3j4B05tRN
         fkvncEWNMOX8UEyjTCOqj2ocaZWb1M2Lrcihs4Sam+vN8ztbFT1ofIjIBsrlPoL8q1LP
         kEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080517; x=1724685317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP5Y3+St8DLMnl+ojNb4BcLnBgri+HpVXEz96Xrg0no=;
        b=TQJvcfDV5vY3K+i7RuE7Wj9GEv403G2MzZSw5hmhrG39CI7jUy/dsMTRnZu6ujoIc7
         FSlmevnki0xyZWCMfPTOiAU1EKpTllU4YDcvwuRN1ibUNrEo6kHXgM+Rjef5wB6ej6Wt
         s+TokbUH0ZmwMVoOijwyGZ8+83n1OB/y6zwpvBzYGx0MhO3X8GP3+u6YPoUn0/opZ3lQ
         0/dS+DxaEv4soUdi3UfZZeeioPfMZUKZmujwmDbf7yOj28u+gXlSDEbilHgr3wvHTawc
         kh4tIYY0PgtbK3OmBffzNwKK6hOE4cWmxItPOd38QcwrmSY9RRt/jRaTPlWCLSHeyA4T
         RS+w==
X-Forwarded-Encrypted: i=1; AJvYcCV71Hu1RVwRhcRSLTuiRihAPRfprb+1yP4i5qC8v86wsXVle7G1zpxGe9hLIWH1dBGMrj+b/PBxMa6ucEGPV77D8i7ba/+povJouw==
X-Gm-Message-State: AOJu0YxW+fYohsXAF4KkrAXEtP8U7WcNI03ggxxLRWk+kDVz6krp7Kz4
	6kRTItURu0py9w2DTtyAT8UvfogrxuUvgyopIdXvoegQzfVibs4TQyufl9R1//N6GP6FSkMCz1U
	C1w==
X-Google-Smtp-Source: AGHT+IHIzYk9Q273USL5AsYZzJs11m0hcVvSOdyFJga9/z80thJTPdIa+orVuheupXR2PsXCT+j74zPGSXM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5aea:cf26:50f4:76db])
 (user=surenb job=sendgmr) by 2002:a25:ec0a:0:b0:e11:5b8c:f9c with SMTP id
 3f1490d57ef6-e1180bb40a8mr216454276.0.1724080517086; Mon, 19 Aug 2024
 08:15:17 -0700 (PDT)
Date: Mon, 19 Aug 2024 08:15:07 -0700
In-Reply-To: <20240819151512.2363698-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819151512.2363698-2-surenb@google.com>
Subject: [PATCH 1/5] alloc_tag: load module tags into separate continuous memory
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

When a module gets unloaded there is a possibility that some of the
allocations it made are still used and therefore the allocation tags
corresponding to these allocations are still referenced. As such, the
memory for these tags can't be freed. This is currently handled as an
abnormal situation and module's data section is not being unloaded.
To handle this situation without keeping module's data in memory,
allow codetags with longer lifespan than the module to be loaded into
their own separate memory. The in-use memory areas and gaps after
module unloading in this separate memory are tracked using maple trees.
Allocation tags arrange their separate memory so that it is virtually
contiguous and that will allow simple allocation tag indexing later on
in this patchset. The size of this virtually contiguous memory is set
to store up to 100000 allocation tags and max_module_alloc_tags kernel
parameter is introduced to change this size.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 include/asm-generic/codetag.lds.h             |  19 ++
 include/linux/alloc_tag.h                     |  13 +-
 include/linux/codetag.h                       |  35 ++-
 kernel/module/main.c                          |  67 +++--
 lib/alloc_tag.c                               | 245 ++++++++++++++++--
 lib/codetag.c                                 | 101 +++++++-
 scripts/module.lds.S                          |   5 +-
 8 files changed, 429 insertions(+), 60 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d0d141d50638..17f9f811a9c0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3205,6 +3205,10 @@
 			devices can be requested on-demand with the
 			/dev/loop-control interface.
 
+
+	max_module_alloc_tags=	[KNL] Max supported number of allocation tags
+			in modules.
+
 	mce		[X86-32] Machine Check Exception
 
 	mce=option	[X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index 64f536b80380..372c320c5043 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -11,4 +11,23 @@
 #define CODETAG_SECTIONS()		\
 	SECTION_WITH_BOUNDARIES(alloc_tags)
 
+/*
+ * Module codetags which aren't used after module unload, therefore have the
+ * same lifespan as the module and can be safely unloaded with the module.
+ */
+#define MOD_CODETAG_SECTIONS()
+
+#define MOD_SEPARATE_CODETAG_SECTION(_name)	\
+	.codetag.##_name : {			\
+		SECTION_WITH_BOUNDARIES(_name)	\
+	}
+
+/*
+ * For codetags which might be used after module unload, therefore might stay
+ * longer in memory. Each such codetag type has its own section so that we can
+ * unload them individually once unused.
+ */
+#define MOD_SEPARATE_CODETAG_SECTIONS()		\
+	MOD_SEPARATE_CODETAG_SECTION(alloc_tags)
+
 #endif /* __ASM_GENERIC_CODETAG_LDS_H */
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 8c61ccd161ba..99cbc7f086ad 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -30,6 +30,13 @@ struct alloc_tag {
 	struct alloc_tag_counters __percpu	*counters;
 } __aligned(8);
 
+struct alloc_tag_module_section {
+	unsigned long start_addr;
+	unsigned long end_addr;
+	/* used size */
+	unsigned long size;
+};
+
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
 
 #define CODETAG_EMPTY	((void *)1)
@@ -54,6 +61,8 @@ static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
+#define ALLOC_TAG_SECTION_NAME	"alloc_tags"
+
 struct codetag_bytes {
 	struct codetag *ct;
 	s64 bytes;
@@ -76,7 +85,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 
 #define DEFINE_ALLOC_TAG(_alloc_tag)						\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
-	__section("alloc_tags") = {						\
+	__section(ALLOC_TAG_SECTION_NAME) = {					\
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_shared_alloc_tag };
 
@@ -85,7 +94,7 @@ DECLARE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 #define DEFINE_ALLOC_TAG(_alloc_tag)						\
 	static DEFINE_PER_CPU(struct alloc_tag_counters, _alloc_tag_cntr);	\
 	static struct alloc_tag _alloc_tag __used __aligned(8)			\
-	__section("alloc_tags") = {						\
+	__section(ALLOC_TAG_SECTION_NAME) = {					\
 		.ct = CODE_TAG_INIT,						\
 		.counters = &_alloc_tag_cntr };
 
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index c2a579ccd455..c4a3dd60205e 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -35,8 +35,13 @@ struct codetag_type_desc {
 	size_t tag_size;
 	void (*module_load)(struct codetag_type *cttype,
 			    struct codetag_module *cmod);
-	bool (*module_unload)(struct codetag_type *cttype,
+	void (*module_unload)(struct codetag_type *cttype,
 			      struct codetag_module *cmod);
+	void (*module_replaced)(struct module *mod, struct module *new_mod);
+	bool (*needs_section_mem)(struct module *mod, unsigned long size);
+	void *(*alloc_section_mem)(struct module *mod, unsigned long size,
+				   unsigned int prepend, unsigned long align);
+	void (*free_section_mem)(struct module *mod, bool unused);
 };
 
 struct codetag_iterator {
@@ -71,11 +76,31 @@ struct codetag_type *
 codetag_register_type(const struct codetag_type_desc *desc);
 
 #if defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES)
+
+bool codetag_needs_module_section(struct module *mod, const char *name,
+				  unsigned long size);
+void *codetag_alloc_module_section(struct module *mod, const char *name,
+				   unsigned long size, unsigned int prepend,
+				   unsigned long align);
+void codetag_free_module_sections(struct module *mod);
+void codetag_module_replaced(struct module *mod, struct module *new_mod);
 void codetag_load_module(struct module *mod);
-bool codetag_unload_module(struct module *mod);
-#else
+void codetag_unload_module(struct module *mod);
+
+#else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
+
+static inline bool
+codetag_needs_module_section(struct module *mod, const char *name,
+			     unsigned long size) { return false; }
+static inline void *
+codetag_alloc_module_section(struct module *mod, const char *name,
+			     unsigned long size, unsigned int prepend,
+			     unsigned long align) { return NULL; }
+static inline void codetag_free_module_sections(struct module *mod) {}
+static inline void codetag_module_replaced(struct module *mod, struct module *new_mod) {}
 static inline void codetag_load_module(struct module *mod) {}
-static inline bool codetag_unload_module(struct module *mod) { return true; }
-#endif
+static inline void codetag_unload_module(struct module *mod) {}
+
+#endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
 
 #endif /* _LINUX_CODETAG_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 71396e297499..d195d788835c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1225,18 +1225,12 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	return 0;
 }
 
-static void module_memory_free(struct module *mod, enum mod_mem_type type,
-			       bool unload_codetags)
+static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
-	void *ptr = mod->mem[type].base;
-
-	if (!unload_codetags && mod_mem_type_is_core_data(type))
-		return;
-
-	execmem_free(ptr);
+	execmem_free(mod->mem[type].base);
 }
 
-static void free_mod_mem(struct module *mod, bool unload_codetags)
+static void free_mod_mem(struct module *mod)
 {
 	for_each_mod_mem_type(type) {
 		struct module_memory *mod_mem = &mod->mem[type];
@@ -1247,25 +1241,20 @@ static void free_mod_mem(struct module *mod, bool unload_codetags)
 		/* Free lock-classes; relies on the preceding sync_rcu(). */
 		lockdep_free_key_range(mod_mem->base, mod_mem->size);
 		if (mod_mem->size)
-			module_memory_free(mod, type, unload_codetags);
+			module_memory_free(mod, type);
 	}
 
 	/* MOD_DATA hosts mod, so free it at last */
 	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
-	module_memory_free(mod, MOD_DATA, unload_codetags);
+	module_memory_free(mod, MOD_DATA);
 }
 
 /* Free a module, remove from lists, etc. */
 static void free_module(struct module *mod)
 {
-	bool unload_codetags;
-
 	trace_module_free(mod);
 
-	unload_codetags = codetag_unload_module(mod);
-	if (!unload_codetags)
-		pr_warn("%s: memory allocation(s) from the module still alive, cannot unload cleanly\n",
-			mod->name);
+	codetag_unload_module(mod);
 
 	mod_sysfs_teardown(mod);
 
@@ -1308,7 +1297,7 @@ static void free_module(struct module *mod)
 	kfree(mod->args);
 	percpu_modfree(mod);
 
-	free_mod_mem(mod, unload_codetags);
+	free_mod_mem(mod);
 }
 
 void *__symbol_get(const char *symbol)
@@ -1573,6 +1562,14 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 			if (WARN_ON_ONCE(type == MOD_INVALID))
 				continue;
 
+			/*
+			 * Do not allocate codetag memory as we load it into
+			 * preallocated contiguous memory. s->sh_entsize will
+			 * not be used for this section, so leave it as is.
+			 */
+			if (codetag_needs_module_section(mod, sname, s->sh_size))
+				continue;
+
 			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
 			pr_debug("\t%s\n", sname);
 		}
@@ -2247,6 +2244,7 @@ static int move_module(struct module *mod, struct load_info *info)
 	int i;
 	enum mod_mem_type t = 0;
 	int ret = -ENOMEM;
+	bool codetag_section_found = false;
 
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
@@ -2257,7 +2255,7 @@ static int move_module(struct module *mod, struct load_info *info)
 		ret = module_memory_alloc(mod, type);
 		if (ret) {
 			t = type;
-			goto out_enomem;
+			goto out_err;
 		}
 	}
 
@@ -2267,11 +2265,27 @@ static int move_module(struct module *mod, struct load_info *info)
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
 		enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
+		const char *sname;
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
 
-		dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
+		sname = info->secstrings + shdr->sh_name;
+		/*
+		 * Load codetag sections separately as they might still be used
+		 * after module unload.
+		 */
+		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
+			dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
+					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
+			if (IS_ERR(dest)) {
+				ret = PTR_ERR(dest);
+				goto out_err;
+			}
+			codetag_section_found = true;
+		} else {
+			dest = mod->mem[type].base + (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
+		}
 
 		if (shdr->sh_type != SHT_NOBITS) {
 			/*
@@ -2283,7 +2297,7 @@ static int move_module(struct module *mod, struct load_info *info)
 			if (i == info->index.mod &&
 			   (WARN_ON_ONCE(shdr->sh_size != sizeof(struct module)))) {
 				ret = -ENOEXEC;
-				goto out_enomem;
+				goto out_err;
 			}
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
 		}
@@ -2299,9 +2313,12 @@ static int move_module(struct module *mod, struct load_info *info)
 	}
 
 	return 0;
-out_enomem:
+out_err:
 	for (t--; t >= 0; t--)
-		module_memory_free(mod, t, true);
+		module_memory_free(mod, t);
+	if (codetag_section_found)
+		codetag_free_module_sections(mod);
+
 	return ret;
 }
 
@@ -2422,6 +2439,8 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
 	kmemleak_load_module(mod, info);
+	codetag_module_replaced(info->mod, mod);
+
 	return mod;
 }
 
@@ -2431,7 +2450,7 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 	percpu_modfree(mod);
 	module_arch_freeing_init(mod);
 
-	free_mod_mem(mod, true);
+	free_mod_mem(mod);
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 81e5f9a70f22..f33784f48dd2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/alloc_tag.h>
+#include <linux/execmem.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -9,6 +10,12 @@
 #include <linux/seq_file.h>
 
 static struct codetag_type *alloc_tag_cttype;
+static struct alloc_tag_module_section module_tags;
+static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
+/* A dummy object used to indicate an unloaded module */
+static struct module unloaded_mod;
+/* A dummy object used to indicate a module prepended area */
+static struct module prepend_mod;
 
 DEFINE_PER_CPU(struct alloc_tag_counters, _shared_alloc_tag);
 EXPORT_SYMBOL(_shared_alloc_tag);
@@ -149,29 +156,198 @@ static void __init procfs_init(void)
 	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
-static bool alloc_tag_module_unload(struct codetag_type *cttype,
-				    struct codetag_module *cmod)
+static bool needs_section_mem(struct module *mod, unsigned long size)
 {
-	struct codetag_iterator iter = codetag_get_ct_iter(cttype);
-	struct alloc_tag_counters counter;
-	bool module_unused = true;
-	struct alloc_tag *tag;
-	struct codetag *ct;
+	return size >= sizeof(struct alloc_tag);
+}
+
+/* Called under RCU read lock */
+static void clean_unused_module_areas(void)
+{
+	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
+	struct module *val;
+
+	mas_for_each(&mas, val, module_tags.size) {
+		if (val == &unloaded_mod) {
+			struct alloc_tag *tag;
+			struct alloc_tag *last;
+			bool unused = true;
+
+			tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
+			last = (struct alloc_tag *)(module_tags.start_addr + mas.last);
+			while (tag <= last) {
+				struct alloc_tag_counters counter;
+
+				counter = alloc_tag_read(tag);
+				if (counter.bytes) {
+					unused = false;
+					break;
+				}
+				tag++;
+			}
+			if (unused) {
+				mtree_store_range(&mod_area_mt, mas.index,
+						  mas.last, NULL, GFP_KERNEL);
+			}
+		}
+	}
+}
+
+static void *reserve_module_tags(struct module *mod, unsigned long size,
+				 unsigned int prepend, unsigned long align)
+{
+	unsigned long section_size = module_tags.end_addr - module_tags.start_addr;
+	MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
+	bool cleanup_done = false;
+	unsigned long offset;
+	void *ret;
+
+	/* If no tags return NULL */
+	if (size < sizeof(struct alloc_tag))
+		return NULL;
+
+	/*
+	 * align is always power of 2, so we can use IS_ALIGNED and ALIGN.
+	 * align 0 or 1 means no alignment, to simplify set to 1.
+	 */
+	if (!align)
+		align = 1;
+
+	rcu_read_lock();
+repeat:
+	/* Try finding exact size and hope the start is aligned */
+	if (mas_empty_area(&mas, 0, section_size - 1, prepend + size))
+		goto cleanup;
+
+	if (IS_ALIGNED(mas.index + prepend, align))
+		goto found;
+
+	/* Try finding larger area to align later */
+	mas_reset(&mas);
+	if (!mas_empty_area(&mas, 0, section_size - 1,
+			    size + prepend + align - 1))
+		goto found;
+
+cleanup:
+	/* No free area, try cleanup stale data and repeat the search once */
+	if (!cleanup_done) {
+		clean_unused_module_areas();
+		cleanup_done = true;
+		mas_reset(&mas);
+		goto repeat;
+	} else {
+		ret = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+found:
+	offset = mas.index;
+	offset += prepend;
+	offset = ALIGN(offset, align);
+
+	if (mtree_insert_range(&mod_area_mt, offset, offset + size - 1, mod,
+			       GFP_KERNEL)) {
+		ret = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	if (offset != mas.index) {
+		if (mtree_insert_range(&mod_area_mt, mas.index, offset - 1,
+				       &prepend_mod, GFP_KERNEL)) {
+			mtree_store_range(&mod_area_mt, offset, offset + size - 1,
+					  NULL, GFP_KERNEL);
+			ret = ERR_PTR(-ENOMEM);
+			goto out;
+		}
+	}
+
+	if (module_tags.size < offset + size)
+		module_tags.size = offset + size;
+
+	ret = (struct alloc_tag *)(module_tags.start_addr + offset);
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static void release_module_tags(struct module *mod, bool unused)
+{
+	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
+	unsigned long padding_start;
+	bool padding_found = false;
+	struct module *val;
+
+	if (unused)
+		return;
+
+	unused = true;
+	rcu_read_lock();
+	mas_for_each(&mas, val, module_tags.size) {
+		struct alloc_tag *tag;
+		struct alloc_tag *last;
+
+		if (val == &prepend_mod) {
+			padding_start = mas.index;
+			padding_found = true;
+			continue;
+		}
 
-	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
-		if (iter.cmod != cmod)
+		if (val != mod) {
+			padding_found = false;
 			continue;
+		}
+
+		tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
+		last = (struct alloc_tag *)(module_tags.start_addr + mas.last);
+		while (tag <= last) {
+			struct alloc_tag_counters counter;
+
+			counter = alloc_tag_read(tag);
+			if (counter.bytes) {
+				struct codetag *ct = &tag->ct;
 
-		tag = ct_to_alloc_tag(ct);
-		counter = alloc_tag_read(tag);
+				pr_info("%s:%u module %s func:%s has %llu allocated at module unload\n",
+					ct->filename, ct->lineno, ct->modname,
+					ct->function, counter.bytes);
+				unused = false;
+				break;
+			}
+			tag++;
+		}
+		if (unused) {
+			mtree_store_range(&mod_area_mt,
+					  padding_found ? padding_start : mas.index,
+					  mas.last, NULL, GFP_KERNEL);
+		} else {
+			/* Release the padding and mark the module unloaded */
+			if (padding_found)
+				mtree_store_range(&mod_area_mt, padding_start,
+						  mas.index - 1, NULL, GFP_KERNEL);
+			mtree_store_range(&mod_area_mt, mas.index, mas.last,
+					  &unloaded_mod, GFP_KERNEL);
+		}
 
-		if (WARN(counter.bytes,
-			 "%s:%u module %s func:%s has %llu allocated at module unload",
-			 ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
-			module_unused = false;
+		break;
 	}
+	rcu_read_unlock();
+}
+
+static void replace_module(struct module *mod, struct module *new_mod)
+{
+	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
+	struct module *val;
 
-	return module_unused;
+	rcu_read_lock();
+	mas_for_each(&mas, val, module_tags.size) {
+		if (val != mod)
+			continue;
+
+		mtree_store_range(&mod_area_mt, mas.index, mas.last,
+				  new_mod, GFP_KERNEL);
+		break;
+	}
+	rcu_read_unlock();
 }
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
@@ -252,17 +428,46 @@ static void __init sysctl_init(void)
 static inline void sysctl_init(void) {}
 #endif /* CONFIG_SYSCTL */
 
+static unsigned long max_module_alloc_tags __initdata = 100000;
+
+static int __init set_max_module_alloc_tags(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	return kstrtoul(arg, 0, &max_module_alloc_tags);
+}
+early_param("max_module_alloc_tags", set_max_module_alloc_tags);
+
 static int __init alloc_tag_init(void)
 {
 	const struct codetag_type_desc desc = {
-		.section	= "alloc_tags",
-		.tag_size	= sizeof(struct alloc_tag),
-		.module_unload	= alloc_tag_module_unload,
+		.section		= ALLOC_TAG_SECTION_NAME,
+		.tag_size		= sizeof(struct alloc_tag),
+		.needs_section_mem	= needs_section_mem,
+		.alloc_section_mem	= reserve_module_tags,
+		.free_section_mem	= release_module_tags,
+		.module_replaced	= replace_module,
 	};
+	unsigned long module_tags_mem_sz;
 
+	module_tags_mem_sz = max_module_alloc_tags * sizeof(struct alloc_tag);
+	pr_info("%lu bytes reserved for module allocation tags\n", module_tags_mem_sz);
+
+	/* Allocate space to copy allocation tags */
+	module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
+							      module_tags_mem_sz);
+	if (!module_tags.start_addr)
+		return -ENOMEM;
+
+	module_tags.end_addr = module_tags.start_addr + module_tags_mem_sz;
+	mt_set_in_rcu(&mod_area_mt);
 	alloc_tag_cttype = codetag_register_type(&desc);
-	if (IS_ERR(alloc_tag_cttype))
+	if (IS_ERR(alloc_tag_cttype)) {
+		execmem_free((void *)module_tags.start_addr);
+		module_tags.start_addr = 0;
 		return PTR_ERR(alloc_tag_cttype);
+	}
 
 	sysctl_init();
 	procfs_init();
diff --git a/lib/codetag.c b/lib/codetag.c
index 5ace625f2328..d602a81bdc03 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -126,6 +126,7 @@ static inline size_t range_size(const struct codetag_type *cttype,
 }
 
 #ifdef CONFIG_MODULES
+
 static void *get_symbol(struct module *mod, const char *prefix, const char *name)
 {
 	DECLARE_SEQ_BUF(sb, KSYM_NAME_LEN);
@@ -155,6 +156,94 @@ static struct codetag_range get_section_range(struct module *mod,
 	};
 }
 
+#define CODETAG_SECTION_PREFIX	".codetag."
+
+/* Some codetag types need a separate module section */
+bool codetag_needs_module_section(struct module *mod, const char *name,
+				  unsigned long size)
+{
+	const char *type_name;
+	struct codetag_type *cttype;
+	bool ret = false;
+
+	if (strncmp(name, CODETAG_SECTION_PREFIX, strlen(CODETAG_SECTION_PREFIX)))
+		return false;
+
+	type_name = name + strlen(CODETAG_SECTION_PREFIX);
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		if (strcmp(type_name, cttype->desc.section) == 0) {
+			if (!cttype->desc.needs_section_mem)
+				break;
+
+			down_write(&cttype->mod_lock);
+			ret = cttype->desc.needs_section_mem(mod, size);
+			up_write(&cttype->mod_lock);
+			break;
+		}
+	}
+	mutex_unlock(&codetag_lock);
+
+	return ret;
+}
+
+void *codetag_alloc_module_section(struct module *mod, const char *name,
+				   unsigned long size, unsigned int prepend,
+				   unsigned long align)
+{
+	const char *type_name = name + strlen(CODETAG_SECTION_PREFIX);
+	struct codetag_type *cttype;
+	void *ret = NULL;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		if (strcmp(type_name, cttype->desc.section) == 0) {
+			if (WARN_ON(!cttype->desc.alloc_section_mem))
+				break;
+
+			down_write(&cttype->mod_lock);
+			ret = cttype->desc.alloc_section_mem(mod, size, prepend, align);
+			up_write(&cttype->mod_lock);
+			break;
+		}
+	}
+	mutex_unlock(&codetag_lock);
+
+	return ret;
+}
+
+void codetag_free_module_sections(struct module *mod)
+{
+	struct codetag_type *cttype;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		if (!cttype->desc.free_section_mem)
+			continue;
+
+		down_write(&cttype->mod_lock);
+		cttype->desc.free_section_mem(mod, true);
+		up_write(&cttype->mod_lock);
+	}
+	mutex_unlock(&codetag_lock);
+}
+
+void codetag_module_replaced(struct module *mod, struct module *new_mod)
+{
+	struct codetag_type *cttype;
+
+	mutex_lock(&codetag_lock);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		if (!cttype->desc.module_replaced)
+			continue;
+
+		down_write(&cttype->mod_lock);
+		cttype->desc.module_replaced(mod, new_mod);
+		up_write(&cttype->mod_lock);
+	}
+	mutex_unlock(&codetag_lock);
+}
+
 static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 {
 	struct codetag_range range;
@@ -212,13 +301,12 @@ void codetag_load_module(struct module *mod)
 	mutex_unlock(&codetag_lock);
 }
 
-bool codetag_unload_module(struct module *mod)
+void codetag_unload_module(struct module *mod)
 {
 	struct codetag_type *cttype;
-	bool unload_ok = true;
 
 	if (!mod)
-		return true;
+		return;
 
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
@@ -235,18 +323,17 @@ bool codetag_unload_module(struct module *mod)
 		}
 		if (found) {
 			if (cttype->desc.module_unload)
-				if (!cttype->desc.module_unload(cttype, cmod))
-					unload_ok = false;
+				cttype->desc.module_unload(cttype, cmod);
 
 			cttype->count -= range_size(cttype, &cmod->range);
 			idr_remove(&cttype->mod_idr, mod_id);
 			kfree(cmod);
 		}
 		up_write(&cttype->mod_lock);
+		if (found && cttype->desc.free_section_mem)
+			cttype->desc.free_section_mem(mod, false);
 	}
 	mutex_unlock(&codetag_lock);
-
-	return unload_ok;
 }
 
 #else /* CONFIG_MODULES */
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 3f43edef813c..711c6e029936 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -50,7 +50,7 @@ SECTIONS {
 	.data : {
 		*(.data .data.[0-9a-zA-Z_]*)
 		*(.data..L*)
-		CODETAG_SECTIONS()
+		MOD_CODETAG_SECTIONS()
 	}
 
 	.rodata : {
@@ -59,9 +59,10 @@ SECTIONS {
 	}
 #else
 	.data : {
-		CODETAG_SECTIONS()
+		MOD_CODETAG_SECTIONS()
 	}
 #endif
+	MOD_SEPARATE_CODETAG_SECTIONS()
 }
 
 /* bring in arch-specific sections */
-- 
2.46.0.184.g6999bdac58-goog



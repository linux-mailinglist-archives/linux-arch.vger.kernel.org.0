Return-Path: <linux-arch+bounces-6888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE6967E8C
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 06:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C3B21512
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 04:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8C2154C07;
	Mon,  2 Sep 2024 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAD/66HA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69730152196
	for <linux-arch@vger.kernel.org>; Mon,  2 Sep 2024 04:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725252099; cv=none; b=XIedwBB+t7ejtqywUTQZFMC6GbtW3fI6EndEKz0JPDQuK08ogeeSZW9avxm0ZeNfn2hO7i6AYJ6Ao21oDmbnIA+e+tQf4kydiK8GGMIlX6i09xmPi3zDcC1eBGcuMi0wbzb2RihV3lJRKpDbeqQmiGids2ih4RgnCSIL/J3597w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725252099; c=relaxed/simple;
	bh=lOxkgf8EnbY8t+TCKSnY1dPXjKXs2qlyAArAYfs10Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fzfyzhf60g2KgIiJj17sxGZGb8MyGilVdaRiamEVzmnpR4KItxX9w+ZZrp3TVUHzsWNNW+F3tgid8fTQrY+oe4Bk8CXFf1bWuEByK5vwEBjuz/WlonkxtA8Rclqb7Ixn2Gi4ugDnYIbF6Dh3ypNeuj2heLq1LX1wjMa4MCteSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAD/66HA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b41e02c293so79581267b3.0
        for <linux-arch@vger.kernel.org>; Sun, 01 Sep 2024 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725252096; x=1725856896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dp4HLFsSdaCRLqkUULTSVafVtTTe/LDKPcvkJXQF4Ug=;
        b=KAD/66HAA1fZ10r6acv6HcDBc4WQn9Fu8XxfRCDmIW9vh2rkfC/2CO2kmybhxaOoUM
         OLRx2ttDBDyp5ChJgCeDai8oKTPg95L148puV4/Ny+SJr2SzQh8p8aJA3/lmBQn2oy8D
         aTLOcX4DFvA8HiAtvNJ/tzO9ZVjhT+vcOIPCegG7HhLtUUT4wEetnz2OjxIDpA1oC9Yd
         Oj0vbnycBBZAKKq6paVVMNaL5HmURIMZ3yh2gWRbs8yE9xuzI1H5FOJqdb8PGgw8gh+d
         Nw6M71FOz311MBLpvfcR8X37ZD4dYtNd5btyW8Zr3V56BjsBSGlKEiEGgzAygyeF/Von
         UvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725252096; x=1725856896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dp4HLFsSdaCRLqkUULTSVafVtTTe/LDKPcvkJXQF4Ug=;
        b=ZpiYavnHZNc7YjKHS4OvP9kefSsuhOeJNO+G3QZLu9DllGMFUW3/k3vr17C8kjzOJW
         79poxaL/UfxvAJaCF9UhKmyD7ltUbok7t958jGE2rCJZX2KfjGtbCovWRfJT72idX1f+
         el3Ut3cUNpJVBvmPTWbY084ELn08TOaYf+WpS5sgT9xjnvG96bNILk8jZdX5RWzf3kWR
         kjRCiMVQEXt1TdSW0qqeyyiZishYUZFoSWHnpMLc7UvGEEPD8luBB/1sSSbkZCbyT1VB
         KdU4fxsOygjP8sxcOzqJ3OLFnVsHtAj7Ts90sXLHisHWAYA7si+8a02R0+5/y2wK/Dcr
         Tk3A==
X-Forwarded-Encrypted: i=1; AJvYcCUA4nQQLnBlF+fDTJ6DJ8ulPVf08+c/kEz7fDkVs1S54A2/72l5i/aY0mc70CKJJ70HG6x55Kmd8swA@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjgLHJo0Bjbjx5k0PWuBV27bNgVSYscHB1njOR3WvoxgtUW4P
	4u2tsSGKGiysd62KsRJX9kjd72VTOM2MSE8QNIBwmXD33CfGAPHw3YerywmYgKKnGRGhqXeUfzr
	/8w==
X-Google-Smtp-Source: AGHT+IEB96AfQMtGaWG34HjG3YUsNj+jjgM1XA7e+3hjtS0U7EuT1s7DnlwBcK3PHwYEM5jDMTEBB/kupyA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7343:ecd2:aed:5b8f])
 (user=surenb job=sendgmr) by 2002:a05:690c:3386:b0:68d:52a1:bed with SMTP id
 00721157ae682-6d40d88f6eemr5995947b3.1.1725252096434; Sun, 01 Sep 2024
 21:41:36 -0700 (PDT)
Date: Sun,  1 Sep 2024 21:41:24 -0700
In-Reply-To: <20240902044128.664075-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240902044128.664075-3-surenb@google.com>
Subject: [PATCH v2 2/6] alloc_tag: load module tags into separate continuous memory
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
 include/linux/codetag.h                       |  37 ++-
 kernel/module/main.c                          |  67 +++--
 lib/alloc_tag.c                               | 265 ++++++++++++++++--
 lib/codetag.c                                 | 100 ++++++-
 scripts/module.lds.S                          |   5 +-
 8 files changed, 451 insertions(+), 59 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8dd0aefea01e..991b1c9ecf0e 100644
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
index c2a579ccd455..fb4e7adfa746 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -35,8 +35,15 @@ struct codetag_type_desc {
 	size_t tag_size;
 	void (*module_load)(struct codetag_type *cttype,
 			    struct codetag_module *cmod);
-	bool (*module_unload)(struct codetag_type *cttype,
+	void (*module_unload)(struct codetag_type *cttype,
 			      struct codetag_module *cmod);
+#ifdef CONFIG_MODULES
+	void (*module_replaced)(struct module *mod, struct module *new_mod);
+	bool (*needs_section_mem)(struct module *mod, unsigned long size);
+	void *(*alloc_section_mem)(struct module *mod, unsigned long size,
+				   unsigned int prepend, unsigned long align);
+	void (*free_section_mem)(struct module *mod, bool unused);
+#endif
 };
 
 struct codetag_iterator {
@@ -71,11 +78,31 @@ struct codetag_type *
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
index 81e5f9a70f22..19ef02a18611 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/alloc_tag.h>
+#include <linux/execmem.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -149,30 +150,244 @@ static void __init procfs_init(void)
 	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
-static bool alloc_tag_module_unload(struct codetag_type *cttype,
-				    struct codetag_module *cmod)
+#ifdef CONFIG_MODULES
+
+static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
+/* A dummy object used to indicate an unloaded module */
+static struct module unloaded_mod;
+/* A dummy object used to indicate a module prepended area */
+static struct module prepend_mod;
+
+static struct alloc_tag_module_section module_tags;
+
+static bool needs_section_mem(struct module *mod, unsigned long size)
 {
-	struct codetag_iterator iter = codetag_get_ct_iter(cttype);
-	struct alloc_tag_counters counter;
-	bool module_unused = true;
+	return size >= sizeof(struct alloc_tag);
+}
+
+/* Called under RCU read lock */
+static void clean_unused_module_areas_locked(void)
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
+			if (unused)
+				mas_erase(&mas);
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
+	mas_lock(&mas);
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
+		clean_unused_module_areas_locked();
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
+	if (offset != mas.index) {
+		unsigned long pad_start = mas.index;
+
+		mas.last = offset - 1;
+		mas_store(&mas, &prepend_mod);
+		if (mas_is_err(&mas)) {
+			ret = ERR_PTR(xa_err(mas.node));
+			goto out;
+		}
+		mas.index = offset;
+		mas.last = offset + size - 1;
+		mas_store(&mas, mod);
+		if (mas_is_err(&mas)) {
+			ret = ERR_PTR(xa_err(mas.node));
+			mas.index = pad_start;
+			mas_erase(&mas);
+			goto out;
+		}
+
+	} else {
+		mas.last = offset + size - 1;
+		mas_store(&mas, mod);
+		if (mas_is_err(&mas)) {
+			ret = ERR_PTR(xa_err(mas.node));
+			goto out;
+		}
+	}
+
+	if (module_tags.size < offset + size)
+		module_tags.size = offset + size;
+
+	ret = (struct alloc_tag *)(module_tags.start_addr + offset);
+out:
+	mas_unlock(&mas);
+
+	return ret;
+}
+
+static void release_module_tags(struct module *mod, bool unused)
+{
+	MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
+	struct alloc_tag *last;
 	struct alloc_tag *tag;
-	struct codetag *ct;
+	struct module *val;
 
-	for (ct = codetag_next_ct(&iter); ct; ct = codetag_next_ct(&iter)) {
-		if (iter.cmod != cmod)
-			continue;
+	if (unused)
+		return;
+
+	mas_lock(&mas);
+	mas_for_each_rev(&mas, val, 0)
+		if (val == mod)
+			break;
+
+	if (!val) /* module not found */
+		goto out;
+
+	tag = (struct alloc_tag *)(module_tags.start_addr + mas.index);
+	last = (struct alloc_tag *)(module_tags.start_addr + mas.last);
+
+	unused = true;
+	while (tag <= last) {
+		struct alloc_tag_counters counter;
 
-		tag = ct_to_alloc_tag(ct);
 		counter = alloc_tag_read(tag);
+		if (counter.bytes) {
+			struct codetag *ct = &tag->ct;
+
+			pr_info("%s:%u module %s func:%s has %llu allocated at module unload\n",
+				ct->filename, ct->lineno, ct->modname,
+				ct->function, counter.bytes);
+			unused = false;
+			break;
+		}
+		tag++;
+	}
+
+	mas_store(&mas, unused ? NULL : &unloaded_mod);
+	val = mas_prev_range(&mas, 0);
+	if (val == &prepend_mod)
+		mas_store(&mas, NULL);
+out:
+	mas_unlock(&mas);
+}
+
+static void replace_module(struct module *mod, struct module *new_mod)
+{
+	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
+	struct module *val;
 
-		if (WARN(counter.bytes,
-			 "%s:%u module %s func:%s has %llu allocated at module unload",
-			 ct->filename, ct->lineno, ct->modname, ct->function, counter.bytes))
-			module_unused = false;
+	mas_lock(&mas);
+	mas_for_each(&mas, val, module_tags.size) {
+		if (val != mod)
+			continue;
+
+		mas_store_gfp(&mas, new_mod, GFP_KERNEL);
+		break;
 	}
+	mas_unlock(&mas);
+}
+
+static unsigned long max_module_alloc_tags __initdata = 100000;
 
-	return module_unused;
+static int __init set_max_module_alloc_tags(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	return kstrtoul(arg, 0, &max_module_alloc_tags);
 }
+early_param("max_module_alloc_tags", set_max_module_alloc_tags);
+
+static int __init alloc_mod_tags_mem(void)
+{
+	unsigned long module_tags_mem_sz;
+
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
+
+	return 0;
+}
+
+static void __init free_mod_tags_mem(void)
+{
+	execmem_free((void *)module_tags.start_addr);
+	module_tags.start_addr = 0;
+}
+
+#else /* CONFIG_MODULES */
+
+static inline int alloc_mod_tags_mem(void) { return 0; }
+static inline void free_mod_tags_mem(void) {}
+
+#endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT
 static bool mem_profiling_support __meminitdata = true;
@@ -255,14 +470,26 @@ static inline void sysctl_init(void) {}
 static int __init alloc_tag_init(void)
 {
 	const struct codetag_type_desc desc = {
-		.section	= "alloc_tags",
-		.tag_size	= sizeof(struct alloc_tag),
-		.module_unload	= alloc_tag_module_unload,
+		.section		= ALLOC_TAG_SECTION_NAME,
+		.tag_size		= sizeof(struct alloc_tag),
+#ifdef CONFIG_MODULES
+		.needs_section_mem	= needs_section_mem,
+		.alloc_section_mem	= reserve_module_tags,
+		.free_section_mem	= release_module_tags,
+		.module_replaced	= replace_module,
+#endif
 	};
+	int res;
+
+	res = alloc_mod_tags_mem();
+	if (res)
+		return res;
 
 	alloc_tag_cttype = codetag_register_type(&desc);
-	if (IS_ERR(alloc_tag_cttype))
+	if (IS_ERR(alloc_tag_cttype)) {
+		free_mod_tags_mem();
 		return PTR_ERR(alloc_tag_cttype);
+	}
 
 	sysctl_init();
 	procfs_init();
diff --git a/lib/codetag.c b/lib/codetag.c
index afa8a2d4f317..60463ef4bb85 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -207,6 +207,94 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 }
 
 #ifdef CONFIG_MODULES
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
 void codetag_load_module(struct module *mod)
 {
 	struct codetag_type *cttype;
@@ -220,13 +308,12 @@ void codetag_load_module(struct module *mod)
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
@@ -243,18 +330,17 @@ bool codetag_unload_module(struct module *mod)
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
 #endif /* CONFIG_MODULES */
 
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
2.46.0.469.g59c65b2a67-goog



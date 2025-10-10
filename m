Return-Path: <linux-arch+bounces-14025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D14BCDDF5
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103F0428CD7
	for <lists+linux-arch@lfdr.de>; Fri, 10 Oct 2025 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8D2F8BC3;
	Fri, 10 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGxLpKld"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607426980E
	for <linux-arch@vger.kernel.org>; Fri, 10 Oct 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111197; cv=none; b=uTPnRLxhOPoX8zMBCWwIGIdz30CpcKmZGo9kuZyUUB2TDlnYxHNuyGjiqq0rBD0dXtIDS4xLaURUdY2ohwJ3j4itc7mGI5wzFVrMiVd7gl9qtLe8x+Zigz2TY7hyYEMmnzNb1QwhqUoYuX0+GrElyU6bOF3x94UU8RevPpcQ2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111197; c=relaxed/simple;
	bh=vD94a1dQIKcft348Wg0IhPKa3pFzW5Gq6MGoQABL2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQb831fWilIDHmjwGwkZxTqTwuyui1UH4/LVr3j+rQ1kOvsjmhykZVaIY9lMmOOFHXhgW12ahxD9qALRyymgUNz0y24Wuou42F6VoYp3c37cXzKtrdgZz15+DYJW2bdMsj2QIe0/rOiHxhxJthiK1AXBe8kQOoorjfGzjbg23SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGxLpKld; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760111193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmfQcjlYeeIizFh9KNcYaRTP3GIRysvYsOZwFKMgxYk=;
	b=XGxLpKldBwVslBn6vWnSxh/e85lBzvOBuNkZW37RYF3wgpqBDKEjdpVyJBmXpuCpoi1uX5
	Av8VAjQkHlaCptGUatLthprpakH7g2xXnIym4OhejpoE9WiUsjezS09/JvRwwF4DJZCbTn
	C0FS9HW5+awFL+UKShXSt9RYw1MbXMc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-rJr-IMpFPEaorCSwgGDLpA-1; Fri,
 10 Oct 2025 11:46:31 -0400
X-MC-Unique: rJr-IMpFPEaorCSwgGDLpA-1
X-Mimecast-MFC-AGG-ID: rJr-IMpFPEaorCSwgGDLpA_1760111187
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF761180034A;
	Fri, 10 Oct 2025 15:46:26 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.224.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 655E0180035E;
	Fri, 10 Oct 2025 15:46:12 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v6 22/29] module: Add MOD_NOINSTR_TEXT mem_type
Date: Fri, 10 Oct 2025 17:38:32 +0200
Message-ID: <20251010153839.151763-23-vschneid@redhat.com>
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

As pointed out by Sean [1], is_kernel_noinstr_text() will return false for
an address contained within a module's .noinstr.text section. A later patch
will require checking whether a text address is noinstr, and this can
unfortunately be the case of modules - KVM is one such case.

A module's .noinstr.text section is already tracked as of commit
  66e9b0717102 ("kprobes: Prevent probes in .noinstr.text section")
for kprobe blacklisting purposes, but via an ad-hoc mechanism.

Add a MOD_NOINSTR_TEXT mem_type, and reorganize __layout_sections() so that
it maps all the sections in a single invocation.

[1]: http://lore.kernel.org/r/Z4qQL89GZ_gk0vpu@google.com
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/module.h |  6 ++--
 kernel/kprobes.c       |  8 ++---
 kernel/module/main.c   | 76 ++++++++++++++++++++++++++++++++----------
 3 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 3319a5269d286..825e2a072184a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -314,6 +314,7 @@ struct mod_tree_node {
 
 enum mod_mem_type {
 	MOD_TEXT = 0,
+	MOD_NOINSTR_TEXT,
 	MOD_DATA,
 	MOD_RODATA,
 	MOD_RO_AFTER_INIT,
@@ -484,8 +485,6 @@ struct module {
 	void __percpu *percpu;
 	unsigned int percpu_size;
 #endif
-	void *noinstr_text_start;
-	unsigned int noinstr_text_size;
 
 #ifdef CONFIG_TRACEPOINTS
 	unsigned int num_tracepoints;
@@ -614,12 +613,13 @@ static inline bool module_is_coming(struct module *mod)
         return mod->state == MODULE_STATE_COMING;
 }
 
-struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
+struct module *__module_text_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
 bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
+bool is_module_noinstr_text_address(unsigned long addr);
 
 static inline bool within_module_mem_type(unsigned long addr,
 					  const struct module *mod,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d17..d60560dddec56 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2551,9 +2551,9 @@ static void add_module_kprobe_blacklist(struct module *mod)
 		kprobe_add_area_blacklist(start, end);
 	}
 
-	start = (unsigned long)mod->noinstr_text_start;
+	start = (unsigned long)mod->mem[MOD_NOINSTR_TEXT].base;
 	if (start) {
-		end = start + mod->noinstr_text_size;
+		end = start + mod->mem[MOD_NOINSTR_TEXT].size;
 		kprobe_add_area_blacklist(start, end);
 	}
 }
@@ -2574,9 +2574,9 @@ static void remove_module_kprobe_blacklist(struct module *mod)
 		kprobe_remove_area_blacklist(start, end);
 	}
 
-	start = (unsigned long)mod->noinstr_text_start;
+	start = (unsigned long)mod->mem[MOD_NOINSTR_TEXT].base;
 	if (start) {
-		end = start + mod->noinstr_text_size;
+		end = start + mod->mem[MOD_NOINSTR_TEXT].size;
 		kprobe_remove_area_blacklist(start, end);
 	}
 }
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b261849362..1f5bfdbb956a7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1653,7 +1653,17 @@ bool module_init_layout_section(const char *sname)
 	return module_init_section(sname);
 }
 
-static void __layout_sections(struct module *mod, struct load_info *info, bool is_init)
+static bool module_noinstr_layout_section(const char *sname)
+{
+	return strstarts(sname, ".noinstr");
+}
+
+static bool module_default_layout_section(const char *sname)
+{
+	return !module_init_layout_section(sname) && !module_noinstr_layout_section(sname);
+}
+
+static void __layout_sections(struct module *mod, struct load_info *info)
 {
 	unsigned int m, i;
 
@@ -1662,20 +1672,44 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 	 *   Mask of excluded section header flags }
 	 */
 	static const unsigned long masks[][2] = {
+		/* Core */
+		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
+		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
+		{ SHF_ALLOC, SHF_WRITE | ARCH_SHF_SMALL },
+		{ SHF_RO_AFTER_INIT | SHF_ALLOC, ARCH_SHF_SMALL },
+		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
+		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 },
+		/* Init */
 		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ SHF_ALLOC, SHF_WRITE | ARCH_SHF_SMALL },
 		{ SHF_RO_AFTER_INIT | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
-		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 }
+		{ ARCH_SHF_SMALL | SHF_ALLOC, 0 },
 	};
-	static const int core_m_to_mem_type[] = {
+	static bool (*const section_filter[])(const char *) = {
+		/* Core */
+		module_default_layout_section,
+		module_noinstr_layout_section,
+		module_default_layout_section,
+		module_default_layout_section,
+		module_default_layout_section,
+		module_default_layout_section,
+		/* Init */
+		module_init_layout_section,
+		module_init_layout_section,
+		module_init_layout_section,
+		module_init_layout_section,
+		module_init_layout_section,
+	};
+	static const int mem_type_map[] = {
+		/* Core */
 		MOD_TEXT,
+		MOD_NOINSTR_TEXT,
 		MOD_RODATA,
 		MOD_RO_AFTER_INIT,
 		MOD_DATA,
 		MOD_DATA,
-	};
-	static const int init_m_to_mem_type[] = {
+		/* Init */
 		MOD_INIT_TEXT,
 		MOD_INIT_RODATA,
 		MOD_INVALID,
@@ -1684,16 +1718,16 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 	};
 
 	for (m = 0; m < ARRAY_SIZE(masks); ++m) {
-		enum mod_mem_type type = is_init ? init_m_to_mem_type[m] : core_m_to_mem_type[m];
+		enum mod_mem_type type = mem_type_map[m];
 
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
 			const char *sname = info->secstrings + s->sh_name;
 
-			if ((s->sh_flags & masks[m][0]) != masks[m][0]
-			    || (s->sh_flags & masks[m][1])
-			    || s->sh_entsize != ~0UL
-			    || is_init != module_init_layout_section(sname))
+			if ((s->sh_flags & masks[m][0]) != masks[m][0] ||
+			    (s->sh_flags & masks[m][1])                ||
+			    s->sh_entsize != ~0UL                      ||
+			    !section_filter[m](sname))
 				continue;
 
 			if (WARN_ON_ONCE(type == MOD_INVALID))
@@ -1733,10 +1767,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		info->sechdrs[i].sh_entsize = ~0UL;
 
 	pr_debug("Core section allocation order for %s:\n", mod->name);
-	__layout_sections(mod, info, false);
-
-	pr_debug("Init section allocation order for %s:\n", mod->name);
-	__layout_sections(mod, info, true);
+	__layout_sections(mod, info);
 }
 
 static void module_license_taint_check(struct module *mod, const char *license)
@@ -2625,9 +2656,6 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	}
 #endif
 
-	mod->noinstr_text_start = section_objs(info, ".noinstr.text", 1,
-						&mod->noinstr_text_size);
-
 #ifdef CONFIG_TRACEPOINTS
 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
 					     sizeof(*mod->tracepoints_ptrs),
@@ -3872,12 +3900,26 @@ struct module *__module_text_address(unsigned long addr)
 	if (mod) {
 		/* Make sure it's within the text section. */
 		if (!within_module_mem_type(addr, mod, MOD_TEXT) &&
+		    !within_module_mem_type(addr, mod, MOD_NOINSTR_TEXT) &&
 		    !within_module_mem_type(addr, mod, MOD_INIT_TEXT))
 			mod = NULL;
 	}
 	return mod;
 }
 
+bool is_module_noinstr_text_address(unsigned long addr)
+{
+	scoped_guard(preempt) {
+		struct module *mod = __module_address(addr);
+
+		/* Make sure it's within the .noinstr.text section. */
+		if (mod)
+			return within_module_mem_type(addr, mod, MOD_NOINSTR_TEXT);
+	}
+
+	return false;
+}
+
 /* Don't grab lock, we're oopsing. */
 void print_modules(void)
 {
-- 
2.51.0



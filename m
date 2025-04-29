Return-Path: <linux-arch+bounces-11705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77AEAA0AA0
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08423AE114
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122402D0260;
	Tue, 29 Apr 2025 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToO68QJg"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE32C1080
	for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927131; cv=none; b=Lku2Mrn4114OX1BT10rPhsM6mND6eVGixoeo2Q7iN1R8h9gZk4PunioxvGJYjQpPMDWHR5dKgke6gefmMNXjrJxTP39i4k/kMiE+0S4MmhR5acB/KmBbdP+S7RVQu0lvgYd54ktXyDhreawzgu3Bcn9PGhvnKwnDsWhBMVmx+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927131; c=relaxed/simple;
	bh=NJfpXMbwdIjKMcwhuZUnZrajNhJDS7nuZLz4u6h1L98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmYDqenq5XDdMZz0esmi3MpN1TVNe/hQWXfsVUeDr+0OPJjr9g5nvga8yMZDRLcKnzZ2whkyXAGsgeIUKoH1UXF6qIhGyAiC64LE0TtSEZpctr4YzB1ZvEYYR6FB3yrmWmO3b3A9Nh6ItqlR/VPx7C+z1YUm985omuQ0fN0acFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToO68QJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745927128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eRqqbGq1uFGChwVCp3H62kpC0FqCEBM1hCsGgM03Z0=;
	b=ToO68QJgyMU5T1ZtoV1wCLJG19X+h3zagehZtIS04mj642+rTD8Iki4W6yX+CX6zQlz/Ke
	8CKCH0mWu7MU3qPQkKxJoI/70kAbQswQXajmd48ZQ3DRVzrTLl5GaQxeofE3Ho08d2Do0c
	Wp4Race3mYREPRtnk2elauZiY3/hgy0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-Wh1l12g2O4OqWBygOwaAeg-1; Tue,
 29 Apr 2025 07:45:25 -0400
X-MC-Unique: Wh1l12g2O4OqWBygOwaAeg-1
X-Mimecast-MFC-AGG-ID: Wh1l12g2O4OqWBygOwaAeg_1745927120
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B668E1800984;
	Tue, 29 Apr 2025 11:45:20 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.225.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DB8F19560A3;
	Tue, 29 Apr 2025 11:44:51 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Naveen N Rao <naveen@kernel.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Rong Xu <xur@google.com>,
	Rafael Aquini <aquini@redhat.com>,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Stultz <jstultz@google.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v5 23/25] module: Add MOD_NOINSTR_TEXT mem_type
Date: Tue, 29 Apr 2025 13:32:40 +0200
Message-ID: <20250429113242.998312-24-vschneid@redhat.com>
In-Reply-To: <20250429113242.998312-1-vschneid@redhat.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
index d94b196d5a34e..193d8d34eeee0 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -332,6 +332,7 @@ struct mod_tree_node {
 
 enum mod_mem_type {
 	MOD_TEXT = 0,
+	MOD_NOINSTR_TEXT,
 	MOD_DATA,
 	MOD_RODATA,
 	MOD_RO_AFTER_INIT,
@@ -502,8 +503,6 @@ struct module {
 	void __percpu *percpu;
 	unsigned int percpu_size;
 #endif
-	void *noinstr_text_start;
-	unsigned int noinstr_text_size;
 
 #ifdef CONFIG_TRACEPOINTS
 	unsigned int num_tracepoints;
@@ -622,12 +621,13 @@ static inline bool module_is_coming(struct module *mod)
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
index ffe0c3d523063..9a799faee68a1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2547,9 +2547,9 @@ static void add_module_kprobe_blacklist(struct module *mod)
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
@@ -2570,9 +2570,9 @@ static void remove_module_kprobe_blacklist(struct module *mod)
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
index b9f010daaa4c7..0126bae64b698 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1558,7 +1558,17 @@ bool module_init_layout_section(const char *sname)
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
 
@@ -1567,20 +1577,44 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
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
@@ -1589,16 +1623,16 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
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
@@ -1638,10 +1672,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		info->sechdrs[i].sh_entsize = ~0UL;
 
 	pr_debug("Core section allocation order for %s:\n", mod->name);
-	__layout_sections(mod, info, false);
-
-	pr_debug("Init section allocation order for %s:\n", mod->name);
-	__layout_sections(mod, info, true);
+	__layout_sections(mod, info);
 }
 
 static void module_license_taint_check(struct module *mod, const char *license)
@@ -2515,9 +2546,6 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	}
 #endif
 
-	mod->noinstr_text_start = section_objs(info, ".noinstr.text", 1,
-						&mod->noinstr_text_size);
-
 #ifdef CONFIG_TRACEPOINTS
 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
 					     sizeof(*mod->tracepoints_ptrs),
@@ -3769,12 +3797,26 @@ struct module *__module_text_address(unsigned long addr)
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
2.49.0



Return-Path: <linux-arch+bounces-4191-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF07B8BC153
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB41F21A5B
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09641755;
	Sun,  5 May 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCOoCzeD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165D2555B;
	Sun,  5 May 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714919362; cv=none; b=VFazNnEj0MIFKn0q+7ZWF9E6oennAgRn2kQTUIjNYdVL2EX4nhS6xZk+Yp0pkjtqGVUOFLZpMWqyh+jRD611+OlZHUO9txvaEzn9wA0TPAJGj2TCk3lwj3l0Y4NuwPBb5jYsOTxaysFvsNvnRhmV+FhK49sVDBNlq/isxBNEXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714919362; c=relaxed/simple;
	bh=n6mgI0H/39mvE4gYkoCj3q2CT30/D9BQcnyPUkYmzdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udHNAPKCKTtJBxE/thNkVWge8z4QsAqzwnx6EmuujW5zjUjjsWBfqs9hDY2EhHcCZL7j1ejI4QFimCZfqPFc1ETWc2QsxZJcUmu+X3HyKKvnnHmgRit3Lqx1lLTyCNq/QLUK2/Wj3isGouESaDNc3boOd/YmCcwJiy7bPoDDRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCOoCzeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79F1C4AF18;
	Sun,  5 May 2024 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714919362;
	bh=n6mgI0H/39mvE4gYkoCj3q2CT30/D9BQcnyPUkYmzdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCOoCzeDDucZMyfkGTax/lnqm1e5Abz1XosvZiBVXA4GkwIKS1hteSGn08V8/wLuC
	 wpPNDdzZnnFSmPxqXMvyiOGhJfaqrnAtcI5ejcAGpj5kHU2/jzTmtI2ATOSpOR2zm6
	 i/qggJ/L4s4qTpgSgd1dd5AGNpCqZauhtz4ELcdUfxrSXTb0cEH1CMow5l/cKtu5Y/
	 k+67kSbUtZB7U8D+kbKCx/teDnQG+H6EYp1rEhWZCiJFHfR6SREuMcHUsHkYtS0hgK
	 QQdejucvdgWv98oEveEQ6aQHeslE2DAF0AMg6jCpNM1EKStAf7pmRZzPSfJTdetmKd
	 MpUJkQKDqLz+A==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Liviu Dudau <liviu@dudau.co.uk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 15/17] kprobes: remove dependency on CONFIG_MODULES
Date: Sun,  5 May 2024 17:25:58 +0300
Message-ID: <20240505142600.2322517-16-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505142600.2322517-1-rppt@kernel.org>
References: <20240505142600.2322517-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

kprobes depended on CONFIG_MODULES because it has to allocate memory for
code.

Since code allocations are now implemented with execmem, kprobes can be
enabled in non-modular kernels.

Add #ifdef CONFIG_MODULE guards for the code dealing with kprobes inside
modules, make CONFIG_KPROBES select CONFIG_EXECMEM and drop the
dependency of CONFIG_KPROBES on CONFIG_MODULES.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig                |  2 +-
 include/linux/module.h      |  9 ++++++
 kernel/kprobes.c            | 55 +++++++++++++++++++++++--------------
 kernel/trace/trace_kprobe.c | 20 +++++++++++++-
 4 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4fd0daa54e6c..caa459964f09 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -52,9 +52,9 @@ config GENERIC_ENTRY
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
+	select EXECMEM
 	select TASKS_RCU if PREEMPTION
 	help
 	  Kprobes allows you to trap at almost any kernel address and
diff --git a/include/linux/module.h b/include/linux/module.h
index 1153b0d99a80..ffa1c603163c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -605,6 +605,11 @@ static inline bool module_is_live(struct module *mod)
 	return mod->state != MODULE_STATE_GOING;
 }
 
+static inline bool module_is_coming(struct module *mod)
+{
+        return mod->state == MODULE_STATE_COMING;
+}
+
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
@@ -857,6 +862,10 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 	return ptr;
 }
 
+static inline bool module_is_coming(struct module *mod)
+{
+	return false;
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ddd7cdc16edf..ca2c6cbd42d2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1588,7 +1588,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	}
 
 	/* Get module refcount and reject __init functions for loaded modules. */
-	if (*probed_mod) {
+	if (IS_ENABLED(CONFIG_MODULES) && *probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating
 		 * its code to prohibit unexpected unloading.
@@ -1603,12 +1603,13 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		 * kprobes in there.
 		 */
 		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
-		    (*probed_mod)->state != MODULE_STATE_COMING) {
+		    !module_is_coming(*probed_mod)) {
 			module_put(*probed_mod);
 			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
 	}
+
 out:
 	preempt_enable();
 	jump_label_unlock();
@@ -2488,24 +2489,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
-/* Remove all symbols in given area from kprobe blacklist */
-static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
-{
-	struct kprobe_blacklist_entry *ent, *n;
-
-	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
-		if (ent->start_addr < start || ent->start_addr >= end)
-			continue;
-		list_del(&ent->list);
-		kfree(ent);
-	}
-}
-
-static void kprobe_remove_ksym_blacklist(unsigned long entry)
-{
-	kprobe_remove_area_blacklist(entry, entry + 1);
-}
-
 int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 				   char *type, char *sym)
 {
@@ -2570,6 +2553,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
+/* Remove all symbols in given area from kprobe blacklist */
+static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
+{
+	struct kprobe_blacklist_entry *ent, *n;
+
+	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
+		if (ent->start_addr < start || ent->start_addr >= end)
+			continue;
+		list_del(&ent->list);
+		kfree(ent);
+	}
+}
+
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2672,6 +2674,17 @@ static struct notifier_block kprobe_module_nb = {
 	.priority = 0
 };
 
+static int kprobe_register_module_notifier(void)
+{
+	return register_module_notifier(&kprobe_module_nb);
+}
+#else
+static int kprobe_register_module_notifier(void)
+{
+	return 0;
+}
+#endif /* CONFIG_MODULES */
+
 void kprobe_free_init_mem(void)
 {
 	void *start = (void *)(&__init_begin);
@@ -2731,7 +2744,7 @@ static int __init init_kprobes(void)
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
 	if (!err)
-		err = register_module_notifier(&kprobe_module_nb);
+		err = kprobe_register_module_notifier();
 
 	kprobes_initialized = (err == 0);
 	kprobe_sysctls_init();
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 14099cc17fc9..2cb2a3951b4f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
+#ifdef CONFIG_MODULES
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 {
 	char *p;
@@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#else
+static inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
+{
+	return false;
+}
+#endif
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	return ret;
 }
 
+#ifdef CONFIG_MODULES
 /* Module notifier call back, checking event on the module */
 static int trace_kprobe_module_callback(struct notifier_block *nb,
 				       unsigned long val, void *data)
@@ -704,6 +712,16 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
 	.priority = 1	/* Invoked after kprobe module callback */
 };
+static int trace_kprobe_register_module_notifier(void)
+{
+	return register_module_notifier(&trace_kprobe_module_nb);
+}
+#else
+static int trace_kprobe_register_module_notifier(void)
+{
+	return 0;
+}
+#endif /* CONFIG_MODULES */
 
 static int count_symbols(void *data, unsigned long unused)
 {
@@ -1933,7 +1951,7 @@ static __init int init_kprobe_trace_early(void)
 	if (ret)
 		return ret;
 
-	if (register_module_notifier(&trace_kprobe_module_nb))
+	if (trace_kprobe_register_module_notifier())
 		return -EINVAL;
 
 	return 0;
-- 
2.43.0



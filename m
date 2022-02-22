Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1964BFBDB
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiBVPDs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 10:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiBVPCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 10:02:20 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF115F34E;
        Tue, 22 Feb 2022 07:01:01 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K32RM19WHz9sSm;
        Tue, 22 Feb 2022 16:00:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cXlVZuWkRwWK; Tue, 22 Feb 2022 16:00:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K32RF3gP2z9sSp;
        Tue, 22 Feb 2022 16:00:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D33E8B764;
        Tue, 22 Feb 2022 16:00:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QOwbd7_ZHCjS; Tue, 22 Feb 2022 16:00:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5D458B77B;
        Tue, 22 Feb 2022 16:00:40 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MF0ZRV1087076
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 16:00:35 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MF0VtJ1087075;
        Tue, 22 Feb 2022 16:00:31 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v5 4/6] module: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Date:   Tue, 22 Feb 2022 16:00:21 +0100
Message-Id: <fe41ba636a1e229ab3c47543670182d68e38b1e5.1645541930.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645541930.git.christophe.leroy@csgroup.eu>
References: <cover.1645541930.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645542019; l=10326; s=20211009; h=from:subject:message-id; bh=jfohywy7Pj0RCHc9nfFEkluhtuy5nMPObt52zQJtLMw=; b=eA/6vfTfI7bqW8XwFoEf2DmsuFFhBE9N/jvxa+cIXZEaO1I65UT8aQjeZG6axGUnTtQeFsjpxGfX Qx7x64s2DRbHxCBzciuWlY+wHjiZVAslNq9pK/4rtpYl+7FCnMTO
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC to allow architectures
to request having modules data in vmalloc area instead of module area.

This is required on powerpc book3s/32 in order to set data non
executable, because it is not possible to set executability on page
basis, this is done per 256 Mbytes segments. The module area has exec
right, vmalloc area has noexec.

This can also be useful on other powerpc/32 in order to maximize the
chance of code being close enough to kernel core to avoid branch
trampolines.

Cc: Jason Wessel <jason.wessel@windriver.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/Kconfig                |  6 ++++
 include/linux/module.h      |  8 +++++
 kernel/debug/kdb/kdb_main.c | 10 +++++--
 kernel/module/internal.h    |  3 ++
 kernel/module/main.c        | 58 +++++++++++++++++++++++++++++++++++--
 kernel/module/procfs.c      |  8 +++--
 kernel/module/tree_lookup.c |  8 +++++
 7 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..b5d1f2c19c27 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -882,6 +882,12 @@ config MODULES_USE_ELF_REL
 	  Modules only use ELF REL relocations.  Modules with ELF RELA
 	  relocations will give an error.
 
+config ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	bool
+	help
+	  For architectures like powerpc/32 which have constraints on module
+	  allocation and need to allocate module data outside of module area.
+
 config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	bool
 	help
diff --git a/include/linux/module.h b/include/linux/module.h
index 7ec9715de7dc..134c1df04b14 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -422,6 +422,9 @@ struct module {
 	/* Core layout: rbtree is accessed frequently, so keep together. */
 	struct module_layout core_layout __module_layout_align;
 	struct module_layout init_layout;
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	struct module_layout data_layout;
+#endif
 
 	/* Arch-specific module values */
 	struct mod_arch_specific arch;
@@ -569,6 +572,11 @@ bool is_module_text_address(unsigned long addr);
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
 {
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	if ((unsigned long)mod->data_layout.base <= addr &&
+	    addr < (unsigned long)mod->data_layout.base + mod->data_layout.size)
+		return true;
+#endif
 	return (unsigned long)mod->core_layout.base <= addr &&
 	       addr < (unsigned long)mod->core_layout.base + mod->core_layout.size;
 }
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 5369bf45c5d4..94de2889a062 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2027,8 +2027,11 @@ static int kdb_lsmod(int argc, const char **argv)
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 
-		kdb_printf("%-20s%8u  0x%px ", mod->name,
-			   mod->core_layout.size, (void *)mod);
+		kdb_printf("%-20s%8u", mod->name, mod->core_layout.size);
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+		kdb_printf("/%8u", mod->data_layout.size);
+#endif
+		kdb_printf("  0x%px ", (void *)mod);
 #ifdef CONFIG_MODULE_UNLOAD
 		kdb_printf("%4d ", module_refcount(mod));
 #endif
@@ -2039,6 +2042,9 @@ static int kdb_lsmod(int argc, const char **argv)
 		else
 			kdb_printf(" (Live)");
 		kdb_printf(" 0x%px", mod->core_layout.base);
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+		kdb_printf("/0x%px", mod->data_layout.base);
+#endif
 
 #ifdef CONFIG_MODULE_UNLOAD
 		{
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 5ad6233d409a..6911c7533ede 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -20,7 +20,9 @@
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
+#ifndef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 #define	data_layout core_layout
+#endif
 
 /*
  * Modules' sections will be aligned on page boundaries
@@ -154,6 +156,7 @@ struct mod_tree_root {
 };
 
 extern struct mod_tree_root mod_tree;
+extern struct mod_tree_root mod_data_tree;
 
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 void mod_tree_insert(struct module *mod);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index bd26280f2880..f4d95a2ff08f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -78,6 +78,12 @@ struct mod_tree_root mod_tree __cacheline_aligned = {
 	.addr_min = -1UL,
 };
 
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+struct mod_tree_root mod_data_tree __cacheline_aligned = {
+	.addr_min = -1UL,
+};
+#endif
+
 #define module_addr_min mod_tree.addr_min
 #define module_addr_max mod_tree.addr_max
 
@@ -107,6 +113,9 @@ static void mod_update_bounds(struct module *mod)
 	__mod_update_bounds(mod->core_layout.base, mod->core_layout.size, &mod_tree);
 	if (mod->init_layout.size)
 		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size, &mod_tree);
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	__mod_update_bounds(mod->data_layout.base, mod->data_layout.size, &mod_data_tree);
+#endif
 }
 
 static void module_assert_mutex_or_preempt(void)
@@ -940,6 +949,17 @@ static ssize_t show_coresize(struct module_attribute *mattr,
 static struct module_attribute modinfo_coresize =
 	__ATTR(coresize, 0444, show_coresize, NULL);
 
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+static ssize_t show_datasize(struct module_attribute *mattr,
+			     struct module_kobject *mk, char *buffer)
+{
+	return sprintf(buffer, "%u\n", mk->mod->data_layout.size);
+}
+
+static struct module_attribute modinfo_datasize =
+	__ATTR(datasize, 0444, show_datasize, NULL);
+#endif
+
 static ssize_t show_initsize(struct module_attribute *mattr,
 			     struct module_kobject *mk, char *buffer)
 {
@@ -968,6 +988,9 @@ struct module_attribute *modinfo_attrs[] = {
 	&modinfo_srcversion,
 	&modinfo_initstate,
 	&modinfo_coresize,
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	&modinfo_datasize,
+#endif
 	&modinfo_initsize,
 	&modinfo_taint,
 #ifdef CONFIG_MODULE_UNLOAD
@@ -1233,6 +1256,9 @@ static void free_module(struct module *mod)
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	vfree(mod->data_layout.base);
+#endif
 }
 
 void *__symbol_get(const char *symbol)
@@ -2163,6 +2189,24 @@ static int move_module(struct module *mod, struct load_info *info)
 	} else
 		mod->init_layout.base = NULL;
 
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	/* Do the allocs. */
+	ptr = vmalloc(mod->data_layout.size);
+	/*
+	 * The pointer to this block is stored in the module structure
+	 * which is inside the block. Just mark it as not being a
+	 * leak.
+	 */
+	kmemleak_not_leak(ptr);
+	if (!ptr) {
+		module_memfree(mod->core_layout.base);
+		module_memfree(mod->init_layout.base);
+		return -ENOMEM;
+	}
+
+	memset(ptr, 0, mod->data_layout.size);
+	mod->data_layout.base = ptr;
+#endif
 	/* Transfer each section which specifies SHF_ALLOC */
 	pr_debug("final section addresses:\n");
 	for (i = 0; i < info->hdr->e_shnum; i++) {
@@ -2338,6 +2382,9 @@ static void module_deallocate(struct module *mod, struct load_info *info)
 	module_arch_freeing_init(mod);
 	module_memfree(mod->init_layout.base);
 	module_memfree(mod->core_layout.base);
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	vfree(mod->data_layout.base);
+#endif
 }
 
 int __weak module_finalize(const Elf_Ehdr *hdr,
@@ -3049,13 +3096,20 @@ bool is_module_address(unsigned long addr)
 struct module *__module_address(unsigned long addr)
 {
 	struct module *mod;
+	struct mod_tree_root *tree;
 
-	if (addr < module_addr_min || addr > module_addr_max)
+	if (addr >= mod_tree.addr_min && addr <= mod_tree.addr_max)
+		tree = &mod_tree;
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	else if (addr >= mod_data_tree.addr_min && addr <= mod_data_tree.addr_max)
+		tree = &mod_data_tree;
+#endif
+	else
 		return NULL;
 
 	module_assert_mutex_or_preempt();
 
-	mod = mod_find(addr, &mod_tree);
+	mod = mod_find(addr, tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
 		if (mod->state == MODULE_STATE_UNFORMED)
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 2717e130788e..9a8f4f0f6329 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -67,13 +67,17 @@ static int m_show(struct seq_file *m, void *p)
 	struct module *mod = list_entry(p, struct module, list);
 	char buf[MODULE_FLAGS_BUF_SIZE];
 	void *value;
+	unsigned int size;
 
 	/* We always ignore unformed modules. */
 	if (mod->state == MODULE_STATE_UNFORMED)
 		return 0;
 
-	seq_printf(m, "%s %u",
-		   mod->name, mod->init_layout.size + mod->core_layout.size);
+	size = mod->init_layout.size + mod->core_layout.size;
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	size += mod->data_layout.size;
+#endif
+	seq_printf(m, "%s %u", mod->name, size);
 	print_unload_info(m, mod);
 
 	/* Informative for users. */
diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
index 995fe68059db..8ec5cfd60496 100644
--- a/kernel/module/tree_lookup.c
+++ b/kernel/module/tree_lookup.c
@@ -83,6 +83,11 @@ void mod_tree_insert(struct module *mod)
 	__mod_tree_insert(&mod->core_layout.mtn, &mod_tree);
 	if (mod->init_layout.size)
 		__mod_tree_insert(&mod->init_layout.mtn, &mod_tree);
+
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	mod->data_layout.mtn.mod = mod;
+	__mod_tree_insert(&mod->data_layout.mtn, &mod_data_tree);
+#endif
 }
 
 void mod_tree_remove_init(struct module *mod)
@@ -95,6 +100,9 @@ void mod_tree_remove(struct module *mod)
 {
 	__mod_tree_remove(&mod->core_layout.mtn, &mod_tree);
 	mod_tree_remove_init(mod);
+#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
+	__mod_tree_remove(&mod->data_layout.mtn, &mod_data_tree);
+#endif
 }
 
 struct module *mod_find(unsigned long addr, struct mod_tree_root *tree)
-- 
2.34.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207F34C123F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiBWMD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbiBWMD2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 07:03:28 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB909A9B4;
        Wed, 23 Feb 2022 04:02:50 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K3ZRJ23dVz9sSZ;
        Wed, 23 Feb 2022 13:02:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m9JXzGGU1xor; Wed, 23 Feb 2022 13:02:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K3ZRC29xVz9sSq;
        Wed, 23 Feb 2022 13:02:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C1FE8B779;
        Wed, 23 Feb 2022 13:02:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UlqdccA2a9jd; Wed, 23 Feb 2022 13:02:31 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.201])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C3A158B77B;
        Wed, 23 Feb 2022 13:02:30 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21NC2LXX1148191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 13:02:21 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21NC2LnF1148190;
        Wed, 23 Feb 2022 13:02:21 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH v6 3/6] module: Introduce data_layout
Date:   Wed, 23 Feb 2022 13:02:13 +0100
Message-Id: <50797bbf84acd87c490192ae5b8539ee67b71418.1645607143.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645607143.git.christophe.leroy@csgroup.eu>
References: <cover.1645607143.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645617734; l=7630; s=20211009; h=from:subject:message-id; bh=SGwB0g/VxOk2Hxo10neUQCGEPvBipCTZ4EgruMPkPX8=; b=3xAwSrf4ThjTcViq5YoqXp4ZAWQSGrAFOmUT3HPpL/SfcClpcVP8uAstD8Hv76DC1Ubxm+5XQBS/ 1fGk8wH7CDUedQC/8UuKOHw3irvOL/Vy2gNlb+pzdEJSj1/8THcD
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

In order to allow separation of data from text, add another layout,
called data_layout. For architectures requesting separation of text
and data, only text will go in core_layout and data will go in
data_layout.

For architectures which keep text and data together, make data_layout
an alias of core_layout, that way data_layout can be used for all
data manipulations, regardless of whether data is in core_layout or
data_layout.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   |  2 ++
 kernel/module/kallsyms.c   | 18 +++++++++---------
 kernel/module/main.c       | 20 ++++++++++++--------
 kernel/module/strict_rwx.c | 10 +++++-----
 4 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 0f3146347256..0aabbf5cbcd1 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -20,6 +20,8 @@
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
+#define	data_layout core_layout
+
 /*
  * Modules' sections will be aligned on page boundaries
  * to ensure complete separation of code and data, but
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 23034b50f8f5..c56de1686172 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -134,12 +134,12 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	}
 
 	/* Append room for core symbols at end of core part. */
-	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
-	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
-	mod->core_layout.size += strtab_size;
-	info->core_typeoffs = mod->core_layout.size;
-	mod->core_layout.size += ndst * sizeof(char);
-	mod->core_layout.size = strict_align(mod->core_layout.size);
+	info->symoffs = ALIGN(mod->data_layout.size, symsect->sh_addralign ?: 1);
+	info->stroffs = mod->data_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
+	mod->data_layout.size += strtab_size;
+	info->core_typeoffs = mod->data_layout.size;
+	mod->data_layout.size += ndst * sizeof(char);
+	mod->data_layout.size = strict_align(mod->data_layout.size);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
@@ -187,9 +187,9 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	 * Now populate the cut down core kallsyms for after init
 	 * and set types up while we still have access to sections.
 	 */
-	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
-	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
-	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
+	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
+	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
+	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
 	src = rcu_dereference_sched(mod->kallsyms)->symtab;
 	for (ndst = i = 0; i < rcu_dereference_sched(mod->kallsyms)->num_symtab; i++) {
 		rcu_dereference_sched(mod->kallsyms)->typetab[i] = elf_type(src + i, info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a831f51595d7..84db7318ba2b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1190,7 +1190,7 @@ static void free_module(struct module *mod)
 	percpu_modfree(mod);
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -1431,13 +1431,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		for (i = 0; i < info->hdr->e_shnum; ++i) {
 			Elf_Shdr *s = &info->sechdrs[i];
 			const char *sname = info->secstrings + s->sh_name;
+			unsigned int *sizep;
 
 			if ((s->sh_flags & masks[m][0]) != masks[m][0]
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL
 			    || module_init_layout_section(sname))
 				continue;
-			s->sh_entsize = module_get_offset(mod, &mod->core_layout.size, s, i);
+			sizep = m ? &mod->data_layout.size : &mod->core_layout.size;
+			s->sh_entsize = module_get_offset(mod, sizep, s, i);
 			pr_debug("\t%s\n", sname);
 		}
 		switch (m) {
@@ -1446,15 +1448,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			mod->core_layout.text_size = mod->core_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->core_layout.size = strict_align(mod->core_layout.size);
-			mod->core_layout.ro_size = mod->core_layout.size;
+			mod->data_layout.size = strict_align(mod->data_layout.size);
+			mod->data_layout.ro_size = mod->data_layout.size;
 			break;
 		case 2: /* RO after init */
-			mod->core_layout.size = strict_align(mod->core_layout.size);
-			mod->core_layout.ro_after_init_size = mod->core_layout.size;
+			mod->data_layout.size = strict_align(mod->data_layout.size);
+			mod->data_layout.ro_after_init_size = mod->data_layout.size;
 			break;
 		case 4: /* whole core */
-			mod->core_layout.size = strict_align(mod->core_layout.size);
+			mod->data_layout.size = strict_align(mod->data_layout.size);
 			break;
 		}
 	}
@@ -2134,6 +2136,8 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (shdr->sh_entsize & INIT_OFFSET_MASK)
 			dest = mod->init_layout.base
 				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
+		else if (!(shdr->sh_flags & SHF_EXECINSTR))
+			dest = mod->data_layout.base + shdr->sh_entsize;
 		else
 			dest = mod->core_layout.base + shdr->sh_entsize;
 
@@ -2829,7 +2833,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index f36ea54c1dac..fe3c10891407 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -101,12 +101,12 @@ void module_enable_ro(const struct module *mod, bool after_init)
 	set_vm_flush_reset_perms(mod->init_layout.base);
 	frob_text(&mod->core_layout, set_memory_ro);
 
-	frob_rodata(&mod->core_layout, set_memory_ro);
+	frob_rodata(&mod->data_layout, set_memory_ro);
 	frob_text(&mod->init_layout, set_memory_ro);
 	frob_rodata(&mod->init_layout, set_memory_ro);
 
 	if (after_init)
-		frob_ro_after_init(&mod->core_layout, set_memory_ro);
+		frob_ro_after_init(&mod->data_layout, set_memory_ro);
 }
 
 void module_enable_nx(const struct module *mod)
@@ -114,9 +114,9 @@ void module_enable_nx(const struct module *mod)
 	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 		return;
 
-	frob_rodata(&mod->core_layout, set_memory_nx);
-	frob_ro_after_init(&mod->core_layout, set_memory_nx);
-	frob_writable_data(&mod->core_layout, set_memory_nx);
+	frob_rodata(&mod->data_layout, set_memory_nx);
+	frob_ro_after_init(&mod->data_layout, set_memory_nx);
+	frob_writable_data(&mod->data_layout, set_memory_nx);
 	frob_rodata(&mod->init_layout, set_memory_nx);
 	frob_writable_data(&mod->init_layout, set_memory_nx);
 }
-- 
2.34.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E404BFBC7
	for <lists+linux-arch@lfdr.de>; Tue, 22 Feb 2022 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiBVPCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Feb 2022 10:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiBVPCS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Feb 2022 10:02:18 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3601D10EC46;
        Tue, 22 Feb 2022 07:00:54 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K32RK0RC9z9sSj;
        Tue, 22 Feb 2022 16:00:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dmkNAPq6bi6R; Tue, 22 Feb 2022 16:00:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K32RF2zyTz9sSh;
        Tue, 22 Feb 2022 16:00:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56BDE8B778;
        Tue, 22 Feb 2022 16:00:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hi9VJtzWf9Y1; Tue, 22 Feb 2022 16:00:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C16228B779;
        Tue, 22 Feb 2022 16:00:40 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MF0VGF1087072
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 16:00:31 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MF0Va51087071;
        Tue, 22 Feb 2022 16:00:31 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH v5 3/6] module: Introduce data_layout
Date:   Tue, 22 Feb 2022 16:00:20 +0100
Message-Id: <a4ccdcbbfd884c533dfc81a987ed820bcd157d3e.1645541930.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645541930.git.christophe.leroy@csgroup.eu>
References: <cover.1645541930.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645542019; l=7494; s=20211009; h=from:subject:message-id; bh=mnGJddV/VLufpq4mul7z0wxAfxM/ej4XLDRryeTGUBY=; b=ttQZbW5aANwVNLprjCMW7u0Ztg196JJwc6K6eP4mAPmWkhd+yyBXNW/OIHCFdGAPijD3DZK3Poz4 oQyQOiK/AXiAA4A770cUtq+alSh01BN9RL3+rZT00u6CQUKQHMOr
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
index 99a5be36190c..5ad6233d409a 100644
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
index b6d49bb5afed..850cc66bb28c 100644
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
-	mod->core_layout.size = debug_align(mod->core_layout.size);
+	info->symoffs = ALIGN(mod->data_layout.size, symsect->sh_addralign ?: 1);
+	info->stroffs = mod->data_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
+	mod->data_layout.size += strtab_size;
+	info->core_typeoffs = mod->data_layout.size;
+	mod->data_layout.size += ndst * sizeof(char);
+	mod->data_layout.size = debug_align(mod->data_layout.size);
 
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
index c0b961e02909..bd26280f2880 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1229,7 +1229,7 @@ static void free_module(struct module *mod)
 	percpu_modfree(mod);
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -1470,13 +1470,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
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
@@ -1485,15 +1487,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			mod->core_layout.text_size = mod->core_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.ro_size = mod->core_layout.size;
+			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.ro_size = mod->data_layout.size;
 			break;
 		case 2: /* RO after init */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.ro_after_init_size = mod->core_layout.size;
+			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.ro_after_init_size = mod->data_layout.size;
 			break;
 		case 4: /* whole core */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->data_layout.size = debug_align(mod->data_layout.size);
 			break;
 		}
 	}
@@ -2173,6 +2175,8 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (shdr->sh_entsize & INIT_OFFSET_MASK)
 			dest = mod->init_layout.base
 				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
+		else if (!(shdr->sh_flags & SHF_EXECINSTR))
+			dest = mod->data_layout.base + shdr->sh_entsize;
 		else
 			dest = mod->core_layout.base + shdr->sh_entsize;
 
@@ -2863,7 +2867,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 7949dfd449c2..1a6b9573260b 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -50,19 +50,19 @@ void module_enable_ro(const struct module *mod, bool after_init)
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
 {
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


Return-Path: <linux-arch+bounces-10108-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7740A30042
	for <lists+linux-arch@lfdr.de>; Tue, 11 Feb 2025 02:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6B9188787C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Feb 2025 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEDC79C0;
	Tue, 11 Feb 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciByhu31"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D31EB186;
	Tue, 11 Feb 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237433; cv=none; b=uKU3hwSOhIh0yqPq7uZ+jZPYVbLGxiv2/mGQeSrIe97J6nRlo7yh+jNe5QE3wKm+AJwpkl6ZWqiqdk/Ibrob9ZlO29MEiolop4Rb2o1hkDUV//PpOJ//toFtW09lehvFmzrlL7lw3pC2aLgutS8hIZo/llXoFc44xLtWYge0yaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237433; c=relaxed/simple;
	bh=0Ne2S3BQpzWq1EWFDvAOKPc/FEtQwW4GDuJQ9pz0W+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGI/AHG7agz1/rAp2vNy1dHvTiVzG/9lmMXt1YILSUHktZierfqGHycHfhjpbZM/PAm12c09LsQncDPyG91qP3ZjqFj/tDQK9fo9LEkEscGgUsLeumuYuicPZ5Uy13jDITkyNY7xIOl8MIoGr2SZO9ryu7iR+yYwXa4+7nwYbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciByhu31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876DFC4CED1;
	Tue, 11 Feb 2025 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237433;
	bh=0Ne2S3BQpzWq1EWFDvAOKPc/FEtQwW4GDuJQ9pz0W+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ciByhu31uer9URMDJuQAW3ZIzXXMhmiW4hvX/hIric8HPY65IVx9hbiip+VHLil/A
	 A/z/BLznSU0PAHrdDj10hFA4T8pfD6vPJSnHs2zvpZeeRLoZUgPcqQ4g/dpnmOtlg3
	 w31ccnKksxBNGAZS88Uf3N3pSyONOtzHOOtJ+uuQsdBPT/1ZKU60e6E2qmj/mJwwR6
	 lwtGOBY24IKCLe6GkLZ8QPlYusgcBuXkX9GXz+KZKDSSN4Wp7briwDi1XgdmZiEmsm
	 tFxflsS71RhPQPXjL5s6MN85I0GWc2FFw3tEx+letJ812JfR4klD7mjle7JHMGmvsM
	 T4zGaovExP9Ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mcgrof@kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 16/21] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
Date: Mon, 10 Feb 2025 20:29:49 -0500
Message-Id: <20250211012954.4096433-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 4c56eb33e603c3b9eb4bd24efbfdd0283c1c37e4 ]

Linus observed that the symbol_request(utf8_data_table) call fails when
CONFIG_UNICODE=y and CONFIG_TRIM_UNUSED_KSYMS=y.

symbol_get() relies on the symbol data being present in the ksymtab for
symbol lookups. However, EXPORT_SYMBOL_GPL(utf8_data_table) is dropped
due to CONFIG_TRIM_UNUSED_KSYMS, as no module references it in this case.

Probably, this has been broken since commit dbacb0ef670d ("kconfig option
for TRIM_UNUSED_KSYMS").

This commit addresses the issue by leveraging modpost. Symbol names
passed to symbol_get() are recorded in the special .no_trim_symbol
section, which is then parsed by modpost to forcibly keep such symbols.
The .no_trim_symbol section is discarded by the linker scripts, so there
is no impact on the size of the final vmlinux or modules.

This commit cannot resolve the issue for direct calls to __symbol_get()
because the symbol name is not known at compile-time.

Although symbol_get() may eventually be deprecated, this workaround
should be good enough meanwhile.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/module.h            |  5 ++++-
 scripts/mod/modpost.c             | 35 +++++++++++++++++++++++++++++++
 scripts/mod/modpost.h             |  6 ++++++
 scripts/module.lds.S              |  1 +
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c7491..02a4adb4a9999 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1038,6 +1038,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.export_symbol)						\
+	*(.no_trim_symbol)						\
 	*(.modinfo)							\
 	/* ld.bfd warns about .gnu.version* even when not emitted */	\
 	*(.gnu.version*)						\
diff --git a/include/linux/module.h b/include/linux/module.h
index b3a6434353579..541e4357ea2f1 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -306,7 +306,10 @@ extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(__stringify(x))))
+#define symbol_get(x)	({ \
+	static const char __notrim[] \
+		__used __section(".no_trim_symbol") = __stringify(x); \
+	(typeof(&x))(__symbol_get(__stringify(x))); })
 
 /* modules using other modules: kdb wants to see this. */
 struct module_use {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7ea59dc4926b3..967d698e0c924 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -503,6 +503,9 @@ static int parse_elf(struct elf_info *info, const char *filename)
 			info->modinfo_len = sechdrs[i].sh_size;
 		} else if (!strcmp(secname, ".export_symbol")) {
 			info->export_symbol_secndx = i;
+		} else if (!strcmp(secname, ".no_trim_symbol")) {
+			info->no_trim_symbol = (void *)hdr + sechdrs[i].sh_offset;
+			info->no_trim_symbol_len = sechdrs[i].sh_size;
 		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
@@ -1562,6 +1565,14 @@ static void read_symbols(const char *modname)
 	/* strip trailing .o */
 	mod = new_module(modname, strlen(modname) - strlen(".o"));
 
+	/* save .no_trim_symbol section for later use */
+	if (info.no_trim_symbol_len) {
+		mod->no_trim_symbol = xmalloc(info.no_trim_symbol_len);
+		memcpy(mod->no_trim_symbol, info.no_trim_symbol,
+		       info.no_trim_symbol_len);
+		mod->no_trim_symbol_len = info.no_trim_symbol_len;
+	}
+
 	if (!mod->is_vmlinux) {
 		license = get_modinfo(&info, "license");
 		if (!license)
@@ -1724,6 +1735,28 @@ static void handle_white_list_exports(const char *white_list)
 	free(buf);
 }
 
+/*
+ * Keep symbols recorded in the .no_trim_symbol section. This is necessary to
+ * prevent CONFIG_TRIM_UNUSED_KSYMS from dropping EXPORT_SYMBOL because
+ * symbol_get() relies on the symbol being present in the ksymtab for lookups.
+ */
+static void keep_no_trim_symbols(struct module *mod)
+{
+	unsigned long size = mod->no_trim_symbol_len;
+
+	for (char *s = mod->no_trim_symbol; s; s = next_string(s , &size)) {
+		struct symbol *sym;
+
+		/*
+		 * If find_symbol() returns NULL, this symbol is not provided
+		 * by any module, and symbol_get() will fail.
+		 */
+		sym = find_symbol(s);
+		if (sym)
+			sym->used = true;
+	}
+}
+
 static void check_modname_len(struct module *mod)
 {
 	const char *mod_name;
@@ -2195,6 +2228,8 @@ int main(int argc, char **argv)
 		read_symbols_from_files(files_source);
 
 	list_for_each_entry(mod, &modules, list) {
+		keep_no_trim_symbols(mod);
+
 		if (mod->dump_file || mod->is_vmlinux)
 			continue;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index ffd0a52a606ef..59366f456b765 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -111,6 +111,8 @@ struct module_alias {
  *
  * @dump_file: path to the .symvers file if loaded from a file
  * @aliases: list head for module_aliases
+ * @no_trim_symbol: .no_trim_symbol section data
+ * @no_trim_symbol_len: length of the .no_trim_symbol section
  */
 struct module {
 	struct list_head list;
@@ -128,6 +130,8 @@ struct module {
 	// Actual imported namespaces
 	struct list_head imported_namespaces;
 	struct list_head aliases;
+	char *no_trim_symbol;
+	unsigned int no_trim_symbol_len;
 	char name[];
 };
 
@@ -141,6 +145,8 @@ struct elf_info {
 	char         *strtab;
 	char	     *modinfo;
 	unsigned int modinfo_len;
+	char         *no_trim_symbol;
+	unsigned int no_trim_symbol_len;
 
 	/* support for 32bit section numbers */
 
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index c2f80f9141d40..450f1088d5fd3 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -16,6 +16,7 @@ SECTIONS {
 		*(.discard)
 		*(.discard.*)
 		*(.export_symbol)
+		*(.no_trim_symbol)
 	}
 
 	__ksymtab		0 : ALIGN(8) { *(SORT(___ksymtab+*)) }
-- 
2.39.5



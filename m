Return-Path: <linux-arch+bounces-9957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F420BA24B73
	for <lists+linux-arch@lfdr.de>; Sat,  1 Feb 2025 19:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B121163143
	for <lists+linux-arch@lfdr.de>; Sat,  1 Feb 2025 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D91CAA95;
	Sat,  1 Feb 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDRlUn/L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473191BD01D;
	Sat,  1 Feb 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738435911; cv=none; b=GVBTvjiavU+hjHSsbYhUkW/Y9K/xGfkFqOUSOF7dNRXgZBgcHVJ5h1WoIDorwRSjehjLebFz+QP8QCOk07Nn5mXXkVoTZyavOobLcYwGhPy9OdXNQB1Sfc2wKcmgaQ6ZRlocb9c13fRUNuGL6dQu8eBLKAKXV4N+YbwHBIaIqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738435911; c=relaxed/simple;
	bh=I7kiEVnW8jRrnhHw67TzHWe0xarJxl/6zRXpMspPRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sa4fSAX6auARScLKOzZw0gqBGjW82G03ZQYaDFpSJw5WL006uh3GAlpRQXxceTvGQvBQbh0YwrVXI5LZ7UivY4nzluGgj3Ti0U92St9t+SVK1N8eoGWmgX2+YEC7vYGEP+EXqA+GCdtQxiSjKkD1NdVpFetX/2o5DyvXBMSBGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDRlUn/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEAEC4CED3;
	Sat,  1 Feb 2025 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738435910;
	bh=I7kiEVnW8jRrnhHw67TzHWe0xarJxl/6zRXpMspPRvA=;
	h=From:To:Cc:Subject:Date:From;
	b=QDRlUn/L5H2HOk3KB0WxhPbjFzUMLq5F66buBhlXO+q1lrh3Bbq1MS4JpizAmwTcj
	 iDXt7AAH+b05pVaQNjnPY3V/pqRTNoxyJFxW3iTifFg4u2T1npDwRA81/woM/kQZcW
	 UiSXkL6zz6x+pFPryHFFOPq9G6BZdWQSthBJ242Lnf31awwOsEAmtJnJsInyMnJpbv
	 jE4CqlFBWUF6wdKK0fJwOsX/ONecNYMPnTGZP6PRFPb3BRDERXXa1tSM77RvIX/WMW
	 dgFpYwd4YpnRaYqG2d1WGKv4uTQr0JqNxvoYnxVHIamDVdooVIse+b/1wQ90eC/AA6
	 BT2SACyw6xqng==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH v3] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
Date: Sun,  2 Feb 2025 03:51:41 +0900
Message-ID: <20250201185143.1745708-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

Changes in v3:
 - More precise check in case symbol_get() is called from a module

Changes in v2:
 - Call keep_no_trim_symbols() for modules as well.
   EXPORT_SYMBOL() may disppear if symbol_get() calls a symbol
   within this same module.

 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/module.h            |  5 ++++-
 scripts/mod/modpost.c             | 35 +++++++++++++++++++++++++++++++
 scripts/mod/modpost.h             |  6 ++++++
 scripts/module.lds.S              |  1 +
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c749..02a4adb4a999 100644
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
index 23792d5d7b74..30e5b19bafa9 100644
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
index e18ae7dc8140..36b28987a2f0 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -507,6 +507,9 @@ static int parse_elf(struct elf_info *info, const char *filename)
 			info->modinfo_len = sechdrs[i].sh_size;
 		} else if (!strcmp(secname, ".export_symbol")) {
 			info->export_symbol_secndx = i;
+		} else if (!strcmp(secname, ".no_trim_symbol")) {
+			info->no_trim_symbol = (void *)hdr + sechdrs[i].sh_offset;
+			info->no_trim_symbol_len = sechdrs[i].sh_size;
 		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
@@ -1566,6 +1569,14 @@ static void read_symbols(const char *modname)
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
@@ -1728,6 +1739,28 @@ static void handle_white_list_exports(const char *white_list)
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
@@ -2254,6 +2287,8 @@ int main(int argc, char **argv)
 		read_symbols_from_files(files_source);
 
 	list_for_each_entry(mod, &modules, list) {
+		keep_no_trim_symbols(mod);
+
 		if (mod->dump_file || mod->is_vmlinux)
 			continue;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index ffd0a52a606e..59366f456b76 100644
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
index c2f80f9141d4..450f1088d5fd 100644
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
2.43.0



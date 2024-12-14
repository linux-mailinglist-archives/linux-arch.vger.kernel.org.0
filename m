Return-Path: <linux-arch+bounces-9391-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1759F1DDB
	for <lists+linux-arch@lfdr.de>; Sat, 14 Dec 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C90B167D01
	for <lists+linux-arch@lfdr.de>; Sat, 14 Dec 2024 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D831531DC;
	Sat, 14 Dec 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2AqL/qT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD3433D8;
	Sat, 14 Dec 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734170359; cv=none; b=qknUL0B7ed7Z2lHpuGuM9ZMPlbzKc4QZpn62wgSd/lyavkJZclLZkclsHdGR4+C46+LZnzmLZdcIpnWwKdU1+0BaEZD7ReNVHaapJ9DJFB/JMCI2wqmnB0j4MJ7rxO01XSMukflhjABsql/KW4NV5/iKv0Z2koKPT0LLaHzujvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734170359; c=relaxed/simple;
	bh=zPCYquVMyHszbkGVcE2/GM5XO92yWX3+ZbBjTyw9TYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQZlDLYgDIlt1VnnwtGXZnp8mzXQImuZbwyM3DlvFxTLrsEUEqMOWG8DVclhgx1QsxntQRtrFgoJCuyVaQGH8tTQIxVcy6BFYJRNZQQymCZQORXDgfIMSzHOoHlXUBOGpC0C+DTGZmzEjh4Xx4eosv7lqxYBLI8jdetuDvVDalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2AqL/qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D19C4CED1;
	Sat, 14 Dec 2024 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734170358;
	bh=zPCYquVMyHszbkGVcE2/GM5XO92yWX3+ZbBjTyw9TYw=;
	h=From:To:Cc:Subject:Date:From;
	b=Z2AqL/qTmZhQOqXXapTMVn6uJAQMYGDEeYuppOZtY7zRTDvZYX2h8E2e2zJRJJimz
	 WUaIGMqcYk0nTWddN56atlY4MAPL7yvyYlL2qAOl/XLndN5tUDO/zXySB/mQyVk/P+
	 5V5rRQ7qVlvvlDqD/Bv9wFrHwa5S/N+Q83rYKxr7rGVX4yEOILJ8WSOTAM5mzLblBr
	 4c19sgVgviVuf7D+PD1s2ndcYR9u9cLAxZRgd+RNAGy8Whz9o8FaxGloLX73XKyvqX
	 xhHRloyqTRPFQLr0IOoc4sdbpLJAXxdvUjhBzS//EflGISnB2H2vLV5t1fukQ2joXS
	 81tFQqpI0TC9w==
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
Subject: [PATCH] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
Date: Sat, 14 Dec 2024 18:58:57 +0900
Message-ID: <20241214095900.42990-1-masahiroy@kernel.org>
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

 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/module.h            |  5 ++++-
 scripts/mod/modpost.c             | 25 ++++++++++++++++++++++++-
 scripts/mod/modpost.h             |  2 ++
 scripts/module.lds.S              |  1 +
 5 files changed, 32 insertions(+), 2 deletions(-)

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
index 94acbacdcdf1..405ca74c0340 100644
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
index 94ee49207a45..82dde0342ad5 100644
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
@@ -1443,6 +1446,24 @@ static char *remove_dot(char *s)
 	return s;
 }
 
+/*
+ * Keep symbols recorded in the .no_trim_symbol section. This is necessary to
+ * prevent CONFIG_TRIM_UNUSED_KSYMS from dropping EXPORT_SYMBOL because
+ * symbol_get() relies on the symbol being present in the ksymtab for lookups.
+ */
+static void keep_no_trim_symbols(const struct elf_info *info)
+{
+	unsigned long size = info->no_trim_symbol_len;
+
+	for (char *s = info->no_trim_symbol; s; s = next_string(s , &size)) {
+		struct symbol *sym;
+
+		sym = find_symbol(s);
+		if (sym)
+			sym->used = true;
+	}
+}
+
 /*
  * The CRCs are recorded in .*.cmd files in the form of:
  * #SYMVER <name> <crc>
@@ -1594,7 +1615,9 @@ static void read_symbols(const char *modname)
 
 	check_sec_ref(mod, &info);
 
-	if (!mod->is_vmlinux) {
+	if (mod->is_vmlinux) {
+		keep_no_trim_symbols(&info);
+	} else {
 		version = get_modinfo(&info, "version");
 		if (version || all_versions)
 			get_src_version(mod->name, mod->srcversion,
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 8b72c227ebf4..cfcda357ccb2 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -127,6 +127,8 @@ struct elf_info {
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



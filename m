Return-Path: <linux-arch+bounces-9392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478499F1E29
	for <lists+linux-arch@lfdr.de>; Sat, 14 Dec 2024 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E5D188A611
	for <lists+linux-arch@lfdr.de>; Sat, 14 Dec 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B718A92C;
	Sat, 14 Dec 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1DA2SJW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2415666D;
	Sat, 14 Dec 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734173855; cv=none; b=dacRksM4p0Ou7Dvmez6bYpAfTGeosuYnqY6+B2AsEUfBXX4floFXMYHChe4T/c9CDO+YLnYezkPH2AV+/XWDboVcFmsZcSixHgH+L60ftMMWiwvHzCkWSz+7mHWRl6b6G0/ALO8X/VrpcG7A0qUfb5AUH43lYx6O+Oc5t3XWenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734173855; c=relaxed/simple;
	bh=1UH1d6RvQEAx99qEool6QwQZ14CsvkKmJUlkp38qcds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vl5FWJzszvX3Pvyr4dVdtZLprIMh7MK4qRZEhruB602IuxnuXFIFhoeBmAgYgQ++9LVn5Xds1smlGFznG8mPdVFEzuDQBwijo2JXMO22ylDGH0rSuG0W+WYEWjZ+fIyyOWyaNIFdKobbJKMIywEpjuCFDGgn1H0nCD/jP31kzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1DA2SJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DB4C4CED1;
	Sat, 14 Dec 2024 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734173855;
	bh=1UH1d6RvQEAx99qEool6QwQZ14CsvkKmJUlkp38qcds=;
	h=From:To:Cc:Subject:Date:From;
	b=F1DA2SJWpmQozl7GLjxxjRJ6PrWsvsn4ypA19l1fR0oGrybppMQlripztl7sx5tgR
	 WenxIQm2w+dBPFq59pVAeumoAqEAGUu3GhJQxbULF3SNOTkZsIM3VeFZfDu3KmdnRJ
	 oIfEXNtQJE4W7UhqISh9Gt/0TvTcsB/0i8u1G3Zv2zxOoDGxEdbxIc1jTou5pWM2qh
	 T3gE+53Rw3lXCd63Og918pj7mbfZhAk72CwnFhOCsnlDMnispqJf9kdabmRIRwCiAI
	 bON/jHpyJ+w9N3Bk3Kp/3DFyWLdECmDTpoVlxlrogBgkEuJT/Oa68ZDf83sDSuE5r2
	 hjUk+ufUKbW8Q==
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
Subject: [PATCH v2] kbuild: keep symbols for symbol_get() even with CONFIG_TRIM_UNUSED_KSYMS
Date: Sat, 14 Dec 2024 19:57:20 +0900
Message-ID: <20241214105726.92557-1-masahiroy@kernel.org>
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

Changes in v2:
 - Call keep_no_trim_symbols() for modules as well.
   EXPORT_SYMBOL() may disppear if symbol_get() calls a symbol
   within this same module.

 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/module.h            |  5 ++++-
 scripts/mod/modpost.c             | 27 +++++++++++++++++++++++++++
 scripts/mod/modpost.h             |  2 ++
 scripts/module.lds.S              |  1 +
 5 files changed, 35 insertions(+), 1 deletion(-)

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
index 94ee49207a45..27bded11875e 100644
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
@@ -1443,6 +1446,29 @@ static char *remove_dot(char *s)
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
+		/*
+		 * find_symbol() returns NULL if the symbol is exported by
+		 * another module that has not been parsed yet. This is OK
+		 * because sym->used will be set to true later in this case.
+		 */
+		sym = find_symbol(s);
+		if (sym)
+			sym->used = true;
+	}
+}
+
 /*
  * The CRCs are recorded in .*.cmd files in the form of:
  * #SYMVER <name> <crc>
@@ -1601,6 +1627,7 @@ static void read_symbols(const char *modname)
 					sizeof(mod->srcversion) - 1);
 	}
 
+	keep_no_trim_symbols(&info);
 	parse_elf_finish(&info);
 
 	if (modversions) {
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



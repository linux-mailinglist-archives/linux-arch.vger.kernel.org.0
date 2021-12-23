Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8747DBC6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbhLWAXi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:23:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:42719 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345558AbhLWAXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219004; x=1671755004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AWx+QB6HIyDDIu9Ym5IUpqB3nDldtSibW4hj/k1NkSs=;
  b=P73AwlV6VZsNI9DXkBWLZ7LjEpB7eri1ruebCmohJdv/zj3DqBLKR4zV
   ebJ9X9HGm6yvxXJ7OeQzdlLNHY501iR1IClw6lO8ZxeBo2BWzfDV/Bkl5
   YBtmNBRoTEnu5J/CW86u9rLnYBQ0OMk74ZtkNAcrG2I4dwNL88WN92y++
   GrfBwZvxWBa5koO9/6NJa5Z6jB4ift5LvU7Cv2td1dii/Ysi4wUoG0Mme
   BDchq56nb3hvB7L/nU+Mx6GWnt28Au8PN1y5udK9HalsljrN3ID22m1P1
   HFc7n/sGwsSKoL8HFgv+oBdJxSf0aoEKQnBIQxsJbMlaLpItWjnt9uakP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="304097780"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="304097780"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="756561065"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga006.fm.intel.com with ESMTP; 22 Dec 2021 16:23:14 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N797032467;
        Thu, 23 Dec 2021 00:23:11 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 02/15] livepatch: use `-z unique-symbol` if available to nuke pos-based search
Date:   Thu, 23 Dec 2021 01:21:56 +0100
Message-Id: <20211223002209.1092165-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Position-based search, which means that if we have several symbols
with the same name, we additionally need to provide an "index" of
the desired symbol, is fragile. Par exemple, it breaks when two
symbols with the same name are located in different sections.

Since a while, LD has a flag `-z unique-symbol` which appends
numeric suffixes to the functions with the same name (in symtab
and strtab).
Check for its availability and always prefer when the livepatching
is on. This needs a little adjustment to the modpost to make it
strip suffixes before adding exports.

depmod needs some treatment as well, tho its false-positibe warnings
about unknown symbols are harmless and don't alter the return code.
And there is a bunch more livepatch code to optimize-out after
introducing this, but let's leave it for later.

Suggested-by: H.J. Lu <hjl.tools@gmail.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                |  6 ++++++
 init/Kconfig            |  3 +++
 kernel/livepatch/core.c | 20 +++++++++++++-------
 scripts/mod/modpost.c   | 42 ++++++++++++++++++++++-------------------
 4 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index d85f1ff79f5c..9dc15c67d132 100644
--- a/Makefile
+++ b/Makefile
@@ -882,6 +882,12 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
 KBUILD_CFLAGS += -fno-inline-functions-called-once
 endif
 
+# Prefer linking with the `-z unique-symbol` if available, this eliminates
+# position-based search
+ifeq ($(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)$(CONFIG_LIVEPATCH),yy)
+KBUILD_LDFLAGS += -z unique-symbol
+endif
+
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d..37926d19a74a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -86,6 +86,9 @@ config CC_HAS_ASM_INLINE
 config CC_HAS_NO_PROFILE_FN_ATTR
 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
 
+config LD_HAS_Z_UNIQUE_SYMBOL
+	def_bool $(ld-option,-z unique-symbol)
+
 config CONSTRUCTORS
 	bool
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 335d988bd811..b2c787297f85 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -143,11 +143,13 @@ static int klp_find_callback(void *data, const char *name,
 	args->count++;
 
 	/*
-	 * Finish the search when the symbol is found for the desired position
-	 * or the position is not defined for a non-unique symbol.
+	 * Finish the search when unique symbol names are enabled
+	 * or the symbol is found for the desired position or the
+	 * position is not defined for a non-unique symbol.
 	 */
-	if ((args->pos && (args->count == args->pos)) ||
-	    (!args->pos && (args->count > 1)))
+	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL) ||
+	    (args->pos && args->count == args->pos) ||
+	    (!args->pos && args->count > 1))
 		return 1;
 
 	return 0;
@@ -171,17 +173,21 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 
 	/*
 	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
-	 * otherwise ensure the symbol position count matches sympos.
+	 * otherwise ensure the symbol position count matches sympos. If the LD
+	 * `-z unique` flag is enabled, sympos checks are not relevant.
 	 */
-	if (args.addr == 0)
+	if (args.addr == 0) {
 		pr_err("symbol '%s' not found in symbol table\n", name);
-	else if (args.count > 1 && sympos == 0) {
+	} else if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL)) {
+		goto out_ok;
+	} else if (args.count > 1 && sympos == 0) {
 		pr_err("unresolvable ambiguity for symbol '%s' in object '%s'\n",
 		       name, objname);
 	} else if (sympos != args.count && sympos > 0) {
 		pr_err("symbol position %lu for symbol '%s' in object '%s' not found\n",
 		       sympos, name, objname ? objname : "vmlinux");
 	} else {
+out_ok:
 		*addr = args.addr;
 		return 0;
 	}
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ccc6d35580f2..f39cc73a082c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -689,11 +689,28 @@ static void handle_modversion(const struct module *mod,
 	sym_set_crc(symname, crc);
 }
 
+static char *remove_dot(char *s)
+{
+	size_t n = strcspn(s, ".");
+
+	if (n && s[n]) {
+		size_t m = strspn(s + n + 1, "0123456789");
+
+		if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
+			s[n] = 0;
+
+		/* strip trailing .lto */
+		if (strends(s, ".lto"))
+			s[strlen(s) - 4] = '\0';
+	}
+
+	return s;
+}
+
 static void handle_symbol(struct module *mod, struct elf_info *info,
 			  const Elf_Sym *sym, const char *symname)
 {
 	enum export export;
-	const char *name;
 
 	if (strstarts(symname, "__ksymtab"))
 		export = export_from_secname(info, get_secindex(info, sym));
@@ -734,8 +751,11 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 	default:
 		/* All exported symbols */
 		if (strstarts(symname, "__ksymtab_")) {
-			name = symname + strlen("__ksymtab_");
-			sym_add_exported(name, mod, export);
+			char *name;
+
+			name = NOFAIL(strdup(symname + strlen("__ksymtab_")));
+			sym_add_exported(remove_dot(name), mod, export);
+			free(name);
 		}
 		if (strcmp(symname, "init_module") == 0)
 			mod->has_init = 1;
@@ -1965,22 +1985,6 @@ static void check_sec_ref(struct module *mod, const char *modname,
 	}
 }
 
-static char *remove_dot(char *s)
-{
-	size_t n = strcspn(s, ".");
-
-	if (n && s[n]) {
-		size_t m = strspn(s + n + 1, "0123456789");
-		if (m && (s[n + m + 1] == '.' || s[n + m + 1] == 0))
-			s[n] = 0;
-
-		/* strip trailing .lto */
-		if (strends(s, ".lto"))
-			s[strlen(s) - 4] = '\0';
-	}
-	return s;
-}
-
 static void read_symbols(const char *modname)
 {
 	const char *symname;
-- 
2.33.1


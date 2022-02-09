Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA24AFCBC
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiBITBz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbiBITAp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E5C03C19D;
        Wed,  9 Feb 2022 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433236; x=1675969236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TFoJ8hml7DfFEwN1MeCftGLxN9fAc0FL9jRFOXIT44=;
  b=iY3BbgsG9rBd08M2OkWr5HiRdpN7sRL89OQ1Ycj1kYMbTokO//Hg/bi8
   djm+x+5+OjUKdZRfKLbFvBc0kh5JgcEy7tRBREWCZtuwkR+vBQiRaNGVX
   mGZ4RX7egvS6AXw4tBwFz60XQDz2BHubi3dTsG3MmfpIXlE9MT8N7UtEI
   gNYgdAToX77bcTcogrdS2SUuXFMGPx0GOcoStgqujJr69rG1+hE3AMlqi
   Peg6lPrGmthtRR0ajHb8je/7QkUtIxNfVbbEcSriSTHB5kAaCkZxH4YuA
   dS1Yu/mClY9RB4E2gPPi6OTk1dCWcutj6bGsMiFxHqiNfLcdjQ+uO5z0G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="232869378"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="232869378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="541248491"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2022 10:58:52 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQP031082;
        Wed, 9 Feb 2022 18:58:50 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v10 02/15] livepatch: avoid position-based search if `-z unique-symbol` is available
Date:   Wed,  9 Feb 2022 19:57:39 +0100
Message-Id: <20220209185752.1226407-3-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Position-based search, which means that if there are several symbols
with the same name, the user needs to additionally provide the
"index" of a desired symbol, is fragile. For example, it breaks
when two symbols with the same name are located in different
sections.

Since a while, LD has a flag `-z unique-symbol` which appends
numeric suffixes to the functions with the same name (in symtab
and strtab). It can be used to effectively prevent from having
any ambiguity when referring to a symbol by its name.
Check for its availability and always prefer when the livepatching
is on. It can be used unconditionally later on after broader testing
on a wide variety of machines, but for now let's stick to the actual
CONFIG_LIVEPATCH=y case, which is true for most of distro configs
anyways.
This needs a little adjustment to the modpost to make it strip
suffixes before adding exports. depmod needs some treatment as well,
tho its false-positive warnings about unknown symbols are harmless
and don't alter the return code.

There is probably a bunch more livepatch code to optimize-out after
introducing this, leave it for later as well.

Suggested-by: H.J. Lu <hjl.tools@gmail.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                |  6 ++++++
 init/Kconfig            |  3 +++
 kernel/livepatch/core.c | 17 +++++++++++++----
 scripts/mod/modpost.c   | 42 ++++++++++++++++++++++-------------------
 4 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index ceb987e5c87b..fa9f947c9839 100644
--- a/Makefile
+++ b/Makefile
@@ -871,6 +871,12 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
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
index e9119bf54b1f..8e900d17d42b 100644
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
index 585494ec464f..7a330465a8c7 100644
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
@@ -169,6 +171,13 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 	else
 		kallsyms_on_each_symbol(klp_find_callback, &args);
 
+	/*
+	 * If the LD's `-z unique-symbol` flag is available and enabled,
+	 * sympos checks are not relevant.
+	 */
+	if (IS_ENABLED(CONFIG_LD_HAS_Z_UNIQUE_SYMBOL))
+		sympos = 0;
+
 	/*
 	 * Ensure an address was found. If sympos is 0, ensure symbol is unique;
 	 * otherwise ensure the symbol position count matches sympos.
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4648b7afe5cc..ec521ccebea6 100644
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
@@ -1980,22 +2000,6 @@ static void check_sec_ref(struct module *mod, const char *modname,
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
2.34.1


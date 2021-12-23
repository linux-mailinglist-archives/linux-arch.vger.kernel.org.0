Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECCF47DBCE
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbhLWAXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:23:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:24287 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345503AbhLWAXd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219013; x=1671755013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4waWPSOn2iXftgNDJfpbm8+6fkn7TwbPenUwqBmKBg=;
  b=bF2o32PFWOb2+s+7HKbGL7wKxi3/wvf5recV9AnSjyIwdyvHKPNFkjEv
   DR+vUkMPKivP89Fls/3GLHsIS2WYr8/5h1hcoyvY3ublNqFfWyAJ92WE9
   e6DdsXewHjKXXX1e+KEqKaAcUy3oVZstvSZzxQu5ChDArRQ8FHoOjaXr5
   t/Fc8yiS45fq8puR0XSzK664AS2q6fQRliXCm2Pjcm9hGUvOt646p1wI2
   4MoEBbRJ+d0L+fYnOzYm4Molq/hWXjLU6anD2QAXowLUOatArRiKsmDAX
   0Qd5J70YDqWWAwLEquhXtsu0f7eGSgbxlptG6u76h9WO2EafAZXHpfSNZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="238264212"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="238264212"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="570733414"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2021 16:23:25 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79D032467;
        Thu, 23 Dec 2021 00:23:23 GMT
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
Subject: [PATCH v9 08/15] x86/tools: Add relative relocs for randomized functions
Date:   Thu, 23 Dec 2021 01:22:02 +0100
Message-Id: <20211223002209.1092165-9-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

When reordering functions, the relative offsets for relocs that
are either in the randomized sections, or refer to the randomized
sections will need to be adjusted. Add code to detect whether a
reloc satisfies these cases, and if so, add them to the appropriate
reloc list.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[ alobakin: don't split relocs' usage string across lines ]
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/boot/compressed/Makefile |  7 ++++++-
 arch/x86/tools/relocs.c           | 32 +++++++++++++++++++++++++++----
 arch/x86/tools/relocs.h           |  4 ++--
 arch/x86/tools/relocs_common.c    | 14 +++++++++-----
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 4bf32db56010..2cf809f5c642 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -107,6 +107,11 @@ $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
+
+ifdef CONFIG_FG_KASLR
+RELOCS_ARGS += --fg-kaslr
+endif
+
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
@@ -114,7 +119,7 @@ targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relo
 
 CMD_RELOCS = arch/x86/tools/relocs
 quiet_cmd_relocs = RELOCS  $@
-      cmd_relocs = $(CMD_RELOCS) $< > $@;$(CMD_RELOCS) --abs-relocs $<
+      cmd_relocs = $(CMD_RELOCS) $(RELOCS_ARGS) $< > $@;$(CMD_RELOCS) $(RELOCS_ARGS) --abs-relocs $<
 $(obj)/vmlinux.relocs: vmlinux FORCE
 	$(call if_changed,relocs)
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c736cf2ac76b..8aa1f39be561 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -45,6 +45,8 @@ struct section {
 };
 static struct section *secs;
 
+static int fgkaslr_mode;
+
 static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 /*
  * Following symbols have been audited. There values are constant and do
@@ -823,6 +825,24 @@ static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 		strncmp(symname, "init_per_cpu_", 13);
 }
 
+static int is_function_section(struct section *sec)
+{
+	if (!fgkaslr_mode)
+		return 0;
+
+	return !strncmp(sec_name(sec->shdr.sh_info), ".text.", 6);
+}
+
+static int is_randomized_sym(ElfW(Sym) *sym)
+{
+	if (!fgkaslr_mode)
+		return 0;
+
+	if (sym->st_shndx > shnum)
+		return 0;
+
+	return !strncmp(sec_name(sym_index(sym)), ".text.", 6);
+}
 
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
@@ -848,12 +868,15 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
 		/*
-		 * PC relative relocations don't need to be adjusted unless
-		 * referencing a percpu symbol.
+		 * we need to keep pc relative relocations for sections which
+		 * might be randomized, and for the percpu section.
+		 * We also need to keep relocations for any offset which might
+		 * reference an address in a section which has been randomized.
 		 *
 		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
 		 */
-		if (is_percpu_sym(sym, symname))
+		if (is_function_section(sec) || is_randomized_sym(sym) ||
+		    is_percpu_sym(sym, symname))
 			add_reloc(&relocs32neg, offset);
 		break;
 
@@ -1168,8 +1191,9 @@ static void print_reloc_info(void)
 
 void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
-	     int show_reloc_info)
+	     int show_reloc_info, int fgkaslr)
 {
+	fgkaslr_mode = fgkaslr;
 	regex_init(use_real_mode);
 	read_ehdr(fp);
 	read_shdrs(fp);
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 4c49c82446eb..269db511b243 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -32,8 +32,8 @@ enum symtype {
 
 void process_32(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int fgkaslr);
 void process_64(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int fgkaslr);
 #endif /* RELOCS_H */
diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
index 6634352a20bc..d6acda36575a 100644
--- a/arch/x86/tools/relocs_common.c
+++ b/arch/x86/tools/relocs_common.c
@@ -12,14 +12,13 @@ void die(char *fmt, ...)
 
 static void usage(void)
 {
-	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode]" \
-	    " vmlinux\n");
+	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode|--fg-kaslr] vmlinux\n");
 }
 
 int main(int argc, char **argv)
 {
 	int show_absolute_syms, show_absolute_relocs, show_reloc_info;
-	int as_text, use_real_mode;
+	int as_text, use_real_mode, fgkaslr_opt;
 	const char *fname;
 	FILE *fp;
 	int i;
@@ -30,6 +29,7 @@ int main(int argc, char **argv)
 	show_reloc_info = 0;
 	as_text = 0;
 	use_real_mode = 0;
+	fgkaslr_opt = 0;
 	fname = NULL;
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -54,6 +54,10 @@ int main(int argc, char **argv)
 				use_real_mode = 1;
 				continue;
 			}
+			if (strcmp(arg, "--fg-kaslr") == 0) {
+				fgkaslr_opt = 1;
+				continue;
+			}
 		}
 		else if (!fname) {
 			fname = arg;
@@ -75,11 +79,11 @@ int main(int argc, char **argv)
 	if (e_ident[EI_CLASS] == ELFCLASS64)
 		process_64(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, fgkaslr_opt);
 	else
 		process_32(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, fgkaslr_opt);
 	fclose(fp);
 	return 0;
 }
-- 
2.33.1


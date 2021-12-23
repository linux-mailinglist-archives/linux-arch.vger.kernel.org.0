Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458E47DBF9
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhLWA0f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:26:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:53166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345757AbhLWAYC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219042; x=1671755042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+KrOqIqb4aeQ6x0G1EHmcHniPYRjIzt9aPk8YuSf44w=;
  b=UmzSkarp70lbdny1BCH/IXH1WJ2gz2gDlj7yFWGO4w4MDmVUaMWT5H0K
   6vE84T+303rLuEt1zi2ndrBGn+gw/te5BrLOwcB7y88tS3Sjfc5SFg8qX
   ZJdqL9JH1hrMtILIvHkxDmonTLd3LoPL5FyYz4TPrEluYnz9rClkUGB2D
   RDybQ/H9XoQkw/YZqS6wD920xpLGwsjPYcA94EH4UFUvkX4aziDQk362h
   Dhbz7N+hnFpBjUst2URYOgPrptDHVLTRuva5kaBVadmk/bXkq5n5MATeq
   ggW8WcdGAQPTEawosQOHL9uwP6nN2Js6+UY94scf156F9B2r8EZM40kEC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240533510"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="240533510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="521881976"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 22 Dec 2021 16:23:33 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79H032467;
        Thu, 23 Dec 2021 00:23:31 GMT
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
Subject: [PATCH v9 12/15] module: Reorder functions
Date:   Thu, 23 Dec 2021 01:22:06 +0100
Message-Id: <20211223002209.1092165-13-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Introduce a new config option to allow modules to be re-ordered
by function. This option can be enabled independently of the
kernel text KASLR or FG_KASLR settings so that it can be used
by architectures that do not support either of these features.
This option will be selected by default if CONFIG_FG_KASLR is
selected.

If a module has functions split out into separate text sections
(i.e. compiled with the -ffunction-sections flag), reorder the
functions to provide some code diversification to modules.

alobakin:
Make it work with ClangCFI -- in such builds, .text section must
always come first and be page-aligned. Exclude it from the shuffle
list and leave as it is.
Make this feature depend on `-z unique-symbol` as well, due to the
very same reasons.
Traditionally, use common shuffle_array() from <linux/random.h>.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Acked-by: Jessica Yu <jeyu@kernel.org>
Tested-by: Jessica Yu <jeyu@kernel.org>
Reported-by: kernel test robot <lkp@intel.com> # swap.cocci
Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                |  6 +++-
 include/linux/linkage.h |  1 +
 init/Kconfig            | 14 ++++++++
 kernel/module.c         | 73 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3346269341d4..74d270c77d96 100644
--- a/Makefile
+++ b/Makefile
@@ -900,7 +900,7 @@ export SECSUBST_AFLAGS
 endif
 
 # Same for modules. LD DCE doesn't work for them, thus not checking for it
-ifneq ($(CONFIG_LTO_CLANG),)
+ifneq ($(CONFIG_MODULE_FG_KASLR)$(CONFIG_LTO_CLANG),)
 KBUILD_AFLAGS_MODULE += -Wa,--sectname-subst
 KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
 endif
@@ -909,6 +909,10 @@ endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
 # ClangLTO implies `-ffunction-sections -fdata-sections`, no need
 # to specify them manually and trigger a pointless full rebuild
 ifndef CONFIG_LTO_CLANG
+ifdef CONFIG_MODULE_FG_KASLR
+KBUILD_CFLAGS_MODULE += -ffunction-sections
+endif
+
 ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_FG_KASLR),)
 KBUILD_CFLAGS_KERNEL += -ffunction-sections
 endif
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index f3c96fb6a534..deb26069278a 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -80,6 +80,7 @@
 #if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
     ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
      (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
+     (defined(CONFIG_MODULE_FG_KASLR) && defined(MODULE)) || \
      (defined(CONFIG_LTO_CLANG)))
 
 #define SYM_PUSH_SECTION(name)				\
diff --git a/init/Kconfig b/init/Kconfig
index 381b063b4925..38c82e21efd7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2376,6 +2376,20 @@ config UNUSED_KSYMS_WHITELIST
 	  one per line. The path can be absolute, or relative to the kernel
 	  source tree.
 
+config MODULE_FG_KASLR
+	bool "Module Function Granular Layout Randomization"
+	depends on $(cc-option,-ffunction-sections)
+	depends on LD_HAS_Z_UNIQUE_SYMBOL || !LIVEPATCH
+	default FG_KASLR
+	depends on BROKEN
+	help
+	  This option randomizes the module text section by reordering the text
+	  section by function at module load time. In order to use this
+	  feature, the module must have been compiled with the
+	  -ffunction-sections compiler flag.
+
+	  If unsure, say N.
+
 endif # MODULES
 
 config MODULES_TREE_LOOKUP
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..802e1098eaf4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -57,6 +57,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/random.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -1527,7 +1528,7 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 
 	for (section = 0; section < sect_attrs->nsections; section++)
 		kfree(sect_attrs->attrs[section].battr.attr.name);
-	kfree(sect_attrs);
+	kvfree(sect_attrs);
 }
 
 static void add_sect_attrs(struct module *mod, const struct load_info *info)
@@ -1544,7 +1545,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
 			sizeof(sect_attrs->grp.bin_attrs[0]));
 	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
-	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
+	sect_attrs = kvzalloc(size[0] + size[1], GFP_KERNEL);
 	if (sect_attrs == NULL)
 		return;
 
@@ -2416,6 +2417,71 @@ static bool module_init_layout_section(const char *sname)
 	return module_init_section(sname);
 }
 
+/*
+ * randomize_text()
+ * Look through the core section looking for executable code sections.
+ * Store sections in an array and then shuffle the sections
+ * to reorder the functions.
+ */
+static void randomize_text(struct module *mod, struct load_info *info)
+{
+	int max_sections = info->hdr->e_shnum;
+	int num_text_sections = 0;
+	Elf_Shdr **text_list;
+	int i, size;
+
+	text_list = kvmalloc_array(max_sections, sizeof(*text_list), GFP_KERNEL);
+	if (!text_list)
+		return;
+
+	for (i = 0; i < max_sections; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+		const char *sname = info->secstrings + shdr->sh_name;
+
+		if (!(shdr->sh_flags & SHF_ALLOC) ||
+		    !(shdr->sh_flags & SHF_EXECINSTR) ||
+		    (shdr->sh_flags & ARCH_SHF_SMALL) ||
+		    module_init_layout_section(sname))
+			continue;
+
+		/*
+		 * With CONFIG_CFI_CLANG, .text with __cfi_check() must come
+		 * before any other text sections, and be aligned to PAGE_SIZE.
+		 * Don't include it in the shuffle list.
+		 */
+		if (IS_ENABLED(CONFIG_CFI_CLANG) && !strcmp(sname, ".text"))
+			continue;
+
+		if (!num_text_sections)
+			size = shdr->sh_entsize;
+
+		text_list[num_text_sections] = shdr;
+		num_text_sections++;
+	}
+
+	if (!num_text_sections)
+		goto exit;
+
+	shuffle_array(text_list, num_text_sections);
+
+	for (i = 0; i < num_text_sections; i++) {
+		Elf_Shdr *shdr = text_list[i];
+
+		/*
+		 * get_offset has a section index for it's last
+		 * argument, that is only used by arch_mod_section_prepend(),
+		 * which is only defined by parisc. Since this type
+		 * of randomization isn't supported on parisc, we can
+		 * safely pass in zero as the last argument, as it is
+		 * ignored.
+		 */
+		shdr->sh_entsize = get_offset(mod, &size, shdr, 0);
+	}
+
+exit:
+	kvfree(text_list);
+}
+
 /*
  * Lay out the SHF_ALLOC sections in a way not dissimilar to how ld
  * might -- code, read-only data, read-write data, small data.  Tally
@@ -2510,6 +2576,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			break;
 		}
 	}
+
+	if (IS_ENABLED(CONFIG_MODULE_FG_KASLR))
+		randomize_text(mod, info);
 }
 
 static void set_license(struct module *mod, const char *license)
-- 
2.33.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D47D466CF2
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 23:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377351AbhLBWhi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 17:37:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:48270 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349556AbhLBWg7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="223730467"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="223730467"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:33:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513054743"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2021 14:33:11 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYc028552;
        Thu, 2 Dec 2021 22:33:09 GMT
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
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v8 11/14] module: Reorder functions
Date:   Thu,  2 Dec 2021 23:32:11 +0100
Message-Id: <20211202223214.72888-12-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202223214.72888-1-alexandr.lobakin@intel.com>
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
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

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Acked-by: Jessica Yu <jeyu@kernel.org>
Tested-by: Jessica Yu <jeyu@kernel.org>
Reported-by: kernel test robot <lkp@intel.com> # swap.cocci
[ alobakin: make it work with ClangCFI ]
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 Makefile                |  4 ++
 init/Kconfig            | 12 ++++++
 kernel/kallsyms.c       |  4 +-
 kernel/livepatch/core.c |  3 +-
 kernel/module.c         | 91 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index a4d2eac5f81f..649c309d10e2 100644
--- a/Makefile
+++ b/Makefile
@@ -885,6 +885,10 @@ endif
 # ClangLTO implies -ffunction-sections -fdata-sections, no need
 # to specify them manually and trigger a pointless full rebuild
 ifndef CONFIG_LTO_CLANG
+ifdef CONFIG_MODULE_FG_KASLR
+KBUILD_CFLAGS_MODULE += -ffunction-sections
+endif
+
 ifneq ($(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION)$(CONFIG_FG_KASLR),)
 KBUILD_CFLAGS_KERNEL += -ffunction-sections
 endif
diff --git a/init/Kconfig b/init/Kconfig
index 8baeaef382c9..1f7e57d323bb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2360,6 +2360,18 @@ config UNUSED_KSYMS_WHITELIST
 	  one per line. The path can be absolute, or relative to the kernel
 	  source tree.
 
+config MODULE_FG_KASLR
+	bool "Module Function Granular Layout Randomization"
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
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index ff9d8b651966..4ff14a94d1bd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -861,7 +861,7 @@ static int __kallsyms_open(struct inode *inode, struct file *file)
  * When function granular kaslr is enabled, we need to print out the symbols
  * at random so we don't reveal the new layout.
  */
-#ifdef CONFIG_FG_KASLR
+#if defined(CONFIG_FG_KASLR) || defined(CONFIG_MODULE_FG_KASLR)
 static int update_random_pos(struct kallsyms_shuffled_iter *s_iter,
 			     loff_t pos, loff_t *new_pos)
 {
@@ -1005,7 +1005,7 @@ static int kallsyms_random_open(struct inode *inode, struct file *file)
 #define kallsyms_open kallsyms_random_open
 #else
 #define kallsyms_open __kallsyms_open
-#endif /* !CONFIG_FG_KASLR */
+#endif /* !CONFIG_FG_KASLR && !CONFIG_MODULE_FG_KASLR */
 
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 10ea75111057..8a5240b5eb5e 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -174,7 +174,8 @@ static int klp_find_object_symbol(const char *objname, const char *name,
 	 * to resolve symbols when there are duplicates using the previous
 	 * symbol position (i.e. sympos != 0).
 	 */
-	if (IS_ENABLED(CONFIG_FG_KASLR) && sympos) {
+	if ((IS_ENABLED(CONFIG_FG_KASLR) || IS_ENABLED(CONFIG_MODULE_FG_KASLR)) &&
+	    sympos) {
 		pr_err("FG-KASLR is enabled, specifying symbol position %lu for symbol '%s' in object '%s' does not work\n",
 		       sympos, name, objname ? objname : "vmlinux");
 		goto out_err;
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..48d5919d09dd 100644
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
 
@@ -2416,6 +2417,89 @@ static bool module_init_layout_section(const char *sname)
 	return module_init_section(sname);
 }
 
+/*
+ * shuffle_text_list()
+ * Use a Fisher Yates algorithm to shuffle a list of text sections.
+ */
+static void shuffle_text_list(Elf_Shdr **list, int size)
+{
+	u32 i, j;
+
+	for (i = size - 1; i > 0; i--) {
+		/*
+		 * pick a random index from 0 to i
+		 */
+		j = get_random_u32() % (i + 1);
+
+		swap(list[i], list[j]);
+	}
+}
+
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
+	shuffle_text_list(text_list, num_text_sections);
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
@@ -2510,6 +2594,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
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


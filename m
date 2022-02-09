Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0AE4AFCA5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiBITBr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiBITAl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9EC05CBBB;
        Wed,  9 Feb 2022 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433170; x=1675969170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+jBO/npeGvXg7XDYxgpHbHrFNhYQT3ckL7ow46HPUI=;
  b=dZSxB9GPood0yX0Ynj0VnmHSjCTmXfM2KqDrd+3twKsIGDM7I32rG6M0
   BaXVmgLQqha0RHljP7Oc8wknr4SVvf42n6Q8Q6Px76OHQEVuU5araNeRg
   yHlpUAxXC+7S+oW5+FzjOa2TxVhLquhutju4fuzH9v2za6136IXt+1fy/
   4z5b6vDWSIZ5xEQkoHJq0i5ZFbYrIoG9FnnUWf7sayPNXPBQFKL1Z5UI9
   HIdKqu6llFbymnq0BNqIkPIUsMAilrSrYovRthcO0Ml7OwudzGyW/v+pK
   mIo/N7Xpy1ehIRAR69YyzCImnRoCbZn5SEvV5moR9HqIlaptYdXgnWG2f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248140554"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="248140554"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="629389938"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2022 10:59:13 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQZ031082;
        Wed, 9 Feb 2022 18:59:11 GMT
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
Subject: [PATCH v10 12/15] module: add arch-indep FG-KASLR for randomizing function layout
Date:   Wed,  9 Feb 2022 19:57:49 +0100
Message-Id: <20220209185752.1226407-13-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Alexander Lobakin:

Make it work with ClangCFI -- in such builds, .text section must
always come first and be page-aligned. Exclude it from the shuffle
list and leave as it is.
Make this feature depend on `-z unique-symbol` as well, due to the
very same reasons as for FG-KASLR for vmlinux.
Use common shuffle_array() from <linux/random.h> instead of
open-coding it.

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
index 4328d53d8b25..cf7cf5cbdad9 100644
--- a/Makefile
+++ b/Makefile
@@ -889,7 +889,7 @@ export SECSUBST_AFLAGS
 endif
 
 # Same for modules. LD DCE doesn't work for them, thus not checking for it
-ifneq ($(CONFIG_LTO_CLANG),)
+ifneq ($(CONFIG_MODULE_FG_KASLR)$(CONFIG_LTO_CLANG),)
 KBUILD_AFLAGS_MODULE += -Wa,--sectname-subst
 KBUILD_CFLAGS_MODULE += -Wa,--sectname-subst
 endif
@@ -898,6 +898,10 @@ endif # CONFIG_HAVE_ASM_FUNCTION_SECTIONS
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
index 95ca162a868c..12cf21f9d8ad 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -81,6 +81,7 @@
 #if defined(CONFIG_HAVE_ASM_FUNCTION_SECTIONS) && \
     ((defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) && !defined(MODULE)) || \
      (defined(CONFIG_FG_KASLR) && !defined(MODULE)) || \
+     (defined(CONFIG_MODULE_FG_KASLR) && defined(MODULE)) || \
      (defined(CONFIG_LTO_CLANG)))
 
 #define SYM_PUSH_SECTION(name)				\
diff --git a/init/Kconfig b/init/Kconfig
index 5fbd1c294df4..86a2d3fd6390 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2386,6 +2386,20 @@ config UNUSED_KSYMS_WHITELIST
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
index 46a5c2ed1928..616a622953fa 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -57,6 +57,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <linux/random.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -1526,7 +1527,7 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 
 	for (section = 0; section < sect_attrs->nsections; section++)
 		kfree(sect_attrs->attrs[section].battr.attr.name);
-	kfree(sect_attrs);
+	kvfree(sect_attrs);
 }
 
 static void add_sect_attrs(struct module *mod, const struct load_info *info)
@@ -1543,7 +1544,7 @@ static void add_sect_attrs(struct module *mod, const struct load_info *info)
 	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
 			sizeof(sect_attrs->grp.bin_attrs[0]));
 	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
-	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
+	sect_attrs = kvzalloc(size[0] + size[1], GFP_KERNEL);
 	if (sect_attrs == NULL)
 		return;
 
@@ -2415,6 +2416,71 @@ static bool module_init_layout_section(const char *sname)
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
@@ -2509,6 +2575,9 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			break;
 		}
 	}
+
+	if (IS_ENABLED(CONFIG_MODULE_FG_KASLR))
+		randomize_text(mod, info);
 }
 
 static void set_license(struct module *mod, const char *license)
-- 
2.34.1


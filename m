Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6024AFCDA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiBITEx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:04:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiBITEU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:04:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44A4C050CCA;
        Wed,  9 Feb 2022 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433322; x=1675969322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zOrA7C3DptaNUP/qG5SJSyg2DZfotK6JEnOnVCcTrms=;
  b=U09Eu/z49Ya52Vl2q54xoYr8c8RXY+fUQhKge+8A3tIVSy4TAIwnunQM
   b8wsnrJrRtW+m15SPPV6PPlv+eFUOgaKgE97Y7/ZZ2BPjwpzAHKN7ZXVJ
   rvthtbkID20Hd5DN5IHS/lQDbRWCYEKzggmVqdZ5XMRSGPIdp4D30af6X
   8ZwRU15n6rRjpmz6qElnGg5T1u41yVHSlHH8ktkfPHIZTC9wKZTl690o9
   5sLog/NlXqB1+qomQZOWWMqAizHJ6LsNT8pjVIA3wX3ZXilSxGakcUSpI
   dr/6/FfI95rJCEXRAiS2IyqUWYwoaw5jH3rw7J32D2f99rOTJh4AwkqLA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="236710020"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="236710020"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="773601637"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2022 10:59:15 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQa031082;
        Wed, 9 Feb 2022 18:59:13 GMT
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
Subject: [PATCH v10 13/15] module: use a scripted approach for FG-KASLR
Date:   Wed,  9 Feb 2022 19:57:50 +0100
Message-Id: <20220209185752.1226407-14-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the same methods and scripts to generate an LD script for every
module containing all the output text sections.
The only difference there is that we don't need to reserve any space
as the memory for every section is being allocated dynamically.

I picked ".ko.lds" extension since there's a fistful of ".lds" files
inside the tree, so I couldn't count all of them as generated /
build artifacts. OTOH, we're limited in heuristics when cleaning as
dotconfig doesn't get included and stuff like ".mod.c" is just being
wiped using `find`.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 .gitignore                        |  1 +
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 init/Kconfig                      | 15 ++++++++++++++-
 scripts/Makefile.modfinal         | 20 +++++++++++++++++---
 scripts/generate_text_sections.pl |  9 ++++++++-
 scripts/module.lds.S              | 14 +++++++++++++-
 6 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7afd412dadd2..d1b48f01037a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@
 *.gz
 *.i
 *.ko
+*.ko.lds
 *.lex.c
 *.ll
 *.lst
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e63d5a69f1bc..9f67660ace18 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -130,6 +130,18 @@
 #define TEXT_MAIN		.text
 #endif
 
+/*
+ * Same for modules. However, LD_DEAD_CODE_DATA_ELIMINATION doesn't touch
+ * them, so no need to check for it here.
+ */
+#if defined(CONFIG_LTO_CLANG) && !defined(CONFIG_MODULE_FG_KASLR)
+#define TEXT_MAIN_MODULE	SECT_WILDCARD(.text)
+#elif defined(CONFIG_MODULE_FG_KASLR)
+#define TEXT_MAIN_MODULE	.text.__unused__
+#else
+#define TEXT_MAIN_MODULE	.text
+#endif
+
 /*
  * Used by scripts/generate_text_sections.pl to inject text sections,
  * harmless if FG-KASLR is disabled.
diff --git a/init/Kconfig b/init/Kconfig
index 86a2d3fd6390..90951631aa03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2391,7 +2391,6 @@ config MODULE_FG_KASLR
 	depends on $(cc-option,-ffunction-sections)
 	depends on LD_HAS_Z_UNIQUE_SYMBOL || !LIVEPATCH
 	default FG_KASLR
-	depends on BROKEN
 	help
 	  This option randomizes the module text section by reordering the text
 	  section by function at module load time. In order to use this
@@ -2400,6 +2399,20 @@ config MODULE_FG_KASLR
 
 	  If unsure, say N.
 
+config MODULE_FG_KASLR_SHIFT
+	int "Module FG-KASLR granularity (functions per section shift)"
+	depends on MODULE_FG_KASLR
+	range 0 16
+	default 0
+	help
+	  This sets the number of functions that will be put in each section
+	  as a power of two.
+	  Decreasing the value increases the randomization, but also increases
+	  the size of the final kernel module due to the amount of sections.
+	  0 means that a separate section will be created for each function.
+	  16 almost disables the randomization, leaving only the manual
+	  separation.
+
 endif # MODULES
 
 config MODULES_TREE_LOOKUP
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 7f39599e9fae..4ca9d8fc978d 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -28,13 +28,25 @@ quiet_cmd_cc_o_c = CC [M]  $@
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
+ifdef CONFIG_MODULE_FG_KASLR
+quiet_cmd_gen_modules_lds = GEN [M] $@
+      cmd_gen_modules_lds =						\
+	$(PERL) $(srctree)/scripts/generate_text_sections.pl		\
+		$(if $(CONFIG_HAVE_ASM_FUNCTION_SECTIONS),-a)		\
+		-s $(CONFIG_MODULE_FG_KASLR_SHIFT) $(filter %.o, $^)	\
+		< $(filter %.lds, $^) > $@
+
+%.ko.lds: %$(mod-prelink-ext).o scripts/module.lds FORCE
+	$(call if_changed,gen_modules_lds)
+endif
+
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
-		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
+		-T $(filter %.lds, $^) -o $@ $(filter %.o, $^);		\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 quiet_cmd_btf_ko = BTF [M] $@
@@ -56,13 +68,15 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
+$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o
+$(modules): %.ko: $(if $(CONFIG_MODULE_FG_KASLR),%.ko.lds,scripts/module.lds)
+$(modules): %.ko: $(if $(KBUILD_BUILTIN),vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
 
-targets += $(modules) $(modules:.ko=.mod.o)
+targets += $(modules) $(modules:.ko=.mod.o) $(modules:.ko=.ko.lds)
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/generate_text_sections.pl b/scripts/generate_text_sections.pl
index 999e1b68181f..a05ae9fb0041 100755
--- a/scripts/generate_text_sections.pl
+++ b/scripts/generate_text_sections.pl
@@ -48,6 +48,7 @@ my $readelf = $ENV{'READELF'} || die "$0: ERROR: READELF not set?";
 ## text sections array
 my @sections = ();
 my $has_ccf = 0;
+my $vmlinux = 0;
 
 ## max alignment found to reserve some space. It would probably be
 ## better to start from 64, but CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B
@@ -78,6 +79,12 @@ sub read_sections {
 			$has_ccf = 1;
 		}
 
+		## If we're processing a module, don't reserve any space
+		## at the end as its sections are being allocated separately.
+		if ($name eq ".sched.text") {
+			$vmlinux = 1;
+		}
+
 		if (!($name =~ /^\.text(\.(?!hot\.|unknown\.|unlikely\.|.san\.)[0-9a-zA-Z_]*){1,2}((\.constprop|\.isra|\.part)\.[0-9]){0,2}(|\.[0-9cfi]*)$/)) {
 			next;
 		}
@@ -141,7 +148,7 @@ sub print_reserve {
 	## If we have text sections aligned with 128 bytes or more, make
 	## sure we reserve some space for them to not overlap _etext
 	## while shuffling sections.
-	if (!$count) {
+	if (!$vmlinux or !$count) {
 		return;
 	}
 
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 1d0e1e4dc3d2..6e957aa614b1 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,6 +3,11 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+
+#include <asm-generic/vmlinux.lds.h>
+
+#undef SANITIZER_DISCARDS
+
 #ifdef CONFIG_CFI_CLANG
 # include <asm/page.h>
 # define ALIGN_CFI 		ALIGN(PAGE_SIZE)
@@ -58,9 +63,16 @@ SECTIONS {
 	 */
 	.text : ALIGN_CFI {
 		*(.text.__cfi_check)
-		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
+		*(TEXT_MAIN_MODULE)
+		*(.text..L.cfi.jumptable .text..L.cfi.jumptable.*)
+	}
+#elif defined(CONFIG_MODULE_FG_KASLR)
+	.text : {
+		*(TEXT_MAIN_MODULE)
 	}
 #endif
+
+	TEXT_FG_KASLR
 }
 
 /* bring in arch-specific sections */
-- 
2.34.1


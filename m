Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70C43FCA43
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhHaOo4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:44:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:16897 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239034AbhHaOnu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:43:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="215357990"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="215357990"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="446126336"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2021 07:42:31 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmfk002209;
        Tue, 31 Aug 2021 15:42:28 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org
Cc:     "Kristen C Accardi" <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        "Marta A Plantykow" <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v6 kspp-next 20/22] module: use a scripted approach for FG-KASLR
Date:   Tue, 31 Aug 2021 16:41:12 +0200
Message-Id: <20210831144114.154-21-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the same methods and scripts to generate an LD script for every
module containing all the output text sections.
The only difference there is that we don't need to reserve any space
as the memory for every section is being allocated dynamically.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 init/Kconfig                      | 15 ++++++++++++++-
 scripts/Makefile.modfinal         | 19 ++++++++++++++++---
 scripts/generate_text_sections.pl |  7 ++++++-
 scripts/module.lds.S              | 14 +++++++++++++-
 5 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 70fac18c786e..561f3ef06745 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -127,6 +127,18 @@
 #define TEXT_MAIN		.text
 #endif
 
+/*
+ * Same for modules. However, LD_DEAD_CODE_DATA_ELIMINATION doesn't touch
+ * them, so no need to check for it here.
+ */
+#if defined(CONFIG_LTO_CLANG) && !defined(CONFIG_MODULE_FG_KASLR)
+#define TEXT_MAIN_MODULE	.text .text.[0-9a-zA-Z_]*
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
index e8158c256ee9..8e0b5973fb72 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2333,7 +2333,6 @@ config UNUSED_KSYMS_WHITELIST
 config MODULE_FG_KASLR
 	bool "Module Function Granular Layout Randomization"
 	default FG_KASLR
-	depends on BROKEN
 	help
 	  This option randomizes the module text section by reordering the text
 	  section by function at module load time. In order to use this
@@ -2342,6 +2341,20 @@ config MODULE_FG_KASLR
 
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
index ff805777431c..ac1b8415519f 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -28,13 +28,24 @@ quiet_cmd_cc_o_c = CC [M]  $@
 %.mod.o: %.mod.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
+ifdef CONFIG_MODULE_FG_KASLR
+quiet_cmd_gen_modules_lds = GEN [M] $@
+      cmd_gen_modules_lds =						\
+	$(PERL) $(srctree)/scripts/generate_text_sections.pl		\
+		-s $(CONFIG_MODULE_FG_KASLR_SHIFT) $(filter %.o, $^)	\
+		< $(filter %.lds, $^) > $@
+
+%.lds: %$(mod-prelink-ext).o scripts/module.lds FORCE
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
@@ -55,13 +66,15 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
+$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o
+$(modules): %.ko: $(if $(CONFIG_MODULE_FG_KASLR),%.lds,scripts/module.lds)
+$(modules): %.ko: $(if $(KBUILD_BUILTIN),vmlinux) FORCE
 	+$(call if_changed_except,ld_ko_o,vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
 
-targets += $(modules) $(modules:.ko=.mod.o)
+targets += $(modules) $(modules:.ko=.mod.o) $(if $(CONFIG_MODULE_FG_KASLR),$(modules:.ko=.lds))
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/generate_text_sections.pl b/scripts/generate_text_sections.pl
index 5f3ece2ee0ea..d5b16057b9ff 100755
--- a/scripts/generate_text_sections.pl
+++ b/scripts/generate_text_sections.pl
@@ -44,6 +44,7 @@ my $readelf = $ENV{'READELF'} || die "$0: ERROR: READELF not set?";
 
 ## text sections array
 my @sections = ();
+my $vmlinux = 0;
 
 ## max alignment found to reserve some space
 my $max_align = 64;
@@ -64,6 +65,10 @@ sub read_sections {
 			next;
 		}
 
+		if ($name eq ".sched.text") {
+			$vmlinux = 1;
+		}
+
 		if (!($name =~ /^\.text\.[0-9a-zA-Z_]*((\.constprop|\.isra|\.part)\.[0-9])*(|\.[0-9cfi]*)$/)) {
 			next;
 		}
@@ -120,7 +125,7 @@ sub print_reserve {
 	## we reserve some space for them to not overlap _etext while shuffling
 	## sections
 
-	if (!$count) {
+	if (!$vmlinux or !$count) {
 		return;
 	}
 
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 04c5685c25cf..f32437783edf 100644
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
@@ -57,9 +62,16 @@ SECTIONS {
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
2.31.1


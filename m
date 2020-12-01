Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA42CAEBA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 22:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgLAVik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 16:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbgLAVih (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 16:38:37 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EAC061A4D
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 13:37:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j138so3966695ybg.20
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fygjglTRsKGmnadS+2qeS3fGBk6lf/IWx2oHvO7WNxI=;
        b=ld3ZUnH3OtCUhEynkUOEkRj5Y8DCnq4JLr8zgSNXp9Us0msShiJvRbOGSRCG3pfSoV
         Mxp2Qp/ocZDzWnzxhsdFIWtvjFNXXS5/rrKWXNRJ/AxULYdaP0q998bTbDlFcyB2nAle
         ZtzcETw1Te8SHGChUMsSRF2c6lZk74b5RlogLs64x6Blq9zd2VODbbxQ/OGylzBALucJ
         zQBhKlAcgP8eGfWtkepIF9obp4/L3e/4LwOH74wTMKzBSH5d5mfSytb4Bjh0idD3Kx6c
         o9o5IwHTt+8cQt7zyRp+Xglk8ZnIUi+TO6u852lX8WTOMgfHsOQG5S72tjfPloSbGtyu
         /KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fygjglTRsKGmnadS+2qeS3fGBk6lf/IWx2oHvO7WNxI=;
        b=hbiIvs5LH2gSHnoRbUASaPhroMHIH/K9d2f+vxYrfvRWxL1iXur7vwVuHz199MCF/E
         qAj3/vvQUsSOr0tUGB1orCKGCmAYp+VIXv8jxuCtNY6SIqKGYc9n+j4Y9AH+hz8tuEMz
         ASOwIsB72/uSc7iaSYlYR1NkceTdkRxbg4giAJo7xDsYRI4mu24SvRloexw0xJ3LSSDZ
         6+Uiky0FcwMR4ipupwfbOJSO2i5Ysa7xWOduFYowCCyqxAvkgBUNcdBsrrjC2cZXesr9
         MqKeUUZewBjgp/cCBpOVT98iQ4+xCSrJ77pqRmntsakC2Jfqj/YxlEiKCgVmFRtYQx/T
         9yEg==
X-Gm-Message-State: AOAM530HM1ylU+X9Lkz+nsj8Jq5NiYwqJuMseAdn5fYqlvzoGBHnFU1w
        MYgVvrts9xXNAPaECJsACIvloQ3KIzkXpSQ3OSE=
X-Google-Smtp-Source: ABdhPJzfUE3Px8AQFizwOVTAW068CHUEcQQsuwqRNDgzG+AIPviLQFJyvHJvyBp677JPugmd1GlJnmWIP3ofkFkUIXg=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a5b:f01:: with SMTP id
 x1mr6309054ybr.291.1606858634882; Tue, 01 Dec 2020 13:37:14 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:36:53 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 02/16] kbuild: add support for Clang LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This change adds build system support for Clang's Link Time
Optimization (LTO). With -flto, instead of ELF object files, Clang
produces LLVM bitcode, which is compiled into native code at link
time, allowing the final binary to be optimized globally. For more
details, see:

  https://llvm.org/docs/LinkTimeOptimization.html

The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
which defaults to LTO being disabled. To use LTO, the architecture
must select ARCH_SUPPORTS_LTO_CLANG and support:

  - compiling with Clang,
  - compiling inline assembly with Clang's integrated assembler,
  - and linking with LLD.

While using full LTO results in the best runtime performance, the
compilation is not scalable in time or memory. CONFIG_THINLTO
enables ThinLTO, which allows parallel optimization and faster
incremental builds. ThinLTO is used by default if the architecture
also selects ARCH_SUPPORTS_THINLTO:

  https://clang.llvm.org/docs/ThinLTO.html

To enable LTO, LLVM tools must be used to handle bitcode files. The
easiest way is to pass the LLVM=1 option to make:

  $ make LLVM=1 defconfig
  $ scripts/config -e LTO_CLANG
  $ make LLVM=1

Alternatively, at least the following LLVM tools must be used:

  CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm

To prepare for LTO support with other compilers, common parts are
gated behind the CONFIG_LTO option, and LTO can be disabled for
specific files by filtering out CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Makefile                          | 19 ++++++-
 arch/Kconfig                      | 88 +++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 ++--
 scripts/Makefile.build            |  9 +++-
 scripts/Makefile.modfinal         |  9 +++-
 scripts/Makefile.modpost          | 21 +++++++-
 scripts/link-vmlinux.sh           | 32 ++++++++---
 7 files changed, 171 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 16b7f0890e75..f5cac2428efc 100644
--- a/Makefile
+++ b/Makefile
@@ -891,6 +891,21 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
 export CC_FLAGS_SCS
 endif
 
+ifdef CONFIG_LTO_CLANG
+ifdef CONFIG_LTO_CLANG_THIN
+CC_FLAGS_LTO	+= -flto=thin -fsplit-lto-unit
+KBUILD_LDFLAGS	+= --thinlto-cache-dir=$(extmod-prefix).thinlto-cache
+else
+CC_FLAGS_LTO	+= -flto
+endif
+CC_FLAGS_LTO	+= -fvisibility=default
+endif
+
+ifdef CONFIG_LTO
+KBUILD_CFLAGS	+= $(CC_FLAGS_LTO)
+export CC_FLAGS_LTO
+endif
+
 ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
 KBUILD_CFLAGS += -falign-functions=32
 endif
@@ -1471,7 +1486,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  *.spec
 
 # Directories & files removed with 'make distclean'
-DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
+DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS .thinlto-cache
 
 # clean - Delete most, but leave enough to build external modules
 #
@@ -1717,7 +1732,7 @@ PHONY += compile_commands.json
 
 clean-dirs := $(KBUILD_EXTMOD)
 clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
-	$(KBUILD_EXTMOD)/compile_commands.json
+	$(KBUILD_EXTMOD)/compile_commands.json $(KBUILD_EXTMOD)/.thinlto-cache
 
 PHONY += help
 help:
diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..30907b554451 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -598,6 +598,94 @@ config SHADOW_CALL_STACK
 	  reading and writing arbitrary memory may be able to locate them
 	  and hijack control flow by modifying the stacks.
 
+config LTO
+	bool
+	help
+	  Selected if the kernel will be built using the compiler's LTO feature.
+
+config LTO_CLANG
+	bool
+	select LTO
+	help
+	  Selected if the kernel will be built using Clang's LTO feature.
+
+config ARCH_SUPPORTS_LTO_CLANG
+	bool
+	help
+	  An architecture should select this option if it supports:
+	  - compiling with Clang,
+	  - compiling inline assembly with Clang's integrated assembler,
+	  - and linking with LLD.
+
+config ARCH_SUPPORTS_LTO_CLANG_THIN
+	bool
+	help
+	  An architecture should select this option if it can support Clang's
+	  ThinLTO mode.
+
+config HAS_LTO_CLANG
+	def_bool y
+	# Clang >= 11: https://github.com/ClangBuiltLinux/linux/issues/510
+	depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
+	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
+	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
+	depends on ARCH_SUPPORTS_LTO_CLANG
+	depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
+	depends on !KASAN
+	depends on !GCOV_KERNEL
+	depends on !MODVERSIONS
+	help
+	  The compiler and Kconfig options support building with Clang's
+	  LTO.
+
+choice
+	prompt "Link Time Optimization (LTO)"
+	default LTO_NONE
+	help
+	  This option enables Link Time Optimization (LTO), which allows the
+	  compiler to optimize binaries globally.
+
+	  If unsure, select LTO_NONE. Note that LTO is very resource-intensive
+	  so it's disabled by default.
+
+config LTO_NONE
+	bool "None"
+	help
+	  Build the kernel normally, without Link Time Optimization (LTO).
+
+config LTO_CLANG_FULL
+	bool "Clang Full LTO (EXPERIMENTAL)"
+	depends on HAS_LTO_CLANG
+	select LTO_CLANG
+	help
+          This option enables Clang's full Link Time Optimization (LTO), which
+          allows the compiler to optimize the kernel globally. If you enable
+          this option, the compiler generates LLVM bitcode instead of ELF
+          object files, and the actual compilation from bitcode happens at
+          the LTO link step, which may take several minutes depending on the
+          kernel configuration. More information can be found from LLVM's
+          documentation:
+
+	    https://llvm.org/docs/LinkTimeOptimization.html
+
+	  During link time, this option can use a large amount of RAM, and
+	  may take much longer than the ThinLTO option.
+
+config LTO_CLANG_THIN
+	bool "Clang ThinLTO (EXPERIMENTAL)"
+	depends on HAS_LTO_CLANG && ARCH_SUPPORTS_LTO_CLANG_THIN
+	select LTO_CLANG
+	help
+	  This option enables Clang's ThinLTO, which allows for parallel
+	  optimization and faster incremental compiles compared to the
+	  CONFIG_LTO_CLANG_FULL option. More information can be found
+	  from Clang's documentation:
+
+	    https://clang.llvm.org/docs/ThinLTO.html
+
+	  If unsure, say Y.
+endchoice
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..8988a2e445d8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -90,15 +90,18 @@
  * .data. We don't want to pull in .data..other sections, which Linux
  * has defined. Same for text and bss.
  *
+ * With LTO_CLANG, the linker also splits sections by default, so we need
+ * these macros to combine the sections during the final link.
+ *
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
-#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
-#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
-#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
+#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
+#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2175ddb1ee0c..ed74b2f986f7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -111,7 +111,7 @@ endif
 # ---------------------------------------------------------------------------
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) -fverbose-asm -S -o $@ $<
+      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<
 
 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
@@ -425,8 +425,15 @@ $(obj)/lib.a: $(lib-y) FORCE
 # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
 # module is turned into a multi object module, $^ will contain header file
 # dependencies recorded in the .*.cmd file.
+ifdef CONFIG_LTO_CLANG
+quiet_cmd_link_multi-m = AR [M]  $@
+cmd_link_multi-m =						\
+	rm -f $@; 						\
+	$(AR) cDPrsT $@ $(filter %.o,$^)
+else
 quiet_cmd_link_multi-m = LD [M]  $@
       cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
+endif
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index ae01baf96f4e..2cb9a1d88434 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -6,6 +6,7 @@
 PHONY := __modfinal
 __modfinal:
 
+include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
 # for c_flags
@@ -29,6 +30,12 @@ quiet_cmd_cc_o_c = CC [M]  $@
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
+ifdef CONFIG_LTO_CLANG
+# With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
+# avoid a second slow LTO link
+prelink-ext := .lto
+endif
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o =                                                     \
 	$(LD) -r $(KBUILD_LDFLAGS)					\
@@ -36,7 +43,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-$(modules): %.ko: %.o %.mod.o scripts/module.lds FORCE
+$(modules): %.ko: %$(prelink-ext).o %.mod.o scripts/module.lds FORCE
 	+$(call if_changed,ld_ko_o)
 
 targets += $(modules) $(modules:.ko=.mod.o)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index f54b6ac37ac2..9ff8bfdb574d 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -43,6 +43,9 @@ __modpost:
 include include/config/auto.conf
 include scripts/Kbuild.include
 
+# for ld_flags
+include scripts/Makefile.lib
+
 MODPOST = scripts/mod/modpost								\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
@@ -102,12 +105,26 @@ $(input-symdump):
 	@echo >&2 'WARNING: Symbol version dump "$@" is missing.'
 	@echo >&2 '         Modules may not have dependencies or modversions.'
 
+ifdef CONFIG_LTO_CLANG
+# With CONFIG_LTO_CLANG, .o files might be LLVM bitcode, so we need to run
+# LTO to compile them into native code before running modpost
+prelink-ext := .lto
+
+quiet_cmd_cc_lto_link_modules = LTO [M] $@
+cmd_cc_lto_link_modules = $(LD) $(ld_flags) -r -o $@ --whole-archive $^
+
+%.lto.o: %.o
+	$(call if_changed,cc_lto_link_modules)
+endif
+
+modules := $(sort $(shell cat $(MODORDER)))
+
 # Read out modules.order to pass in modpost.
 # Otherwise, allmodconfig would fail with "Argument list too long".
 quiet_cmd_modpost = MODPOST $@
-      cmd_modpost = sed 's/ko$$/o/' $< | $(MODPOST) -T -
+      cmd_modpost = sed 's/\.ko$$/$(prelink-ext)\.o/' $< | $(MODPOST) -T -
 
-$(output-symdump): $(MODORDER) $(input-symdump) FORCE
+$(output-symdump): $(MODORDER) $(input-symdump) $(modules:.ko=$(prelink-ext).o) FORCE
 	$(call if_changed,modpost)
 
 targets += $(output-symdump)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 6eded325c837..596507573a48 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -56,6 +56,14 @@ modpost_link()
 		${KBUILD_VMLINUX_LIBS}				\
 		--end-group"
 
+	if [ -n "${CONFIG_LTO_CLANG}" ]; then
+		# This might take a while, so indicate that we're doing
+		# an LTO link
+		info LTO ${1}
+	else
+		info LD ${1}
+	fi
+
 	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
 }
 
@@ -103,13 +111,22 @@ vmlinux_link()
 	fi
 
 	if [ "${SRCARCH}" != "um" ]; then
-		objects="--whole-archive			\
-			${KBUILD_VMLINUX_OBJS}			\
-			--no-whole-archive			\
-			--start-group				\
-			${KBUILD_VMLINUX_LIBS}			\
-			--end-group				\
-			${@}"
+		if [ -n "${CONFIG_LTO_CLANG}" ]; then
+			# Use vmlinux.o instead of performing the slow LTO
+			# link again.
+			objects="--whole-archive		\
+				vmlinux.o 			\
+				--no-whole-archive		\
+				${@}"
+		else
+			objects="--whole-archive		\
+				${KBUILD_VMLINUX_OBJS}		\
+				--no-whole-archive		\
+				--start-group			\
+				${KBUILD_VMLINUX_LIBS}		\
+				--end-group			\
+				${@}"
+		fi
 
 		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
 			${strip_debug#-Wl,}			\
@@ -274,7 +291,6 @@ fi;
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 
 #link vmlinux.o
-info LD vmlinux.o
 modpost_link vmlinux.o
 objtool_link vmlinux.o
 
-- 
2.29.2.576.ga3fc446d84-goog


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A9207D8B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgFXUfI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391468AbgFXUc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:32:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F44C061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:32:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11so3510226ybg.15
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/wrr17V+FsCXcFbmRN2vHICWLIelteQsueKzbrVs9hw=;
        b=COoeXSQlCw4QRSMoNZarFzFNTbDcr6maZAyBTdDeJ3xsLc6rncF7v9wWsAunQPtuzH
         7vNEgFVFpuwR2ETEwflij42oCPn4XuNbO8xP+xeO/JpQ4cbNn2mzatO27UjmEPI7Tlmm
         5TKoTnAzd8KGxzyXY/s7E79IbefQXu1e7hrmLjW2x43kK7mH1XyN8wifsRReBhhprunp
         uhXKFTHc+VpBQyltyThaPTu+CQS4/Nc+Iffym5jl0Vq7YLusiAqpFo333GBF/6UHQ6HU
         tKuOaCWx4957S+p/qAE9zWc4CIXFC4tU55bAISk7rrINEcRJNCeupH5Gi/K/bZ9GZlKw
         OtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/wrr17V+FsCXcFbmRN2vHICWLIelteQsueKzbrVs9hw=;
        b=fs6PqiOvF4sP6h7tK6Edro8hAbdRH0hr+64ge0wZC2bYMBYrDVN42rp6fUdFVFtMW7
         FcaWs+hsYPe9k0oukOQ/gxTCm+WeH/6dLhssLafBQn0vFsDiFwYDa4VcfiUB6CzaO0IH
         PizB0ZY/m5zikE0HscLkSPlB5eQxp322v4lo37Ewg3iVAn4/FnvRs6AczNNtevTp8aEs
         98zm7ymY5K2/jSGvo0FTk9QmT8WmshsK0lyyvgnoyIxOFiyaT5DTaimtlSD6XZFzd6wj
         vT02FN2v7m+NvsFvJkvLU8WiWu244gDrsBjTP2wu4VcGwjOSo3OPfnH6BzwvgznWHUsQ
         VS3g==
X-Gm-Message-State: AOAM530z8p+ZIOYRex3r53//xxdg7jl80bhzK102jb+doFK3yC8KwJl/
        lDgjURN6SaguvFUw4NiPZYE/QL27o540JVmM7P8=
X-Google-Smtp-Source: ABdhPJzNUx+zDn4WfpUBRej52AydQCDedaVXaTDX3VpJk3mmTtqNJ/BdB8+Tfc74cfqhKkMv2ddRCbECop7L3VUHAek=
X-Received: by 2002:a5b:307:: with SMTP id j7mr44548339ybp.292.1593030775736;
 Wed, 24 Jun 2020 13:32:55 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:40 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 02/22] kbuild: add support for Clang LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
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

Note that support for DYNAMIC_FTRACE and MODVERSIONS are added in
follow-up patches.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile                          | 16 ++++++++
 arch/Kconfig                      | 66 +++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 ++++--
 scripts/Makefile.build            |  9 ++++-
 scripts/Makefile.modfinal         |  9 ++++-
 scripts/Makefile.modpost          | 24 ++++++++++-
 scripts/link-vmlinux.sh           | 32 +++++++++++----
 7 files changed, 151 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index ac2c61c37a73..0c7fe6fb2143 100644
--- a/Makefile
+++ b/Makefile
@@ -886,6 +886,22 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
 export CC_FLAGS_SCS
 endif
 
+ifdef CONFIG_LTO_CLANG
+ifdef CONFIG_THINLTO
+CC_FLAGS_LTO_CLANG := -flto=thin $(call cc-option, -fsplit-lto-unit)
+KBUILD_LDFLAGS	+= --thinlto-cache-dir=.thinlto-cache
+else
+CC_FLAGS_LTO_CLANG := -flto
+endif
+CC_FLAGS_LTO_CLANG += -fvisibility=default
+endif
+
+ifdef CONFIG_LTO
+CC_FLAGS_LTO	:= $(CC_FLAGS_LTO_CLANG)
+KBUILD_CFLAGS	+= $(CC_FLAGS_LTO)
+export CC_FLAGS_LTO
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..e00b122293f8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -552,6 +552,72 @@ config SHADOW_CALL_STACK
 	  reading and writing arbitrary memory may be able to locate them
 	  and hijack control flow by modifying the stacks.
 
+config LTO
+	bool
+
+config ARCH_SUPPORTS_LTO_CLANG
+	bool
+	help
+	  An architecture should select this option if it supports:
+	  - compiling with Clang,
+	  - compiling inline assembly with Clang's integrated assembler,
+	  - and linking with LLD.
+
+config ARCH_SUPPORTS_THINLTO
+	bool
+	help
+	  An architecture should select this option if it supports Clang's
+	  ThinLTO.
+
+config THINLTO
+	bool "Clang ThinLTO"
+	depends on LTO_CLANG && ARCH_SUPPORTS_THINLTO
+	default y
+	help
+	  This option enables Clang's ThinLTO, which allows for parallel
+	  optimization and faster incremental compiles. More information
+	  can be found from Clang's documentation:
+
+	    https://clang.llvm.org/docs/ThinLTO.html
+
+choice
+	prompt "Link Time Optimization (LTO)"
+	default LTO_NONE
+	help
+	  This option enables Link Time Optimization (LTO), which allows the
+	  compiler to optimize binaries globally.
+
+	  If unsure, select LTO_NONE.
+
+config LTO_NONE
+	bool "None"
+
+config LTO_CLANG
+	bool "Clang's Link Time Optimization (EXPERIMENTAL)"
+	depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
+	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
+	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
+	depends on ARCH_SUPPORTS_LTO_CLANG
+	depends on !FTRACE_MCOUNT_RECORD
+	depends on !KASAN
+	depends on !MODVERSIONS
+	select LTO
+	help
+          This option enables Clang's Link Time Optimization (LTO), which
+          allows the compiler to optimize the kernel globally. If you enable
+          this option, the compiler generates LLVM bitcode instead of ELF
+          object files, and the actual compilation from bitcode happens at
+          the LTO link step, which may take several minutes depending on the
+          kernel configuration. More information can be found from LLVM's
+          documentation:
+
+	    https://llvm.org/docs/LinkTimeOptimization.html
+
+	  To select this option, you also need to use LLVM tools to handle
+	  the bitcode by passing LLVM=1 to make.
+
+endchoice
+
 config HAVE_ARCH_WITHIN_STACK_FRAMES
 	bool
 	help
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index db600ef218d7..78079000c05a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -89,15 +89,18 @@
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
index 2e8810b7e5ed..f307e708a1b7 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -108,7 +108,7 @@ endif
 # ---------------------------------------------------------------------------
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<
 
 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
@@ -424,8 +424,15 @@ $(obj)/lib.a: $(lib-y) FORCE
 # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
 # module is turned into a multi object module, $^ will contain header file
 # dependencies recorded in the .*.cmd file.
+ifdef CONFIG_LTO_CLANG
+quiet_cmd_link_multi-m = AR [M]  $@
+cmd_link_multi-m =						\
+	rm -f $@; 						\
+	$(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)
+else
 quiet_cmd_link_multi-m = LD [M]  $@
       cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
+endif
 
 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 411c1e600e7d..1005b147abd0 100644
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
@@ -37,7 +44,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		-o $@ $(filter %.o, $^);				\
 	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
-$(modules): %.ko: %.o %.mod.o $(KBUILD_LDS_MODULE) FORCE
+$(modules): %.ko: %$(prelink-ext).o %.mod.o $(KBUILD_LDS_MODULE) FORCE
 	+$(call if_changed,ld_ko_o)
 
 targets += $(modules) $(modules:.ko=.mod.o)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 3651cbf6ad49..9ced8aecd579 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -102,12 +102,32 @@ $(input-symdump):
 	@echo >&2 'WARNING: Symbol version dump "$@" is missing.'
 	@echo >&2 '         Modules may not have dependencies or modversions.'
 
+ifdef CONFIG_LTO_CLANG
+# With CONFIG_LTO_CLANG, .o files might be LLVM bitcode, so we need to run
+# LTO to compile them into native code before running modpost
+prelink-ext = .lto
+
+quiet_cmd_cc_lto_link_modules = LTO [M] $@
+cmd_cc_lto_link_modules =						\
+	$(LD) $(ld_flags) -r -o $@					\
+		--whole-archive $(filter-out FORCE,$^)
+
+%.lto.o: %.o FORCE
+	$(call if_changed,cc_lto_link_modules)
+
+PHONY += FORCE
+FORCE:
+
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
index 92dd745906f4..a681b3b6722e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -52,6 +52,14 @@ modpost_link()
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
 
@@ -99,13 +107,22 @@ vmlinux_link()
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
@@ -270,7 +287,6 @@ fi;
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 
 #link vmlinux.o
-info LD vmlinux.o
 modpost_link vmlinux.o
 objtool_link vmlinux.o
 
-- 
2.27.0.212.ge8ba1cc988-goog


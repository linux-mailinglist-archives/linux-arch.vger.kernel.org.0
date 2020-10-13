Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406D28C5E8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgJMAcj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgJMAc2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF4C0613D2
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e28so13466026pgm.15
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FZ0g9JkTaft4qRr6+QvPEEunC7zVw9+UB5ZjiIlQbts=;
        b=i60Heb9M69LL68aOGjgZW3hdDoeHwlI6ZLI/BXNcyMRsMRse9PMzbsjasIa8xfm6D1
         MC7gSz8V9atjAfxsVz3nbinYtrYgsf7T59u2aqGPO0fw61jYaL/9G/DV+kMHUBPcwG7z
         9pIqcMR7UntMviz3O4pIqj75VVrLLXBD+5vaQ6p3oc48U51h+TkJ382/BJLYYd6/utNP
         vIPrHSZSFBOCwXfjcwRnUL30aVwc9FrgvHfvM1ESkJZT4YF3JdubWHrcHrgqgLQHeIVp
         F2xKZkyvKHXCblmL12+1vUEcKkH27+OTrpaW8YYnJvow1teVtA8iQvX/4xAiko3zMz3U
         UYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FZ0g9JkTaft4qRr6+QvPEEunC7zVw9+UB5ZjiIlQbts=;
        b=ifnRRlBJYhSLacl3aNuEZaZtx19QkXqOHLhY4KT4BCzxuq395QNwZ05xU8/zoEK92v
         bViUgTcoB20Ynhov4xaB12Ul5cYfzNUTlXB1Bf4n66CezUk672Pzvq/de3GdNk4FVY7Z
         aQl41QEF2l09qlkVyYkIkDzGF7YcXGugjmEO55YZWOijMXe7ODrgHAnBg9FuWG/RUYrf
         F6Eb7eCo6vXfzpWNb/EQrxiJ0vuoHg/poZFqD1fhRuvLj2XylVVuabC+AWr20rWNpvAq
         lhe0CAlkIlM6gq+TRd5mvdX9jkDiTVVOZmb1sunTKa9Mg1cLXtRdH9xRO60PvpmUENvF
         Qb1w==
X-Gm-Message-State: AOAM533CzQiK9Q4LiMVrsfqtiauJBA+s4aAMCRX7tg0tcbPT8cqel4kQ
        r+xiFtemzHpa3qjn47qxphrUp3YuyqtildcIJGM=
X-Google-Smtp-Source: ABdhPJxLRs62juK5sABFUNenY66YHbvsYqrV5j1zlLfdeGrd145o98upWu0bFQLIXb2vjyDGv5gsrh5MmjXdEcsMavA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:ec02:b029:d1:fc2b:fe95 with
 SMTP id l2-20020a170902ec02b02900d1fc2bfe95mr26706351pld.79.1602549147998;
 Mon, 12 Oct 2020 17:32:27 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:49 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 11/25] kbuild: lto: postpone objtool
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, LLVM bitcode won't be compiled into native code until
modpost_link, or modfinal for modules. This change postpones calls
to objtool until after these steps, and moves objtool_args to
Makefile.lib, so the arguments can be reused in Makefile.modfinal.

As we didn't have objects to process earlier, we use --duplicate
when processing vmlinux.o. This change also disables unreachable
instruction warnings with LTO to avoid warnings about the int3
padding between functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig              |  2 +-
 scripts/Makefile.build    | 22 ++--------------------
 scripts/Makefile.lib      | 11 +++++++++++
 scripts/Makefile.modfinal | 19 ++++++++++++++++---
 scripts/link-vmlinux.sh   | 28 +++++++++++++++++++++++++---
 5 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index caeb6feb517e..74cbd6e3b116 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -612,7 +612,7 @@ config LTO_CLANG
 	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
 	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
 	depends on ARCH_SUPPORTS_LTO_CLANG
-	depends on !FTRACE_MCOUNT_RECORD
+	depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
 	depends on !KASAN
 	depends on !GCOV_KERNEL
 	select LTO
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e08e66413dbe..ab0ddf4884fd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -218,30 +218,11 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),
 endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
 ifdef CONFIG_STACK_VALIDATION
+ifndef CONFIG_LTO_CLANG
 ifneq ($(SKIP_STACK_VALIDATION),1)
 
 __objtool_obj := $(objtree)/tools/objtool/objtool
 
-objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
-
-objtool_args += $(if $(part-of-module), --module,)
-
-ifndef CONFIG_FRAME_POINTER
-objtool_args += --no-fp
-endif
-ifdef CONFIG_GCOV_KERNEL
-objtool_args += --no-unreachable
-endif
-ifdef CONFIG_RETPOLINE
-  objtool_args += --retpoline
-endif
-ifdef CONFIG_X86_SMAP
-  objtool_args += --uaccess
-endif
-ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
-  objtool_args += --mcount
-endif
-
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
@@ -253,6 +234,7 @@ objtool_obj = $(if $(patsubst y%,, \
 	$(__objtool_obj))
 
 endif # SKIP_STACK_VALIDATION
+endif # CONFIG_LTO_CLANG
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3d599716940c..ecb97c9f5feb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -216,6 +216,17 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
+# Objtool arguments are also needed for modfinal with LTO, so we define
+# then here to avoid duplication.
+objtool_args =								\
+	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
+	$(if $(part-of-module), --module,)				\
+	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable,)			\
+	$(if $(CONFIG_RETPOLINE), --retpoline,)				\
+	$(if $(CONFIG_X86_SMAP), --uaccess,)				\
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount,)
+
 # Useful for describing the dependency of composite objects
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 2cb9a1d88434..1bd2953b11c4 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -9,7 +9,7 @@ __modfinal:
 include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-# for c_flags
+# for c_flags and objtool_args
 include $(srctree)/scripts/Makefile.lib
 
 # find all modules listed in modules.order
@@ -34,10 +34,23 @@ ifdef CONFIG_LTO_CLANG
 # With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
 # avoid a second slow LTO link
 prelink-ext := .lto
-endif
+
+# ELF processing was skipped earlier because we didn't have native code,
+# so let's now process the prelinked binary before we link the module.
+
+ifdef CONFIG_STACK_VALIDATION
+ifneq ($(SKIP_STACK_VALIDATION),1)
+cmd_ld_ko_o +=								\
+	$(objtree)/tools/objtool/objtool $(objtool_args)		\
+		$(@:.ko=$(prelink-ext).o);
+
+endif # SKIP_STACK_VALIDATION
+endif # CONFIG_STACK_VALIDATION
+
+endif # CONFIG_LTO_CLANG
 
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o =                                                     \
+      cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 5ace1dc43993..7f4d19271180 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -89,14 +89,36 @@ modpost_link()
 
 objtool_link()
 {
+	local objtoolcmd;
 	local objtoolopt;
 
+	if [ "${CONFIG_LTO_CLANG} ${CONFIG_STACK_VALIDATION}" = "y y" ]; then
+		# Don't perform vmlinux validation unless explicitly requested,
+		# but run objtool on vmlinux.o now that we have an object file.
+		if [ -n "${CONFIG_UNWINDER_ORC}" ]; then
+			objtoolcmd="orc generate"
+		fi
+
+		objtoolopt="${objtoolopt} --duplicate"
+
+		if [ -n "${CONFIG_FTRACE_MCOUNT_USE_OBJTOOL}" ]; then
+			objtoolopt="${objtoolopt} --mcount"
+		fi
+	fi
+
 	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
-		objtoolopt="check --vmlinux --noinstr"
+		objtoolopt="${objtoolopt} --noinstr"
+	fi
+
+	if [ -n "${objtoolopt}" ]; then
+		if [ -z "${objtoolcmd}" ]; then
+			objtoolcmd="check"
+		fi
+		objtoolopt="${objtoolopt} --vmlinux"
 		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
-		if [ -n "${CONFIG_GCOV_KERNEL}" ]; then
+		if [ -n "${CONFIG_GCOV_KERNEL}" ] || [ -n "${CONFIG_LTO_CLANG}" ]; then
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
 		if [ -n "${CONFIG_RETPOLINE}" ]; then
@@ -106,7 +128,7 @@ objtool_link()
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
 		info OBJTOOL ${1}
-		tools/objtool/objtool ${objtoolopt} ${1}
+		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
 }
 
-- 
2.28.0.1011.ga647a8990f-goog


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE49207D0A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406344AbgFXUdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406437AbgFXUdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD3C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y3so3549107ybf.4
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=apr/xMGBKChEUgpglsm7SLvi5EseZ2l0OlujVaKR1Ng=;
        b=o2nKUag0MXeHuoSKSFhp/2yxKJkh8hAOHialsc33tV/1JSfo0TJojZo+VuCF4S6ZRY
         PJwi10LKoYCbiPOrkzHTUEfAUWmM7MV5pavS+ujf8z9kqFAkGJMn76qrC/ISP5TMbOuH
         NWhJVmLgx8VSte4AMQa5oT2WtZHD/UJbi+0enN0abVOBDQKl9KFP4iSE8eOxixypsh+7
         CZmNKXOqoKAd7nHxvuAyJLrPosBE5H6H65Vt11cAxLLnu6zssUE1KTIDPjDEDqosAFVV
         6xMtAb9eD/uiFznILS60wEDxDxtXlynPVf8HZroMB/go75xgue2MDW3nqDwn8gsT4XNb
         CQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=apr/xMGBKChEUgpglsm7SLvi5EseZ2l0OlujVaKR1Ng=;
        b=d6Ac4l1MuYJur6OOW1SelIcjl4FrQD/FrHTlJDMNB5x2XK4fedXTwtc1+KsUshAoZ4
         dgUiwakNF3/9FZapgmHo4xNzvc4zWMpR7Qq0FzfJxq1ze2DvPin+MheDH/DyC7p62WKe
         +gKzfC1p5wRzsF2jkunBiFAUs3rq5zMC7+o3sgDKOKfch7MIyeO3Gy7/L3Ahesy4W0mX
         252EVPouTonu6Ijn16gfuk82Et61DLP9oqrbFSglfCy8qq07jNSg8PR0d+ed+6kWq/fU
         eWwQLTTWIARfDAr/tgLuGg5pa7h0C746sfnJ9r+h479d4iRS92RImYnIgigx918Q6O+I
         3unQ==
X-Gm-Message-State: AOAM530HxBBqtdDcYolyaiGZH32JMi0aUNtMU6nB99AeHgEEluyQLo+F
        QDPCtZagfpuQqW1k5JHmOFAIQ314OnR5tTRqiOY=
X-Google-Smtp-Source: ABdhPJwRZVZ6E3lpX9oZxZVYWkChT+cVfPRtENzCGkVOHvnXVJtjGTH1c7VF2FTPmKEfqFgTY7AiMicZV760XUsik/0=
X-Received: by 2002:a25:df15:: with SMTP id w21mr44302291ybg.210.1593030783493;
 Wed, 24 Jun 2020 13:33:03 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:42 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 04/22] kbuild: lto: fix recordmcount
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

With LTO, LLVM bitcode won't be compiled into native code until
modpost_link. This change postpones calls to recordmcount until after
this step.

In order to exclude specific functions from inspection, we add a new
code section .text..nomcount, which we tell recordmcount to ignore, and
a __nomcount attribute for moving functions to this section.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile                          |  2 +-
 arch/Kconfig                      |  2 +-
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/compiler-clang.h    |  4 ++++
 include/linux/compiler_types.h    |  4 ++++
 kernel/trace/ftrace.c             |  1 +
 scripts/Makefile.build            |  9 +++++++++
 scripts/Makefile.modfinal         | 18 ++++++++++++++++--
 scripts/link-vmlinux.sh           | 29 +++++++++++++++++++++++++++++
 scripts/recordmcount.c            |  3 ++-
 10 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 161ad0d1f77f..3a7e5e5c17b9 100644
--- a/Makefile
+++ b/Makefile
@@ -861,7 +861,7 @@ KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
 	ifdef CONFIG_HAVE_C_RECORDMCOUNT
 		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
+		export BUILD_C_RECORDMCOUNT RECORDMCOUNT_WARN
 	endif
 endif
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 87488fe1e6b8..85b2044b927d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -598,7 +598,7 @@ config LTO_CLANG
 	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
 	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
 	depends on ARCH_SUPPORTS_LTO_CLANG
-	depends on !FTRACE_MCOUNT_RECORD
+	depends on !FTRACE_MCOUNT_RECORD || HAVE_C_RECORDMCOUNT
 	depends on !KASAN
 	select LTO
 	help
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 78079000c05a..a1c902b808d0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -565,6 +565,7 @@
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
 		NOINSTR_TEXT						\
 		*(.text..refcount)					\
+		*(.text..nomcount)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text*)						\
 	MEM_KEEP(exit.text*)						\
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index ee37256ec8bd..fd78475c0642 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -55,3 +55,7 @@
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
+
+#if defined(CONFIG_LTO_CLANG) && defined(CONFIG_FTRACE_MCOUNT_RECORD)
+#define __nomcount	__attribute__((__section__(".text..nomcount")))
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e368384445b6..1470c9703a25 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -233,6 +233,10 @@ struct ftrace_likely_data {
 # define __noscs
 #endif
 
+#ifndef __nomcount
+# define __nomcount
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6eb..8e3ddb8123d9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6062,6 +6062,7 @@ static int ftrace_cmp_ips(const void *a, const void *b)
 	return 0;
 }
 
+__nomcount
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5c0bbb6ddfcf..64e99f4baa5b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -187,6 +187,9 @@ endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 ifndef CC_USING_RECORD_MCOUNT
+ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
+# With LTO, we postpone recordmcount until we compile a native binary
+ifndef CONFIG_LTO_CLANG
 # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
@@ -200,6 +203,8 @@ sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
 		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
 	fi;
+endif # CONFIG_LTO_CLANG
+
 recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
 else
@@ -209,11 +214,15 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
+
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
+ifndef CONFIG_LTO_CLANG
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
+endif # CONFIG_LTO_CLANG
 endif # CC_USING_RECORD_MCOUNT
+endif # CC_USING_PATCHABLE_FUNCTION_ENTRY
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1005b147abd0..d168f0cfe67c 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -34,10 +34,24 @@ ifdef CONFIG_LTO_CLANG
 # With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
 # avoid a second slow LTO link
 prelink-ext := .lto
-endif
+
+# ELF processing was skipped earlier because we didn't have native code,
+# so let's now process the prelinked binary before we link the module.
+
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+ifndef CC_USING_RECORD_MCOUNT
+ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
+cmd_ld_ko_o += $(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS)	\
+			$(@:.ko=$(prelink-ext).o);
+
+endif # CC_USING_PATCHABLE_FUNCTION_ENTRY
+endif # CC_USING_RECORD_MCOUNT
+endif # CONFIG_FTRACE_MCOUNT_RECORD
+
+endif # CONFIG_LTO_CLANG
 
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o =                                                     \
+      cmd_ld_ko_o +=                                                    \
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		$(addprefix -T , $(KBUILD_LDS_MODULE))			\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 69a6d7254e28..c72f5d0238f1 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -108,6 +108,29 @@ objtool_link()
 	fi
 }
 
+# If CONFIG_LTO_CLANG is selected, we postpone running recordmcount until
+# we have compiled LLVM IR to an object file.
+recordmcount()
+{
+	if [ "${CONFIG_LTO_CLANG} ${CONFIG_FTRACE_MCOUNT_RECORD}" != "y y" ]; then
+		return
+	fi
+
+	if [ -n "${CC_USING_RECORD_MCOUNT}" ]; then
+		return
+	fi
+	if [ -n "${CC_USING_PATCHABLE_FUNCTION_ENTRY}" ]; then
+		return
+	fi
+
+	local flags=""
+
+	[ -n "${RECORDMCOUNT_WARN}" ] && flags="-w"
+
+	info MCOUNT $*
+	${objtree}/scripts/recordmcount ${flags} $*
+}
+
 # Link of vmlinux
 # ${1} - output file
 # ${2}, ${3}, ... - optional extra .o files
@@ -316,6 +339,12 @@ objtool_link vmlinux.o
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
 
+if [ -n "${CONFIG_LTO_CLANG}" ]; then
+	# If we postponed ELF processing steps due to LTO, process
+	# vmlinux.o instead.
+	recordmcount vmlinux.o
+fi
+
 info MODINFO modules.builtin.modinfo
 ${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
 info GEN modules.builtin
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 7225107a9aaf..9e9f10b4d649 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -404,7 +404,8 @@ static uint32_t (*w2)(uint16_t);
 /* Names of the sections that could contain calls to mcount. */
 static int is_mcounted_section_name(char const *const txtname)
 {
-	return strncmp(".text",          txtname, 5) == 0 ||
+	return (strncmp(".text",           txtname, 5) == 0 &&
+		 strcmp(".text..nomcount", txtname) != 0) ||
 		strcmp(".init.text",     txtname) == 0 ||
 		strcmp(".ref.text",      txtname) == 0 ||
 		strcmp(".sched.text",    txtname) == 0 ||
-- 
2.27.0.212.ge8ba1cc988-goog


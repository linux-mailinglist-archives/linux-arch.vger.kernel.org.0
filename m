Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA423E3D0
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHFWJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Aug 2020 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgHFWJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2020 18:09:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B35C061757
        for <linux-arch@vger.kernel.org>; Thu,  6 Aug 2020 15:09:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so83135plz.10
        for <linux-arch@vger.kernel.org>; Thu, 06 Aug 2020 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRP3FgRyQ/k48NTUuHSvU7SLO+Q+hOFOxehsPE+mY3A=;
        b=koToQFz7v/FNbYDUnN7uUjTfsar8RnUGuRSmognn2IXLMfP3k0TA0YVizuDKsldhCB
         oKL0TTm/CPbY9FwI+p94fRf/RVUPLuni/gRgietd/s6uKg0l4CXy14b0eKcAGA/tSijk
         ozo6ZDCuptECLJz1cGm1K6VT/QjQNmNKjn8iMW7XksBfJkrHors35OlSwnYlpjb9xu/7
         4wd8dLHukDPpGQ8yzP4CRj9SqSju3fi4muJJH7TnO3QuLzqSDWRlLuZLq9MARynzV126
         b4+/uVQUOgtUiyM6hv2/2+TNV74S3w+bziPPQTsgXqD491pP6XoES/LHTtzUtL2U1acd
         DhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRP3FgRyQ/k48NTUuHSvU7SLO+Q+hOFOxehsPE+mY3A=;
        b=OXQMHgFCc7G6nkk5nM3WDCV5c1Qu+X4A3Us9I6yfRjrLPEZR16MFqthhFjv/0rhlzs
         rGUevcn/t+0SgpdLwehg8P3C1L06c82wAcm48U7fRcD6aYY0o3KFe83HHQZzZ5R3d8Bb
         HwakdT9iOeFqSF1pD4ojpT1eTdXQaneN4qBuNFYrrEw9UOQ+6T4NSB1X/UpAhJUBsdIm
         ufzkFJqJSef9lzUw4Fluwh7fAhav0xXf1QAtV/5rORvoEdStPRXLRDj6KZmEBrhyPwLY
         h/HW6y+J6h58WMN2xM7e0TTROYFQYP79a58EFaMEzBMQ0fq2X08Um8lEtYTuSpjjSF6G
         Lfhg==
X-Gm-Message-State: AOAM532peE3DN1W6NKGAwy1QmXXta7YTzv4k+Zhkxx98ysnccpxgxd2U
        UZJ5BVvhi8Jexrab8YaZJ6aItA==
X-Google-Smtp-Source: ABdhPJyIvDdOsrSRk0Aersg8zp7X6hgYDLE4DrekCgs3b7/u9ms0kPv6U1wN8B2b/xqJQTL8s6WaHg==
X-Received: by 2002:a17:90a:2210:: with SMTP id c16mr10702188pje.65.1596751790067;
        Thu, 06 Aug 2020 15:09:50 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id 193sm9352085pfu.169.2020.08.06.15.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 15:09:49 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:09:43 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
Message-ID: <20200806220943.GA1781224@google.com>
References: <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com>
 <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com>
 <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <20200722135542.41127cc4@oasis.local.home>
 <20200722184137.GP10769@hirez.programming.kicks-ass.net>
 <20200722150943.53046592@oasis.local.home>
 <20200722235620.GR10769@hirez.programming.kicks-ass.net>
 <20200722200608.40ca9994@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722200608.40ca9994@oasis.local.home>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 22, 2020 at 08:06:08PM -0400, Steven Rostedt wrote:
> On Thu, 23 Jul 2020 01:56:20 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Anyway, what do you prefer, I suppose I can make objtool whatever we
> > need, that patch is trivial. Simply recording the sites and not
> > rewriting them should be simple enough.
> 
> Either way. If objtool turns it into nops, just make it where we can
> enable -DCC_USING_NOP_MCOUNT set, and the kernel will be unaware.
> 
> Or if you just add the locations, then that would work too.

I took Peter's earlier patch, rebased it on top of the current mainline
tree for easier testing, and tweaked the makefiles to only use objtool
--mcount when CONFIG_STACK_VALIDATION is enabled and the compiler
supports -mfentry. This works for me with both gcc and clang. Thoughts?

Sami


---
 Makefile                      | 38 ++++++++++++----
 arch/x86/Kconfig              |  1 +
 kernel/trace/Kconfig          |  5 +++
 scripts/Makefile.build        |  9 ++--
 tools/objtool/builtin-check.c |  3 +-
 tools/objtool/builtin.h       |  2 +-
 tools/objtool/check.c         | 83 +++++++++++++++++++++++++++++++++++
 tools/objtool/check.h         |  1 +
 tools/objtool/objtool.h       |  1 +
 9 files changed, 129 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 5cfc3481207f..2d23b6b6c4c9 100644
--- a/Makefile
+++ b/Makefile
@@ -864,17 +864,34 @@ ifdef CONFIG_HAVE_FENTRY
   ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
     CC_FLAGS_USING	+= -DCC_USING_FENTRY
+    export CC_USING_FENTRY := 1
   endif
 endif
 export CC_FLAGS_FTRACE
-KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
-KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 ifdef CONFIG_DYNAMIC_FTRACE
-	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
-	endif
+  ifndef CC_USING_RECORD_MCOUNT
+  ifndef CC_USING_PATCHABLE_FUNCTION_ENTRY
+    # use objtool or recordmcount to generate mcount tables
+    ifdef CONFIG_HAVE_OBJTOOL_MCOUNT
+      ifdef CC_USING_FENTRY
+        USE_OBJTOOL_MCOUNT := y
+        CC_FLAGS_USING += -DCC_USING_NOP_MCOUNT
+        export USE_OBJTOOL_MCOUNT
+      endif
+    endif
+    ifndef USE_OBJTOOL_MCOUNT
+      USE_RECORDMCOUNT := y
+      export USE_RECORDMCOUNT
+      ifdef CONFIG_HAVE_C_RECORDMCOUNT
+        BUILD_C_RECORDMCOUNT := y
+        export BUILD_C_RECORDMCOUNT
+      endif
+    endif
+  endif
+  endif
 endif
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
+KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 endif
 
 # We trigger additional mismatches with less inlining
@@ -1211,11 +1228,16 @@ uapi-asm-generic:
 PHONY += prepare-objtool prepare-resolve_btfids
 prepare-objtool: $(objtool_target)
 ifeq ($(SKIP_STACK_VALIDATION),1)
+objtool-lib-prompt := "please install libelf-dev, libelf-devel or elfutils-libelf-devel"
+ifdef USE_OBJTOOL_MCOUNT
+	@echo "error: Cannot generate __mcount_loc for CONFIG_DYNAMIC_FTRACE=y, $(objtool-lib-prompt)" >&2
+	@false
+endif
 ifdef CONFIG_UNWINDER_ORC
-	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, $(objtool-lib-prompt)" >&2
 	@false
 else
-	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, $(objtool-lib-prompt)" >&2
 endif
 endif
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9a2849527dd7..149c94a44cf0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -163,6 +163,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
 	select HAVE_C_RECORDMCOUNT
+	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508..b510af5b216c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -56,6 +56,11 @@ config HAVE_C_RECORDMCOUNT
 	help
 	  C version of recordmcount available?
 
+config HAVE_OBJTOOL_MCOUNT
+	bool
+	help
+	  Arch supports objtool --mcount
+
 config TRACER_MAX_TRACE
 	bool
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e8810b7e5ed..f66f8c0ef294 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -175,8 +175,7 @@ cmd_modversions_c =								\
 	fi
 endif
 
-ifdef CONFIG_FTRACE_MCOUNT_RECORD
-ifndef CC_USING_RECORD_MCOUNT
+ifdef USE_RECORDMCOUNT
 # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
@@ -203,8 +202,7 @@ recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
-endif # CC_USING_RECORD_MCOUNT
-endif # CONFIG_FTRACE_MCOUNT_RECORD
+endif # USE_RECORDMCOUNT
 
 ifdef CONFIG_STACK_VALIDATION
 ifneq ($(SKIP_STACK_VALIDATION),1)
@@ -227,6 +225,9 @@ endif
 ifdef CONFIG_X86_SMAP
   objtool_args += --uaccess
 endif
+ifdef USE_OBJTOOL_MCOUNT
+  objtool_args += --mcount
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7a44174967b5..71595cf4946d 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,7 @@
 #include "builtin.h"
 #include "objtool.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -35,6 +35,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
 	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
+	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 85c979caa367..94565a72b701 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f24f46..6e0b478dc065 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -433,6 +433,65 @@ static int add_dead_ends(struct objtool_file *file)
 	return 0;
 }
 
+static int create_mcount_loc_sections(struct objtool_file *file)
+{
+	struct section *sec, *reloc_sec;
+	struct reloc *reloc;
+	unsigned long *loc;
+	struct instruction *insn;
+	int idx;
+
+	sec = find_section_by_name(file->elf, "__mcount_loc");
+	if (sec) {
+		INIT_LIST_HEAD(&file->mcount_loc_list);
+		WARN("file already has __mcount_loc section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->mcount_loc_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, "__mcount_loc", sizeof(unsigned long), idx);
+	if (!sec)
+		return -1;
+
+	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
+	if (!reloc_sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
+
+		loc = (unsigned long *)sec->data->d_buf + idx;
+		memset(loc, 0, sizeof(unsigned long));
+
+		reloc = malloc(sizeof(*reloc));
+		if (!reloc) {
+			perror("malloc");
+			return -1;
+		}
+		memset(reloc, 0, sizeof(*reloc));
+
+		reloc->sym = insn->sec->sym;
+		reloc->addend = insn->offset;
+		reloc->type = R_X86_64_64;
+		reloc->offset = idx * sizeof(unsigned long);
+		reloc->sec = reloc_sec;
+		elf_add_reloc(file->elf, reloc);
+
+		idx++;
+	}
+
+	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
+		return -1;
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -784,6 +843,22 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->type = INSN_NOP;
 		}
 
+		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+			if (reloc) {
+				reloc->type = R_NONE;
+				elf_write_reloc(file->elf, reloc);
+			}
+
+			elf_write_insn(file->elf, insn->sec,
+				       insn->offset, insn->len,
+				       arch_nop_insn(insn->len));
+
+			insn->type = INSN_NOP;
+
+			list_add_tail(&insn->mcount_loc_node,
+				      &file->mcount_loc_list);
+		}
+
 		/*
 		 * Whatever stack impact regular CALLs have, should be undone
 		 * by the RETURN of the called function.
@@ -2791,6 +2866,7 @@ int check(const char *_objname, bool orc)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.mcount_loc_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
@@ -2838,6 +2914,13 @@ int check(const char *_objname, bool orc)
 		warnings += ret;
 	}
 
+	if (mcount) {
+		ret = create_mcount_loc_sections(&file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (orc) {
 		ret = create_orc(&file);
 		if (ret < 0)
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 061aa96e15d3..b62afd3d970b 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -22,6 +22,7 @@ struct insn_state {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
+	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 528028a66816..427806079540 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -16,6 +16,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
+	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 


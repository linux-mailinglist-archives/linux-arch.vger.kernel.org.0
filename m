Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4E25CA7F
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICUc0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbgICUbv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:31:51 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD21C0619CB
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:17 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c5so2914886qtd.12
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=68EGgksazPQQWa43NBSs0j4GgDFQhp/Me0oPJzuOsN8=;
        b=eZp0Qn5Mm2ShJ/tgYPaRj85Z8VUBs6dHqTbSeVpz2aQ8IT+Uz4kserb5rwYgZd+Cwn
         k2U+ck7Y8IZ7th793kOmXJc6g2Scr4a/vKCka7ANnMO/AT2KQRxNxsShvwTyA6E/o15O
         8XCzrDDKDRTJp06/9WX1NT36pZOKiIAYs8XK258isaAUZqWQPMWg3npOPIjN8aYcapWI
         WU48aFUbK0L92YPeWiJOPtw+mesK+nnkKQOrrHUndl452ziz+R2DMO5rDIQ6Y/Qeev2g
         D8xzJzY5mttEMiic8gwiUfR2vdI8Fq8Jp2U+kdDYpIEFsu+h2dtY2vP50lgzUL6pYFDU
         IdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=68EGgksazPQQWa43NBSs0j4GgDFQhp/Me0oPJzuOsN8=;
        b=sTyHTdhrd/4h9W+Lcm93IIIBcpQGgPGiVSN8vs0WBHjCog71B7I0JnC1SceXwo5PYU
         rQ0IvKMXTDUbofOpsFzeWBBZb/mJZP3xny3Yxh4ZvejnXoEv7CshGV0UNH/5HJWeoNLP
         FTZTA8xLZNaI0l2cKATMWocAyQcJld4Y7ya6EQw84JILv6/sO6toUjqA44bBBE20eh2I
         Rhfl08u9l1t5XgDLOgu9HQ/AVk6ziBrZvu0dOOB2H6yJapl/vd+87rDTcVOHEwzBOUCM
         4CHO1vH/UDVypsNfzgdFUAOQd7r148rtMXCubBQTe3IoZ14q8gsEKUXX7gy5XdVm9yYI
         cFuA==
X-Gm-Message-State: AOAM5328EzccuDfGFScHnyzSvih1eBDrP3XUEx7jr0GOn+efzvUWnV4U
        +fGn8LZ2obTTNsTGIJrebcz53QefadppXNVXjVs=
X-Google-Smtp-Source: ABdhPJwx0iA2/+FKVoOyHKkwFqQMq9Y1dKXGtr+TJBEQ96YIr3ynGB1QxnludpQgb3sJv844+nrU8x6OIjTFKfziaBI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e543:: with SMTP id
 n3mr3539594qvm.11.1599165077148; Thu, 03 Sep 2020 13:31:17 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:36 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 11/28] kbuild: lto: postpone objtool
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With LTO, LLVM bitcode won't be compiled into native code until
modpost_link, or modfinal for modules. This change postpones calls
to objtool until after these steps.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/Kconfig              |  2 +-
 scripts/Makefile.build    |  2 ++
 scripts/Makefile.modfinal | 24 ++++++++++++++++++++++--
 scripts/link-vmlinux.sh   | 23 ++++++++++++++++++++++-
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 71392e4a8900..7a418907e686 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -599,7 +599,7 @@ config LTO_CLANG
 	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
 	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
 	depends on ARCH_SUPPORTS_LTO_CLANG
-	depends on !FTRACE_MCOUNT_RECORD
+	depends on HAVE_OBJTOOL_MCOUNT || !(X86_64 && DYNAMIC_FTRACE)
 	depends on !KASAN
 	depends on !GCOV_KERNEL
 	select LTO
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c348e6d6b436..b8f1f0d65a73 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -218,6 +218,7 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),
 endif # USE_RECORDMCOUNT
 
 ifdef CONFIG_STACK_VALIDATION
+ifndef CONFIG_LTO_CLANG
 ifneq ($(SKIP_STACK_VALIDATION),1)
 
 __objtool_obj := $(objtree)/tools/objtool/objtool
@@ -253,6 +254,7 @@ objtool_obj = $(if $(patsubst y%,, \
 	$(__objtool_obj))
 
 endif # SKIP_STACK_VALIDATION
+endif # CONFIG_LTO_CLANG
 endif # CONFIG_STACK_VALIDATION
 
 # Rebuild all objects when objtool changes, or is enabled/disabled.
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 1005b147abd0..909bd509edb4 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -34,10 +34,30 @@ ifdef CONFIG_LTO_CLANG
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
+	$(objtree)/tools/objtool/objtool				\
+		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
+		--module						\
+		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
+		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
+		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
+		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
+		$(if $(USE_OBJTOOL_MCOUNT),--mcount,)			\
+		$(@:.ko=$(prelink-ext).o);
+
+endif # SKIP_STACK_VALIDATION
+endif # CONFIG_STACK_VALIDATION
+
+endif # CONFIG_LTO_CLANG
 
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o =                                                     \
+      cmd_ld_ko_o +=                                                     \
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		$(addprefix -T , $(KBUILD_LDS_MODULE))			\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3e99a19b9195..a352a5ad9ef7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -93,8 +93,29 @@ objtool_link()
 {
 	local objtoolopt;
 
+	if [ "${CONFIG_LTO_CLANG} ${CONFIG_STACK_VALIDATION}" = "y y" ]; then
+		# Don't perform vmlinux validation unless explicitly requested,
+		# but run objtool on vmlinux.o now that we have an object file.
+		if [ -n "${CONFIG_UNWINDER_ORC}" ]; then
+			objtoolopt="orc generate"
+		else
+			objtoolopt="check"
+		fi
+
+		if [ -n ${USE_OBJTOOL_MCOUNT} ]; then
+			objtoolopt="${objtoolopt} --mcount"
+		fi
+	fi
+
 	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
-		objtoolopt="check --vmlinux"
+		if [ -z "${objtoolopt}" ]; then
+			objtoolopt="check --vmlinux"
+		else
+			objtoolopt="${objtoolopt} --vmlinux"
+		fi
+	fi
+
+	if [ -n "${objtoolopt}" ]; then
 		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
-- 
2.28.0.402.g5ffc5be6b7-goog


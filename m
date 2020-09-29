Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6964D27DAC8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgI2Vq5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgI2Vqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:46:55 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D1C0613D7
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:55 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id de12so3336595qvb.12
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EVFyDdMBT7UIjCTs1R+jFYtxZ12heAHoZCz5KJatfNk=;
        b=jb5rUAmu6jwYLZfXR3cdX9Of5qq8lDR8AdcOKwFBT1Jn7cdegEaEDvOw+fpU2idY9A
         8wFamSyI2lLC5VxJq7gYYwW4eOM8Bkfx943cd4ZbXduXrvxredZSa99R51L+eh2bDr9X
         UYWjSLF9dF9wGO9IVQkFy6y9WjhboBfwIQ5mKr/qBjqRpX9u6GdEqUCrNwU7cVRpdhS4
         RlxEj1ljkZcdmBaUMZNJWQOEavH3n+8ZPoLfB9xSVFT8bI81+SHvQiKWZiw0cslu16Yd
         xZW3VRVpgNMRYExJsKoxdCR27pnuJQiOWTDGIAneFEWb8bDWnFJUk61U27XVETE6R0oT
         pfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EVFyDdMBT7UIjCTs1R+jFYtxZ12heAHoZCz5KJatfNk=;
        b=T+zMEQFSCs9tujutsJd/Uu/svtp3UEof3AQI6+l02bGokJIiudZ/WQh1xm9/+3eEuB
         jLdDiMoT6D/VY1EEGI3KsA/NwX7nH2P1KUfgeT3/khLVTJTSzzQ1t38Eb5YDLZM/zEks
         nOB3pMP5Gt8uqZh7Ncc6ADwLt1UZTm6vuL/5DYGQXi45XjkO3QyId3Oswk1ghd835Pzp
         K57Z8UKa59yqKkIcz2nBWdFwsMK6riUG0K1X1aMZSddILyMEvHP3EQdB9wjTYB07An8M
         CHGz8i2UBfYKp5M8vGsKCxVp6XHuk6ez+GfbLFqyEFnqXkNp72jsLNGdcZCN73PMqpMw
         JMdA==
X-Gm-Message-State: AOAM530JeGwmVQ14p2xM7VIwaVTI40oyENAEazcB4cNaOYgwCA8Et5mx
        BPJhmBKKlVHVGrEps3cQvpmqyU5VnQWNRjfW++M=
X-Google-Smtp-Source: ABdhPJyRGPN5FuKG66QFQ9S/eE38q1d4Oa9ZxVtiqvMkkcqZMBtDHE3DHqCOJnL3FWXxjNgRj5vcomu7T8L57ID5qok=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b202:: with SMTP id
 x2mr6465789qvd.49.1601416014258; Tue, 29 Sep 2020 14:46:54 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:12 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 10/29] treewide: remove DISABLE_LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

This change removes all instances of DISABLE_LTO from
Makefiles, as they are currently unused, and the preferred
method of disabling LTO is to filter out the flags instead.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 1 -
 arch/sparc/vdso/Makefile        | 2 --
 arch/x86/entry/vdso/Makefile    | 2 --
 kernel/Makefile                 | 3 ---
 scripts/Makefile.build          | 2 +-
 5 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 45d5cfe46429..e836e300440f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -31,7 +31,6 @@ ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
-KBUILD_CFLAGS			+= $(DISABLE_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index f44355e46f31..476c4b315505 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -3,8 +3,6 @@
 # Building vDSO images for sparc.
 #
 
-KBUILD_CFLAGS += $(DISABLE_LTO)
-
 VDSO64-$(CONFIG_SPARC64)	:= y
 VDSOCOMPAT-$(CONFIG_COMPAT)	:= y
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 215376d975a2..ecc27018ae13 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -9,8 +9,6 @@ ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
 ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
 include $(srctree)/lib/vdso/Makefile
 
-KBUILD_CFLAGS += $(DISABLE_LTO)
-
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
diff --git a/kernel/Makefile b/kernel/Makefile
index 9a20016d4900..347254f07dab 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -38,9 +38,6 @@ KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
-# cond_syscall is currently not LTO compatible
-CFLAGS_sys_ni.o = $(DISABLE_LTO)
-
 obj-y += sched/
 obj-y += locking/
 obj-y += power/
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4634aae1506..2175ddb1ee0c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -111,7 +111,7 @@ endif
 # ---------------------------------------------------------------------------
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) -fverbose-asm -S -o $@ $<
 
 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
-- 
2.28.0.709.gb0816b6eb0-goog


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8A28C5CC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgJMAcX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbgJMAcU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E23C0613D2
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q15so13788536qkq.23
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DpKDWbKTWTks9tV0s5R4bAv6I99K4U3GWyHtOORPWq0=;
        b=tToV5WHAo5KqbZWvmvK6V50kBP7lFH3FOB2CpC/8vUKu1aRiVvkQ0yMN0vQ89CF6e5
         JRyw7EkAwMm6H7peFQHQIMNjEArgToT8cMngzUtewp6pjEsEnKihkjsnBtvO6oPWyoY5
         0jEoVe5t1I0r/WTDYyCiLYBEDIC8osSOQ1G5cl4z6TNyAQclWkSSmuTXoRh0op1Xl5s4
         0Q1DPTZbYn6GTjC25XWRmtS3tD3Yc9zFyn9Pd4h3pvxgPKUIZShi/wu0rDWou0nHcj7q
         RIn/E/s2/75f3avHOb7sHbB3x3aWYsCQGwnME8C9IgglpttXQYXa7cI9BcTPqzUO1vEH
         +83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DpKDWbKTWTks9tV0s5R4bAv6I99K4U3GWyHtOORPWq0=;
        b=oFYpX5pLJajDuo1ccm4NBMUy6oiivBeEP9PaQjcVVE5A2yNfHS1plneQqAoJJJuTAe
         8v6geABgZLyV8kV14WZyh6ON78oFwQ0DeIZE6qx9QXQVKVN4UPmkNDJkhtsyjdpMD0dv
         0OfUhZJhjuQ3J1MyxoZYWItqtzRDAxRPT+BxD+3FLEGHfM0TMvqnENckF1hpcsO/GdTi
         iOzMzssNrX3A5O43HeUpRB5xjBQTSRoAiMt3EsVpknYDukuT0YsVyrbjT9Tp14ji2sIp
         e5qQdsi9ZRnFg+5nQe2zETS1HYYkf8yzmmBSYZTJjR3OrIgVTMmBpLmrzuEOjyUIz4ha
         amXA==
X-Gm-Message-State: AOAM531vkbukiS2y/kDywcR337YCjfSUf8m9jK699Y0TyX54//6kkl9b
        Vp5hgApI2AVj701+2aoeGS3TEWeL0dGBYHb8JKM=
X-Google-Smtp-Source: ABdhPJx3VxsNQ9tGu8xO95a1t6wVsoYxq4cLAxTVRK8Lq6kP9gEUNleSTLK5SuOy50JiEDn6GMUiyP2OF00DUvOhVxA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e1d1:: with SMTP id
 v17mr25826493qvl.15.1602549139059; Mon, 12 Oct 2020 17:32:19 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:45 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 07/25] treewide: remove DISABLE_LTO
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

This change removes all instances of DISABLE_LTO from
Makefiles, as they are currently unused, and the preferred
method of disabling LTO is to filter out the flags instead.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index 16ec9262ce9d..2561abc91961 100644
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
index cd4294435fef..6db5b1f55b14 100644
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
2.28.0.1011.ga647a8990f-goog


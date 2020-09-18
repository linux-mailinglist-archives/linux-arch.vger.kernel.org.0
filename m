Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070272706B0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIRUPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIRUPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4AC0613CF
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:03 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u23so5553530qku.17
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8Z9k7hZvEPmq++QcMDZiZsWcl46Vj1BocbQ0cOU/FNM=;
        b=QatnRemB8cKq9+uR9uPhgVc2Bc6FwkGBsqtwIjGXf6ksklkrNv4kL3LeGcIpnb3kJD
         +VwOOFb1L9qdjGWufD737L0mHuhxu80I2Ipso4IMvzIJas82S09muHkdzoE5crcC0K4X
         jHnkPNr0LNFGuuBIJcIPGhqG0P+7+VZZuQ3chCGeXzDp4qjhYbwW4Yvw5E4Lq+DHRE2x
         +SvZeCiBoXRrsWh3eS0wWEht2cZnd0r3e6+aOgBH5CI14gyZ1vwHI2sjtDN3qmhUcK4j
         NDhnu6OrCJmznwP7zF474cCOa4gKRKf9OVdwozqYVkj615Ymd9ke7k8+4OAc2VqFRZta
         u5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8Z9k7hZvEPmq++QcMDZiZsWcl46Vj1BocbQ0cOU/FNM=;
        b=Q9zZVdPmahKlfxO0ti78T6N+tJ/Zx4Vw1/5HyjZ94sz6zm1EpoJCStpKQz/8mk5248
         evu9Gc7iuEUyd1Oe0E86Or/ZC0r1BoJLitg8wPw/ShOyuOfGso6AXUIJ9zhP6El8Bvhh
         6VFDrEa3RdDV4JuUW5ypPi1jy0q55RVYgFzEhBzshAv9YGnnDnHyqlB4PmUTjjV6bu6G
         QKxuLgm+3bjWEdmayT++qMOmrmFADNsZa1jBjs1+wA6GBvFEtq//KkJyyy67nZQyD0EF
         /Y53A+Q+l4s9odyyI/bItQEHVxzfmzkscSEQiNruuSfPKUqKYFKTQ9D7P7jjVJ50lqF7
         oQRQ==
X-Gm-Message-State: AOAM531rabW26GGfLZl8Yv/hXfAVv8qAWsc/OwIXX2bcrBARt73QOout
        ksu09eX25dPw5hSq9Fd1pspShE54Z98v9gsNZjk=
X-Google-Smtp-Source: ABdhPJz+7Css5KK1OpZUjZgXWLDi39JN/gWO7PRZZDMxz/EqUbcEpWKFi5QyByaFuSTBObLpkxNksopPJp16SrRkt4s=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e152:: with SMTP id
 c18mr18505590qvl.41.1600460102349; Fri, 18 Sep 2020 13:15:02 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:16 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 10/30] treewide: remove DISABLE_LTO
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
index 6ecf30c70ced..ed2b8ce9d4c2 100644
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
2.28.0.681.g6f77f65b4e-goog


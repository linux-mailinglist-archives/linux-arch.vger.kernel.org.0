Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B25F1499
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiI3VPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI3VPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 17:15:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1B7676A
        for <linux-arch@vger.kernel.org>; Fri, 30 Sep 2022 14:15:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-34558a60c39so52857527b3.16
        for <linux-arch@vger.kernel.org>; Fri, 30 Sep 2022 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=w1VewG6/ucM/kWlIiY+OEg0V0mx9+6eAtRi0Lhie0XM=;
        b=Tp4dwoaPnTRGNUQ5SxT2h9xiIpSnWjwEzaPEwoI8MlCxexAhEiLEqRHO8PW5T23IId
         5Z4MNnMGJ6bEh3IykJGWZD1Cjl3WbZ+MzSwKdza895nUPVaPuuCpfzKe+5nXAOXo/ERI
         dMb/3ioM6tA4SSQlflXue7wEZ/zwv+/Hzm1gd6Y1OpWpwPDgWPqnR3FjnBJm4a0cY5Q0
         ZxUnaWwDPaCeMAtGm2Cr+0jD7CykU38ZGdxw78ZwyVsMlQ8axvbF7DsfajwOUflc8Y+e
         N9sOLvNkGI8mgABbWzD3GKbLDl9qBOFocS14lDUJsY28r5QO41jsJwHTGvOBJWpXx1ZV
         0Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=w1VewG6/ucM/kWlIiY+OEg0V0mx9+6eAtRi0Lhie0XM=;
        b=yQHVi04l9PEaKsJGwuTQugr3XZNyysyPDDaHElMtJveVLuH03QTrNmnd+ak4zfZPCp
         QwpOxv6XZ4G6QEasiVQ87yzrbiPQZVCOX8kYYxuF8AOcmAxy6XEkZ5547PbEb3KYla0Z
         m5h/GDV0dC0xKl/nCoqsSPt/ZxRKqY2YiMzTQMYN+nUV7h37CPjgVO4otSHYghiiyRs1
         5H6ldGiY+0CRiPK66dw+QG6VZFs9lhw+XLasiJ+kWILV9ZyKgrfWXXq8jYL8YWQT+iVj
         sacNWcje79lUEcSuJrRfyZq4HmEyX0KMjINPhg+56zx/hs7pFRqepUNNrbk4Bhw/fnbc
         2Zpg==
X-Gm-Message-State: ACrzQf2lsIkHuF6HxbwpaRSy7xD5aQ0WoQYu1+QnbdTuqn8t/jZZvuWt
        +QYePLI7mmVW5FwU+GtiPrcPmdljyTuFtJ5EV68=
X-Google-Smtp-Source: AMsMyM6YfkwaQZI8VA1GX09CQYJhLs6XtLjF9X9QwGccCpJhS1/Y/ezpwRrI67d9a0y9ulfsLbxEglc5x0GPl3wehn4=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:8142:a086:b6c7:da71])
 (user=ndesaulniers job=sendgmr) by 2002:a25:70d7:0:b0:6bc:20d5:b4b7 with SMTP
 id l206-20020a2570d7000000b006bc20d5b4b7mr10140202ybc.175.1664572511464; Fri,
 30 Sep 2022 14:15:11 -0700 (PDT)
Date:   Fri, 30 Sep 2022 14:15:05 -0700
In-Reply-To: <202209291607.0MlscIht-lkp@intel.com>
Mime-Version: 1.0
References: <202209291607.0MlscIht-lkp@intel.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664572505; l=8791;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=lUHlzSuudiJPVlmyWzn9mgQxtMlrWznVl5z96sKGkm0=;
 b=klReRD9UTEurRxPEn7v7Gd0sQIl5ojDRVmi98qbP9jMxVf+iTDPbNWAIVcyl78Z2aukRN7HsHkT6
 TsjkJLbTDyk437hkn9Vgicxxb0pverqsO5Ltyk3o43d6Mg62tdzh
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930211505.209939-1-ndesaulniers@google.com>
Subject: [PATCH v3] ARM: kprobes: move __kretprobe_trampoline to out of line assembler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Logan Chien <loganchien@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

commit 1069c1dd20a3 ("ARM: 9231/1: Recover kretprobes return address for
EABI stack unwinder")
tickled a bug in clang's integrated assembler where the .save and .pad
directives must have corresponding .fnstart directives. The integrated
assembler is unaware that the compiler will be generating the .fnstart
directive.

  arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
  .save or .vsave directives
  <inline asm>:3:2: note: instantiated into assembly here
  .save   {sp, lr, pc}
  ^
  arch/arm/probes/kprobes/core.c:412:29: error: .fnstart must precede
  .pad directive
  <inline asm>:6:2: note: instantiated into assembly here
  .pad    #52
  ^

__kretprobe_trampoline's definition is already entirely inline asm. Move
it to out-of-line asm to avoid breaking the build. Forward declare
trampoline_handler() to avoid -Wmissing-prototypes since it's only
called from assembler. Fixes another instance of -Wmissing-prototypes on
kprobe_handler() so that arch/arm/probes/kprobes/core.c builds cleanly
with W=1.

Link: https://github.com/llvm/llvm-project/issues/57993
Link: https://github.com/ClangBuiltLinux/linux/issues/1718
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Suggested-by: Logan Chien <loganchien@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Fix -Wmissing-prototypes on trampoline_handler() as reported by kernel
  test robot.
* Update comment above trampoline_handler().
* Fix another pre-existing case of -Wmissing-prototypes on
  kprobe_handler() so that arch/arm/probes/kprobes/core.c builds cleanly
  with W=1.
* Make note of the above in the commit message.

Changes v1 -> v2:
* rebase on linux-next again.
* drop commented out declaration of __kretprobe_trampoline from v1.

 arch/arm/probes/kprobes/Makefile              |  1 +
 arch/arm/probes/kprobes/core.c                | 54 +++---------------
 .../arm/probes/kprobes/kretprobe-trampoline.S | 55 +++++++++++++++++++
 include/asm-generic/kprobes.h                 | 13 +++--
 4 files changed, 72 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/probes/kprobes/kretprobe-trampoline.S

diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
index 6159010dac4a..cdbe9dd99e28 100644
--- a/arch/arm/probes/kprobes/Makefile
+++ b/arch/arm/probes/kprobes/Makefile
@@ -3,6 +3,7 @@ KASAN_SANITIZE_actions-common.o := n
 KASAN_SANITIZE_actions-arm.o := n
 KASAN_SANITIZE_actions-thumb.o := n
 obj-$(CONFIG_KPROBES)		+= core.o actions-common.o checkers-common.o
+obj-$(CONFIG_KPROBES)		+= kretprobe-trampoline.o
 obj-$(CONFIG_ARM_KPROBES_TEST)	+= test-kprobes.o
 test-kprobes-objs		:= test-core.o
 
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 9090c3a74dcc..11159fcf6ba6 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -233,7 +233,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
  * kprobe, and that level is reserved for user kprobe handlers, so we can't
  * risk encountering a new kprobe in an interrupt handler.
  */
-void __kprobes kprobe_handler(struct pt_regs *regs)
+static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
@@ -366,53 +366,11 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 }
 
 /*
- * When a retprobed function returns, trampoline_handler() is called,
- * calling the kretprobe's handler. We construct a struct pt_regs to
- * give a view of registers r0-r11, sp, lr, and pc to the user
- * return-handler. This is not a complete pt_regs structure, but that
- * should be enough for stacktrace from the return handler with or
- * without pt_regs.
+ * Called from __kretprobe_trampoline in assembler. Forward declare to avoid
+ * -Wmissing-prototypes.
  */
-void __naked __kprobes __kretprobe_trampoline(void)
-{
-	__asm__ __volatile__ (
-#ifdef CONFIG_FRAME_POINTER
-		"ldr	lr, =__kretprobe_trampoline	\n\t"
-	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
-#ifdef CONFIG_CC_IS_CLANG
-		"stmdb	sp, {sp, lr, pc}	\n\t"
-		"sub	sp, sp, #12		\n\t"
-		/* In clang case, pt_regs->ip = lr. */
-		"stmdb	sp!, {r0 - r11, lr}	\n\t"
-		/* fp points regs->r11 (fp) */
-		"add	fp, sp,	#44		\n\t"
-#else /* !CONFIG_CC_IS_CLANG */
-		/* In gcc case, pt_regs->ip = fp. */
-		"stmdb	sp, {fp, sp, lr, pc}	\n\t"
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
-		/* fp points regs->r15 (pc) */
-		"add	fp, sp, #60		\n\t"
-#endif /* CONFIG_CC_IS_CLANG */
-#else /* !CONFIG_FRAME_POINTER */
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
-#endif /* CONFIG_FRAME_POINTER */
-		"mov	r0, sp			\n\t"
-		"bl	trampoline_handler	\n\t"
-		"mov	lr, r0			\n\t"
-		"ldmia	sp!, {r0 - r11}		\n\t"
-		"add	sp, sp, #16		\n\t"
-#ifdef CONFIG_THUMB2_KERNEL
-		"bx	lr			\n\t"
-#else
-		"mov	pc, lr			\n\t"
-#endif
-		: : : "memory");
-}
-
-/* Called from __kretprobe_trampoline */
-static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
+void *trampoline_handler(struct pt_regs *regs);
+__kprobes void *trampoline_handler(struct pt_regs *regs)
 {
 	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->ARM_fp);
 }
@@ -420,6 +378,8 @@ static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
+	extern void __kretprobe_trampoline(void);
+
 	ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
 	ri->fp = (void *)regs->ARM_fp;
 
diff --git a/arch/arm/probes/kprobes/kretprobe-trampoline.S b/arch/arm/probes/kprobes/kretprobe-trampoline.S
new file mode 100644
index 000000000000..261c99b8c17f
--- /dev/null
+++ b/arch/arm/probes/kprobes/kretprobe-trampoline.S
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/unwind.h>
+#include <asm-generic/kprobes.h>
+
+/*
+ * When a retprobed function returns, trampoline_handler() is called,
+ * calling the kretprobe's handler. We construct a struct pt_regs to
+ * give a view of registers r0-r11, sp, lr, and pc to the user
+ * return-handler. This is not a complete pt_regs structure, but that
+ * should be enough for stacktrace from the return handler with or
+ * without pt_regs.
+ */
+__KPROBE
+SYM_FUNC_START(__kretprobe_trampoline)
+UNWIND(.fnstart)
+	ldr	lr, =__kretprobe_trampoline
+#ifdef CONFIG_FRAME_POINTER
+	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
+#ifdef CONFIG_CC_IS_CLANG
+	stmdb	sp, {sp, lr, pc}
+	sub	sp, sp, #12
+	/* In clang case, pt_regs->ip = lr. */
+	stmdb	sp!, {r0 - r11, lr}
+	/* fp points regs->r11 (fp) */
+	add	fp, sp, #44
+#else /* !CONFIG_CC_IS_CLANG */
+	/* In gcc case, pt_regs->ip = fp. */
+	stmdb	sp, {fp, sp, lr, pc}
+	sub	sp, sp, #16
+	stmdb	sp!, {r0 - r11}
+	/* fp points regs->r15 (pc) */
+	add	fp, sp, #60
+#endif /* CONFIG_CC_IS_CLANG */
+#else /* !CONFIG_FRAME_POINTER */
+	/* store SP, LR on stack and add EABI unwind hint */
+	stmdb	sp, {sp, lr, pc}
+UNWIND(.save	{sp, lr, pc})
+	sub	sp, sp, #16
+	stmdb	sp!, {r0 - r11}
+UNWIND(.pad	#52)
+#endif /* CONFIG_FRAME_POINTER */
+	mov	r0, sp
+	bl	trampoline_handler
+	mov	lr, r0
+	ldmia	sp!, {r0 - r11}
+	add	sp, sp, #16
+#ifdef CONFIG_THUMB2_KERNEL
+	bx	lr
+#else
+	mov	pc, lr
+#endif
+UNWIND(.fnend)
+SYM_FUNC_END(__kretprobe_trampoline)
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 060eab094e5a..1509daa281b8 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -2,7 +2,11 @@
 #ifndef _ASM_GENERIC_KPROBES_H
 #define _ASM_GENERIC_KPROBES_H
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#ifdef __KERNEL__
+
+#ifdef __ASSEMBLY__
+# define __KPROBE .section ".kprobes.text", "ax"
+#else
 #ifdef CONFIG_KPROBES
 /*
  * Blacklist ganerating macro. Specify functions which is not probed
@@ -16,11 +20,12 @@ static unsigned long __used					\
 /* Use this to forbid a kprobes attach on very low level functions */
 # define __kprobes	__section(".kprobes.text")
 # define nokprobe_inline	__always_inline
-#else
+#else /* !defined(CONFIG_KPROBES) */
 # define NOKPROBE_SYMBOL(fname)
 # define __kprobes
 # define nokprobe_inline	inline
-#endif
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(CONFIG_KPROBES) */
+#endif /* defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) */
 
 #endif /* _ASM_GENERIC_KPROBES_H */
-- 
2.38.0.rc1.362.ged0d419d3c-goog


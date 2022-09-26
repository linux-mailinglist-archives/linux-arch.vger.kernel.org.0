Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6824F5EB022
	for <lists+linux-arch@lfdr.de>; Mon, 26 Sep 2022 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIZSiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 14:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiIZShx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 14:37:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C97D6D9E7
        for <linux-arch@vger.kernel.org>; Mon, 26 Sep 2022 11:37:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m131-20020a252689000000b006b2bf1dd88cso6566916ybm.19
        for <linux-arch@vger.kernel.org>; Mon, 26 Sep 2022 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=znhGVGmm6TLIt/hCvZyRbrWMCYyq9RR6vI5Xw2wMKC4=;
        b=d68/aWCLPiIhe6kggZL49/Bh7V4/p14HgIMbRCvVM2NXYFgGVn+Xq9brpRwfNhGn1c
         bzJwZSeSD28a7Y9C2q6pU7Ns5YVEFTZe/NUDWalKdLmiDD2Ycu38MkayfNaqystb+Yqe
         2uitdjgk1pKgDrhsqNj5Zi+us9bovm9f4gWEJiOjaim9mYiKX/XM3sYD5w/R4o2mb4mZ
         CFQt2YiJ+JQ5f5ciYi+1HTq4fleAv03ZClh98oFN7wKat0tgF+afcbUELEguex2NqQsj
         ebHSIrxp17+FxDtmN9isOGdXvSr28CY+GxWqR7nRTLSnzGkZucq1jvCcRo3Cov2rfSOI
         8Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=znhGVGmm6TLIt/hCvZyRbrWMCYyq9RR6vI5Xw2wMKC4=;
        b=5QnlDL8HLyFO/AuEj/XILlnJIOXWcjr98oKWBwkJh7nCtrqdHHoiSUiASixOEOy4vq
         C5DjvhPrTLB0u02Bv/LYi+GAucf6AomJzbL7/YM3gJhrGqNk7fZwf58PXGuOE+LDVDHj
         yfaTBlhjc1wzHG1jxcof9aaOm7aov6ia6IbRlEKdjjUpJ+AaRUt6H9gTxBX2cFDV+biF
         qfj66yeHeFZYOpqunik5BxNcB/sn/fEfmY4ciJ9ovhZr/N9eUlns9Prss1FnyHdzy2Gh
         0oncexUABCriR7r0f6/0j951TFew1lHD6cjt5KPirEgKEZ38JwkX4IKpFbuuilGjiJkJ
         OZKg==
X-Gm-Message-State: ACrzQf0hBxadGDMq/fRccf/NIGawCV8yOuD0XGcrXC54XF6A6sFJImo+
        QW8PFQtvVVz0YZJKtw5w/9dbFm4bWzcTMvoFfoQ=
X-Google-Smtp-Source: AMsMyM4bDMVt1tdnaBnUxux6UCle3vtahK9wHgCGdwWVS1dv1pQjCOyBISO8bmwfU2AlX2gfDPcGjZtYrAVWpRrRAUc=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:0:100e:712:8fb4:fe0d:d74c:5bcb])
 (user=ndesaulniers job=sendgmr) by 2002:a25:f628:0:b0:6bc:bb6:aec5 with SMTP
 id t40-20020a25f628000000b006bc0bb6aec5mr929868ybd.139.1664217469129; Mon, 26
 Sep 2022 11:37:49 -0700 (PDT)
Date:   Mon, 26 Sep 2022 11:37:25 -0700
In-Reply-To: <CAKwvOdkCCyP8W2pHf9ETKMgUtKCgcSwUb6=bMJ_8riwjyknpCw@mail.gmail.com>
Mime-Version: 1.0
References: <CAKwvOdkCCyP8W2pHf9ETKMgUtKCgcSwUb6=bMJ_8riwjyknpCw@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664217445; l=7895;
 i=ndesaulniers@google.com; s=20220923; h=from:subject; bh=x0RwTwO74GUfeRgTrJP+F6BnwHVqyXRlkCvRcvW1NlM=;
 b=aATOabxLSS9znVNtm6L5GIkLiNWqOo9CDSaqmGgfeElYHBzA7DRPuBx916vBrYh+uPU8ccbHNwUy
 5wYW/6BNB3vDlr9XOrgMb7SvlKfMG6oNcMPwlge2WJWmJuq1ioxM
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926183725.1112298-1-ndesaulniers@google.com>
Subject: [PATCH] ARM: kprobes: move __kretprobe_trampoline to out of line assembler
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
it to out-of-line asm to avoid breaking the build.

Link: https://github.com/llvm/llvm-project/issues/57993
Link: https://github.com/ClangBuiltLinux/linux/issues/1718
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Suggested-by: Logan Chien <loganchien@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note: I wasn't quite sure if a Fixes tag against 1069c1dd20a3 was
appropriate here? Either way, if 1069c1dd20a3 gets picked up for stable
without this, it will break clang builds.

 arch/arm/probes/kprobes/Makefile              |  1 +
 arch/arm/probes/kprobes/core.c                | 54 ++----------------
 .../arm/probes/kprobes/kretprobe-trampoline.S | 55 +++++++++++++++++++
 include/asm-generic/kprobes.h                 | 13 +++--
 4 files changed, 69 insertions(+), 54 deletions(-)
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
index 1435b508aa36..17d7e0259e63 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -375,58 +375,10 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return NOTIFY_DONE;
 }
 
-/*
- * When a retprobed function returns, trampoline_handler() is called,
- * calling the kretprobe's handler. We construct a struct pt_regs to
- * give a view of registers r0-r11, sp, lr, and pc to the user
- * return-handler. This is not a complete pt_regs structure, but that
- * should be enough for stacktrace from the return handler with or
- * without pt_regs.
- */
-void __naked __kprobes __kretprobe_trampoline(void)
-{
-	__asm__ __volatile__ (
-		"ldr	lr, =__kretprobe_trampoline	\n\t"
-#ifdef CONFIG_FRAME_POINTER
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
-		/* store SP, LR on stack and add EABI unwind hint */
-		"stmdb  sp, {sp, lr, pc}	\n\t"
-		".save	{sp, lr, pc}	\n\t"
-		"sub	sp, sp, #16		\n\t"
-		"stmdb	sp!, {r0 - r11}		\n\t"
-		".pad	#52				\n\t"
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
+/*void __kretprobe_trampoline(void);*/
 
 /* Called from __kretprobe_trampoline */
-static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
+__kprobes void *trampoline_handler(struct pt_regs *regs)
 {
 	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->TRAMP_FP);
 }
@@ -434,6 +386,8 @@ static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
+	extern void __kretprobe_trampoline(void);
+
 	ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
 	ri->fp = (void *)regs->TRAMP_FP;
 
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
2.37.3.998.g577e59143f-goog


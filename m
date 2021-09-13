Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CD409F9C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbhIMW0J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhIMW0I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2021 18:26:08 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABFAC061574
        for <linux-arch@vger.kernel.org>; Mon, 13 Sep 2021 15:24:52 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c22-20020ac80096000000b0029f6809300eso57557169qtg.6
        for <linux-arch@vger.kernel.org>; Mon, 13 Sep 2021 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LKWy/ERI3BTZ8aFYD304ShajbrTpx8URfXOEqSnPWPM=;
        b=ePQF1HZ5eRhsFUBH3X5/e3Fo1vVe0ahZRPvRTt135uO84nFo/7cZEY+Bp3e7JqWa6X
         /k9qUsY6gcg2+JDnmxOacQt1Ox2WxbkyUupkz0C1l/TpR2xDxxPiZ1kxtJ1Vq7emBV/W
         ceFLCZvO87xTrZ77Sy7wy5unuHNeV1rn5UHH+RNI4iwJJi82rTvYmL9HstFjwRXNLbQC
         TZYy/ni1CGBc7FKeoKT8Zo5KEPWY2gcMVXMX1DUJpetHj0/SS0sZo6chSHyHe0Fbr5i0
         l0sPeWspv0Lm3TsCr8A9QpaXaJfUcaM8tyv9rErLIXZsARbQlVnBpfWDtyM43RJUb3Fi
         Y3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LKWy/ERI3BTZ8aFYD304ShajbrTpx8URfXOEqSnPWPM=;
        b=Z1TweC7RdNUgpPHvB7r6YM2nUNYMuji+2CdOG9XU0/aEBqNM8OomeieLIV7JwJrUc3
         n7KA97L5xl659o23YTAuKXf68FfE29GgB8vcdy5PHZmUyw3lnUXgJFu08xFSAG6eMgmc
         PaE/c6wQ2rd3MQzCfZfyaGF5ZXexQXKSJRQrnlES+mW16E64FWIKe3qc+E7+6mLtZmzW
         uGzIF75tE2LXgW+07FvBfciQ4XfNZ4y2n9bqYPrvDxKm1Qx/aiN0G5C/4wHslKRnh9Oh
         BQTxUfl0akMKWaan0zjSYBpG7G+jXGXGW150U0guL1Stn4Hhod7NbVicV3jKqehm0Wli
         EO0w==
X-Gm-Message-State: AOAM533TfZbvmFXlg4JhNzFednhZjW0P9xWhh+md6Zcf7cal+rjU3qES
        IuMMgvkKWxxrYMCHa2EKypVdyTA=
X-Google-Smtp-Source: ABdhPJwJSC5hyQ6DaoMrbMgwYOVr2+seMYbgGP5wlI87IQLrJijXoy0uiDmzSsdlLo+9yU9AlpQzyP4=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f533:d5d5:c2b4:c981])
 (user=pcc job=sendgmr) by 2002:a05:6214:3ca:: with SMTP id
 ce10mr1984213qvb.12.1631571891299; Mon, 13 Sep 2021 15:24:51 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:24:47 -0700
Message-Id: <20210913222447.4112-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] arch: remove unused function syscall_set_arguments()
From:   Peter Collingbourne <pcc@google.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Collingbourne <pcc@google.com>, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This function appears to have been unused since it was first introduced in
commit 828c365cc8b8 ("tracehook: asm/syscall.h").

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I8ce04f002903a37c0b6c1d16e9b2a3afa716c097
---
 arch/arm/include/asm/syscall.h        | 10 --------
 arch/arm64/include/asm/syscall.h      | 10 --------
 arch/csky/include/asm/syscall.h       |  9 --------
 arch/ia64/include/asm/syscall.h       | 17 ++------------
 arch/ia64/kernel/ptrace.c             | 31 ++++++++++---------------
 arch/microblaze/include/asm/syscall.h | 33 ---------------------------
 arch/nds32/include/asm/syscall.h      | 22 ------------------
 arch/nios2/include/asm/syscall.h      | 11 ---------
 arch/openrisc/include/asm/syscall.h   |  7 ------
 arch/powerpc/include/asm/syscall.h    | 10 --------
 arch/riscv/include/asm/syscall.h      |  9 --------
 arch/s390/include/asm/syscall.h       | 12 ----------
 arch/sh/include/asm/syscall_32.h      | 12 ----------
 arch/sparc/include/asm/syscall.h      | 10 --------
 arch/um/include/asm/syscall-generic.h | 14 ------------
 arch/x86/include/asm/syscall.h        | 33 ---------------------------
 arch/xtensa/include/asm/syscall.h     | 11 ---------
 include/asm-generic/syscall.h         | 16 -------------
 18 files changed, 14 insertions(+), 263 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 24c19d63ff0a..dfeed440254a 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -77,16 +77,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->ARM_r0 + 1, 5 * sizeof(args[0]));
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	regs->ARM_ORIG_r0 = args[0];
-	args++;
-
-	memcpy(&regs->ARM_r0 + 1, args, 5 * sizeof(args[0]));
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* ARM tasks don't change audit architectures on the fly. */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 03e20895453a..4cfe9b49709b 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -73,16 +73,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->regs[1], 5 * sizeof(args[0]));
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	regs->orig_x0 = args[0];
-	args++;
-
-	memcpy(&regs->regs[1], args, 5 * sizeof(args[0]));
-}
-
 /*
  * We don't care about endianness (__AUDIT_ARCH_LE bit) here because
  * AArch64 has the same system calls both on little- and big- endian.
diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index f624fa3bbc22..0de5734950bf 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -59,15 +59,6 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
 }
 
-static inline void
-syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-		      const unsigned long *args)
-{
-	regs->orig_a0 = args[0];
-	args++;
-	memcpy(&regs->a1, args, 5 * sizeof(regs->a1));
-}
-
 static inline int
 syscall_get_arch(struct task_struct *task)
 {
diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
index 0d23c0049301..2b02a3fb862a 100644
--- a/arch/ia64/include/asm/syscall.h
+++ b/arch/ia64/include/asm/syscall.h
@@ -55,21 +55,8 @@ static inline void syscall_set_return_value(struct task_struct *task,
 	}
 }
 
-extern void ia64_syscall_get_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned long *args, int rw);
-static inline void syscall_get_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 unsigned long *args)
-{
-	ia64_syscall_get_set_arguments(task, regs, args, 0);
-}
-
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 unsigned long *args)
-{
-	ia64_syscall_get_set_arguments(task, regs, args, 1);
-}
+extern void syscall_get_arguments(struct task_struct *task,
+	struct pt_regs *regs, unsigned long *args);
 
 static inline int syscall_get_arch(struct task_struct *task)
 {
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index df28c7dd164f..6a1439eaa050 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -2001,17 +2001,16 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *tsk)
 	return &user_ia64_view;
 }
 
-struct syscall_get_set_args {
+struct syscall_get_args {
 	unsigned int i;
 	unsigned int n;
 	unsigned long *args;
 	struct pt_regs *regs;
-	int rw;
 };
 
-static void syscall_get_set_args_cb(struct unw_frame_info *info, void *data)
+static void syscall_get_args_cb(struct unw_frame_info *info, void *data)
 {
-	struct syscall_get_set_args *args = data;
+	struct syscall_get_args *args = data;
 	struct pt_regs *pt = args->regs;
 	unsigned long *krbs, cfm, ndirty, nlocals, nouts;
 	int i, count;
@@ -2042,37 +2041,31 @@ static void syscall_get_set_args_cb(struct unw_frame_info *info, void *data)
 	/* Iterate over outs. */
 	for (i = 0; i < count; i++) {
 		int j = ndirty + nlocals + i + args->i;
-		if (args->rw)
-			*ia64_rse_skip_regs(krbs, j) = args->args[i];
-		else
-			args->args[i] = *ia64_rse_skip_regs(krbs, j);
+		args->args[i] = *ia64_rse_skip_regs(krbs, j);
 	}
 
-	if (!args->rw) {
-		while (i < args->n) {
-			args->args[i] = 0;
-			i++;
-		}
+	while (i < args->n) {
+		args->args[i] = 0;
+		i++;
 	}
 }
 
-void ia64_syscall_get_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned long *args, int rw)
+void syscall_get_arguments(struct task_struct *task,
+	struct pt_regs *regs, unsigned long *args)
 {
-	struct syscall_get_set_args data = {
+	struct syscall_get_args data = {
 		.i = 0,
 		.n = 6,
 		.args = args,
 		.regs = regs,
-		.rw = rw,
 	};
 
 	if (task == current)
-		unw_init_running(syscall_get_set_args_cb, &data);
+		unw_init_running(syscall_get_args_cb, &data);
 	else {
 		struct unw_frame_info ufi;
 		memset(&ufi, 0, sizeof(ufi));
 		unw_init_from_blocked_task(&ufi, task);
-		syscall_get_set_args_cb(&ufi, &data);
+		syscall_get_args_cb(&ufi, &data);
 	}
 }
diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
index 3a6924f3cbde..5eb3f624cc59 100644
--- a/arch/microblaze/include/asm/syscall.h
+++ b/arch/microblaze/include/asm/syscall.h
@@ -58,28 +58,6 @@ static inline microblaze_reg_t microblaze_get_syscall_arg(struct pt_regs *regs,
 	return ~0;
 }
 
-static inline void microblaze_set_syscall_arg(struct pt_regs *regs,
-					      unsigned int n,
-					      unsigned long val)
-{
-	switch (n) {
-	case 5:
-		regs->r10 = val;
-	case 4:
-		regs->r9 = val;
-	case 3:
-		regs->r8 = val;
-	case 2:
-		regs->r7 = val;
-	case 1:
-		regs->r6 = val;
-	case 0:
-		regs->r5 = val;
-	default:
-		BUG();
-	}
-}
-
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
 					 unsigned long *args)
@@ -91,17 +69,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 		*args++ = microblaze_get_syscall_arg(regs, i++);
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	unsigned int i = 0;
-	unsigned int n = 6;
-
-	while (n--)
-		microblaze_set_syscall_arg(regs, i++, *args++);
-}
-
 asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs);
 asmlinkage void do_syscall_trace_leave(struct pt_regs *regs);
 
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index 7b5180d78e20..90aa56c94af1 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -132,28 +132,6 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(args, &regs->uregs[0] + 1, 5 * sizeof(args[0]));
 }
 
-/**
- * syscall_set_arguments - change system call parameter value
- * @task:	task of interest, must be in system call entry tracing
- * @regs:	task_pt_regs() of @task
- * @args:	array of argument values to store
- *
- * Changes 6 arguments to the system call. The first argument gets value
- * @args[0], and so on.
- *
- * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- */
-static inline void
-syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-		      const unsigned long *args)
-{
-	regs->orig_r0 = args[0];
-	args++;
-
-	memcpy(&regs->uregs[0] + 1, args, 5 * sizeof(args[0]));
-}
-
 static inline int
 syscall_get_arch(struct task_struct *task)
 {
diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 526449edd768..fff52205fb65 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -58,17 +58,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	*args   = regs->r9;
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, const unsigned long *args)
-{
-	regs->r4 = *args++;
-	regs->r5 = *args++;
-	regs->r6 = *args++;
-	regs->r7 = *args++;
-	regs->r8 = *args++;
-	regs->r9 = *args;
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_NIOS2;
diff --git a/arch/openrisc/include/asm/syscall.h b/arch/openrisc/include/asm/syscall.h
index e6383be2a195..903ed882bdec 100644
--- a/arch/openrisc/include/asm/syscall.h
+++ b/arch/openrisc/include/asm/syscall.h
@@ -57,13 +57,6 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	memcpy(args, &regs->gpr[3], 6 * sizeof(args[0]));
 }
 
-static inline void
-syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-		      const unsigned long *args)
-{
-	memcpy(&regs->gpr[3], args, 6 * sizeof(args[0]));
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_OPENRISC;
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index c60ebd04b2ed..52d05b465e3e 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -103,16 +103,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	}
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	memcpy(&regs->gpr[3], args, 6 * sizeof(args[0]));
-
-	/* Also copy the first argument into orig_gpr3 */
-	regs->orig_gpr3 = args[0];
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	if (is_32bit_task())
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index b933b1583c9f..f8686ac98235 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -64,15 +64,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	regs->orig_a0 = args[0];
-	args++;
-	memcpy(&regs->a1, args, 5 * sizeof(regs->a1));
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_64BIT
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index b3dd883699e7..27e3d804b311 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -78,18 +78,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	args[0] = regs->orig_gpr2 & mask;
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	unsigned int n = 6;
-
-	while (n-- > 0)
-		if (n > 0)
-			regs->gprs[2 + n] = args[n];
-	regs->orig_gpr2 = args[0];
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #ifdef CONFIG_COMPAT
diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index cb51a7528384..d87738eebe30 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -57,18 +57,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	args[0] = regs->regs[4];
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	regs->regs[1] = args[5];
-	regs->regs[0] = args[4];
-	regs->regs[7] = args[3];
-	regs->regs[6] = args[2];
-	regs->regs[5] = args[1];
-	regs->regs[4] = args[0];
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	int arch = AUDIT_ARCH_SH;
diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index 62a5a78804c4..20c109ac8cc9 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -117,16 +117,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	}
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	unsigned int i;
-
-	for (i = 0; i < 6; i++)
-		regs->u_regs[UREG_I0 + i] = args[i];
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 #if defined(CONFIG_SPARC64) && defined(CONFIG_COMPAT)
diff --git a/arch/um/include/asm/syscall-generic.h b/arch/um/include/asm/syscall-generic.h
index 2984feb9d576..172b74143c4b 100644
--- a/arch/um/include/asm/syscall-generic.h
+++ b/arch/um/include/asm/syscall-generic.h
@@ -62,20 +62,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	*args   = UPT_SYSCALL_ARG6(r);
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	struct uml_pt_regs *r = &regs->regs;
-
-	UPT_SYSCALL_ARG1(r) = *args++;
-	UPT_SYSCALL_ARG2(r) = *args++;
-	UPT_SYSCALL_ARG3(r) = *args++;
-	UPT_SYSCALL_ARG4(r) = *args++;
-	UPT_SYSCALL_ARG5(r) = *args++;
-	UPT_SYSCALL_ARG6(r) = *args;
-}
-
 /* See arch/x86/um/asm/syscall.h for syscall_get_arch() definition. */
 
 #endif	/* __UM_SYSCALL_GENERIC_H */
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index f7e2d82d24fb..5b85987a5e97 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -87,15 +87,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
-					 const unsigned long *args)
-{
-	BUG_ON(i + n > 6);
-	memcpy(&regs->bx + i, args, n * sizeof(args[0]));
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	return AUDIT_ARCH_I386;
@@ -127,30 +118,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	}
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-# ifdef CONFIG_IA32_EMULATION
-	if (task->thread_info.status & TS_COMPAT) {
-		regs->bx = *args++;
-		regs->cx = *args++;
-		regs->dx = *args++;
-		regs->si = *args++;
-		regs->di = *args++;
-		regs->bp = *args;
-	} else
-# endif
-	{
-		regs->di = *args++;
-		regs->si = *args++;
-		regs->dx = *args++;
-		regs->r10 = *args++;
-		regs->r8 = *args++;
-		regs->r9 = *args;
-	}
-}
-
 static inline int syscall_get_arch(struct task_struct *task)
 {
 	/* x32 tasks should be considered AUDIT_ARCH_X86_64. */
diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index f9a671cbf933..5ee974bf8330 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -68,17 +68,6 @@ static inline void syscall_get_arguments(struct task_struct *task,
 		args[i] = regs->areg[reg[i]];
 }
 
-static inline void syscall_set_arguments(struct task_struct *task,
-					 struct pt_regs *regs,
-					 const unsigned long *args)
-{
-	static const unsigned int reg[] = XTENSA_SYSCALL_ARGUMENT_REGS;
-	unsigned int i;
-
-	for (i = 0; i < 6; ++i)
-		regs->areg[reg[i]] = args[i];
-}
-
 asmlinkage long xtensa_rt_sigreturn(void);
 asmlinkage long xtensa_shmat(int, char __user *, int);
 asmlinkage long xtensa_fadvise64_64(int, int,
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 524218ae3825..81695eb02a12 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -117,22 +117,6 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 			   unsigned long *args);
 
-/**
- * syscall_set_arguments - change system call parameter value
- * @task:	task of interest, must be in system call entry tracing
- * @regs:	task_pt_regs() of @task
- * @args:	array of argument values to store
- *
- * Changes 6 arguments to the system call.
- * The first argument gets value @args[0], and so on.
- *
- * It's only valid to call this when @task is stopped for tracing on
- * entry to a system call, due to %SYSCALL_WORK_SYSCALL_TRACE or
- * %SYSCALL_WORK_SYSCALL_AUDIT.
- */
-void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-			   const unsigned long *args);
-
 /**
  * syscall_get_arch - return the AUDIT_ARCH for the current system call
  * @task:	task of interest, must be blocked
-- 
2.33.0.309.g3052b89438-goog


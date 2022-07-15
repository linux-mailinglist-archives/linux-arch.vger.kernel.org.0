Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12589575CE8
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 10:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiGOIBo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOIBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 04:01:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87877E00F;
        Fri, 15 Jul 2022 01:01:42 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LkkHS3sP7zVg3M;
        Fri, 15 Jul 2022 15:57:56 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 16:01:11 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 16:01:11 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
CC:     <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <ardb@kernel.org>,
        <rmk+kernel@armlinux.org.uk>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] ARM: Recover kretprobes return address for EABI stack unwinder
Date:   Fri, 15 Jul 2022 15:58:04 +0800
Message-ID: <20220715075804.93756-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'fed240d9c974 ("ARM: Recover kretprobe modified return address in stacktrace")'
has implemented kretprobes return address recovery for FP
unwinder, this patch makes it works for EABI unwinder.

It saves __kretprobe_trampoline address in LR on stack to identify
and recover the correct return address in EABI unwinder.

Since EABI doesn't use r11 as frame pointer, we need to use SP to
identify different kretprobes addresses. Here the value of SP has fixed
distance to conventional FP position so it's fine to use it.

Passed kunit kprobes_test on QEMU.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm/Kconfig               |  2 +-
 arch/arm/kernel/unwind.c       | 12 ++++++++++++
 arch/arm/probes/kprobes/core.c | 20 +++++++++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6cc..2bd987aa938d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,7 +3,7 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
+	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index a37ea6c772cd..51e34fa4a4b3 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/kprobes.h>
 
 #include <asm/stacktrace.h>
 #include <asm/traps.h>
@@ -482,6 +483,12 @@ int unwind_frame(struct stackframe *frame)
 	frame->pc = ctrl.vrs[PC];
 	frame->lr_addr = ctrl.lr_addr;
 
+#ifdef CONFIG_KRETPROBES
+	if (is_kretprobe_trampoline(frame->pc))
+		frame->pc = kretprobe_find_ret_addr(frame->tsk,
+					(void *)frame->sp, &frame->kr_cur);
+#endif
+
 	return URC_OK;
 }
 
@@ -522,6 +529,11 @@ void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 		frame.pc = thread_saved_pc(tsk);
 	}
 
+#ifdef CONFIG_KRETPROBES
+	frame.kr_cur = NULL;
+	frame.tsk = tsk;
+#endif
+
 	while (1) {
 		int urc;
 		unsigned long where = frame.pc;
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 9090c3a74dcc..1435b508aa36 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -41,6 +41,16 @@
 			   (unsigned long)(addr) +	\
 			   (size))
 
+/*
+ * Since EABI unwinder doesn't use ARM_fp as conventional fp
+ * use ARM_sp as hint register for kretprobes.
+ */
+#ifdef CONFIG_ARM_UNWIND
+#define TRAMP_FP ARM_sp
+#else /* CONFIG_FRAME_POINTER */
+#define TRAMP_FP ARM_fp
+#endif
+
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -376,8 +386,8 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 void __naked __kprobes __kretprobe_trampoline(void)
 {
 	__asm__ __volatile__ (
-#ifdef CONFIG_FRAME_POINTER
 		"ldr	lr, =__kretprobe_trampoline	\n\t"
+#ifdef CONFIG_FRAME_POINTER
 	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
 #ifdef CONFIG_CC_IS_CLANG
 		"stmdb	sp, {sp, lr, pc}	\n\t"
@@ -395,8 +405,12 @@ void __naked __kprobes __kretprobe_trampoline(void)
 		"add	fp, sp, #60		\n\t"
 #endif /* CONFIG_CC_IS_CLANG */
 #else /* !CONFIG_FRAME_POINTER */
+		/* store SP, LR on stack and add EABI unwind hint */
+		"stmdb  sp, {sp, lr, pc}	\n\t"
+		".save	{sp, lr, pc}	\n\t"
 		"sub	sp, sp, #16		\n\t"
 		"stmdb	sp!, {r0 - r11}		\n\t"
+		".pad	#52				\n\t"
 #endif /* CONFIG_FRAME_POINTER */
 		"mov	r0, sp			\n\t"
 		"bl	trampoline_handler	\n\t"
@@ -414,14 +428,14 @@ void __naked __kprobes __kretprobe_trampoline(void)
 /* Called from __kretprobe_trampoline */
 static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
 {
-	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->ARM_fp);
+	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->TRAMP_FP);
 }
 
 void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
-	ri->fp = (void *)regs->ARM_fp;
+	ri->fp = (void *)regs->TRAMP_FP;
 
 	/* Replace the return addr with trampoline addr. */
 	regs->ARM_lr = (unsigned long)&__kretprobe_trampoline;
-- 
2.17.1


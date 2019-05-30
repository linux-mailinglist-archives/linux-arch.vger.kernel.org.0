Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B01282FD58
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfE3OQM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 10:16:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfE3OQJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:16:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06A13174E;
        Thu, 30 May 2019 07:16:09 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2E023F59C;
        Thu, 30 May 2019 07:16:05 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Subject: [PATCH v6 07/19] arm64: compat: Expose signal related structures
Date:   Thu, 30 May 2019 15:15:19 +0100
Message-Id: <20190530141531.43462-8-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530141531.43462-1-vincenzo.frascino@arm.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The compat signal data structures are required as part of the compat
vDSO implementation in order to provide the unwinding information for
the sigreturn trampolines.

Expose the mentioned data structures as part of signal32.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/signal32.h | 46 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c      | 46 -------------------------------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 58e288aaf0ba..1f05268f4c6d 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -20,6 +20,52 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
+struct compat_sigcontext {
+	/* We always set these two fields to 0 */
+	compat_ulong_t			trap_no;
+	compat_ulong_t			error_code;
+
+	compat_ulong_t			oldmask;
+	compat_ulong_t			arm_r0;
+	compat_ulong_t			arm_r1;
+	compat_ulong_t			arm_r2;
+	compat_ulong_t			arm_r3;
+	compat_ulong_t			arm_r4;
+	compat_ulong_t			arm_r5;
+	compat_ulong_t			arm_r6;
+	compat_ulong_t			arm_r7;
+	compat_ulong_t			arm_r8;
+	compat_ulong_t			arm_r9;
+	compat_ulong_t			arm_r10;
+	compat_ulong_t			arm_fp;
+	compat_ulong_t			arm_ip;
+	compat_ulong_t			arm_sp;
+	compat_ulong_t			arm_lr;
+	compat_ulong_t			arm_pc;
+	compat_ulong_t			arm_cpsr;
+	compat_ulong_t			fault_address;
+};
+
+struct compat_ucontext {
+	compat_ulong_t			uc_flags;
+	compat_uptr_t			uc_link;
+	compat_stack_t			uc_stack;
+	struct compat_sigcontext	uc_mcontext;
+	compat_sigset_t			uc_sigmask;
+	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
+	compat_ulong_t			uc_regspace[128] __attribute__((__aligned__(8)));
+};
+
+struct compat_sigframe {
+	struct compat_ucontext	uc;
+	compat_ulong_t		retcode[2];
+};
+
+struct compat_rt_sigframe {
+	struct compat_siginfo info;
+	struct compat_sigframe sig;
+};
+
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index caea6e25db2a..74e06d8c7c2b 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -30,42 +30,6 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
-struct compat_sigcontext {
-	/* We always set these two fields to 0 */
-	compat_ulong_t			trap_no;
-	compat_ulong_t			error_code;
-
-	compat_ulong_t			oldmask;
-	compat_ulong_t			arm_r0;
-	compat_ulong_t			arm_r1;
-	compat_ulong_t			arm_r2;
-	compat_ulong_t			arm_r3;
-	compat_ulong_t			arm_r4;
-	compat_ulong_t			arm_r5;
-	compat_ulong_t			arm_r6;
-	compat_ulong_t			arm_r7;
-	compat_ulong_t			arm_r8;
-	compat_ulong_t			arm_r9;
-	compat_ulong_t			arm_r10;
-	compat_ulong_t			arm_fp;
-	compat_ulong_t			arm_ip;
-	compat_ulong_t			arm_sp;
-	compat_ulong_t			arm_lr;
-	compat_ulong_t			arm_pc;
-	compat_ulong_t			arm_cpsr;
-	compat_ulong_t			fault_address;
-};
-
-struct compat_ucontext {
-	compat_ulong_t			uc_flags;
-	compat_uptr_t			uc_link;
-	compat_stack_t			uc_stack;
-	struct compat_sigcontext	uc_mcontext;
-	compat_sigset_t			uc_sigmask;
-	int		__unused[32 - (sizeof (compat_sigset_t) / sizeof (int))];
-	compat_ulong_t	uc_regspace[128] __attribute__((__aligned__(8)));
-};
-
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
 	compat_ulong_t	size;
@@ -92,16 +56,6 @@ struct compat_aux_sigframe {
 	unsigned long			end_magic;
 } __attribute__((__aligned__(8)));
 
-struct compat_sigframe {
-	struct compat_ucontext	uc;
-	compat_ulong_t		retcode[2];
-};
-
-struct compat_rt_sigframe {
-	struct compat_siginfo info;
-	struct compat_sigframe sig;
-};
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
-- 
2.21.0


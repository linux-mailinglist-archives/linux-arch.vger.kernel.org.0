Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AADD3BC538
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGFEWE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEWE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:22:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 796236198D;
        Tue,  6 Jul 2021 04:19:23 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 10/19] LoongArch: Add signal handling support
Date:   Tue,  6 Jul 2021 12:18:11 +0800
Message-Id: <20210706041820.1536502-11-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds signal handling support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/sigcontext.h      |  10 +
 arch/loongarch/include/asm/signal.h          |  16 +
 arch/loongarch/include/uapi/asm/sigcontext.h |  40 ++
 arch/loongarch/include/uapi/asm/siginfo.h    |  19 +
 arch/loongarch/include/uapi/asm/signal.h     | 115 ++++
 arch/loongarch/include/uapi/asm/ucontext.h   |  46 ++
 arch/loongarch/kernel/signal-common.h        |  52 ++
 arch/loongarch/kernel/signal.c               | 583 +++++++++++++++++++
 8 files changed, 881 insertions(+)
 create mode 100644 arch/loongarch/include/asm/sigcontext.h
 create mode 100644 arch/loongarch/include/asm/signal.h
 create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
 create mode 100644 arch/loongarch/include/uapi/asm/siginfo.h
 create mode 100644 arch/loongarch/include/uapi/asm/signal.h
 create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
 create mode 100644 arch/loongarch/kernel/signal-common.h
 create mode 100644 arch/loongarch/kernel/signal.c

diff --git a/arch/loongarch/include/asm/sigcontext.h b/arch/loongarch/include/asm/sigcontext.h
new file mode 100644
index 000000000000..c8d46213ad98
--- /dev/null
+++ b/arch/loongarch/include/asm/sigcontext.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SIGCONTEXT_H
+#define _ASM_SIGCONTEXT_H
+
+#include <uapi/asm/sigcontext.h>
+
+#endif /* _ASM_SIGCONTEXT_H */
diff --git a/arch/loongarch/include/asm/signal.h b/arch/loongarch/include/asm/signal.h
new file mode 100644
index 000000000000..530805184ce5
--- /dev/null
+++ b/arch/loongarch/include/asm/signal.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SIGNAL_H
+#define _ASM_SIGNAL_H
+
+#include <uapi/asm/signal.h>
+
+#ifndef __ASSEMBLY__
+
+#include <asm/sigcontext.h>
+#undef __HAVE_ARCH_SIG_BITOPS
+
+#endif /* __ASSEMBLY__ */
+#endif /* _ASM_SIGNAL_H */
diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..da0e5bac2d80
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/sigcontext.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _UAPI_ASM_SIGCONTEXT_H
+#define _UAPI_ASM_SIGCONTEXT_H
+
+#include <linux/types.h>
+#include <asm/processor.h>
+
+/* scalar FP context was used */
+#define USED_FP			(1 << 0)
+
+/* extended context was used, see struct extcontext for details */
+#define USED_EXTCONTEXT		(1 << 1)
+
+#include <linux/posix_types.h>
+/*
+ * Keep this struct definition in sync with the sigcontext fragment
+ * in arch/loongarch/kernel/asm-offsets.c
+ *
+ */
+struct sigcontext {
+	__u64	sc_pc;
+	__u64	sc_regs[32];
+	__u32	sc_flags;
+
+	__u32	sc_fcsr;
+	__u32	sc_vcsr;
+	__u64	sc_fcc;
+	__u64	sc_scr[4];
+
+	union fpureg sc_fpregs[32] FPU_ALIGN;
+	__u8	sc_reserved[4096] __attribute__((__aligned__(16)));
+};
+
+#endif /* _UAPI_ASM_SIGCONTEXT_H */
diff --git a/arch/loongarch/include/uapi/asm/siginfo.h b/arch/loongarch/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..11287ad78138
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/siginfo.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _UAPI_ASM_SIGINFO_H
+#define _UAPI_ASM_SIGINFO_H
+
+#if _LOONGARCH_SZLONG == 32
+#define __ARCH_SI_PREAMBLE_SIZE (3 * sizeof(int))
+#else
+#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
+#endif
+
+#include <asm-generic/siginfo.h>
+
+#endif /* _UAPI_ASM_SIGINFO_H */
diff --git a/arch/loongarch/include/uapi/asm/signal.h b/arch/loongarch/include/uapi/asm/signal.h
new file mode 100644
index 000000000000..2254aef35402
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/signal.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _UAPI_ASM_SIGNAL_H
+#define _UAPI_ASM_SIGNAL_H
+
+#include <linux/types.h>
+
+#ifndef _NSIG
+#define _NSIG		128
+#endif
+#define _NSIG_BPW	__BITS_PER_LONG
+#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#define SIGIOT		 6
+#define SIGBUS		 7
+#define SIGFPE		 8
+#define SIGKILL		 9
+#define SIGUSR1		10
+#define SIGSEGV		11
+#define SIGUSR2		12
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#define SIGSTKFLT	16
+#define SIGCHLD		17
+#define SIGCONT		18
+#define SIGSTOP		19
+#define SIGTSTP		20
+#define SIGTTIN		21
+#define SIGTTOU		22
+#define SIGURG		23
+#define SIGXCPU		24
+#define SIGXFSZ		25
+#define SIGVTALRM	26
+#define SIGPROF		27
+#define SIGWINCH	28
+#define SIGIO		29
+#define SIGPOLL		SIGIO
+#define SIGPWR		30
+#define SIGSYS		31
+#define	SIGUNUSED	31
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#ifndef SIGRTMAX
+#define SIGRTMAX	_NSIG
+#endif
+
+/*
+ * SA_FLAGS values:
+ *
+ * SA_ONSTACK indicates that a registered stack_t will be used.
+ * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
+ * SA_RESETHAND clears the handler when the signal is delivered.
+ * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
+ * SA_NODEFER prevents the current signal from being masked in the handler.
+ *
+ * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
+ * Unix names RESETHAND and NODEFER respectively.
+ */
+#define SA_NOCLDSTOP	0x00000001
+#define SA_NOCLDWAIT	0x00000002
+#define SA_SIGINFO	0x00000004
+#define SA_ONSTACK	0x08000000
+#define SA_RESTART	0x10000000
+#define SA_NODEFER	0x40000000
+#define SA_RESETHAND	0x80000000
+
+#define SA_NOMASK	SA_NODEFER
+#define SA_ONESHOT	SA_RESETHAND
+
+#if !defined MINSIGSTKSZ || !defined SIGSTKSZ
+#define MINSIGSTKSZ	2048
+#define SIGSTKSZ	8192
+#endif
+
+#ifndef __ASSEMBLY__
+typedef struct {
+	unsigned long sig[_NSIG_WORDS];
+} sigset_t;
+
+/* not actually used, but required for linux/syscalls.h */
+typedef unsigned long old_sigset_t;
+
+#include <asm-generic/signal-defs.h>
+
+#ifndef __KERNEL__
+struct sigaction {
+	__sighandler_t sa_handler;
+	unsigned long sa_flags;
+	sigset_t sa_mask;		/* mask last for extensibility */
+};
+#endif
+
+typedef struct sigaltstack {
+	void __user *ss_sp;
+	int ss_flags;
+	size_t ss_size;
+} stack_t;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_SIGNAL_H */
diff --git a/arch/loongarch/include/uapi/asm/ucontext.h b/arch/loongarch/include/uapi/asm/ucontext.h
new file mode 100644
index 000000000000..e3814b5fbce8
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/ucontext.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LOONGARCH_UAPI_ASM_UCONTEXT_H
+#define __LOONGARCH_UAPI_ASM_UCONTEXT_H
+
+/**
+ * struct extcontext - extended context header structure
+ * @magic:	magic value identifying the type of extended context
+ * @size:	the size in bytes of the enclosing structure
+ *
+ * Extended context structures provide context which does not fit within struct
+ * sigcontext. They are placed sequentially in memory at the end of struct
+ * ucontext and struct sigframe, with each extended context structure beginning
+ * with a header defined by this struct. The type of context represented is
+ * indicated by the magic field. Userland may check each extended context
+ * structure against magic values that it recognises. The size field allows any
+ * unrecognised context to be skipped, allowing for future expansion. The end
+ * of the extended context data is indicated by the magic value
+ * END_EXTCONTEXT_MAGIC.
+ */
+struct extcontext {
+	unsigned int		magic;
+	unsigned int		size;
+};
+
+/**
+ * struct ucontext - user context structure
+ * @uc_flags:
+ * @uc_link:
+ * @uc_stack:
+ * @uc_mcontext:	holds basic processor state
+ * @uc_sigmask:
+ * @uc_extcontext:	holds extended processor state
+ */
+struct ucontext {
+	/* Historic fields matching asm-generic */
+	unsigned long		uc_flags;
+	struct ucontext		*uc_link;
+	stack_t			uc_stack;
+	struct sigcontext	uc_mcontext;
+	sigset_t		uc_sigmask;
+
+	/* Extended context structures may follow ucontext */
+	unsigned long long	uc_extcontext[0];
+};
+
+#endif /* __LOONGARCH_UAPI_ASM_UCONTEXT_H */
diff --git a/arch/loongarch/kernel/signal-common.h b/arch/loongarch/kernel/signal-common.h
new file mode 100644
index 000000000000..c0ce90f988e5
--- /dev/null
+++ b/arch/loongarch/kernel/signal-common.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __SIGNAL_COMMON_H
+#define __SIGNAL_COMMON_H
+
+/* #define DEBUG_SIG */
+
+#ifdef DEBUG_SIG
+#  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
+#else
+#  define DEBUGP(fmt, args...)
+#endif
+
+/*
+ * Determine which stack to use..
+ */
+extern void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
+				 size_t frame_size);
+/* Check and clear pending FPU exceptions in saved CSR */
+extern int fpcsr_pending(unsigned int __user *fpcsr);
+
+/* Make sure we will not lose FPU ownership */
+#define lock_fpu_owner()	({ preempt_disable(); pagefault_disable(); })
+#define unlock_fpu_owner()	({ pagefault_enable(); preempt_enable(); })
+
+/* Assembly functions to move context to/from the FPU */
+extern asmlinkage int
+_save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
+extern asmlinkage int
+_restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
+extern asmlinkage int
+_save_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr,
+	void __user *vcsr);
+extern asmlinkage int
+_restore_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr,
+	void __user *vcsr);
+extern asmlinkage int
+_save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr,
+	void __user *vcsr);
+extern asmlinkage int
+_restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr,
+	void __user *vcsr);
+extern asmlinkage int _save_lsx_all_upper(void __user *buf);
+extern asmlinkage int _restore_lsx_all_upper(void __user *buf);
+
+#endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
new file mode 100644
index 000000000000..b722b9e7c380
--- /dev/null
+++ b/arch/loongarch/kernel/signal.c
@@ -0,0 +1,583 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/audit.h>
+#include <linux/cache.h>
+#include <linux/context_tracking.h>
+#include <linux/irqflags.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/personality.h>
+#include <linux/smp.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+#include <linux/unistd.h>
+#include <linux/uprobes.h>
+#include <linux/compiler.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/tracehook.h>
+
+#include <asm/abi.h>
+#include <asm/asm.h>
+#include <asm/cacheflush.h>
+#include <asm/fpu.h>
+#include <asm/ucontext.h>
+#include <asm/cpu-features.h>
+#include <asm/inst.h>
+
+#include "signal-common.h"
+
+static int (*save_fp_context)(void __user *sc);
+static int (*restore_fp_context)(void __user *sc);
+
+struct sigframe {
+	u32 sf_ass[4];		/* argument save space for o32 */
+	u32 sf_pad[2];		/* Was: signal trampoline */
+
+	/* Matches struct ucontext from its uc_mcontext field onwards */
+	struct sigcontext sf_sc;
+	sigset_t sf_mask;
+	unsigned long long sf_extcontext[0];
+};
+
+struct rt_sigframe {
+	u32 rs_ass[4];		/* argument save space for o32 */
+	u32 rs_pad[2];		/* Was: signal trampoline */
+	struct siginfo rs_info;
+	struct ucontext rs_uc;
+};
+
+/*
+ * Thread saved context copy to/from a signal context presumed to be on the
+ * user stack, and therefore accessed with appropriate macros from uaccess.h.
+ */
+static int copy_fp_to_sigcontext(void __user *sc)
+{
+	struct loongarch_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint64_t __user *fcc = sc + abi->off_sc_fcc;
+	uint32_t __user *csr = sc + abi->off_sc_fcsr;
+	int i;
+	int err = 0;
+	int inc = 1;
+
+	for (i = 0; i < NUM_FPU_REGS; i += inc) {
+		err |=
+		    __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+			       &fpregs[4*i]);
+	}
+	err |= __put_user(current->thread.fpu.fcsr, csr);
+	err |= __put_user(current->thread.fpu.fcc, fcc);
+
+	return err;
+}
+
+static int copy_fp_from_sigcontext(void __user *sc)
+{
+	struct loongarch_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint64_t __user *fcc = sc + abi->off_sc_fcc;
+	uint32_t __user *csr = sc + abi->off_sc_fcsr;
+	int i;
+	int err = 0;
+	int inc = 1;
+	u64 fpr_val;
+
+	for (i = 0; i < NUM_FPU_REGS; i += inc) {
+		err |= __get_user(fpr_val, &fpregs[4*i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
+	}
+	err |= __get_user(current->thread.fpu.fcsr, csr);
+	err |= __get_user(current->thread.fpu.fcc, fcc);
+
+	return err;
+}
+
+/*
+ * Wrappers for the assembly _{save,restore}_fp_context functions.
+ */
+static int save_hw_fp_context(void __user *sc)
+{
+	struct loongarch_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint64_t __user *fcc = sc + abi->off_sc_fcc;
+	uint32_t __user *fcsr = sc + abi->off_sc_fcsr;
+
+	return _save_fp_context(fpregs, fcc, fcsr);
+}
+
+static int restore_hw_fp_context(void __user *sc)
+{
+	struct loongarch_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint64_t __user *fcc = sc + abi->off_sc_fcc;
+	uint32_t __user *csr = sc + abi->off_sc_fcsr;
+
+	return _restore_fp_context(fpregs, fcc, csr);
+}
+
+/*
+ * Extended context handling.
+ */
+
+static inline void __user *sc_to_extcontext(void __user *sc)
+{
+	struct ucontext __user *uc;
+
+	/*
+	 * We can just pretend the sigcontext is always embedded in a struct
+	 * ucontext here, because the offset from sigcontext to extended
+	 * context is the same in the struct sigframe case.
+	 */
+	uc = container_of(sc, struct ucontext, uc_mcontext);
+	return &uc->uc_extcontext;
+}
+
+static int save_extcontext(void __user *buf)
+{
+	return 0;
+}
+
+static int restore_extcontext(void __user *buf)
+{
+	return 0;
+}
+
+/*
+ * Helper routines
+ */
+int protected_save_fp_context(void __user *sc)
+{
+	int err = 0;
+	unsigned int used, ext_sz;
+	struct loongarch_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *fcc = sc + abi->off_sc_fcsr;
+	uint32_t __user *fcsr = sc + abi->off_sc_fcsr;
+	uint32_t __user *vcsr = sc + abi->off_sc_vcsr;
+	uint32_t __user *flags = sc + abi->off_sc_flags;
+
+	used = used_math() ? USED_FP : 0;
+	if (!used)
+		goto fp_done;
+
+	while (1) {
+		lock_fpu_owner();
+		if (is_fpu_owner())
+			err = save_fp_context(sc);
+		else
+			err |= copy_fp_to_sigcontext(sc);
+		unlock_fpu_owner();
+		if (likely(!err))
+			break;
+		/* touch the sigcontext and try again */
+		err = __put_user(0, &fpregs[0]) |
+			__put_user(0, &fpregs[31*4]) |
+			__put_user(0, fcc) |
+			__put_user(0, fcsr) |
+			__put_user(0, vcsr);
+		if (err)
+			return err;	/* really bad sigcontext */
+	}
+
+fp_done:
+	ext_sz = err = save_extcontext(sc_to_extcontext(sc));
+	if (err < 0)
+		return err;
+	used |= ext_sz ? USED_EXTCONTEXT : 0;
+
+	return __put_user(used, flags);
+}
+
+int protected_restore_fp_context(void __user *sc)
+{
+	unsigned int used;
+	int err = 0, sig = 0, tmp __maybe_unused;
+	struct loongarch_abi *abi = current->thread.abi;
+	uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
+	uint32_t __user *fcsr = sc + abi->off_sc_fcsr;
+	uint32_t __user *fcc = sc + abi->off_sc_fcsr;
+	uint32_t __user *vcsr = sc + abi->off_sc_vcsr;
+	uint32_t __user *flags = sc + abi->off_sc_flags;
+
+	err = __get_user(used, flags);
+	conditional_used_math(used & USED_FP);
+
+	/*
+	 * The signal handler may have used FPU; give it up if the program
+	 * doesn't want it following sigreturn.
+	 */
+	if (err || !(used & USED_FP))
+		lose_fpu(0);
+
+	if (err)
+		return err;
+
+	if (!(used & USED_FP))
+		goto fp_done;
+
+	err = sig = fpcsr_pending(fcsr);
+	if (err < 0)
+		return err;
+
+	while (1) {
+		lock_fpu_owner();
+		if (is_fpu_owner())
+			err = restore_fp_context(sc);
+		else
+			err |= copy_fp_from_sigcontext(sc);
+		unlock_fpu_owner();
+		if (likely(!err))
+			break;
+		/* touch the sigcontext and try again */
+		err = __get_user(tmp, &fpregs[0]) |
+			__get_user(tmp, &fpregs[31*4]) |
+			__get_user(tmp, fcc) |
+			__get_user(tmp, fcsr) |
+			__get_user(tmp, vcsr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+
+fp_done:
+	if (!err && (used & USED_EXTCONTEXT))
+		err = restore_extcontext(sc_to_extcontext(sc));
+
+	return err ?: sig;
+}
+
+int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
+{
+	int err = 0;
+	int i;
+
+	err |= __put_user(regs->csr_epc, &sc->sc_pc);
+
+	err |= __put_user(0, &sc->sc_regs[0]);
+	for (i = 1; i < 32; i++)
+		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
+
+	/*
+	 * Save FPU state to signal context. Signal handler
+	 * will "inherit" current FPU state.
+	 */
+	err |= protected_save_fp_context(sc);
+
+	return err;
+}
+
+static size_t extcontext_max_size(void)
+{
+	size_t sz = 0;
+
+	/*
+	 * The assumption here is that between this point & the point at which
+	 * the extended context is saved the size of the context should only
+	 * ever be able to shrink (if the task is preempted), but never grow.
+	 * That is, what this function returns is an upper bound on the size of
+	 * the extended context for the current task at the current time.
+	 */
+
+	/* If any context is saved then we'll append the end marker */
+	if (sz)
+		sz += sizeof(((struct extcontext *)NULL)->magic);
+
+	return sz;
+}
+
+int fpcsr_pending(unsigned int __user *fpcsr)
+{
+	int err, sig = 0;
+	unsigned int csr, enabled;
+
+	err = __get_user(csr, fpcsr);
+	enabled = ((csr & FPU_CSR_ALL_E) << 24);
+	/*
+	 * If the signal handler set some FPU exceptions, clear it and
+	 * send SIGFPE.
+	 */
+	if (csr & enabled) {
+		csr &= ~enabled;
+		err |= __put_user(csr, fpcsr);
+		sig = SIGFPE;
+	}
+	return err ?: sig;
+}
+
+int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
+{
+	int err = 0;
+	int i;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	err |= __get_user(regs->csr_epc, &sc->sc_pc);
+
+	for (i = 1; i < 32; i++)
+		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
+
+	return err ?: protected_restore_fp_context(sc);
+}
+
+void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
+			  size_t frame_size)
+{
+	unsigned long sp;
+
+	/* Leave space for potential extended context */
+	frame_size += extcontext_max_size();
+
+	/* Default to using normal stack */
+	sp = regs->regs[3];
+
+	/*
+	 * FPU emulator may have it's own trampoline active just
+	 * above the user stack, 16-bytes before the next lowest
+	 * 16 byte boundary.  Try to avoid trashing it.
+	 */
+	sp -= 32;
+
+	sp = sigsp(sp, ksig);
+
+	return (void __user *)((sp - frame_size) & ALMASK);
+}
+
+/*
+ * Atomically swap in the new signal mask, and wait for a signal.
+ */
+
+asmlinkage void sys_rt_sigreturn(void)
+{
+	struct rt_sigframe __user *frame;
+	struct pt_regs *regs;
+	sigset_t set;
+	int sig;
+
+	regs = current_pt_regs();
+	frame = (struct rt_sigframe __user *)regs->regs[3];
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__copy_from_user(&set, &frame->rs_uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	sig = restore_sigcontext(regs, &frame->rs_uc.uc_mcontext);
+	if (sig < 0)
+		goto badframe;
+	else if (sig)
+		force_sig(sig);
+
+	if (restore_altstack(&frame->rs_uc.uc_stack))
+		goto badframe;
+
+	/*
+	 * Don't let your children do this ...
+	 */
+	__asm__ __volatile__(
+		"or\t$sp, $zero, %0\n\t"
+		"b\tsyscall_exit"
+		: /* no outputs */
+		: "r" (regs));
+	/* Unreached */
+
+badframe:
+	force_sig(SIGSEGV);
+}
+
+static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
+			  struct pt_regs *regs, sigset_t *set)
+{
+	struct rt_sigframe __user *frame;
+	int err = 0;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create siginfo.  */
+	err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
+
+	/* Create the ucontext.	 */
+	err |= __put_user(0, &frame->rs_uc.uc_flags);
+	err |= __put_user(NULL, &frame->rs_uc.uc_link);
+	err |= __save_altstack(&frame->rs_uc.uc_stack, regs->regs[3]);
+	err |= setup_sigcontext(regs, &frame->rs_uc.uc_mcontext);
+	err |= __copy_to_user(&frame->rs_uc.uc_sigmask, set, sizeof(*set));
+
+	if (err)
+		return -EFAULT;
+
+	/*
+	 * Arguments to signal handler:
+	 *
+	 *   a0 = signal number
+	 *   a1 = 0 (should be cause)
+	 *   a2 = pointer to ucontext
+	 *
+	 * $25 and c0_epc point to the signal handler, $29 points to
+	 * the struct rt_sigframe.
+	 */
+	regs->regs[4] = ksig->sig;
+	regs->regs[5] = (unsigned long) &frame->rs_info;
+	regs->regs[6] = (unsigned long) &frame->rs_uc;
+	regs->regs[3] = (unsigned long) frame;
+	regs->regs[1] = (unsigned long) sig_return;
+	regs->csr_epc = (unsigned long) ksig->ka.sa.sa_handler;
+
+	DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
+	       current->comm, current->pid,
+	       frame, regs->csr_epc, regs->regs[1]);
+
+	return 0;
+}
+
+struct loongarch_abi loongarch_abi = {
+	.setup_rt_frame = setup_rt_frame,
+	.restart	= __NR_restart_syscall,
+#ifdef CONFIG_32BIT
+	.audit_arch	= AUDIT_ARCH_LOONGARCH32,
+#else
+	.audit_arch	= AUDIT_ARCH_LOONGARCH64,
+#endif
+
+	.off_sc_fpregs = offsetof(struct sigcontext, sc_fpregs),
+	.off_sc_fcc = offsetof(struct sigcontext, sc_fcc),
+	.off_sc_fcsr = offsetof(struct sigcontext, sc_fcsr),
+	.off_sc_flags = offsetof(struct sigcontext, sc_flags),
+	.off_sc_vcsr = offsetof(struct sigcontext, sc_vcsr),
+
+	.vdso		= &vdso_image,
+};
+
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *oldset = sigmask_to_save();
+	int ret;
+	struct loongarch_abi *abi = current->thread.abi;
+	void *vdso = current->mm->context.vdso;
+
+	/* Are we from a system call? */
+	if (regs->regs[0]) {
+		switch (regs->regs[4]) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->regs[4] = -EINTR;
+			break;
+		case -ERESTARTSYS:
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
+				regs->regs[4] = -EINTR;
+				break;
+			}
+			fallthrough;
+		case -ERESTARTNOINTR:
+			regs->regs[4] = regs->orig_a0;
+			regs->csr_epc -= 4;
+		}
+
+		regs->regs[0] = 0;		/* Don't deal with this again.	*/
+	}
+
+	rseq_signal_deliver(ksig, regs);
+
+	ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
+				  ksig, regs, oldset);
+
+	signal_setup_done(ret, ksig, 0);
+}
+
+static void do_signal(struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	if (get_signal(&ksig)) {
+		/* Whee!  Actually deliver the signal.	*/
+		handle_signal(&ksig, regs);
+		return;
+	}
+
+	/* Are we from a system call? */
+	if (regs->regs[0]) {
+		switch (regs->regs[4]) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			regs->regs[4] = regs->orig_a0;
+			regs->csr_epc -= 4;
+			break;
+
+		case -ERESTART_RESTARTBLOCK:
+			regs->regs[4] = regs->orig_a0;
+			regs->regs[11] = current->thread.abi->restart;
+			regs->csr_epc -= 4;
+			break;
+		}
+		regs->regs[0] = 0;	/* Don't deal with this again.	*/
+	}
+
+	/*
+	 * If there's no signal to deliver, we just put the saved sigmask
+	 * back
+	 */
+	restore_saved_sigmask();
+}
+
+/*
+ * notification of userspace execution resumption
+ * - triggered by the TIF_WORK_MASK flags
+ */
+asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
+	__u32 thread_info_flags)
+{
+	local_irq_enable();
+
+	user_exit();
+
+	if (thread_info_flags & _TIF_UPROBE)
+		uprobe_notify_resume(regs);
+
+	/* deal with pending signal delivery */
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+		do_signal(regs);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
+	}
+
+	user_enter();
+}
+
+static int signal_setup(void)
+{
+	/*
+	 * The offset from sigcontext to extended context should be the same
+	 * regardless of the type of signal, such that userland can always know
+	 * where to look if it wishes to find the extended context structures.
+	 */
+	BUILD_BUG_ON((offsetof(struct sigframe, sf_extcontext) -
+		      offsetof(struct sigframe, sf_sc)) !=
+		     (offsetof(struct rt_sigframe, rs_uc.uc_extcontext) -
+		      offsetof(struct rt_sigframe, rs_uc.uc_mcontext)));
+
+	if (cpu_has_fpu) {
+		save_fp_context = save_hw_fp_context;
+		restore_fp_context = restore_hw_fp_context;
+	} else {
+		save_fp_context = copy_fp_to_sigcontext;
+		restore_fp_context = copy_fp_from_sigcontext;
+	}
+
+	return 0;
+}
+
+arch_initcall(signal_setup);
-- 
2.27.0


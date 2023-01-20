Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8DB675778
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjATOg7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATOgT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:36:19 -0500
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F46CFD2E
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:32 -0800 (PST)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id CF39E35CF6A
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:46 +0100 (CET)
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id 0652B35CD2C; Fri, 20 Jan
 2023 15:20:46 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 274F235CD14; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 8D93B27E043D; Fri, 20 Jan 2023
 15:10:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 525A227E0442; Fri, 20 Jan 2023 15:10:34 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 fP9ew3IpTsDK; Fri, 20 Jan 2023 15:10:34 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id D9D9227E043D; Fri, 20 Jan 2023
 15:10:33 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <4023.63caa33d.26329.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 525A227E0442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223834;
 bh=aXD2STzsmn5SV1hfOdG/cXdwsPHfP17MTko4dr9Gtjo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=WralGqMba+8KbYihsOnUPw91xmkTXXSm6esg3i+xiykENsFIH/hBAV3cxTbS6+AT5
 blVaZ9KQFidgY4WTBZNKj7Olz36kJKylp0IdN7MePkn8hRwTd7XyN9y/C578tKPMZA
 dqOMB7oShxaiqCqn2vBXfoTNlsasV0Yu3mNLULJg=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 21/31] kvx: Add system call support
Date:   Fri, 20 Jan 2023 15:09:52 +0100
Message-ID: <20230120141002.2442-22-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add system call support and related uaccess.h for kvx.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Villette <jvillette@kalray.eu>
Signed-off-by: Julien Villette <jvillette@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2:
     - typo fixes (clober* -> clobber*)
     - use generic __access_ok

 arch/kvx/include/asm/syscall.h       |   73 ++
 arch/kvx/include/asm/syscalls.h      |   21 +
 arch/kvx/include/asm/uaccess.h       |  317 +++++
 arch/kvx/include/asm/unistd.h        |   11 +
 arch/kvx/include/uapi/asm/cachectl.h |   25 +
 arch/kvx/include/uapi/asm/unistd.h   |   16 +
 arch/kvx/kernel/entry.S              | 1759 ++++++++++++++++++++++++++
 arch/kvx/kernel/sys_kvx.c            |   58 +
 arch/kvx/kernel/syscall_table.c      |   19 +
 9 files changed, 2299 insertions(+)
 create mode 100644 arch/kvx/include/asm/syscall.h
 create mode 100644 arch/kvx/include/asm/syscalls.h
 create mode 100644 arch/kvx/include/asm/uaccess.h
 create mode 100644 arch/kvx/include/asm/unistd.h
 create mode 100644 arch/kvx/include/uapi/asm/cachectl.h
 create mode 100644 arch/kvx/include/uapi/asm/unistd.h
 create mode 100644 arch/kvx/kernel/entry.S
 create mode 100644 arch/kvx/kernel/sys_kvx.c
 create mode 100644 arch/kvx/kernel/syscall_table.c

diff --git a/arch/kvx/include/asm/syscall.h b/arch/kvx/include/asm/syscall.h
new file mode 100644
index 000000000000..a3f6cef73e4a
--- /dev/null
+++ b/arch/kvx/include/asm/syscall.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SYSCALL_H
+#define _ASM_KVX_SYSCALL_H
+
+#include <linux/err.h>
+#include <linux/audit.h>
+
+#include <asm/ptrace.h>
+
+/* The array of function pointers for syscalls. */
+extern void *sys_call_table[];
+
+void scall_machine_exit(unsigned char value);
+
+/**
+ * syscall_get_nr - find which system call a task is executing
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * If @task is executing a system call or is at system call
+ * tracing about to attempt one, returns the system call number.
+ * If @task is not executing a system call, i.e. it's blocked
+ * inside the kernel for a fault or signal, returns -1.
+ *
+ * Note this returns int even on 64-bit machines.  Only 32 bits of
+ * system call number can be meaningful.  If the actual arch value
+ * is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
+ *
+ * It's only valid to call this when @task is known to be blocked.
+ */
+static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	if (!in_syscall(regs))
+		return -1;
+
+	return es_sysno(regs);
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	/* 0 if syscall succeeded, otherwise -Errorcode */
+	return IS_ERR_VALUE(regs->r0) ? regs->r0 : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->r0;
+}
+
+static inline int syscall_get_arch(struct task_struct *task)
+{
+	return AUDIT_ARCH_KVX;
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned long *args)
+{
+	args[0] = regs->orig_r0;
+	args++;
+	memcpy(args, &regs->r1, 5 * sizeof(args[0]));
+}
+
+int __init setup_syscall_sigreturn_page(void *sigpage_addr);
+
+#endif
diff --git a/arch/kvx/include/asm/syscalls.h b/arch/kvx/include/asm/syscalls.h
new file mode 100644
index 000000000000..beec95ebb97a
--- /dev/null
+++ b/arch/kvx/include/asm/syscalls.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SYSCALLS_H
+#define _ASM_KVX_SYSCALLS_H
+
+#include <asm-generic/syscalls.h>
+
+/* We redefine clone in assembly for special slowpath */
+asmlinkage long __sys_clone(unsigned long clone_flags, unsigned long newsp,
+			int __user *parent_tid, int __user *child_tid, int tls);
+
+#define sys_clone __sys_clone
+
+long sys_cachectl(unsigned long addr, unsigned long len, unsigned long cache,
+		  unsigned long flags);
+
+#endif
diff --git a/arch/kvx/include/asm/uaccess.h b/arch/kvx/include/asm/uaccess.h
new file mode 100644
index 000000000000..24f91d75c1dd
--- /dev/null
+++ b/arch/kvx/include/asm/uaccess.h
@@ -0,0 +1,317 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * derived from arch/riscv/include/asm/uaccess.h
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef _ASM_KVX_UACCESS_H
+#define _ASM_KVX_UACCESS_H
+
+#include <linux/sched.h>
+#include <linux/types.h>
+
+/**
+ * access_ok: - Checks if a user space pointer is valid
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Checks if a pointer to a block of memory in user space is valid.
+ *
+ * Returns true (nonzero) if the memory block may be valid, false (zero)
+ * if it is definitely invalid.
+ *
+ * Note that, depending on architecture, this function probably just
+ * checks that the pointer is in the user space range - after calling
+ * this function, memory access functions may still return -EFAULT.
+ */
+#define access_ok(addr, size) ({					\
+	__chk_user_ptr(addr);						\
+	likely(__access_ok((addr), (size)));				\
+})
+
+#include <asm-generic/access_ok.h>
+
+/*
+ * The exception table consists of pairs of addresses: the first is the
+ * address of an instruction that is allowed to fault, and the second is
+ * the address at which the program should continue.  No registers are
+ * modified, so it is entirely up to the continuation code to figure out
+ * what to do.
+ *
+ * All the routines below use bits of fixup code that are out of line
+ * with the main instruction path.  This means when everything is well,
+ * we don't even have to jump over them.  Further, they do not intrude
+ * on our cache or TLB entries.
+ */
+
+struct exception_table_entry {
+	unsigned long insn, fixup;
+};
+
+extern int fixup_exception(struct pt_regs *regs);
+
+/**
+ * Assembly defined function (usercopy.S)
+ */
+extern unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n);
+
+extern unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n);
+
+extern unsigned long
+asm_clear_user(void __user *to, unsigned long n);
+
+#define __clear_user asm_clear_user
+
+static inline __must_check unsigned long
+clear_user(void __user *to, unsigned long n)
+{
+	might_fault();
+	if (!access_ok(to, n))
+		return n;
+
+	return asm_clear_user(to, n);
+}
+
+extern __must_check long strnlen_user(const char __user *str, long n);
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+
+#define __enable_user_access()
+#define __disable_user_access()
+
+/**
+ * get_user: - Get a simple variable from user space.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
+#define get_user(x, ptr)						\
+({									\
+	long __e = -EFAULT;						\
+	const __typeof__(*(ptr)) __user *__p = (ptr);			\
+	might_fault();							\
+	if (likely(access_ok(__p, sizeof(*__p)))) {			\
+		__e = __get_user(x, __p);				\
+	} else {							\
+		x = 0;							\
+	}								\
+	__e;								\
+})
+
+/**
+ * __get_user: - Get a simple variable from user space, with less checking.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
+#define __get_user(x, ptr)						\
+({									\
+	unsigned long __err = 0;					\
+	__chk_user_ptr(ptr);						\
+									\
+	__enable_user_access();						\
+	__get_user_nocheck(x, ptr, __err);				\
+	__disable_user_access();					\
+									\
+	__err;								\
+})
+
+#define __get_user_nocheck(x, ptr, err)					\
+do {									\
+	unsigned long __gu_addr = (unsigned long)(ptr);			\
+	unsigned long __gu_val;						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		__get_user_asm("lbz", __gu_val, __gu_addr, err);	\
+		break;							\
+	case 2:								\
+		__get_user_asm("lhz", __gu_val, __gu_addr, err);	\
+		break;							\
+	case 4:								\
+		__get_user_asm("lwz", __gu_val, __gu_addr, err);	\
+		break;							\
+	case 8:								\
+		__get_user_asm("ld", __gu_val, __gu_addr, err);		\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	(x) = (__typeof__(*(ptr)))__gu_val;				\
+} while (0)
+
+#define __get_user_asm(op, x, addr, err)				\
+({									\
+	__asm__ __volatile__(						\
+			"1:     "op" %1 = 0[%2]\n"			\
+			"       ;;\n"					\
+			"2:\n"						\
+			".section .fixup,\"ax\"\n"			\
+			"3:     make %0 = 2b\n"				\
+			"	make %1 = 0\n"				\
+			"       ;;\n"					\
+			"       make %0 = %3\n"				\
+			"       igoto %0\n"				\
+			"       ;;\n"					\
+			".previous\n"					\
+			".section __ex_table,\"a\"\n"			\
+			"       .align 8\n"				\
+			"       .dword 1b,3b\n"				\
+			".previous"					\
+			: "=r"(err), "=r"(x)				\
+			: "r"(addr), "i"(-EFAULT), "0"(err));		\
+})
+
+/**
+ * put_user: - Write a simple value into user space.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define put_user(x, ptr)						\
+({									\
+	long __e = -EFAULT;						\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (likely(access_ok(__p, sizeof(*__p)))) {			\
+		__e = __put_user(x, __p);				\
+	}								\
+	__e;								\
+})
+
+/**
+ * __put_user: - Write a simple value into user space, with less checking.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
+#define __put_user(x, ptr)						\
+({									\
+	unsigned long __err = 0;					\
+	__chk_user_ptr(ptr);						\
+									\
+	__enable_user_access();						\
+	__put_user_nocheck(x, ptr, __err);				\
+	__disable_user_access();					\
+									\
+	__err;								\
+})
+
+#define __put_user_nocheck(x, ptr, err)					\
+do {									\
+	unsigned long __pu_addr = (unsigned long)(ptr);			\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		__put_user_asm("sb", __pu_val, __pu_addr, err);		\
+		break;							\
+	case 2:								\
+		__put_user_asm("sh", __pu_val, __pu_addr, err);		\
+		break;							\
+	case 4:								\
+		__put_user_asm("sw", __pu_val, __pu_addr, err);		\
+		break;							\
+	case 8:								\
+		__put_user_asm("sd", __pu_val, __pu_addr, err);		\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+} while (0)
+
+#define __put_user_asm(op, x, addr, err)				\
+({									\
+	__asm__ __volatile__(						\
+			"1:     "op" 0[%2], %1\n"			\
+			"       ;;\n"					\
+			"2:\n"						\
+			".section .fixup,\"ax\"\n"			\
+			"3:     make %0 = 2b\n"				\
+			"       ;;\n"					\
+			"       make %0 = %3\n"				\
+			"       igoto %0\n"				\
+			"       ;;\n"					\
+			".previous\n"					\
+			".section __ex_table,\"a\"\n"			\
+			"       .align 8\n"				\
+			"       .dword 1b,3b\n"				\
+			".previous"					\
+			: "=r"(err)					\
+			: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err));	\
+})
+
+#define HAVE_GET_KERNEL_NOFAULT
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	long __kr_err;							\
+									\
+	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
+	if (unlikely(__kr_err))						\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	long __kr_err;							\
+									\
+	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
+	if (unlikely(__kr_err))						\
+		goto err_label;						\
+} while (0)
+
+
+#endif	/* _ASM_KVX_UACCESS_H */
diff --git a/arch/kvx/include/asm/unistd.h b/arch/kvx/include/asm/unistd.h
new file mode 100644
index 000000000000..6cd093dbf2d8
--- /dev/null
+++ b/arch/kvx/include/asm/unistd.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define __ARCH_WANT_SYS_CLONE
+
+#include <uapi/asm/unistd.h>
+
+#define NR_syscalls (__NR_syscalls)
diff --git a/arch/kvx/include/uapi/asm/cachectl.h b/arch/kvx/include/uapi/asm/cachectl.h
new file mode 100644
index 000000000000..be0a1aa23cf6
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/cachectl.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _UAPI_ASM_KVX_CACHECTL_H
+#define _UAPI_ASM_KVX_CACHECTL_H
+
+/*
+ * Cache type for cachectl system call
+ */
+#define CACHECTL_CACHE_DCACHE		(1 << 0)
+
+/*
+ * Flags for cachectl system call
+ */
+#define CACHECTL_FLAG_OP_INVAL		(1 << 0)
+#define CACHECTL_FLAG_OP_WB		(1 << 1)
+#define CACHECTL_FLAG_OP_MASK		(CACHECTL_FLAG_OP_INVAL | \
+					 CACHECTL_FLAG_OP_WB)
+
+#define CACHECTL_FLAG_ADDR_PHYS		(1 << 2)
+
+#endif /* _UAPI_ASM_KVX_CACHECTL_H */
diff --git a/arch/kvx/include/uapi/asm/unistd.h b/arch/kvx/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..5f86d81dbb76
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/unistd.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_CLONE3
+
+#include <asm-generic/unistd.h>
+
+/* Additional KVX specific syscalls */
+#define __NR_cachectl (__NR_arch_specific_syscall)
+__SYSCALL(__NR_cachectl, sys_cachectl)
diff --git a/arch/kvx/kernel/entry.S b/arch/kvx/kernel/entry.S
new file mode 100644
index 000000000000..e73dc2221c06
--- /dev/null
+++ b/arch/kvx/kernel/entry.S
@@ -0,0 +1,1759 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Marius Gligor
+ *            Yann Sionneau
+ *            Julien Villette
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+#include <asm/cache.h>
+#include <asm/page.h>
+#include <asm/pgtable-bits.h>
+#include <asm/sys_arch.h>
+#include <asm/sfr_defs.h>
+#include <asm/tlb_defs.h>
+#include <asm/mem_map.h>
+#include <asm/traps.h>
+#include <asm/unistd.h>
+
+#define MMU_SET_MASK		((1 << KVX_SFR_MMC_SS_WIDTH) - 1)
+
+/* Mask to replicate data from 32bits LSB to MSBs */
+#define REPLICATE_32_MASK 0x0804020108040201
+
+#define PS_HWLOOP_ENABLE	(KVX_SFR_PS_HLE_MASK << 32)
+#define PS_HWLOOP_DISABLE	(KVX_SFR_PS_HLE_MASK)
+#define PS_HWLOOP_EN_ET_CLEAR_DAUS_DIS	\
+	(PS_HWLOOP_ENABLE | KVX_SFR_PS_ET_MASK | SFR_SET_VAL_WFXL(PS, DAUS, 0))
+#define PS_ET_CLEAR KVX_SFR_PS_ET_MASK
+#define PS_HLE_EN_IT_EN_ET_CLEAR_DAUS_DIS	\
+		(SFR_SET_VAL_WFXL(PS, HLE, 1) | \
+		SFR_SET_VAL_WFXL(PS, IE, 1) | \
+		SFR_SET_VAL_WFXL(PS, ET, 0) | \
+		SFR_SET_VAL_WFXL(PS, DAUS, 0))
+
+#define PS_IT_DIS		KVX_SFR_PS_IE_MASK
+#define PS_IL_CLEAR		KVX_SFR_PS_IL_WFXL_CLEAR
+
+#define MMC_CLEAR_TLB_CLEAR_WAY \
+	(SFR_CLEAR_WFXL(MMC, SB) | SFR_CLEAR_WFXL(MMC, SW))
+
+#define MMC_SEL_TLB_CLEAR_WAY(__tlb) \
+	(SFR_SET_WFXL(MMC, SB, __tlb) | MMC_CLEAR_TLB_CLEAR_WAY)
+#define MMC_SEL_JTLB_CLEAR_WAY	MMC_SEL_TLB_CLEAR_WAY(MMC_SB_JTLB)
+#define MMC_SEL_LTLB_CLEAR_WAY	MMC_SEL_TLB_CLEAR_WAY(MMC_SB_LTLB)
+
+#define MME_WFXL(_enable)	SFR_SET_VAL_WFXL(PS, MME, _enable)
+
+/* Temporary scract system register for trap handling */
+#define TMP_SCRATCH_SR	$sr_pl3
+
+.altmacro
+
+#define TEL_DEFAULT_VALUE  (TLB_ES_A_MODIFIED << KVX_SFR_TEL_ES_SHIFT)
+
+#define TASK_THREAD_SAVE_AREA_QUAD(__q) \
+				(TASK_THREAD_SAVE_AREA + (__q) * QUAD_REG_SIZE)
+
+#ifdef CONFIG_DEBUG_EXCEPTION_STACK
+.section .rodata
+stack_error_panic_str_label:
+	.string "Stack has been messed up !"
+#endif
+
+#ifdef CONFIG_KVX_DEBUG_TLB_WRITE
+.section .rodata
+mmc_error_panic_str_label:
+	.string "Failed to write entry to the JTLB (in assembly refill)"
+#endif
+
+#ifdef CONFIG_KVX_DEBUG_ASN
+.section .rodata
+asn_error_panic_str_label:
+	.string "ASN mismatch !"
+#endif
+
+/**
+ * call_trace_hardirqs: hardirqs tracing call
+ * state: State of hardirqs to be reported (on/off)
+ */
+.macro call_trace_hardirqs state
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_\state
+	;;
+#endif
+.endm
+
+/**
+ * disable_interrupts: Disable interrupts
+ * tmp_reg: Temporary register to use for interrupt disabling
+ */
+.macro disable_interrupt tmp_reg
+	make \tmp_reg = KVX_SFR_PS_IE_MASK
+	;;
+	wfxl $ps, \tmp_reg
+	;;
+.endm
+
+/**
+ * call_do_work_pending: Call do_work_pending and set stack argument ($r0)
+ * NOTE: Since do_work_pending requires thread_flags in $r1, they must
+ * be provided in $r1 before calling this macro.
+ * Moreover, do_work_pending expects interrupts to be disabled.
+ */
+.macro call_do_work_pending
+	copyd $r0 = $sp
+	call do_work_pending
+	;;
+.endm
+
+/**
+ * save_quad_regs: Save quad registers in temporary thread area
+ * After call, the quad is saved in task_struct.thread.save_area.
+ * sr_swap_reg is only used as a temporary value and will be
+ * restored after returning from this macro
+ *
+ * quad: 	Quad to saved
+ * sr_swap_reg:	Register used for sr swap and quad saving.
+ */
+.macro save_quad_regs quad sr_swap_reg
+	rswap \sr_swap_reg = $sr
+	;;
+	/* Save registers in save_area */
+	so __PA(TASK_THREAD_SAVE_AREA_QUAD(0))[\sr_swap_reg] = \quad
+	/* Restore register */
+	rswap \sr_swap_reg = $sr
+	;;
+.endm
+
+/**
+ * Switch task when entering kernel if needed.
+ * sp_reg: register which will be used to store original stack pointer when
+ * entering the kernel
+ * task_reg: is a register containing the current task pointer
+ * save_regs_label: label to jump to save register immediately. This label is
+ * used when we are already in kernel execution context.
+ * NOTE: when returning from this macro, we consider that the assembly following
+ * it will be executed only when coming from user space
+ */
+.macro switch_stack sp_reg task_reg save_regs_label
+	get \sp_reg = $sps
+	;;
+	/* Check if $sps.pl bit is 0 (ie in kernel mode)
+	 * if so, then we dont have to switch stack */
+	cb.even \sp_reg? \save_regs_label
+	/* Copy original $sp in a scratch reg */
+	copyd \sp_reg = $sp
+	;;
+	/* restore sp from kernel stack pointer */
+	ld $sp = __PA(TASK_THREAD_KERNEL_SP)[\task_reg]
+	;;
+.endm
+
+/**
+ * Disable MMU using a specified register
+ * scratch_reg: Scratch register to be used for $ps modification (clobbered)
+ * ps_val: Additionnal $ps modifications after returning disabling MMU
+ */
+.macro disable_mmu scratch_reg ps_val=0
+	/* Disable MME in $sps */
+	make \scratch_reg = MME_WFXL(0)
+	;;
+	wfxl $sps = \scratch_reg
+	;;
+	/* Enable DAUS in $ps */
+	make \scratch_reg = SFR_SET_VAL_WFXL(PS, DAUS, 1) | \ps_val
+	;;
+	wfxl $ps = \scratch_reg
+	/* We are now accessing data with MMU disabled */
+	;;
+.endm
+
+/**
+ * Disable MMU when entering exception path
+ * This macro does not require any register since used register will be
+ * restored after use. This can safely be used directly after entering
+ * exceptions.
+ */
+.macro exception_entry_disable_mmu
+	set TMP_SCRATCH_SR = $r0
+	disable_mmu $r0
+	;;
+	get $r0 = TMP_SCRATCH_SR
+	;;
+.endm
+
+/* Save callee registers on stack */
+.macro save_callee
+	sq PT_R18R19[$sp] = $r18r19
+	;;
+	so PT_Q20[$sp] = $r20r21r22r23
+	;;
+	so PT_Q24[$sp] = $r24r25r26r27
+	;;
+	so PT_Q28[$sp] = $r28r29r30r31
+	;;
+.endm
+
+/**
+ * Save registers for entry in kernel space.
+ * sp_reg should point to the original stack pointer when entering kernel space
+ * task_reg is a register containing the current task pointer
+ * both task_reg and sp_reg must be in saved_quad since they have been
+ * clobberred and will be restored when restoring saved_quad.
+ * pt_regs_sp is a single register which will be filled by pt_regs addr.
+ * When "returning" from this macro, hardware loop are enabled and exception
+ * is cleared, allowing to call kernel function without any risk.
+ */
+.macro save_regs_for_exception sp_reg task_reg saved_quad pt_regs_sp
+.if (\saved_quad==$r4r5r6r7 || \saved_quad==$r60r61r62r63)
+.error "saved_quad must not be $r4r5r6r7 or $r60r61r62r63 !"
+.endif
+	/* make some room on stack to save registers */
+	addd $sp = $sp, -(PT_SIZE_ON_STACK)
+	so __PA(PT_Q4-PT_SIZE_ON_STACK)[$sp] = $r4r5r6r7
+	/* Compute physical address of stack to avoid using 64bits immediate */
+	addd $r6 = $sp, VA_TO_PA_OFFSET - (PT_SIZE_ON_STACK)
+	;;
+	so PT_Q60[$r6] = $r60r61r62r63
+	/* Now that $r60r61r62r63 is saved, we can use it for saving
+	 * original stack stored in scratch_reg. Note that we can not
+	 * use the r12r13r14r15 quad to do that because it would
+	 * modify the current $r12/sp ! This is if course not what we
+	 * want and hence we use the freshly saved quad $r60r61r62r63.
+	 *
+	 * Note that we must use scratch_reg before reloading the saved
+	 * quad since the scratch reg is contained in it, so reloading
+	 * it before copying it would overwrite it.
+	 */
+	copyd $r60 = \sp_reg
+	;;
+	/* Reload the saved quad registers to save correct values
+	 * Since we use the scratch reg before that */
+	lo \saved_quad = __PA(TASK_THREAD_SAVE_AREA_QUAD(0))[\task_reg]
+	;;
+	so PT_Q8[$r6] = $r8r9r10r11
+	;;
+	so PT_Q0[$r6] = $r0r1r2r3
+	copyd $r61 = $r13
+	get $r5 = $le
+	;;
+	sq PT_R16R17[$r6] = $r16r17
+	make $r10 = 0x0
+	copyd $r62 = $r14
+	;;
+	so PT_Q32[$r6] = $r32r33r34r35
+	/* Since we are going to enable hardware loop, we must be careful
+	 * and reset le (loop exit) to avoid any exploit and return to
+	 * user with kernel mode */
+	set $le = $r10
+	copyd $r63 = $r15
+	;;
+	so PT_Q36[$r6] = $r36r37r38r39
+	get $r0 = $cs
+	;;
+	so PT_Q40[$r6] = $r40r41r42r43
+	get $r1 = $spc
+	;;
+	so PT_Q44[$r6] = $r44r45r46r47
+	get $r2 = $sps
+	;;
+	so PT_Q48[$r6] = $r48r49r50r51
+	get $r3 = $es
+	;;
+	so PT_Q52[$r6] = $r52r53r54r55
+	get $r7 = $ra
+	;;
+	so PT_Q56[$r6] = $r56r57r58r59
+	get $r4 = $lc
+	;;
+	so PT_Q12[$r6] = $r60r61r62r63
+	copyd $r63 = $r6
+	get $r6 = $ls
+	;;
+	so PT_CS_SPC_SPS_ES[$r63] = $r0r1r2r3
+	;;
+	so PT_LC_LE_LS_RA[$r63] = $r4r5r6r7
+	/* Clear frame pointer */
+	make $fp = 0
+	;;
+	/* Copy regs stack pointer for macro caller */
+	copyd \pt_regs_sp = $sp
+#ifdef CONFIG_DEBUG_EXCEPTION_STACK
+	addd $sp = $sp, -STACK_REG_SIZE
+	;;
+	sd VA_TO_PA_OFFSET[$sp] = $sp
+	;;
+#endif
+	/* Reenable hwloop, MMU and clear exception taken */
+	make $r8 = PS_HWLOOP_EN_ET_CLEAR_DAUS_DIS
+	;;
+	wfxl $ps, $r8
+	;;
+.endm
+
+/***********************************************************************
+*                Exception vectors trampolines
+***********************************************************************/
+#define exception_trampoline(__type) \
+.section .exception.## __type, "ax", @progbits ;\
+ENTRY(kvx_##__type ##_handler_trampoline): ;\
+	goto kvx_## __type ##_handler ;\
+	;; ;\
+ENDPROC(kvx_ ## __type ## _handler_trampoline) ;\
+.section .early_exception.## __type, "ax", @progbits ;\
+ENTRY(kvx_## __type ##_early_handler): ;\
+1:	nop ;\
+	;; ;\
+	goto 1b ;\
+	;; ;\
+ENDPROC(kvx_ ## __type ## _early_handler)
+
+exception_trampoline(debug)
+exception_trampoline(trap)
+exception_trampoline(interrupt)
+exception_trampoline(syscall)
+
+#define EXCEPTION_ENTRY(__name) \
+.section .exception.text, "ax", @progbits ;\
+ENTRY(__name)
+
+
+/***********************************************************************
+*                  Common exception return path
+***********************************************************************/
+/**
+ * Restore registers after exception
+ * When entering this macro, $sp must be located right before regs
+ * storage.
+ */
+EXCEPTION_ENTRY(return_from_exception)
+#ifdef CONFIG_DEBUG_EXCEPTION_STACK
+	ld $r1 = 0[$sp]
+	;;
+	sbfd $r1 = $r1, $sp
+	;;
+	cb.deqz $r1, _check_ok
+	;;
+	make $r2 = panic
+	make $r0 = stack_error_panic_str_label
+	;;
+	icall $r2
+	;;
+_check_ok:
+	addd $sp = $sp, STACK_REG_SIZE
+	;;
+#endif
+	get $r11 = $sr
+	/* Load sps value from saved registers */
+	ld $r6 = PT_SPS[$sp]
+	;;
+	/* Disable interrupt to check task flags atomically */
+	disable_interrupt $r60
+	;;
+	/* Check PL bit of sps, if set, then it means we are returning
+	 * to a lower privilege level (ie to user), if so, we need to
+	 * check work pending. If coming from kernel, directly go to
+	 * register restoration */
+	cb.even $r6? _restore_regs
+	ld $r1 = TASK_TI_FLAGS[$r11]
+	;;
+	/* Do we have work pending ? */
+	andd $r5 = $r1, _TIF_WORK_MASK
+	;;
+	/**
+	 * If we do not have work pending (ie $r5 == 0) then we can
+	 * directly jump to _restore_regs without calling do_work_pending
+	 */
+	cb.deqz $r5? _restore_regs
+	;;
+	/*
+	 * Work pending can potentially call a signal handler and then return
+	 * via rt_sigreturn. Return path will be different (restore all regs)
+	 * and hence all registers are needed to be saved.
+	 */
+	save_callee
+	;;
+	call_do_work_pending
+	;;
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* reload sps value from saved registers */
+	ld $r6 = PT_SPS[$sp]
+	;;
+#endif
+_restore_regs:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* Check if IRQs are going to be reenable in next context */
+	andd $r6 = $r6, KVX_SFR_SPS_IE_MASK
+	;;
+	cb.deqz $r6? 1f
+	;;
+	call trace_hardirqs_on
+	;;
+1:
+#endif
+	disable_mmu $r0, PS_HWLOOP_DISABLE
+	;;
+	lo $r0r1r2r3 = __PA(PT_CS_SPC_SPS_ES)[$sp]
+	/* Compute physical address of stack to avoid using 64bits immediate */
+	addd $r11 = $sp, VA_TO_PA_OFFSET
+	;;
+	lo $r4r5r6r7 = PT_LC_LE_LS_RA[$r11]
+	;;
+	lo $r60r61r62r63 = PT_Q60[$r11]
+	;;
+	lo $r56r57r58r59 = PT_Q56[$r11]
+	;;
+	lo $r52r53r54r55 = PT_Q52[$r11]
+	get $r14 = $sps
+	;;
+	lo $r48r49r50r51 = PT_Q48[$r11]
+	/* Generate a mask of ones at each bit where the current $sps
+	 * differs from the $sps to be restored
+	 */
+	xord $r14 = $r2, $r14
+	/* prepare wfxl clear mask on LSBs */
+	notd $r15 = $r2
+	/* prepare wfxl set mask on MSBs */
+	slld $r13 = $r2, 32
+	;;
+	lo $r44r45r46r47 = PT_Q44[$r11]
+	/* Replicate mask of ones on the 32 MSBs */
+	sbmm8 $r14 = $r14, REPLICATE_32_MASK
+	/* Combine the set and clear mask for wfxl */
+	insf  $r13 = $r15, 31, 0
+	;;
+	lo $r40r41r42r43 = PT_Q40[$r11]
+	set $lc = $r4
+	/* Mask to drop identical bits in order to avoid useless
+	 * privilege traps
+	 */
+	andd $r13 = $r13, $r14
+	;;
+	lq $r16r17 = PT_R16R17[$r11]
+	set $le = $r5
+	;;
+	lo $r32r33r34r35 = PT_Q32[$r11]
+	set $ls = $r6
+	;;
+	lo $r36r37r38r39 = PT_Q36[$r11]
+	copyd $r14 = $r11
+	set $ra = $r7
+	;;
+	lo $r8r9r10r11 = PT_Q8[$r14]
+	set $cs = $r0
+	/* MME was disabled by disable_mmu, reenable it before leaving */
+	ord $r13 = $r13, SFR_SET_VAL_WFXL(SPS, MME, 1)
+	;;
+	lo $r4r5r6r7 = PT_Q4[$r14]
+	set $spc = $r1
+	;;
+	lo $r0r1r2r3 = PT_Q0[$r14]
+	/* Store $sps wfxl value in scratch system register */
+	set TMP_SCRATCH_SR = $r13
+	;;
+	lo $r12r13r14r15 = PT_Q12[$r14]
+	rswap $r0 = TMP_SCRATCH_SR
+	;;
+	wfxl $sps = $r0
+	;;
+	/* Finally, restore $r0 value */
+	rswap $r0 = TMP_SCRATCH_SR
+	;;
+	rfe
+	;;
+ENDPROC(return_from_exception)
+
+/***********************************************************************
+*                      Debug handling
+***********************************************************************/
+EXCEPTION_ENTRY(kvx_debug_handler):
+	exception_entry_disable_mmu
+	;;
+	save_quad_regs $r0r1r2r3 $r4
+	;;
+	get $r2 = $sr
+	;;
+	switch_stack $r1 $r2 debug_save_regs
+	;;
+debug_save_regs:
+	save_regs_for_exception $r1 $r2 $r0r1r2r3 $r1
+	;;
+	get $r0 = $ea
+	/* tail-call for return_from_exception */
+	make $r3 = return_from_exception
+	;;
+	set $ra = $r3
+	;;
+	goto debug_handler
+	;;
+ENDPROC(kvx_debug_handler)
+
+/***********************************************************************
+*                      Traps handling
+***********************************************************************/
+/* These labels will be used for instruction patching */
+.global kvx_perf_tlb_refill, kvx_std_tlb_refill
+EXCEPTION_ENTRY(kvx_trap_handler):
+	/* Enable DAUS for physical data access */
+	exception_entry_disable_mmu
+	;;
+	/* Save r3 in a temporary system register to check if the trap is a
+	* nomapping or not */
+	set TMP_SCRATCH_SR = $r3
+	;;
+	get $r3 = $es
+	;;
+	/* Hardware trap cause  */
+	extfz $r3 = $r3, KVX_SFR_END(ES_HTC), KVX_SFR_START(ES_HTC)
+	;;
+	/* Is this a nomapping trap ? */
+	compd.eq $r3 = $r3, KVX_TRAP_NOMAPPING
+	;;
+	/* if nomapping trap, try fast_refill */
+	cb.even $r3? trap_slow_path
+	;;
+	/*
+	 * Fast TLB refill routine
+	 *
+	 * On kvx, we do not have hardware page walking, hence, TLB refill is
+	 * done using the core on no-mapping traps.
+	 * This routine must be as fast as possible to avoid wasting CPU time.
+	 * For that purpose, it is called directly from trap_handle after saving
+	 * only 8 registers ($r0 -> $r7) in a dedicated buffer.
+	 * To avoid taking nomapping while accessing page tables inside this
+	 * refill handler we switch to physical accesses using DAUS.
+	 * Once the switch is done, we save up to 8 registers to compute
+	 * the refill data.
+	 * This allows to avoid computing a complete task switching in order
+	 * to greatly reduce the refill time.
+	 *
+	 * We refill the JTLB which contains 128 sets with 4 way each.
+	 * Currently, the way selection is done using a round robin algorithm.
+	 *
+	 * The refill is using the basic flow:
+	 * 1 -	Enable physical access using DAUS.
+	 * 2 -	Save necessary registers
+	 * 3 -	Walk the page table to find the TLB entry to add (virtual to
+	 *	physical)
+	 * 4 -	Compute the TLB entry to be written (convert PTE to TLB entry)
+	 * 5 - 	Compute the target set (0 -> 127) for the new TLB entry
+	 *	This is done by extracting the 6 lsb of page number
+	 * 6 -	Get the current way to be used which is selected using a
+		simple round robin
+	 * 7 -	Mark PTE entry as _PAGE_ACCESSED (and optionally PAGE_DIRTY)
+	 * 8 -	Commit the new tlb entry
+	 * 9 -  Restore the virtual memory by disabling DAUS.
+	 *
+	 */
+	/* Get current task */
+	rswap $r63 = $sr
+	;;
+#ifdef CONFIG_KVX_MMU_STATS
+	get $r3 = $pm0
+	;;
+	sd __PA(TASK_THREAD_ENTRY_TS)[$r63] = $r3
+	;;
+#endif
+	/* Restore $r3 from temporary system scratch register */
+	get $r3 = TMP_SCRATCH_SR
+	/* Save registers to save $tel, $teh and $mmc */
+	so __PA(TASK_THREAD_SAVE_AREA_QUAD(2))[$r63] = $r8r9r10r11
+	;;
+	get $r8 = $tel
+	/* Save register for refill handler */
+	so __PA(TASK_THREAD_SAVE_AREA_QUAD(1))[$r63] = $r4r5r6r7
+	;;
+	/* Get exception address */
+	get $r0 = $ea
+	/* Save more registers to be comfy */
+	so __PA(TASK_THREAD_SAVE_AREA_QUAD(0))[$r63] = $r0r1r2r3
+	;;
+	get $r9 = $teh
+	;;
+	get $r10 = $mmc
+	;;
+	/* Restore $r63 value */
+	rswap $r63 = $sr
+	/* Check kernel address range */
+	addd $r4 = $r0, -KERNEL_DIRECT_MEMORY_MAP_BASE
+	/* Load task active mm for pgd loading in macro_tlb_refill */
+	ld $r1 = __PA(TASK_ACTIVE_MM)[$r63]
+	;;
+kvx_perf_tlb_refill:
+	/* Check if the address is in the kernel direct memory mapping */
+	compd.ltu $r3 = $r4, KERNEL_DIRECT_MEMORY_MAP_SIZE
+	/* Clear low bits of virtual address to align on page size */
+	andd $r5 = $r0, ~(REFILL_PERF_PAGE_SIZE - 1)
+	/* Create corresponding physical address */
+	addd $r2 = $r4, PHYS_OFFSET
+	;;
+	/* If address is not a kernel one, take the standard path */
+	cb.deqz $r3? kvx_std_tlb_refill
+	/* Prepare $teh value with virtual address and kernel value */
+	ord $r7 = $r5, REFILL_PERF_TEH_VAL
+	;;
+	/* Get $pm0 value as a pseudo random value for LTLB way to use */
+	get $r4 = $pm0
+	/* Clear low bits of physical address to align on page size */
+	andd $r2 = $r2, ~(REFILL_PERF_PAGE_SIZE - 1)
+	/* Prepare value for $mmc wfxl to select LTLB and correct way */
+	make $r5 = MMC_SEL_LTLB_CLEAR_WAY
+	;;
+	/* Keep low bits of timer value */
+	andw $r4 = $r4, (REFILL_PERF_ENTRIES - 1)
+	/* Get current task pointer for register restoration */
+	get $r11 = $sr
+	;;
+	/* Add LTLB base way number for kernel refill way */
+	addw $r4 = $r4, LTLB_KERNEL_RESERVED
+	/* Prepare $tel value with physical address and kernel value */
+	ord $r6 = $r2, REFILL_PERF_TEL_VAL
+	set $teh = $r7
+	;;
+	/* insert way in $mmc wfxl value */
+	insf $r5 = $r4, KVX_SFR_END(MMC_SW) + 32, KVX_SFR_START(MMC_SW) + 32
+	set $tel = $r6
+	;;
+	wfxl $mmc = $r5
+	;;
+	goto do_tlb_write
+	;;
+kvx_std_tlb_refill:
+	/* extract PGD offset */
+	extfz $r3 = $r0, (ASM_PGDIR_SHIFT + ASM_PGDIR_BITS - 1), ASM_PGDIR_SHIFT
+	/* is mm NULL ? if so, use init_mm */
+	cmoved.deqz $r1? $r1 = init_mm
+	;;
+	get $r7 = $pcr
+	/* Load pgd base address into $r1 */
+	ld $r1 = __PA(MM_PGD)[$r1]
+	;;
+	/* Add offset for physical address */
+	addd $r1 = $r1, VA_TO_PA_OFFSET
+	/* Extract processor ID to compute cpu_offset*/
+	extfz $r7 = $r7, KVX_SFR_END(PCR_PID), KVX_SFR_START(PCR_PID)
+	;;
+	/* Load PGD entry offset */
+	ld.xs $r1 = $r3[$r1]
+	/* Load per_cpu_offset */
+#if defined(CONFIG_SMP)
+	make $r5 = __PA(__per_cpu_offset)
+#endif
+	;;
+	/* extract PMD offset*/
+	extfz $r3 = $r0, (ASM_PMD_SHIFT + ASM_PMD_BITS - 1), ASM_PMD_SHIFT
+	/* If pgd entry is null -> out */
+	cb.deqz $r1? refill_err_out
+#if defined(CONFIG_SMP)
+	/* Load cpu offset */
+	ld.xs $r7 = $r7[$r5]
+#else
+	/* Force cpu offset to 0 */
+	make $r7 = 0
+#endif
+	;;
+	/* Load PMD entry offset and keep pointer to the entry for huge page */
+	addx8d $r2 = $r3, $r1
+	ld.xs $r1 = $r3[$r1]
+	;;
+	/* Check if it is a huge page (2Mb or 512Mb in PMD table)*/
+	andd $r6 = $r1, _PAGE_HUGE
+	/* If pmd entry is null -> out */
+	cb.deqz $r1? refill_err_out
+	/* extract PTE offset */
+	extfz $r3 = $r0, (PAGE_SHIFT + 8), PAGE_SHIFT
+	;;
+	/*
+	 * If the page is a huge one we already have set the PTE and the
+	 * pointer to the PTE.
+	 */
+	cb.dnez $r6? is_huge_page
+	;;
+	/* Load PTE entry */
+	ld.xs $r1 = $r3[$r1]
+	addx8d $r2 = $r3, $r1
+	;;
+	/* Check if it is a huge page (64Kb in PTE table) */
+	andd $r6 = $r1, _PAGE_HUGE
+	;;
+	/* Check if PTE entry is for a huge page */
+	cb.dnez $r6? is_huge_page
+	;;
+	/* 4K: Extract set value */
+	extfz $r0 = $r1, (PAGE_SHIFT + KVX_SFR_MMC_SS_WIDTH - 1), PAGE_SHIFT
+	/* 4K: Extract virt page from ea */
+	andd $r4 = $r0, PAGE_MASK
+	;;
+/*
+ * This path expects the following:
+ * - $r0 = set index
+ * - $r1 = pte entry
+ * - $r2 = pte entry address
+ * - $r4 = virtual page address
+ */
+pte_prepared:
+	/* Compute per_cpu_offset + current way of set address */
+	addd $r5 = $r0, $r7
+	/* Get exception cause for access type handling (page dirtying) */
+	get $r7 = $es
+	/* Clear way and select JTLB */
+	make $r6 = MMC_SEL_JTLB_CLEAR_WAY
+	;;
+	/* Load current way to use for current set */
+	lbz $r0 = __PA(jtlb_current_set_way)[$r5]
+	/* Check if the access was a "write" access */
+	andd $r7 = $r7, (KVX_TRAP_RWX_WRITE << KVX_SFR_ES_RWX_SHIFT)
+	;;
+	/* If bit PRESENT of pte entry is 0, then entry is not present */
+	cb.even $r1? refill_err_out
+	/*
+	 * Set the JTLB way in $mmc value, add 32 bits to be in the set part.
+	 * Since we are refilling JTLB, we must make sure we insert only
+	 * relevant bits (ie 2 bits for ways) to avoid using nonexistent ways.
+	 */
+	insf $r6 = $r0, KVX_SFR_START(MMC_SW) + 32 + (MMU_JTLB_WAYS_SHIFT - 1),\
+						KVX_SFR_START(MMC_SW) + 32
+	/* Extract page global bit */
+	extfz $r3 = $r1, _PAGE_GLOBAL_SHIFT, _PAGE_GLOBAL_SHIFT
+	/* Increment way value, note that we do not care about overflow since
+	 * we only use the two lower byte */
+	addd $r0 = $r0, 1
+	;;
+	/* Prepare MMC */
+	wfxl $mmc, $r6
+	;;
+	/* Insert global bit (if any) to its position into $teh value */
+	insf $r4 = $r3, KVX_SFR_TEH_G_SHIFT, KVX_SFR_TEH_G_SHIFT
+	/* If "write" access ($r7 != 0), then set it as dirty */
+	cmoved.dnez $r7? $r7 = _PAGE_DIRTY
+	/* Clear bits not related to FN in the pte entry for TEL writing */
+	andd $r6 = $r1, KVX_PFN_MASK
+	/* Store new way */
+	sb __PA(jtlb_current_set_way)[$r5] = $r0
+	;;
+	/* Extract access perms from pte entry (discard PAGE_READ bit +1) */
+	extfz $r3 = $r1, KVX_ACCESS_PERM_STOP_BIT, KVX_ACCESS_PERM_START_BIT + 1
+	/* Move FN bits to their place */
+	srld $r6 = $r6, KVX_PFN_SHIFT - PAGE_SHIFT
+	/* Extract the page size + cache policy */
+	andd $r0 = $r1, (KVX_PAGE_SZ_MASK | KVX_PAGE_CP_MASK)
+	/* Prepare SBMM value */
+	make $r5 = KVX_SBMM_BYTE_SEL
+	;;
+	/* Add page size + cache policy to $tel value */
+	ord $r6 = $r6, $r0
+	/* Get $mmc to get current ASN */
+	get $r0 = $mmc
+	/* Add _PAGE_ACCESSED bit to PTE entry for writeback */
+	ord $r7 = $r7, _PAGE_ACCESSED
+	;;
+	/* OR PTE value with accessed/dirty flags */
+	ord $r1 = $r1, $r7
+	/* Generate the byte selection for sbmm */
+	slld $r5 = $r5, $r3
+	/* Compute the mask to extract set and mask exception address */
+	make $r7 = KVX_PAGE_PA_MATRIX
+	;;
+	ord $r0 = $r6, TEL_DEFAULT_VALUE
+	/* Add ASN from mmc into future $teh value */
+	insf $r4 = $r0, KVX_SFR_END(MMC_ASN), KVX_SFR_START(MMC_ASN)
+	/* Get the page permission value */
+	sbmm8 $r6 = $r7, $r5
+	/* Check PAGE_READ bit in PTE entry */
+	andd $r3 = $r1, _PAGE_READ
+	;;
+	/* If PAGE_READ bit is not set, set policy as NA_NA */
+	cmoved.deqz $r3? $r6 = TLB_PA_NA_NA
+	;;
+	/* Shift PA to correct position */
+	slld $r6 = $r6, KVX_SFR_TEL_PA_SHIFT
+	set $teh = $r4
+	;;
+	/* Store updated pte entry */
+	sd 0[$r2] = $r1
+	/* Prepare tel */
+	ord $r6 = $r0, $r6
+	/* Get current task pointer for register restoration */
+	get $r11 = $sr
+	;;
+	set $tel = $r6
+	;;
+do_tlb_write:
+	tlbwrite
+	;;
+#ifdef CONFIG_KVX_DEBUG_TLB_WRITE
+	goto mmc_error_check
+	;;
+mmc_error_check_ok:
+#endif
+#ifdef CONFIG_KVX_DEBUG_ASN
+	goto asn_check
+	;;
+asn_check_ok:
+#endif
+	set $tel = $r8
+	/* Restore registers */
+	lo $r4r5r6r7 = __PA(TASK_THREAD_SAVE_AREA_QUAD(1))[$r11]
+	;;
+	set $teh = $r9
+	lo $r0r1r2r3 = __PA(TASK_THREAD_SAVE_AREA_QUAD(0))[$r11]
+	;;
+	set $mmc = $r10
+	;;
+	lo $r8r9r10r11 = __PA(TASK_THREAD_SAVE_AREA_QUAD(2))[$r11]
+	;;
+#ifdef CONFIG_KVX_MMU_STATS
+	/*
+	 * Fence to simulate a direct data dependency after returning from trap
+	 * nomapping handling. This is the worst case that can happen and the
+	 * processor will be stalled waiting for previous loads to complete.
+	 */
+	fence
+	;;
+	get $r4 = $pm0
+	;;
+	get $r0 = $sr
+	;;
+	/* Get cycles measured on trap entry */
+	ld $r1 = __PA(TASK_THREAD_ENTRY_TS)[$r0]
+	;;
+	/* Compute refill time */
+	sbfd $r0 = $r1, $r4
+	;;
+#ifdef CONFIG_SMP
+	get $r1 = $pcr
+	;;
+	/* Extract processor ID to compute cpu_offset */
+	extfz $r1 = $r1, KVX_SFR_END(PCR_PID), KVX_SFR_START(PCR_PID)
+	make $r2 = __PA(__per_cpu_offset)
+	;;
+	/* Load cpu offset */
+	ld.xs $r1 = $r1[$r2]
+	;;
+	addd $r1 = $r1, __PA(mmu_stats)
+	;;
+#else
+	make $r1 = __PA(mmu_stats)
+	;;
+#endif
+	/* Load time between refill + last refill cycle */
+	lq $r2r3 = MMU_STATS_CYCLES_BETWEEN_REFILL_OFF[$r1]
+	;;
+	/* Set last update time to current if 0 */
+	cmoved.deqz $r3? $r3 = $r4
+	/* remove current refill time to current cycle */
+	sbfd $r4 = $r0, $r4
+	;;
+	/* Compute time between last refill and current refill */
+	sbfd $r5 = $r3, $r4
+	/* Update last cycle time */
+	copyd $r3 = $r4
+	;;
+	/* Increment total time between refill */
+	addd $r2 = $r2, $r5
+	;;
+	sq MMU_STATS_CYCLES_BETWEEN_REFILL_OFF[$r1] = $r2r3
+	/* Get exception address */
+	get $r4 = $ea
+	;;
+	/* $r2 holds refill type (user/kernel/kernel_direct) */
+	make $r2 = MMU_STATS_REFILL_KERNEL_OFF
+	/* Check if address is a kernel direct mapping one */
+	compd.ltu $r3 = $r4, (KERNEL_DIRECT_MEMORY_MAP_BASE + \
+			      KERNEL_DIRECT_MEMORY_MAP_SIZE)
+	;;
+	cmoved.dnez $r3? $r2 = MMU_STATS_REFILL_KERNEL_DIRECT_OFF
+	/* Check if address is a user (ie below kernel) */
+	compd.ltu $r3 = $r4, KERNEL_DIRECT_MEMORY_MAP_BASE
+	;;
+	cmoved.dnez $r3? $r2 = MMU_STATS_REFILL_USER_OFF
+	;;
+	/* Compute refill struct addr into one reg */
+	addd $r1 = $r2, $r1
+	/* Load refill_struct values */
+	lo $r4r5r6r7 = $r2[$r1]
+	;;
+	/* Increment count */
+	addd $r4 = $r4, 1
+	/* Increment total cycles count */
+	addd $r5 = $r5, $r0
+	;;
+	/* Set min to ~0 if 0 */
+	cmoved.deqz $r6? $r6 = ~0
+	;;
+	/* Compare min and max */
+	compd.ltu $r2 = $r0, $r6
+	compd.gtu $r3 = $r0, $r7
+	;;
+	/* Update min and max*/
+	cmoved.dnez $r2? $r6 = $r0
+	cmoved.dnez $r3? $r7 = $r0
+	;;
+	/* store back all values */
+	so 0[$r1] = $r4r5r6r7
+	;;
+	get $r0 = $sr
+	;;
+	/* Restore clobberred registers */
+	lo $r4r5r6r7 = __PA(TASK_THREAD_SAVE_AREA_QUAD(1))[$r0]
+	;;
+	lo $r0r1r2r3 = __PA(TASK_THREAD_SAVE_AREA_QUAD(0))[$r0]
+	;;
+#endif
+	/* Save $r4 for reenabling mmu and data cache in sps */
+	set TMP_SCRATCH_SR = $r4
+	/* Enable MME in $sps */
+	make $r4 = MME_WFXL(1)
+	;;
+	/* Reenable $mme in $sps */
+	wfxl $sps = $r4
+	;;
+	get $r4 = TMP_SCRATCH_SR
+	;;
+	rfe
+	;;
+
+is_huge_page:
+	/*
+	 * When entering this path:
+	 * - $r0 = $ea
+	 * - $r1 = pte entry
+	 * - $r7 = cpu offset for tlb_current_set_way
+	 *
+	 * From now on, we have the pte value in $r1 so we can extract the page
+	 * size. This value is stored as it is expected by the MMU (ie between
+	 * 0 and 3).
+	 * Note that page size value is located at the same place as in $tel
+	 * and this is checked at build time so we can use TEL_PS defines.
+	 * In this codepath, we will extract the set and mask exception address
+	 * and align virt and phys address with what the hardware expect.
+	 * Indeed, MMU expect lsb of the virtual and physycal address to be 0
+	 * according to page size.
+	 * This means that for 4K pages, the 12 lsb must be 0, for 64K
+	 * pages, the 16 lsb must be 0 and so on.
+	 */
+	extfz $r5 = $r1, KVX_SFR_END(TEL_PS), KVX_SFR_START(TEL_PS)
+	/* Compute the mask to extract set and mask exception address */
+	make $r4 = KVX_PS_SHIFT_MATRIX
+	make $r6 = KVX_SBMM_BYTE_SEL
+	;;
+	/* Generate the byte selection for sbmm */
+	slld $r6 = $r6, $r5
+	;;
+	/* Get the shift value */
+	sbmm8 $r5 = $r4, $r6
+	make $r4 = 0xFFFFFFFFFFFFFFFF
+	;;
+	/* extract TLB set from ea (6 lsb of virtual page) */
+	srld $r5 = $r0, $r5
+	/* Generate ea masking according to page shift */
+	slld $r4 = $r4, $r5
+	;;
+	/* Mask to get the set value */
+	andd $r0 = $r5, MMU_SET_MASK
+	/* Extract virt page from ea */
+	andd $r4 = $r0, $r4
+	;;
+	/* Returned to fast path */
+	goto pte_prepared
+	;;
+
+#ifdef CONFIG_KVX_DEBUG_TLB_WRITE
+mmc_error_check:
+	get $r1 = $mmc
+	;;
+	andd $r1 = $r1, KVX_SFR_MMC_E_MASK
+	;;
+	cb.deqz $r1? mmc_error_check_ok
+	;;
+	make $r0 = mmc_error_panic_str_label
+	goto asm_panic
+	;;
+#endif
+#ifdef CONFIG_KVX_DEBUG_ASN
+/*
+ * When entering this path $r11 = $sr.
+ * WARNING: Do not clobber it here if you don't want to mess up with registers
+ * restoration above.
+ */
+asn_check:
+	get $r1 = $ea
+	;;
+	/* Check if kernel address, if so, there is no ASN */
+	compd.geu $r2 = $r1, PAGE_OFFSET
+	;;
+	cb.dnez $r2? asn_check_ok
+	;;
+	get $r2 = $pcr
+	/* Load active mm addr */
+	ld $r3 = __PA(TASK_ACTIVE_MM)[$r11]
+	;;
+	get $r5 = $mmc
+	/* Extract processor ID to compute cpu_offset*/
+	extfz $r2 = $r2, KVX_SFR_END(PCR_PID), KVX_SFR_START(PCR_PID)
+	addd $r3 = $r3, MM_CTXT_ASN
+	;;
+	extfz $r4 = $r5, KVX_SFR_END(MMC_ASN), KVX_SFR_START(MMC_ASN)
+	addd $r3 = $r3, VA_TO_PA_OFFSET
+	;;
+	/* Load current asn from active_mm */
+	ld.xs $r3 = $r2[$r3]
+	;;
+	/* Error if ASN is not set */
+	cb.deqz $r3? asn_check_err
+	/* Mask $r3 asn cycle part */
+	andd $r5 = $r3, ((1 << KVX_SFR_MMC_ASN_WIDTH) - 1)
+	;;
+	/* Compare asn in $mmc and asn in current task mm */
+	compd.eq $r3 = $r5, $r4
+	;;
+	cb.dnez $r3? asn_check_ok
+	;;
+asn_check_err:
+	/* We are fried, die peacefully */
+	make $r0 = asn_error_panic_str_label
+	goto asm_panic
+	;;
+#endif
+
+#if defined(CONFIG_KVX_DEBUG_ASN) || defined(CONFIG_KVX_DEBUG_TLB_WRITE)
+
+/**
+ * This routine calls panic from assembly after setting appropriate things
+ * $r0 = panic string
+ */
+asm_panic:
+	/*
+	 * Reenable hardware loop and traps (for nomapping) since some functions
+	 * might need it. Moreover, disable DAUS to reenable MMU accesses.
+	 */
+	make $r32 = PS_HWLOOP_EN_ET_CLEAR_DAUS_DIS
+	make $r33 = 0
+	get $r34 = $sr
+	;;
+	/* Clear hw loop exit to disable current loop */
+	set $le = $r33
+	;;
+	wfxl $ps = $r32
+	;;
+	/* Restore kernel stack */
+	ld $r12 = TASK_THREAD_KERNEL_SP[$r34]
+	;;
+	call panic
+	;;
+#endif
+
+/* Error path for TLB refill */
+refill_err_out:
+	get $r2 = $sr
+	;;
+	/* Restore clobbered registers */
+	lo $r8r9r10r11 = __PA(TASK_THREAD_SAVE_AREA_QUAD(2))[$r2]
+	;;
+	lo $r4r5r6r7 = __PA(TASK_THREAD_SAVE_AREA_QUAD(1))[$r2]
+	goto trap_switch_stack
+	;;
+
+/* This path is entered only when the trap is NOT a NOMAPPING */
+trap_slow_path:
+	/* Restore $r3 from temporary scratch system register */
+	get $r3 = TMP_SCRATCH_SR
+	;;
+	save_quad_regs $r0r1r2r3 $r4
+	;;
+	get $r2 = $sr
+	;;
+trap_switch_stack:
+	switch_stack $r1 $r2 trap_save_regs
+	;;
+trap_save_regs:
+	save_regs_for_exception $r1 $r2 $r0r1r2r3 $r2
+	;;
+	get $r1 = $ea
+	/* tail-call for return_from_exception */
+	make $r3 = return_from_exception
+	;;
+	set $ra = $r3
+	;;
+	/* Handler call */
+	get $r0 = $es
+	;;
+	goto trap_handler
+	;;
+ENDPROC(kvx_trap_handler)
+
+/***********************************************************************
+*                      Interrupts handling
+***********************************************************************/
+EXCEPTION_ENTRY(kvx_interrupt_handler):
+	exception_entry_disable_mmu
+	;;
+	save_quad_regs $r0r1r2r3 $r4
+	;;
+	get $r0 = $sr
+	;;
+	switch_stack $r1 $r0 it_save_regs
+	;;
+#ifdef CONFIG_SECURE_DAME_HANDLING
+	/**
+	 * In order to securely Handle Data Asynchronous Memory Error,
+	 * we need to have a correct entry point. This means we do not
+	 * want to handle a user induced DAME interrupt when entering
+	 * kernel.
+	 * In order to do that, we need to do a barrier, which will
+	 * reflect the DAME status in $ilr (if any).
+	 */
+	barrier
+	;;
+#endif
+it_save_regs:
+	save_regs_for_exception $r1 $r0 $r0r1r2r3 $r1
+	;;
+	get $r0 = $ilr
+	;;
+	get $r2 = $ile
+	;;
+	/**
+	 * When an interrupt happens, the processor automatically clears the
+	 * corresponding bit in $ilr. However, as we are using $ilr to get the
+	 * list of irqs we want to handle, we need to add the automatically
+	 * cleared interrupt bit. This is done by getting the interrupt number
+	 * from $es.
+	 */
+	get $r3 = $es
+	make $r4 = 1
+	;;
+	/* Extract interrupt number from $es */
+	extfz $r3 = $r3, KVX_SFR_END(ES_ITN), KVX_SFR_START(ES_ITN)
+	/**
+	 * Mask requests with enabled line since ILR will also contain disabled
+	 * interrupt lines (ie not enabled in $ile) and we want to respect the
+	 * current state of interrupt lines.
+	 */
+	andd $r0 = $r0, $r2
+	;;
+	/* Clear $ilr with bits we are going to handle */
+	wfxl $ilr = $r0
+	slld $r4 = $r4, $r3
+	;;
+	/* OR the irq mask with the current pending irq */
+	ord $r0 = $r0, $r4
+	call do_IRQ
+	;;
+	/* From now on, lower the interrupt level (IL) to allow IT nesting.
+	 * If returning to user, we will call schedule which will reenable
+	 * interrupts by itself when ready.
+	 * If returning to kernel and with CONFIG_PREEMPT, we will call
+	 * preempt_schedule_irq which will do the same.
+	 */
+	make $r0 = PS_IL_CLEAR
+	;;
+	wfxl $ps = $r0
+	;;
+	goto return_from_exception
+	;;
+ENDPROC(kvx_interrupt_handler)
+
+/***********************************************************************
+*                      Syscall handling
+***********************************************************************/
+EXCEPTION_ENTRY(kvx_syscall_handler):
+	/**
+	 * Syscalls are seen as standard func call from ABI POV
+	 * We may use all caller saved register whithout causing havoc
+	 * in the userspace. We need to save callee registers because they
+	 * will be restored when returning from fork.
+	 * Note that r0 -> r11 MUST not be used since they are
+	 * containing syscall parameters !
+	 * During this function, $r38 is the syscall handler address. Hence,
+	 * this register must not be clobberred during function calls (tracing
+	 * for instance.
+	 */
+	disable_mmu $r43
+	;;
+	get $r43 = $es
+	copyd $r52 = $sp
+	copyd $r53 = $tp
+	;;
+	get $r36 = $sr
+	copyd $r54 = $fp
+	copyd $r55 = $r15
+	;;
+	/* Extract syscall number */
+	extfz $r32 = $r43, KVX_SFR_END(ES_SN), KVX_SFR_START(ES_SN)
+	/* Get regs to save on stack */
+	get $r63 = $ra
+	addd $r36 = $r36, VA_TO_PA_OFFSET
+	;;
+	ld $r39 = TASK_TI_FLAGS[$r36]
+	get $r41 = $spc
+	make $r42 = __PA(sys_call_table)
+	;;
+	/* Check for out-of-bound syscall number */
+	sbfd $r50 = $r32, __NR_syscalls
+	/* Compute syscall func addr (ie sys_call_table[$r32])*/
+	ld.xs $r38 = $r32[$r42]
+	get $r42 = $sps
+	;;
+	/* True if trace syscall enable */
+	andd $r37 = $r39, _TIF_SYSCALL_WORK
+	/* Restore kernel stack pointer */
+	ld $sp = TASK_THREAD_KERNEL_SP[$r36]
+	/* If the syscall number is invalid, set invalid handler */
+	cmoved.dlez $r50? $r38 = sys_ni_syscall
+	;;
+	/* Prepare space on stack */
+	addd $sp = $sp, -PT_SIZE_ON_STACK
+	get $r40 = $cs
+	/* Save regs r0 -> r3 in pt_regs for restart & trace if needed */
+	so __PA(PT_Q0 - PT_SIZE_ON_STACK)[$sp] = $r0r1r2r3
+	;;
+	/* Store user stack pointer, frame pointer, thread pointer and r15 */
+	so __PA(PT_Q12)[$sp] = $r52r53r54r55
+	addd $r36 = $sp, VA_TO_PA_OFFSET
+	get $r60 = $lc
+	;;
+#ifdef CONFIG_SECURE_DAME_HANDLING
+	get $r44 = $ilr
+	make $r45 = SFR_CLEAR_WFXL(ILR, IT16);
+	;;
+	/* Extract $ilr.dame bit */
+	extfz $r44 = $r44, KVX_SFR_END(ILR_IT16), KVX_SFR_START(ILR_IT16)
+	/* Save $ilr value */
+	sd PT_ILR[$r36] = $r44
+	/* Clear $ilr.dame */
+	wfxl $ilr = $r45
+	;;
+#endif
+	so PT_CS_SPC_SPS_ES[$r36] = $r40r41r42r43
+	get $r61 = $le
+	make $r43 = 0x0
+	;;
+	/* Reenable hardware loops, IT, exceptions and disable DAUS */
+	make $r44 = PS_HLE_EN_IT_EN_ET_CLEAR_DAUS_DIS
+	get $r62 = $ls
+	/* Save regs r4 -> r7 in pt_regs for restart & trace if needed */
+	so PT_Q4[$r36] = $r4r5r6r7
+	;;
+	/* Clear $le on entry */
+	set $le = $r43
+	/* Save hw loop stuff */
+	so PT_LC_LE_LS_RA[$r36] = $r60r61r62r63
+	/* Clear frame pointer for kernel */
+	make $fp = 0
+	;;
+	/* Enable hwloop and interrupts and MMU
+	 * Note that we have to reenable interrupts after saving context
+	 * to avoid losing registers content */
+	wfxl $ps, $r44
+	;;
+	/* Do we have to trace the syscall ? */
+	cb.dnez $r37? trace_syscall_enter
+	/* Stroe original r0 value */
+	sd PT_ORIG_R0[$sp] = $r0
+	;;
+do_syscall:
+	/* Call the syscall handler */
+	icall $r38
+	;;
+	/*
+	 * rt_sigreturn syscall will not take this exit path (see
+	 * sys_rt_sigreturn for more information).
+	 */
+	/* Reload task flags since the syscall might have generated a signal*/
+	get $r36 = $sr
+	;;
+#ifdef CONFIG_SECURE_DAME_HANDLING
+	/* Barrier to force DAME interrupt to be generated if any pending */
+	barrier
+	;;
+#endif
+	/* Disable interrupt to check task flags atomically */
+	disable_interrupt $r60
+	;;
+	ld $r38 = TASK_TI_FLAGS[$r36]
+	;;
+	andd $r37 = $r38, _TIF_SYSCALL_WORK
+	;;
+	/* Save r0 which was returned from do_scall previously and will be
+	 * clobberred by do_work_pending (and potentially do_syscall_trace_exit
+	 * if tracing is enabled)
+	 * If do_signal is called and that syscall is restarted,
+	 * it will be modified by handle_restart to restore original
+	 * r0 value
+	 */
+	sd PT_Q0[$sp] = $r0
+	/* used to store if trace system */
+	cb.dnez $r37? trace_syscall_exit
+	;;
+check_work_pending:
+	/* Do we have work pending ? */
+	andd $r1 = $r38, _TIF_WORK_MASK
+	;;
+	/* If no work pending, directly continue to ret_to_user */
+	cb.dnez $r1? call_work_pending
+	;;
+ret_to_user:
+	disable_mmu $r60, PS_HWLOOP_DISABLE
+	;;
+	/* Compute $sp virtual address to avoid using 64 bits offset */
+	addd $r15 = $sp, VA_TO_PA_OFFSET
+	;;
+	/* Restore registers */
+	lo $r60r61r62r63 = PT_LC_LE_LS_RA[$r15]
+	get $r33 = $sps
+	;;
+	lo $r40r41r42r43 = PT_CS_SPC_SPS_ES[$r15];
+	set $ra = $r63
+	;;
+	/* Restore syscall arguments since they might be needed for
+	 * syscall restart
+	 */
+	lo $r0r1r2r3 = PT_Q0[$r15]
+	set $cs = $r40
+	/* Generate a mask of ones at each bit where the current $sps
+	 * differs from the $sps to be restored
+	 */
+	xord $r33 = $r42, $r33
+	/* prepare wfxl clear mask on LSBs */
+	notd $r34 = $r42
+	/* prepare wfxl set mask on MSBs */
+	slld $r35 = $r42, 32
+	;;
+	set $lc = $r60
+	/* Replicate mask of ones on the 32 MSBs */
+	sbmm8 $r33 = $r33, REPLICATE_32_MASK
+	/* Combine the set and clear mask for wfxl */
+	insf  $r35 = $r34, 31, 0
+	;;
+	lo $r4r5r6r7 = PT_Q4[$r15]
+	set $le = $r61
+	/* Mask to drop identical bits in order to avoid useless
+	 * privilege traps
+	 */
+	andd $r35 = $r35, $r33
+	;;
+	/* Restore $ilr */
+	ld $r44 = PT_ILR[$r15]
+	set $ls = $r62
+	/* Reenable MMU in $sps */
+	ord $r35 = $r35, SFR_SET_VAL_WFXL(SPS, MME, 1)
+	;;
+	/* Restore user pointer */
+	lo $r12r13r14r15 = PT_Q12[$r15]
+	/* Prepare $r44 as a set mask for $ilr wfxl */
+	slld $r44 = $r44,  32
+	;;
+	/**
+	 * wfxl on $ilr to avoid privilege traps when restoring with set
+	 * Note that we do that after disabling interrupt since we explicitly
+	 * want to serve DAME itnerrupt to the user (ie not in kernel mode).
+	 */
+	wfxl $ilr = $r44
+	;;
+	wfxl $sps = $r35
+	;;
+	set $spc = $r41
+	;;
+	/* TODO: we might have to clear some registers to avoid leaking
+	 * information to user space ! callee saved regs have been
+	 * restored by called function but caller saved regs might
+	 * have been used without being cleared */
+	rfe
+	;;
+
+/* Slow paths handling */
+call_work_pending:
+	/*
+	 * Work pending can potentially call a signal handler and then return
+	 * via rt_sigreturn. Return path will be different (restore all regs)
+	 * and hence all registers are needed to be saved.
+	 */
+	save_callee
+	;;
+	call_do_work_pending
+	;;
+	/* Since we are returning to user, interrupts will be reenabled */
+	call_trace_hardirqs on
+	;;
+	goto ret_to_user
+	;;
+
+trace_syscall_enter:
+	/* Save $r38 (syscall handler) which was computed above */
+	sd PT_R38[$sp] = $r38
+	;;
+	/* do_syscall_trace_enter expect pt_regs and syscall number
+	 * as argument */
+	copyd $r0 = $sp
+	copyd $r1 = $r32
+	;;
+	call do_syscall_trace_enter
+	;;
+	/* Restore r38 (syscall handler) which might has been clobbered by
+	 * do_syscall_trace_enter */
+	ld $r38 = PT_R38[$sp]
+	;;
+	/* if the trace system requested to abort syscall, set $r38 to
+	 * non implemented syscall */
+	cmoved.dnez $r0? $r38 = sys_ni_syscall
+	;;
+	/* Restore registers since the do_syscall_trace_enter call might
+	 * have clobbered them and we need them for the actual syscall
+	 * call */
+	lo $r0r1r2r3 = PT_Q0[$sp]
+	;;
+	lo $r4r5r6r7 = PT_Q4[$sp]
+	;;
+	goto do_syscall
+	;;
+trace_syscall_exit:
+	copyd $r0 = $sp
+	call do_syscall_trace_exit
+	;;
+	/* ptrace_notify might re-enable interrupts, disable them to be sure
+	 * it will not mess up context restoration path */
+	disable_interrupt $r36
+	;;
+	get $r36 = $sr
+	;;
+	ld $r38 = TASK_TI_FLAGS[$r36]
+	goto check_work_pending
+	;;
+ENDPROC(kvx_syscall_handler)
+
+.text
+/**
+ * sys_rt_sigreturn: Special handler for sigreturn
+ * rt_sigreturn is called after invoking a user signal handler (see
+ * user_scall_rt_sigreturn). Since this signal handler can be invoked after
+ * interrupts have been handled, this means we must restore absolutely all user
+ * registers. Normally, this has been done by setup_sigcontext which saved all
+ * user registers on the user stack.
+ * In restore sigcontext, they have been restored onto entry stack (stack to be
+ * restored). However, the standard syscall path do not restore it completely
+ * since only callee-saved registers are restored for fork and al.
+ * Here, we will restore all registers which might have been clobberred.
+ */
+ENTRY(sys_rt_sigreturn)
+	/*
+	 * If syscall tracing is enable (stored in $r37 during syscall
+	 * fastpath), tail-call to trace_exit. If not, tail-call to
+	 * ret_from_kernel.
+	 */
+	cmoved.dnez $r37? $r38 = scall_trace_exit
+	cmoved.deqz $r37? $r38 = ret_from_kernel
+	;;
+	set $ra = $r38
+	;;
+	goto _sys_rt_sigreturn
+	;;
+scall_trace_exit:
+	copyd $r0 = $sp
+	call do_syscall_trace_exit
+	;;
+	goto ret_from_kernel
+	;;
+ENDPROC(sys_rt_sigreturn)
+
+/**
+ * __sys_clone: slow path handler for clone
+ *
+ * Save callee registers (from $r18 to $31) since they are needed for
+ * child process when restoring it.
+ * Indeed, when forking we want it to have the same registers contents
+ * as its parent. These registers will then be restored in
+ * ret_from_fork.
+ * This slow path saves them out of the fast path to avoid bloating all syscall
+ * just for one special case.
+ */
+ENTRY(__sys_clone)
+	save_callee
+	;;
+	/*
+	 * Use goto since we want sys_clone to "ret" to the previous caller.
+	 * This allows to simply go back in the normal syscall fastpath
+	 */
+	goto sys_clone
+	;;
+ENDPROC(__sys_clone)
+/***********************************************************************
+*                      Context switch
+***********************************************************************/
+
+#define SAVE_TCA_REG(__reg_num, __task_reg, __zero_reg1, __zero_reg2) \
+	xso (CTX_SWITCH_TCA_REGS + (__reg_num * TCA_REG_SIZE))[__task_reg] = \
+							$a##__reg_num ;\
+	movetq $a##__reg_num##.lo = __zero_reg1, __zero_reg2 ;\
+	movetq $a##__reg_num##.hi = __zero_reg1, __zero_reg2 ;\
+	;;
+
+.macro save_tca_regs task_reg zero_reg1 zero_reg2
+	SAVE_TCA_REG(0, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(1, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(2, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(3, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(4, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(5, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(6, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(7, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(8, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(9, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(10, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(11, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(12, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(13, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(14, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(15, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(16, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(17, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(18, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(19, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(20, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(21, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(22, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(23, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(24, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(25, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(26, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(27, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(28, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(29, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(30, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(31, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(32, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(33, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(34, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(35, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(36, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(37, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(38, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(39, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(40, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(41, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(42, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(43, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(44, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(45, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(46, \task_reg, \zero_reg1, \zero_reg2)
+	SAVE_TCA_REG(47, \task_reg, \zero_reg1, \zero_reg2)
+.endm
+
+#define RESTORE_TCA_REG(__reg_num, __task_reg) \
+	xlo.u $a##__reg_num = (CTX_SWITCH_TCA_REGS + (__reg_num * TCA_REG_SIZE)) \
+								[__task_reg] ;\
+	;;
+
+.macro restore_tca_regs task_reg
+	RESTORE_TCA_REG(0, \task_reg)
+	RESTORE_TCA_REG(1, \task_reg)
+	RESTORE_TCA_REG(2, \task_reg)
+	RESTORE_TCA_REG(3, \task_reg)
+	RESTORE_TCA_REG(4, \task_reg)
+	RESTORE_TCA_REG(5, \task_reg)
+	RESTORE_TCA_REG(6, \task_reg)
+	RESTORE_TCA_REG(7, \task_reg)
+	RESTORE_TCA_REG(8, \task_reg)
+	RESTORE_TCA_REG(9, \task_reg)
+	RESTORE_TCA_REG(10, \task_reg)
+	RESTORE_TCA_REG(11, \task_reg)
+	RESTORE_TCA_REG(12, \task_reg)
+	RESTORE_TCA_REG(13, \task_reg)
+	RESTORE_TCA_REG(14, \task_reg)
+	RESTORE_TCA_REG(15, \task_reg)
+	RESTORE_TCA_REG(16, \task_reg)
+	RESTORE_TCA_REG(17, \task_reg)
+	RESTORE_TCA_REG(18, \task_reg)
+	RESTORE_TCA_REG(19, \task_reg)
+	RESTORE_TCA_REG(20, \task_reg)
+	RESTORE_TCA_REG(21, \task_reg)
+	RESTORE_TCA_REG(22, \task_reg)
+	RESTORE_TCA_REG(23, \task_reg)
+	RESTORE_TCA_REG(24, \task_reg)
+	RESTORE_TCA_REG(25, \task_reg)
+	RESTORE_TCA_REG(26, \task_reg)
+	RESTORE_TCA_REG(27, \task_reg)
+	RESTORE_TCA_REG(28, \task_reg)
+	RESTORE_TCA_REG(29, \task_reg)
+	RESTORE_TCA_REG(30, \task_reg)
+	RESTORE_TCA_REG(31, \task_reg)
+	RESTORE_TCA_REG(32, \task_reg)
+	RESTORE_TCA_REG(33, \task_reg)
+	RESTORE_TCA_REG(34, \task_reg)
+	RESTORE_TCA_REG(35, \task_reg)
+	RESTORE_TCA_REG(36, \task_reg)
+	RESTORE_TCA_REG(37, \task_reg)
+	RESTORE_TCA_REG(38, \task_reg)
+	RESTORE_TCA_REG(39, \task_reg)
+	RESTORE_TCA_REG(40, \task_reg)
+	RESTORE_TCA_REG(41, \task_reg)
+	RESTORE_TCA_REG(42, \task_reg)
+	RESTORE_TCA_REG(43, \task_reg)
+	RESTORE_TCA_REG(44, \task_reg)
+	RESTORE_TCA_REG(45, \task_reg)
+	RESTORE_TCA_REG(46, \task_reg)
+	RESTORE_TCA_REG(47, \task_reg)
+.endm
+
+.text
+/*
+ * When entering in ret_from_kernel_thread, r20 and r21 where set by
+ * copy_thread and have been restored in switch_to.
+ * These registers contains the values needed to call a function
+ * specified by the switch_to caller (or where set by copy_thread).
+ */
+ENTRY(ret_from_kernel_thread)
+	call schedule_tail
+	;;
+	/* Call fn(arg) */
+	copyd $r0 = $r21
+	;;
+	icall $r20
+	;;
+	goto ret_from_kernel
+	;;
+ENDPROC(ret_from_kernel_thread)
+
+/**
+ * Return from fork.
+ * start_thread will set return stack and pc. Then copy_thread will
+ * take care of the copying logic.
+ * $r20 will then contains 0 if tracing disabled (set by copy_thread)
+ * The mechanism is almost the same as for ret_from_kernel_thread.
+ */
+ENTRY(ret_from_fork)
+	call schedule_tail
+	;;
+	/* $r20 contains 0 if tracing disable */
+	cb.deqz $r20? ret_from_kernel
+	;;
+	copyd $r0 = $sp
+	call do_syscall_trace_exit
+	;;
+ret_from_kernel:
+	/*
+	 * When returning from a fork, the child will take this path.
+	 * Since we did not restore callee in return_from_exception, we
+	 * must do it before.
+	 */
+	lo $r28r29r30r31 = PT_Q28[$sp]
+	;;
+	lo $r24r25r26r27 = PT_Q24[$sp]
+	;;
+	lo $r20r21r22r23 = PT_Q20[$sp]
+	;;
+	lq $r18r19 = PT_R18R19[$sp]
+	;;
+#ifdef CONFIG_DEBUG_EXCEPTION_STACK
+	/**
+	* Debug code expect entry stack to be stored at current $sp.
+	* Make some room and store current $sp to avoid triggering false alarm.
+	*/
+	addd $sp = $sp, -STACK_REG_SIZE
+	;;
+	sd 0[$sp] = $sp
+#endif
+	;;
+	goto return_from_exception
+	;;
+ENDPROC(ret_from_fork)
+
+/*
+ * The callee-saved registers must be saved and restored.
+ * When entering:
+ * - r0 = previous task struct
+ * - r1 = next task struct
+ * Moreover, the parameters for function call (given by copy_thread)
+ * are stored in:
+ * - r20 = Func to call
+ * - r21 = Argument for function
+ */
+ENTRY(__switch_to)
+	sd CTX_SWITCH_FP[$r0] = $fp
+	;;
+	/* Save previous task context */
+	so CTX_SWITCH_Q20[$r0] = $r20r21r22r23
+	;;
+	so CTX_SWITCH_Q24[$r0] = $r24r25r26r27
+	get $r16 = $ra
+	;;
+	so CTX_SWITCH_Q28[$r0] = $r28r29r30r31
+	copyd $r17 = $sp
+	get $r2 = $cs
+	;;
+	so CTX_SWITCH_RA_SP_R18_R19[$r0] = $r16r17r18r19
+	/* Extract XMF bit which means coprocessor was used by user */
+	andd $r3 = $r2, KVX_SFR_CS_XMF_MASK
+	;;
+#ifdef CONFIG_ENABLE_TCA
+	make $r4 = 0
+	make $r5 = 0
+	make $r6 = 1
+	cb.dnez $r3? save_tca_registers
+	/* Check if next task needs TCA registers to be restored */
+	ld $r7 = CTX_SWITCH_TCA_REGS_SAVED[$r1]
+	;;
+check_restore_tca:
+	cb.dnez $r7? restore_tca_registers
+	;;
+restore_fast_path:
+#endif
+	/* Restore next task context */
+	lo $r16r17r18r19 = CTX_SWITCH_RA_SP_R18_R19[$r1]
+	;;
+	lo $r20r21r22r23 = CTX_SWITCH_Q20[$r1]
+	;;
+	lo $r24r25r26r27 = CTX_SWITCH_Q24[$r1]
+	copyd $sp = $r17
+	set $ra = $r16
+	;;
+	lo $r28r29r30r31 = CTX_SWITCH_Q28[$r1]
+	set $sr = $r1
+	;;
+	ld $fp = CTX_SWITCH_FP[$r1]
+	;;
+	ret
+	;;
+#ifdef CONFIG_ENABLE_TCA
+save_tca_registers:
+	save_tca_regs $r0 $r4 $r5
+	;;
+	/* Indicates that we saved the TCA context */
+	sb CTX_SWITCH_TCA_REGS_SAVED[$r0] = $r6
+	goto check_restore_tca
+	;;
+restore_tca_registers:
+	restore_tca_regs $r1
+	;;
+	/* Clear TCA registers saved hint */
+	sb CTX_SWITCH_TCA_REGS_SAVED[$r1] = $r5
+	goto restore_fast_path
+	;;
+#endif
+ENDPROC(__switch_to)
+
+/***********************************************************************
+*          		 Misc functions
+***********************************************************************/
+
+/**
+ * Avoid hardcoding trampoline for rt_sigreturn by using this code and
+ * copying it on user trampoline
+ */
+.pushsection .text
+.global user_scall_rt_sigreturn_end
+ENTRY(user_scall_rt_sigreturn)
+	make $r6 = __NR_rt_sigreturn
+	;;
+	scall $r6
+	;;
+user_scall_rt_sigreturn_end:
+ENDPROC(user_scall_rt_sigreturn)
+.popsection
diff --git a/arch/kvx/kernel/sys_kvx.c b/arch/kvx/kernel/sys_kvx.c
new file mode 100644
index 000000000000..b32a821d76c9
--- /dev/null
+++ b/arch/kvx/kernel/sys_kvx.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/syscalls.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cachectl.h>
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+	unsigned long, prot, unsigned long, flags,
+	unsigned long, fd, off_t, off)
+{
+	/* offset must be a multiple of the page size */
+	if (unlikely(offset_in_page(off) != 0))
+		return -EINVAL;
+
+	/* Unlike mmap2 where the offset is in PAGE_SIZE-byte units, here it
+	 * is in bytes. So we need to use PAGE_SHIFT.
+	 */
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
+
+SYSCALL_DEFINE4(cachectl, unsigned long, addr, unsigned long, len,
+		unsigned long, cache, unsigned long, flags)
+{
+	bool wb = !!(flags & CACHECTL_FLAG_OP_WB);
+	bool inval = !!(flags & CACHECTL_FLAG_OP_INVAL);
+
+	if (len == 0)
+		return 0;
+
+	/* Check for overflow */
+	if (addr + len < addr)
+		return -EFAULT;
+
+	if (cache != CACHECTL_CACHE_DCACHE)
+		return -EINVAL;
+
+	if ((flags & CACHECTL_FLAG_OP_MASK) == 0)
+		return -EINVAL;
+
+	if (flags & CACHECTL_FLAG_ADDR_PHYS) {
+		if (!IS_ENABLED(CONFIG_CACHECTL_UNSAFE_PHYS_OPERATIONS))
+			return -EINVAL;
+
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		dcache_wb_inval_phys_range(addr, len, wb, inval);
+		return 0;
+	}
+
+	return dcache_wb_inval_virt_range(addr, len, wb, inval);
+}
diff --git a/arch/kvx/kernel/syscall_table.c b/arch/kvx/kernel/syscall_table.c
new file mode 100644
index 000000000000..7859d25e728d
--- /dev/null
+++ b/arch/kvx/kernel/syscall_table.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/riscv/kernel/syscall_table.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/syscalls.h>
+
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)	[nr] = (call),
+
+void *sys_call_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.37.2






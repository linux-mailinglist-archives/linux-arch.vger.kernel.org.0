Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF32E3FFDB7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 12:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348959AbhICKBE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 06:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232273AbhICKBE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 06:01:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C51861057;
        Fri,  3 Sep 2021 10:00:00 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 13/22] LoongArch: Add system call support
Date:   Fri,  3 Sep 2021 17:52:04 +0800
Message-Id: <20210903095213.797973-14-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds system call support and related code (uaccess and
seccomp) for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/syscall.h     |  74 +++++
 arch/loongarch/include/asm/uaccess.h     | 327 +++++++++++++++++++++++
 arch/loongarch/include/asm/unistd.h      |  11 +
 arch/loongarch/include/uapi/asm/unistd.h |   6 +
 arch/loongarch/kernel/entry.S            |  86 ++++++
 arch/loongarch/kernel/syscall.c          |  80 ++++++
 6 files changed, 584 insertions(+)
 create mode 100644 arch/loongarch/include/asm/syscall.h
 create mode 100644 arch/loongarch/include/asm/uaccess.h
 create mode 100644 arch/loongarch/include/asm/unistd.h
 create mode 100644 arch/loongarch/include/uapi/asm/unistd.h
 create mode 100644 arch/loongarch/kernel/entry.S
 create mode 100644 arch/loongarch/kernel/syscall.c

diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
new file mode 100644
index 000000000000..da0cd5a02dad
--- /dev/null
+++ b/arch/loongarch/include/asm/syscall.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_LOONGARCH_SYSCALL_H
+#define __ASM_LOONGARCH_SYSCALL_H
+
+#include <linux/compiler.h>
+#include <uapi/linux/audit.h>
+#include <linux/elf-em.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+
+extern void *sys_call_table[];
+
+static inline long syscall_get_nr(struct task_struct *task,
+				  struct pt_regs *regs)
+{
+	return regs->regs[11];
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+				    struct pt_regs *regs)
+{
+        regs->regs[4] = regs->orig_a0;
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	unsigned long error = regs->regs[4];
+
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->regs[4];
+}
+
+static inline void syscall_set_return_value(struct task_struct *task,
+					    struct pt_regs *regs,
+					    int error, long val)
+{
+	regs->regs[4] = (long) error ? error : val;
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned long *args)
+{
+	args[0] = regs->orig_a0;
+	memcpy(&args[1], &regs->regs[5], 5 * sizeof(long));
+}
+
+static inline int syscall_get_arch(struct task_struct *task)
+{
+	return AUDIT_ARCH_LOONGARCH64;
+}
+
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
+
+#endif	/* __ASM_LOONGARCH_SYSCALL_H */
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
new file mode 100644
index 000000000000..3ffea5a81d1d
--- /dev/null
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -0,0 +1,327 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 1996, 1997, 1998, 1999, 2000, 03, 04 by Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2007  Maciej W. Rozycki
+ * Copyright (C) 2014, Imagination Technologies Ltd.
+ */
+#ifndef _ASM_UACCESS_H
+#define _ASM_UACCESS_H
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/extable.h>
+#include <asm-generic/extable.h>
+
+extern u64 __ua_limit;
+
+#define __UA_LIMIT	__ua_limit
+
+#define __UA_ADDR	".dword"
+#define __UA_ADDU	"add.d"
+#define __UA_LA		"la.abs"
+
+/*
+ * Is a address valid? This does a straightforward calculation rather
+ * than tests.
+ *
+ * Address valid if:
+ *  - "addr" doesn't have any high-bits set
+ *  - AND "size" doesn't have any high-bits set
+ *  - AND "addr+size" doesn't have any high-bits set
+ *  - OR we are in kernel mode.
+ *
+ * __ua_size() is a trick to avoid runtime checking of positive constant
+ * sizes; for those we already know at compile time that the size is ok.
+ */
+#define __ua_size(size)							\
+	((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
+
+/*
+ * access_ok: - Checks if a user space pointer is valid
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
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
+static inline int __access_ok(const void __user *p, unsigned long size)
+{
+	unsigned long addr = (unsigned long)p;
+	unsigned long end = addr + size - !!size;
+
+	return (__UA_LIMIT & (addr | end | __ua_size(size))) == 0;
+}
+
+#define access_ok(addr, size)					\
+	likely(__access_ok((addr), (size)))
+
+/*
+ * get_user: - Get a simple variable from user space.
+ * @x:	 Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
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
+#define get_user(x, ptr) \
+({									\
+	int __gu_err = -EFAULT;						\
+	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+									\
+	might_fault();							\
+	if (likely(access_ok(__gu_ptr, sizeof(*(ptr))))) {		\
+		__get_user_common((x), sizeof(*(ptr)), __gu_ptr);	\
+	} else								\
+		(x) = 0;						\
+									\
+	__gu_err;							\
+})
+
+/*
+ * put_user: - Write a simple value into user space.
+ * @x:	 Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
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
+#define put_user(x, ptr) \
+({									\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
+	__typeof__(*(ptr)) __pu_val = (x);				\
+	int __pu_err = -EFAULT;						\
+									\
+	might_fault();							\
+	if (likely(access_ok(__pu_addr, sizeof(*(ptr))))) {		\
+		__put_user_common(__pu_addr, sizeof(*(ptr)));		\
+	}								\
+									\
+	__pu_err;							\
+})
+
+/*
+ * __get_user: - Get a simple variable from user space, with less checking.
+ * @x:	 Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
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
+#define __get_user(x, ptr) \
+({									\
+	int __gu_err;							\
+									\
+	__chk_user_ptr(ptr);						\
+	__get_user_common((x), sizeof(*(ptr)), ptr);			\
+	__gu_err;							\
+})
+
+/*
+ * __put_user: - Write a simple value into user space, with less checking.
+ * @x:	 Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
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
+#define __put_user(x, ptr) \
+({									\
+	__typeof__(*(ptr)) __pu_val;					\
+	int __pu_err = 0;						\
+									\
+	__pu_val = (x);							\
+	__chk_user_ptr(ptr);						\
+	__put_user_common(ptr, sizeof(*(ptr)));					\
+	__pu_err;							\
+})
+
+struct __large_struct { unsigned long buf[100]; };
+#define __m(x) (*(struct __large_struct __user *)(x))
+
+#define __get_user_common(val, size, ptr)				\
+do {									\
+	switch (size) {							\
+	case 1: __get_data_asm(val, "ld.b", ptr); break;		\
+	case 2: __get_data_asm(val, "ld.h", ptr); break;		\
+	case 4: __get_data_asm(val, "ld.w", ptr); break;		\
+	case 8: __get_data_asm(val, "ld.d", ptr); break;			\
+	default: BUILD_BUG(); break;					\
+	}								\
+} while (0)
+
+#define __get_kernel_common(val, size, ptr) __get_user_common(val, size, ptr)
+
+#define __get_data_asm(val, insn, addr)					\
+{									\
+	long __gu_tmp;							\
+									\
+	__asm__ __volatile__(						\
+	"1:	" insn "	%1, %3				\n"	\
+	"2:							\n"	\
+	"	.section .fixup,\"ax\"				\n"	\
+	"3:	li.w	%0, %4					\n"	\
+	"	or	%1, $r0, $r0				\n"	\
+	"	b	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section __ex_table,\"a\"			\n"	\
+	"	"__UA_ADDR "\t1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=r" (__gu_tmp)				\
+	: "0" (0), "o" (__m(addr)), "i" (-EFAULT));			\
+									\
+	(val) = (__typeof__(*(addr))) __gu_tmp;				\
+}
+
+#define __put_user_common(ptr, size)					\
+do {									\
+	switch (size) {							\
+	case 1: __put_data_asm("st.b", ptr); break;			\
+	case 2: __put_data_asm("st.h", ptr); break;			\
+	case 4: __put_data_asm("st.w", ptr); break;			\
+	case 8: __put_data_asm("st.d", ptr); break;				\
+	default: BUILD_BUG(); break;					\
+	}								\
+} while (0)
+
+#define __put_kernel_common(ptr, size) __put_user_common(ptr, size)
+
+#define __put_data_asm(insn, ptr)					\
+{									\
+	__asm__ __volatile__(						\
+	"1:	" insn "	%z2, %3		# __put_user_asm\n"	\
+	"2:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"3:	li.w	%0, %4					\n"	\
+	"	b	2b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 3b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__pu_err)						\
+	: "0" (0), "Jr" (__pu_val), "o" (__m(ptr)),			\
+	  "i" (-EFAULT));						\
+}
+
+#define HAVE_GET_KERNEL_NOFAULT
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	int __gu_err;							\
+									\
+	__get_kernel_common(*((type *)(dst)), sizeof(type),		\
+			    (__force type *)(src));			\
+	if (unlikely(__gu_err))						\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	type __pu_val;					\
+	int __pu_err = 0;						\
+									\
+	__pu_val = *(__force type *)(src);				\
+	__put_kernel_common(((type *)(dst)), sizeof(type));		\
+	if (unlikely(__pu_err))						\
+		goto err_label;						\
+} while (0)
+
+extern unsigned long __copy_user(void *to, const void *from, __kernel_size_t n);
+
+static inline unsigned long __must_check
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+static inline unsigned long __must_check
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+#define INLINE_COPY_FROM_USER
+#define INLINE_COPY_TO_USER
+
+/*
+ * __clear_user: - Zero a block of memory in user space, with less checking.
+ * @addr: Destination address, in user space.
+ * @size: Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
+extern unsigned long __clear_user(void __user *addr, __kernel_size_t size);
+
+#define clear_user(addr, n)						\
+({									\
+	void __user *__cl_addr = (addr);				\
+	unsigned long __cl_size = (n);					\
+	if (__cl_size && access_ok(__cl_addr, __cl_size))		\
+		__cl_size = __clear_user(__cl_addr, __cl_size);		\
+	__cl_size;							\
+})
+
+extern long strncpy_from_user(char *to, const char __user *from, long n);
+extern long strnlen_user(const char __user *str, long n);
+
+#endif /* _ASM_UACCESS_H */
diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
new file mode 100644
index 000000000000..25b6f2d0b4e5
--- /dev/null
+++ b/arch/loongarch/include/asm/unistd.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <uapi/asm/unistd.h>
+
+#define NR_syscalls (__NR_syscalls)
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..b344b1f91715
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
+
+#include <asm-generic/unistd.h>
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
new file mode 100644
index 000000000000..080b80feeb68
--- /dev/null
+++ b/arch/loongarch/kernel/entry.S
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 1994 - 2000, 2001, 2003 Ralf Baechle
+ * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2001 MIPS Technologies, Inc.
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/loongarch.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/thread_info.h>
+
+	.text
+	.cfi_sections	.debug_frame
+	.align	5
+SYM_FUNC_START(handle_syscall)
+	csrrd	t0, PERCPU_BASE_KS
+	la.abs	t1, kernelsp
+	add.d	t1, t1, t0
+	move	t2, sp
+	ld.d	sp, t1, 0
+
+	addi.d	sp, sp, -PT_SIZE
+	cfi_st	t2, PT_R3
+	cfi_rel_offset  sp, PT_R3
+	csrrd	t2, LOONGARCH_CSR_PRMD
+	st.d	t2, sp, PT_PRMD
+	csrrd	t2, LOONGARCH_CSR_CRMD
+	st.d	t2, sp, PT_CRMD
+	csrrd	t2, LOONGARCH_CSR_ECFG
+	st.d	t2, sp, PT_ECFG
+	csrrd	t2, LOONGARCH_CSR_EUEN
+	st.d	t2, sp, PT_EUEN
+	cfi_st	ra, PT_R1
+	cfi_st	a0, PT_R4
+	cfi_st	a1, PT_R5
+	cfi_st	a2, PT_R6
+	cfi_st	a3, PT_R7
+	cfi_st	a4, PT_R8
+	cfi_st	a5, PT_R9
+	cfi_st	a6, PT_R10
+	cfi_st	a7, PT_R11
+	csrrd	ra, LOONGARCH_CSR_EPC
+	st.d	ra, sp, PT_EPC
+	cfi_rel_offset ra, PT_EPC
+
+	cfi_st	tp, PT_R2
+	cfi_st	x0, PT_R21
+	cfi_st	fp, PT_R22
+
+	SAVE_STATIC
+
+	move	x0, t0
+	li.d	tp, ~_THREAD_MASK
+	and	tp, tp, sp
+
+	move	a0, sp
+	bl	do_syscall
+
+	RESTORE_ALL_AND_RET
+SYM_FUNC_END(handle_syscall)
+
+SYM_CODE_START(ret_from_fork)
+	bl	schedule_tail		# a0 = struct task_struct *prev
+	move	a0, sp
+	bl 	syscall_exit_to_user_mode
+	RESTORE_STATIC
+	RESTORE_SOME
+	RESTORE_SP_AND_RET
+SYM_CODE_END(ret_from_fork)
+
+SYM_CODE_START(ret_from_kernel_thread)
+	bl	schedule_tail		# a0 = struct task_struct *prev
+	move	a0, s1
+	jirl	ra, s0, 0
+	move	a0, sp
+	bl	syscall_exit_to_user_mode
+	RESTORE_STATIC
+	RESTORE_SOME
+	RESTORE_SP_AND_RET
+SYM_CODE_END(ret_from_kernel_thread)
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
new file mode 100644
index 000000000000..8d51589994df
--- /dev/null
+++ b/arch/loongarch/kernel/syscall.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/capability.h>
+#include <linux/entry-common.h>
+#include <linux/errno.h>
+#include <linux/linkage.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/syscalls.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/unistd.h>
+#include <linux/compiler.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/asm.h>
+#include <asm/cacheflush.h>
+#include <asm/asm-offsets.h>
+#include <asm/signal.h>
+#include <asm/shmparam.h>
+#include <asm/switch_to.h>
+#include <asm-generic/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)	[nr] = (call),
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+	unsigned long, prot, unsigned long, flags, unsigned long,
+	fd, off_t, offset)
+{
+	if (offset & ~PAGE_MASK)
+		return -EINVAL;
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
+			       offset >> PAGE_SHIFT);
+}
+
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+	unsigned long, prot, unsigned long, flags, unsigned long, fd,
+	unsigned long, pgoff)
+{
+	if (pgoff & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
+			       pgoff >> (PAGE_SHIFT - 12));
+}
+
+void *sys_call_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
+
+typedef long (*sys_call_fn)(unsigned long, unsigned long,
+	unsigned long, unsigned long, unsigned long, unsigned long);
+
+void noinstr do_syscall(struct pt_regs *regs)
+{
+	unsigned long nr;
+	sys_call_fn syscall_fn;
+
+	nr = regs->regs[11];
+	nr = syscall_enter_from_user_mode(regs, nr);
+
+	regs->csr_epc += 4;
+	regs->orig_a0 = regs->regs[4];
+	regs->regs[4] = -ENOSYS;
+	if (nr < NR_syscalls) {
+		regs->regs[0] = nr + 1;
+		syscall_fn = sys_call_table[nr];
+		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
+					   regs->regs[7], regs->regs[8], regs->regs[9]);
+	}
+
+	syscall_exit_to_user_mode(regs);
+}
-- 
2.27.0


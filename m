Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4543BC537
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhGFEWA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEWA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:22:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 046096198B;
        Tue,  6 Jul 2021 04:19:18 +0000 (UTC)
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
Subject: [PATCH 09/19] LoongArch: Add system call support
Date:   Tue,  6 Jul 2021 12:18:10 +0800
Message-Id: <20210706041820.1536502-10-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds system call support and related code (uaccess and
seccomp) for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/seccomp.h     |   9 +
 arch/loongarch/include/asm/syscall.h     |  74 ++++
 arch/loongarch/include/asm/uaccess.h     | 453 +++++++++++++++++++++++
 arch/loongarch/include/asm/unistd.h      |  11 +
 arch/loongarch/include/uapi/asm/unistd.h |   7 +
 arch/loongarch/kernel/scall64.S          | 126 +++++++
 arch/loongarch/kernel/syscall.c          |  84 +++++
 7 files changed, 764 insertions(+)
 create mode 100644 arch/loongarch/include/asm/seccomp.h
 create mode 100644 arch/loongarch/include/asm/syscall.h
 create mode 100644 arch/loongarch/include/asm/uaccess.h
 create mode 100644 arch/loongarch/include/asm/unistd.h
 create mode 100644 arch/loongarch/include/uapi/asm/unistd.h
 create mode 100644 arch/loongarch/kernel/scall64.S
 create mode 100644 arch/loongarch/kernel/syscall.c

diff --git a/arch/loongarch/include/asm/seccomp.h b/arch/loongarch/include/asm/seccomp.h
new file mode 100644
index 000000000000..220c885f5478
--- /dev/null
+++ b/arch/loongarch/include/asm/seccomp.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SECCOMP_H
+#define __ASM_SECCOMP_H
+
+#include <linux/unistd.h>
+
+#include <asm-generic/seccomp.h>
+
+#endif /* __ASM_SECCOMP_H */
diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
new file mode 100644
index 000000000000..7d877ebfda77
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
+static inline void syscall_set_nr(struct task_struct *task,
+				  struct pt_regs *regs,
+				  int syscall)
+{
+	regs->regs[11] = syscall;
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	return regs->regs[7] ? -regs->regs[4] : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->regs[4];
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+				    struct pt_regs *regs)
+{
+	/* Do nothing */
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
+#endif	/* __ASM_LOONGARCH_SYSCALL_H */
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
new file mode 100644
index 000000000000..b760aa0a3bc6
--- /dev/null
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -0,0 +1,453 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_UACCESS_H
+#define _ASM_UACCESS_H
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/extable.h>
+#include <asm-generic/extable.h>
+
+/*
+ * The fs value determines whether argument validity checking should be
+ * performed or not.  If get_fs() == USER_DS, checking is performed, with
+ * get_fs() == KERNEL_DS, checking is bypassed.
+ *
+ * For historical reasons, these macros are grossly misnamed.
+ */
+
+#ifdef CONFIG_64BIT
+
+extern u64 __ua_limit;
+
+#define __UA_LIMIT	__ua_limit
+
+#define __UA_ADDR	".dword"
+#define __UA_ADDU	"add.d"
+#define __UA_LA		"la.abs"
+
+#endif /* CONFIG_64BIT */
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
+#ifdef CONFIG_32BIT
+#define __GET_DW(val, insn, ptr) __get_data_asm_ll32(val, insn, ptr)
+#endif
+#ifdef CONFIG_64BIT
+#define __GET_DW(val, insn, ptr) __get_data_asm(val, insn, ptr)
+#endif
+
+#define __get_user_common(val, size, ptr)				\
+do {									\
+	switch (size) {							\
+	case 1: __get_data_asm(val, "ld.b", ptr); break;		\
+	case 2: __get_data_asm(val, "ld.h", ptr); break;		\
+	case 4: __get_data_asm(val, "ld.w", ptr); break;		\
+	case 8: __GET_DW(val, "ld.d", ptr); break;			\
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
+/*
+ * Get a long long 64 using 32 bit registers.
+ */
+#define __get_data_asm_ll32(val, insn, addr)				\
+{									\
+	union {								\
+		unsigned long long	l;				\
+		__typeof__(*(addr))	t;				\
+	} __gu_tmp;							\
+									\
+	__asm__ __volatile__(						\
+	"1:	ld.w	%1, (%3)				\n"	\
+	"2:	ld.w	%D1, 4(%3)				\n"	\
+	"3:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"4:	li.w	%0, %4					\n"	\
+	"	slli.d	%1, $r0, 0				\n"	\
+	"	slli.d	%D1, $r0, 0				\n"	\
+	"	b	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous					\n"	\
+	: "=r" (__gu_err), "=&r" (__gu_tmp.l)				\
+	: "0" (0), "r" (addr), "i" (-EFAULT));				\
+									\
+	(val) = __gu_tmp.t;						\
+}
+
+#ifdef CONFIG_32BIT
+#define __PUT_DW(insn, ptr) __put_data_asm_ll32(insn, ptr)
+#endif
+#ifdef CONFIG_64BIT
+#define __PUT_DW(insn, ptr) __put_data_asm(insn, ptr)
+#endif
+
+#define __put_user_common(ptr, size)					\
+do {									\
+	switch (size) {							\
+	case 1: __put_data_asm("st.b", ptr); break;			\
+	case 2: __put_data_asm("st.h", ptr); break;			\
+	case 4: __put_data_asm("st.w", ptr); break;			\
+	case 8: __PUT_DW("st.d", ptr); break;				\
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
+#define __put_data_asm_ll32(insn, ptr)					\
+{									\
+	__asm__ __volatile__(						\
+	"1:	st.w	%2, (%3)	# __put_user_asm_ll32	\n"	\
+	"2:	st.w	%D2, 4(%3)				\n"	\
+	"3:							\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
+	"4:	li.w	%0, %4					\n"	\
+	"	b	3b					\n"	\
+	"	.previous					\n"	\
+	"	.section	__ex_table,\"a\"		\n"	\
+	"	" __UA_ADDR "	1b, 4b				\n"	\
+	"	" __UA_ADDR "	2b, 4b				\n"	\
+	"	.previous"						\
+	: "=r" (__pu_err)						\
+	: "0" (0), "r" (__pu_val), "r" (ptr),				\
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
+extern __kernel_size_t __copy_user(void *to, const void *from, __kernel_size_t n);
+
+static inline unsigned long
+raw_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+static inline unsigned long
+raw_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
+
+#define INLINE_COPY_FROM_USER
+#define INLINE_COPY_TO_USER
+
+static inline unsigned long
+raw_copy_in_user(void __user *to, const void __user *from, unsigned long n)
+{
+	return __copy_user(to, from, n);
+}
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
+extern __kernel_size_t __clear_user(void __user *addr, __kernel_size_t size);
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
+extern long __strncpy_from_user(char *to, const char __user *from, long len);
+
+/*
+ * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * @to:   Destination address, in kernel space.  This buffer must be at
+ *	  least @len bytes long.
+ * @from: Source address, in user space.
+ * @len:  Maximum number of bytes to copy, including the trailing NUL.
+ *
+ * Copies a NUL-terminated string from userspace to kernel space.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @len is smaller than the length of the string, copies @len bytes
+ * and returns @len.
+ */
+static inline long
+strncpy_from_user(char *to, const char __user *from, long len)
+{
+	if (!access_ok(from, len))
+		return -EFAULT;
+
+	might_fault();
+	return __strncpy_from_user(to, from, len);
+}
+
+extern long __strnlen_user(const char __user *s, long n);
+
+/*
+ * strnlen_user: - Get the size of a string in user space.
+ * @s: The string to measure.
+ *
+ * Context: User context only. This function may sleep if pagefaults are
+ *          enabled.
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ * If the string is too long, returns a value greater than @n.
+ */
+static inline long strnlen_user(const char __user *s, long n)
+{
+	if (!access_ok(s, 1))
+		return 0;
+
+	might_fault();
+	return __strnlen_user(s, n);
+}
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
index 000000000000..6c194d740ed0
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
+#define __ARCH_WANT_SET_GET_RLIMIT
+
+#include <asm-generic/unistd.h>
diff --git a/arch/loongarch/kernel/scall64.S b/arch/loongarch/kernel/scall64.S
new file mode 100644
index 000000000000..ec4cf68d7feb
--- /dev/null
+++ b/arch/loongarch/kernel/scall64.S
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/errno.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/irqflags.h>
+#include <asm/loongarchregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/unistd.h>
+
+	.text
+	.cfi_sections	.debug_frame
+	.align	5
+SYM_FUNC_START(handle_sys)
+	csrrd	t0, PERCPU_BASE_KS
+	la.abs	t1, kernelsp
+	add.d	t1, t1, t0
+	or	t2, sp, zero
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
+
+	cfi_rel_offset ra, PT_EPC
+
+	cfi_st	tp, PT_R2
+	cfi_st	x0, PT_R21
+	cfi_st	fp, PT_R22
+
+	li.d	tp, ~_THREAD_MASK
+	and	tp, tp, sp
+
+	STI
+
+	/* save the initial A0 value (needed in signal handlers) */
+	st.d	a0, sp, PT_ORIG_A0
+	ld.d	t1, sp, PT_EPC		# skip syscall on return
+	addi.d	t1, t1, 4		# skip to next instruction
+	st.d	t1, sp, PT_EPC
+
+	li.d	t1, _TIF_WORK_SYSCALL_ENTRY
+	LONG_L	t0, tp, TI_FLAGS	# syscall tracing enabled?
+	and	t0, t1, t0
+	bnez	t0, syscall_trace_entry
+
+syscall_common:
+	/* Check to make sure we don't jump to a bogus syscall number. */
+	li.w	t0, __NR_syscalls
+	sub.d	t2, a7, t0
+	bgez	t2, illegal_syscall
+
+	/* Syscall number held in a7 */
+	slli.d	t0, a7, 3		# offset into table
+	la	t2, sys_call_table
+	add.d	t0, t2, t0
+	ld.d	t2, t0, 0		#syscall routine
+	beqz    t2, illegal_syscall
+
+	jalr	t2			# Do The Real Thing (TM)
+
+	ld.d	t1, sp, PT_R11		# syscall number
+	addi.d	t1, t1, 1		# +1 for handle_signal
+	st.d	t1, sp, PT_R0		# save it for syscall restarting
+	st.d	v0, sp, PT_R4		# result
+
+la64_syscall_exit:
+	b	syscall_exit_partial
+
+/* ------------------------------------------------------------------------ */
+
+syscall_trace_entry:
+	SAVE_STATIC
+	move	a0, sp
+	move	a1, a7
+	bl	syscall_trace_enter
+
+	blt	v0, zero, 1f			# seccomp failed? Skip syscall
+
+	RESTORE_STATIC
+	ld.d	a0, sp, PT_R4		# Restore argument registers
+	ld.d	a1, sp, PT_R5
+	ld.d	a2, sp, PT_R6
+	ld.d	a3, sp, PT_R7
+	ld.d	a4, sp, PT_R8
+	ld.d	a5, sp, PT_R9
+	ld.d	a6, sp, PT_R10
+	ld.d	a7, sp, PT_R11		# Restore syscall (maybe modified)
+	b	syscall_common
+
+1:	b	syscall_exit
+
+	/*
+	 * The system call does not exist in this kernel
+	 */
+
+illegal_syscall:
+	/* This also isn't a valid syscall, throw an error.  */
+	li.w	v0, -ENOSYS			# error
+	st.d	v0, sp, PT_R4
+	b	la64_syscall_exit
+SYM_FUNC_END(handle_sys)
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
new file mode 100644
index 000000000000..71dd110bf31c
--- /dev/null
+++ b/arch/loongarch/kernel/syscall.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Hanlu Li <lihanlu@loongson.cn>
+ *         Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/capability.h>
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
+#define __str2(x) #x
+#define __str(x) __str2(x)
+#define save_static(symbol)                            \
+__asm__(                                               \
+       ".text\n\t"                                     \
+       ".globl\t__" #symbol "\n\t"                     \
+       ".align\t2\n\t"                                 \
+       ".type\t__" #symbol ", @function\n\t"           \
+	"__"#symbol":\n\t"                              \
+       "st.d\t$r23,$r3,"__str(PT_R23)"\n\t"            \
+       "st.d\t$r24,$r3,"__str(PT_R24)"\n\t"            \
+       "st.d\t$r25,$r3,"__str(PT_R25)"\n\t"            \
+       "st.d\t$r26,$r3,"__str(PT_R26)"\n\t"            \
+       "st.d\t$r27,$r3,"__str(PT_R27)"\n\t"            \
+       "st.d\t$r28,$r3,"__str(PT_R28)"\n\t"            \
+       "st.d\t$r29,$r3,"__str(PT_R29)"\n\t"            \
+       "st.d\t$r30,$r3,"__str(PT_R30)"\n\t"            \
+       "st.d\t$r31,$r3,"__str(PT_R31)"\n\t"            \
+       "b\t" #symbol "\n\t"                            \
+       ".size\t__" #symbol",. - __" #symbol)
+
+save_static(sys_clone);
+save_static(sys_clone3);
+
+asmlinkage void __sys_clone(void);
+asmlinkage void __sys_clone3(void);
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
+	__SYSCALL(__NR_clone, __sys_clone)
+	__SYSCALL(__NR_clone3, __sys_clone3)
+};
-- 
2.27.0


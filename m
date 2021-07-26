Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2CB3D5B17
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhGZNbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 09:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234460AbhGZNbg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 09:31:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5388160F57;
        Mon, 26 Jul 2021 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627308724;
        bh=0Rnhfees4LvhDdcCE0fFvJ0fic6ZDFy9GBRjNNucmkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9AfnoEqkshHv+yeISn/tEmhwdDcYpxEkdCy5dBvTCnxhRSYwDo0SvPLZ9yKXiopD
         EGmOupJs9AO1UINofd/CBVSS7LxkIWelLUKmP+E8fnGcjjGQtB6ZOI+9IY9oi12yki
         /JjNRYAj68wV+HxNLKrmM1kjUMPVbrbzPbHnuWRBjX5moWnIH7Vz+oyzLqLBBIW3Fm
         +mXTHv8E+CBEy3k7hctCMVRBpf67/vrwpPwzl5WID7YDE9wgDrKkTC2mqWlMHLic5m
         +ZFtxaOgYtkM3aYu7o28jLKDzML1wWXIoLvD3TxxZxktQpQLZUSfzUN+s+6pYJKsLO
         6NCNo/UEWkQiw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 09/10] ARM: uaccess: remove set_fs() implementation
Date:   Mon, 26 Jul 2021 16:11:40 +0200
Message-Id: <20210726141141.2839385-10-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are no remaining callers of set_fs(), so just remove it
along with all associated code that operates on
thread_info->addr_limit.

There are still further optimizations that can be done:

- In get_user(), the address check could be moved entirely
  into the out of line code, rather than passing a constant
  as an argument,

- I assume the DACR handling can be simplified as we now
  only change it during user access when CONFIG_CPU_SW_DOMAIN_PAN
  is set, but not during set_fs().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                   |  1 -
 arch/arm/include/asm/ptrace.h      |  1 -
 arch/arm/include/asm/thread_info.h |  4 ---
 arch/arm/include/asm/uaccess-asm.h |  6 ----
 arch/arm/include/asm/uaccess.h     | 46 +++---------------------------
 arch/arm/kernel/asm-offsets.c      |  2 --
 arch/arm/kernel/entry-common.S     | 12 --------
 arch/arm/kernel/process.c          |  7 +----
 arch/arm/kernel/signal.c           |  8 ------
 arch/arm/lib/copy_from_user.S      |  3 +-
 arch/arm/lib/copy_to_user.S        |  3 +-
 11 files changed, 7 insertions(+), 86 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 82f908fa5676..40a3a96b3d4e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -126,7 +126,6 @@ config ARM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-	select SET_FS
 	select SYS_SUPPORTS_APM_EMULATION
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 91d6b7856be4..93051e2f402c 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -19,7 +19,6 @@ struct pt_regs {
 struct svc_pt_regs {
 	struct pt_regs regs;
 	u32 dacr;
-	u32 addr_limit;
 };
 
 #define to_svc_pt_regs(r) container_of(r, struct svc_pt_regs, regs)
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 17c56051747b..d89931aed59f 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -31,8 +31,6 @@ struct task_struct;
 
 #include <asm/types.h>
 
-typedef unsigned long mm_segment_t;
-
 struct cpu_context_save {
 	__u32	r4;
 	__u32	r5;
@@ -54,7 +52,6 @@ struct cpu_context_save {
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
-	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
 	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
@@ -80,7 +77,6 @@ struct thread_info {
 	.task		= &tsk,						\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
-	.addr_limit	= KERNEL_DS,					\
 }
 
 /*
diff --git a/arch/arm/include/asm/uaccess-asm.h b/arch/arm/include/asm/uaccess-asm.h
index e6eb7a2aaf1e..6451a433912c 100644
--- a/arch/arm/include/asm/uaccess-asm.h
+++ b/arch/arm/include/asm/uaccess-asm.h
@@ -84,12 +84,8 @@
 	 * if \disable is set.
 	 */
 	.macro	uaccess_entry, tsk, tmp0, tmp1, tmp2, disable
-	ldr	\tmp1, [\tsk, #TI_ADDR_LIMIT]
-	ldr	\tmp2, =TASK_SIZE
-	str	\tmp2, [\tsk, #TI_ADDR_LIMIT]
  DACR(	mrc	p15, 0, \tmp0, c3, c0, 0)
  DACR(	str	\tmp0, [sp, #SVC_DACR])
-	str	\tmp1, [sp, #SVC_ADDR_LIMIT]
 	.if \disable && IS_ENABLED(CONFIG_CPU_SW_DOMAIN_PAN)
 	/* kernel=client, user=no access */
 	mov	\tmp2, #DACR_UACCESS_DISABLE
@@ -106,9 +102,7 @@
 
 	/* Restore the user access state previously saved by uaccess_entry */
 	.macro	uaccess_exit, tsk, tmp0, tmp1
-	ldr	\tmp1, [sp, #SVC_ADDR_LIMIT]
  DACR(	ldr	\tmp0, [sp, #SVC_DACR])
-	str	\tmp1, [\tsk, #TI_ADDR_LIMIT]
  DACR(	mcr	p15, 0, \tmp0, c3, c0, 0)
 	.endm
 
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 4f60638755c4..084d1c07c2d0 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -52,32 +52,8 @@ static __always_inline void uaccess_restore(unsigned int flags)
 extern int __get_user_bad(void);
 extern int __put_user_bad(void);
 
-/*
- * Note that this is actually 0x1,0000,0000
- */
-#define KERNEL_DS	0x00000000
-
 #ifdef CONFIG_MMU
 
-#define USER_DS		TASK_SIZE
-#define get_fs()	(current_thread_info()->addr_limit)
-
-static inline void set_fs(mm_segment_t fs)
-{
-	current_thread_info()->addr_limit = fs;
-
-	/*
-	 * Prevent a mispredicted conditional call to set_fs from forwarding
-	 * the wrong address limit to access_ok under speculation.
-	 */
-	dsb(nsh);
-	isb();
-
-	modify_domain(DOMAIN_KERNEL, fs ? DOMAIN_CLIENT : DOMAIN_MANAGER);
-}
-
-#define uaccess_kernel()	(get_fs() == KERNEL_DS)
-
 /*
  * We use 33-bit arithmetic here.  Success returns zero, failure returns
  * addr_limit.  We take advantage that addr_limit will be zero for KERNEL_DS,
@@ -89,7 +65,7 @@ static inline void set_fs(mm_segment_t fs)
 	__asm__(".syntax unified\n" \
 		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \
 		: "=&r" (flag), "=&r" (roksum) \
-		: "r" (addr), "Ir" (size), "0" (current_thread_info()->addr_limit) \
+		: "r" (addr), "Ir" (size), "0" (TASK_SIZE) \
 		: "cc"); \
 	flag; })
 
@@ -120,7 +96,7 @@ static inline void __user *__uaccess_mask_range_ptr(const void __user *ptr,
 	"	subshs	%1, %1, %2\n"
 	"	movlo	%0, #0\n"
 	: "+r" (safe_ptr), "=&r" (tmp)
-	: "r" (size), "r" (current_thread_info()->addr_limit)
+	: "r" (size), "r" (TASK_SIZE)
 	: "cc");
 
 	csdb();
@@ -194,7 +170,7 @@ extern int __get_user_64t_4(void *);
 
 #define __get_user_check(x, p)						\
 	({								\
-		unsigned long __limit = current_thread_info()->addr_limit - 1; \
+		unsigned long __limit = TASK_SIZE - 1; \
 		register typeof(*(p)) __user *__p asm("r0") = (p);	\
 		register __inttype(x) __r2 asm("r2");			\
 		register unsigned long __l asm("r1") = __limit;		\
@@ -245,7 +221,7 @@ extern int __put_user_8(void *, unsigned long long);
 
 #define __put_user_check(__pu_val, __ptr, __err, __s)			\
 	({								\
-		unsigned long __limit = current_thread_info()->addr_limit - 1; \
+		unsigned long __limit = TASK_SIZE - 1; \
 		register typeof(__pu_val) __r2 asm("r2") = __pu_val;	\
 		register const void __user *__p asm("r0") = __ptr;	\
 		register unsigned long __l asm("r1") = __limit;		\
@@ -262,19 +238,8 @@ extern int __put_user_8(void *, unsigned long long);
 
 #else /* CONFIG_MMU */
 
-/*
- * uClinux has only one addr space, so has simplified address limits.
- */
-#define USER_DS			KERNEL_DS
-
-#define uaccess_kernel()	(true)
 #define __addr_ok(addr)		((void)(addr), 1)
 #define __range_ok(addr, size)	((void)(addr), 0)
-#define get_fs()		(KERNEL_DS)
-
-static inline void set_fs(mm_segment_t fs)
-{
-}
 
 #define get_user(x, p)	__get_user(x, p)
 #define __put_user_check __put_user_nocheck
@@ -283,9 +248,6 @@ static inline void set_fs(mm_segment_t fs)
 
 #define access_ok(addr, size)	(__range_ok(addr, size) == 0)
 
-#define user_addr_max() \
-	(uaccess_kernel() ? ~0UL : get_fs())
-
 #ifdef CONFIG_CPU_SPECTRE
 /*
  * When mitigating Spectre variant 1, it is not worth fixing the non-
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index a0945b898ca3..c60fefabc868 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -43,7 +43,6 @@ int main(void)
   BLANK();
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
-  DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
@@ -92,7 +91,6 @@ int main(void)
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
   DEFINE(SVC_DACR,		offsetof(struct svc_pt_regs, dacr));
-  DEFINE(SVC_ADDR_LIMIT,	offsetof(struct svc_pt_regs, addr_limit));
   DEFINE(SVC_REGS_SIZE,		sizeof(struct svc_pt_regs));
   BLANK();
   DEFINE(SIGFRAME_RC3_OFFSET,	offsetof(struct sigframe, retcode[3]));
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index e837af90cd44..d9c99db50243 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -49,10 +49,6 @@ __ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	ldr	r1, =TASK_SIZE
-	cmp	r2, r1
-	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
 	bne	fast_work_pending
@@ -87,10 +83,6 @@ __ret_fast_syscall:
 	bl	do_rseq_syscall
 #endif
 	disable_irq_notrace			@ disable interrupts
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	ldr     r1, =TASK_SIZE
-	cmp     r2, r1
-	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	movs	r1, r1, lsl #16
 	beq	no_work_pending
@@ -129,10 +121,6 @@ ret_slow_syscall:
 #endif
 	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	ldr     r1, =TASK_SIZE
-	cmp	r2, r1
-	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]
 	movs	r1, r1, lsl #16
 	bne	slow_work_pending
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fc9e8b37eaa8..581542fbf5bf 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -108,7 +108,7 @@ void __show_regs(struct pt_regs *regs)
 	unsigned long flags;
 	char buf[64];
 #ifndef CONFIG_CPU_V7M
-	unsigned int domain, fs;
+	unsigned int domain;
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
 	 * Get the domain register for the parent context. In user
@@ -117,14 +117,11 @@ void __show_regs(struct pt_regs *regs)
 	 */
 	if (user_mode(regs)) {
 		domain = DACR_UACCESS_ENABLE;
-		fs = get_fs();
 	} else {
 		domain = to_svc_pt_regs(regs)->dacr;
-		fs = to_svc_pt_regs(regs)->addr_limit;
 	}
 #else
 	domain = get_domain();
-	fs = get_fs();
 #endif
 #endif
 
@@ -160,8 +157,6 @@ void __show_regs(struct pt_regs *regs)
 		if ((domain & domain_mask(DOMAIN_USER)) ==
 		    domain_val(DOMAIN_USER, DOMAIN_NOACCESS))
 			segment = "none";
-		else if (fs == KERNEL_DS)
-			segment = "kernel";
 		else
 			segment = "user";
 
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a3a38d0a4c85..3e7ddac086c2 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -711,14 +711,6 @@ struct page *get_signal_page(void)
 	return page;
 }
 
-/* Defer to generic check */
-asmlinkage void addr_limit_check_failed(void)
-{
-#ifdef CONFIG_MMU
-	addr_limit_user_check();
-#endif
-}
-
 #ifdef CONFIG_DEBUG_RSEQ
 asmlinkage void do_rseq_syscall(struct pt_regs *regs)
 {
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index f8016e3db65d..480a20766137 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -109,8 +109,7 @@
 
 ENTRY(arm_copy_from_user)
 #ifdef CONFIG_CPU_SPECTRE
-	get_thread_info r3
-	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	ldr	r3, =TASK_SIZE
 	uaccess_mask_range_ptr r1, r2, r3, ip
 #endif
 
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index ebfe4cb3d912..842ea5ede485 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -109,8 +109,7 @@
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
 #ifdef CONFIG_CPU_SPECTRE
-	get_thread_info r3
-	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	ldr	r3, =TASK_SIZE
 	uaccess_mask_range_ptr r0, r2, r3, ip
 #endif
 
-- 
2.29.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9636280102
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgJAONb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:13:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732466AbgJAONO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:13:14 -0400
Received: from threadripper.lan ([46.223.126.90]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6svJ-1kTY2z35jT-018LMt; Thu, 01 Oct 2020 16:12:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 10/10] ARM: uaccess: remove set_fs() implementation
Date:   Thu,  1 Oct 2020 16:12:33 +0200
Message-Id: <20201001141233.119343-11-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201001141233.119343-1-arnd@arndb.de>
References: <20201001141233.119343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c7n0899ba8d89RLFZcbAnXcastoMvP/Hnya1NwGppWzA7LX+6tV
 K/Rpy0z8l8UnvUaL9Jq7NFahgP+9gQAg+aGw3QxEOxk6lxFUJczIuKqvzbgZWX3qLFi6rqv
 RQoRLkb0/PeJSdpiXfjdx/WMheBYzcwiQTkvPD1TsQ1bjwyB/D/H11Myzet6r+tSTathaYd
 vYp/jVf4G/7wk+E8HzVOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sU6SUszacMQ=:A4WOI1kzbArwynTSMwPbdk
 cxeOyZYokJRfXyLfRpwokvTkMf1GAMJcUbYRvQ2E4N1lnBwOS6QgLVI/faFAo5ZJ24N8Jwile
 UCNiVccw7nYYTCPn0G48IG0Az/pAPaYq/9PBWnYjKbEWYF0puWBGRfdY68x7yZReIohpwwj6f
 hid6GiLJDlS0nvd+WYsUqAK0TNvSc7Z/Laa2LmoZVfOlXC28exFuWMMYXORjv3sTUIt4vBaFu
 jMLjiwbCwZrV9z0fEIkIk0Lopys9DhRa2ZQ+oBxPkSh7MrV81Zr5yLXcUuUR0EnZtkzQoyB39
 SD/UW8fy507LibkfnSIkOc9V+nRGBsXyswUszUZVkbc1mlzjudOJwupYJNFHChoDXnBJVWUey
 c0tKfqZhFDfa9/gkjcevYa+xHl5LjMDppDZl104CHIenx/a2dPGqCXDxvd19fojix8ZpbXhXq
 1NQ4/hcs80EpCChHa33gds2+HIL70pQdV5nxdcSzAXj7AZ6I6Y/TYd2pPIpGGIN0np1fpDj56
 YE/1kgP63VVyoisv8H3JfKIHKSPOWLKxvmC9mChk3R3F3qmT19jmdfljqmflRxZJeOcTpRS2m
 RB51Jomy8qEIMD6BIBVYb1Vnt8vsLyUETNy8IrP0lGqzzVaiEt6h5SQt0TZV3D7CW2TXtrOLM
 26+10ef5VY4InfP1DBlIz4AUPV02w71zb6ngGtyCmPaukbW/TWAY9sFMhPLLx/RCAPXBXbrme
 4v3ops1EXzbJRko2Zd1dm0UwULNzt4pQs0auhuvgjkvv0H5iOOS14YA48UzwB2QNwbhAiXg9B
 Z1uc4IRgj1ihZX+USgUdrBhPd9Q1IkIrYW1zE/ejGhKgoUv6dbKrZLtszcsl/ISAQJ8ce2E
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
 arch/arm/kernel/entry-common.S     |  9 ------
 arch/arm/kernel/process.c          |  7 +----
 arch/arm/kernel/signal.c           |  8 ------
 arch/arm/lib/copy_from_user.S      |  3 +-
 arch/arm/lib/copy_to_user.S        |  3 +-
 11 files changed, 7 insertions(+), 83 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87e1478a42dc..e00d94b16658 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -118,7 +118,6 @@ config ARM
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
index 536b6b979f63..8b705f611216 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -23,8 +23,6 @@ struct task_struct;
 
 #include <asm/types.h>
 
-typedef unsigned long mm_segment_t;
-
 struct cpu_context_save {
 	__u32	r4;
 	__u32	r5;
@@ -46,7 +44,6 @@ struct cpu_context_save {
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
-	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
 	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
@@ -72,7 +69,6 @@ struct thread_info {
 	.task		= &tsk,						\
 	.flags		= 0,						\
 	.preempt_count	= INIT_PREEMPT_COUNT,				\
-	.addr_limit	= KERNEL_DS,					\
 }
 
 /*
diff --git a/arch/arm/include/asm/uaccess-asm.h b/arch/arm/include/asm/uaccess-asm.h
index 907571fd05c6..6451a433912c 100644
--- a/arch/arm/include/asm/uaccess-asm.h
+++ b/arch/arm/include/asm/uaccess-asm.h
@@ -84,12 +84,8 @@
 	 * if \disable is set.
 	 */
 	.macro	uaccess_entry, tsk, tmp0, tmp1, tmp2, disable
-	ldr	\tmp1, [\tsk, #TI_ADDR_LIMIT]
-	mov	\tmp2, #TASK_SIZE
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
index 97af6735172b..78f0a25baf2d 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -41,7 +41,6 @@ int main(void)
   BLANK();
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
-  DEFINE(TI_ADDR_LIMIT,		offsetof(struct thread_info, addr_limit));
   DEFINE(TI_TASK,		offsetof(struct thread_info, task));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
@@ -90,7 +89,6 @@ int main(void)
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
   DEFINE(SVC_DACR,		offsetof(struct svc_pt_regs, dacr));
-  DEFINE(SVC_ADDR_LIMIT,	offsetof(struct svc_pt_regs, addr_limit));
   DEFINE(SVC_REGS_SIZE,		sizeof(struct svc_pt_regs));
   BLANK();
   DEFINE(SIGFRAME_RC3_OFFSET,	offsetof(struct sigframe, retcode[3]));
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 9a76467bbb47..2c0bde14fba6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -49,9 +49,6 @@ __ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	cmp	r2, #TASK_SIZE
-	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
 	bne	fast_work_pending
@@ -86,9 +83,6 @@ __ret_fast_syscall:
 	bl	do_rseq_syscall
 #endif
 	disable_irq_notrace			@ disable interrupts
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	cmp	r2, #TASK_SIZE
-	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
 	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
 	beq	no_work_pending
@@ -127,9 +121,6 @@ ret_slow_syscall:
 #endif
 	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
-	ldr	r2, [tsk, #TI_ADDR_LIMIT]
-	cmp	r2, #TASK_SIZE
-	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
 	bne	slow_work_pending
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8e6ace03e960..28a1a4a9dd77 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -97,7 +97,7 @@ void __show_regs(struct pt_regs *regs)
 	unsigned long flags;
 	char buf[64];
 #ifndef CONFIG_CPU_V7M
-	unsigned int domain, fs;
+	unsigned int domain;
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
 	 * Get the domain register for the parent context. In user
@@ -106,14 +106,11 @@ void __show_regs(struct pt_regs *regs)
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
 
@@ -149,8 +146,6 @@ void __show_regs(struct pt_regs *regs)
 		if ((domain & domain_mask(DOMAIN_USER)) ==
 		    domain_val(DOMAIN_USER, DOMAIN_NOACCESS))
 			segment = "none";
-		else if (fs == KERNEL_DS)
-			segment = "kernel";
 		else
 			segment = "user";
 
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index c9dc912b83f0..618b5d938317 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -710,14 +710,6 @@ struct page *get_signal_page(void)
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
index f8016e3db65d..f481ef789a93 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -109,8 +109,7 @@
 
 ENTRY(arm_copy_from_user)
 #ifdef CONFIG_CPU_SPECTRE
-	get_thread_info r3
-	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	mov	r3, #TASK_SIZE
 	uaccess_mask_range_ptr r1, r2, r3, ip
 #endif
 
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index ebfe4cb3d912..215da16c7d6e 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -109,8 +109,7 @@
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
 #ifdef CONFIG_CPU_SPECTRE
-	get_thread_info r3
-	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	mov	r3, #TASK_SIZE
 	uaccess_mask_range_ptr r0, r2, r3, ip
 #endif
 
-- 
2.27.0


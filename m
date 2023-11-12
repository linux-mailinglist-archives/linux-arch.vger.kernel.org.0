Return-Path: <linux-arch+bounces-149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FEE7E8E9B
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9C1F20F6B
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32188440E;
	Sun, 12 Nov 2023 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESyaUcYg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175EF440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1162C433CB;
	Sun, 12 Nov 2023 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769806;
	bh=qHVG03WWJVZvda3e++Okszof2Z8C09M4hIc5+i1mb4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ESyaUcYgNZ0w0PeP2kGWLX5Cc0dwRyNfLVnXyg9QegSXPArmxplZ9qX9iQZiScfEQ
	 Rm+EPIvWhBCbTz1kAKaBDTtgnpMq2U0IFUgRl4vPD599u+P4UJtlsliPYEUhWYXCcD
	 HGuVXJuQ3nZc4keZ0OZbGfXF5P4ISH/LZ/c776GY97dKhlM/b4KDihf7Y/rOwCLki5
	 dBjrHeqm7rXXA5VQeX2ON4PAqAdRv/3futewKN+kSZKpGxof7uenBZyysTjmpJd87Y
	 xms8KaaJztTEunoNDl9dgjtK7zpZ0Vro0gs+xIo90ZVYrYtlpcn0GZcjI8dFoNpuHb
	 LdAJYKuyfZr8g==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 13/38] riscv: s64ilp32: Introduce xlen_t for 64ILP32 kernel
Date: Sun, 12 Nov 2023 01:14:49 -0500
Message-Id: <20231112061514.2306187-14-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When s64ilp32 landed, we couldn't use CONFIG_64/32BIT to distingue XLEN
data types. Because the xlen is 64, but the long & pointer is 32 for
s64ilp32, and s64ilp32 is a 32BIT from the software view. So introduce a
new data type - "xlen_t" and use __riscv_xlen instead of CONFIG_64/32BIT
ifdef macro.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/csr.h       | 20 ++++---
 arch/riscv/include/asm/processor.h |  8 +--
 arch/riscv/include/asm/ptrace.h    | 96 +++++++++++++++---------------
 arch/riscv/include/asm/timex.h     | 10 ++--
 arch/riscv/kernel/process.c        |  4 +-
 arch/riscv/kernel/traps.c          |  4 +-
 arch/riscv/kernel/vector.c         |  2 +-
 arch/riscv/lib/memset.S            |  4 +-
 arch/riscv/mm/fault.c              |  2 +-
 9 files changed, 78 insertions(+), 72 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 051c017e1e5e..03acdedc100d 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -461,9 +461,15 @@
 
 #ifndef __ASSEMBLY__
 
+#if __riscv_xlen == 64
+typedef u64 xlen_t;
+#else
+typedef u32 xlen_t;
+#endif
+
 #define csr_swap(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrw %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -472,7 +478,7 @@
 
 #define csr_read(csr)						\
 ({								\
-	register unsigned long __v;				\
+	register xlen_t __v;					\
 	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
 			      : "=r" (__v) :			\
 			      : "memory");			\
@@ -481,7 +487,7 @@
 
 #define csr_write(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
@@ -489,7 +495,7 @@
 
 #define csr_read_set(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrs %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -498,7 +504,7 @@
 
 #define csr_set(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrs " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
@@ -506,7 +512,7 @@
 
 #define csr_read_clear(csr, val)				\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrc %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -515,7 +521,7 @@
 
 #define csr_clear(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrc " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index c950a8d9edef..d8bfadaeea32 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -37,12 +37,12 @@ struct thread_struct {
 	/* Callee-saved registers */
 	unsigned long ra;
 	unsigned long sp;	/* Kernel mode stack */
-	unsigned long s[12];	/* s[0]: frame pointer */
+	xlen_t     s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
 	unsigned long vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
-};
+} __attribute__((__aligned__(sizeof(xlen_t))));
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
@@ -60,8 +60,8 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	((struct pt_regs *)(task_stack_page(tsk) + THREAD_SIZE		\
 			    - ALIGN(sizeof(struct pt_regs), STACK_ALIGN)))
 
-#define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
-#define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
+#define KSTK_EIP(tsk)		(ulong)(task_pt_regs(tsk)->epc)
+#define KSTK_ESP(tsk)		(ulong)(task_pt_regs(tsk)->sp)
 
 
 /* Do necessary setup to start up a newly executed thread. */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c1..54cdeec8ee79 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -13,53 +13,53 @@
 #ifndef __ASSEMBLY__
 
 struct pt_regs {
-	unsigned long epc;
-	unsigned long ra;
-	unsigned long sp;
-	unsigned long gp;
-	unsigned long tp;
-	unsigned long t0;
-	unsigned long t1;
-	unsigned long t2;
-	unsigned long s0;
-	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
-	unsigned long s2;
-	unsigned long s3;
-	unsigned long s4;
-	unsigned long s5;
-	unsigned long s6;
-	unsigned long s7;
-	unsigned long s8;
-	unsigned long s9;
-	unsigned long s10;
-	unsigned long s11;
-	unsigned long t3;
-	unsigned long t4;
-	unsigned long t5;
-	unsigned long t6;
+	xlen_t epc;
+	xlen_t ra;
+	xlen_t sp;
+	xlen_t gp;
+	xlen_t tp;
+	xlen_t t0;
+	xlen_t t1;
+	xlen_t t2;
+	xlen_t s0;
+	xlen_t s1;
+	xlen_t a0;
+	xlen_t a1;
+	xlen_t a2;
+	xlen_t a3;
+	xlen_t a4;
+	xlen_t a5;
+	xlen_t a6;
+	xlen_t a7;
+	xlen_t s2;
+	xlen_t s3;
+	xlen_t s4;
+	xlen_t s5;
+	xlen_t s6;
+	xlen_t s7;
+	xlen_t s8;
+	xlen_t s9;
+	xlen_t s10;
+	xlen_t s11;
+	xlen_t t3;
+	xlen_t t4;
+	xlen_t t5;
+	xlen_t t6;
 	/* Supervisor/Machine CSRs */
-	unsigned long status;
-	unsigned long badaddr;
-	unsigned long cause;
+	xlen_t status;
+	xlen_t badaddr;
+	xlen_t cause;
 	/* a0 value before the syscall */
-	unsigned long orig_a0;
+	xlen_t orig_a0;
 };
 
 #define PTRACE_SYSEMU			0x1f
 #define PTRACE_SYSEMU_SINGLESTEP	0x20
 
-#ifdef CONFIG_64BIT
-#define REG_FMT "%016lx"
+#if __riscv_xlen == 64
+#define REG_FMT "%016llx"
 #else
-#define REG_FMT "%08lx"
+#define REG_FMT "%08x"
 #endif
 
 #define user_mode(regs) (((regs)->status & SR_PP) == 0)
@@ -69,12 +69,12 @@ struct pt_regs {
 /* Helpers for working with the instruction pointer */
 static inline unsigned long instruction_pointer(struct pt_regs *regs)
 {
-	return regs->epc;
+	return (unsigned long)regs->epc;
 }
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
 {
-	regs->epc = val;
+	regs->epc = (xlen_t)val;
 }
 
 #define profile_pc(regs) instruction_pointer(regs)
@@ -82,40 +82,40 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 /* Helpers for working with the user stack pointer */
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
-	return regs->sp;
+	return (unsigned long)regs->sp;
 }
 static inline void user_stack_pointer_set(struct pt_regs *regs,
 					  unsigned long val)
 {
-	regs->sp =  val;
+	regs->sp = (xlen_t)val;
 }
 
 /* Valid only for Kernel mode traps. */
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
-	return regs->sp;
+	return (unsigned long)regs->sp;
 }
 
 /* Helpers for working with the frame pointer */
 static inline unsigned long frame_pointer(struct pt_regs *regs)
 {
-	return regs->s0;
+	return (unsigned long)regs->s0;
 }
 static inline void frame_pointer_set(struct pt_regs *regs,
 				     unsigned long val)
 {
-	regs->s0 = val;
+	regs->s0 = (xlen_t)val;
 }
 
 static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
-	return regs->a0;
+	return (unsigned long)regs->a0;
 }
 
 static inline void regs_set_return_value(struct pt_regs *regs,
 					 unsigned long val)
 {
-	regs->a0 = val;
+	regs->a0 = (xlen_t)val;
 }
 
 extern int regs_query_register_offset(const char *name);
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69..bc0d2708bcd6 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -8,7 +8,7 @@
 
 #include <asm/csr.h>
 
-typedef unsigned long cycles_t;
+typedef xlen_t cycles_t;
 
 #ifdef CONFIG_RISCV_M_MODE
 
@@ -62,12 +62,12 @@ static inline u32 get_cycles_hi(void)
 
 #endif /* !CONFIG_RISCV_M_MODE */
 
-#ifdef CONFIG_64BIT
+#if __riscv_xlen == 64
 static inline u64 get_cycles64(void)
 {
 	return get_cycles();
 }
-#else /* CONFIG_64BIT */
+#else /* __riscv_xlen == 64 */
 static inline u64 get_cycles64(void)
 {
 	u32 hi, lo;
@@ -79,12 +79,12 @@ static inline u64 get_cycles64(void)
 
 	return ((u64)hi << 32) | lo;
 }
-#endif /* CONFIG_64BIT */
+#endif /* __riscv_xlen == 64 */
 
 #define ARCH_HAS_READ_CURRENT_TIMER
 static inline int read_current_timer(unsigned long *timer_val)
 {
-	*timer_val = get_cycles();
+	*timer_val = (unsigned long)get_cycles();
 	return 0;
 }
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 87bdb0d6dbf3..599b1966a166 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -46,8 +46,8 @@ void __show_regs(struct pt_regs *regs)
 	show_regs_print_info(KERN_DEFAULT);
 
 	if (!user_mode(regs)) {
-		pr_cont("epc : %pS\n", (void *)regs->epc);
-		pr_cont(" ra : %pS\n", (void *)regs->ra);
+		pr_cont("epc : %pS\n", (void *)(ulong)regs->epc);
+		pr_cont(" ra : %pS\n", (void *)(ulong)regs->ra);
 	}
 
 	pr_cont("epc : " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..8fcef4fa43d0 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -100,7 +100,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
-			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+			tsk->comm, task_pid_nr(tsk), signo, code, (xlen_t)addr);
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
@@ -265,7 +265,7 @@ void handle_break(struct pt_regs *regs)
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)instruction_pointer(regs));
 #ifdef CONFIG_KGDB
 	else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTRAP)
 								== NOTIFY_STOP)
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 8d92fb6c522c..72ff3916eed6 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(riscv_v_vstate_ctrl_user_allowed);
 
 bool riscv_v_first_use_handler(struct pt_regs *regs)
 {
-	u32 __user *epc = (u32 __user *)regs->epc;
+	u32 __user *epc = (u32 __user *)(ulong)regs->epc;
 	u32 insn = (u32)regs->badaddr;
 
 	/* Do not handle if V is not supported, or disabled */
diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index 34c5360c6705..34be7bf51731 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -38,7 +38,7 @@ WEAK(memset)
 	or a1, a3, a1
 	slli a3, a1, 16
 	or a1, a3, a1
-#ifdef CONFIG_64BIT
+#if __riscv_xlen == 64
 	slli a3, a1, 32
 	or a1, a3, a1
 #endif
@@ -58,7 +58,7 @@ WEAK(memset)
 	/* Jump into loop body */
 	/* Assumes 32-bit instruction lengths */
 	la a5, 3f
-#ifdef CONFIG_64BIT
+#if __riscv_xlen == 64
 	srli a4, a4, 1
 #endif
 	add a5, a5, a4
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 6ea2cce4cc17..3d410dad28f8 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -28,7 +28,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	bust_spinlocks(1);
 
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
-		addr);
+		(xlen_t)addr);
 
 	bust_spinlocks(0);
 	die(regs, "Oops");
-- 
2.36.1



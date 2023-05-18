Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35750708260
	for <lists+linux-arch@lfdr.de>; Thu, 18 May 2023 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjERNN5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 May 2023 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjERNNY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2023 09:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8741FC2;
        Thu, 18 May 2023 06:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3215F64F4B;
        Thu, 18 May 2023 13:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2BDC433A8;
        Thu, 18 May 2023 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684415504;
        bh=mUvKPYb9kXtM63DkJk8xrIjB0iU3kTZ7V5k0fuwWhWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAVh1Lb9pxkCaMxZsXlZjAaOVNnfqMWUypTw/mgPxDp9wVkFSJW6yeudTgDzuMXBW
         rPf1VbQ2MTu83fXUaDZGGUcG7JJZqO5GEHXzAgTcCd6/ggG6/o4OqMArG2ljWbg5Hc
         /xFFvQXmcLVINwx/6dxrg14W3ygTEtRFCTH3oYG4JzNw4T27EvjWN1P4B+LhXImH4k
         /R1yTD73cP7CCmTUFLr70LBufwduUHhgw1LNnl9tLm2vhRatVIsiITYFu2Lg6FMsrK
         Kmw1Cy84gm+j2XEE+84BPl7E/dTXxh2AdUGHQ5Hb9ijeSKhexzX1IHdX0ss61BODgq
         fn8eV3L8pojZA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        paul.walmsley@sifive.com, catalin.marinas@arm.com, will@kernel.org,
        rppt@kernel.org, anup@brainfault.org, shihua@iscas.ac.cn,
        jiawei@iscas.ac.cn, liweiwei@iscas.ac.cn, luxufan@iscas.ac.cn,
        chunyu@iscas.ac.cn, tsu.yubo@gmail.com, wefu@redhat.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, corbet@lwn.net, wuwei2016@iscas.ac.cn,
        jrtc27@jrtc27.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 05/22] riscv: s64ilp32: Introduce xlen_t
Date:   Thu, 18 May 2023 09:09:56 -0400
Message-Id: <20230518131013.3366406-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230518131013.3366406-1-guoren@kernel.org>
References: <20230518131013.3366406-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When s64ilp32 landed, we couldn't use CONFIG_64/32BIT to distingue XLEN
data types. Because the xlen is 64, but the long & pointer is 32 for
s64ilp32, and s64ilp32 is a 32BIT from the software view. So introduce a
new data type - "xlen_t" and use __riscv_xlen instead of CONFIG_64/32BIT
ifdef macro.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/csr.h       | 58 ++++++++++--------
 arch/riscv/include/asm/processor.h |  8 +--
 arch/riscv/include/asm/ptrace.h    | 96 +++++++++++++++---------------
 arch/riscv/include/asm/timex.h     | 10 ++--
 arch/riscv/kernel/cpufeature.c     |  4 +-
 arch/riscv/kernel/process.c        |  4 +-
 arch/riscv/kernel/signal.c         |  6 +-
 arch/riscv/kernel/traps.c          |  4 +-
 arch/riscv/lib/memset.S            |  4 +-
 arch/riscv/mm/fault.c              |  2 +-
 10 files changed, 104 insertions(+), 92 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 7c2b8cdb7b77..adc3c866d353 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -30,37 +30,41 @@
 #define SR_XS_CLEAN	_AC(0x00010000, UL)
 #define SR_XS_DIRTY	_AC(0x00018000, UL)
 
-#ifndef CONFIG_64BIT
+#if __riscv_xlen == 32
 #define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, ULL) /* FS/XS dirty */
 #endif
 
-#ifdef CONFIG_64BIT
-#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
-#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
-#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
+#if __riscv_xlen == 64
+#define SR_UXL		_AC(0x300000000, ULL) /* XLEN mask for U-mode */
+#define SR_UXL_32	_AC(0x100000000, ULL) /* XLEN = 32 for U-mode */
+#define SR_UXL_64	_AC(0x200000000, ULL) /* XLEN = 64 for U-mode */
 #endif
 
 /* SATP flags */
-#ifndef CONFIG_64BIT
+#if __riscv_xlen == 32
 #define SATP_PPN	_AC(0x003FFFFF, UL)
 #define SATP_MODE_32	_AC(0x80000000, UL)
 #define SATP_ASID_BITS	9
 #define SATP_ASID_SHIFT	22
 #define SATP_ASID_MASK	_AC(0x1FF, UL)
 #else
-#define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
-#define SATP_MODE_39	_AC(0x8000000000000000, UL)
-#define SATP_MODE_48	_AC(0x9000000000000000, UL)
-#define SATP_MODE_57	_AC(0xa000000000000000, UL)
+#define SATP_PPN	_AC(0x00000FFFFFFFFFFF, ULL)
+#define SATP_MODE_39	_AC(0x8000000000000000, ULL)
+#define SATP_MODE_48	_AC(0x9000000000000000, ULL)
+#define SATP_MODE_57	_AC(0xa000000000000000, ULL)
 #define SATP_ASID_BITS	16
 #define SATP_ASID_SHIFT	44
-#define SATP_ASID_MASK	_AC(0xFFFF, UL)
+#define SATP_ASID_MASK	_AC(0xFFFF, ULL)
 #endif
 
 /* Exception cause high bit - is an interrupt if set */
+#if __riscv_xlen == 32
 #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
+#else
+#define CAUSE_IRQ_FLAG		(_AC(1, ULL) << (__riscv_xlen - 1))
+#endif
 
 /* Interrupt causes (minus the high bit) */
 #define IRQ_S_SOFT		1
@@ -103,8 +107,8 @@
 #define PMP_L			0x80
 
 /* HSTATUS flags */
-#ifdef CONFIG_64BIT
-#define HSTATUS_VSXL		_AC(0x300000000, UL)
+#if __riscv_xlen == 64
+#define HSTATUS_VSXL		_AC(0x300000000, ULL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
 #define HSTATUS_VTSR		_AC(0x00400000, UL)
@@ -132,12 +136,12 @@
 
 #define HGATP64_MODE_SHIFT	60
 #define HGATP64_VMID_SHIFT	44
-#define HGATP64_VMID_MASK	_AC(0x03FFF00000000000, UL)
-#define HGATP64_PPN		_AC(0x00000FFFFFFFFFFF, UL)
+#define HGATP64_VMID_MASK	_AC(0x03FFF00000000000, ULL)
+#define HGATP64_PPN		_AC(0x00000FFFFFFFFFFF, ULL)
 
 #define HGATP_PAGE_SHIFT	12
 
-#ifdef CONFIG_64BIT
+#if __riscv_xlen == 64
 #define HGATP_PPN		HGATP64_PPN
 #define HGATP_VMID_SHIFT	HGATP64_VMID_SHIFT
 #define HGATP_VMID_MASK		HGATP64_VMID_MASK
@@ -342,9 +346,15 @@
 
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
@@ -353,7 +363,7 @@
 
 #define csr_read(csr)						\
 ({								\
-	register unsigned long __v;				\
+	register xlen_t __v;					\
 	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
 			      : "=r" (__v) :			\
 			      : "memory");			\
@@ -362,7 +372,7 @@
 
 #define csr_write(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
@@ -370,7 +380,7 @@
 
 #define csr_read_set(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrs %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -379,7 +389,7 @@
 
 #define csr_set(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrs " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
@@ -387,7 +397,7 @@
 
 #define csr_read_clear(csr, val)				\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrc %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -396,7 +406,7 @@
 
 #define csr_clear(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrc " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 94a0590c6971..829000d6de94 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -36,10 +36,10 @@ struct thread_struct {
 	/* Callee-saved registers */
 	unsigned long ra;
 	unsigned long sp;	/* Kernel mode stack */
-	unsigned long s[12];	/* s[0]: frame pointer */
+	xlen_t     s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
-};
+} __attribute__((__aligned__(sizeof(xlen_t))));
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
@@ -57,8 +57,8 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
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
index d6a7428f6248..b610819c7ff4 100644
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
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 52585e088873..5de6418b7588 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -126,10 +126,10 @@ void __init riscv_fill_hwcap(void)
 		}
 
 		temp = isa;
-#if IS_ENABLED(CONFIG_32BIT)
+#if IS_ENABLED(CONFIG_32BIT) && !IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 		if (!strncmp(isa, "rv32", 4))
 			isa += 4;
-#elif IS_ENABLED(CONFIG_64BIT)
+#else
 		if (!strncmp(isa, "rv64", 4))
 			isa += 4;
 #endif
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e2a060066730..ab01b51a5bb9 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -45,8 +45,8 @@ void __show_regs(struct pt_regs *regs)
 	show_regs_print_info(KERN_DEFAULT);
 
 	if (!user_mode(regs)) {
-		pr_cont("epc : %pS\n", (void *)regs->epc);
-		pr_cont(" ra : %pS\n", (void *)regs->ra);
+		pr_cont("epc : %pS\n", (void *)(ulong)regs->epc);
+		pr_cont(" ra : %pS\n", (void *)(ulong)regs->ra);
 	}
 
 	pr_cont("epc : " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 2e365084417e..f142a9eeec36 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -109,7 +109,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	frame = (struct rt_sigframe __user *)regs->sp;
+	frame = (struct rt_sigframe __user *)kernel_stack_pointer(regs);
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
@@ -135,7 +135,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 		pr_info_ratelimited(
 			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
 			task->comm, task_pid_nr(task), __func__,
-			frame, (void *)regs->epc, (void *)regs->sp);
+			frame,
+			(void *)instruction_pointer(regs),
+			(void *)kernel_stack_pointer(regs));
 	}
 	force_sig(SIGSEGV);
 	return 0;
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8c258b78c925..efc6b649985a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -98,7 +98,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
-			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+			tsk->comm, task_pid_nr(tsk), signo, code, (xlen_t)addr);
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
@@ -236,7 +236,7 @@ void handle_break(struct pt_regs *regs)
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)instruction_pointer(regs));
 #ifdef CONFIG_KGDB
 	else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTRAP)
 								== NOTIFY_STOP)
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
index 3aba72ec1742..1b0bd0683766 100644
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


Return-Path: <linux-arch+bounces-7791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A3993BEC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 02:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A52832F1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F883AD5A;
	Tue,  8 Oct 2024 00:47:46 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438829A5;
	Tue,  8 Oct 2024 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348466; cv=none; b=aIDDsUi14AlwWrhARf968cldXjkMVgnfIE0N3TBm2LXdvGejp95rPtM3WkMLDNKz2W6MQnGRdVKgrJhG+50XJJ5hS9O8+G6YDbV0wW5FHza6blcXjwHYiu0laOoQxB2N3qFoygAfu+VvHtUVttCNPvhd7ZR0zV36SWGe5v9ARuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348466; c=relaxed/simple;
	bh=5L8cBzTEqY6a5Mko+kPIn3K9XB4ritUszfTkHkumXvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UpQBckZwJYlnea7Ymv+6r3HWJEf83mZkSelow4YV0RbLI7yAjuVtOEpeUBJ9nkhrHpLgaboCiu+avOWSMTr9XXRarSpRQ2OjCmMFt5Rell1wFPt76HFZcyStGO7+40SeGCLMG1xIhiw8DeJ+3A0y65lLVBfDJydrKG3zWu1MIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCCEC4CEC6;
	Tue,  8 Oct 2024 00:47:41 +0000 (UTC)
Date: Mon, 7 Oct 2024 20:47:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <20241007204743.41314f1d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

ftrace_regs was created to hold registers that store information to save
function parameters, return value and stack. Since it is a subset of
pt_regs, it should only be used by its accessor functions. But because
pt_regs can easily be taken from ftrace_regs (on most archs), it is
tempting to use it directly. But when running on other architectures, it
may fail to build or worse, build but crash the kernel!

Instead, make struct ftrace_regs an empty structure and have the
architectures define __arch_ftrace_regs and all the accessor functions
will typecast to it to get to the actual fields. This will help avoid
usage of ftrace_regs directly.

Link: https://lore.kernel.org/all/20241007171027.629bdafd@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I tried to cros-compile the affected architectures,
but my builds failed for 32 bit powerpc and s390 (without this patch).
It mostly compiled, and the affected files seemed to build.

 arch/arm64/include/asm/ftrace.h          | 20 +++++++++--------
 arch/arm64/kernel/asm-offsets.c          | 22 +++++++++----------
 arch/arm64/kernel/ftrace.c               | 10 ++++-----
 arch/loongarch/include/asm/ftrace.h      | 22 ++++++++++---------
 arch/loongarch/kernel/ftrace_dyn.c       |  2 +-
 arch/powerpc/include/asm/ftrace.h        | 21 ++++++++++--------
 arch/powerpc/kernel/trace/ftrace.c       |  4 ++--
 arch/powerpc/kernel/trace/ftrace_64_pg.c |  2 +-
 arch/riscv/include/asm/ftrace.h          | 21 ++++++++++--------
 arch/riscv/kernel/asm-offsets.c          | 28 ++++++++++++------------
 arch/riscv/kernel/ftrace.c               |  2 +-
 arch/s390/include/asm/ftrace.h           | 23 ++++++++++---------
 arch/s390/kernel/asm-offsets.c           |  4 ++--
 arch/s390/kernel/ftrace.c                |  2 +-
 arch/s390/lib/test_unwind.c              |  4 ++--
 arch/x86/include/asm/ftrace.h            | 25 +++++++++++----------
 arch/x86/kernel/ftrace.c                 |  2 +-
 include/asm-generic/ftrace.h             | 13 +++++++++++
 include/linux/ftrace.h                   | 10 +++++----
 kernel/trace/ftrace.c                    |  2 +-
 20 files changed, 135 insertions(+), 104 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dc9cf0bd2a4c..bbb69c7751b9 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -56,6 +56,8 @@ unsigned long ftrace_call_adjust(unsigned long addr);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 struct dyn_ftrace;
 struct ftrace_ops;
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
 
 #define arch_ftrace_get_regs(regs) NULL
 
@@ -63,7 +65,7 @@ struct ftrace_ops;
  * Note: sizeof(struct ftrace_regs) must be a multiple of 16 to ensure correct
  * stack alignment
  */
-struct ftrace_regs {
+struct __arch_ftrace_regs {
 	/* x0 - x8 */
 	unsigned long regs[9];
 
@@ -83,47 +85,47 @@ struct ftrace_regs {
 static __always_inline unsigned long
 ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
 {
-	return fregs->pc;
+	return arch_ftrace_regs(fregs)->pc;
 }
 
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long pc)
 {
-	fregs->pc = pc;
+	arch_ftrace_regs(fregs)->pc = pc;
 }
 
 static __always_inline unsigned long
 ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
 {
-	return fregs->sp;
+	return arch_ftrace_regs(fregs)->sp;
 }
 
 static __always_inline unsigned long
 ftrace_regs_get_argument(struct ftrace_regs *fregs, unsigned int n)
 {
 	if (n < 8)
-		return fregs->regs[n];
+		return arch_ftrace_regs(fregs)->regs[n];
 	return 0;
 }
 
 static __always_inline unsigned long
 ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
 {
-	return fregs->regs[0];
+	return arch_ftrace_regs(fregs)->regs[0];
 }
 
 static __always_inline void
 ftrace_regs_set_return_value(struct ftrace_regs *fregs,
 			     unsigned long ret)
 {
-	fregs->regs[0] = ret;
+	arch_ftrace_regs(fregs)->regs[0] = ret;
 }
 
 static __always_inline void
 ftrace_override_function_with_return(struct ftrace_regs *fregs)
 {
-	fregs->pc = fregs->lr;
+	arch_ftrace_regs(fregs)->pc = arch_ftrace_regs(fregs)->lr;
 }
 
 int ftrace_regs_query_register_offset(const char *name);
@@ -143,7 +145,7 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 	 * The ftrace trampoline will return to this address instead of the
 	 * instrumented function.
 	 */
-	fregs->direct_tramp = addr;
+	arch_ftrace_regs(fregs)->direct_tramp = addr;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 27de1dddb0ab..a5de57f68219 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -84,19 +84,19 @@ int main(void)
   DEFINE(PT_REGS_SIZE,		sizeof(struct pt_regs));
   BLANK();
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
-  DEFINE(FREGS_X0,		offsetof(struct ftrace_regs, regs[0]));
-  DEFINE(FREGS_X2,		offsetof(struct ftrace_regs, regs[2]));
-  DEFINE(FREGS_X4,		offsetof(struct ftrace_regs, regs[4]));
-  DEFINE(FREGS_X6,		offsetof(struct ftrace_regs, regs[6]));
-  DEFINE(FREGS_X8,		offsetof(struct ftrace_regs, regs[8]));
-  DEFINE(FREGS_FP,		offsetof(struct ftrace_regs, fp));
-  DEFINE(FREGS_LR,		offsetof(struct ftrace_regs, lr));
-  DEFINE(FREGS_SP,		offsetof(struct ftrace_regs, sp));
-  DEFINE(FREGS_PC,		offsetof(struct ftrace_regs, pc));
+  DEFINE(FREGS_X0,		offsetof(struct __arch_ftrace_regs, regs[0]));
+  DEFINE(FREGS_X2,		offsetof(struct __arch_ftrace_regs, regs[2]));
+  DEFINE(FREGS_X4,		offsetof(struct __arch_ftrace_regs, regs[4]));
+  DEFINE(FREGS_X6,		offsetof(struct __arch_ftrace_regs, regs[6]));
+  DEFINE(FREGS_X8,		offsetof(struct __arch_ftrace_regs, regs[8]));
+  DEFINE(FREGS_FP,		offsetof(struct __arch_ftrace_regs, fp));
+  DEFINE(FREGS_LR,		offsetof(struct __arch_ftrace_regs, lr));
+  DEFINE(FREGS_SP,		offsetof(struct __arch_ftrace_regs, sp));
+  DEFINE(FREGS_PC,		offsetof(struct __arch_ftrace_regs, pc));
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-  DEFINE(FREGS_DIRECT_TRAMP,	offsetof(struct ftrace_regs, direct_tramp));
+  DEFINE(FREGS_DIRECT_TRAMP,	offsetof(struct __arch_ftrace_regs, direct_tramp));
 #endif
-  DEFINE(FREGS_SIZE,		sizeof(struct ftrace_regs));
+  DEFINE(FREGS_SIZE,		sizeof(struct __arch_ftrace_regs));
   BLANK();
 #endif
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..b2d947175cbe 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -23,10 +23,10 @@ struct fregs_offset {
 	int offset;
 };
 
-#define FREGS_OFFSET(n, field)				\
-{							\
-	.name = n,					\
-	.offset = offsetof(struct ftrace_regs, field),	\
+#define FREGS_OFFSET(n, field)					\
+{								\
+	.name = n,						\
+	.offset = offsetof(struct __arch_ftrace_regs, field),	\
 }
 
 static const struct fregs_offset fregs_offsets[] = {
@@ -481,7 +481,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(ip, &fregs->lr, fregs->fp);
+	prepare_ftrace_return(ip, &arch_ftrace_regs(fregs)->lr, arch_ftrace_regs(fregs)->fp);
 }
 #else
 /*
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index c0a682808e07..0e15d36ce251 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -43,38 +43,40 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent);
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_ops;
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
 
-struct ftrace_regs {
+struct __arch_ftrace_regs {
 	struct pt_regs regs;
 };
 
 static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
-	return &fregs->regs;
+	return &arch_ftrace_regs(fregs)->regs;
 }
 
 static __always_inline unsigned long
 ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
 {
-	return instruction_pointer(&fregs->regs);
+	return instruction_pointer(&arch_ftrace_regs(fregs)->regs);
 }
 
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 {
-	instruction_pointer_set(&fregs->regs, ip);
+	instruction_pointer_set(&arch_ftrace_regs(fregs)->regs, ip);
 }
 
 #define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&(fregs)->regs, n)
+	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&(fregs)->regs)
+	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_return_value(fregs) \
-	regs_return_value(&(fregs)->regs)
+	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&(fregs)->regs, ret)
+	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
 #define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&(fregs)->regs)
+	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
@@ -90,7 +92,7 @@ __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
 }
 
 #define arch_ftrace_set_direct_caller(fregs, addr) \
-	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
+	__arch_ftrace_set_direct_caller(&arch_ftrace_regs(fregs)->regs, addr)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #endif
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index bff058317062..18056229e22e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -241,7 +241,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = &fregs->regs;
+	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 	unsigned long *parent = (unsigned long *)&regs->regs[1];
 
 	prepare_ftrace_return(ip, (unsigned long *)parent);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 559560286e6d..e299fd47d201 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -32,39 +32,42 @@ struct dyn_arch_ftrace {
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
 
-struct ftrace_regs {
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
+
+struct __arch_ftrace_regs {
 	struct pt_regs regs;
 };
 
 static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	/* We clear regs.msr in ftrace_call */
-	return fregs->regs.msr ? &fregs->regs : NULL;
+	return arch_ftrace_regs(fregs)->regs.msr ? &arch_ftrace_regs(fregs)->regs : NULL;
 }
 
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
 {
-	regs_set_return_ip(&fregs->regs, ip);
+	regs_set_return_ip(&arch_ftrace_regs(fregs)->regs, ip);
 }
 
 static __always_inline unsigned long
 ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
 {
-	return instruction_pointer(&fregs->regs);
+	return instruction_pointer(&arch_ftrace_regs(fregs)->regs);
 }
 
 #define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&(fregs)->regs, n)
+	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&(fregs)->regs)
+	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_return_value(fregs) \
-	regs_return_value(&(fregs)->regs)
+	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&(fregs)->regs, ret)
+	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
 #define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&(fregs)->regs)
+	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index d8d6b4fd9a14..df41f4a7c738 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -421,7 +421,7 @@ int __init ftrace_dyn_arch_init(void)
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	unsigned long sp = fregs->regs.gpr[1];
+	unsigned long sp = arch_ftrace_regs(fregs)->regs.gpr[1];
 	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -439,6 +439,6 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 
 	ftrace_test_recursion_unlock(bit);
 out:
-	fregs->regs.link = parent_ip;
+	arch_ftrace_regs(fregs)->regs.link = parent_ip;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 12fab1803bcf..d3c5552e4984 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -829,7 +829,7 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	fregs->regs.link = __prepare_ftrace_return(parent_ip, ip, fregs->regs.gpr[1]);
+	arch_ftrace_regs(fregs)->regs.link = __prepare_ftrace_return(parent_ip, ip, arch_ftrace_regs(fregs)->regs.gpr[1]);
 }
 #else
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2cddd79ff21b..c6bcdff105b5 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -126,7 +126,10 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 #define arch_ftrace_get_regs(regs) NULL
 struct ftrace_ops;
-struct ftrace_regs {
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
+
+struct __arch_ftrace_regs {
 	unsigned long epc;
 	unsigned long ra;
 	unsigned long sp;
@@ -150,42 +153,42 @@ struct ftrace_regs {
 static __always_inline unsigned long ftrace_regs_get_instruction_pointer(const struct ftrace_regs
 									 *fregs)
 {
-	return fregs->epc;
+	return arch_ftrace_regs(fregs)->epc;
 }
 
 static __always_inline void ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 								unsigned long pc)
 {
-	fregs->epc = pc;
+	arch_ftrace_regs(fregs)->epc = pc;
 }
 
 static __always_inline unsigned long ftrace_regs_get_stack_pointer(const struct ftrace_regs *fregs)
 {
-	return fregs->sp;
+	return arch_ftrace_regs(fregs)->sp;
 }
 
 static __always_inline unsigned long ftrace_regs_get_argument(struct ftrace_regs *fregs,
 							      unsigned int n)
 {
 	if (n < 8)
-		return fregs->args[n];
+		return arch_ftrace_regs(fregs)->args[n];
 	return 0;
 }
 
 static __always_inline unsigned long ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
 {
-	return fregs->a0;
+	return arch_ftrace_regs(fregs)->a0;
 }
 
 static __always_inline void ftrace_regs_set_return_value(struct ftrace_regs *fregs,
 							 unsigned long ret)
 {
-	fregs->a0 = ret;
+	arch_ftrace_regs(fregs)->a0 = ret;
 }
 
 static __always_inline void ftrace_override_function_with_return(struct ftrace_regs *fregs)
 {
-	fregs->epc = fregs->ra;
+	arch_ftrace_regs(fregs)->epc = arch_ftrace_regs(fregs)->ra;
 }
 
 int ftrace_regs_query_register_offset(const char *name);
@@ -196,7 +199,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 
 static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
-	fregs->t1 = addr;
+	arch_ftrace_regs(fregs)->t1 = addr;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index e94180ba432f..f6f5a277ba9d 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -498,19 +498,19 @@ void asm_offsets(void)
 	OFFSET(STACKFRAME_RA, stackframe, ra);
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
-	DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct ftrace_regs), STACK_ALIGN));
-	DEFINE(FREGS_EPC,	    offsetof(struct ftrace_regs, epc));
-	DEFINE(FREGS_RA,	    offsetof(struct ftrace_regs, ra));
-	DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
-	DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
-	DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
-	DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
-	DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
-	DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
-	DEFINE(FREGS_A3,	    offsetof(struct ftrace_regs, a3));
-	DEFINE(FREGS_A4,	    offsetof(struct ftrace_regs, a4));
-	DEFINE(FREGS_A5,	    offsetof(struct ftrace_regs, a5));
-	DEFINE(FREGS_A6,	    offsetof(struct ftrace_regs, a6));
-	DEFINE(FREGS_A7,	    offsetof(struct ftrace_regs, a7));
+	DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct __arch_ftrace_regs), STACK_ALIGN));
+	DEFINE(FREGS_EPC,	    offsetof(struct __arch_ftrace_regs, epc));
+	DEFINE(FREGS_RA,	    offsetof(struct __arch_ftrace_regs, ra));
+	DEFINE(FREGS_SP,	    offsetof(struct __arch_ftrace_regs, sp));
+	DEFINE(FREGS_S0,	    offsetof(struct __arch_ftrace_regs, s0));
+	DEFINE(FREGS_T1,	    offsetof(struct __arch_ftrace_regs, t1));
+	DEFINE(FREGS_A0,	    offsetof(struct __arch_ftrace_regs, a0));
+	DEFINE(FREGS_A1,	    offsetof(struct __arch_ftrace_regs, a1));
+	DEFINE(FREGS_A2,	    offsetof(struct __arch_ftrace_regs, a2));
+	DEFINE(FREGS_A3,	    offsetof(struct __arch_ftrace_regs, a3));
+	DEFINE(FREGS_A4,	    offsetof(struct __arch_ftrace_regs, a4));
+	DEFINE(FREGS_A5,	    offsetof(struct __arch_ftrace_regs, a5));
+	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
+	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
 }
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4b95c574fd04..5081ad886841 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -214,7 +214,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
+	prepare_ftrace_return(&arch_ftrace_regs(fregs)->ra, ip, arch_ftrace_regs(fregs)->s0);
 }
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 extern void ftrace_graph_call(void);
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 406746666eb7..1498d0a9c762 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -51,13 +51,16 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
-struct ftrace_regs {
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
+
+struct __arch_ftrace_regs {
 	struct pt_regs regs;
 };
 
 static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = &fregs->regs;
+	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 
 	if (test_pt_regs_flag(regs, PIF_FTRACE_FULL_REGS))
 		return regs;
@@ -84,26 +87,26 @@ static __always_inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph
 static __always_inline unsigned long
 ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
 {
-	return fregs->regs.psw.addr;
+	return arch_ftrace_regs(fregs)->regs.psw.addr;
 }
 
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
 {
-	fregs->regs.psw.addr = ip;
+	arch_ftrace_regs(fregs)->regs.psw.addr = ip;
 }
 
 #define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&(fregs)->regs, n)
+	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&(fregs)->regs)
+	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_return_value(fregs) \
-	regs_return_value(&(fregs)->regs)
+	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&(fregs)->regs, ret)
+	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
 #define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&(fregs)->regs)
+	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
@@ -117,7 +120,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
  */
 static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
-	struct pt_regs *regs = &fregs->regs;
+	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 	regs->orig_gpr2 = addr;
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 5529248d84fb..db9659980175 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -184,8 +184,8 @@ int main(void)
 	OFFSET(__FGRAPH_RET_FP, fgraph_ret_regs, fp);
 	DEFINE(__FGRAPH_RET_SIZE, sizeof(struct fgraph_ret_regs));
 #endif
-	OFFSET(__FTRACE_REGS_PT_REGS, ftrace_regs, regs);
-	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct ftrace_regs));
+	OFFSET(__FTRACE_REGS_PT_REGS, __arch_ftrace_regs, regs);
+	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct __arch_ftrace_regs));
 
 	OFFSET(__PCPU_FLAGS, pcpu, flags);
 	return 0;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 0b6e62d1d8b8..51439a71e392 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -318,7 +318,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
-	kmsan_unpoison_memory(fregs, sizeof(*fregs));
+	kmsan_unpoison_memory(fregs, ftrace_regs_size());
 	regs = ftrace_get_regs(fregs);
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (!regs || unlikely(!p) || kprobe_disabled(p))
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 8b7f981e6f34..6e42100875e7 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -270,9 +270,9 @@ static void notrace __used test_unwind_ftrace_handler(unsigned long ip,
 						      struct ftrace_ops *fops,
 						      struct ftrace_regs *fregs)
 {
-	struct unwindme *u = (struct unwindme *)fregs->regs.gprs[2];
+	struct unwindme *u = (struct unwindme *)arch_ftrace_regs(fregs)->regs.gprs[2];
 
-	u->ret = test_unwind(NULL, (u->flags & UWM_REGS) ? &fregs->regs : NULL,
+	u->ret = test_unwind(NULL, (u->flags & UWM_REGS) ? &arch_ftrace_regs(fregs)->regs : NULL,
 			     (u->flags & UWM_SP) ? u->sp : 0);
 }
 
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0152a81d9b4a..87943f7a299b 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -33,7 +33,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 }
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-struct ftrace_regs {
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
+
+struct __arch_ftrace_regs {
 	struct pt_regs		regs;
 };
 
@@ -41,27 +44,27 @@ static __always_inline struct pt_regs *
 arch_ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	/* Only when FL_SAVE_REGS is set, cs will be non zero */
-	if (!fregs->regs.cs)
+	if (!arch_ftrace_regs(fregs)->regs.cs)
 		return NULL;
-	return &fregs->regs;
+	return &arch_ftrace_regs(fregs)->regs;
 }
 
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
-	do { (fregs)->regs.ip = (_ip); } while (0)
+	do { arch_ftrace_regs(fregs)->regs.ip = (_ip); } while (0)
 
 #define ftrace_regs_get_instruction_pointer(fregs) \
-	((fregs)->regs.ip)
+	arch_ftrace_regs(fregs)->regs.ip)
 
 #define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(&(fregs)->regs, n)
+	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(&(fregs)->regs)
+	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_return_value(fregs) \
-	regs_return_value(&(fregs)->regs)
+	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(&(fregs)->regs, ret)
+	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
 #define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(&(fregs)->regs)
+	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
@@ -88,7 +91,7 @@ __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
 	regs->orig_ax = addr;
 }
 #define arch_ftrace_set_direct_caller(fregs, addr) \
-	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
+	__arch_ftrace_set_direct_caller(&arch_ftrace_regs(fregs)->regs, addr)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8da0e66ca22d..adb09f78edb2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -647,7 +647,7 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = &fregs->regs;
+	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
 
 	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
diff --git a/include/asm-generic/ftrace.h b/include/asm-generic/ftrace.h
index 3a23028d69d2..ba7b7d6e55d6 100644
--- a/include/asm-generic/ftrace.h
+++ b/include/asm-generic/ftrace.h
@@ -10,4 +10,17 @@
  * common definitions are already in linux/ftrace.h.
  */
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+struct __arch_ftrace_regs {
+	struct pt_regs		regs;
+};
+
+#define arch_ftrace_get_regs(fregs)					\
+	({ struct __arch_fregs_regs *__f = (struct __arch_ftrace_regs *)(fregs); \
+		&__f->regs;						\
+	})
+
+struct ftrace_regs;
+#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
+
 #endif /* __ASM_GENERIC_FTRACE_H__ */
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2ac3b3b53cd0..3547016f2f87 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -115,8 +115,6 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 
 extern int ftrace_enabled;
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-
 /**
  * ftrace_regs - ftrace partial/optimal register set
  *
@@ -142,12 +140,16 @@ extern int ftrace_enabled;
  *
  * NOTE: user *must not* access regs directly, only do it via APIs, because
  * the member can be changed according to the architecture.
+ * This is why the structure is empty here, so that nothing accesses
+ * the ftrace_regs directly.
  */
 struct ftrace_regs {
-	struct pt_regs		regs;
+	/* Nothing to see here, use the accessor functions! */
 };
-#define arch_ftrace_get_regs(fregs) (&(fregs)->regs)
 
+#define ftrace_regs_size()	sizeof(struct __arch_ftrace_regs)
+
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 /*
  * ftrace_regs_set_instruction_pointer() is to be defined by the architecture
  * if to allow setting of the instruction pointer from the ftrace_regs when
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5d87dac83b80..1e6251174530 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7944,7 +7944,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 			       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	kmsan_unpoison_memory(fregs, sizeof(*fregs));
+	kmsan_unpoison_memory(fregs, ftrace_regs_size());
 	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
 }
 #else
-- 
2.45.2



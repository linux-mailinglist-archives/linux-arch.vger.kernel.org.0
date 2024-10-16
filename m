Return-Path: <linux-arch+bounces-8200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF699FD7A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8240C280D3F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 00:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0467A0D;
	Wed, 16 Oct 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuWCM74h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E6327726;
	Wed, 16 Oct 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040299; cv=none; b=JC6nR8sRe0lA2AH70uhehuZOTTttGQXIeOdIPOE5WWBiyTAPY00ZiTQrdIhDdEfrAxL3GDaVL5SuWL/3EhUXB6SHgdg0mcuz12kDPd+sLqwvC+Z3UBrbM7LUQb+ET+YJbGuPwgJ3s2IAbcjpuChEfzKnoPG05yYE/CqfSsEwCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040299; c=relaxed/simple;
	bh=KFhz0/gwhk/vMmxYGDOXjkM2Mk3hJ3ckibPY6ND3S5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BI+z4e/yQpRSaNB9FsFjVppQvnrcUCwj4GGmqqeUpT7fTkmENAGMvIDJJVV5YYXLbsXWtYMkjMVejKdLIpcHtkYgN9rH09T2DK7PxVmel/SlEui2nKNPWioEvP0j34R59RN1zjSa4ormVsovl8NJcS+q2YoWHt4/gGtZ7UMRgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuWCM74h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F520C4CECD;
	Wed, 16 Oct 2024 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040299;
	bh=KFhz0/gwhk/vMmxYGDOXjkM2Mk3hJ3ckibPY6ND3S5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuWCM74hy5r+7yqfuTv8/UO76FkiZkGGeivDZmuCUL7wJSHlge5L/lNz3gfBGe+xc
	 HkIT9+d+DruYolqgoLCxQ3yMjH9M8vKyD/ePFs+kPHUGT8YgjZJ/MI72e+9NgOs3xM
	 SKG+SZ7s7zgYENmPFolZmTu+MMwIt47eF4/72OYdffLr6LkbPNSHjY/mMwjRfascJX
	 X7ce47EyVy9gvmBP/n5GRR3FLKHah39ltHyeDJ6EmzLTlOt2tjsxo6/1XRU8aN/tkz
	 8zdoccJ51+uD7Nc7jUq1GSyh7hwk9qOLGyQ1rH0ejsTooceBI9QaRxo6xkjZ+XPSgM
	 eWjFdhvuB/gkQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v17 02/16] function_graph: Replace fgraph_ret_regs with ftrace_regs
Date: Wed, 16 Oct 2024 09:58:09 +0900
Message-ID: <172904028952.36809.12123402713602405457.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172904026427.36809.516716204730117800.stgit@devnote2>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use ftrace_regs instead of fgraph_ret_regs for tracing return value
on function_graph tracer because of simplifying the callback interface.

The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
CONFIG_HAVE_FUNCTION_GRAPH_FREGS.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 Changes in v17:
  - Fixes s390 return_to_handler according to Heiko's advice.
 Changes in v16:
  - According to the recent ftrace_regs.h change, override
    ftrace_regs_get_frame_pointer() if needed.
  - s390: keep stack_frame on stack, just replace fgraph_ret_regs
    with ftrace_regs.
 Changes in v8:
  - Newly added.
---
 arch/arm64/Kconfig                  |    1 +
 arch/arm64/include/asm/ftrace.h     |   23 ++++++-----------------
 arch/arm64/kernel/asm-offsets.c     |   12 ------------
 arch/arm64/kernel/entry-ftrace.S    |   32 ++++++++++++++++++--------------
 arch/loongarch/Kconfig              |    2 +-
 arch/loongarch/include/asm/ftrace.h |   26 ++++----------------------
 arch/loongarch/kernel/asm-offsets.c |   12 ------------
 arch/loongarch/kernel/mcount.S      |   17 ++++++++++-------
 arch/loongarch/kernel/mcount_dyn.S  |   14 +++++++-------
 arch/riscv/Kconfig                  |    2 +-
 arch/riscv/include/asm/ftrace.h     |   26 +++++---------------------
 arch/riscv/kernel/mcount.S          |   24 +++++++++++++-----------
 arch/s390/Kconfig                   |    2 +-
 arch/s390/include/asm/ftrace.h      |   24 +++++++-----------------
 arch/s390/kernel/asm-offsets.c      |    6 ------
 arch/s390/kernel/mcount.S           |   12 ++++++------
 arch/x86/Kconfig                    |    2 +-
 arch/x86/include/asm/ftrace.h       |   20 --------------------
 arch/x86/kernel/ftrace_32.S         |   15 +++++++++------
 arch/x86/kernel/ftrace_64.S         |   17 +++++++++--------
 include/linux/ftrace.h              |   12 +++++++++---
 include/linux/ftrace_regs.h         |    2 ++
 kernel/trace/Kconfig                |    4 ++--
 kernel/trace/fgraph.c               |   21 +++++++++------------
 24 files changed, 121 insertions(+), 207 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e29b44d2d7b..9a654bbcc350 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -215,6 +215,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL
 	select HAVE_GCC_PLUGINS
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5ccff4de7f09..b5fa57b61378 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -129,6 +129,12 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
 	arch_ftrace_regs(fregs)->pc = arch_ftrace_regs(fregs)->lr;
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->fp;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
@@ -186,23 +192,6 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-struct fgraph_ret_regs {
-	/* x0 - x7 */
-	unsigned long regs[8];
-
-	unsigned long fp;
-	unsigned long __unused;
-};
-
-static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->regs[0];
-}
-
-static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->fp;
-}
 
 void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 			   unsigned long frame_pointer);
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index a5de57f68219..66011aaf0a0a 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -201,18 +201,6 @@ int main(void)
   DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
 #endif
   BLANK();
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-  DEFINE(FGRET_REGS_X0,			offsetof(struct fgraph_ret_regs, regs[0]));
-  DEFINE(FGRET_REGS_X1,			offsetof(struct fgraph_ret_regs, regs[1]));
-  DEFINE(FGRET_REGS_X2,			offsetof(struct fgraph_ret_regs, regs[2]));
-  DEFINE(FGRET_REGS_X3,			offsetof(struct fgraph_ret_regs, regs[3]));
-  DEFINE(FGRET_REGS_X4,			offsetof(struct fgraph_ret_regs, regs[4]));
-  DEFINE(FGRET_REGS_X5,			offsetof(struct fgraph_ret_regs, regs[5]));
-  DEFINE(FGRET_REGS_X6,			offsetof(struct fgraph_ret_regs, regs[6]));
-  DEFINE(FGRET_REGS_X7,			offsetof(struct fgraph_ret_regs, regs[7]));
-  DEFINE(FGRET_REGS_FP,			offsetof(struct fgraph_ret_regs, fp));
-  DEFINE(FGRET_REGS_SIZE,		sizeof(struct fgraph_ret_regs));
-#endif
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
   DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
 #endif
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index f0c16640ef21..169ccf600066 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -329,24 +329,28 @@ SYM_FUNC_END(ftrace_stub_graph)
  * @fp is checked against the value passed by ftrace_graph_caller().
  */
 SYM_CODE_START(return_to_handler)
-	/* save return value regs */
-	sub sp, sp, #FGRET_REGS_SIZE
-	stp x0, x1, [sp, #FGRET_REGS_X0]
-	stp x2, x3, [sp, #FGRET_REGS_X2]
-	stp x4, x5, [sp, #FGRET_REGS_X4]
-	stp x6, x7, [sp, #FGRET_REGS_X6]
-	str x29,    [sp, #FGRET_REGS_FP]	// parent's fp
+	/* Make room for ftrace_regs */
+	sub	sp, sp, #FREGS_SIZE
+
+	/* Save return value regs */
+	stp	x0, x1, [sp, #FREGS_X0]
+	stp	x2, x3, [sp, #FREGS_X2]
+	stp	x4, x5, [sp, #FREGS_X4]
+	stp	x6, x7, [sp, #FREGS_X6]
+
+	/* Save the callsite's FP */
+	str	x29, [sp, #FREGS_FP]
 
 	mov	x0, sp
-	bl	ftrace_return_to_handler	// addr = ftrace_return_to_hander(regs);
+	bl	ftrace_return_to_handler	// addr = ftrace_return_to_hander(fregs);
 	mov	x30, x0				// restore the original return address
 
-	/* restore return value regs */
-	ldp x0, x1, [sp, #FGRET_REGS_X0]
-	ldp x2, x3, [sp, #FGRET_REGS_X2]
-	ldp x4, x5, [sp, #FGRET_REGS_X4]
-	ldp x6, x7, [sp, #FGRET_REGS_X6]
-	add sp, sp, #FGRET_REGS_SIZE
+	/* Restore return value regs */
+	ldp	x0, x1, [sp, #FREGS_X0]
+	ldp	x2, x3, [sp, #FREGS_X2]
+	ldp	x4, x5, [sp, #FREGS_X4]
+	ldp	x6, x7, [sp, #FREGS_X6]
+	add	sp, sp, #FREGS_SIZE
 
 	ret
 SYM_CODE_END(return_to_handler)
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index bb35c34f86d2..73466c9947f6 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -135,7 +135,7 @@ config LOONGARCH
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 8f13eaeaa325..ceb3e3d9c0d3 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -57,6 +57,10 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 	instruction_pointer_set(&arch_ftrace_regs(fregs)->regs, ip);
 }
 
+#undef ftrace_regs_get_frame_pointer
+#define ftrace_regs_get_frame_pointer(fregs) \
+	(arch_ftrace_regs(fregs)->regs.regs[22])
+
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
@@ -78,26 +82,4 @@ __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-struct fgraph_ret_regs {
-	/* a0 - a1 */
-	unsigned long regs[2];
-
-	unsigned long fp;
-	unsigned long __unused;
-};
-
-static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->regs[0];
-}
-
-static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->fp;
-}
-#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
-#endif
-
 #endif /* _ASM_LOONGARCH_FTRACE_H */
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index bee9f7a3108f..714f5b5f1956 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -279,18 +279,6 @@ static void __used output_pbe_defines(void)
 }
 #endif
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-static void __used output_fgraph_ret_regs_defines(void)
-{
-	COMMENT("LoongArch fgraph_ret_regs offsets.");
-	OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
-	OFFSET(FGRET_REGS_A1, fgraph_ret_regs, regs[1]);
-	OFFSET(FGRET_REGS_FP, fgraph_ret_regs, fp);
-	DEFINE(FGRET_REGS_SIZE, sizeof(struct fgraph_ret_regs));
-	BLANK();
-}
-#endif
-
 static void __used output_kvm_defines(void)
 {
 	COMMENT("KVM/LoongArch Specific offsets.");
diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
index 3015896016a0..b6850503e061 100644
--- a/arch/loongarch/kernel/mcount.S
+++ b/arch/loongarch/kernel/mcount.S
@@ -79,10 +79,11 @@ SYM_FUNC_START(ftrace_graph_caller)
 SYM_FUNC_END(ftrace_graph_caller)
 
 SYM_FUNC_START(return_to_handler)
-	PTR_ADDI	sp, sp, -FGRET_REGS_SIZE
-	PTR_S		a0, sp, FGRET_REGS_A0
-	PTR_S		a1, sp, FGRET_REGS_A1
-	PTR_S		zero, sp, FGRET_REGS_FP
+	/* Save return value regs */
+	PTR_ADDI	sp, sp, -PT_SIZE
+	PTR_S		a0, sp, PT_R4
+	PTR_S		a1, sp, PT_R5
+	PTR_S		zero, sp, PT_R22
 
 	move		a0, sp
 	bl		ftrace_return_to_handler
@@ -90,9 +91,11 @@ SYM_FUNC_START(return_to_handler)
 	/* Restore the real parent address: a0 -> ra */
 	move		ra, a0
 
-	PTR_L		a0, sp, FGRET_REGS_A0
-	PTR_L		a1, sp, FGRET_REGS_A1
-	PTR_ADDI	sp, sp, FGRET_REGS_SIZE
+	/* Restore return value regs */
+	PTR_L		a0, sp, PT_R4
+	PTR_L		a1, sp, PT_R5
+	PTR_ADDI	sp, sp, PT_SIZE
+
 	jr		ra
 SYM_FUNC_END(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index 0c65cf09110c..d6b474ad1d5e 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -140,19 +140,19 @@ SYM_CODE_END(ftrace_graph_caller)
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	/* Save return value regs */
-	PTR_ADDI	sp, sp, -FGRET_REGS_SIZE
-	PTR_S		a0, sp, FGRET_REGS_A0
-	PTR_S		a1, sp, FGRET_REGS_A1
-	PTR_S		zero, sp, FGRET_REGS_FP
+	PTR_ADDI	sp, sp, -PT_SIZE
+	PTR_S		a0, sp, PT_R4
+	PTR_S		a1, sp, PT_R5
+	PTR_S		zero, sp, PT_R22
 
 	move		a0, sp
 	bl		ftrace_return_to_handler
 	move		ra, a0
 
 	/* Restore return value regs */
-	PTR_L		a0, sp, FGRET_REGS_A0
-	PTR_L		a1, sp, FGRET_REGS_A1
-	PTR_ADDI	sp, sp, FGRET_REGS_SIZE
+	PTR_L		a0, sp, PT_R4
+	PTR_L		a1, sp, PT_R5
+	PTR_ADDI	sp, sp, PT_SIZE
 
 	jr		ra
 SYM_CODE_END(return_to_handler)
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22dc5ea4196c..851486fc935a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -144,7 +144,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_GUP_FAST if MMU
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 3d66437a1029..9372f8d7036f 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -168,6 +168,11 @@ static __always_inline unsigned long ftrace_regs_get_stack_pointer(const struct
 	return arch_ftrace_regs(fregs)->sp;
 }
 
+static __always_inline unsigned long ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->s0;
+}
+
 static __always_inline unsigned long ftrace_regs_get_argument(struct ftrace_regs *fregs,
 							      unsigned int n)
 {
@@ -208,25 +213,4 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsi
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-struct fgraph_ret_regs {
-	unsigned long a1;
-	unsigned long a0;
-	unsigned long s0;
-	unsigned long ra;
-};
-
-static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->a0;
-}
-
-static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->s0;
-}
-#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
-#endif
-
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index 3a42f6287909..068168046e0e 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -12,6 +12,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
 
+#define ABI_SIZE_ON_STACK	80
+
 	.text
 
 	.macro SAVE_ABI_STATE
@@ -26,12 +28,12 @@
 	 * register if a0 was not saved.
 	 */
 	.macro SAVE_RET_ABI_STATE
-	addi	sp, sp, -4*SZREG
-	REG_S	s0, 2*SZREG(sp)
-	REG_S	ra, 3*SZREG(sp)
-	REG_S	a0, 1*SZREG(sp)
-	REG_S	a1, 0*SZREG(sp)
-	addi	s0, sp, 4*SZREG
+	addi	sp, sp, -ABI_SIZE_ON_STACK
+	REG_S	ra, 1*SZREG(sp)
+	REG_S	s0, 8*SZREG(sp)
+	REG_S	a0, 10*SZREG(sp)
+	REG_S	a1, 11*SZREG(sp)
+	addi	s0, sp, ABI_SIZE_ON_STACK
 	.endm
 
 	.macro RESTORE_ABI_STATE
@@ -41,11 +43,11 @@
 	.endm
 
 	.macro RESTORE_RET_ABI_STATE
-	REG_L	ra, 3*SZREG(sp)
-	REG_L	s0, 2*SZREG(sp)
-	REG_L	a0, 1*SZREG(sp)
-	REG_L	a1, 0*SZREG(sp)
-	addi	sp, sp, 4*SZREG
+	REG_L	ra, 1*SZREG(sp)
+	REG_L	s0, 8*SZREG(sp)
+	REG_L	a0, 10*SZREG(sp)
+	REG_L	a1, 11*SZREG(sp)
+	addi	sp, sp, ABI_SIZE_ON_STACK
 	.endm
 
 SYM_TYPED_FUNC_START(ftrace_stub)
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d339fe4fdedf..112e83601ed5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -184,7 +184,7 @@ config S390
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_RETVAL
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index fc97d75dc752..5c94c1fc1bc1 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -62,23 +62,6 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return NULL;
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-struct fgraph_ret_regs {
-	unsigned long gpr2;
-	unsigned long fp;
-};
-
-static __always_inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->gpr2;
-}
-
-static __always_inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->fp;
-}
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
@@ -86,6 +69,13 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	arch_ftrace_regs(fregs)->regs.psw.addr = ip;
 }
 
+#undef ftrace_regs_get_frame_pointer
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
+{
+	return ftrace_regs_get_stack_pointer(fregs);
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index db9659980175..be82fd8c1414 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -178,12 +178,6 @@ int main(void)
 	DEFINE(OLDMEM_SIZE, PARMAREA + offsetof(struct parmarea, oldmem_size));
 	DEFINE(COMMAND_LINE, PARMAREA + offsetof(struct parmarea, command_line));
 	DEFINE(MAX_COMMAND_LINE_SIZE, PARMAREA + offsetof(struct parmarea, max_command_line_size));
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/* function graph return value tracing */
-	OFFSET(__FGRAPH_RET_GPR2, fgraph_ret_regs, gpr2);
-	OFFSET(__FGRAPH_RET_FP, fgraph_ret_regs, fp);
-	DEFINE(__FGRAPH_RET_SIZE, sizeof(struct fgraph_ret_regs));
-#endif
 	OFFSET(__FTRACE_REGS_PT_REGS, __arch_ftrace_regs, regs);
 	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct __arch_ftrace_regs));
 
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 7e267ef63a7f..2b628aa3d809 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -134,14 +134,14 @@ SYM_CODE_END(ftrace_common)
 SYM_FUNC_START(return_to_handler)
 	stmg	%r2,%r5,32(%r15)
 	lgr	%r1,%r15
-	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
+	# allocate ftrace_regs and stack frame for ftrace_return_to_handler
+	aghi	%r15,-STACK_FRAME_SIZE_FREGS
 	stg	%r1,__SF_BACKCHAIN(%r15)
-	la	%r3,STACK_FRAME_OVERHEAD(%r15)
-	stg	%r1,__FGRAPH_RET_FP(%r3)
-	stg	%r2,__FGRAPH_RET_GPR2(%r3)
-	lgr	%r2,%r3
+	stg	%r2,(STACK_FREGS_PTREGS_GPRS+2*8)(%r15)
+	stg	%r1,(STACK_FREGS_PTREGS_GPRS+15*8)(%r15)
+	la	%r2,STACK_FRAME_OVERHEAD(%r15)
 	brasl	%r14,ftrace_return_to_handler
-	aghi	%r15,STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE
+	aghi	%r15,STACK_FRAME_SIZE_FREGS
 	lgr	%r14,%r2
 	lmg	%r2,%r5,32(%r15)
 	BR_EX	%r14
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..2697ebbfce8d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -232,7 +232,7 @@ config X86
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 8f02d28c571a..2160d11945ce 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -132,24 +132,4 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 #endif /* !COMPILE_OFFSETS */
 #endif /* !__ASSEMBLY__ */
 
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-struct fgraph_ret_regs {
-	unsigned long ax;
-	unsigned long dx;
-	unsigned long bp;
-};
-
-static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->ax;
-}
-
-static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
-{
-	return ret_regs->bp;
-}
-#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
-#endif
-
 #endif /* _ASM_X86_FTRACE_H */
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 58d9ed50fe61..4b265884d06c 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -23,6 +23,8 @@ SYM_FUNC_START(__fentry__)
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
+#define FRAME_SIZE	PT_OLDSS+4
+
 SYM_CODE_START(ftrace_caller)
 
 #ifdef CONFIG_FRAME_POINTER
@@ -187,14 +189,15 @@ SYM_CODE_END(ftrace_graph_caller)
 
 .globl return_to_handler
 return_to_handler:
-	pushl	$0
-	pushl	%edx
-	pushl	%eax
+	subl	$(FRAME_SIZE), %esp
+	movl	$0, PT_EBP(%esp)
+	movl	%edx, PT_EDX(%esp)
+	movl	%eax, PT_EAX(%esp)
 	movl	%esp, %eax
 	call	ftrace_return_to_handler
 	movl	%eax, %ecx
-	popl	%eax
-	popl	%edx
-	addl	$4, %esp		# skip ebp
+	movl	%eax, PT_EAX(%esp)
+	movl	%edx, PT_EDX(%esp)
+	addl	$(FRAME_SIZE), %esp
 	JMP_NOSPEC ecx
 #endif
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 214f30e9f0c0..d51647228596 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -348,21 +348,22 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
-	subq  $24, %rsp
 
-	/* Save the return values */
-	movq %rax, (%rsp)
-	movq %rdx, 8(%rsp)
-	movq %rbp, 16(%rsp)
+	/* Save ftrace_regs for function exit context  */
+	subq $(FRAME_SIZE), %rsp
+
+	movq %rax, RAX(%rsp)
+	movq %rdx, RDX(%rsp)
+	movq %rbp, RBP(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
 
 	movq %rax, %rdi
-	movq 8(%rsp), %rdx
-	movq (%rsp), %rax
+	movq RDX(%rsp), %rdx
+	movq RAX(%rsp), %rax
 
-	addq $24, %rsp
+	addq $(FRAME_SIZE), %rsp
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
 	 * since IBT would demand that contain ENDBR, which simply isn't so for
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c86ac786da3d..069f270bd7ae 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -43,9 +43,8 @@ struct dyn_ftrace;
 
 char *arch_ftrace_match_adjust(char *str, const char *search);
 
-#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
-struct fgraph_ret_regs;
-unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs);
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+unsigned long ftrace_return_to_handler(struct ftrace_regs *fregs);
 #else
 unsigned long ftrace_return_to_handler(unsigned long frame_pointer);
 #endif
@@ -134,6 +133,13 @@ extern int ftrace_enabled;
  * Also, architecture dependent fields can be used for internal process.
  * (e.g. orig_ax on x86_64)
  *
+ * Basically, ftrace_regs stores the registers related to the context.
+ * On function entry, registers for function parameters and hooking the
+ * function call are stored, and on function exit, registers for function
+ * return value and frame pointers are stored.
+ *
+ * And also, it dpends on the context that which registers are restored
+ * from the ftrace_regs.
  * On the function entry, those registers will be restored except for
  * the stack pointer, so that user can change the function parameters
  * and instruction pointer (e.g. live patching.)
diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index be1ed0c891d0..bbc1873ca6b8 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -30,6 +30,8 @@ struct ftrace_regs;
 	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
+#define ftrace_regs_get_frame_pointer(fregs) \
+	frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
 #endif /* HAVE_ARCH_FTRACE_REGS */
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 74c2b1d43bb9..c5ab2a561272 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -31,7 +31,7 @@ config HAVE_FUNCTION_GRAPH_TRACER
 	help
 	  See Documentation/trace/ftrace-design.rst
 
-config HAVE_FUNCTION_GRAPH_RETVAL
+config HAVE_FUNCTION_GRAPH_FREGS
 	bool
 
 config HAVE_DYNAMIC_FTRACE
@@ -232,7 +232,7 @@ config FUNCTION_GRAPH_TRACER
 
 config FUNCTION_GRAPH_RETVAL
 	bool "Kernel Function Graph Return Value"
-	depends on HAVE_FUNCTION_GRAPH_RETVAL
+	depends on HAVE_FUNCTION_GRAPH_FREGS
 	depends on FUNCTION_GRAPH_TRACER
 	default n
 	help
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 3eda5880f883..0ba336b79ee0 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -793,15 +793,12 @@ static struct notifier_block ftrace_suspend_notifier = {
 	.notifier_call = ftrace_suspend_notifier_call,
 };
 
-/* fgraph_ret_regs is not defined without CONFIG_FUNCTION_GRAPH_RETVAL */
-struct fgraph_ret_regs;
-
 /*
  * Send the trace to the ring-buffer.
  * @return the original return address.
  */
-static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
-						unsigned long frame_pointer)
+static inline unsigned long
+__ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointer)
 {
 	struct ftrace_ret_stack *ret_stack;
 	struct ftrace_graph_ret trace;
@@ -821,7 +818,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 
 	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
-	trace.retval = fgraph_ret_regs_return_value(ret_regs);
+	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
 
 	bitmap = get_bitmap_bits(current, offset);
@@ -856,14 +853,14 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 }
 
 /*
- * After all architecures have selected HAVE_FUNCTION_GRAPH_RETVAL, we can
- * leave only ftrace_return_to_handler(ret_regs).
+ * After all architecures have selected HAVE_FUNCTION_GRAPH_FREGS, we can
+ * leave only ftrace_return_to_handler(fregs).
  */
-#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
-unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs)
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
+unsigned long ftrace_return_to_handler(struct ftrace_regs *fregs)
 {
-	return __ftrace_return_to_handler(ret_regs,
-				fgraph_ret_regs_frame_pointer(ret_regs));
+	return __ftrace_return_to_handler(fregs,
+				ftrace_regs_get_frame_pointer(fregs));
 }
 #else
 unsigned long ftrace_return_to_handler(unsigned long frame_pointer)



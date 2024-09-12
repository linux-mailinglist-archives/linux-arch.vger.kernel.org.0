Return-Path: <linux-arch+bounces-7234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482DD976D17
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 17:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C54281F47
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A601BAEF0;
	Thu, 12 Sep 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS+IwNhm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37944C6F;
	Thu, 12 Sep 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153737; cv=none; b=Ale6h2+IYBNjbL4676lo+hbOy/SLbgNUv8CjCaZsEFeID1uph+ZzxVvrV4HMHQrpJHI0hy/vDstwLBjI3Uyo97w0aHOKGJj5fliMt9V3uJFTJzvzEI6BIav81u+WByDd3yuNdgk9EnEJC7dkGgxnE3MliWwAltRArzF6Y5k/7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153737; c=relaxed/simple;
	bh=HhPN7RjQTXX8R0LtIoFIwgzy1EbSoWqdfIIS5LlGmyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCTInjg+Uql0WpYsWiq4jXYn4bXBZvyc3HHg5MECWhKqWl3FXUaf3ogBOQ96eC8XDDeqnDc55XHV50BWtYykmVj7qGORJD2+aJVoIhF35Lwx+Ko4f+FJN5tGXoqLtAl1CHRRkXRiyRnTkxu5A70vKUBWzNCDNPdD/ycUK5RiSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS+IwNhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9824DC4CEC3;
	Thu, 12 Sep 2024 15:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726153737;
	bh=HhPN7RjQTXX8R0LtIoFIwgzy1EbSoWqdfIIS5LlGmyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VS+IwNhmBh1X0Pl0G91x6HfI313DKiscYBsEByGIsw6zmNHoVtgS5rJ9ImJhQZTg1
	 PEjtonr1sj3lERKdzUAIBLiA70In/scQmHRwhPmVaB15R6SdgBR3YJoXd+LKnp/fRB
	 fDfyS/3WsOMwIj0ObgeC351ogdBE37wqJ9BZuV1ttOGoSPEZZdixJkM/XJopSYKH4z
	 ni/qHF4rEKIRE/64o0985W97C++tPnucHmJiONCbKmgad7BsYHBFJu/hp2rIVeiLGl
	 ikaORtumfUIHlpRT0nkuL9DZcaFDPRqS2o7G9wraeWHnRyckuwgXiUQKtqwsDDhpO0
	 Z5qHhiK+fQtZw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with ftrace_regs
Date: Fri, 13 Sep 2024 00:08:51 +0900
Message-Id: <172615373091.133222.1812791604518973124.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172615368656.133222.2336770908714920670.stgit@devnote2>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
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
---
 Changes in v8:
  - Newly added.
---
 arch/arm64/Kconfig                  |    1 +
 arch/arm64/include/asm/ftrace.h     |   23 ++++++-----------------
 arch/arm64/kernel/asm-offsets.c     |   12 ------------
 arch/arm64/kernel/entry-ftrace.S    |   32 ++++++++++++++++++--------------
 arch/loongarch/Kconfig              |    2 +-
 arch/loongarch/include/asm/ftrace.h |   24 ++----------------------
 arch/loongarch/kernel/asm-offsets.c |   12 ------------
 arch/loongarch/kernel/mcount.S      |   17 ++++++++++-------
 arch/loongarch/kernel/mcount_dyn.S  |   14 +++++++-------
 arch/riscv/Kconfig                  |    2 +-
 arch/riscv/include/asm/ftrace.h     |   26 +++++---------------------
 arch/riscv/kernel/mcount.S          |   24 +++++++++++++-----------
 arch/s390/Kconfig                   |    2 +-
 arch/s390/include/asm/ftrace.h      |   26 +++++++++-----------------
 arch/s390/kernel/asm-offsets.c      |    6 ------
 arch/s390/kernel/mcount.S           |    9 +++++----
 arch/x86/Kconfig                    |    2 +-
 arch/x86/include/asm/ftrace.h       |   22 ++--------------------
 arch/x86/kernel/ftrace_32.S         |   15 +++++++++------
 arch/x86/kernel/ftrace_64.S         |   17 +++++++++--------
 include/linux/ftrace.h              |   14 +++++++++++---
 kernel/trace/Kconfig                |    4 ++--
 kernel/trace/fgraph.c               |   21 +++++++++------------
 23 files changed, 122 insertions(+), 205 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..17947f625b06 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -211,6 +211,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_RETVAL
 	select HAVE_GCC_PLUGINS
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dc9cf0bd2a4c..dffaab3dd1f1 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -126,6 +126,12 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
 	fregs->pc = fregs->lr;
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->fp;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
@@ -183,23 +189,6 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 
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
index 27de1dddb0ab..9e03c9a7e5c3 100644
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
index 70f169210b52..974f08f65f63 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -131,7 +131,7 @@ config LOONGARCH
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
-	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 6f8517d59954..1a73f35ea9af 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -77,6 +77,8 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 	override_function_with_return(&(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
+#define ftrace_regs_get_frame_pointer(fregs) \
+	((fregs)->regs.regs[22])
 
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
@@ -99,26 +101,4 @@ __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
 
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
index 0f3cd7c3a436..6e8422269ba4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -140,7 +140,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_GUP_FAST if MMU
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2cddd79ff21b..e9f364ce9fe8 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -164,6 +164,11 @@ static __always_inline unsigned long ftrace_regs_get_stack_pointer(const struct
 	return fregs->sp;
 }
 
+static __always_inline unsigned long ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->s0;
+}
+
 static __always_inline unsigned long ftrace_regs_get_argument(struct ftrace_regs *fregs,
 							      unsigned int n)
 {
@@ -204,25 +209,4 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsi
 
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
index a822f952f64a..12e942cfbcde 100644
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
index de76c21eb4a3..9cdd48a46bf7 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -49,23 +49,6 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
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
 static __always_inline unsigned long
 ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
 {
@@ -92,6 +75,15 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
+{
+	unsigned long *sp;
+
+	sp = (void *)ftrace_regs_get_stack_pointer(fregs);
+	return sp[0];	/* return backchain */
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index ffa0dd2dbaac..d38ed80615d5 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -179,12 +179,6 @@ int main(void)
 	DEFINE(OLDMEM_SIZE, PARMAREA + offsetof(struct parmarea, oldmem_size));
 	DEFINE(COMMAND_LINE, PARMAREA + offsetof(struct parmarea, command_line));
 	DEFINE(MAX_COMMAND_LINE_SIZE, PARMAREA + offsetof(struct parmarea, max_command_line_size));
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/* function graph return value tracing */
-	OFFSET(__FGRAPH_RET_GPR2, fgraph_ret_regs, gpr2);
-	OFFSET(__FGRAPH_RET_FP, fgraph_ret_regs, fp);
-	DEFINE(__FGRAPH_RET_SIZE, sizeof(struct fgraph_ret_regs));
-#endif
 	OFFSET(__FTRACE_REGS_PT_REGS, ftrace_regs, regs);
 	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct ftrace_regs));
 
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index ae4d4fd9afcd..cda798b976de 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -133,14 +133,15 @@ SYM_CODE_END(ftrace_common)
 SYM_FUNC_START(return_to_handler)
 	stmg	%r2,%r5,32(%r15)
 	lgr	%r1,%r15
-	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
+# Allocate ftrace_regs + backchain on the stack
+	aghi	%r15,-STACK_FRAME_SIZE_FREGS
 	stg	%r1,__SF_BACKCHAIN(%r15)
 	la	%r3,STACK_FRAME_OVERHEAD(%r15)
-	stg	%r1,__FGRAPH_RET_FP(%r3)
-	stg	%r2,__FGRAPH_RET_GPR2(%r3)
+	stg	%r2,(__SF_GPRS+2*8)(%r15)
+	stg	%r15,(__SF_GPRS+15*8)(%r15)
 	lgr	%r2,%r3
 	brasl	%r14,ftrace_return_to_handler
-	aghi	%r15,STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE
+	aghi	%r15,STACK_FRAME_SIZE_FREGS
 	lgr	%r14,%r2
 	lmg	%r2,%r5,32(%r15)
 	BR_EX	%r14
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..047384e4d93a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -228,7 +228,7 @@ config X86
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 78f6a200e15b..669771ef3b5b 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -64,6 +64,8 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	override_function_with_return(&(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
+#define ftrace_regs_get_frame_pointer(fregs) \
+	frame_pointer(&(fregs)->regs)
 
 struct ftrace_ops;
 #define ftrace_graph_func ftrace_graph_func
@@ -148,24 +150,4 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
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
index 1fe49a28de2d..13987cd63553 100644
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
@@ -191,6 +197,8 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	override_function_with_return(ftrace_get_regs(fregs))
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
+#define ftrace_regs_get_frame_pointer(fregs) \
+	frame_pointer(&(fregs)->regs)
 #endif
 
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 721c3b221048..ab277eff80dc 100644
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
index 0322c5723748..30bebe43607d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -763,15 +763,12 @@ static struct notifier_block ftrace_suspend_notifier = {
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
@@ -791,7 +788,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 
 	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
-	trace.retval = fgraph_ret_regs_return_value(ret_regs);
+	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
 
 	bitmap = get_bitmap_bits(current, offset);
@@ -826,14 +823,14 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
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



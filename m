Return-Path: <linux-arch+bounces-9330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5FE9EA4BB
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2724287055
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E138197A8F;
	Tue, 10 Dec 2024 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knR6KIIo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02B16DC15;
	Tue, 10 Dec 2024 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796561; cv=none; b=WtYrWOAB5wKFbxJutYtHnFLb1oETokng8Sgwojng10z3DZQ/+XHISBVrOBn0BpCHbyyyuNO2BNc0Vi5ycOi9j5O7vW0uqDx0w0PaiRpv19rXMN7H5bRwmPFhw0lvLXKwsihNwglVNVttKLTEZNRcj6pQJkV7dgpnRBBx+6Vlmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796561; c=relaxed/simple;
	bh=gmSMJ9eAMnCFpuqyiQ8BNhHLZXl5tVzL14+ItV57wNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtLqNkilKau3chYN1lp91tsZXDl1WnI7qUtJp4mRZQO4SMjz6M/laBBQMtQT8m35svCO9Jquz2Uy2WjFNuPiTrEgTaz00mCeDlwIytExtPSu5RqYNHNVxneleqDL3s8Hz+TN9xygLwO62MUx8ngyj0BZjdit3bcbqhZEGQd5X9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knR6KIIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BFAC4CED1;
	Tue, 10 Dec 2024 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796560;
	bh=gmSMJ9eAMnCFpuqyiQ8BNhHLZXl5tVzL14+ItV57wNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=knR6KIIoENC9qw8tx/RRDW2/NLkIsM+dCo0ZMwsPZtHxCRfXBj6IbgIJGkwB3yfcv
	 gXXGZcW74yLZOIRHIX/zl+ZvYPLD9W1tXQiozJNvWHWIJm7QcC71tC83gJ1PGkvrKK
	 WCW60bEi/5aAw6ZWnlMnbeQ4JevJZWt9H22ZIvKHtbjsFt4s2964PfI0x6xTXf4B6F
	 ekn225UC7TANTsfotAyohpLeO/TACL+nxxxfLWnQSFRckLBSZhigSsubdMCOGPulO7
	 17+x4fU/HwmlkIah131RNwUmxC47Nzp2qrSWXX/5CYCgU2P5O8qLAMp4bbrXOh49yj
	 uTXXVrD7edGXw==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v21 02/20] fgraph: Pass ftrace_regs to entryfunc
Date: Tue, 10 Dec 2024 11:09:11 +0900
Message-ID: <173379655082.973433.17251746345055242101.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173379652547.973433.2311391879173461183.stgit@devnote2>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
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

Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
available, it passes a NULL instead. User callback function can access
some registers (including return address) via this ftrace_regs.

Note that the ftrace_regs can be NULL when the arch does NOT define:
HAVE_DYNAMIC_FTRACE_WITH_ARGS or HAVE_DYNAMIC_FTRACE_WITH_REGS.
More specifically, if HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but
not the HAVE_DYNAMIC_FTRACE_WITH_ARGS, and the ftrace ops used to
register the function callback does not set FTRACE_OPS_FL_SAVE_REGS.
In this case, ftrace_regs can be NULL in user callback.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 Changes in v21:
  - Remove ftrace_test_recursion_trylock() from new code.
 Changes in v19:
  - Remove unneeded FTRACE_OPS_FL_SAVE_ARGS from fgraph_ops.
 Changes in v18:
  - Remove unclear comment about `regs->fp` access on arm64.
 Changes in v16:
  - Add a note when the ftrace_regs can be NULL.
  - Update against for the latest kernel.
 Changes in v11:
  - Update for the latest for-next branch.
 Changes in v8:
  - Just pass ftrace_regs to the handler instead of adding a new
    entryregfunc.
  - Update riscv ftrace_graph_func().
 Changes in v3:
  - Update for new multiple fgraph.
---
 arch/arm64/kernel/ftrace.c               |   15 ++++++++++-
 arch/loongarch/kernel/ftrace_dyn.c       |   10 ++++++-
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++---
 arch/riscv/kernel/ftrace.c               |   17 +++++++++++-
 arch/x86/kernel/ftrace.c                 |   42 ++++++++++++++++++++----------
 include/linux/ftrace.h                   |   17 +++++++++---
 kernel/trace/fgraph.c                    |   20 +++++++++-----
 kernel/trace/ftrace.c                    |    3 +-
 kernel/trace/trace.h                     |    3 +-
 kernel/trace/trace_functions_graph.c     |    3 +-
 kernel/trace/trace_irqsoff.c             |    3 +-
 kernel/trace/trace_sched_wakeup.c        |    3 +-
 kernel/trace/trace_selftest.c            |    8 ++++--
 14 files changed, 114 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 245cb419ca24..570c38be833c 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -481,7 +481,20 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(ip, &arch_ftrace_regs(fregs)->lr, arch_ftrace_regs(fregs)->fp);
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long frame_pointer = arch_ftrace_regs(fregs)->fp;
+	unsigned long *parent = &arch_ftrace_regs(fregs)->lr;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+
+	if (!function_graph_enter_regs(old, ip, frame_pointer,
+				       (void *)frame_pointer, fregs)) {
+		*parent = return_hooker;
+	}
 }
 #else
 /*
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 18056229e22e..25c9a4cfd5fa 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -243,8 +243,16 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 {
 	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 	unsigned long *parent = (unsigned long *)&regs->regs[1];
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
 
-	prepare_ftrace_return(ip, (unsigned long *)parent);
+	if (!function_graph_enter_regs(old, ip, 0, parent, fregs))
+		*parent = return_hooker;
 }
 #else
 static int ftrace_modify_graph_caller(bool enable)
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index e41daf2c4a31..2f776f137a89 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -665,7 +665,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 
-	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent_ip, ip, 0, (unsigned long *)sp, fregs))
 		parent_ip = ppc_function_entry(return_to_handler);
 
 out:
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 8fb860b90ae1..ac35015f04c6 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -787,7 +787,8 @@ int ftrace_disable_ftrace_graph_caller(void)
  * in current thread info. Return the address we want to divert to.
  */
 static unsigned long
-__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
+__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp,
+			struct ftrace_regs *fregs)
 {
 	unsigned long return_hooker;
 
@@ -799,7 +800,7 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent, ip, 0, (unsigned long *)sp, fregs))
 		parent = return_hooker;
 
 out:
@@ -810,13 +811,14 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	arch_ftrace_regs(fregs)->regs.link = __prepare_ftrace_return(parent_ip, ip, arch_ftrace_regs(fregs)->regs.gpr[1]);
+	arch_ftrace_regs(fregs)->regs.link = __prepare_ftrace_return(parent_ip, ip,
+						arch_ftrace_regs(fregs)->regs.gpr[1], fregs);
 }
 #else
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip,
 				    unsigned long sp)
 {
-	return __prepare_ftrace_return(parent, ip, sp);
+	return __prepare_ftrace_return(parent, ip, sp, NULL);
 }
 #endif
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 8cb9b211611d..3524db5e4fa0 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -214,7 +214,22 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	prepare_ftrace_return(&arch_ftrace_regs(fregs)->ra, ip, arch_ftrace_regs(fregs)->s0);
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long frame_pointer = arch_ftrace_regs(fregs)->s0;
+	unsigned long *parent = &arch_ftrace_regs(fregs)->ra;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	/*
+	 * We don't suffer access faults, so no extra fault-recovery assembly
+	 * is needed here.
+	 */
+	old = *parent;
+
+	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
+		*parent = return_hooker;
 }
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 extern void ftrace_graph_call(void);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 33f50c80f481..166bc0ea3bdf 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -607,15 +607,8 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE && !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
-/*
- * Hook the return address and push it in the stack of return addrs
- * in current thread info.
- */
-void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
-			   unsigned long frame_pointer)
+static inline bool skip_ftrace_return(void)
 {
-	unsigned long return_hooker = (unsigned long)&return_to_handler;
-
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
 	 * called from early CPU startup code while the CPU is in real mode,
@@ -625,13 +618,27 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	 * This check isn't as accurate as virt_addr_valid(), but it should be
 	 * good enough for this purpose, and it's fast.
 	 */
-	if (unlikely((long)__builtin_frame_address(0) >= 0))
-		return;
+	if ((long)__builtin_frame_address(0) >= 0)
+		return true;
 
-	if (unlikely(ftrace_graph_is_dead()))
-		return;
+	if (ftrace_graph_is_dead())
+		return true;
+
+	if (atomic_read(&current->tracing_graph_pause))
+		return true;
+	return false;
+}
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in current thread info.
+ */
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
 
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	if (!function_graph_enter(*parent, ip, frame_pointer, parent))
@@ -644,8 +651,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 {
 	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long *parent = (unsigned long *)stack;
+
+	if (unlikely(skip_ftrace_return()))
+		return;
+
 
-	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
+	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
+		*parent = return_hooker;
 }
 #endif
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index aa9ddd1e4bb6..c86ac786da3d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1071,10 +1071,12 @@ struct fgraph_ops;
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
 				       struct fgraph_ops *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
-				      struct fgraph_ops *); /* entry */
+				      struct fgraph_ops *,
+				      struct ftrace_regs *); /* entry */
 
 extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-				   struct fgraph_ops *gops);
+				   struct fgraph_ops *gops,
+				   struct ftrace_regs *fregs);
 bool ftrace_pids_enabled(struct ftrace_ops *ops);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -1114,8 +1116,15 @@ struct ftrace_ret_stack {
 extern void return_to_handler(void);
 
 extern int
-function_graph_enter(unsigned long ret, unsigned long func,
-		     unsigned long frame_pointer, unsigned long *retp);
+function_graph_enter_regs(unsigned long ret, unsigned long func,
+			  unsigned long frame_pointer, unsigned long *retp,
+			  struct ftrace_regs *fregs);
+
+static inline int function_graph_enter(unsigned long ret, unsigned long func,
+				       unsigned long fp, unsigned long *retp)
+{
+	return function_graph_enter_regs(ret, func, fp, retp, NULL);
+}
 
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int skip);
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c57540ad384d..1bd406c101f6 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -292,7 +292,8 @@ static inline unsigned long make_data_type_val(int idx, int size, int offset)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
+		     struct ftrace_regs *fregs)
 {
 	return 0;
 }
@@ -520,7 +521,8 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 #endif
 
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops)
+			    struct fgraph_ops *gops,
+			    struct ftrace_regs *fregs)
 {
 	return 0;
 }
@@ -644,8 +646,9 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 #endif
 
 /* If the caller does not use ftrace, call this function. */
-int function_graph_enter(unsigned long ret, unsigned long func,
-			 unsigned long frame_pointer, unsigned long *retp)
+int function_graph_enter_regs(unsigned long ret, unsigned long func,
+			      unsigned long frame_pointer, unsigned long *retp,
+			      struct ftrace_regs *fregs)
 {
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
@@ -668,7 +671,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (static_branch_likely(&fgraph_do_direct)) {
 		int save_curr_ret_stack = current->curr_ret_stack;
 
-		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops, fregs))
 			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
@@ -686,7 +689,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 			save_curr_ret_stack = current->curr_ret_stack;
 			if (ftrace_ops_test(&gops->ops, func, NULL) &&
-			    gops->entryfunc(&trace, gops))
+			    gops->entryfunc(&trace, gops, fregs))
 				bitmap |= BIT(i);
 			else
 				/* Clear out any saved storage */
@@ -1180,7 +1183,8 @@ void ftrace_graph_exit_task(struct task_struct *t)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
-			   struct fgraph_ops *gops)
+			   struct fgraph_ops *gops,
+			   struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = gops->ops.private;
 	int pid;
@@ -1194,7 +1198,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			return 0;
 	}
 
-	return gops->saved_func(trace, gops);
+	return gops->saved_func(trace, gops, fregs);
 }
 
 void fgraph_update_pid_func(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..e04e058faccf 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -827,7 +827,8 @@ struct profile_fgraph_data {
 };
 
 static int profile_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	struct profile_fgraph_data *profile_data;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 266740b4e121..c929c3046593 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -695,7 +695,8 @@ void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
-int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
+int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+		      struct ftrace_regs *fregs);
 
 void tracing_start_cmdline_record(void);
 void tracing_stop_cmdline_record(void);
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 5504b5e4e7b4..b62ad912d84f 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -175,7 +175,8 @@ struct fgraph_times {
 };
 
 int trace_graph_entry(struct ftrace_graph_ent *trace,
-		      struct fgraph_ops *gops)
+		      struct fgraph_ops *gops,
+		      struct ftrace_regs *fregs)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index fce064e20570..ad739d76fc86 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -176,7 +176,8 @@ static int irqsoff_display_graph(struct trace_array *tr, int set)
 }
 
 static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
-			       struct fgraph_ops *gops)
+			       struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index d6c7f18daa15..0d9e1075d815 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -113,7 +113,8 @@ static int wakeup_display_graph(struct trace_array *tr, int set)
 }
 
 static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops)
+			      struct fgraph_ops *gops,
+			      struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 38b5754790c9..f54493f8783d 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -774,7 +774,8 @@ struct fgraph_fixture {
 };
 
 static __init int store_entry(struct ftrace_graph_ent *trace,
-			      struct fgraph_ops *gops)
+			      struct fgraph_ops *gops,
+			      struct ftrace_regs *fregs)
 {
 	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
 	const char *type = fixture->store_type_name;
@@ -1025,7 +1026,8 @@ static unsigned int graph_hang_thresh;
 
 /* Wrap the real function entry probe to avoid possible hanging */
 static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
-				      struct fgraph_ops *gops)
+				      struct fgraph_ops *gops,
+				      struct ftrace_regs *fregs)
 {
 	/* This is harmlessly racy, we want to approximately detect a hang */
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
@@ -1039,7 +1041,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
 		return 0;
 	}
 
-	return trace_graph_entry(trace, gops);
+	return trace_graph_entry(trace, gops, fregs);
 }
 
 static struct fgraph_ops fgraph_ops __initdata  = {



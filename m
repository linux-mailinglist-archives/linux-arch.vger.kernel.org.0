Return-Path: <linux-arch+bounces-9264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C929E61C3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 01:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9069928257D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22F81E;
	Fri,  6 Dec 2024 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvv+APDo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EDA41;
	Fri,  6 Dec 2024 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443757; cv=none; b=AveKRnMKukBCNi4XvV83np0jUUbr4cPzzMbLgFHL7fvtcPCHRp1WDVbsLieCCDp4RwQvd7k9SxxwrmBQgN0XYjRKAMOHnJVfeqEIUBNilUTTc4GijSEuhwViihO40XxD2nNhaCfRUy5I1zU0cvR4ktBmtOXpf5YrR4XGmUNBuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443757; c=relaxed/simple;
	bh=ps8FR3bXyv3Hm+gd3su+GeM+aaasXfR1VVmg66zvie4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBFcReikF2hzPpUh2JPRyEjmHcWCLo+rwkEsk4ZOpQDKz4wrB0gVCMm4P95tAVV+5FF0Wz5wJzPLYdyK8cLQSXPpga6eWpWU+V+8UUF659wL616Lfmdn7mPZh9bPGVikG5GrworQ2ZxJeLQAy5Xn7YHFxbJNfvkzos395FVTRKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvv+APDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684AEC4CED1;
	Fri,  6 Dec 2024 00:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443757;
	bh=ps8FR3bXyv3Hm+gd3su+GeM+aaasXfR1VVmg66zvie4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvv+APDo2uuXLO21WALDGrSt0b4iY40MM0rFymJuEeWh+k4+97mpTB1Blf05Qo0TY
	 v1z1DCWZpPhIDHOgSo5EZAM6e7cRS7zdajBLFVaD1k+QiwizKZRwPpZWcINAfj0eXa
	 M8fjkh/rF/KXOh36j9vvdTKwAdaenmXqJcBkCR8QeBn1fEcaFQ0YQ48lz75NOo3UIb
	 xGkyz+yr6dQqrtOJuyHZgqLvBNFCk3a1axYa90UDjnk1vvjOxPCXk+J5pMcX1ES+jg
	 viMK1sbNLpGD7Va9M4avkFOYE36UjV+AAnaI4tRdlKN0sg33AaXdhBQWKMrpb2zI6M
	 FiSwmabABbtZQ==
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
Subject: [PATCH v20 01/19] fgraph: Pass ftrace_regs to entryfunc
Date: Fri,  6 Dec 2024 09:09:07 +0900
Message-ID: <173344374758.50709.7957430411299778568.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173344373580.50709.5332611753907139634.stgit@devnote2>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
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
 arch/arm64/kernel/ftrace.c               |   15 ++++++++-
 arch/loongarch/kernel/ftrace_dyn.c       |   10 +++++-
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++--
 arch/riscv/kernel/ftrace.c               |   17 ++++++++++
 arch/x86/kernel/ftrace.c                 |   50 +++++++++++++++++++++---------
 include/linux/ftrace.h                   |   17 ++++++++--
 kernel/trace/fgraph.c                    |   20 +++++++-----
 kernel/trace/ftrace.c                    |    3 +-
 kernel/trace/trace.h                     |    3 +-
 kernel/trace/trace_functions_graph.c     |    3 +-
 kernel/trace/trace_irqsoff.c             |    3 +-
 kernel/trace/trace_sched_wakeup.c        |    3 +-
 kernel/trace/trace_selftest.c            |    8 +++--
 14 files changed, 121 insertions(+), 43 deletions(-)

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
index 5ccd791761e8..d588d3173dc6 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -670,7 +670,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		goto out;
 
-	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent_ip, ip, 0, (unsigned long *)sp, fregs))
 		parent_ip = ppc_function_entry(return_to_handler);
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 98787376eb87..c63c4212a50b 100644
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
 	int bit;
@@ -804,7 +805,7 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent, ip, 0, (unsigned long *)sp, fregs))
 		parent = return_hooker;
 
 	ftrace_test_recursion_unlock(bit);
@@ -816,13 +817,14 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
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
index 4dd0ad6c94d6..b3aa27ff981f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -607,16 +607,8 @@ int ftrace_disable_ftrace_graph_caller(void)
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
-	int bit;
-
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
 	 * called from early CPU startup code while the CPU is in real mode,
@@ -626,13 +618,28 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
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
+	int bit;
 
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+	if (unlikely(skip_ftrace_return()))
 		return;
 
 	bit = ftrace_test_recursion_trylock(ip, *parent);
@@ -651,8 +658,21 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 {
 	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
 	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long *parent = (unsigned long *)stack;
+	int bit;
 
-	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
+	if (unlikely(skip_ftrace_return()))
+		return;
+
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+
+	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
+		*parent = return_hooker;
+
+	ftrace_test_recursion_unlock(bit);
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
index 0bf78517b5d4..b2e3df6cce96 100644
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
@@ -663,7 +666,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (static_branch_likely(&fgraph_do_direct)) {
 		int save_curr_ret_stack = current->curr_ret_stack;
 
-		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops, fregs))
 			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
@@ -681,7 +684,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 			save_curr_ret_stack = current->curr_ret_stack;
 			if (ftrace_ops_test(&gops->ops, func, NULL) &&
-			    gops->entryfunc(&trace, gops))
+			    gops->entryfunc(&trace, gops, fregs))
 				bitmap |= BIT(i);
 			else
 				/* Clear out any saved storage */
@@ -1174,7 +1177,8 @@ void ftrace_graph_exit_task(struct task_struct *t)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
-			   struct fgraph_ops *gops)
+			   struct fgraph_ops *gops,
+			   struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = gops->ops.private;
 	int pid;
@@ -1188,7 +1192,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent *trace,
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



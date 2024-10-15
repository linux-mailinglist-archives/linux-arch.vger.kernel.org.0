Return-Path: <linux-arch+bounces-8132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFBD99DB56
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9297C1C212FB
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872981537CE;
	Tue, 15 Oct 2024 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVAakh91"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54068184F;
	Tue, 15 Oct 2024 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955752; cv=none; b=bPW7RvKMvhoBFRzzwziYxI4KLTR2E0TeQiLyy7++BJ1DyvnVQ3IK+MxiDyuuV3NGFi8Tq4fERgcfcYnQTlouqz2YYIiuY9sTJ1A5APBcDkYalYOb8ScmO8oUUIxgU1+3yBBKfFfvd5M0oYwxF++XyUqU0VWtpPwRMLjpbqWNFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955752; c=relaxed/simple;
	bh=Z1Elllya6fSOmS3matFCGZu5BkUlq6W+hZzKKfBTtE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1iEV10GtpenCWRb5mGomDKYpxFEbxE0z1et5Lo4SOvTTm2Wz99+fofKk49eESAv7q8pL5Lz8eR+cksKaODuwpvytPLIIF/BBKGJy69FZaQUomfL8BrrRDxcv2FZx4eFMdqN782/F0TUV1mMrVMzalCS7wN9sUaZHS4BaCK2VVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVAakh91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF805C4CEC3;
	Tue, 15 Oct 2024 01:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728955751;
	bh=Z1Elllya6fSOmS3matFCGZu5BkUlq6W+hZzKKfBTtE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVAakh91CQgIuGTzeMgx5cpllEBwJZ+DGkmrkZOLcN9wJXw6GN5oGdLYq/ex/V+AH
	 GLWos5SVc7l1pVzCCFbbIdDPbOyL1YAvrzjb0Skserf6priAZbhtgZq0rdU1aumMpS
	 RzmazmUu70nDqsXUELjKDiTV4PuU9tE3XO5Ydr65+L6PdHBgGkWvo7R/vUfxmdiQhP
	 8F3TtX0AFF0MPYkHxBlRN1plel4hL68jYOiIFzvI+6613ABE6PBmOknMkqlJCm7Z9z
	 K0KrH0T2TYMuFZRMpWzn8PI8l/qOP6fx/raXftQ0EKa70gIvZGAmEaDY7bUiWq3ZaL
	 bERCpHzvFWimQ==
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
Subject: [PATCH v16 03/18] function_graph: Pass ftrace_regs to entryfunc
Date: Tue, 15 Oct 2024 10:29:03 +0900
Message-ID: <172895574385.107311.11545016809880227635.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172895571278.107311.14000164546881236558.stgit@devnote2>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
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
 arch/arm64/kernel/ftrace.c               |   20 +++++++++++-
 arch/loongarch/kernel/ftrace_dyn.c       |   10 +++++-
 arch/powerpc/kernel/trace/ftrace.c       |    2 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++--
 arch/riscv/kernel/ftrace.c               |   17 ++++++++++
 arch/x86/kernel/ftrace.c                 |   50 +++++++++++++++++++++---------
 include/linux/ftrace.h                   |   17 ++++++++--
 kernel/trace/fgraph.c                    |   25 +++++++++------
 kernel/trace/ftrace.c                    |    3 +-
 kernel/trace/trace.h                     |    3 +-
 kernel/trace/trace_functions_graph.c     |    3 +-
 kernel/trace/trace_irqsoff.c             |    3 +-
 kernel/trace/trace_sched_wakeup.c        |    3 +-
 kernel/trace/trace_selftest.c            |    8 +++--
 14 files changed, 129 insertions(+), 45 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index b2d947175cbe..a5a285f8a7ef 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -481,7 +481,25 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
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
+	/*
+	 * Note:
+	 * No protection against faulting at *parent, which may be seen
+	 * on other archs. It's unlikely on AArch64.
+	 */
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
index df41f4a7c738..c3ec437b530d 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -434,7 +434,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		goto out;
 
-	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent_ip, ip, 0, (unsigned long *)sp, fregs))
 		parent_ip = ppc_function_entry(return_to_handler);
 
 	ftrace_test_recursion_unlock(bit);
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index d3c5552e4984..7964d632d13d 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -800,7 +800,8 @@ int ftrace_disable_ftrace_graph_caller(void)
  * in current thread info. Return the address we want to divert to.
  */
 static unsigned long
-__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
+__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp,
+			struct ftrace_regs *fregs)
 {
 	unsigned long return_hooker;
 	int bit;
@@ -817,7 +818,7 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
+	if (!function_graph_enter_regs(parent, ip, 0, (unsigned long *)sp, fregs))
 		parent = return_hooker;
 
 	ftrace_test_recursion_unlock(bit);
@@ -829,13 +830,14 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
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
index 5081ad886841..d6ebdb5d7537 100644
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
index adb09f78edb2..be224f1c2078 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -605,16 +605,8 @@ int ftrace_disable_ftrace_graph_caller(void)
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
@@ -624,13 +616,28 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
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
@@ -649,8 +656,21 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
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
index ee829d65f301..3eda5880f883 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -290,7 +290,8 @@ static inline unsigned long make_data_type_val(int idx, int size, int offset)
 }
 
 /* ftrace_graph_entry set to this to tell some archs to run function graph */
-static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops)
+static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
+		     struct ftrace_regs *fregs)
 {
 	return 0;
 }
@@ -518,7 +519,8 @@ int __weak ftrace_disable_ftrace_graph_caller(void)
 #endif
 
 int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
-			    struct fgraph_ops *gops)
+			    struct fgraph_ops *gops,
+			    struct ftrace_regs *fregs)
 {
 	return 0;
 }
@@ -642,8 +644,9 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
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
@@ -661,7 +664,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	if (static_branch_likely(&fgraph_do_direct)) {
 		int save_curr_ret_stack = current->curr_ret_stack;
 
-		if (static_call(fgraph_func)(&trace, fgraph_direct_gops))
+		if (static_call(fgraph_func)(&trace, fgraph_direct_gops, fregs))
 			bitmap |= BIT(fgraph_direct_gops->idx);
 		else
 			/* Clear out any saved storage */
@@ -679,7 +682,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 
 			save_curr_ret_stack = current->curr_ret_stack;
 			if (ftrace_ops_test(&gops->ops, func, NULL) &&
-			    gops->entryfunc(&trace, gops))
+			    gops->entryfunc(&trace, gops, fregs))
 				bitmap |= BIT(i);
 			else
 				/* Clear out any saved storage */
@@ -977,7 +980,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 static struct ftrace_ops graph_ops = {
 	.func			= ftrace_graph_func,
-	.flags			= FTRACE_OPS_GRAPH_STUB,
+	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_ARGS,
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
 	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
 	/* trampoline_size is only needed for dynamically allocated tramps */
@@ -987,7 +990,8 @@ static struct ftrace_ops graph_ops = {
 void fgraph_init_ops(struct ftrace_ops *dst_ops,
 		     struct ftrace_ops *src_ops)
 {
-	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
+	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
+			 FTRACE_OPS_FL_SAVE_ARGS;
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (src_ops) {
@@ -1159,7 +1163,8 @@ void ftrace_graph_exit_task(struct task_struct *t)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 static int fgraph_pid_func(struct ftrace_graph_ent *trace,
-			   struct fgraph_ops *gops)
+			   struct fgraph_ops *gops,
+			   struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = gops->ops.private;
 	int pid;
@@ -1173,7 +1178,7 @@ static int fgraph_pid_func(struct ftrace_graph_ent *trace,
 			return 0;
 	}
 
-	return gops->saved_func(trace, gops);
+	return gops->saved_func(trace, gops, fregs);
 }
 
 void fgraph_update_pid_func(void)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e9fd4fb2769e..6346fe37f2f6 100644
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
index ec99b630eb11..c1d4d5a3469c 100644
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
index d3a14ae47e26..137c13de5731 100644
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



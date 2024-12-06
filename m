Return-Path: <linux-arch+bounces-9266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D299E61D0
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 01:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1761884F68
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94F81E;
	Fri,  6 Dec 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQFKM7Qt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3B1DDE9;
	Fri,  6 Dec 2024 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443783; cv=none; b=F6n4Z5GDBgazLnvGxk237Jm+FvuiKVzSv1fEvWpmFkytILdBM3DnXFOxQpwGeLtSuSiqYc15rv16DpivfX0BV3NlwD9lbURcTjZjsol2JthJRQWSFa0z6gw8rLR/hqLG/87Knlt8upCaFPIVtDXSIVzx259/Kmi3z7BVzKpS11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443783; c=relaxed/simple;
	bh=R9u3RaaVcOfIGrFdArJdSGCA9xSYW34wPL6Ct3ZHvAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QObakE1c6GU5L+0oDG3Txus0XgCXyaUGmYnUElGaub6d42Hr218lBI9K12qGsxFNIa3G0Yo44McaJ51yb5D0lZSSUbdIMHPzTwCM1nbrbMG+vy/5Fgn9MCWPjpLJ/98PJC26zmmjHPXnm0VyXAxpneUtVam/9fjBoDlRJr/7KCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQFKM7Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD68C4CED1;
	Fri,  6 Dec 2024 00:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443782;
	bh=R9u3RaaVcOfIGrFdArJdSGCA9xSYW34wPL6Ct3ZHvAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQFKM7QtCRkv2D82d6J5MH56e1sEAjB2XKBI2uLR1d6KxboBj205VGnGddiar9ckT
	 CK7EVOsqPGOpPqxLBCwcbMHqmjLAbacLJLYRD33gRMYykPdslws8o9Zq0GI+P06LaE
	 d1u9VVOdvI0WS9KOQdhStGPS9gUu6lsbVDAmWYPXp9CbvbPVQznauAX0h1dViLFUW+
	 uAhksC2QJw8SU9jRsXeObTTfWen30pg0GTQeGC045g37GrHiBpMosiAyqdiwd73Fxl
	 xW2eIsyWcKY/DXCZ1Phyak9UhzIj3CqCFS6vWzifEyiohkrcqKf/NIFnH0C2MOF3wG
	 H7je9Q1Hx5v6A==
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
	linux-arch@vger.kernel.org
Subject: [PATCH v20 03/19] fgraph: Pass ftrace_regs to retfunc
Date: Fri,  6 Dec 2024 09:09:37 +0900
Message-ID: <173344377737.50709.12314846664287142422.stgit@devnote2>
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

Pass ftrace_regs to the fgraph_ops::retfunc(). If ftrace_regs is not
available, it passes a NULL instead. User callback function can access
some registers (including return address) via this ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Pass ftrace_regs to retfunc, instead of adding retregfunc.
 Changes in v6:
  - update to use ftrace_regs_get_return_value() because of reordering
    patches.
 Changes in v3:
  - Update for new multiple fgraph.
  - Save the return address to instruction pointer in ftrace_regs.
---
 include/linux/ftrace.h               |    3 ++-
 kernel/trace/fgraph.c                |   16 +++++++++++-----
 kernel/trace/ftrace.c                |    3 ++-
 kernel/trace/trace.h                 |    3 ++-
 kernel/trace/trace_functions_graph.c |    7 ++++---
 kernel/trace/trace_irqsoff.c         |    3 ++-
 kernel/trace/trace_sched_wakeup.c    |    3 ++-
 kernel/trace/trace_selftest.c        |    3 ++-
 8 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 069f270bd7ae..9a1e768e47da 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1075,7 +1075,8 @@ struct fgraph_ops;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *,
-				       struct fgraph_ops *); /* return */
+				       struct fgraph_ops *,
+				       struct ftrace_regs *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *,
 				      struct fgraph_ops *,
 				      struct ftrace_regs *); /* entry */
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 126671cd38e5..7f4c2001e382 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -299,7 +299,8 @@ static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
 }
 
 /* ftrace_graph_return set to this to tell some archs to run function graph */
-static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
+static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops,
+		       struct ftrace_regs *fregs)
 {
 }
 
@@ -528,7 +529,8 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
 }
 
 static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
-				  struct fgraph_ops *gops)
+				  struct fgraph_ops *gops,
+				  struct ftrace_regs *fregs)
 {
 }
 
@@ -819,6 +821,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	}
 
 	trace.rettime = trace_clock_local();
+	if (fregs)
+		ftrace_regs_set_instruction_pointer(fregs, ret);
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -828,7 +833,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 #ifdef CONFIG_HAVE_STATIC_CALL
 	if (static_branch_likely(&fgraph_do_direct)) {
 		if (test_bit(fgraph_direct_gops->idx, &bitmap))
-			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops);
+			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
 	} else
 #endif
 	{
@@ -838,7 +843,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 			if (gops == &fgraph_stub)
 				continue;
 
-			gops->retfunc(&trace, gops);
+			gops->retfunc(&trace, gops, fregs);
 		}
 	}
 
@@ -1010,7 +1015,8 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
+		       struct ftrace_regs *fregs);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e04e058faccf..bd2fc0274115 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -850,7 +850,8 @@ static int profile_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void profile_graph_return(struct ftrace_graph_ret *trace,
-				 struct fgraph_ops *gops)
+				 struct fgraph_ops *gops,
+				 struct ftrace_regs *fregs)
 {
 	struct profile_fgraph_data *profile_data;
 	struct ftrace_profile_stat *stat;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c929c3046593..ad9f008d7dd7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -694,7 +694,8 @@ void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
 
-void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+void trace_graph_return(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
+			struct ftrace_regs *fregs);
 int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 		      struct ftrace_regs *fregs);
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index b62ad912d84f..d0e4f412c298 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -315,7 +315,7 @@ static void handle_nosleeptime(struct ftrace_graph_ret *trace,
 }
 
 void trace_graph_return(struct ftrace_graph_ret *trace,
-			struct fgraph_ops *gops)
+			struct fgraph_ops *gops, struct ftrace_regs *fregs)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -355,7 +355,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
-				      struct fgraph_ops *gops)
+				      struct fgraph_ops *gops,
+				      struct ftrace_regs *fregs)
 {
 	struct fgraph_times *ftimes;
 	int size;
@@ -379,7 +380,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	    (trace->rettime - ftimes->calltime < tracing_thresh))
 		return;
 	else
-		trace_graph_return(trace, gops);
+		trace_graph_return(trace, gops, fregs);
 }
 
 static struct fgraph_ops funcgraph_ops = {
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index ad739d76fc86..504de7a05498 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -208,7 +208,8 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
-				 struct fgraph_ops *gops)
+				 struct fgraph_ops *gops,
+				 struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 0d9e1075d815..8165382a174a 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -144,7 +144,8 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 }
 
 static void wakeup_graph_return(struct ftrace_graph_ret *trace,
-				struct fgraph_ops *gops)
+				struct fgraph_ops *gops,
+				struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index f54493f8783d..d88c44f1dfa5 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -808,7 +808,8 @@ static __init int store_entry(struct ftrace_graph_ent *trace,
 }
 
 static __init void store_return(struct ftrace_graph_ret *trace,
-				struct fgraph_ops *gops)
+				struct fgraph_ops *gops,
+				struct ftrace_regs *fregs)
 {
 	struct fgraph_fixture *fixture = container_of(gops, struct fgraph_fixture, gops);
 	const char *type = fixture->store_type_name;



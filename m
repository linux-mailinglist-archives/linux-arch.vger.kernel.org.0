Return-Path: <linux-arch+bounces-8201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FC99FD7D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 02:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE461F2628F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60E132111;
	Wed, 16 Oct 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKhm26qq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A51097B;
	Wed, 16 Oct 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040309; cv=none; b=iy4thIAV02KmEGGTqAiPSt/UYWi4C6+Manxc1me1uHyqF5cWT8uZrDPpLgKqLeXtkPDwHszjab88IylvJ/Igr3GLqIo3qxopkZRavQbIz9pFpjkza9Nex92pucSHRj8GStoxt+Rkd6PbDiFyhcNxsBPeMcl6lPRHY6Jzo2kC60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040309; c=relaxed/simple;
	bh=ZszU1tMnlmpdT3uYMqp+gZZDNb1wsHTYqKFZrVbwztQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9THgoz+D3ABp3SMno/jac7h/UcJ/jc1vBdMsOkP7ymWRGivgm3yDlaGb0F2SVblVEBKaTXmOpivwHsWGATDeZ9j5hk0gDKNZALJuD7ydf5+RavpTYeca7WlgBOqiebIL4gTCySAr+7iEye5cpwYrtkdQ7yaY4cKELweyqGoMPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKhm26qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E474FC4CEC6;
	Wed, 16 Oct 2024 00:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040309;
	bh=ZszU1tMnlmpdT3uYMqp+gZZDNb1wsHTYqKFZrVbwztQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKhm26qq20xl0lamS77Dcwgzr95D1i8LGQ7KSRvergS7tP7dtuICVDWZ5gArPp1BD
	 Wt2sPd5KzGCFQaF3LzkoIiwICk7FMTRt/xBnfNpYexUzKnPQp6JlEJKIM/eG0NElmk
	 n76Dcpq6YdD1iRoz5C8/rES5Fa396lEYMRGSZvLKQKnb7/b/uHOti7oYqMvM7OyP9c
	 25byd50l0mvD/msU4R1NfG/2IzIBKgT5g8grEZKxuFlP5b3W21PenpGNq/aSJ+K2d/
	 sF/Wa+oc8FhANM0mqAMOkZsYIS11ORz/qSR14G+Qdz/ut8Ulkq6CaAb+07S43AAXf8
	 ReKufPQxcxr9w==
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
Subject: [PATCH v17 03/16] function_graph: Pass ftrace_regs to retfunc
Date: Wed, 16 Oct 2024 09:58:24 +0900
Message-ID: <172904030406.36809.4818690266137301771.stgit@devnote2>
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
index 0ba336b79ee0..c11663405ade 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -297,7 +297,8 @@ static int entry_run(struct ftrace_graph_ent *trace, struct fgraph_ops *ops,
 }
 
 /* ftrace_graph_return set to this to tell some archs to run function graph */
-static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops)
+static void return_run(struct ftrace_graph_ret *trace, struct fgraph_ops *ops,
+		       struct ftrace_regs *fregs)
 {
 }
 
@@ -526,7 +527,8 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace,
 }
 
 static void ftrace_graph_ret_stub(struct ftrace_graph_ret *trace,
-				  struct fgraph_ops *gops)
+				  struct fgraph_ops *gops,
+				  struct ftrace_regs *fregs)
 {
 }
 
@@ -817,6 +819,9 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	}
 
 	trace.rettime = trace_clock_local();
+	if (fregs)
+		ftrace_regs_set_instruction_pointer(fregs, ret);
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -826,7 +831,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 #ifdef CONFIG_HAVE_STATIC_CALL
 	if (static_branch_likely(&fgraph_do_direct)) {
 		if (test_bit(fgraph_direct_gops->idx, &bitmap))
-			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops);
+			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
 	} else
 #endif
 	{
@@ -836,7 +841,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 			if (gops == &fgraph_stub)
 				continue;
 
-			gops->retfunc(&trace, gops);
+			gops->retfunc(&trace, gops, fregs);
 		}
 	}
 
@@ -1009,7 +1014,8 @@ void ftrace_graph_sleep_time_control(bool enable)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops);
+void ftrace_stub_graph(struct ftrace_graph_ret *trace, struct fgraph_ops *gops,
+		       struct ftrace_regs *fregs);
 
 /* The callbacks that hook a function */
 trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6346fe37f2f6..3e9fbfef2d08 100644
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
index fee181af0245..4a3d460a82b3 100644
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
index c7f9e93fe8a3..8025e9b1237e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -319,7 +319,7 @@ static void handle_nosleeptime(struct ftrace_graph_ret *trace,
 }
 
 void trace_graph_return(struct ftrace_graph_ret *trace,
-			struct fgraph_ops *gops)
+			struct fgraph_ops *gops, struct ftrace_regs *fregs)
 {
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct trace_array *tr = gops->private;
@@ -359,7 +359,8 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
-				      struct fgraph_ops *gops)
+				      struct fgraph_ops *gops,
+				      struct ftrace_regs *fregs)
 {
 	struct fgraph_times *ftimes;
 	int size;
@@ -383,7 +384,7 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
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
index 5fe1f18df137..5202bd02a222 100644
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
index 137c13de5731..361dad71727e 100644
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



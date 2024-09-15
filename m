Return-Path: <linux-arch+bounces-7315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDA9795ED
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B49B222A4
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD01C463E;
	Sun, 15 Sep 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu9pGXSb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C272232A;
	Sun, 15 Sep 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391447; cv=none; b=c9liCkOOOyYbigyz+Vd405ocJnzmbasWXRtxRkeO6B7ZUjJHLD6noDoi1rnbEvyZPGdayqTyKNhLDsa7/fxMpRGKaTCWvuAxpWerFF5o2mjy8xgPTf6CeXZF96L/4ti8FS/DtdmjKdpIVpVkXIZgoCmEKl9SRwP13Sg+FKB1y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391447; c=relaxed/simple;
	bh=luxqQ6aApAo7La0MPtyuvPYJdsPrmj5xdiCWoGMGDLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA92PIy6w2ijpYtlUSmDst2VzSEZnHoctxFEPotnSHc6wwkZ0gSR59B3A0tIoeRjrBncvBVYXwuvCI3DXr4NfxQVxm5IFPR45jdQv2nKijDOQ5qZEeSDmcRqcYC2qDs8F0zIlpyfU0VNHN2/5Jh8la9JLcR8CauzWv/37H0SuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu9pGXSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A885CC4CEC3;
	Sun, 15 Sep 2024 09:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391446;
	bh=luxqQ6aApAo7La0MPtyuvPYJdsPrmj5xdiCWoGMGDLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uu9pGXSbEfDDp+uE4Nwnm1D2su0TY5thatXmf5d+v2HgyGG0dWyxLN+L4UewZ8qOM
	 KhaHTQg96CxtrITSlHNS5Z2psrSLPZ/Rgx88Y9SIErOY1zIJZeZH6rytpVcfrGklZI
	 IXBG0D8exqLI9erUffX9eEgY6g6WH/m9Jjy/sHYqjOONrhzPMDtMhqDsubPFfjB73f
	 9cUd4nBbqQ9HwBfVPWEi86oHkK2FdxaKHXAHDTIkCzK1p/F4yhhYX3C7wCV1UiAg88
	 hLQKzAQ/zg0B7Y6WwarwYp/WLAoFmgOzoP58b6g/uv9/IlxHWpHGWdHrTYZqwocVzf
	 ZNsBal3leb0lg==
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
Subject: [PATCH v15 06/19] fprobe: Use ftrace_regs in fprobe entry handler
Date: Sun, 15 Sep 2024 18:10:40 +0900
Message-Id: <172639144055.366111.1357568003008307699.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172639136989.366111.11359590127009702129.stgit@devnote2>
References: <172639136989.366111.11359590127009702129.stgit@devnote2>
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

This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
on arm64.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v6:
  - Keep using SAVE_REGS flag to avoid breaking bpf kprobe-multi test.
---
 include/linux/fprobe.h          |    2 +-
 kernel/trace/Kconfig            |    3 ++-
 kernel/trace/bpf_trace.c        |   10 +++++++---
 kernel/trace/fprobe.c           |    3 ++-
 kernel/trace/trace_fprobe.c     |    6 +++++-
 lib/test_fprobe.c               |    4 ++--
 samples/fprobe/fprobe_example.c |    2 +-
 7 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index f39869588117..ca64ee5e45d2 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -10,7 +10,7 @@
 struct fprobe;
 
 typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *regs,
 			       void *entry_data);
 
 typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index ab277eff80dc..0c6a03554c13 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -287,7 +287,7 @@ config DYNAMIC_FTRACE_WITH_ARGS
 config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on FUNCTION_TRACER
-	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_RETHOOK
 	select RETHOOK
 	default n
@@ -672,6 +672,7 @@ config FPROBE_EVENTS
 	select TRACING
 	select PROBE_EVENTS
 	select DYNAMIC_EVENTS
+	depends on DYNAMIC_FTRACE_WITH_REGS
 	default y
 	help
 	  This allows user to add tracing events on the function entry and
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..947808a002d0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2605,7 +2605,7 @@ struct bpf_session_run_ctx {
 	void *data;
 };
 
-#ifdef CONFIG_FPROBE
+#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2857,12 +2857,16 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 static int
 kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
-			  unsigned long ret_ip, struct pt_regs *regs,
+			  unsigned long ret_ip, struct ftrace_regs *fregs,
 			  void *data)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct bpf_kprobe_multi_link *link;
 	int err;
 
+	if (!regs)
+		return 0;
+
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false, data);
 	return is_kprobe_session(link->link.prog) ? err : 0;
@@ -3137,7 +3141,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE */
+#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9ff018245840..3d3789283873 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -46,7 +46,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long parent_ip,
 	}
 
 	if (fp->entry_handler)
-		ret = fp->entry_handler(fp, ip, parent_ip, ftrace_get_regs(fregs), entry_data);
+		ret = fp->entry_handler(fp, ip, parent_ip, fregs, entry_data);
 
 	/* If entry_handler returns !0, nmissed is not counted. */
 	if (rh) {
@@ -182,6 +182,7 @@ static void fprobe_init(struct fprobe *fp)
 		fp->ops.func = fprobe_kprobe_handler;
 	else
 		fp->ops.func = fprobe_handler;
+
 	fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS;
 }
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 62e6a8f4aae9..b2c20d4fdfd7 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -338,12 +338,16 @@ NOKPROBE_SYMBOL(fexit_perf_func);
 #endif	/* CONFIG_PERF_EVENTS */
 
 static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *fregs,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	int ret = 0;
 
+	if (!regs)
+		return 0;
+
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
 		fentry_trace_func(tf, entry_ip, regs);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index 24de0e5ff859..ff607babba18 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -40,7 +40,7 @@ static noinline u32 fprobe_selftest_nest_target(u32 value, u32 (*nest)(u32))
 
 static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
-				    struct pt_regs *regs, void *data)
+				    struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
@@ -81,7 +81,7 @@ static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
 				      unsigned long ret_ip,
-				      struct pt_regs *regs, void *data)
+				      struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	return 0;
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 0a50b05add96..c234afae52d6 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -50,7 +50,7 @@ static void show_backtrace(void)
 
 static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 				unsigned long ret_ip,
-				struct pt_regs *regs, void *data)
+				struct ftrace_regs *fregs, void *data)
 {
 	if (use_trace)
 		/*



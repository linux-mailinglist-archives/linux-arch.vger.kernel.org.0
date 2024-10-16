Return-Path: <linux-arch+bounces-8207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99299FD8F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9201C26ADA
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5488248D;
	Wed, 16 Oct 2024 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz2Kahf8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31F5D477;
	Wed, 16 Oct 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040383; cv=none; b=H//iUC/TzMmyNQXdp7s9fbOeXdN6zYBqHQqNOlITuDJtcniHIyZTioJ5ZFxuJuY3e9BL7jyzbQhwzv+OC0Q3RUV2i+m2Yfi33iyNDbb7I3PsONMYkOEgsCeIhS5f0OnrcQa2xDdLR8Jxj/ruldKGSF14sZOEJjUaYjRrrC3qZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040383; c=relaxed/simple;
	bh=ENIUEW8rDQ6Bki4p8UTgvZofYWz4Vdl3op51apG49gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyLfhb58glzbQvCshYikpVA2njzIHlEVnfI0brfacI94hqXhnhy0mOyqJ7UJ68WHwMkIt5QZLMZu5gWgyoSU8buXyA1yuTzlg7SrFzFL+40ApSAK3jGI43DseOZhuxkWF/Kul5SHte43sEwuV/tFwKIJ8uHOqstIEnrA+DN3K+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz2Kahf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50560C4CEC6;
	Wed, 16 Oct 2024 00:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040382;
	bh=ENIUEW8rDQ6Bki4p8UTgvZofYWz4Vdl3op51apG49gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kz2Kahf8mputHtLYUXQuAftseUpb8kpIi322qjd9f5d3FlgiSMBuzh7QGiiE709ct
	 z9FDkk1sWVeMKkBC+euKGx/nxOZm/tYqgz2s71GVwWIlDcprrZtYYZeZVRTK+gRO6G
	 7F5YEMAarPD6UsymsdiuwCr7NdeMwEcUyGF51SKGoGB3f7v2aJvcOKVAvCnJsDU13V
	 69IVKV+oZTzIpYrQ62Yr2qjGTfLKjindL9/jIChGbrBEz+M9ijhcQjrWSqEwC9b2Pg
	 1bIhumonO/Nmx0jk7W1X4Qexfeey9IGCq/gX5je0ShdQGtxgyxYORuao7nw3ECx7AD
	 5ggBHJkST5qRw==
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
Subject: [PATCH v17 09/16] bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
Date: Wed, 16 Oct 2024 09:59:36 +0900
Message-ID: <172904037666.36809.4351333932744494456.stgit@devnote2>
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

Enable kprobe_multi feature if CONFIG_FPROBE is enabled. The pt_regs is
converted from ftrace_regs by ftrace_partial_regs(), thus some registers
may always returns 0. But it should be enough for function entry (access
arguments) and exit (access return value).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v9:
  - Avoid wasting memory for bpf_kprobe_multi_pt_regs when
    CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y
---
 kernel/trace/bpf_trace.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4db2aff65151..edd577297dc2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2517,7 +2517,7 @@ struct bpf_session_run_ctx {
 	void *data;
 };
 
-#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2540,6 +2540,13 @@ struct user_syms {
 	char *buf;
 };
 
+#ifndef CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS
+static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
+#define bpf_kprobe_multi_pt_regs_ptr()	this_cpu_ptr(&bpf_kprobe_multi_pt_regs)
+#else
+#define bpf_kprobe_multi_pt_regs_ptr()	(NULL)
+#endif
+
 static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
 {
 	unsigned long __user usymbol;
@@ -2734,7 +2741,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs,
+			   unsigned long entry_ip, struct ftrace_regs *fregs,
 			   bool is_return, void *data)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
@@ -2746,6 +2753,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		.entry_ip = entry_ip,
 	};
 	struct bpf_run_ctx *old_run_ctx;
+	struct pt_regs *regs;
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
@@ -2756,6 +2764,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
+	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
@@ -2772,15 +2781,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 			  unsigned long ret_ip, struct ftrace_regs *fregs,
 			  void *data)
 {
-	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct bpf_kprobe_multi_link *link;
 	int err;
 
-	if (!regs)
-		return 0;
-
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, false, data);
+	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, false, data);
 	return is_kprobe_session(link->link.prog) ? err : 0;
 }
 
@@ -2790,13 +2795,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
-	struct pt_regs *regs = ftrace_get_regs(fregs);
-
-	if (!regs)
-		return;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true, data);
+	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, true, data);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)
@@ -3057,7 +3058,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;



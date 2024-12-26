Return-Path: <linux-arch+bounces-9500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E069FC867
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64DC162B11
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20A189521;
	Thu, 26 Dec 2024 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFFSrL1l"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBA155A4D;
	Thu, 26 Dec 2024 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735190009; cv=none; b=GJuIVvZkuOu6hvpINUfpEldGT2YpFj/yz+ZtTd21hHV5OBLXDksn/2/bghhyBX6p9isK6kGXNA/8+TH7nJ8mziS9lJg1Ho4B892+u92FAP3D7lX0KfT7KmLufXFSM9z0kMS9yLT26VCUfUUe1ohkRdkYYTXp0AfVE0ZkG6S27Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735190009; c=relaxed/simple;
	bh=GULDlrbJIImk+DIhKTj3Uuocr4L0WJf5k1KNmOEesqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8o1B8MJwyBG2yWvEZMoOC8ZcZsg4tuvETIoAxHd+opYzB1BJj2N1iTXSebkqjqqMu41jaD9SiBvvyZQmLfbaPtspcWp/njDIbhOt9TuUVINQNY6cVVXNFLKH7LyFXysIpAsO86ZdgagTH8oMRzNC5NAaD8IZ11crrLFF0X9oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFFSrL1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9927FC4CED1;
	Thu, 26 Dec 2024 05:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735190009;
	bh=GULDlrbJIImk+DIhKTj3Uuocr4L0WJf5k1KNmOEesqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NFFSrL1ltecipetCjVCTc2BqN+tFi1n5OEAHaNCYiQPXV93PI/z0dfJsN7husRawM
	 RoIkaM4BganDdh4KvngyXwuzuRBDf9LjsxDIIRR9KQpckBrTSe4GqgZMjMCe9BmaPx
	 /Nn1WrjOR5/n/somnZYqEcFKxTU7kbVWXWlEd6DfABi+0By9XTRCeIjD4AZx1VmLGO
	 dOmZA9nzchdfJzJ0AHmhYVSAdE1xAlxy9j9RRn0sqJGlG69hykNlnQlYh6+aAn9nTq
	 4JnP1nw0RoHfx95ooFigcRYIKA25V7ebycSVqQNJd9v1j3wIiZslfKDp3/qud7K0jv
	 gUsCumk2hoNVA==
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
Subject: [PATCH v22 10/20] bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
Date: Thu, 26 Dec 2024 14:13:24 +0900
Message-ID: <173519000417.391279.14011193569589886419.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173518987627.391279.3307342580035322889.stgit@devnote2>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
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
index e469fcbed210..863351559334 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2561,7 +2561,7 @@ struct bpf_session_run_ctx {
 	void *data;
 };
 
-#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2584,6 +2584,13 @@ struct user_syms {
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
@@ -2778,7 +2785,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs,
+			   unsigned long entry_ip, struct ftrace_regs *fregs,
 			   bool is_return, void *data)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
@@ -2790,6 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		.entry_ip = entry_ip,
 	};
 	struct bpf_run_ctx *old_run_ctx;
+	struct pt_regs *regs;
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
@@ -2800,6 +2808,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
+	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
@@ -2816,15 +2825,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
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
 
@@ -2834,13 +2839,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
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
@@ -3101,7 +3102,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;



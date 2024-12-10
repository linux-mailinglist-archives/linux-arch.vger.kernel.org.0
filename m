Return-Path: <linux-arch+bounces-9338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE769EA4D7
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7502188A7EC
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9051A38C4;
	Tue, 10 Dec 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAyrHAlz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E91990BA;
	Tue, 10 Dec 2024 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796663; cv=none; b=gDqLBDYBQBrEkNOH1JxpimteuKfRRLUxkQRPcLB7aimgaF+cp/uC5L1T/d5hSPs2uuXleQB7LnowN4la3JprIDrLAXbJ/xS+iNGxXIjE0mzjG3yfMTZ2bvnDQPAymVUdIbMPkJKyoQPuLAGBHCGvBrey4941IoVXrO7ZYs14SDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796663; c=relaxed/simple;
	bh=9OGc+Psrr2RQl+U3BiCBOgmGTipVIBYkFiE8ke4Sv8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVc4USQn74crIJwALaHH3OpnWaF8vEepvBkDa6p8C1PkORcvIa9FP+cbgiWWoZqLsOuXgnVDdgS6kHxAUaVpkGTAu4Rup5xUQpeUpnTERAxNCKP+ijpK9SgVF/Zof3nYvYvSFsK4JPtA8/lvv+Zptz3d6/UkIsYFzRNRN5lgelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAyrHAlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D6C4CED1;
	Tue, 10 Dec 2024 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796662;
	bh=9OGc+Psrr2RQl+U3BiCBOgmGTipVIBYkFiE8ke4Sv8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAyrHAlzcEOWwVLwkwR4wZhCtOHfNOUUuVTiT5yzqjhDDtkSXFnRMP8Ttsy/dHSw5
	 ROo/txeA1MVCEVQUiavf5tGWg+bRXhjhqdoiBfBcf8xeTQOwB/tkQ0btQH892ZykvF
	 vezL6QQOCayy+72oHlOU1MyxR9XRewcU7SrSXqmnRZMqfszF3ajntY/+9+QZOPnqZC
	 FO/HemrKTBD+lAe9Lzxi+mtjPOxBatqqi0ZMcWopsr8gI1/JJVbSf9sw3Tfsb3ylfS
	 +CFzTn1nchqQO2sgdqaJj0NfCbFY9WWlCHmcGfudP1OZ9K1aBV2OZKj651J34lR7LB
	 wgkJ5luo1kzWw==
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
Subject: [PATCH v21 10/20] bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
Date: Tue, 10 Dec 2024 11:10:56 +0900
Message-ID: <173379665670.973433.15793757202692406914.stgit@devnote2>
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
index 88aad3e3742c..852400170c5c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2550,7 +2550,7 @@ struct bpf_session_run_ctx {
 	void *data;
 };
 
-#if defined(CONFIG_FPROBE) && defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
+#ifdef CONFIG_FPROBE
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;
@@ -2573,6 +2573,13 @@ struct user_syms {
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
@@ -2767,7 +2774,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 
 static int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
-			   unsigned long entry_ip, struct pt_regs *regs,
+			   unsigned long entry_ip, struct ftrace_regs *fregs,
 			   bool is_return, void *data)
 {
 	struct bpf_kprobe_multi_run_ctx run_ctx = {
@@ -2779,6 +2786,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 		.entry_ip = entry_ip,
 	};
 	struct bpf_run_ctx *old_run_ctx;
+	struct pt_regs *regs;
 	int err;
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
@@ -2789,6 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 
 	migrate_disable();
 	rcu_read_lock();
+	regs = ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
@@ -2805,15 +2814,11 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
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
 
@@ -2823,13 +2828,9 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
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
@@ -3090,7 +3091,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(cookies);
 	return err;
 }
-#else /* !CONFIG_FPROBE || !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+#else /* !CONFIG_FPROBE */
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;



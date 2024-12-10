Return-Path: <linux-arch+bounces-9348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FC9EA4FD
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E3228695F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB981D0F5F;
	Tue, 10 Dec 2024 02:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqrptU7/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301219ADA2;
	Tue, 10 Dec 2024 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796783; cv=none; b=fHN9Yx4exHApy+E5Yu7p5noLAdcsJozKCEFlosFUTNVQTfHvhBKif5COq32VnOwLRj5prlRx2VHNDlVVZMFwxsFeFmsnf2q83LAJNiIMWuodMoNrHwDvpA6G0uZ7ZSmEzgB/8lGCtk8ttsZ2N/pQDiV2FwuSuo34o7H3p+/m9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796783; c=relaxed/simple;
	bh=2p9qHO+5munvSFM1Ox+17a3n3bNIcRbVVvxTG/0uOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPNqnJ002UqPo5O5rd4NWhBpV54O31vUm1Vrfr1f4TuyisM3n8C745jVyZEzSPMGnHogtCO6aSHQrg6Tq2g3PWZIOXVl8dqi5WkbeKAkTbiFgu5pACtSXMiJgO8UWcSoCDh0upQg6RfqN6NlJnYYkSJ/IYiOau9GWgV7tkmuXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqrptU7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB6C4CEDE;
	Tue, 10 Dec 2024 02:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796783;
	bh=2p9qHO+5munvSFM1Ox+17a3n3bNIcRbVVvxTG/0uOJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqrptU7/krbW2vld9AMvRl/6FEz36YnXi0SBLbdF7SrAPP6RBOmv+N9cXozwszjEJ
	 McSRhgf4mafEBlbLV/qb1Rlo2NA6ybeCm7udERnyBeVgMMQtf7b2WoN6OKOx3DIUVZ
	 AOlCs1UnyWOq49PXfLb1pzFlvKARIHCu8ZN73QtMf1/oBEeik9Xok4jhgGvIYi6eHr
	 ql1RsJFUfhqWfN10VUBVyOdntClk6YcU4yVxvB2EIVPDlriR4ogcm52lRTIjpl+Y3L
	 NGzChcLIjtwJmuZB6+It+ThZX2RBwuL8Z8rVw1pIcKMiR8ZS/9192IMPvHjVDx2rOx
	 O7WCrDdQH7H6w==
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
Subject: [PATCH v21 20/20] bpf: Use ftrace_get_symaddr() for kprobe_multi probes
Date: Tue, 10 Dec 2024 11:12:58 +0900
Message-ID: <173379677799.973433.10413868616941810350.stgit@devnote2>
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

Add ftrace_get_entry_ip() which is only for ftrace based probes, and use
it for kprobe multi probes because they are based on fprobe which uses
ftrace instead of kprobes.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v21:
  - Use new ftreace_get_symaddr() only for kprobe multi probes.
 Changes in v19:
  - Use ftrace_get_symaddr() instead of introducing new arch dependent code.
  - Also, replace x86 code with ftrace_get_symaddr(), which does the same
   thing.
---
 kernel/trace/bpf_trace.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 852400170c5c..91c18e9aac6b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1070,6 +1070,13 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
 #define get_entry_ip(fentry_ip) fentry_ip
 #endif
 
+static unsigned long ftrace_get_entry_ip(unsigned long fentry_ip)
+{
+	unsigned long ip = ftrace_get_symaddr(fentry_ip);
+
+	return ip ? : fentry_ip;
+}
+
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {
 	struct bpf_trace_run_ctx *run_ctx __maybe_unused;
@@ -2818,7 +2825,8 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, false, data);
+	err = kprobe_multi_link_prog_run(link, ftrace_get_entry_ip(fentry_ip),
+					 fregs, false, data);
 	return is_kprobe_session(link->link.prog) ? err : 0;
 }
 
@@ -2830,7 +2838,8 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, true, data);
+	kprobe_multi_link_prog_run(link, ftrace_get_entry_ip(fentry_ip),
+				   fregs, true, data);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)



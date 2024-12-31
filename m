Return-Path: <linux-arch+bounces-9550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A79FF06F
	for <lists+linux-arch@lfdr.de>; Tue, 31 Dec 2024 17:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2AE37A11D7
	for <lists+linux-arch@lfdr.de>; Tue, 31 Dec 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986313D521;
	Tue, 31 Dec 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6HoD8YX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035217C68;
	Tue, 31 Dec 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660820; cv=none; b=auvyeYi99IbGGV1rJiFxBvJWu/c1ocGvIhdM3cwUvp9JzN2bgnexuZa0r0ejBLFFKzB7/WXlGX4xuxbhQq3HYjK/cSG4np5tOwI1CZ2MOtiQiwhHRWNvfoVUqLqLkpGVDFq1XvqUiyekh3RPhUJRHlLTU4/5sIMp6hQpwX13d7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660820; c=relaxed/simple;
	bh=wVISiyeMkK4FOBrgMThtXTKECr0EnjQ6TVL1e6ur+9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTwHcGlnMS8ltja1dIgnS4ZDSEuzlW6sJSSVc519mvCbAudFNoT2mi2qDCu9wIAiEkGm16WPTaOf6ZRFtAvFLQ8b81d1Uz5kHRv2UQoqe6FcG34aA2Kfvn4z//OObsPAaTyqFPPHe7mBYCBt2OUuEmnk3c7wmeaqDvtI70qRrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6HoD8YX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FB2C4CED2;
	Tue, 31 Dec 2024 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735660819;
	bh=wVISiyeMkK4FOBrgMThtXTKECr0EnjQ6TVL1e6ur+9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6HoD8YXdUSfugWyJ6LzwHVghHNxaK/pgxrz1BYqRyrf/taoGfZspKgSPwnRSb7VV
	 eJCOaleQUtIgQyoVBAa32hsLZDwXH+JXmq69IRKW3xOScFCFfLcAgMLuS9O9eILVwA
	 /IqtpNSjJAq9qdf2fGuQb/+ko6MTXKmHDk7WQf+GzzwdzrUBMxJnJ9XkpTnowXEPrI
	 VsLckaE7E68l3B/e0zBBuWiDNVPioJAp1SgdXgp2tkZXy4cK4wcASiKaTu3I7VaPnn
	 2xWjr5Sz7G/Rjt3NCby0CkNiNINGpFCQ5AHTEnAiTespd1Cu4jOqqusB+tP3u6exXK
	 3GpRRceBdAx7g==
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
Subject: [PATCH v23] bpf: Use ftrace_get_symaddr() for kprobe_multi probes
Date: Wed,  1 Jan 2025 01:00:14 +0900
Message-ID: <173566081414.878879.10631096557346094362.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241227102452.14a1c2d9@gandalf.local.home>
References: <20241227102452.14a1c2d9@gandalf.local.home>
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
 Changes in v23:
  - Move ftrace_get_symaddr() in CONFIG_FPROBE ifdef block.
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
index 863351559334..9bfd52913a5b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2591,6 +2591,13 @@ static DEFINE_PER_CPU(struct pt_regs, bpf_kprobe_multi_pt_regs);
 #define bpf_kprobe_multi_pt_regs_ptr()	(NULL)
 #endif
 
+static unsigned long ftrace_get_entry_ip(unsigned long fentry_ip)
+{
+	unsigned long ip = ftrace_get_symaddr(fentry_ip);
+
+	return ip ? : fentry_ip;
+}
+
 static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
 {
 	unsigned long __user usymbol;
@@ -2829,7 +2836,8 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 	int err;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	err = kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, false, data);
+	err = kprobe_multi_link_prog_run(link, ftrace_get_entry_ip(fentry_ip),
+					 fregs, false, data);
 	return is_kprobe_session(link->link.prog) ? err : 0;
 }
 
@@ -2841,7 +2849,8 @@ kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
 	struct bpf_kprobe_multi_link *link;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
-	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), fregs, true, data);
+	kprobe_multi_link_prog_run(link, ftrace_get_entry_ip(fentry_ip),
+				   fregs, true, data);
 }
 
 static int symbols_cmp_r(const void *a, const void *b, const void *priv)



Return-Path: <linux-arch+bounces-9510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668D9FC888
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA28A162E98
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBBD1BD9F6;
	Thu, 26 Dec 2024 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcES0trB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49317B50F;
	Thu, 26 Dec 2024 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735190131; cv=none; b=Zvuvq1A1jkLDpcOUzi2znesMK2aVfllZREA1n/j8neWlA0IbNON9DKPBcnCuc8639F/CnxUT1E1v4kUY/8jh2hKoR7OBbdzHxqSfMZYIj1W2CYwPZa+uHOsWI24G4YRoBFXbwUM/2aroip0maFE4IN9cnBPwtKEFz2nr5JLOxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735190131; c=relaxed/simple;
	bh=2bIEkJo/NVwMsn9eDKfDeA7hvaijbkdoU841Oyjb2Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMONI/kuFG3/ZB+MlLpg2RvbkhFtf/JVczItQaatqYA06fWotvdGmbqiLh0iuDLGO4lfMswxnQhL4sbxbWCzi0GDYaeq3Ytl4syYMoU0HcEyl64Cqg6QDIs3WV76c6IXAjzeFA7VzKrWnWQYPACoBGCrKJqCwB89K5qs743LABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcES0trB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42F9C4CED1;
	Thu, 26 Dec 2024 05:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735190130;
	bh=2bIEkJo/NVwMsn9eDKfDeA7hvaijbkdoU841Oyjb2Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcES0trBq6NvsHnuXFyJKaKdihkYdNx1yB51tbP8KGtd5moVd+LBcv4WdgVUvVwHJ
	 HjZPXUEmduJgOUoylYvyYPDEQS423/+EHhLZTcEePqh2AkLG35xJksf0FAfbbhAQf7
	 8U7jb/kPDj5pBwVzKbO7mT8l1WQdiMgVa/g9wYN8hTFdR8sk84NMx63PnrWvjgFcuP
	 UEzsjsqnNa4FbwaLpY3nqs+z2O9E0TlKzmBPunZZ5y8ZlvGbJgwuiZbcHyPB4TdEt7
	 hI4XRNrX+SsBmZQrB8wgPXkcLIOqae6Dk+yFv5XfKBwKSt8KPuZsdZsWVl1FlQ438m
	 Md9PWibvlWcfw==
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
Subject: [PATCH v22 20/20] bpf: Use ftrace_get_symaddr() for kprobe_multi probes
Date: Thu, 26 Dec 2024 14:15:25 +0900
Message-ID: <173519012541.391279.12203132904339088937.stgit@devnote2>
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
index 863351559334..47beb70187d7 100644
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



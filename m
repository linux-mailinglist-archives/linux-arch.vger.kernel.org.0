Return-Path: <linux-arch+bounces-8953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D361F9C3385
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E631F213E3
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C05913A24D;
	Sun, 10 Nov 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJFqO3rA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1694594A;
	Sun, 10 Nov 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253904; cv=none; b=AZutfBqwdq/4XWltjtApxrwyXeoYZSLJmRh5xO9vqos6Dr+P0GP6iRxnUdOGiioj3AbKKfjaYxaouRwL1fGattnAsC0OtXQa3HJy/EPG2mziDqyYyx38KiCLHwBB4pl6cI4EmHVQT40BNM1IUME4W2+cyZ/HyAqtYD0nVXdh7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253904; c=relaxed/simple;
	bh=DyIlxK+rzyV5Z9ObEzLIQrZIcPEZL8giKascGhc6cU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rla+oTsJWYz1kDTor49Dl5htO7Cvhvqs/4iOXFyy+qDHFq8s61luBXP4jQNyIaUNqfUpnx52Ptt0HPlZ1m8GWIZlyaEFGZbremD+tjs+xV//tzK1+2X1Hwsjsa1IeZQgqqLEP7hurl32ak2RyQ+hWsakyoe24Dy9ICWSWMuPKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJFqO3rA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DD6C4CECD;
	Sun, 10 Nov 2024 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253904;
	bh=DyIlxK+rzyV5Z9ObEzLIQrZIcPEZL8giKascGhc6cU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJFqO3rAQ5QR50yAiC2utYJMVLLefG/7pFE7WZXB3kERnPWHYHfp4xzAWbhjCMCty
	 3FxJ3p6IZcZi16Gaisnz76M218XCUYgHxRcJ2x6swP7KtbT2GSNgbHEE7E03TFzgz4
	 PgaUNf+fweLkmHNQ9MNJa/kBphjyoonkGb195aNCX5/0crthkCw2rcAlBrM/8Vo4p3
	 8FaKo97Dg/+J8/dJi4G3hPdOq/VGlxlQjigTI0FeR/nGdnSoZxs1qc9QZg4P5auhY0
	 FsT2/HSA9qcPbuq0XQTU0DXecVGcQGuiVGuzIhSegDfZnBmoNyT9tSxGNawrIVbyUx
	 j0s3+Af7DvHqg==
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
Subject: [PATCH v19 14/19] tracing/fprobe: Remove nr_maxactive from fprobe
Date: Mon, 11 Nov 2024 00:51:39 +0900
Message-ID: <173125389954.172790.2219734085182975753.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173125372214.172790.6929368952404083802.stgit@devnote2>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
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

Remove depercated fprobe::nr_maxactive. This involves fprobe events to
rejects the maxactive number.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Newly added.
---
 include/linux/fprobe.h      |    2 --
 kernel/trace/trace_fprobe.c |   43 ++++++-------------------------------------
 2 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 91337bcb452f..702099f08929 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -54,7 +54,6 @@ struct fprobe_hlist {
  * @nmissed: The counter for missing events.
  * @flags: The status flag.
  * @entry_data_size: The private data storage size.
- * @nr_maxactive: The max number of active functions. (*deprecated)
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
@@ -63,7 +62,6 @@ struct fprobe {
 	unsigned long		nmissed;
 	unsigned int		flags;
 	size_t			entry_data_size;
-	int			nr_maxactive;
 
 	fprobe_entry_cb entry_handler;
 	fprobe_exit_cb  exit_handler;
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 41595e38fea5..0a17ed405b6a 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -424,7 +424,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 					       const char *symbol,
 					       struct tracepoint *tpoint,
 					       struct module *mod,
-					       int maxactive,
 					       int nargs, bool is_return)
 {
 	struct trace_fprobe *tf;
@@ -445,7 +444,6 @@ static struct trace_fprobe *alloc_trace_fprobe(const char *group,
 
 	tf->tpoint = tpoint;
 	tf->mod = mod;
-	tf->fp.nr_maxactive = maxactive;
 
 	ret = trace_probe_init(&tf->tp, event, group, false, nargs);
 	if (ret < 0)
@@ -1098,12 +1096,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
 	 */
 	struct trace_fprobe *tf = NULL;
-	int i, len, new_argc = 0, ret = 0;
+	int i, new_argc = 0, ret = 0;
 	bool is_return = false;
 	char *symbol = NULL;
 	const char *event = NULL, *group = FPROBE_EVENT_SYSTEM;
 	const char **new_argv = NULL;
-	int maxactive = 0;
 	char buf[MAX_EVENT_NAME_LEN];
 	char gbuf[MAX_EVENT_NAME_LEN];
 	char sbuf[KSYM_NAME_LEN];
@@ -1126,33 +1123,13 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	trace_probe_log_init("trace_fprobe", argc, argv);
 
-	event = strchr(&argv[0][1], ':');
-	if (event)
-		event++;
-
-	if (isdigit(argv[0][1])) {
-		if (event)
-			len = event - &argv[0][1] - 1;
-		else
-			len = strlen(&argv[0][1]);
-		if (len > MAX_EVENT_NAME_LEN - 1) {
-			trace_probe_log_err(1, BAD_MAXACT);
-			goto parse_error;
-		}
-		memcpy(buf, &argv[0][1], len);
-		buf[len] = '\0';
-		ret = kstrtouint(buf, 0, &maxactive);
-		if (ret || !maxactive) {
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
 			trace_probe_log_err(1, BAD_MAXACT);
 			goto parse_error;
 		}
-		/* fprobe rethook instances are iterated over via a list. The
-		 * maximum should stay reasonable.
-		 */
-		if (maxactive > RETHOOK_MAXACTIVE_MAX) {
-			trace_probe_log_err(1, MAXACT_TOO_BIG);
-			goto parse_error;
-		}
+		event = &argv[0][2];
 	}
 
 	trace_probe_log_set_index(1);
@@ -1162,12 +1139,6 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (ret < 0)
 		goto parse_error;
 
-	if (!is_return && maxactive) {
-		trace_probe_log_set_index(0);
-		trace_probe_log_err(1, BAD_MAXACT_TYPE);
-		goto parse_error;
-	}
-
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1231,7 +1202,7 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 
 	/* setup a probe */
 	tf = alloc_trace_fprobe(group, event, symbol, tpoint, tp_mod,
-				maxactive, argc, is_return);
+				argc, is_return);
 	if (IS_ERR(tf)) {
 		ret = PTR_ERR(tf);
 		/* This must return -ENOMEM, else there is a bug */
@@ -1311,8 +1282,6 @@ static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev)
 		seq_putc(m, 't');
 	else
 		seq_putc(m, 'f');
-	if (trace_fprobe_is_return(tf) && tf->fp.nr_maxactive)
-		seq_printf(m, "%d", tf->fp.nr_maxactive);
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tf->tp),
 				trace_probe_name(&tf->tp));
 



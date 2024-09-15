Return-Path: <linux-arch+bounces-7323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF3979607
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFBC3B21D53
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9F1C7B82;
	Sun, 15 Sep 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA1DQbvf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91D1C6F4E;
	Sun, 15 Sep 2024 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391538; cv=none; b=Vq9KE8Zm7NAPqpAPJlE03gdbU5r9IuRazxwslxPNkrnkt2Xdr0EQY6/uVsRQwmUWvx5WABhgl7nRLw+Yki0xkXaZhDAodJr5eCGgz9v4rxNqopA2GOcVyjdIICgWsmcGnTgPkyF45fF7hqgb5UYr9z8XdjIRfZ2ruHCPs05cUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391538; c=relaxed/simple;
	bh=XL3/JHepsp5mPyEf2U8WFE6hs9Xy4+zNyejmCVae1Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYRsuIa+Fu+twMgxIQNvKYdzobp8p38eqFWHH5tC3L+UjngCJ4Jk5z9ZKaVNO3pXaRFTazGhjPZiksAzrL7zYG2yc8sSYW2ShkGSW/S3dnb4U1Sq4GTfhO0/ZKPkzrnds5hvVhULms6lhlPWUPT6ayFycr5C1QeHMfDHIAoUoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA1DQbvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BBCC4CEC3;
	Sun, 15 Sep 2024 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391538;
	bh=XL3/JHepsp5mPyEf2U8WFE6hs9Xy4+zNyejmCVae1Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dA1DQbvfqrsIyfzUe9JRNbF3cdp66jlCEYkrz5XI6NxqOB3TMctXutfPNOa+Hd+SU
	 Z6cb25yWNYHha6cLLCiloQVh0ilbOMj3AnRMJatLGDm8CkNUelU+yaKxd3oeisJhFi
	 2XA06Vz7y3Mbvq8yNXaEKbD0ndu6lAcDI+m5K6BoOA4jA7Q8lgoRhpHs2xSAFs7A2Q
	 1HtYax+4c6fNkTgGYYjYdIaa6biBj0B8wOYkp+aa53I1rtAOv6Sr/J5AdySxVdI8aq
	 MbAEkoT0NkQKIZai9E5bnLGMTM3OZZdysuVJkUxEl/hEb2qsH4eBDr/Bk+x24oaO4u
	 CevDyFk39+gwA==
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
Subject: [PATCH v15 14/19] tracing: Fix function timing profiler to initialize hashtable
Date: Sun, 15 Sep 2024 18:12:12 +0900
Message-Id: <172639153271.366111.7639381985296883820.stgit@devnote2>
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

Since the new fgraph requires to initialize fgraph_ops.ops.func_hash before
calling register_ftrace_graph(), initialize it with default (tracing all
functions) parameter.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ftrace.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 66aea1baf8a2..d589057957d2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -904,6 +904,10 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static struct fgraph_ops fprofiler_ops = {
+	.ops = {
+		.flags = FTRACE_OPS_FL_INITIALIZED,
+		INIT_OPS_HASH(fprofiler_ops.ops)
+	},
 	.entryfunc = &profile_graph_entry,
 	.retfunc = &profile_graph_return,
 };



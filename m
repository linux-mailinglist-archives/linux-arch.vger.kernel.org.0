Return-Path: <linux-arch+bounces-7244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6857976D48
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D390F1C21604
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8C1BC9F5;
	Thu, 12 Sep 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfBirS0K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3691BB6B5;
	Thu, 12 Sep 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153849; cv=none; b=tkWifnfzi1fFtrkJDER11+LNaHxp8+lmvXdPg8Da5pGkDT6iS4X2FdU7BQimDSd4q7oP/FlIG137oB1WN6VAlxy2XJ79q6YzH3hTwyA118Xv5KLLBpSjLG1zn5sGizxUqLU+0Uq5cGsP6DhjRorlK7NVVpF6gPDtpznGzX45LVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153849; c=relaxed/simple;
	bh=TU7U/7cI5u4iMQ6JCxAHG0ipOgBf+qmHbAaqBlHtV9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpCa+vqTuOKemOX56MxtLkX4ghMuZ/RMM9dB1FhexkAMj3ww/KAWtgyqa/Ghkm7hnYRBfuIFnO4Rl+TxThckkiVXB08bW4Ksndc81UJmsgMT0nyoj+WKxDwBv1Hb63579yK5yZmlZdxo22uGM9oaWTga5ljShvJqpN2raTM0R7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfBirS0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C0C4CEC3;
	Thu, 12 Sep 2024 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726153848;
	bh=TU7U/7cI5u4iMQ6JCxAHG0ipOgBf+qmHbAaqBlHtV9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IfBirS0KBjnGI1C00xT5k33+UcgMsBh9uwKYMf3OZxkCZXg5tScUXhZgHWo7bNd/m
	 uewMY/KGiM+sj/C2d/yo1yZ+ZYjP995HgPZqYSj3sBZP/mdjBLIzM70r/7hw3V4lZK
	 HdX2A1cESckJZAQ4M6iQzJU4OhzGhSeL/276LZn8VV4VinHEyo7rkhH9s4ajv2cUVQ
	 auYNvhklI0Y6gREI4X+2RR94jr9Xh5E3S0psgjGYfnKmC8NEOXHQeuMBWKRYXXK1/i
	 wyS7vFGwIJbjSj8Sto2gFp+mK20DJGaoDq8fnanH9UTEOhEkQsepNKUpSWX2ib1LEs
	 cXez2bokzmvMg==
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
Subject: [PATCH v14 14/19] tracing: Fix function timing profiler to initialize hashtable
Date: Fri, 13 Sep 2024 00:10:42 +0900
Message-Id: <172615384269.133222.13779164555686766360.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <172615368656.133222.2336770908714920670.stgit@devnote2>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
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
index fd6c5a50c5e5..c55cf21fd53c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -885,6 +885,10 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static struct fgraph_ops fprofiler_ops = {
+	.ops = {
+		.flags = FTRACE_OPS_FL_INITIALIZED,
+		INIT_OPS_HASH(fprofiler_ops.ops)
+	},
 	.entryfunc = &profile_graph_entry,
 	.retfunc = &profile_graph_return,
 };



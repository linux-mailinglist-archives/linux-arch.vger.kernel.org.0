Return-Path: <linux-arch+bounces-9047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24EC9C662B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 01:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FEC1F24DC8
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 00:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ABAAD2F;
	Wed, 13 Nov 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBy8e21p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56AAD24;
	Wed, 13 Nov 2024 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458540; cv=none; b=R5LaeoporgIH/7kPVeCh2+T/iqNT7ZmOYzSd3cvDV/HWRFDgD97f5JAuMCRAOK65Qx7gUVy9sRLJmtdaVeWvdiJprtkEG5ZwnLZmX2Rhw70Rk90tS+ZXBU1k9CLF7BTBwnDTpMZo31QuQKc2WJXRBIWbaXx+2l1u03JUR4EbkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458540; c=relaxed/simple;
	bh=UtTCpRAQSW0k/5mHxhY2EZqFTnQ1dV5Qa9iPw8SEhkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uE1LB8DMOUH3FZymtsbiiiBs04+aFsUoY/ZcWBlY5M5n6KzoPUBXe1YWElqTR9UWIC61ysav3OLEZD9WpYmao9I29ehWPpNHvTtzeLZRDhn28P4RG+psRaEkEQZ8INXS8hU49wMMzYMRhU4/V00ZvIZ7YH7/9TJEoIhcjCcvg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBy8e21p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EBDC4CED4;
	Wed, 13 Nov 2024 00:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731458538;
	bh=UtTCpRAQSW0k/5mHxhY2EZqFTnQ1dV5Qa9iPw8SEhkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBy8e21pLgOBkxC/k6fXB6T29dQkKz1xcv0GZ8z6MW3RKUqpDF/nQnL1a2AAIWwhc
	 8HOdZYUfUhaTlfku4YK9SKbKuTR8O3RVvsRVGbw6Gh9y9Q3Nmy6UyHdlIc6amWoVPv
	 EKDqSRH1LqFGtXm3aVNlBlS7JuTiOdtKQXKotd4SuH6IPC7u4VzOjZzRewdn5PsiT0
	 yLJLbD2Q907tgWHB8d19iY91xQNxyDo8+fv8aQ/u9O7kdfQ2Yg+6mwZxgz7OkHFISq
	 qfv3KOCQR+UCbu5YmY2lw6r11ipIXs25yS5O1aGLCoHFpIAsVz24NOZDPifM/YB3UY
	 ZhvLuvBroh+Tg==
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
Subject: [PATCH 19.1] Documentation: probes: Update fprobe on function-graph tracer
Date: Wed, 13 Nov 2024 09:42:13 +0900
Message-ID: <173145853330.190048.8075164639336145964.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173125393047.172790.8427492388173333634.stgit@devnote2>
References: <173125393047.172790.8427492388173333634.stgit@devnote2>
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

Update fprobe documentation for the new fprobe on function-graph
tracer. This includes some bahvior changes and pt_regs to
ftrace_regs interface change.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v19.1:
  - Fix typo
  - function-graph tracer -> function graph tracing feature in ftrace.
 Changes in v2:
  - Update @fregs parameter explanation.
---
 Documentation/trace/fprobe.rst |   42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 196f52386aaa..71cd40472d36 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -9,9 +9,10 @@ Fprobe - Function entry/exit probe
 Introduction
 ============
 
-Fprobe is a function entry/exit probe mechanism based on ftrace.
-Instead of using ftrace full feature, if you only want to attach callbacks
-on function entry and exit, similar to the kprobes and kretprobes, you can
+Fprobe is a function entry/exit probe based on the function-graph tracing
+feature in ftrace.
+Instead of tracing all functions, if you want to attach callbacks on specific
+function entry and exit, similar to the kprobes and kretprobes, you can
 use fprobe. Compared with kprobes and kretprobes, fprobe gives faster
 instrumentation for multiple functions with single handler. This document
 describes how to use fprobe.
@@ -91,12 +92,14 @@ The prototype of the entry/exit callback function are as follows:
 
 .. code-block:: c
 
- int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
+ int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
 
- void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
+ void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
 
-Note that the @entry_ip is saved at function entry and passed to exit handler.
-If the entry callback function returns !0, the corresponding exit callback will be cancelled.
+Note that the @entry_ip is saved at function entry and passed to exit
+handler.
+If the entry callback function returns !0, the corresponding exit callback
+will be cancelled.
 
 @fp
         This is the address of `fprobe` data structure related to this handler.
@@ -112,12 +115,10 @@ If the entry callback function returns !0, the corresponding exit callback will
         This is the return address that the traced function will return to,
         somewhere in the caller. This can be used at both entry and exit.
 
-@regs
-        This is the `pt_regs` data structure at the entry and exit. Note that
-        the instruction pointer of @regs may be different from the @entry_ip
-        in the entry_handler. If you need traced instruction pointer, you need
-        to use @entry_ip. On the other hand, in the exit_handler, the instruction
-        pointer of @regs is set to the current return address.
+@fregs
+        This is the `ftrace_regs` data structure at the entry and exit. This
+        includes the function parameters, or the return values. So user can
+        access thos values via appropriate `ftrace_regs_*` APIs.
 
 @entry_data
         This is a local storage to share the data between entry and exit handlers.
@@ -125,6 +126,17 @@ If the entry callback function returns !0, the corresponding exit callback will
         and `entry_data_size` field when registering the fprobe, the storage is
         allocated and passed to both `entry_handler` and `exit_handler`.
 
+Entry data size and exit handlers on the same function
+======================================================
+
+Since the entry data is passed via per-task stack and it has limited size,
+the entry data size per probe is limited to `15 * sizeof(long)`. You also need
+to take care that the different fprobes are probing on the same function, this
+limit becomes smaller. The entry data size is aligned to `sizeof(long)` and
+each fprobe which has exit handler uses a `sizeof(long)` space on the stack,
+you should keep the number of fprobes on the same function as small as
+possible.
+
 Share the callbacks with kprobes
 ================================
 
@@ -165,8 +177,8 @@ This counter counts up when;
  - fprobe fails to take ftrace_recursion lock. This usually means that a function
    which is traced by other ftrace users is called from the entry_handler.
 
- - fprobe fails to setup the function exit because of the shortage of rethook
-   (the shadow stack for hooking the function return.)
+ - fprobe fails to setup the function exit because of failing to allocate the
+   data buffer from the per-task shadow stack.
 
 The `fprobe::nmissed` field counts up in both cases. Therefore, the former
 skips both of entry and exit callback and the latter skips the exit



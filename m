Return-Path: <linux-arch+bounces-9329-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C49EA4B9
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA3B188B07C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231FA1581F2;
	Tue, 10 Dec 2024 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWXQBqPh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EB5D477;
	Tue, 10 Dec 2024 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796546; cv=none; b=s2ODgrqYJK52BURkW+40+G/s5QMRSLoLvyvNhKvBn9O+y4jaDKhWK28sDgxd2fKKpT3dq0RKiPU9jelPKYv0l1IZefG4XppSY00vzUQKt4VEY7u9kQl8g8hcg1pH3JTx1vAgP5fcN+XDV5hVWVVmUoGTwxfOQxnJGbwEq0hIdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796546; c=relaxed/simple;
	bh=kDfvYl7lD7/37OU2jQkyIgYBfM0i34+G673loU7DXHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdOjSNuDsg7Stl6uLIA2Z419+yldxdBUJQl0PwtSVuieWmTVqiZ5TLyzeKrdMAythPn2WUFhJcWvVObL0pxFUEq9eZWx7qCni2XF/LW8voxNc3/wm3zGoafn0uvm5hNwaTX93PB+mfQr6hmfuKeUcdwmljvooRgxFnwFVGIyhnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWXQBqPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122AC4CEE1;
	Tue, 10 Dec 2024 02:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796545;
	bh=kDfvYl7lD7/37OU2jQkyIgYBfM0i34+G673loU7DXHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWXQBqPhujtfBsQ8BRBEklfPL0Xv9qgvz9zRwu7G7WOB/TEMawPQ0VdYl4fIygItG
	 ybgLnsXzhhkyBWWWMHE/TqQN3HgWJFc6sfeXDnpjNJs8cP+YfI1FF3jMQux4sug6GI
	 A7USSXy0AMZLrU5FZn1GbBAaw7kHrX3MlU69J0bg8LtCgA3QcH30xUGqjRfYzFHaZu
	 N+2oSRQf/BhxwWvncRlTPOXmJU23KQyL1fE1/UyQOFjcV/diyUpzPzhvUqlvA/m7SB
	 XVqCtExlVyFoJtTFZWxTdCIr6RbYlswAOyDGM8odBiSgrKsxPkiKdA3AuSvlA8376d
	 NZiDCUBkv0MVA==
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
	linux-arch@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v21 01/20] fgraph: Get ftrace recursion lock in function_graph_enter
Date: Tue, 10 Dec 2024 11:08:57 +0900
Message-ID: <173379653720.973433.18438622234884980494.stgit@devnote2>
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

Get the ftrace recursion lock in the generic function_graph_enter()
instead of each architecture code.
This changes all function_graph tracer callbacks running in
non-preemptive state. On x86 and powerpc, this is by default, but
on the other architecutres, this will be new.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Changes in v21:
  - Newly added.
---
 arch/powerpc/kernel/trace/ftrace.c       |    6 ------
 arch/powerpc/kernel/trace/ftrace_64_pg.c |    6 ------
 arch/x86/kernel/ftrace.c                 |    7 -------
 kernel/trace/fgraph.c                    |    8 +++++++-
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 5ccd791761e8..e41daf2c4a31 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -658,7 +658,6 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	unsigned long sp = arch_ftrace_regs(fregs)->regs.gpr[1];
-	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
@@ -666,14 +665,9 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0)
-		goto out;
-
 	if (!function_graph_enter(parent_ip, ip, 0, (unsigned long *)sp))
 		parent_ip = ppc_function_entry(return_to_handler);
 
-	ftrace_test_recursion_unlock(bit);
 out:
 	arch_ftrace_regs(fregs)->regs.link = parent_ip;
 }
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
index 98787376eb87..8fb860b90ae1 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -790,7 +790,6 @@ static unsigned long
 __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
 {
 	unsigned long return_hooker;
-	int bit;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
@@ -798,16 +797,11 @@ __prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 
-	bit = ftrace_test_recursion_trylock(ip, parent);
-	if (bit < 0)
-		goto out;
-
 	return_hooker = ppc_function_entry(return_to_handler);
 
 	if (!function_graph_enter(parent, ip, 0, (unsigned long *)sp))
 		parent = return_hooker;
 
-	ftrace_test_recursion_unlock(bit);
 out:
 	return parent;
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4dd0ad6c94d6..33f50c80f481 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -615,7 +615,6 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	int bit;
 
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
@@ -635,14 +634,8 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	bit = ftrace_test_recursion_trylock(ip, *parent);
-	if (bit < 0)
-		return;
-
 	if (!function_graph_enter(*parent, ip, frame_pointer, parent))
 		*parent = return_hooker;
-
-	ftrace_test_recursion_unlock(bit);
 }
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0bf78517b5d4..c57540ad384d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -650,8 +650,13 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	struct ftrace_graph_ent trace;
 	unsigned long bitmap = 0;
 	int offset;
+	int bit;
 	int i;
 
+	bit = ftrace_test_recursion_trylock(func, ret);
+	if (bit < 0)
+		return -EBUSY;
+
 	trace.func = func;
 	trace.depth = ++current->curr_ret_depth;
 
@@ -697,12 +702,13 @@ int function_graph_enter(unsigned long ret, unsigned long func,
 	 * flag, set that bit always.
 	 */
 	set_bitmap(current, offset, bitmap | BIT(0));
-
+	ftrace_test_recursion_unlock(bit);
 	return 0;
  out_ret:
 	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
  out:
 	current->curr_ret_depth--;
+	ftrace_test_recursion_unlock(bit);
 	return -EBUSY;
 }
 



Return-Path: <linux-arch+bounces-9491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D59FC83D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BC2162598
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F0155A25;
	Thu, 26 Dec 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnSmfQS7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D71531DB;
	Thu, 26 Dec 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189895; cv=none; b=WpRnshJkZzzX5REiHc/ACoIcTsbtnb1NNOQjxszyzDLu1rbPRBQscJfYs+xyWxE2meCO8l97BDX9pXSFdddGq4JLIVQBAnoJvKdu2vxPQcecrdu1H3nQhsEPCyb/fwUAtm0ER0QK3YNXj90CfDZiuSbxjMNmctq/oSCnWT+YN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189895; c=relaxed/simple;
	bh=hMWe1F1OxukWskRCOoiu/a8QPxfOtfFqxPCj0gu+iHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHoYL2jUmYxdq4u+LZtz1MLXBLsZfdDAANZy070HSxh/pQ+K37apRqE63P5L6sDgTB+vmpgwOjeFi51ow+TKB41RwtyDyMPQZ8r7S9tkc+qxh5tRNgyDTytG4qIVElolLlU65teOUjo4ErBpyDGrhVcXfIa0NRFZQxAKoxvbsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnSmfQS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ECCC4CED1;
	Thu, 26 Dec 2024 05:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735189895;
	bh=hMWe1F1OxukWskRCOoiu/a8QPxfOtfFqxPCj0gu+iHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnSmfQS75DFl3uY2LVDUR/HJi7nfGJtyHIcAJZiZZZO0DKCk6gl9jKRXpCjehJn0E
	 os7MqfExCgfO0+sglH7GT8txEo4G6tziNpGnOx3Z81NMhPwRqj6q4ws0hgQKz5X9Na
	 4U3xx76ZP0bj/PMljw8t5q1Zan+Q2ENUP9JCgZkvgBTIZnQRq9w+eI7Y7S8H2q+Ygq
	 YBXt40CEOvAnOue1NG/sj6AtgxnrPaW1D9POgFqS+iBR7atu1zOX7h9vIEv3L0ECQF
	 2/HpG3vT2j6qxY6dGIDcX2/VhgXWTbQUYrCqG5JQO32zBxOEGZbvpbL9EEMpu0IFyg
	 aN5rMY4MwktKQ==
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
Subject: [PATCH v22 01/20] fgraph: Get ftrace recursion lock in function_graph_enter
Date: Thu, 26 Dec 2024 14:11:27 +0900
Message-ID: <173518988774.391279.3775714727105430969.stgit@devnote2>
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
index ddedcb50917f..5c68d6109119 100644
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
 



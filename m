Return-Path: <linux-arch+bounces-9274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E09E61E8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 01:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF95A1884F6C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B268F5B;
	Fri,  6 Dec 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqE6aClu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8200819;
	Fri,  6 Dec 2024 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443882; cv=none; b=Bs1bm8ZMSjtzngt7tF5NJF1JXPN+J/L1/o9Wacb3uiAXBTilo/MwaRyFt9VCeVmV3sxvZbchItnUfbYQ7y0hNcQ6jTmoMsKjKWKvUyQMsMhKV9IfjAHXrG/BUoPRtte/eCU+fIK/RRze1WiGrqLYzvh5CPeK4JW68gmjkjs0xEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443882; c=relaxed/simple;
	bh=IcLMaFOjbxnAA4ujm/xxsUJzK9YIQFWOH3mZCpPMaP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUzgU8STiJ83RGx/TJwzq+3FzkpUPusdACDrypxpXsw/5RvjDa93MyPlFtpznQ22G8yX5gihNFsDGBZ4po8MIsf9bOpOmkkEQNwOt4Dc91l00rhbkJcd7IHMl/iMi35Lb7y1aG5mASNbhAGUmfXas0Kz3xEhB4KnUbpgk5o9OeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqE6aClu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683F5C4CED1;
	Fri,  6 Dec 2024 00:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443881;
	bh=IcLMaFOjbxnAA4ujm/xxsUJzK9YIQFWOH3mZCpPMaP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqE6aCluQMeAbUatVTxx8Z8Xj8lLinyTI+ifvjbbWkzICdkdYu/cJj4iExBaMzoqu
	 SL1gwPVEKUTQ/HAr39Q6PhnfvXqTJv6iC2oeteKe/tETqh9eiF6d4Akgf4gJ4itzf0
	 hVE7MSGF82lx3FZD0Igc3RXglRiiF3A0bW0MGQBoH10NoNbuWV+GVxey8Fj3RJBgEn
	 sdKHmUuLegqqlfaL5wwQlUzY26Czr7Wb9KI1DUGIZfod37/iiXEPMIuKnnk7CoQWk3
	 vr9uFaiCscK4i226hlPU+PThhIBBIoAeRVpmuO8XehWiVxw24sGedpeMB1/O6J7v3Y
	 +iRDr2judxDNw==
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
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v20 11/19] s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
Date: Fri,  6 Dec 2024 09:11:16 +0900
Message-ID: <173344387598.50709.7225604567319784292.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173344373580.50709.5332611753907139634.stgit@devnote2>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Sven Schnelle <svens@linux.ibm.com>

Add ftrace_graph_func() which is required for fprobe to access registers.
This also eliminates the need for calling prepare_ftrace_return() from
ftrace_caller().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 Changes in v19:
  - Newly added.
---
 arch/s390/Kconfig              |    1 +
 arch/s390/include/asm/ftrace.h |    5 ++++
 arch/s390/kernel/entry.h       |    1 -
 arch/s390/kernel/ftrace.c      |   48 ++++++++++++----------------------------
 arch/s390/kernel/mcount.S      |   11 ---------
 5 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d8eee56c10b6..622ea2e9a87e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -190,6 +190,7 @@ config S390
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5b7cb49c41ee..fd3f0fe9f7b3 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -39,6 +39,7 @@ struct dyn_arch_ftrace { };
 
 struct module;
 struct dyn_ftrace;
+struct ftrace_ops;
 
 bool ftrace_need_init_nop(void);
 #define ftrace_need_init_nop ftrace_need_init_nop
@@ -122,6 +123,10 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	return !strcmp(sym + 7, name) || !strcmp(sym + 8, name);
 }
 
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 21969520f947..a1f28879c87e 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -41,7 +41,6 @@ void do_restart(void *arg);
 void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
 int setup_profiling_timer(unsigned int multiplier);
-unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
 
 struct s390_mmap_arg_struct;
 struct fadvise64_64_args;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 51439a71e392..c0b2c97efefb 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -261,43 +261,23 @@ void ftrace_arch_code_modify_post_process(void)
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-/*
- * Hook the return address and push it in the stack of return addresses
- * in current thread info.
- */
-unsigned long prepare_ftrace_return(unsigned long ra, unsigned long sp,
-				    unsigned long ip)
-{
-	if (unlikely(ftrace_graph_is_dead()))
-		goto out;
-	if (unlikely(atomic_read(&current->tracing_graph_pause)))
-		goto out;
-	ip -= MCOUNT_INSN_SIZE;
-	if (!function_graph_enter(ra, ip, 0, (void *) sp))
-		ra = (unsigned long) return_to_handler;
-out:
-	return ra;
-}
-NOKPROBE_SYMBOL(prepare_ftrace_return);
 
-/*
- * Patch the kernel code at ftrace_graph_caller location. The instruction
- * there is branch relative on condition. To enable the ftrace graph code
- * block, we simply patch the mask field of the instruction to zero and
- * turn the instruction into a nop.
- * To disable the ftrace graph code the mask field will be patched to
- * all ones, which turns the instruction into an unconditional branch.
- */
-int ftrace_enable_ftrace_graph_caller(void)
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	/* Expect brc 0xf,... */
-	return ftrace_patch_branch_mask(ftrace_graph_caller, 0xa7f4, false);
-}
+	unsigned long *parent = &arch_ftrace_regs(fregs)->regs.gprs[14];
+	int bit;
 
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	/* Expect brc 0x0,... */
-	return ftrace_patch_branch_mask(ftrace_graph_caller, 0xa704, true);
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+	bit = ftrace_test_recursion_trylock(ip, *parent);
+	if (bit < 0)
+		return;
+	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
+		*parent = (unsigned long)&return_to_handler;
+	ftrace_test_recursion_unlock(bit);
 }
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 2b628aa3d809..1fec370fecf4 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -104,17 +104,6 @@ SYM_CODE_START(ftrace_common)
 	lgr	%r3,%r14
 	la	%r5,STACK_FREGS(%r15)
 	BASR_EX	%r14,%r1
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-# The j instruction gets runtime patched to a nop instruction.
-# See ftrace_enable_ftrace_graph_caller.
-SYM_INNER_LABEL(ftrace_graph_caller, SYM_L_GLOBAL)
-	j	.Lftrace_graph_caller_end
-	lmg	%r2,%r3,(STACK_FREGS_PTREGS_GPRS+14*8)(%r15)
-	lg	%r4,(STACK_FREGS_PTREGS_PSW+8)(%r15)
-	brasl	%r14,prepare_ftrace_return
-	stg	%r2,(STACK_FREGS_PTREGS_GPRS+14*8)(%r15)
-.Lftrace_graph_caller_end:
-#endif
 	lg	%r0,(STACK_FREGS_PTREGS_PSW+8)(%r15)
 #ifdef MARCH_HAS_Z196_FEATURES
 	ltg	%r1,STACK_FREGS_PTREGS_ORIG_GPR2(%r15)



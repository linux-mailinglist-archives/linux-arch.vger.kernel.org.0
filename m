Return-Path: <linux-arch+bounces-7317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E09795F3
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D33283285
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9056A1C579C;
	Sun, 15 Sep 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4cDITL6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409F2E822;
	Sun, 15 Sep 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391469; cv=none; b=WE+rpgf+m5t3wswq6Gk5dRlYfJA2j893WR43Vsrv0g0Fj+2P6YDDtpAja6tee1WhSKASi8vdVsJI83DVzc1gqrff9Che16Al9J1E2539cOPqll/FQej4OKAG7ArbWF3G7/i0YTF9S9GyR2rOdmYQGEYgjHCh71vk3YMDuS3NYis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391469; c=relaxed/simple;
	bh=qY+sHzbXQZpWGAHIfO/SJUlQuPBYvVIhmPx03bMzAg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdnIvCmsG4TDFcuYQlD1F17DcA0dgG4CSmt8QJCi0xS9/2FB9l02Ad7SlqWoAxolCoJRZwnz2prjNQq+1XsFpRfwKEsoF0+UtkttegqoDkbBp/fJIMGoVdaWCHi6zGc2ABJ29cP/72eG9dV0VmQgTvtIMc4UQQn2lDbKkB2Jxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4cDITL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B18C4CEC3;
	Sun, 15 Sep 2024 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391469;
	bh=qY+sHzbXQZpWGAHIfO/SJUlQuPBYvVIhmPx03bMzAg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4cDITL62brHS/le2p2QDJoXziKTQSEvxQJg0y7LyAtQhvTGQhQmXaqnbaBcHrlFY
	 tl0/JduiDCiRBg9tr/eYSdw5y3oR/WqBJg+0OyzNCNFkBqn6TmCur1WMRdRU9WX2wk
	 LVTB7imYHYS30dWOHcmcnkwmiWjnDcAnEnUMH6Hqr6NmUXgdhb0+R+fXXMId8WbBry
	 2k21Ygil/jK9P7TU2NX9+IRWE7T6DdbSkq+fWNQ1/ECPmjCTAi4sHmKpp7Vk46uLN0
	 ypd4x6f7bT1o9arNZ1aJ36WBN3KdHYPmHiVJIaCgXza89HoAyPGMV+9sJNNW7Fikir
	 kWj+u/+szt3cw==
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
Subject: [PATCH v15 08/19] tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Sun, 15 Sep 2024 18:11:03 +0900
Message-Id: <172639146339.366111.5820487904166214151.stgit@devnote2>
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

Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
This is for the eBPF which needs this to keep the same pt_regs interface
to access registers.
Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
used by kprobe_multi eBPF event), this will be used.

If the architecture defines its own ftrace_regs, this copies partial
registers to pt_regs and returns it. If not, ftrace_regs is the same as
pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
---
 Changes in v14:
  - Add riscv change.
 Changes in v8:
  - Add the reason why this required in changelog.
 Changes from previous series: NOTHING, just forward ported.
---
 arch/arm64/include/asm/ftrace.h |   11 +++++++++++
 arch/riscv/include/asm/ftrace.h |   12 ++++++++++++
 include/linux/ftrace.h          |   17 +++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index dffaab3dd1f1..5cd587afab6d 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -132,6 +132,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
 	return fregs->fp;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
+	regs->sp = fregs->sp;
+	regs->pc = fregs->pc;
+	regs->regs[29] = fregs->fp;
+	regs->regs[30] = fregs->lr;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index e9f364ce9fe8..897779dec402 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -193,6 +193,18 @@ static __always_inline void ftrace_override_function_with_return(struct ftrace_r
 	fregs->epc = fregs->ra;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	memcpy(&regs->a0, fregs->args, sizeof(u64) * 8);
+	regs->epc = fregs->epc;
+	regs->ra = fregs->ra;
+	regs->sp = fregs->sp;
+	regs->s0 = fregs->s0;
+	regs->t1 = fregs->t1;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 35b5ed8867ca..d6b92a4091b9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -176,6 +176,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
+	defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
+
+static __always_inline struct pt_regs *
+ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	/*
+	 * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=y, ftrace_regs memory
+	 * layout is the same as pt_regs. So always returns that address.
+	 * Since arch_ftrace_get_regs() will check some members and may return
+	 * NULL, we can not use it.
+	 */
+	return &fregs->regs;
+}
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.



Return-Path: <linux-arch+bounces-7318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA139795F6
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87B7282E30
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC81C57B5;
	Sun, 15 Sep 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0VZpBiZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F477198A03;
	Sun, 15 Sep 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391481; cv=none; b=f37GoBvi47fJtyxXcUPXR5Qb270voyrsSCmzHqlizwxrW5RQG0TqTJUmJ1AGnV5wUpKA9PV3bJA/cZME4cqSOZvxMTrH59xKPPkcX2oFHrdwq8nR19LHH6aVL2CAnvEB3ggxWEFCVAQZsXel/YbEiE37nXxuGlM8mKg8a2SithA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391481; c=relaxed/simple;
	bh=jzcP0Kf9MEyvKFO0ZqA0KPrTGBAQopcpINkVM+ZGHnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJlCKHC2Gh74qQJPR1OLNf7efvsBMOkUvur97toPX4B6FQAMfi+tfalQ1EsS3W+HXs4C8louis5umxvgOVwLmOQYh5Pup8nyvaLjJt51EJdff6CXd5kl2dru3RP8F9aZjg1BI4typYeSDB9h062+K7ZNeQ16eogKRBZF7hEuwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0VZpBiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9519C4CEC3;
	Sun, 15 Sep 2024 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391480;
	bh=jzcP0Kf9MEyvKFO0ZqA0KPrTGBAQopcpINkVM+ZGHnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0VZpBiZ2qNf7JyMUJ0K0gCEiVbx32s39+ZfQw71xOfOQyLolxa2eV/AVmLm2i7w9
	 LkyxpH53+lFviBVZjFk72ePmFjWk1I76ywOM6sopNn/Ko6muckDmtEMmRyw9XdFdgg
	 C+YJZYShKPfXvIv1rMnQFtxR5KpWOBtUkasi56yXZpvqihB+IHoHA/oFEwaJYcDyMv
	 +YZdZziSU6Hzng8jFkGBA7JPfmL8L6LFIG4aYdP9YSD7L2vBgWwEEqnxIGDhtxD2Oo
	 eVOf3ZzCqb5TvxycsjAnasDWJRcdvAi6MzIrV/upxg1wq5NpF8E9Ll+Dw5LeH74h8K
	 fH3fPc2GN3K8A==
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
Subject: [PATCH v15 09/19] tracing: Add ftrace_fill_perf_regs() for perf event
Date: Sun, 15 Sep 2024 18:11:14 +0900
Message-Id: <172639147435.366111.834128908630424679.stgit@devnote2>
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

Add ftrace_fill_perf_regs() which should be compatible with the
perf_fetch_caller_regs(). In other words, the pt_regs returned from the
ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
used for stack tracing.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes from previous series: NOTHING, just forward ported.
---
 arch/arm64/include/asm/ftrace.h   |    7 +++++++
 arch/powerpc/include/asm/ftrace.h |    7 +++++++
 arch/s390/include/asm/ftrace.h    |    5 +++++
 arch/x86/include/asm/ftrace.h     |    7 +++++++
 include/linux/ftrace.h            |   31 +++++++++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5cd587afab6d..14ecb9a418d9 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -143,6 +143,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
+		(_regs)->pc = (fregs)->pc;			\
+		(_regs)->regs[29] = (fregs)->fp;		\
+		(_regs)->sp = (fregs)->sp;			\
+		(_regs)->pstate = PSR_MODE_EL1h;		\
+	} while (0)
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 23d26f3afae4..e6ff6834bf7e 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -42,6 +42,13 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return fregs->regs.msr ? &fregs->regs : NULL;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
+		(_regs)->result = 0;				\
+		(_regs)->nip = (fregs)->regs.nip;		\
+		(_regs)->gpr[1] = (fregs)->regs.gpr[1];		\
+		asm volatile("mfmsr %0" : "=r" ((_regs)->msr));	\
+	} while (0)
+
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 9cdd48a46bf7..0d9f6df21f81 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -84,6 +84,11 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
 	return sp[0];	/* return backchain */
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
+		(_regs)->psw.addr = (fregs)->regs.psw.addr;		\
+		(_regs)->gprs[15] = (fregs)->regs.gprs[15];		\
+	} while (0)
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 669771ef3b5b..1f4d1f7b19ed 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -46,6 +46,13 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	return &fregs->regs;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {	\
+		(_regs)->ip = (fregs)->regs.ip;		\
+		(_regs)->sp = (fregs)->regs.sp;		\
+		(_regs)->cs = __KERNEL_CS;		\
+		(_regs)->flags = 0;			\
+	} while (0)
+
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { (fregs)->regs.ip = (_ip); } while (0)
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index d6b92a4091b9..cc6bf05a9992 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -193,6 +193,37 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+
+/*
+ * Please define arch dependent pt_regs which compatible to the
+ * perf_arch_fetch_caller_regs() but based on ftrace_regs.
+ * This requires
+ *   - user_mode(_regs) returns false (always kernel mode).
+ *   - able to use the _regs for stack trace.
+ */
+#ifndef arch_ftrace_fill_perf_regs
+/* As same as perf_arch_fetch_caller_regs(), do nothing by default */
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {} while (0)
+#endif
+
+static __always_inline struct pt_regs *
+ftrace_fill_perf_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	arch_ftrace_fill_perf_regs(fregs, regs);
+	return regs;
+}
+
+#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+
+static __always_inline struct pt_regs *
+ftrace_fill_perf_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	return &fregs->regs;
+}
+
+#endif
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.



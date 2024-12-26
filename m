Return-Path: <linux-arch+bounces-9498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEF9FC861
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E001E162DA1
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569A184524;
	Thu, 26 Dec 2024 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ1Y3IVn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4114EC4B;
	Thu, 26 Dec 2024 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189988; cv=none; b=r8R6nUled2csbIsgDLBWW2cvTgn2llSiyIBXqBlnWvHKcypr9ByUF4Evw2j5NAkLhv2r04OITWYw43YKK4yt14acshfhZ2AD2sk+Sp1rrw1AQw6XsSzm4w7dFnBe702c+iaYnLP//vKTHezohfQPy2BccRzfuclGqV1k2XjUKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189988; c=relaxed/simple;
	bh=WEydtppxGAlLXphghSt9i4OW2/gUqa+fnfF2J2aGZmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6zVuAyJqiOpP5Q7nSKe3GAt7C+1peGLdOx3tNk6woDvaPGVUrG00JEuiVmr1XKntZG0J2p3Tsixds/MTVjMWjpIgdj1U/eBxZSHJYvseKSFTm4E08Co27wiEwYNOmbRD7QO77lrMK1CH99l5ALjhXTJtijZztXK1FcRKmpZlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ1Y3IVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1EDC4CED1;
	Thu, 26 Dec 2024 05:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735189988;
	bh=WEydtppxGAlLXphghSt9i4OW2/gUqa+fnfF2J2aGZmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQ1Y3IVnhlC8sqhxK6p/cE4i93VxoM1ZvZoAShrTv9n6Ad9m2jb4wRCpO+T2OuJNL
	 JrC5HYY79FTs8sACcAZxpXoDeWjmpKComCgjqnuNUb1v5TGsJ9DR5AiRRKt7K+JdN4
	 9PoWZoOBTISI65BEO4s/u3Lj9Hl9FJ7Y+wah8cSlWa/Aph7AtLKCP0DW1HEpXPAinV
	 aJLbl+kKxG48rhlOGhLYx9RDaGQ4LcDArYMaeCQm31WnDy9xcWOc6ngAiavYAWy946
	 DGgYZFOz5zk6dcGxREU+GObR9A56aXIzQp23SkUr3J9F0XezwSY3edp7MCDT3K9CbW
	 LpHjs911Irogw==
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
	Will Deacon <will@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v22 08/20] tracing: Add ftrace_fill_perf_regs() for perf event
Date: Thu, 26 Dec 2024 14:12:59 +0900
Message-ID: <173518997908.391279.15910334347345106424.stgit@devnote2>
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

Add ftrace_fill_perf_regs() which should be compatible with the
perf_fetch_caller_regs(). In other words, the pt_regs returned from the
ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
used for stack tracing.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>

---
  Changes in v16:
   - Fix s390 to clear psw.mask according to Heiko's suggestion.
---
 arch/arm64/include/asm/ftrace.h   |    7 +++++++
 arch/powerpc/include/asm/ftrace.h |    7 +++++++
 arch/s390/include/asm/ftrace.h    |    6 ++++++
 arch/x86/include/asm/ftrace.h     |    7 +++++++
 include/linux/ftrace.h            |   31 +++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 09210f853f12..10e56522122a 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -148,6 +148,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
+		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
+		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
+		(_regs)->sp = arch_ftrace_regs(fregs)->sp;			\
+		(_regs)->pstate = PSR_MODE_EL1h;		\
+	} while (0)
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index db481b336bca..fe181bafdca4 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -43,6 +43,13 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return arch_ftrace_regs(fregs)->regs.msr ? &arch_ftrace_regs(fregs)->regs : NULL;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
+		(_regs)->result = 0;				\
+		(_regs)->nip = arch_ftrace_regs(fregs)->regs.nip;		\
+		(_regs)->gpr[1] = arch_ftrace_regs(fregs)->regs.gpr[1];		\
+		asm volatile("mfmsr %0" : "=r" ((_regs)->msr));	\
+	} while (0)
+
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5c94c1fc1bc1..5b7cb49c41ee 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -76,6 +76,12 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
 	return ftrace_regs_get_stack_pointer(fregs);
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
+		(_regs)->psw.mask = 0;					\
+		(_regs)->psw.addr = arch_ftrace_regs(fregs)->regs.psw.addr;		\
+		(_regs)->gprs[15] = arch_ftrace_regs(fregs)->regs.gprs[15];		\
+	} while (0)
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index d61407c680c2..7e06f8c7937a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -47,6 +47,13 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	return &arch_ftrace_regs(fregs)->regs;
 }
 
+#define arch_ftrace_fill_perf_regs(fregs, _regs) do {	\
+		(_regs)->ip = arch_ftrace_regs(fregs)->regs.ip;		\
+		(_regs)->sp = arch_ftrace_regs(fregs)->regs.sp;		\
+		(_regs)->cs = __KERNEL_CS;		\
+		(_regs)->flags = 0;			\
+	} while (0)
+
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { arch_ftrace_regs(fregs)->regs.ip = (_ip); } while (0)
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ad2b46e1d5b0..6d29c640697c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -207,6 +207,37 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
 
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
+	return &arch_ftrace_regs(fregs)->regs;
+}
+
+#endif
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.



Return-Path: <linux-arch+bounces-8957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0699C3391
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EC7B2108E
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D613C3D3;
	Sun, 10 Nov 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lin1a3x3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFDF13B2BB;
	Sun, 10 Nov 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253946; cv=none; b=UwSlu+neKg0wu/UHJ+Np4eOncFbG0kN74MZ2Hai83i5q1hC4HkvMfNDdGG2a60jcp826iBmfhoZ1wVWktDH+5rfirdT5BMvzfsN4TES56LTrcAVH0xA7hggOHBUggWTnzzYVP+gJhQZcswU+XXvPvI+SnutPphmHdWo88I/Fpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253946; c=relaxed/simple;
	bh=ljV+7i1gHE0GvTLzOVr5+Punuc1M73hF7pzOK4hFm44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl5XEHKXOi0M487ZPN+jCU81OR1FqwoduD6dXNEBlXZzPVAe4KRoJUt4dRXCUqkhr6Fjx+h2TMXpQkmg8E1MKCyHnjIZtFkHSLXjqhgd0vxyYonXkhVLO9qUN6FehUBG05LtuUe9Vua4b1IFUfAw5DmDH2ua1rW6mTGo/DPvVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lin1a3x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461D5C4CECD;
	Sun, 10 Nov 2024 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253946;
	bh=ljV+7i1gHE0GvTLzOVr5+Punuc1M73hF7pzOK4hFm44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lin1a3x3MSmgk9wJ/NIjgm7RnFE4+WmlXVL2U66a+fB0n5PeT0BwBbla/o28K+Boj
	 yssTIfvtB2Ax6W8DL7uKoeIULorJTjpNp18r7bXvTFfpsUlBZ+llnka4fmKrqsAXam
	 NAo+DzTU/+Z+/8b3Kl/RWcGSi1zvhIZ+3VgAEP3lSdtusLkO8hUNC+S5VQhJNZAOwQ
	 O5NPICO5WFjg5BjJ73E9kd0dXY9WLl9MNNjNL7BUkKHdyR3gCp1ynSED4SqVhJWPNf
	 3MwF3leOKIVisU4pmsCZ04IxXL1z+SDE3ztPs7Xa1WXg4/PznTKNePwPYA4kzeBnC7
	 4KNK67sSPfL5w==
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
Subject: [PATCH v19 18/19] ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
Date: Mon, 11 Nov 2024 00:52:21 +0900
Message-ID: <173125394102.172790.7669548166614384865.stgit@devnote2>
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

This introduces ftrace_get_symaddr() which tries to convert fentry_ip
passed by ftrace or fgraph callback to symaddr without calling
kallsyms API. It returns the symbol address or 0 if it fails to
convert it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v19:
  - Newly added.
---
 arch/arm64/include/asm/ftrace.h |    2 +
 arch/arm64/kernel/ftrace.c      |   63 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/ftrace.h   |   21 +++++++++++++
 include/linux/ftrace.h          |   13 ++++++++
 4 files changed, 99 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 876e88ad4119..f08e70bf09ea 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -52,6 +52,8 @@ extern unsigned long ftrace_graph_call;
 extern void return_to_handler(void);
 
 unsigned long ftrace_call_adjust(unsigned long addr);
+unsigned long arch_ftrace_call_adjust(unsigned long fentry_ip);
+#define ftrace_call_adjust(fentry_ip) arch_ftrace_call_adjust(fentry_ip)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 #define HAVE_ARCH_FTRACE_REGS
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 606fd6994578..de1223669758 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -143,6 +143,69 @@ unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+/* Convert fentry_ip to the symbol address without kallsyms */
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
+{
+	u32 insn;
+
+	/*
+	 * When using patchable-function-entry without pre-function NOPS, ftrace
+	 * entry is the address of the first NOP after the function entry point.
+	 *
+	 * The compiler has either generated:
+	 *
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * func-04:		BTI	C
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * The fentry_ip is the address of `BL <caller>` which is at `func + 4`
+	 * bytes in either case.
+	 */
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
+		return fentry_ip - AARCH64_INSN_SIZE;
+
+	/*
+	 * When using patchable-function-entry with pre-function NOPs, BTI is
+	 * a bit different.
+	 *
+	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
+	 * func+04:		NOP		// To be patched to BL <caller>
+	 *
+	 * Or:
+	 *
+	 * func+00:	func:	BTI	C
+	 * func+04:		NOP		// To be patched to MOV X9, LR
+	 * func+08:		NOP		// To be patched to BL <caller>
+	 *
+	 * The fentry_ip is the address of `BL <caller>` which is at either
+	 * `func + 4` or `func + 8` depends on whether there is a BTI.
+	 */
+
+	/* If there is no BTI, the func address should be one instruction before. */
+	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
+		return fentry_ip - AARCH64_INSN_SIZE;
+
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
+		if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2)))
+			return 0;
+	} else {
+		insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
+	}
+
+	if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
+		return fentry_ip - AARCH64_INSN_SIZE * 2;
+
+	return fentry_ip - AARCH64_INSN_SIZE;
+}
+
 /*
  * Replace a single instruction, which may be a branch or NOP.
  * If @validate == true, a replaced instruction is checked against 'old'.
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index cc92c99ef276..f9cb4d07df58 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -34,6 +34,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
+{
+#ifdef CONFIG_X86_KERNEL_IBT
+	u32 instr;
+
+	/* We want to be extra safe in case entry ip is on the page edge,
+	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
+	 */
+	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
+		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
+			return fentry_ip;
+	} else {
+		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
+	}
+	if (is_endbr(instr))
+		fentry_ip -= ENDBR_INSN_SIZE;
+#endif
+	return fentry_ip;
+}
+#define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
+
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 #include <linux/ftrace_regs.h>
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 4c553fe9c026..9659bb2cd76c 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -652,6 +652,19 @@ struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr);
 
 bool is_ftrace_trampoline(unsigned long addr);
 
+/* Arches can override ftrace_get_symaddr() to convert fentry_ip to symaddr. */
+#ifndef ftrace_get_symaddr
+/**
+ * ftrace_get_symaddr - return the symbol address from fentry_ip
+ * @fentry_ip: the address of ftrace location
+ *
+ * Get the symbol address from @fentry_ip (fast path). If there is no fast
+ * search path, this returns 0.
+ * User may need to use kallsyms API to find the symbol address.
+ */
+#define ftrace_get_symaddr(fentry_ip) (0)
+#endif
+
 /*
  * The dyn_ftrace record's flags field is split into two parts.
  * the first part which is '0-FTRACE_REF_MAX' is a counter of



Return-Path: <linux-arch+bounces-9281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC19E6201
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 01:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8BB168DCE
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70231CFB6;
	Fri,  6 Dec 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoksD5GG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979914F90;
	Fri,  6 Dec 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443966; cv=none; b=ZTABAvvzX/49wSnA7BQueAvp/tfj48CylvBp8Cfm1m25E2H1N190XJRD9CBJEWXhLMce9QTzwKfaZBdsDyvbgTBXGyMfDqjeLRHkcSG+I8Rh/dXk/PDBMA3d1q1MfCJvGbHMyQh3QWgeUf0s56C6WimQgFo+HLFo39kcIdqoKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443966; c=relaxed/simple;
	bh=o30VIrd/1GcGRTzhKdK9PfjKtWuWZz4RS9+3nBbYnyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzSoJlgL8TDpMP4KxZYEKLKCZUtxl/aedq4z76SxKlhy1IaZYeBEPSfPRiKPZc52nDkM2454WiAbUnEisYy8NT7q7lUMvDvGGErO5yiUabG0qW4l6KfreZWyVJB0wynULak1KvwU5tEMm25395KjBdoO1opRJp8MW040HrkzZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoksD5GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3489DC4CED1;
	Fri,  6 Dec 2024 00:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443966;
	bh=o30VIrd/1GcGRTzhKdK9PfjKtWuWZz4RS9+3nBbYnyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoksD5GGVzUkG8+ATYpuytJVfHKQiEZqbDtoujxfhMe4HFr1LLIDC70Puyb/2hLVg
	 bn+/5dshwosjHa/BhX2FTjFhJFZG4wjcasYQuEYwDeT3ywFq9PELg3/rj4XgRL3VmA
	 gB1YimakxYMgf1hZbKYTTfvZCdm0Jkk3FxiTI9DI3tDDmJoMb8Kj0wL3JpV6DHw6Ry
	 GHZarWozjgZSTUO2zLkuFfxZEE2XGA4anp8r4pUN1rAt8iaonpFgNyYtEdXmUJ0KUO
	 fUJXPMUC3ne3jh5cvrdBFZ48ntAbp0r26P0BY3FeZtI2NmQihdcAwtC7uySbOrLigg
	 F7f72Cdsr0ivQ==
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
Subject: [PATCH v20 18/19] ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
Date: Fri,  6 Dec 2024 09:12:40 +0900
Message-ID: <173344396077.50709.15571140954397859402.stgit@devnote2>
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
index 570c38be833c..d7c0d023dfe5 100644
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



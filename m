Return-Path: <linux-arch+bounces-9509-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C29B9FC885
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88C27A10D7
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86791C07C9;
	Thu, 26 Dec 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWyO/kc8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E717A5BD;
	Thu, 26 Dec 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735190120; cv=none; b=iodiQKjm0BrydzqHW40CVpxJfcNwhpVrjmgeJI1jdbG5LK1caDDloDEvDr6d7aUGCR40C7vC5ggKYoar9eayhYhBp1kr8Xso33q8OuLC1Ea1kNJaz5hhEdMy4Ht0CaFdBxJa1EvIJ6jBrg3fSZ94YD+WK3ig3zwPdjquWHp403s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735190120; c=relaxed/simple;
	bh=9va72ODfucc7cqmw0txKETTc3HsuWXfOWpU9LW15yRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqJFKMgKCQ9aIRJ9d8r2WsjDm52zYbRyxDcoV6ac4ad0eoQxlp8sc5aw0KvSPLbKTzT+17GAysFrtjRyhF6SzA5qcP28W1uXzdXvPV0LKrAdt5GtmXW5gMAQuyajql9M9lfjPGOeg5GY3P1hbW+7FFp7RDdN5AkpD2NPOC8I6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWyO/kc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3588DC4CED1;
	Thu, 26 Dec 2024 05:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735190120;
	bh=9va72ODfucc7cqmw0txKETTc3HsuWXfOWpU9LW15yRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWyO/kc89ZPvrWtL90CDWnmI39xdsi19Y2cEhHcqM/QrSXA58BQPT61SS22nuNf0P
	 /y6NFuPAwak8ZQNtDwvDnt/dwo14wU7z5yJ9YbJLaTvbdOG2/59BZX2DOu2FS3yQDU
	 wXrNJDM39eugYJTlCHueO58XLGKk2rcUxRgyQp0JSGAXbuF0vHJyhEn3sE0cEWokcG
	 sfXT3U9lcWgjVt9BYAu430CbTQ5QHVKZXHaSgp5fXZ5UiLRK8K342oBHBRXa0J58Vk
	 t7KMpwuFnroc9pvsj4rGRT2QGK7cUpgtScKCNSj0JDRGmXT6iovAA6HGl//hvvlAZK
	 uBL0REQ+ifEqQ==
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
	kernel test robot <lkp@intel.com>
Subject: [PATCH v22 19/20] ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
Date: Thu, 26 Dec 2024 14:15:14 +0900
Message-ID: <173519011487.391279.5450806886342723151.stgit@devnote2>
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

This introduces ftrace_get_symaddr() which tries to convert fentry_ip
passed by ftrace or fgraph callback to symaddr without calling
kallsyms API. It returns the symbol address or 0 if it fails to
convert it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412061423.K79V55Hd-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202412061804.5VRzF14E-lkp@intel.com/
---
 Changes in v21:
  - On arm64, fix the macro name to ftrace_get_symaddr() correctly.
  - Define ftrace_get_symaddr() outside of CONFIG_DYNAMIC_FTRACE.
 Changes in v19:
  - Newly added.
---
 arch/arm64/include/asm/ftrace.h |    2 +
 arch/arm64/kernel/ftrace.c      |   63 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/ftrace.h   |   21 +++++++++++++
 include/linux/ftrace.h          |   13 ++++++++
 4 files changed, 99 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 876e88ad4119..bfe3ce9df197 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -52,6 +52,8 @@ extern unsigned long ftrace_graph_call;
 extern void return_to_handler(void);
 
 unsigned long ftrace_call_adjust(unsigned long addr);
+unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
+#define ftrace_get_symaddr(fentry_ip) arch_ftrace_get_symaddr(fentry_ip)
 
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
index 4c553fe9c026..07092dfb21a4 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -622,6 +622,19 @@ enum {
 	FTRACE_MAY_SLEEP		= (1 << 5),
 };
 
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
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 void ftrace_arch_code_modify_prepare(void);



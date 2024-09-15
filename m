Return-Path: <linux-arch+bounces-7328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5336F979617
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72B81F229B1
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792C1C7B61;
	Sun, 15 Sep 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msfUnc3F"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFC1C6F76;
	Sun, 15 Sep 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391597; cv=none; b=cAiZt7WMlKONEKGOI9te4UscyK//l+1z62C7CF6yrBE9mP8Q7yu0gCEf388TjcLeZ+YeLjl5pLcf13seAPLoFNwTAz/IcvlJHNTGHQQ8LWUDarkNBCO3icj4LMceSVwbqdhudAWsmhB7RczIw0E08wSPco8/R51qXcH8E1BAkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391597; c=relaxed/simple;
	bh=JV1GgN6T0Zh2KuKA5Xe9GKQ+DqDxKyu3Jh2ePZpyuHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaIX31hZZQs1BqRNGQFXOf4fn4JlsFclzOjK1QXa/w15GlRAKUduDyjURNEI9KHh6SI3/f+4ci52CVg/Ys3cVQ2VihheMM5ObskyFZffaCXDnZ5sIkIC+3GCSKCcuLqbG4B8XLNSuRiImkyPTJAQCf3cUDRpUBk+QnRWg9OlYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msfUnc3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCE7C4CECF;
	Sun, 15 Sep 2024 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391596;
	bh=JV1GgN6T0Zh2KuKA5Xe9GKQ+DqDxKyu3Jh2ePZpyuHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msfUnc3FSomoITt9e/DIor3966RWa3UpOYczhmVcK53q7F09ZoNLD6+QC2mLd+Sh2
	 G+8zCn/dGDah3USf4qAkwEt30QfNs+p8PCHcQQvsn7Kif+GyKYS1TefRJaIcpWCmKJ
	 c8gyYMCAQPxP+rKc/fct+EF2SMzL2tbkOhiEIxUvgHju0IX3GIbh3CSZJW8WPkCAmy
	 vlOWGyUXmXLNYPIRuJkOvk0Tse3RDb6HNgrjiZXOoC5ENtMy/i7GkYbisqJIvSpAQO
	 qBy9f7ejk5C3Cql5yPmCUn323coBvVGSGRjjsS7ETtLgrQhbMSn3A5JxzTpbggQA77
	 ScZSg48nw3v3w==
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
Subject: [PATCH v15 19/19] bpf: Add get_entry_ip() for arm64
Date: Sun, 15 Sep 2024 18:13:09 +0900
Message-Id: <172639158914.366111.5959423373874301115.stgit@devnote2>
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

Add get_entry_ip() implementation for arm64. This is based on the
information in ftrace_call_adjust() on arm64. Basically function entry
address = ftrace call entry_ip - 4, but when there is a BTI at the first
instruction, we need one more instruction back (entry_ip - 8.)

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/bpf_trace.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index deb629f4a510..60e7ff16f56f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1066,6 +1066,70 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
 		fentry_ip -= ENDBR_INSN_SIZE;
 	return fentry_ip;
 }
+#elif defined(CONFIG_ARM64)
+#include <asm/insn.h>
+
+static unsigned long get_entry_ip(unsigned long fentry_ip)
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
+			return fentry_ip - AARCH64_INSN_SIZE;
+	} else {
+		insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
+	}
+
+	if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
+		return fentry_ip - AARCH64_INSN_SIZE * 2;
+
+	return fentry_ip - AARCH64_INSN_SIZE;
+}
 #else
 #define get_entry_ip(fentry_ip) fentry_ip
 #endif



Return-Path: <linux-arch+bounces-8147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88299DBA0
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A651F23459
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FE1714CD;
	Tue, 15 Oct 2024 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3j/OZbs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6878015884A;
	Tue, 15 Oct 2024 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955923; cv=none; b=b+C2nsAm61sR5mJUiS1tY/0gSuJuPgn0DT7MdooPi+dxrzdsQxapb71QMOqzrKFqBz8DjwyDYNK4t4G7VH8Mwhpdys79fbI9XbxLMtYw7dLbJpwndbeWhOsibqtCATUSdiWre+oUaqkHF1dvAC+nqMIu4Iugjgk2BFN2NFYlGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955923; c=relaxed/simple;
	bh=5zoBkzFaOJl7tH9L4LSZfLmjahc28XB6pBP4WeEvYWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEikaKlMTHJsNaTNXnL7xvMIZr1JB7Uc44JaqCgfsbaiJLLvRN5GJuUWCouTMtKn1zJaeOLIoFipWCF+O7XgFmwEcc3K57knxo8DsiEY/M+Uizl0i45qWT4yZeVqL5mS4Ip3WDibNPgPZjN7uWFsKEbjGQFvobnvMdVqk5ZlzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3j/OZbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD49C4CEC3;
	Tue, 15 Oct 2024 01:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728955923;
	bh=5zoBkzFaOJl7tH9L4LSZfLmjahc28XB6pBP4WeEvYWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3j/OZbsTW7NGO3C4WQ7+hH4wsDVTjNL6Dz6qUJ4nOtEmHRhSy9HuhowMF/8CmEo+
	 YfHmrVr7ann0yulBxFPco5f8jdM34Tsao+HRtjwmipkvyvbDo7S+iaSnNMAZSwixGK
	 LMLQ68EJZtar9RXphg6Dz0jqXHu6OET/IbL5qNaxN9Hfw8zUlB4JW4QrCFQ1xs6elY
	 Ej8anf7M83puFmleN2Wcf2LNIoFmwDftdSpAGa6PCPiLZ5okpHotUQrsLTp7SToJwO
	 FZRBYzXdrmHtHdBb7avCOqHlf3LNsslhHAz1Bo8h10zGNfBx+ydhsIKeGsXYrO5Yqf
	 pPJIEILRzmbUg==
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
Subject: [PATCH v16 18/18] bpf: Add get_entry_ip() for arm64
Date: Tue, 15 Oct 2024 10:31:58 +0900
Message-ID: <172895591858.107311.3214711054345114072.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172895571278.107311.14000164546881236558.stgit@devnote2>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
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
index edd577297dc2..a7827a0a6d81 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1042,6 +1042,70 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
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



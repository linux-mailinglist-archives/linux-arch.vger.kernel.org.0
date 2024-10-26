Return-Path: <linux-arch+bounces-8610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CA9B14DA
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 06:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CC3B22449
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 04:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49BA17BB13;
	Sat, 26 Oct 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6iVwB08"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581D1531EA;
	Sat, 26 Oct 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729917542; cv=none; b=s4svM8vtuEv03b20G2LUnceqJvjVMJdJuaV+5TswZL2GbVJ4atISw5dFYHarB9un5qT1PgASKVJesERYMDTjStryXpzTi/kOmVK4fqR2bnb/7BlDAercSnbduWa5+Zd47j5mP21AH4sUIlVCUFStGzm3C242ewRsf/fP0WZA4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729917542; c=relaxed/simple;
	bh=n9VtmKQ14GrIslX3iLijN1LRbOtcuO6u1tHZUvreuy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFcW93bafhL2vjxvnd+aDxriqhSIXeJ6JnlYt24M5FO2HsxpF1R27lGEz3ur2ePj23x3Dk9XZGnChlfBQbFToRs8PiDGusOhmURMqqHQSuZoeEgeNea42aFZ5OX78w4HqS0i/HwA09G9OFvwBrIm+xtwTyocGyiSDQ99Ck4ofTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6iVwB08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9208AC4CEC6;
	Sat, 26 Oct 2024 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729917542;
	bh=n9VtmKQ14GrIslX3iLijN1LRbOtcuO6u1tHZUvreuy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6iVwB08XSYCZPjHdIykxIwdG9DjDk+I9Q5iMpupdNGRpuZLHNUXo2Rj2UcGrlCj8
	 yqWhUm3p3ycTNwN/eOOgnbu/sqO9rR3WTKeMcfK1BHeJ1xVcyn/1lxS7UO2ydVHDX2
	 a8xkPHg3rfHeKFtoHxFFnCgh25aGPeXZFr7pB4h79dANN4vBvYt+jPyz/S2/yYlCzl
	 Fg+L1TAHShr/vgFJ7GZvmUMWK6W+ExRoc8Z83vsIGg3srl6JKxiHBEZgAPTY8biTzd
	 xk9DFq2AloJLb4sTJilGVEPd4W/BZGllOeNg+0GJyTqg5Fybd8O/kHgOziF0nwOr+F
	 EShDSQ3Q4ppHQ==
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
Subject: [PATCH v18 17/17] bpf: Add get_entry_ip() for arm64
Date: Sat, 26 Oct 2024 13:38:57 +0900
Message-ID: <172991753721.443985.6962319676929775642.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172991731968.443985.4558065903004844780.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
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
index 1532e9172bf9..d58d1417cbaa 100644
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



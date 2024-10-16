Return-Path: <linux-arch+bounces-8215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4A599FDB7
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 03:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCFF1C27C05
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1FC433D9;
	Wed, 16 Oct 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbZf9n54"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E13C6BA;
	Wed, 16 Oct 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040466; cv=none; b=RaRNTKHf1eaBdxHXSKkYxUe8iKLVckV7A5aYEpOElD8nyHeB/EFxc9My4TBzS9SEJkqK2YRWQiz0heVBrTP4VuIqkzWBNtY0iZrkunhGcc4DbUUZ/TckMeqIDzzIRslJ/gGlV5uzKvexxwMmfkxDwlzq2+CmyQ/n5J1ecl4Vk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040466; c=relaxed/simple;
	bh=5zoBkzFaOJl7tH9L4LSZfLmjahc28XB6pBP4WeEvYWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0+LxZY6kMucZWKAPrfGc71VG7aBVuMWwxtg9QkZiRPCL+M//fkIkdv8nMDXCjk5OfrSFcOzaXuUBIo4e9d82c30ByciA0DwaCHeBDmDqlLvTZkdg1/AO34r3/gng8dUe94LbZWRY41i6Mpv0L1MJJpLAMAmZX/BWnvmU/TRinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbZf9n54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE09C4CEC6;
	Wed, 16 Oct 2024 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040466;
	bh=5zoBkzFaOJl7tH9L4LSZfLmjahc28XB6pBP4WeEvYWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbZf9n54aC3QPC1Cg0MNXH858EDkH+Ga1zvBBXKnOuG7up7QnUt91uugHt2tmxDZG
	 X3w3hOWiCIac1QF1q4XJyuo567Oi/7+aEQTd3O+aofofkGfBDvqBc0BH9F3oJG6EuP
	 CeSyFDU9mqqPRpe4ayVNZujzQYjyCwkilBi0iJdQnloXoBDHVAKE3AScoRhnYRZdkS
	 gO+WmbYHVdHowiFNRrgH6u9UdQAAbviyNdNUIORBBVgtvGadDYYmankqAeTTh+4YeM
	 ltfvqDw4AO3iihdVNAmIA+ffPdPLDGDctQCbAfDILUpssGlx/VG45lIBJGkV3LPc5/
	 PNDg1LJIB2ttw==
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
Subject: [PATCH v17 16/16] bpf: Add get_entry_ip() for arm64
Date: Wed, 16 Oct 2024 10:01:00 +0900
Message-ID: <172904046002.36809.3560480877384724517.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <172904026427.36809.516716204730117800.stgit@devnote2>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
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



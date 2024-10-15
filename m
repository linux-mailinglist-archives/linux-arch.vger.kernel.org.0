Return-Path: <linux-arch+bounces-8130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F0899DB50
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 03:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F132837E8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A514F9FF;
	Tue, 15 Oct 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYGcnd2r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D462B9CD;
	Tue, 15 Oct 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955728; cv=none; b=nmN16jhPpU/Fn3IV1YdjPgSBc5491al0BtBrZ+YJjmdqhc5057FpIKo89UccPePzIIJQz/aybpDs8tDXITMcIw9GSFokxf7R1ebOqWQbhQbJqWSK70Od5+eA7Qbr7feFzOAqWzAc5lGrxOHbjZ+Ik6T8N/ALu4MINkdB20r3vgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955728; c=relaxed/simple;
	bh=RkqCz3RNz4F1OrHvTboC7fWR8n4kP4kSdMFZPUKdbCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcKkJv29vYmFxMPWscSAEszohinLEFvGPBzlnYAj+Ho7OFK6Rp8KPAl9pRUpaCejXR/CmRKywKMqoOPCpYFiqIKCV4G9TB9j1YqE+Q/5z1FkHss6JVbygfovjzhitgy+OzXjCgdiOYNdZ/ZU6/u7/AziQbhqZk4xy/TSxZriAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYGcnd2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA5FC4CEC3;
	Tue, 15 Oct 2024 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728955728;
	bh=RkqCz3RNz4F1OrHvTboC7fWR8n4kP4kSdMFZPUKdbCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYGcnd2rX/w1Tc17s7B2UkAVTkhrVXMP150hrZb8Nmip5R8FI6sNpIAf3hxGPWa4L
	 Dspmy8m+N824dKpNDuvmlO+oyk+TP9KyqILVSWKjRjA7xt1F5HvCD2ETz7XAIMeh6a
	 TF5MSnOOukFqV72DomENLKbfVOX2C3loy7+2pTBzl+47prNyM2m6davDa4TbdfdTzA
	 RWQDuyZSDlmhowd2ER0XYqVIMBWXWw0hiFawi57+ZT0LVicdYMoq50dKcLyz4EDkjj
	 zfSq9bPJdBUxol0AA+czmonFQnPdcjT25/JuOWLLTHHrASylftpt9oBHZEPq0ARMnz
	 VoCKHooh/OgXw==
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
Subject: [PATCH v16 01/18] tracing: Use arch_ftrace_regs() for ftrace_regs_*() macros
Date: Tue, 15 Oct 2024 10:28:43 +0900
Message-ID: <172895572290.107311.16057631001860177198.stgit@devnote2>
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

Since the arch_ftrace_get_regs(fregs) is only valid when the
FL_SAVE_REGS is set, we need to use `&arch_ftrace_regs()->regs` for
ftrace_regs_*() APIs because those APIs are for ftrace_regs, not
complete pt_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace_regs.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index dea6a0851b74..b78a0a60515b 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -17,17 +17,17 @@ struct __arch_ftrace_regs {
 struct ftrace_regs;
 
 #define ftrace_regs_get_instruction_pointer(fregs) \
-	instruction_pointer(arch_ftrace_get_regs(fregs))
+	instruction_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(arch_ftrace_get_regs(fregs), n)
+	regs_get_kernel_argument(&arch_ftrace_regs(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(arch_ftrace_get_regs(fregs))
+	kernel_stack_pointer(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_return_value(fregs) \
-	regs_return_value(arch_ftrace_get_regs(fregs))
+	regs_return_value(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(arch_ftrace_get_regs(fregs), ret)
+	regs_set_return_value(&arch_ftrace_regs(fregs)->regs, ret)
 #define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(arch_ftrace_get_regs(fregs))
+	override_function_with_return(&arch_ftrace_regs(fregs)->regs)
 #define ftrace_regs_query_register_offset(name) \
 	regs_query_register_offset(name)
 



Return-Path: <linux-arch+bounces-7321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E7979601
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D9EB225AF
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794B1C6F7E;
	Sun, 15 Sep 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INs5a7mM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F061C68B4;
	Sun, 15 Sep 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391516; cv=none; b=Rq2qvx9Uc0ESoQdvS8iydHJrmuasqCeg++4BdoQP+Y0zZFj/5wCz+hO3X/vxLki7CfjnXfRb6WIp4ePslIf+8jgUUG9GKT1nCLtDoe677AQGGAj99bl/1rSDQa9TKtIeI1oXRmO1vEHZbPd7ebmtXEskZ4AhSbjsYKaNu5HIdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391516; c=relaxed/simple;
	bh=6HA0IpASV2lPjSE8jsT/ioqYyUxQJEQgO8Ncm+pPfI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNtRS8G9+Jphs0QhQdpXBE4ZCKLpU93dISG155Dq5X2Jgr56BpAVgd+e4IN2TveLS30FxeF1Hy9FX79GJMNDzEF7ySKw++DiVo9Bm3zbonBuzJ+NcOmjfzxkWlREvO4Bonvr6QWJNtx0jM4E8zut4xG5vzKHXX2Txk7BlG/0KA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INs5a7mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C876BC4CEC4;
	Sun, 15 Sep 2024 09:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391515;
	bh=6HA0IpASV2lPjSE8jsT/ioqYyUxQJEQgO8Ncm+pPfI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INs5a7mMzWGu+UtNlzn1LTdCzmnBETllCiFUfRjzxUirQjMneLtNIFSkRm0lXyLaI
	 5YqttKlTXjohDK1FWEyH6XN14rHlS4ap6H1M/pRf0Gj5YIP5YLf5/FFrS534A3eyY0
	 2nH0J6wS6bEasfy0HMCX9oB0zb/rf1hLqOnMB9AcuO5GtYrT0CD8xHW+8Zr3kX/m4j
	 8GbqmUEZTiYX1eth4tuTxhEna30o3itZ6ywjY8ctRVux05zR0og1eTidtVQfSnMWTk
	 HGnWRAHUzHvWdU9xR+9O4B6KFW/+2+5cCOnRW6g8HUAMCyNhFiZ8o0Q4XjIYcvQULh
	 wsbnFttC7ngww==
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
Subject: [PATCH v15 12/19] ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
Date: Sun, 15 Sep 2024 18:11:49 +0900
Message-Id: <172639150909.366111.8501429537914101062.stgit@devnote2>
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

Add CONFIG_HAVE_FTRACE_GRAPH_FUNC kconfig in addition to ftrace_graph_func
macro check. This is for the other feature (e.g. FPROBE) which requires to
access ftrace_regs from fgraph_ops::entryfunc() can avoid compiling if
the fgraph can not pass the valid ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Newly added.
---
 arch/arm64/Kconfig     |    1 +
 arch/loongarch/Kconfig |    1 +
 arch/powerpc/Kconfig   |    1 +
 arch/riscv/Kconfig     |    1 +
 arch/x86/Kconfig       |    1 +
 kernel/trace/Kconfig   |    5 +++++
 6 files changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 17947f625b06..53eb9f36842d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -208,6 +208,7 @@ config ARM64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 73cb657496c8..9f7adca388ec 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -129,6 +129,7 @@ config LOONGARCH
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..aa2669f5b314 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -238,6 +238,7 @@ config PPC
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6e8422269ba4..8f05e9fb7803 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -138,6 +138,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && (CLANG_SUPPORTS_DYNAMIC_FTRACE || GCC_SUPPORTS_DYNAMIC_FTRACE)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS if HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_FREGS
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 59788d8b220e..02863509ebd1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -228,6 +228,7 @@ config X86
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
+	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0fc4c3129c19..c8dfd3a233c6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -34,6 +34,11 @@ config HAVE_FUNCTION_GRAPH_TRACER
 config HAVE_FUNCTION_GRAPH_FREGS
 	bool
 
+config HAVE_FTRACE_GRAPH_FUNC
+	bool
+	help
+	  True if ftrace_graph_func() is defined.
+
 config HAVE_DYNAMIC_FTRACE
 	bool
 	help



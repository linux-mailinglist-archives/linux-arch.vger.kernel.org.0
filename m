Return-Path: <linux-arch+bounces-9282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE79E6207
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 01:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473A518858C2
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1088F66;
	Fri,  6 Dec 2024 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sACSumgP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F48F5B;
	Fri,  6 Dec 2024 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443977; cv=none; b=Er7Bmct+jSWhPhIQEaw2SrSCQIzY7Z9k7Z6mgGncvPBfdNtG5YEnQSXsbrYOq1/oAoVAEr/c8Brlbsfdl6qZBRwRGJR1ENTkdUAfWDLlgwAZtr9AgBDUmi2UnKSlqPn4VkrYPjHpm9wRM2RrZey4WWV+YX+3RH93sSUCc6JD2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443977; c=relaxed/simple;
	bh=BiJkgFbyZWGN3QrnPaBVi1FBGF19OgW996tdjHYY+MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st9Gl5E3J4M1b3Ie8G1x2sI5/WChRE0Njczq7AQgb6gj0bqmaHJPNOSlV8M5yLB9NJhvhGo7KzLlevuzsKUgLvTemKPjEzlay4yx4LlW/wCL2HG/8YSAOR6LKEEhZaWG3fE+B8ldewDcfUGiqJCZSQPpfXHRWvd3R90DInyAAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sACSumgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E25C4CEDD;
	Fri,  6 Dec 2024 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733443976;
	bh=BiJkgFbyZWGN3QrnPaBVi1FBGF19OgW996tdjHYY+MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sACSumgPzbAOgh0aP9gzhIO0B9vUC05c0X+eMvZjd4AgdFR4AxnD09+99uUUa4A2P
	 feA/J7wuFXgtkKuVioxoJTBGPSlu072DKPdSTBQRK+ZH+Ab5X12AvxTvc0vTbNvmvh
	 KjNn+8+ZsrqeVQxIgMQyFf4qAHJnDJDWXks5St1rLAqEsMFVDN/5uCnwc2uJ49UOVD
	 sZxEqypde6H2eB52eYrDihGV7vD6XNbuIVxVRE/hF2suTvPit2taJutt6UM7jY9CLT
	 /EsEj7YePnu+PuormAWPYZBh/Ar/woX5wBt4bYVGmY+RppR6RRIKkXGh3jatYVIYCE
	 GecWstR9txfeA==
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
Subject: [PATCH v20 19/19] bpf: Use ftrace_get_symaddr() in get_entry_ip()
Date: Fri,  6 Dec 2024 09:12:51 +0900
Message-ID: <173344397142.50709.1389323884732382919.stgit@devnote2>
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

Rewrite get_entry_ip() to use ftrace_get_symaddr() macro.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v19:
  - Use ftrace_get_symaddr() instead of introducing new arch dependent code.
  - Also, replace x86 code with ftrace_get_symaddr(), which does the same
   thing.
---
 kernel/trace/bpf_trace.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 852400170c5c..9f9a0d666020 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1048,27 +1048,12 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
-#ifdef CONFIG_X86_KERNEL_IBT
 static unsigned long get_entry_ip(unsigned long fentry_ip)
 {
-	u32 instr;
+	unsigned long ret = ftrace_get_symaddr(fentry_ip);
 
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
-		fentry_ip -= ENDBR_INSN_SIZE;
-	return fentry_ip;
+	return ret ? : fentry_ip;
 }
-#else
-#define get_entry_ip(fentry_ip) fentry_ip
-#endif
 
 BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
 {



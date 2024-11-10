Return-Path: <linux-arch+bounces-8958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49E9C3395
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA828167C
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56925158DD4;
	Sun, 10 Nov 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBRu+jJa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BA13DDDD;
	Sun, 10 Nov 2024 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253957; cv=none; b=mXwXDY10EEnWx0KVm12d7RIjXTOBvtc0EvNxOXRfHKzwUyHs1DUjA2CUYEGtl2W7HQw06umAn85ocDe4hLmlfVlYPJEjJDWMPi8aJXNGvp7bf7Xyi1wy/QPTJ58E5PKEeoEKBl/bbfSUCagAH9qLwwLNP3Kwslfp6G8IYSJYZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253957; c=relaxed/simple;
	bh=kzuMS+tyBQSahtSqkEji9Egz79KXjp5UmvcHMUaWrrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJvNcfERjNXr7W/RM5NdyR1zvZ6tj1d1meN4xNMb2HvV9In067SdGhDhyVTO3rFvCKJeC6nNhCaZFA2n+MRKa0zYYMXrQqf0F5sycgPRD7oo/PbTap5oZHp6OOkcExkzDM7SpzOpAK4Rh/a3DC7q5f4I6R9XGqMwaqr0/gATsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBRu+jJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E562FC4CECF;
	Sun, 10 Nov 2024 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253956;
	bh=kzuMS+tyBQSahtSqkEji9Egz79KXjp5UmvcHMUaWrrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBRu+jJaXPo18SnMpvvYDfvy7jg5vEN6mgf0tmmvOXqbh3FCr7CQM0FhL48yUGbmv
	 jOj8CfVIE0cmu8+WsD2inq5k/um9mUmZDb6s19oWyJvyHWlQxKaE5Fh8tbVXqBynJf
	 zIBgUZB0Dbvdqeslp83y77m0Qk4lXD7vovZr8NAJv0B6BN/HXGNRRZpeuL2akGGSFu
	 +4r+F/r9RGDwokJt6VtZhv3VLzX1oUvYBbcOsuQEkmvDSzKF6ymgYzTFYSHWrsQbyP
	 4ZLwY80bgMqcXqOC5yyJMi9JrVx+hcTKvW22KYR+kEG7eBoQkGiF/6eZ+fiGYCJbj/
	 FCPdNfXSqeU6w==
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
Subject: [PATCH v19 19/19] bpf: Use ftrace_get_symaddr() in get_entry_ip()
Date: Mon, 11 Nov 2024 00:52:31 +0900
Message-ID: <173125395146.172790.15945895464150788842.stgit@devnote2>
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
index 1532e9172bf9..e848a782bc8d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1024,27 +1024,12 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
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



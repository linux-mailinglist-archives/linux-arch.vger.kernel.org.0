Return-Path: <linux-arch+bounces-9335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E909EA4CD
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 03:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C675D188A101
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1B19F118;
	Tue, 10 Dec 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNj7jY21"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACD148FE8;
	Tue, 10 Dec 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796627; cv=none; b=AGOvLeTamFASW3DPFU8ooIPiOhDsaEDMz1GZblxqnoeFHb2yF3A/1hW5769B/P0pZGdj4sYS4Czl27ZdFblKDJWqdM+tzxDM25Y6McEDDYEkalTTv/frggWy6hb3bPpHSa587U60o/jj8Nr6Mcqm5SYnpqXxc/s/IfsKBWgXI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796627; c=relaxed/simple;
	bh=VwgU/FJ/MOK68HNLI5n7pBBrw9lEjFt14etIqRD5i6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kopKxJzoTwDhTyswbFY/t2Ch95Fug2F6OelOuhLt9aae7JcCOpi3V0zvoNvBUv8xxliasuSbh0yFbviQzKcj5+3r15QfSa+G+2GbO9qRhsJQ+7kr6aXJVHB2sdJF+1gPrsF14MEbiTcMewWsLegbVAiBZBgOjPQyj/CvJRHN3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNj7jY21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D91C4CED1;
	Tue, 10 Dec 2024 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796626;
	bh=VwgU/FJ/MOK68HNLI5n7pBBrw9lEjFt14etIqRD5i6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNj7jY21L224I76c0GDQnUGNRlyMJfWnktIZSAtYk0uvN5d+oBG+M7e7ZrPW+P+dc
	 Sa/MNrfiyPKANA0eKIlTGsSDtZfLKNgGkvrO7jeFKcghH4uoyr/nUGx2Ubt1pkYMCA
	 OOSlx8EkHDEgMOsOQ7IMEPB6F8Lbz/BMdasIzSKA5ctpuSry0/m3f8oi9/Zx7W8lLR
	 7vtp8sllZlyjolCS0mADRng+ZM6cwvogvuKKRaiT8fB+8jhz/wU5O0QLgn4Ima6vSh
	 ORJuPVmFw3U3qBtg9e1K7l8M8hr/Cg5rhIY8QhLFGGNWfy5h9HBf/r5Rh4R+kTS1gy
	 iY6fGHIiwFQYQ==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v21 07/20] tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
Date: Tue, 10 Dec 2024 11:10:20 +0900
Message-ID: <173379662014.973433.684377805356846455.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173379652547.973433.2311391879173461183.stgit@devnote2>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
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

Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
This is for the eBPF which needs this to keep the same pt_regs interface
to access registers.
Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
used by kprobe_multi eBPF event), this will be used.

If the architecture defines its own ftrace_regs, this copies partial
registers to pt_regs and returns it. If not, ftrace_regs is the same as
pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Florent Revest <revest@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>

---
 Changes in v18:
  - Fix to use sizeof() for calculating array size.
 Changes in v14:
  - Add riscv change.
 Changes in v8:
  - Add the reason why this required in changelog.
 Changes from previous series: NOTHING, just forward ported.
---
 arch/arm64/include/asm/ftrace.h |   13 +++++++++++++
 arch/riscv/include/asm/ftrace.h |   14 ++++++++++++++
 include/linux/ftrace.h          |   17 +++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index b5fa57b61378..09210f853f12 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -135,6 +135,19 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
 	return arch_ftrace_regs(fregs)->fp;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
+
+	memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
+	regs->sp = afregs->sp;
+	regs->pc = afregs->pc;
+	regs->regs[29] = afregs->fp;
+	regs->regs[30] = afregs->lr;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 9372f8d7036f..7064a530794b 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -197,6 +197,20 @@ static __always_inline void ftrace_override_function_with_return(struct ftrace_r
 	arch_ftrace_regs(fregs)->epc = arch_ftrace_regs(fregs)->ra;
 }
 
+static __always_inline struct pt_regs *
+ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
+
+	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
+	regs->epc = afregs->epc;
+	regs->ra = afregs->ra;
+	regs->sp = afregs->sp;
+	regs->s0 = afregs->s0;
+	regs->t1 = afregs->t1;
+	return regs;
+}
+
 int ftrace_regs_query_register_offset(const char *name);
 
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index bf8bb6c10553..ad2b46e1d5b0 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -190,6 +190,23 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
+	defined(CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS)
+
+static __always_inline struct pt_regs *
+ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	/*
+	 * If CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS=y, ftrace_regs memory
+	 * layout is including pt_regs. So always returns that address.
+	 * Since arch_ftrace_get_regs() will check some members and may return
+	 * NULL, we can not use it.
+	 */
+	return &arch_ftrace_regs(fregs)->regs;
+}
+
+#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
+
 /*
  * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
  * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.



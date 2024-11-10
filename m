Return-Path: <linux-arch+bounces-8944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203F9C3367
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DCA1C208E0
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2366783CD2;
	Sun, 10 Nov 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4reWUcB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A53E49D;
	Sun, 10 Nov 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253793; cv=none; b=jq5sYMD6CaRZMDfCM+kCqcdMUNzvejeg9V+oHz/Cv0qSfcMXXqcnZBzeUEJyzbXmWUaqUeHXfiUo3xVPYqGjMhgheBN7tlMSPM4BleYYpqBxo9Hjiwgue5XxDU5xV+WC7uZTTKMNo9C5Sjm4jKb9Pl1yn6hx/AFVO8VIZ4zd3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253793; c=relaxed/simple;
	bh=bUZ71nSp1lAbwu1vjYiCdSgDlI1ghUdUB1XefNIsAfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPZw6Er79RMeLtF2kmaSrqJbRVtJlP6hz5PoDbwp4q2t2OLjkx0UWN1Vg4mWtZ9dAKIv1ZxuounLFf7Cezi37UYv/Sozj7B/SQ9o3AnkbtEorEXTgV97PRJOuCQwPjJhI7+uMAzc6uOHffGFJSLAyVNlMsANUjsfI7ULj1ZVaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4reWUcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1BDC4CECD;
	Sun, 10 Nov 2024 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253792;
	bh=bUZ71nSp1lAbwu1vjYiCdSgDlI1ghUdUB1XefNIsAfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4reWUcBSLgMoH0I2hcbSm1AWwuJFi87ssM+6Fko71bXRSI1UvSesVjh4HY4yHPI5
	 b379DvUD0HLw0VOdeHoWz5mzLtp6K/YKLHpbTHTVDZDfE3TINTy6P2B/tJ+yEZPYb+
	 O6Xmb10RtOBerKMdMKgpp5DtixaiV3SiZO68bcXMAc/MGP7AOtElf1hcGeDlxfGmjF
	 qPgPRfVvTC9GVZk3u9BpvwMM9Ki3R0BOmy1pNXwTXbeHkSdxOspQlLkf7S8XNEpM/J
	 pe3XJy56x/ywxCE7u6Bb7kL+TpORg6ti9DNzTxEiDTzDNKmJqlqwM5p1P03OMqRyjE
	 Dkwy9YL54jbdA==
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
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v19 05/19] fprobe: Use ftrace_regs in fprobe exit handler
Date: Mon, 11 Nov 2024 00:49:42 +0900
Message-ID: <173125378270.172790.5407978814601760638.stgit@devnote2>
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

Change the fprobe exit handler to use ftrace_regs structure instead of
pt_regs. This also introduce HAVE_FTRACE_REGS_HAVING_PT_REGS which
means the ftrace_regs is including the pt_regs so that ftrace_regs
can provide pt_regs without memory allocation.
Fprobe introduces a new dependency with that.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

---
  Changes in v16:
   - Rename HAVE_PT_REGS_TO_FTRACE_REGS_CAST to
     HAVE_FTRACE_REGS_HAVING_PT_REGS.
  Changes in v3:
   - Use ftrace_regs_get_return_value()
  Changes from previous series: NOTHING, just forward ported.
---
 arch/loongarch/Kconfig          |    1 +
 arch/s390/Kconfig               |    1 +
 arch/x86/Kconfig                |    1 +
 include/linux/fprobe.h          |    2 +-
 include/linux/ftrace.h          |    6 ++++++
 kernel/trace/Kconfig            |    7 +++++++
 kernel/trace/bpf_trace.c        |    6 +++++-
 kernel/trace/fprobe.c           |    3 ++-
 kernel/trace/trace_fprobe.c     |    6 +++++-
 lib/test_fprobe.c               |    6 +++---
 samples/fprobe/fprobe_example.c |    2 +-
 11 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 73466c9947f6..2b0dc9830ec1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -126,6 +126,7 @@ config LOONGARCH
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_FTRACE_REGS_HAVING_PT_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 112e83601ed5..eeb95342ddeb 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -175,6 +175,7 @@ config S390
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_FTRACE_REGS_HAVING_PT_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2697ebbfce8d..22cb0d181552 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -222,6 +222,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
+	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index ca64ee5e45d2..ef609bcca0f9 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -14,7 +14,7 @@ typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
 			       void *entry_data);
 
 typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *regs,
 			       void *entry_data);
 
 /**
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9a1e768e47da..bf8bb6c10553 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -176,6 +176,12 @@ static inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
+#ifdef CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS
+
+static_assert(sizeof(struct pt_regs) == ftrace_regs_size());
+
+#endif /* CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
+
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	if (!fregs)
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index f10ca86fbfad..7f8165f2049a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -57,6 +57,12 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	 This allows for use of ftrace_regs_get_argument() and
 	 ftrace_regs_get_stack_pointer().
 
+config HAVE_FTRACE_REGS_HAVING_PT_REGS
+	bool
+	help
+	 If this is set, ftrace_regs has pt_regs, thus it can convert to
+	 pt_regs without allocating memory.
+
 config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	bool
 	help
@@ -298,6 +304,7 @@ config FPROBE
 	bool "Kernel Function Probe (fprobe)"
 	depends on FUNCTION_TRACER
 	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
+	depends on HAVE_FTRACE_REGS_HAVING_PT_REGS || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_RETHOOK
 	select RETHOOK
 	default n
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 09fb6ce92144..e7ea5568471c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2786,10 +2786,14 @@ kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
 
 static void
 kprobe_multi_link_exit_handler(struct fprobe *fp, unsigned long fentry_ip,
-			       unsigned long ret_ip, struct pt_regs *regs,
+			       unsigned long ret_ip, struct ftrace_regs *fregs,
 			       void *data)
 {
 	struct bpf_kprobe_multi_link *link;
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return;
 
 	link = container_of(fp, struct bpf_kprobe_multi_link, fp);
 	kprobe_multi_link_prog_run(link, get_entry_ip(fentry_ip), regs, true, data);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 3d3789283873..90a3c8e2bbdf 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -124,6 +124,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
 	int bit;
 
 	if (!fp || fprobe_disabled(fp))
@@ -141,7 +142,7 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 		return;
 	}
 
-	fp->exit_handler(fp, fpr->entry_ip, ret_ip, regs,
+	fp->exit_handler(fp, fpr->entry_ip, ret_ip, fregs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
 	ftrace_test_recursion_unlock(bit);
 }
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index f73b78187389..b68d0aa26097 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -360,10 +360,14 @@ static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
 NOKPROBE_SYMBOL(fentry_dispatcher);
 
 static void fexit_dispatcher(struct fprobe *fp, unsigned long entry_ip,
-			     unsigned long ret_ip, struct pt_regs *regs,
+			     unsigned long ret_ip, struct ftrace_regs *fregs,
 			     void *entry_data)
 {
 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (!regs)
+		return;
 
 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
 		fexit_trace_func(tf, entry_ip, ret_ip, regs, entry_data);
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index ff607babba18..271ce0caeec0 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -59,9 +59,9 @@ static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace void fp_exit_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
-				    struct pt_regs *regs, void *data)
+				    struct ftrace_regs *fregs, void *data)
 {
-	unsigned long ret = regs_return_value(regs);
+	unsigned long ret = ftrace_regs_get_return_value(fregs);
 
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	if (ip != target_ip) {
@@ -89,7 +89,7 @@ static notrace int nest_entry_handler(struct fprobe *fp, unsigned long ip,
 
 static notrace void nest_exit_handler(struct fprobe *fp, unsigned long ip,
 				      unsigned long ret_ip,
-				      struct pt_regs *regs, void *data)
+				      struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	KUNIT_EXPECT_EQ(current_test, ip, target_nest_ip);
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index c234afae52d6..bfe98ce826f3 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -67,7 +67,7 @@ static int sample_entry_handler(struct fprobe *fp, unsigned long ip,
 }
 
 static void sample_exit_handler(struct fprobe *fp, unsigned long ip,
-				unsigned long ret_ip, struct pt_regs *regs,
+				unsigned long ret_ip, struct ftrace_regs *regs,
 				void *data)
 {
 	unsigned long rip = ret_ip;



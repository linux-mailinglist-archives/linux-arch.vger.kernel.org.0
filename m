Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A742688F
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhJHLUz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Oct 2021 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbhJHLUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Oct 2021 07:20:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FA7C061762
        for <linux-arch@vger.kernel.org>; Fri,  8 Oct 2021 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=umSfuLmNyx4dR8mDkBis1oRVsQNuMXaIh5WYIShus0o=; b=kyV7a5VCRDjg0lCxTwlu9BoLfA
        j0FlmMCPFG1UizZ0ewTSHVjKcuv2XpbfoGf4ChD2nr0alhYJWtbCl/hhaL2E5HEECcqf+i3fLo8KY
        hR69k8ZNf/NrwVCnlgLrNA3p4REQnE7mvSfJNf/Ntui5NkxQlJB5VpsQ8QD6SupueH5NJFlZUEwjI
        f8r4AVLvc0NoPelOJaxHuIntff438VPrTbdXZWTCcZnTNxlKTyUU9kvXfcUtCvzWi+GpezSVoOIaO
        Q7bNrKBgZuXqq6InRVW81DbNKdFDhFtDGFLEHc6BwfSVc8DZ4P/t8f5aR8ebv1QHpp9mZkUmut+4d
        EagtDrSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnsI-008eLg-6Z; Fri, 08 Oct 2021 11:17:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0074302D44;
        Fri,  8 Oct 2021 13:17:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F0ABC2DB84A6C; Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Message-ID: <20211008111626.455137084@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Oct 2021 13:15:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: [PATCH 7/7] arch: Fix STACKTRACE_SUPPORT
References: <20211008111527.438276127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A few archs got save_stack_trace_tsk() vs in_sched_functions() wrong.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/kernel/stacktrace.c  |    7 ++++++-
 arch/mips/kernel/stacktrace.c  |   27 ++++++++++++++++-----------
 arch/nds32/kernel/stacktrace.c |   21 +++++++++++----------
 3 files changed, 33 insertions(+), 22 deletions(-)

--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -122,12 +122,17 @@ static bool save_trace(unsigned long pc,
 	return __save_trace(pc, arg, false);
 }
 
+static bool save_trace_nosched(unsigned long pc, void *arg)
+{
+	return __save_trace(pc, arg, true);
+}
+
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	walk_stackframe(tsk, NULL, save_trace, trace);
+	walk_stackframe(tsk, NULL, save_trace_nosched, trace);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -66,16 +66,7 @@ static void save_context_stack(struct st
 #endif
 }
 
-/*
- * Save stack-backtrace addresses into a stack_trace buffer.
- */
-void save_stack_trace(struct stack_trace *trace)
-{
-	save_stack_trace_tsk(current, trace);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
 {
 	struct pt_regs dummyregs;
 	struct pt_regs *regs = &dummyregs;
@@ -88,6 +79,20 @@ void save_stack_trace_tsk(struct task_st
 		regs->cp0_epc = tsk->thread.reg31;
 	} else
 		prepare_frametrace(regs);
-	save_context_stack(trace, tsk, regs, tsk == current);
+	save_context_stack(trace, tsk, regs, savesched);
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace(struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(current, trace, true);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(tsk, trace, false);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
--- a/arch/nds32/kernel/stacktrace.c
+++ b/arch/nds32/kernel/stacktrace.c
@@ -6,25 +6,16 @@
 #include <linux/stacktrace.h>
 #include <linux/ftrace.h>
 
-void save_stack_trace(struct stack_trace *trace)
-{
-	save_stack_trace_tsk(current, trace);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
 {
 	unsigned long *fpn;
 	int skip = trace->skip;
-	int savesched;
 	int graph_idx = 0;
 
 	if (tsk == current) {
 		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
-		savesched = 1;
 	} else {
 		fpn = (unsigned long *)thread_saved_fp(tsk);
-		savesched = 0;
 	}
 
 	while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
@@ -50,4 +41,14 @@ void save_stack_trace_tsk(struct task_st
 		fpn = (unsigned long *)fpp;
 	}
 }
+void save_stack_trace(struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(current, trace, true);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(tsk, trace, false);
+}
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);



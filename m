Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3829CB85
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 22:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505991AbgJ0Vvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 17:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgJ0Vve (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 17:51:34 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098392225E;
        Tue, 27 Oct 2020 21:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603835493;
        bh=nU3hgM26iNL5yzEFEmr4JyXLx49XcFjrIm2/XNRCwTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1p/YiTfKA4I1zPlc/xkUOdmqbPbFdOBKAKnCXJRvdNzzI4QZnt3w8WKPMks6DGE1
         VYdSfzmRB+n1HaAn8L6ThtVPP4NCyCciXCgHmCz/MMQq0jTVRLdkMyXuXhs1m3hMfc
         2o713+d9YtU3ETrrCJWaR5RxubBBoX0yULA/6eRU=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: [PATCH 4/6] arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
Date:   Tue, 27 Oct 2020 21:51:16 +0000
Message-Id: <20201027215118.27003-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
References: <20201027215118.27003-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.

Ensure that 32-bit applications always take the slow-path when returning
to userspace on a system with mismatched support at EL0, so that we can
avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 21 ++++++++++++++++++++-
 arch/arm64/kernel/signal.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4784011cecac..c45b5f9dd66b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -542,6 +542,17 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 	write_sysreg(val, cntkctl_el1);
 }
 
+static void compat_thread_switch(struct task_struct *next)
+{
+	if (!is_compat_thread(task_thread_info(next)))
+		return;
+
+	if (!system_has_mismatched_32bit_el0())
+		return;
+
+	set_tsk_thread_flag(next, TIF_NOTIFY_RESUME);
+}
+
 /*
  * Thread switching.
  */
@@ -558,6 +569,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	uao_thread_switch(next);
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
+	compat_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -620,8 +632,15 @@ unsigned long arch_align_stack(unsigned long sp)
  */
 void arch_setup_new_exec(void)
 {
-	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+	unsigned long mmflags = 0;
+
+	if (is_compat_task()) {
+		mmflags = MMCF_AARCH32;
+		if (system_has_mismatched_32bit_el0())
+			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	}
 
+	current->mm->context.flags = mmflags;
 	ptrauth_thread_init_user(current);
 
 	if (task_spec_ssb_noexec(current)) {
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index a8184cad8890..bcb6ca2d9a7c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -911,6 +911,19 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
+static bool cpu_affinity_invalid(struct pt_regs *regs)
+{
+	if (!compat_user_mode(regs))
+		return false;
+
+	/*
+	 * We're preemptible, but a reschedule will cause us to check the
+	 * affinity again.
+	 */
+	return !cpumask_test_cpu(raw_smp_processor_id(),
+				 system_32bit_el0_cpumask());
+}
+
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned long thread_flags)
 {
@@ -948,6 +961,19 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_NOTIFY_RESUME) {
 				tracehook_notify_resume(regs);
 				rseq_handle_notify_resume(NULL, regs);
+
+				/*
+				 * If we reschedule after checking the affinity
+				 * then we must ensure that TIF_NOTIFY_RESUME
+				 * is set so that we check the affinity again.
+				 * Since tracehook_notify_resume() clears the
+				 * flag, ensure that the compiler doesn't move
+				 * it after the affinity check.
+				 */
+				barrier();
+
+				if (cpu_affinity_invalid(regs))
+					force_sig(SIGKILL);
 			}
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
-- 
2.29.0.rc2.309.g374f81d7ae-goog


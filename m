Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B339FE88
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhFHSGx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234161AbhFHSGh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F394961376;
        Tue,  8 Jun 2021 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175484;
        bh=myX14SA0NbiCMTpW6ETGTKqEZ8H7i4uKBUWW7ZY/FWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgCipFwd3/Omvbu8g6SFRXU5rvWx1GsGfahJ1e6asrKhHOxo38bPTTAh8/XnvD8oD
         a5lhx0YJac9EOluHBi3kNOlonUk0+4rnOYjw9owI039qIlvhziPQUd4l5Npv+ErA1Y
         b16MhCG+Or20ZLM5HVngSrZnkqGMwhaZCT5avez99+CC/e1YskJGWzxgDMWDCGBIjl
         10BdhdrNeQcIybJhPLNTmkryayOzjnGrxDt4LmqcZdn78i8VJi91gJ0XrRLWm6yEhr
         RAmMpEbv76uz+vGS7uLKJ7M/kdhghdY8OkJfjRqiX6qIzF9VYHDJjIazYiOBX1GbcK
         /b7DbG30PLoqA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: [PATCH v9 19/20] arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
Date:   Tue,  8 Jun 2021 19:03:12 +0100
Message-Id: <20210608180313.11502-20-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The scheduler now knows enough about these braindead systems to place
32-bit tasks accordingly, so throw out the safety checks and allow the
ret-to-user path to avoid do_notify_resume() if there is nothing to do.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 14 +-------------
 arch/arm64/kernel/signal.c  | 26 --------------------------
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 220134888d7e..1de4d934db7f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -528,15 +528,6 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 	write_sysreg(val, cntkctl_el1);
 }
 
-static void compat_thread_switch(struct task_struct *next)
-{
-	if (!is_compat_thread(task_thread_info(next)))
-		return;
-
-	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
-		set_tsk_thread_flag(next, TIF_NOTIFY_RESUME);
-}
-
 static void update_sctlr_el1(u64 sctlr)
 {
 	/*
@@ -578,7 +569,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
 	ptrauth_thread_switch_user(next);
-	compat_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -680,10 +670,8 @@ void arch_setup_new_exec(void)
 		 * at the point of execve(), although we try a bit harder to
 		 * honour the cpuset hierarchy.
 		 */
-		if (static_branch_unlikely(&arm64_mismatched_32bit_el0)) {
+		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
 			force_compatible_cpus_allowed_ptr(current);
-			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
-		}
 	} else if (static_branch_unlikely(&arm64_mismatched_32bit_el0)) {
 		relax_compatible_cpus_allowed_ptr(current);
 	}
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f8192f4ae0b8..6237486ff6bb 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -911,19 +911,6 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
-static bool cpu_affinity_invalid(struct pt_regs *regs)
-{
-	if (!compat_user_mode(regs))
-		return false;
-
-	/*
-	 * We're preemptible, but a reschedule will cause us to check the
-	 * affinity again.
-	 */
-	return !cpumask_test_cpu(raw_smp_processor_id(),
-				 system_32bit_el0_cpumask());
-}
-
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned long thread_flags)
 {
@@ -951,19 +938,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_NOTIFY_RESUME) {
 				tracehook_notify_resume(regs);
 				rseq_handle_notify_resume(NULL, regs);
-
-				/*
-				 * If we reschedule after checking the affinity
-				 * then we must ensure that TIF_NOTIFY_RESUME
-				 * is set so that we check the affinity again.
-				 * Since tracehook_notify_resume() clears the
-				 * flag, ensure that the compiler doesn't move
-				 * it after the affinity check.
-				 */
-				barrier();
-
-				if (cpu_affinity_invalid(regs))
-					force_sig(SIGKILL);
 			}
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
-- 
2.32.0.rc1.229.g3e70b5a671-goog


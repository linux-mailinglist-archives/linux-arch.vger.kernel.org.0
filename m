Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF872D2BFA
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgLHNaZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 08:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgLHNaZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Dec 2020 08:30:25 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
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
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v5 15/15] arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
Date:   Tue,  8 Dec 2020 13:28:35 +0000
Message-Id: <20201208132835.6151-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201208132835.6151-1-will@kernel.org>
References: <20201208132835.6151-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The scheduler now knows enough about these braindead systems to place
32-bit tasks accordingly, so throw out the safety checks and allow the
ret-to-user path to avoid do_notify_resume() if there is nothing to do.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 14 +-------------
 arch/arm64/kernel/signal.c  | 26 --------------------------
 2 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index da313b738c7c..3b08938c7d9d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -541,15 +541,6 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
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
 /*
  * Thread switching.
  */
@@ -566,7 +557,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	uao_thread_switch(next);
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
-	compat_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -643,10 +633,8 @@ void arch_setup_new_exec(void)
 		 * at the point of execve(), although we try a bit harder to
 		 * honour the cpuset hierarchy.
 		 */
-		if (static_branch_unlikely(&arm64_mismatched_32bit_el0)) {
+		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
 			force_compatible_cpus_allowed_ptr(current);
-			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
-		}
 	}
 
 	current->mm->context.flags = mmflags;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index bcb6ca2d9a7c..a8184cad8890 100644
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
@@ -961,19 +948,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
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
2.29.2.576.ga3fc446d84-goog


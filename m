Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD82C2BED
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbgKXPvr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389866AbgKXPvq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:46 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01D42073C;
        Tue, 24 Nov 2020 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233105;
        bh=+z+guEczWGGY8Fmi0RRJrJK9CwM5f159lXd/SraCCFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnV/JAag6M9SPuRfaIgWp4z8vCZLmbv8aAxTi+ozopUO4lqOSHo7THpdvCRtt0cUx
         yRhIx5t+PEIs7S6OIP3LwxfOm8zw909m/mwqHyr5UXoTd7eQy/7A7W8rtoOIu+9t+I
         2sgUr7azoMjBvRv5sspfclA2NlVQ3Q+U4pEHMq+0=
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
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: [PATCH v4 14/14] arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
Date:   Tue, 24 Nov 2020 15:50:39 +0000
Message-Id: <20201124155039.13804-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
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
index 72116b0c7c73..e21c631c8b17 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -543,15 +543,6 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
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
@@ -568,7 +559,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	uao_thread_switch(next);
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
-	compat_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -644,7 +634,7 @@ static void adjust_compat_task_affinity(struct task_struct *p)
 	 * execve().
 	 */
 	if (!restrict_cpus_allowed_ptr(p, possible_mask))
-		goto out;
+		return;
 
 	if (alloc_cpumask_var(&cpuset_mask, GFP_KERNEL)) {
 		cpuset_cpus_allowed(p, cpuset_mask);
@@ -661,8 +651,6 @@ static void adjust_compat_task_affinity(struct task_struct *p)
 out_set_mask:
 	set_cpus_allowed_ptr(p, newmask);
 	free_cpumask_var(cpuset_mask);
-out:
-	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 }
 
 /*
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
2.29.2.454.gaff20da3a2-goog


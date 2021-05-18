Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27273875A9
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348253AbhERJu4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348106AbhERJuL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:50:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7446613EB;
        Tue, 18 May 2021 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331329;
        bh=cxh0O3aWsznuhosSjWq+pFkb/mSjtZzHnDThwdnjZQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoWEGGqCZBOkoC2+SS/nheiXu/2Hmo+WC9UVd5Z+j0CNnv8h4OqnLXGjaGl7iNbry
         ShR1l32aTvoPswFIknrj2CogVOF2bOIy8UbnShkpro4zTF4Mdp8mHB6mLZ7YqKw2Sq
         w9LRuhE9hHajS9IrAYzQaanN21jDJo3euMA8ZbUGi9rgadI90kZ6lo4/KMWo8q/dQb
         Ebq0jOV4AnXerbs0ME7zLpmBDWxOotDxU+HPHaiQOld41NDrnWWqNmic55rsFPGAm+
         J7pigE6MSeZTmxNgfxbMfZiMdMfYw1D7Py2GuJm8bLRwvsECD0VSpBEn9LwhvuqBfk
         0FAbg8A9ApvZA==
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: [PATCH v6 20/21] arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores
Date:   Tue, 18 May 2021 10:47:24 +0100
Message-Id: <20210518094725.7701-21-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
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
index 8e0da06c4e77..de9833f08742 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -527,15 +527,6 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
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
@@ -577,7 +568,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
 	ptrauth_thread_switch_user(next);
-	compat_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -657,10 +647,8 @@ void arch_setup_new_exec(void)
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
2.31.1.751.gd2f1c929bd-goog


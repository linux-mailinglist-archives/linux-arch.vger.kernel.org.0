Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3842839FE66
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhFHSFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234022AbhFHSFg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA87E61377;
        Tue,  8 Jun 2021 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175423;
        bh=Z2Nz5COgyNKGHsjVNGQwlXO6aR+tDXX8aVdO57nvJ3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsehZ28JOSEX47LYCjD22NdqGNU2jo1o5q+EOf2oxeA+2RrhcfYywUNZGg8GjDKzA
         PJ95vMyhiANA5i1Tbxm+geW8XQrkEOj77TvFiYMiQ5/cWH1g5gZ69UpkZLMJPYQaeD
         avhlj/dM7wFS/ecqjbW9YTrZa6Np4MAcdIJxxm2FA4afyoXPvO3qMFIMEIRXdKuxFj
         YroD+jRjrmASJUR2UdJvfyJufzaueZwI8FD7VK3Sr5uN0UqV7afKQi7FdriI+qIhIs
         mCWHzonR7ilYPLVsjYDJmqaKFViAh6i/zexFA08bodOCVyesrXvu9DM0lXSpfX3Z8j
         17rdbBk7LFc1w==
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
Subject: [PATCH v9 04/20] arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
Date:   Tue,  8 Jun 2021 19:02:57 +0100
Message-Id: <20210608180313.11502-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.

Ensure that 32-bit applications always take the slow-path when returning
to userspace on a system with mismatched support at EL0, so that we can
avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 19 ++++++++++++++++++-
 arch/arm64/kernel/signal.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b4bb67f17a2c..f4a91bf1ce0c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -527,6 +527,15 @@ static void erratum_1418040_thread_switch(struct task_struct *prev,
 	write_sysreg(val, cntkctl_el1);
 }
 
+static void compat_thread_switch(struct task_struct *next)
+{
+	if (!is_compat_thread(task_thread_info(next)))
+		return;
+
+	if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		set_tsk_thread_flag(next, TIF_NOTIFY_RESUME);
+}
+
 static void update_sctlr_el1(u64 sctlr)
 {
 	/*
@@ -568,6 +577,7 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(prev, next);
 	ptrauth_thread_switch_user(next);
+	compat_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
@@ -633,8 +643,15 @@ unsigned long arch_align_stack(unsigned long sp)
  */
 void arch_setup_new_exec(void)
 {
-	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+	unsigned long mmflags = 0;
+
+	if (is_compat_task()) {
+		mmflags = MMCF_AARCH32;
+		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
+			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	}
 
+	current->mm->context.flags = mmflags;
 	ptrauth_thread_init_user();
 	mte_thread_init_user();
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6237486ff6bb..f8192f4ae0b8 100644
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
@@ -938,6 +951,19 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
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
2.32.0.rc1.229.g3e70b5a671-goog


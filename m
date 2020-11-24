Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF62C2BE0
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbgKXPvW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389087AbgKXPvW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:22 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7DF206F7;
        Tue, 24 Nov 2020 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233081;
        bh=IhklJrTc98DlHw/NyV/h2FIqQqwEhiczqa0G/8pyr58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHScSSwSemAKbOAQx6v20ZhR5errvNkNA+8HyRcRf9iVWL/9OgE46NIL5zwd+7MSg
         uNrVsM99EO2F2A5lQWBNWnpLX4kggtQCJSJv+kYUYRunhGHkS2AlNnD1upNtoCD/Hm
         aRN0Fs1QmvsTYGnPiEutGKaY4lwpHMQIVrqPS7rQ=
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
Subject: [PATCH v4 08/14] arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit EL0
Date:   Tue, 24 Nov 2020 15:50:33 +0000
Message-Id: <20201124155039.13804-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When exec'ing a 32-bit task on a system with mismatched support for
32-bit EL0, try to ensure that it starts life on a CPU that can actually
run it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1540ab0fbf23..72116b0c7c73 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/elfcore.h>
 #include <linux/pm.h>
 #include <linux/tick.h>
@@ -625,6 +626,45 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ~0xf;
 }
 
+static void adjust_compat_task_affinity(struct task_struct *p)
+{
+	cpumask_var_t cpuset_mask;
+	const struct cpumask *possible_mask = system_32bit_el0_cpumask();
+	const struct cpumask *newmask = possible_mask;
+
+	/*
+	 * Restrict the CPU affinity mask for a 32-bit task so that it contains
+	 * only the 32-bit-capable subset of its original CPU mask. If this is
+	 * empty, then try again with the cpuset allowed mask. If that fails,
+	 * forcefully override it with the set of all 32-bit-capable CPUs that
+	 * we know about.
+	 *
+	 * From the perspective of the task, this looks similar to what would
+	 * happen if the 64-bit-only CPUs were hot-unplugged at the point of
+	 * execve().
+	 */
+	if (!restrict_cpus_allowed_ptr(p, possible_mask))
+		goto out;
+
+	if (alloc_cpumask_var(&cpuset_mask, GFP_KERNEL)) {
+		cpuset_cpus_allowed(p, cpuset_mask);
+		if (cpumask_and(cpuset_mask, cpuset_mask, possible_mask)) {
+			newmask = cpuset_mask;
+			goto out_set_mask;
+		}
+	}
+
+	if (printk_ratelimit()) {
+		printk_deferred("Overriding affinity for 32-bit process %d (%s) to CPUs %*pbl\n",
+				task_pid_nr(p), p->comm, cpumask_pr_args(newmask));
+	}
+out_set_mask:
+	set_cpus_allowed_ptr(p, newmask);
+	free_cpumask_var(cpuset_mask);
+out:
+	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+
 /*
  * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
  */
@@ -635,7 +675,7 @@ void arch_setup_new_exec(void)
 	if (is_compat_task()) {
 		mmflags = MMCF_AARCH32;
 		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
-			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+			adjust_compat_task_affinity(current);
 	}
 
 	current->mm->context.flags = mmflags;
-- 
2.29.2.454.gaff20da3a2-goog


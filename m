Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0149E39FE68
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFHSFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234009AbhFHSFk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5506613BC;
        Tue,  8 Jun 2021 18:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175427;
        bh=LkvaF5Dq+vp9rMRP7GG2Svg0+9J+Q0X0+zzCOs62KPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTnCxmzrFeijhsDVs0VpqLyV7vUif59kFXGTWhjLcKqLYnBWLUryi+TrYpfb/WEQl
         thgB3Fkhsccc9+JGaCfjDnp/e3KcV3M/0l3Dg4buBJ7gZK46vj3oJ9td7EyQUp1Zl0
         d6PyWDrYyZm/lNwE4BanCLlxNZvTTmYFGOyRQ3BLVLTITT8bDY7knWYP6ytLsslvZl
         wq8hvVebjEHTAtAzXCk/HOWwL34cl/MMKR5q3KH68zpTAeW/ibuX11tcFh7zxS+3zD
         dxcckyATEktrXGcZAEGwPbkQvHhbP0E/uCRksbg4caY8P+C1adWFSVsvGBF1CKkxu2
         wa8o5pcQJ0sSw==
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
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com,
        Valentin Schneider <Valentin.Schneider@arm.com>
Subject: [PATCH v9 05/20] sched: Introduce task_cpu_possible_mask() to limit fallback rq selection
Date:   Tue,  8 Jun 2021 19:02:58 +0100
Message-Id: <20210608180313.11502-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

On such a system, we must take care not to migrate a task to an
unsupported CPU when forcefully moving tasks in select_fallback_rq()
in response to a CPU hot-unplug operation.

Introduce a task_cpu_possible_mask() hook which, given a task argument,
allows an architecture to return a cpumask of CPUs that are capable of
executing that task. The default implementation returns the
cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
limitations that affect scheduling. The new mask is used when selecting
the fallback runqueue as a last resort before forcing a migration to the
first active CPU.

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mmu_context.h | 14 ++++++++++++++
 kernel/sched/core.c         |  5 ++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index 03dee12d2b61..b9b970f7ab45 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -14,4 +14,18 @@
 static inline void leave_mm(int cpu) { }
 #endif
 
+/*
+ * CPUs that are capable of running user task @p. Must contain at least one
+ * active CPU. It is assumed that the kernel can run on all CPUs, so calling
+ * this for a kernel thread is pointless.
+ *
+ * By default, we assume a sane, homogeneous system.
+ */
+#ifndef task_cpu_possible_mask
+# define task_cpu_possible_mask(p)	cpu_possible_mask
+# define task_cpu_possible(cpu, p)	true
+#else
+# define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..0c1b6f1a6c91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1814,7 +1814,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 
 	/* Non kernel threads are not allowed during either online or offline. */
 	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu);
+		return cpu_active(cpu) && task_cpu_possible(cpu, p);
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -2792,10 +2792,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			 *
 			 * More yuck to audit.
 			 */
-			do_set_cpus_allowed(p, cpu_possible_mask);
+			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
 			state = fail;
 			break;
-
 		case fail:
 			BUG();
 			break;
-- 
2.32.0.rc1.229.g3e70b5a671-goog


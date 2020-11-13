Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90602B1868
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKMJiQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgKMJiO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:38:14 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C97D22261;
        Fri, 13 Nov 2020 09:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260293;
        bh=QBUW8J2aV5bknFUdEkA6PLCqeHwwVFx3z9FxkoIyHcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctmVIgbYtFgwkrVBlVqy6osvMbOjK9tNHBZmrJPw7IuTAd72cvI/J2Twu8xgKUkNO
         D0i2pUV7K3MwEx399wHnh56VGi4BY7WjRWg25nVEPkyb8lgVK6ssHsi5wjQ02WWSar
         ti477TTlfoHFQHkU4O0wrkOki+r9nhd8u1gGiqvE=
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
Subject: [PATCH v3 10/14] sched: Introduce arch_cpu_allowed_mask() to limit fallback rq selection
Date:   Fri, 13 Nov 2020 09:37:15 +0000
Message-Id: <20201113093720.21106-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113093720.21106-1-will@kernel.org>
References: <20201113093720.21106-1-will@kernel.org>
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

Introduce an arch_cpu_allowed_mask() hook which, given a task argument,
allows an architecture to return a cpumask of CPUs that are capable of
executing that task. The default implementation returns the
cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
limitations that affect scheduling. The new mask is used when selecting
the fallback runqueue as a last resort before forcing a migration to the
first active CPU.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 818c8f7bdf2a..8df38ebfe769 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1696,6 +1696,11 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
+/* Must contain at least one active CPU */
+#ifndef arch_cpu_allowed_mask
+#define  arch_cpu_allowed_mask(p)	cpu_possible_mask
+#endif
+
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
@@ -1708,7 +1713,10 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (is_per_cpu_kthread(p))
 		return cpu_online(cpu);
 
-	return cpu_active(cpu);
+	if (!cpu_active(cpu))
+		return false;
+
+	return cpumask_test_cpu(cpu, arch_cpu_allowed_mask(p));
 }
 
 /*
@@ -2361,10 +2369,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			}
 			fallthrough;
 		case possible:
-			do_set_cpus_allowed(p, cpu_possible_mask);
+			do_set_cpus_allowed(p, arch_cpu_allowed_mask(p));
 			state = fail;
 			break;
-
 		case fail:
 			BUG();
 			break;
-- 
2.29.2.299.gdc1121823c-goog


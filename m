Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE939FE70
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhFHSGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234080AbhFHSF5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3129561380;
        Tue,  8 Jun 2021 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175443;
        bh=pnXuodVFc1GHIIOVfgJFP7PTJiuFDmC2tnPdxXw3BMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bw3YtX+0yVLopNVY9GthZD3bXxc7xOI7gP05easWxmBge8d92orPHPYmxOEnUZkPa
         PpTnsa1w6LmYhXr2DX0ZYtsW0iZ3uPtsAiLOcS2u/iWekg+MPPF7lgSLscaAnQrIjW
         t8xkEBEQvyRqSoU6nAz579gHpJB9KYTamIltiSlxfEKCjmtKmVZFiNgGf+T4Lz0Jb7
         13jE8MmSgHOlyjHZ/1G9TErHBc18Md1O5dfo3s9sg752PaS+bZiwRlly5o/sH8g6cm
         YgK6EiyMmEEbVA9urkFrRLD6FSwuU9CqvW54oaOWB6Dp+E8jUa0IYXZrcv+ZdBcLd/
         A8C43uTO2Ws+w==
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
Subject: [PATCH v9 09/20] sched: Reject CPU affinity changes based on task_cpu_possible_mask()
Date:   Tue,  8 Jun 2021 19:03:02 +0100
Message-Id: <20210608180313.11502-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reject explicit requests to change the affinity mask of a task via
set_cpus_allowed_ptr() if the requested mask is not a subset of the
mask returned by task_cpu_possible_mask(). This ensures that the
'cpus_mask' for a given task cannot contain CPUs which are incapable of
executing it, except in cases where the affinity is forced.

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e75cb3fbc9c..09fe20b3d6bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2347,15 +2347,17 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
 	int ret = 0;
+	bool kthread = p->flags & PF_KTHREAD;
 
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
-	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
+	if (kthread || is_migration_disabled(p)) {
 		/*
 		 * Kernel threads are allowed on online && !active CPUs,
 		 * however, during cpu-hot-unplug, even these might get pushed
@@ -2369,6 +2371,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
+	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
-- 
2.32.0.rc1.229.g3e70b5a671-goog


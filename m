Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB73904F2
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhEYPRf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhEYPRX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C0B061429;
        Tue, 25 May 2021 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955753;
        bh=qGkVsA0G9EvUFdmfSvnTeaGukNiKFBrINcN26bFiPSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFTaybQbHLvBuCd7/j1WYqxd2rrK144oMKPNln6WRnzTnHq+wuE/OmmjuHj44bPD5
         3zWaSegMAwu1m/cjoKUM6OBh1+35h/9nYLjhfk1nullfSmPmx0MY3sIQPdIDj0kr40
         Nxcw7Bsy9dwhJ+Bbxx1nKVpRy3x/cQupXFOIkMaEoria4GfLqmzwO/PcHNg3Ua0HeG
         edGZX1BPw9/ED/bYANqOBHaBn2SDSzJzjD/Qq8gyF3i0G7fBe39OAIRrkyK6uEkhmo
         Um1OHw7OEvhBeKfEW0/QvRHateZPaBjV+ncrqVgHezbfPr2Jdse6tMysSyWSoRCe01
         2tfEY3TU+9OBA==
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
        kernel-team@android.com
Subject: [PATCH v7 10/22] sched: Reject CPU affinity changes based on task_cpu_possible_mask()
Date:   Tue, 25 May 2021 16:14:20 +0100
Message-Id: <20210525151432.16875-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
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

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00ed51528c70..8ca7854747f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2346,6 +2346,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	unsigned int dest_cpu;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -2366,6 +2367,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
 		 */
 		cpu_valid_mask = cpu_online_mask;
+	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/*
-- 
2.31.1.818.g46aad6cb9e-goog


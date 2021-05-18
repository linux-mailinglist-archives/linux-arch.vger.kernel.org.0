Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205EA38759C
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348182AbhERJuf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348069AbhERJts (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A95B613F4;
        Tue, 18 May 2021 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331304;
        bh=CXXSJFTLguIC0wnRzVNZjaiEiV5Q9Ps2gUQifPQxHXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVxji+ySFLgIHKy055Xm1GNP1NonfdXGEDwTzeg4wNyAOJ5ruRznguUI8CcX2GpKY
         FMM0QlUPUDq6Ugowra6N7/hicfp/zkzLQKQxQSkeMGXd0jP5LJRlVIZ5HMJ5zrIRMz
         4yBQB33CX/K6WLegiITaoiNArqpRa9ybEKWitb0A210zhqZNxJz+FOsPehG2vVwcv+
         bQgyVRTAB7FERd6FEDduJGLLQPXUhGZry4E8mlU3AKIdFoB0GCFrz+TT40UVn89+fK
         39vHAVB+VZYbgai9BGmpnAjaoagZ47Fd3lLdqxHqCU4Q9wc4eA3lN+O0FeC5K44w0M
         M7OVoBumfEQTQ==
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
Subject: [PATCH v6 13/21] sched: Admit forcefully-affined tasks into SCHED_DEADLINE
Date:   Tue, 18 May 2021 10:47:17 +0100
Message-Id: <20210518094725.7701-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On asymmetric systems where the affinity of a task is restricted to
contain only the CPUs capable of running it, admission to the deadline
scheduler is likely to fail because the span of the sched domain
contains incompatible CPUs. Although this is arguably the right thing to
do, it is inconsistent with the case where the affinity of a task is
restricted after already having been admitted to the deadline scheduler.

For example, on an arm64 system where not all CPUs support 32-bit
applications, a 64-bit deadline task can exec() a 32-bit image and have
its affinity forcefully restricted.

Rather than reject these tasks altogether, favour the requested user
affinity saved in 'task_struct::user_cpus_ptr' over the actual affinity
of the task which has been restricted by the kernel.

Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ba66bcf8e812..d7d058fc012e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6403,13 +6403,14 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
+			const cpumask_t *aff = p->user_cpus_ptr ?: p->cpus_ptr;
 
 			/*
 			 * Don't allow tasks with an affinity mask smaller than
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
 			 */
-			if (!cpumask_subset(span, p->cpus_ptr) ||
+			if (!cpumask_subset(span, aff) ||
 			    rq->rd->dl_bw.bw == 0) {
 				retval = -EPERM;
 				goto unlock;
-- 
2.31.1.751.gd2f1c929bd-goog


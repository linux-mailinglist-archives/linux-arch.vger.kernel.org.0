Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5869E3DB7BC
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbhG3LZW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238663AbhG3LZU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02DB561052;
        Fri, 30 Jul 2021 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644315;
        bh=c3XeuGdd25e7O6CSURs0DdZO6Yl72U7eD1ENjOcRYTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugGOPJSLGXplYmM4I/M7RglzRGfe0aNzpUoRwY8UwfAiVamtUKwfq+gNcSjlJFVk8
         hX35+hVXy5hq5q8g0/i+XR+LWd4prJX3ehI7+MDjz7o1HJhSeYupSkPx8b62s1lAoM
         FsL+IK+RZZwHfcHlBCOBIWzal4jKbo6XkoZ8yJzbsADYBpjgEjtzVLlAtblHRK51bK
         fWyHlxxhiNrKo/bsTI2VBzVm5fGkcEz/qRS9CaGM+3QVwrxs9qdTWX5PUjrru1ewHR
         Uih868csnAwWnkOORyQp1TS3jEqB7rDFhp1T65haU7qZd8XUPYlFIcO3G8GrdMDW6E
         /uRxEIVb/+Vmw==
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
Subject: [PATCH v11 06/16] sched: Introduce task_struct::user_cpus_ptr to track requested affinity
Date:   Fri, 30 Jul 2021 12:24:33 +0100
Message-Id: <20210730112443.23245-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210730112443.23245-1-will@kernel.org>
References: <20210730112443.23245-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for saving and restoring the user-requested CPU affinity
mask of a task, add a new cpumask_t pointer to 'struct task_struct'.

If the pointer is non-NULL, then the mask is copied across fork() and
freed on task exit.

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h | 13 +++++++++++++
 init/init_task.c      |  1 +
 kernel/fork.c         |  2 ++
 kernel/sched/core.c   | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d88641..91dab7a62aa1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -748,6 +748,7 @@ struct task_struct {
 	unsigned int			policy;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
+	cpumask_t			*user_cpus_ptr;
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
 #ifdef CONFIG_SMP
@@ -1705,6 +1706,8 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
+extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
+extern void release_user_cpus_ptr(struct task_struct *p);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
@@ -1715,6 +1718,16 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 		return -EINVAL;
 	return 0;
 }
+static inline int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node)
+{
+	if (src->user_cpus_ptr)
+		return -EINVAL;
+	return 0;
+}
+static inline void release_user_cpus_ptr(struct task_struct *p)
+{
+	WARN_ON(p->user_cpus_ptr);
+}
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/init/init_task.c b/init/init_task.c
index 562f2ef8d157..2d024066e27b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -80,6 +80,7 @@ struct task_struct init_task
 	.normal_prio	= MAX_PRIO - 20,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
+	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2cc5995..bd0e165b8397 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -446,6 +446,7 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	release_user_cpus_ptr(tsk);
 	scs_release(tsk);
 
 #ifndef CONFIG_THREAD_INFO_IN_TASK
@@ -924,6 +925,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
+	dup_user_cpus_ptr(tsk, orig, node);
 
 	/*
 	 * One for the user space visible state that goes away when reaped.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbce9cd83a53..a139ed8be7e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2470,6 +2470,26 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	__do_set_cpus_allowed(p, new_mask, 0);
 }
 
+int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
+		      int node)
+{
+	if (!src->user_cpus_ptr)
+		return 0;
+
+	dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
+	if (!dst->user_cpus_ptr)
+		return -ENOMEM;
+
+	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	return 0;
+}
+
+void release_user_cpus_ptr(struct task_struct *p)
+{
+	kfree(p->user_cpus_ptr);
+	p->user_cpus_ptr = NULL;
+}
+
 /*
  * This function is wildly self concurrent; here be dragons.
  *
-- 
2.32.0.402.g57bb445576-goog


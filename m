Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C178D3904F4
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhEYPRt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232530AbhEYPR1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11A7261434;
        Tue, 25 May 2021 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955757;
        bh=7S8FiuEyUSxwLWtrNEdNEEBikQ/xnj7VhrLn/rpdZ7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tT1hvDV0Q64QQV2RwYIPi7s5h6v3u95FXiCfMLKY5Tu9B2D4fn6RejklJELt5LUPY
         q83Ki+wXcQT4nDKIE78sPC0by9bJTjbtEzY3n5t+1C/QSw/iW2qI7IgMWsn92VnHDI
         FoibsqwL8KUwrpEig69mufleLvpOQMbOP4wFvBMcSOoqg5LAInKuaROiGatEhOMvar
         tB/mdQOGfyopzSPzskYzT3VHscqJVVL5JDPE5kEBbUX7uOONtUTJXsXgpSetwlQ4tc
         Ub1UWdz8JHAtqtSwfQwrzJb/SSj3KHV70zcYM5lxLyHyQWR8sBrS7N4J0Th69DF9kk
         cNvWNd5juU7sQ==
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
Subject: [PATCH v7 11/22] sched: Introduce task_struct::user_cpus_ptr to track requested affinity
Date:   Tue, 25 May 2021 16:14:21 +0100
Message-Id: <20210525151432.16875-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for saving and restoring the user-requested CPU affinity
mask of a task, add a new cpumask_t pointer to 'struct task_struct'.

If the pointer is non-NULL, then the mask is copied across fork() and
freed on task exit.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/sched.h | 13 +++++++++++++
 init/init_task.c      |  1 +
 kernel/fork.c         |  2 ++
 kernel/sched/core.c   | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c881384517..db32d4f7e5b3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -730,6 +730,7 @@ struct task_struct {
 	unsigned int			policy;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
+	cpumask_t			*user_cpus_ptr;
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
 #ifdef CONFIG_SMP
@@ -1688,6 +1689,8 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
+extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
+extern void release_user_cpus_ptr(struct task_struct *p);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
@@ -1698,6 +1701,16 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
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
index 8b08c2e19cbb..158c2b1689e1 100644
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
index dc06afd725cb..d3710e7f1686 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -446,6 +446,7 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	release_user_cpus_ptr(tsk);
 	scs_release(tsk);
 
 #ifndef CONFIG_THREAD_INFO_IN_TASK
@@ -918,6 +919,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
+	dup_user_cpus_ptr(tsk, orig, node);
 
 	/*
 	 * One for the user space visible state that goes away when reaped.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8ca7854747f1..9349b8ecbcf9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2124,6 +2124,26 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
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
2.31.1.818.g46aad6cb9e-goog


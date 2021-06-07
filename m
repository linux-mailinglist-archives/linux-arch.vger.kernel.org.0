Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3533039E534
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 19:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGRWk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 13:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFGRWk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 13:22:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF91C6102A;
        Mon,  7 Jun 2021 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623086449;
        bh=r9h4o/kynCaZiF+M69kKU6MUtwBfrU3/DUmwvrKAtmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO/fr8cnIuG5uhhmbCDNb9ilsVm6t8t2jCNSthItfooM9ejP4ia8DEGz7vPtxRSi3
         Zq+5VjYMHwSdxh81XqBHlVf61sYG7uGIedqHg05ag03t0OrknA+fFjY7yBKlUzUzzB
         uCPKRci0Ad8pjPpeBP4UkRwg6b8DbPbTx+S9/2r3ahAozYgW7BOOHSYuwnCsLPmuHV
         UFjK0wuYVVMLtEf/6aDU2FUoA1P+EkTRX8TfU/Lb57+xeDpjfQPzUvDtfa2sQ+09Dg
         5rV3yyfX03KLKMUqIwvRWy8m574kqyat4T+8EjqkagUKJ8GswcpirZCoIHvCTVyQD2
         XVv6+p1KNXhcg==
Date:   Mon, 7 Jun 2021 18:20:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
        kernel-team@android.com, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH v8 06/19] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20210607172042.GB7650@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-7-will@kernel.org>
 <877dj9ees8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dj9ees8.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:11:03PM +0100, Valentin Schneider wrote:
> On 02/06/21 17:47, Will Deacon wrote:
> > @@ -3322,9 +3322,13 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> >
> >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> >  {
> > +	const struct cpumask *cs_mask;
> > +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> > +
> >       rcu_read_lock();
> > -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> > -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> > +	cs_mask = task_cs(tsk)->cpus_allowed;
> > +	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
> > +		do_set_cpus_allowed(tsk, cs_mask);
> 
> Since the task will still go through the is_cpu_allowed() loop in
> select_fallback_rq() after this, is the subset check actually required
> here?

Yes, I think it's needed. do_set_cpus_allowed() doesn't do any checking
against the task_cpu_possible_mask, so if we returned to
select_fallback_rq() with a mask containing a mixture of 32-bit-capable and
64-bit-only CPUs then we'd end up setting an affinity mask for a 32-bit
task which contains 64-bit-only cores.

> It would have more merit if cpuset_cpus_allowed_fallback() returned whether
> it actually changed the allowed mask or not, in which case we could branch
> either to the is_cpu_allowed() loop (as we do unconditionally now), or to
> the 'state == possible' switch case.

I think this is a cleanup, so I can include it as a separate patch (see
below).

Will

--->8

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 414a8e694413..d2b9c41c8edf 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -59,7 +59,7 @@ extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_read_lock(void);
 extern void cpuset_read_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
-extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -188,8 +188,9 @@ static inline void cpuset_cpus_allowed(struct task_struct *p,
        cpumask_copy(mask, task_cpu_possible_mask(p));
 }
 
-static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
+static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
 {
+       return false;
 }
 
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4e7c271e3800..a6bab2259f98 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3327,17 +3327,22 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
  * which will not contain a sane cpumask during cases such as cpu hotplugging.
  * This is the absolute last resort for the scheduler and it is only used if
  * _every_ other avenue has been traveled.
+ *
+ * Returns true if the affinity of @tsk was changed, false otherwise.
  **/
 
-void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
+bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 {
        const struct cpumask *cs_mask;
+       bool changed = false;
        const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
 
        rcu_read_lock();
        cs_mask = task_cs(tsk)->cpus_allowed;
-       if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
+       if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
                do_set_cpus_allowed(tsk, cs_mask);
+               changed = true;
+       }
        rcu_read_unlock();
 
        /*
@@ -3357,6 +3362,7 @@ void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
         * select_fallback_rq() will fix things ups and set cpu_possible_mask
         * if required.
         */
+       return changed;
 }
 
 void __init cpuset_init_current_mems_allowed(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc7de4f955cf..9d7a74a07632 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2951,8 +2951,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
                /* No more Mr. Nice Guy. */
                switch (state) {
                case cpuset:
-                       if (IS_ENABLED(CONFIG_CPUSETS)) {
-                               cpuset_cpus_allowed_fallback(p);
+                       if (cpuset_cpus_allowed_fallback(p)) {
                                state = possible;
                                break;
                        }


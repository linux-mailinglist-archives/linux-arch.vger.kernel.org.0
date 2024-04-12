Return-Path: <linux-arch+bounces-3623-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C408A30D7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFBB2829A2
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A11420A5;
	Fri, 12 Apr 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tHUGz5Je"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABC13E890;
	Fri, 12 Apr 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932694; cv=none; b=lUB4TyWjOHY9fra/Z2MLJBUxZWVbZ1gkvYa/fC1wwn0pNZchm6Ul9uJT+XWqdaW6KVWTS/CfZoG5KkdWFa/G9cfHpBteIv45RZTSO/FqGHRz71sQmOBAMZ+vF01q1f0cZmVV/Oq/bIXERY3ziaUpVoOSlQ8BYvVYG/gx307I8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932694; c=relaxed/simple;
	bh=8PI+98E+UuquY6cy2eKNADGiMpko8eOKNyrHlaqKKbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdXGkNFE0u8XNzZLs3NPOahPJixQ+OhLCScAUgyBMOQgZCMO88gGfesuTYKFbJX2r6bCbrDNOaEiOMxQHjyjFhGuqIFNY7XFZkBT3c/U8pv1GqgXRnuF44KlWyE9JYHWGco1qe/Xh13qVtW3hrcic8kHhUx9jXEJ5M7Hj+h+jUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tHUGz5Je; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1712932685;
	bh=8PI+98E+UuquY6cy2eKNADGiMpko8eOKNyrHlaqKKbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tHUGz5JerR9o4ZpFvPSkEQuurY5is0x1W6AQEM+O9pjqD+lormfSibrUcK1Ct/+lq
	 gEagPZYU66l8MQ7EYQLMZp2UdtbRkH3ew4d2XWape9Y8iTiah29iEHyzBNXftygv/f
	 m9Q+VSwVpG8j+VJf8Q8wcfhlORziVmucUVA8E+cAby9UsG8uIXLjg99gjSc9rxpONm
	 RQBB6mr5COqO2xHtqpKtM5N+Ylsis7A4QF5TfLcie3jFfmbggvfLaoSgnYGAk4axMH
	 EI1wac7nTstVcvBG9t/zszHJPb6rS3NlAAg5QKMD5GQcXw34lVUwC8NbRGmXl4FpM2
	 Vn7M3T8ZZENag==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VGK192tJxzvF3;
	Fri, 12 Apr 2024 10:38:05 -0400 (EDT)
Message-ID: <2da47905-e217-4f5c-a1fd-e6fee602c751@efficios.com>
Date: Fri, 12 Apr 2024 10:38:14 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
To: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "levi . yun" <yeoreum.yun@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Aaron Lu <aaron.lu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20240411174302.353889-1-mathieu.desnoyers@efficios.com>
 <ZhkLgJ2ZkI3JO0m/@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZhkLgJ2ZkI3JO0m/@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-12 06:22, Ingo Molnar wrote:
[...]
> 
> Please move switch_mm_cid() from sched.h to core.c, where its only user
> resides.

I agree, but I should actually go further than that: I need to move _all_ of
the mm_cid code from kernel/sched/sched.h to kernel/sched/core.c, as it is
only used from there.

I plan to create a separate patch on top of this fix, so we can have:

- "sched: Add missing memory barrier in switch_mm_cid" as a minimal
   fix, aiming at the current v6.9-rc cycle, easy to backport to stable,
- A separate "sched: Move mm_cid code from sched.h to core.c", aiming for
   the v6.10 merge window.

Are you OK with this approach (see patch below) ?

Thanks,

Mathieu

Here is the resulting patch:

 From 16b3b280d988da3927c0735ba456ad0c54e42e42 Mon Sep 17 00:00:00 2001
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Fri, 12 Apr 2024 09:52:27 -0400
Subject: [PATCH 1/1] sched: Move mm_cid code from sched.h to core.c

The mm_cid code in sched/sched.h is only used from sched/core.c. Move it
to the compile unit where it belongs.

While reviewing mm_cid functions which were already in sched/core.c, I
noticed that a few of them are non-static even though they are only used
from core.c. Make those functions static inline. For sake of keeping
things consistent, mm_cid functions only marked "static" are now marked
"static inline". The variables cid_lock and use_cid_lock are only used
from core.c, mark them as static.

Moving from non-static to static inline for:

- sched_mm_cid_migrate_from
- init_sched_mm_cid
- task_tick_mm_cid

And the forced inlining of:

- __sched_mm_cid_migrate_from_fetch_cid
- __sched_mm_cid_migrate_from_try_steal_cid
- sched_mm_cid_migrate_to
- sched_mm_cid_remote_clear
- sched_mm_cid_remote_clear_old
- sched_mm_cid_remote_clear_weight

slightly improves the size of sched/core.o on x86-64 (in bytes):

            text          data
before:  192261         58677
after:   191629         58641
-----------------------------
delta:     -632           -36

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
  kernel/sched/core.c  | 277 +++++++++++++++++++++++++++++++++++++++----
  kernel/sched/sched.h | 241 -------------------------------------
  2 files changed, 257 insertions(+), 261 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..cec979eafad4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -457,6 +457,22 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
  
  #endif /* CONFIG_SCHED_CORE */
  
+#ifdef CONFIG_SCHED_MM_CID
+static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev,
+				 struct task_struct *next);
+static inline void sched_mm_cid_migrate_from(struct task_struct *t);
+static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
+static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
+static inline void init_sched_mm_cid(struct task_struct *t);
+#else
+static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev,
+				 struct task_struct *next) { }
+static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
+static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
+static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
+static inline void init_sched_mm_cid(struct task_struct *t) { }
+#endif
+
  /*
   * Serialization rules:
   *
@@ -11530,6 +11546,9 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
  
  #ifdef CONFIG_SCHED_MM_CID
  
+#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
+#define MM_CID_SCAN_DELAY	100			/* 100ms */
+
  /*
   * @cid_lock: Guarantee forward-progress of cid allocation.
   *
@@ -11537,7 +11556,7 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
   * is only used when contention is detected by the lock-free allocation so
   * forward progress can be guaranteed.
   */
-DEFINE_RAW_SPINLOCK(cid_lock);
+static DEFINE_RAW_SPINLOCK(cid_lock);
  
  /*
   * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
@@ -11548,7 +11567,7 @@ DEFINE_RAW_SPINLOCK(cid_lock);
   * completes and sets @use_cid_lock back to 0. This guarantees forward progress
   * of a cid allocation.
   */
-int use_cid_lock;
+static int use_cid_lock;
  
  /*
   * mm_cid remote-clear implements a lock-free algorithm to clear per-mm/cpu cid
@@ -11638,15 +11657,233 @@ int use_cid_lock;
   * because this would UNSET a cid which is actively used.
   */
  
-void sched_mm_cid_migrate_from(struct task_struct *t)
+static inline void __mm_cid_put(struct mm_struct *mm, int cid)
+{
+	if (cid < 0)
+		return;
+	cpumask_clear_cpu(cid, mm_cidmask(mm));
+}
+
+/*
+ * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to
+ * the MM_CID_UNSET state without holding the rq lock, but the rq lock needs to
+ * be held to transition to other states.
+ *
+ * State transitions synchronized with cmpxchg or try_cmpxchg need to be
+ * consistent across cpus, which prevents use of this_cpu_cmpxchg.
+ */
+static inline void mm_cid_put_lazy(struct task_struct *t)
+{
+	struct mm_struct *mm = t->mm;
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	int cid;
+
+	lockdep_assert_irqs_disabled();
+	cid = __this_cpu_read(pcpu_cid->cid);
+	if (!mm_cid_is_lazy_put(cid) ||
+	    !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
+		return;
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
+{
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	int cid, res;
+
+	lockdep_assert_irqs_disabled();
+	cid = __this_cpu_read(pcpu_cid->cid);
+	for (;;) {
+		if (mm_cid_is_unset(cid))
+			return MM_CID_UNSET;
+		/*
+		 * Attempt transition from valid or lazy-put to unset.
+		 */
+		res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
+		if (res == cid)
+			break;
+		cid = res;
+	}
+	return cid;
+}
+
+static inline void mm_cid_put(struct mm_struct *mm)
+{
+	int cid;
+
+	lockdep_assert_irqs_disabled();
+	cid = mm_cid_pcpu_unset(mm);
+	if (cid == MM_CID_UNSET)
+		return;
+	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+}
+
+static inline int __mm_cid_try_get(struct mm_struct *mm)
+{
+	struct cpumask *cpumask;
+	int cid;
+
+	cpumask = mm_cidmask(mm);
+	/*
+	 * Retry finding first zero bit if the mask is temporarily
+	 * filled. This only happens during concurrent remote-clear
+	 * which owns a cid without holding a rq lock.
+	 */
+	for (;;) {
+		cid = cpumask_first_zero(cpumask);
+		if (cid < nr_cpu_ids)
+			break;
+		cpu_relax();
+	}
+	if (cpumask_test_and_set_cpu(cid, cpumask))
+		return -1;
+	return cid;
+}
+
+/*
+ * Save a snapshot of the current runqueue time of this cpu
+ * with the per-cpu cid value, allowing to estimate how recently it was used.
+ */
+static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
+{
+	struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(rq));
+
+	lockdep_assert_rq_held(rq);
+	WRITE_ONCE(pcpu_cid->time, rq->clock);
+}
+
+static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
+{
+	int cid;
+
+	/*
+	 * All allocations (even those using the cid_lock) are lock-free. If
+	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
+	 * guarantee forward progress.
+	 */
+	if (!READ_ONCE(use_cid_lock)) {
+		cid = __mm_cid_try_get(mm);
+		if (cid >= 0)
+			goto end;
+		raw_spin_lock(&cid_lock);
+	} else {
+		raw_spin_lock(&cid_lock);
+		cid = __mm_cid_try_get(mm);
+		if (cid >= 0)
+			goto unlock;
+	}
+
+	/*
+	 * cid concurrently allocated. Retry while forcing following
+	 * allocations to use the cid_lock to ensure forward progress.
+	 */
+	WRITE_ONCE(use_cid_lock, 1);
+	/*
+	 * Set use_cid_lock before allocation. Only care about program order
+	 * because this is only required for forward progress.
+	 */
+	barrier();
+	/*
+	 * Retry until it succeeds. It is guaranteed to eventually succeed once
+	 * all newcoming allocations observe the use_cid_lock flag set.
+	 */
+	do {
+		cid = __mm_cid_try_get(mm);
+		cpu_relax();
+	} while (cid < 0);
+	/*
+	 * Allocate before clearing use_cid_lock. Only care about
+	 * program order because this is for forward progress.
+	 */
+	barrier();
+	WRITE_ONCE(use_cid_lock, 0);
+unlock:
+	raw_spin_unlock(&cid_lock);
+end:
+	mm_cid_snapshot_time(rq, mm);
+	return cid;
+}
+
+static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
+{
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	struct cpumask *cpumask;
+	int cid;
+
+	lockdep_assert_rq_held(rq);
+	cpumask = mm_cidmask(mm);
+	cid = __this_cpu_read(pcpu_cid->cid);
+	if (mm_cid_is_valid(cid)) {
+		mm_cid_snapshot_time(rq, mm);
+		return cid;
+	}
+	if (mm_cid_is_lazy_put(cid)) {
+		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
+			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
+	}
+	cid = __mm_cid_get(rq, mm);
+	__this_cpu_write(pcpu_cid->cid, cid);
+	return cid;
+}
+
+static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev,
+				 struct task_struct *next)
+{
+	/*
+	 * Provide a memory barrier between rq->curr store and load of
+	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
+	 *
+	 * Should be adapted if context_switch() is modified.
+	 */
+	if (!next->mm) {                                // to kernel
+		/*
+		 * user -> kernel transition does not guarantee a barrier, but
+		 * we can use the fact that it performs an atomic operation in
+		 * mmgrab().
+		 */
+		if (prev->mm)                           // from user
+			smp_mb__after_mmgrab();
+		/*
+		 * kernel -> kernel transition does not change rq->curr->mm
+		 * state. It stays NULL.
+		 */
+	} else {                                        // to user
+		/*
+		 * kernel -> user transition does not provide a barrier
+		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
+		 * Provide it here.
+		 */
+		if (!prev->mm) {                        // from kernel
+			smp_mb();
+		} else {				// from user
+			/*
+			 * user -> user transition relies on an implicit
+			 * memory barrier in switch_mm() when
+			 * current->mm changes. If the architecture
+			 * switch_mm() does not have an implicit memory
+			 * barrier, it is emitted here.  If current->mm
+			 * is unchanged, no barrier is needed.
+			 */
+			smp_mb__after_switch_mm();
+		}
+	}
+	if (prev->mm_cid_active) {
+		mm_cid_snapshot_time(rq, prev->mm);
+		mm_cid_put_lazy(prev);
+		prev->mm_cid = -1;
+	}
+	if (next->mm_cid_active)
+		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
+}
+
+static inline void sched_mm_cid_migrate_from(struct task_struct *t)
  {
  	t->migrate_from_cpu = task_cpu(t);
  }
  
-static
-int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
-					  struct task_struct *t,
-					  struct mm_cid *src_pcpu_cid)
+static inline int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
+							struct task_struct *t,
+							struct mm_cid *src_pcpu_cid)
  {
  	struct mm_struct *mm = t->mm;
  	struct task_struct *src_task;
@@ -11682,11 +11919,10 @@ int __sched_mm_cid_migrate_from_fetch_cid(struct rq *src_rq,
  	return src_cid;
  }
  
-static
-int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
-					      struct task_struct *t,
-					      struct mm_cid *src_pcpu_cid,
-					      int src_cid)
+static inline int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
+							    struct task_struct *t,
+							    struct mm_cid *src_pcpu_cid,
+							    int src_cid)
  {
  	struct task_struct *src_task;
  	struct mm_struct *mm = t->mm;
@@ -11746,7 +11982,7 @@ int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
   * Interrupts are disabled, which keeps the window of cid ownership without the
   * source rq lock held small.
   */
-void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
+static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
  {
  	struct mm_cid *src_pcpu_cid, *dst_pcpu_cid;
  	struct mm_struct *mm = t->mm;
@@ -11799,8 +12035,9 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
  	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
  }
  
-static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
-				      int cpu)
+static inline void sched_mm_cid_remote_clear(struct mm_struct *mm,
+					     struct mm_cid *pcpu_cid,
+					     int cpu)
  {
  	struct rq *rq = cpu_rq(cpu);
  	struct task_struct *t;
@@ -11855,7 +12092,7 @@ static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_
  	}
  }
  
-static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
+static inline void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
  {
  	struct rq *rq = cpu_rq(cpu);
  	struct mm_cid *pcpu_cid;
@@ -11887,8 +12124,8 @@ static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
  	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
  }
  
-static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
-					     int weight)
+static inline void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
+						    int weight)
  {
  	struct mm_cid *pcpu_cid;
  	int cid;
@@ -11944,7 +12181,7 @@ static void task_mm_cid_work(struct callback_head *work)
  		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
  }
  
-void init_sched_mm_cid(struct task_struct *t)
+static inline void init_sched_mm_cid(struct task_struct *t)
  {
  	struct mm_struct *mm = t->mm;
  	int mm_users = 0;
@@ -11958,7 +12195,7 @@ void init_sched_mm_cid(struct task_struct *t)
  	init_task_work(&t->cid_work, task_mm_cid_work);
  }
  
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
+static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
  {
  	struct callback_head *work = &curr->cid_work;
  	unsigned long now = jiffies;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 35717359d3ca..9d3050886a05 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3237,247 +3237,6 @@ extern int sched_dynamic_mode(const char *str);
  extern void sched_dynamic_update(int mode);
  #endif
  
-#ifdef CONFIG_SCHED_MM_CID
-
-#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
-#define MM_CID_SCAN_DELAY	100			/* 100ms */
-
-extern raw_spinlock_t cid_lock;
-extern int use_cid_lock;
-
-extern void sched_mm_cid_migrate_from(struct task_struct *t);
-extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
-extern void init_sched_mm_cid(struct task_struct *t);
-
-static inline void __mm_cid_put(struct mm_struct *mm, int cid)
-{
-	if (cid < 0)
-		return;
-	cpumask_clear_cpu(cid, mm_cidmask(mm));
-}
-
-/*
- * The per-mm/cpu cid can have the MM_CID_LAZY_PUT flag set or transition to
- * the MM_CID_UNSET state without holding the rq lock, but the rq lock needs to
- * be held to transition to other states.
- *
- * State transitions synchronized with cmpxchg or try_cmpxchg need to be
- * consistent across cpus, which prevents use of this_cpu_cmpxchg.
- */
-static inline void mm_cid_put_lazy(struct task_struct *t)
-{
-	struct mm_struct *mm = t->mm;
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid;
-
-	lockdep_assert_irqs_disabled();
-	cid = __this_cpu_read(pcpu_cid->cid);
-	if (!mm_cid_is_lazy_put(cid) ||
-	    !try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
-		return;
-	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
-}
-
-static inline int mm_cid_pcpu_unset(struct mm_struct *mm)
-{
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	int cid, res;
-
-	lockdep_assert_irqs_disabled();
-	cid = __this_cpu_read(pcpu_cid->cid);
-	for (;;) {
-		if (mm_cid_is_unset(cid))
-			return MM_CID_UNSET;
-		/*
-		 * Attempt transition from valid or lazy-put to unset.
-		 */
-		res = cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, cid, MM_CID_UNSET);
-		if (res == cid)
-			break;
-		cid = res;
-	}
-	return cid;
-}
-
-static inline void mm_cid_put(struct mm_struct *mm)
-{
-	int cid;
-
-	lockdep_assert_irqs_disabled();
-	cid = mm_cid_pcpu_unset(mm);
-	if (cid == MM_CID_UNSET)
-		return;
-	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
-}
-
-static inline int __mm_cid_try_get(struct mm_struct *mm)
-{
-	struct cpumask *cpumask;
-	int cid;
-
-	cpumask = mm_cidmask(mm);
-	/*
-	 * Retry finding first zero bit if the mask is temporarily
-	 * filled. This only happens during concurrent remote-clear
-	 * which owns a cid without holding a rq lock.
-	 */
-	for (;;) {
-		cid = cpumask_first_zero(cpumask);
-		if (cid < nr_cpu_ids)
-			break;
-		cpu_relax();
-	}
-	if (cpumask_test_and_set_cpu(cid, cpumask))
-		return -1;
-	return cid;
-}
-
-/*
- * Save a snapshot of the current runqueue time of this cpu
- * with the per-cpu cid value, allowing to estimate how recently it was used.
- */
-static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
-{
-	struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(rq));
-
-	lockdep_assert_rq_held(rq);
-	WRITE_ONCE(pcpu_cid->time, rq->clock);
-}
-
-static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
-{
-	int cid;
-
-	/*
-	 * All allocations (even those using the cid_lock) are lock-free. If
-	 * use_cid_lock is set, hold the cid_lock to perform cid allocation to
-	 * guarantee forward progress.
-	 */
-	if (!READ_ONCE(use_cid_lock)) {
-		cid = __mm_cid_try_get(mm);
-		if (cid >= 0)
-			goto end;
-		raw_spin_lock(&cid_lock);
-	} else {
-		raw_spin_lock(&cid_lock);
-		cid = __mm_cid_try_get(mm);
-		if (cid >= 0)
-			goto unlock;
-	}
-
-	/*
-	 * cid concurrently allocated. Retry while forcing following
-	 * allocations to use the cid_lock to ensure forward progress.
-	 */
-	WRITE_ONCE(use_cid_lock, 1);
-	/*
-	 * Set use_cid_lock before allocation. Only care about program order
-	 * because this is only required for forward progress.
-	 */
-	barrier();
-	/*
-	 * Retry until it succeeds. It is guaranteed to eventually succeed once
-	 * all newcoming allocations observe the use_cid_lock flag set.
-	 */
-	do {
-		cid = __mm_cid_try_get(mm);
-		cpu_relax();
-	} while (cid < 0);
-	/*
-	 * Allocate before clearing use_cid_lock. Only care about
-	 * program order because this is for forward progress.
-	 */
-	barrier();
-	WRITE_ONCE(use_cid_lock, 0);
-unlock:
-	raw_spin_unlock(&cid_lock);
-end:
-	mm_cid_snapshot_time(rq, mm);
-	return cid;
-}
-
-static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
-{
-	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
-	int cid;
-
-	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
-	cid = __this_cpu_read(pcpu_cid->cid);
-	if (mm_cid_is_valid(cid)) {
-		mm_cid_snapshot_time(rq, mm);
-		return cid;
-	}
-	if (mm_cid_is_lazy_put(cid)) {
-		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
-			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
-	}
-	cid = __mm_cid_get(rq, mm);
-	__this_cpu_write(pcpu_cid->cid, cid);
-	return cid;
-}
-
-static inline void switch_mm_cid(struct rq *rq,
-				 struct task_struct *prev,
-				 struct task_struct *next)
-{
-	/*
-	 * Provide a memory barrier between rq->curr store and load of
-	 * {prev,next}->mm->pcpu_cid[cpu] on rq->curr->mm transition.
-	 *
-	 * Should be adapted if context_switch() is modified.
-	 */
-	if (!next->mm) {                                // to kernel
-		/*
-		 * user -> kernel transition does not guarantee a barrier, but
-		 * we can use the fact that it performs an atomic operation in
-		 * mmgrab().
-		 */
-		if (prev->mm)                           // from user
-			smp_mb__after_mmgrab();
-		/*
-		 * kernel -> kernel transition does not change rq->curr->mm
-		 * state. It stays NULL.
-		 */
-	} else {                                        // to user
-		/*
-		 * kernel -> user transition does not provide a barrier
-		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
-		 * Provide it here.
-		 */
-		if (!prev->mm) {                        // from kernel
-			smp_mb();
-		} else {				// from user
-			/*
-			 * user -> user transition relies on an implicit
-			 * memory barrier in switch_mm() when
-			 * current->mm changes. If the architecture
-			 * switch_mm() does not have an implicit memory
-			 * barrier, it is emitted here.  If current->mm
-			 * is unchanged, no barrier is needed.
-			 */
-			smp_mb__after_switch_mm();
-		}
-	}
-	if (prev->mm_cid_active) {
-		mm_cid_snapshot_time(rq, prev->mm);
-		mm_cid_put_lazy(prev);
-		prev->mm_cid = -1;
-	}
-	if (next->mm_cid_active)
-		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
-}
-
-#else
-static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
-static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
-static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
-static inline void init_sched_mm_cid(struct task_struct *t) { }
-#endif
-
  extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
  extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
  
-- 
2.25.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com



Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD348C7AC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 16:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354845AbiALPz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 10:55:29 -0500
Received: from mail.efficios.com ([167.114.26.124]:53424 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354844AbiALPz3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 10:55:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 01C41257049;
        Wed, 12 Jan 2022 10:55:29 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BVcWybWL_bi8; Wed, 12 Jan 2022 10:55:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4B5C62570B5;
        Wed, 12 Jan 2022 10:55:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4B5C62570B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642002928;
        bh=WFg5ps5+rGOiI1+k4Cq+mZNosF8jK0dTFL16UiYOiWk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fmRLPHsVP/QF5FyyRjb2aBgZuSDQh7OaywhK7SeTfXHM4R2c19a5Yd61AYO85Pv5N
         72Jl861vvviNpzzrH1teXh7ZV1hXhmWlPmx938QqBVrIuURXXo8D78khStnLZyqt3K
         PfXilDWWZVR4cGk9B7ZUk8s86d/KUu6pE17gCc9oW9tZpGbfFjIICX8yRNSLdsdhZa
         hn71Kptp5MKiIU6V4W0zyNArzfOhBW5bD70gKFZsF8VS9Vr5HcNePk9K8+vH9nIAkO
         lHpg7/ZX0btiLZ8txh46oTODECM7vgd90p0Bsw/cGdGXl6AbndEMb+RZZFry/bhEsK
         oZlAVl4GdSJOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4i-74l2K70Sf; Wed, 12 Jan 2022 10:55:28 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3A1862572A3;
        Wed, 12 Jan 2022 10:55:28 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:55:28 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        riel <riel@surriel.com>, Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Message-ID: <1966376798.24734.1642002928208.JavaMail.zimbra@efficios.com>
In-Reply-To: <e6e7c11c38a3880e56fb7dfff4fa67090d831a3b.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org> <e6e7c11c38a3880e56fb7dfff4fa67090d831a3b.1641659630.git.luto@kernel.org>
Subject: Re: [PATCH 05/23] membarrier, kthread: Use _ONCE accessors for
 task->mm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: membarrier, kthread: Use _ONCE accessors for task->mm
Thread-Index: A55GnHlC9HXtFr5lfVTpW5K+tsFQNQ==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jan 8, 2022, at 11:43 AM, Andy Lutomirski luto@kernel.org wrote:

> membarrier reads cpu_rq(remote cpu)->curr->mm without locking.  Use
> READ_ONCE() and WRITE_ONCE() to remove the data races.
> 

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> fs/exec.c                 | 2 +-
> kernel/exit.c             | 2 +-
> kernel/kthread.c          | 4 ++--
> kernel/sched/membarrier.c | 7 ++++---
> 4 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 3abbd0294e73..38b05e01c5bd 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1006,7 +1006,7 @@ static int exec_mmap(struct mm_struct *mm)
> 	local_irq_disable();
> 	active_mm = tsk->active_mm;
> 	tsk->active_mm = mm;
> -	tsk->mm = mm;
> +	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
> 	/*
> 	 * This prevents preemption while active_mm is being loaded and
> 	 * it and mm are being updated, which could cause problems for
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 91a43e57a32e..70f2cbc42015 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -491,7 +491,7 @@ static void exit_mm(void)
> 	 */
> 	smp_mb__after_spinlock();
> 	local_irq_disable();
> -	current->mm = NULL;
> +	WRITE_ONCE(current->mm, NULL);
> 	membarrier_update_current_mm(NULL);
> 	enter_lazy_tlb(mm, current);
> 	local_irq_enable();
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 396ae78a1a34..3b18329f885c 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1358,7 +1358,7 @@ void kthread_use_mm(struct mm_struct *mm)
> 		mmgrab(mm);
> 		tsk->active_mm = mm;
> 	}
> -	tsk->mm = mm;
> +	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
> 	membarrier_update_current_mm(mm);
> 	switch_mm_irqs_off(active_mm, mm, tsk);
> 	membarrier_finish_switch_mm(mm);
> @@ -1399,7 +1399,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
> 	smp_mb__after_spinlock();
> 	sync_mm_rss(mm);
> 	local_irq_disable();
> -	tsk->mm = NULL;
> +	WRITE_ONCE(tsk->mm, NULL);  /* membarrier reads this without locks */
> 	membarrier_update_current_mm(NULL);
> 	/* active_mm is still 'mm' */
> 	enter_lazy_tlb(mm, tsk);
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 30e964b9689d..327830f89c37 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -411,7 +411,7 @@ static int membarrier_private_expedited(int flags, int
> cpu_id)
> 			goto out;
> 		rcu_read_lock();
> 		p = rcu_dereference(cpu_rq(cpu_id)->curr);
> -		if (!p || p->mm != mm) {
> +		if (!p || READ_ONCE(p->mm) != mm) {
> 			rcu_read_unlock();
> 			goto out;
> 		}
> @@ -424,7 +424,7 @@ static int membarrier_private_expedited(int flags, int
> cpu_id)
> 			struct task_struct *p;
> 
> 			p = rcu_dereference(cpu_rq(cpu)->curr);
> -			if (p && p->mm == mm)
> +			if (p && READ_ONCE(p->mm) == mm)
> 				__cpumask_set_cpu(cpu, tmpmask);
> 		}
> 		rcu_read_unlock();
> @@ -522,7 +522,8 @@ static int sync_runqueues_membarrier_state(struct mm_struct
> *mm)
> 		struct task_struct *p;
> 
> 		p = rcu_dereference(rq->curr);
> -		if (p && p->mm == mm)
> +		/* exec and kthread_use_mm() write ->mm without locks */
> +		if (p && READ_ONCE(p->mm) == mm)
> 			__cpumask_set_cpu(cpu, tmpmask);
> 	}
> 	rcu_read_unlock();
> --
> 2.33.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

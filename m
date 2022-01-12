Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A89548C917
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 18:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355482AbiALRI3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 12:08:29 -0500
Received: from mail.efficios.com ([167.114.26.124]:49754 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355456AbiALRI2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 12:08:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3E521257EA3;
        Wed, 12 Jan 2022 12:08:28 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yacp3HuskVJ8; Wed, 12 Jan 2022 12:08:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BCE19257EA1;
        Wed, 12 Jan 2022 12:08:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BCE19257EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642007307;
        bh=q/NxvMK0ISAZ5ecyEbgSchfPS0aCq4m/pPedhguSeEk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XIuh702OCHY2iCYw878e2bA3sXpyq3u/Hkg/VXBo1oqcbNjQkQJnpJAaAHSkuShN6
         9Q/wh6vuGCUusnqbyGbvZhS7WO3ZVDBYpeCAaAI2bB8LYCC7To4g38TmDvi0lw3x38
         y5lIok+SLkZ+H+EIZhWVUiujJ4DfjDOHWDvzdhYtqHpm/KBIyxP1cWXaph9iwncPL0
         aLoH9tDBIzU/XAtIYzi4jW2TB/3O62cgORmERxZJrAkAkZOtVodiiVUNMxI5OyzVrX
         XiG867chd722qCb0zpv1RKN8/LY41xjLTMoW0jjBJwTYQCPhzcJa0dS2pcaL8ZgaiA
         FfAPGlD09S31w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FveHWTdu5DXT; Wed, 12 Jan 2022 12:08:27 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A6569257D26;
        Wed, 12 Jan 2022 12:08:27 -0500 (EST)
Date:   Wed, 12 Jan 2022 12:08:27 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <883836409.24887.1642007307554.JavaMail.zimbra@efficios.com>
In-Reply-To: <762743530.24791.1642005040611.JavaMail.zimbra@efficios.com>
References: <cover.1641659630.git.luto@kernel.org> <21273aa5349827de22507ef445fbde1a12ac2f8f.1641659630.git.luto@kernel.org> <762743530.24791.1642005040611.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 09/23] membarrier: Fix incorrect barrier positions
 during exec and kthread_use_mm()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (zclient/8.8.15_GA_4180)
Thread-Topic: membarrier: Fix incorrect barrier positions during exec and kthread_use_mm()
Thread-Index: PnXhJUPulweB+SlKA6xf2NbA2X24KT4YIoP3
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


----- Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- On Jan 8, 2022, at 11:43 AM, Andy Lutomirski luto@kernel.org wrote:
> 
> > membarrier() requires a barrier before changes to rq->curr->mm, not just
> > before writes to rq->membarrier_state.  Move the barrier in exec_mmap() to
> > the right place.
> 
> I don't see anything that was technically wrong with membarrier_exec_mmap
> before this patchset. membarrier_exec-mmap issued a smp_mb just after
> the task_lock(), and proceeded to clear the mm->membarrier_state and
> runqueue membarrier state. And then the tsk->mm is set *after* the smp_mb().
> 
> So from this commit message we could be led to think there was something
> wrong before, but I do not think it's true. This first part of the proposed
> change is merely a performance optimization that removes a useless memory
> barrier on architectures where smp_mb__after_spinlock() is a no-op, and
> removes a useless store to mm->membarrier_state because it is already
> zero-initialized. This is all very nice, but does not belong in a "Fix" patch.
> 
> > Add the barrier in kthread_use_mm() -- it was entirely
> > missing before.
> 
> This is correct. This second part of the patch is indeed a relevant fix.

However this adds a useless barrier for CONFIG_MEMBARRIER=n.

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> > 
> > This patch makes exec_mmap() and kthread_use_mm() use the same membarrier
> > hooks, which results in some code deletion.
> > 
> > As an added bonus, this will eliminate a redundant barrier in execve() on
> > arches for which spinlock acquisition is a barrier.
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
> > fs/exec.c                 |  6 +++++-
> > include/linux/sched/mm.h  |  2 --
> > kernel/kthread.c          |  5 +++++
> > kernel/sched/membarrier.c | 15 ---------------
> > 4 files changed, 10 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 38b05e01c5bd..325dab98bc51 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1001,12 +1001,16 @@ static int exec_mmap(struct mm_struct *mm)
> > 	}
> > 
> > 	task_lock(tsk);
> > -	membarrier_exec_mmap(mm);
> > +	/*
> > +	 * membarrier() requires a full barrier before switching mm.
> > +	 */
> > +	smp_mb__after_spinlock();
> > 
> > 	local_irq_disable();
> > 	active_mm = tsk->active_mm;
> > 	tsk->active_mm = mm;
> > 	WRITE_ONCE(tsk->mm, mm);  /* membarrier reads this without locks */
> > +	membarrier_update_current_mm(mm);
> > 	/*
> > 	 * This prevents preemption while active_mm is being loaded and
> > 	 * it and mm are being updated, which could cause problems for
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index e107f292fc42..f1d2beac464c 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -344,8 +344,6 @@ enum {
> > #include <asm/membarrier.h>
> > #endif
> > 
> > -extern void membarrier_exec_mmap(struct mm_struct *mm);
> > -
> > extern void membarrier_update_current_mm(struct mm_struct *next_mm);
> > 
> > /*
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 3b18329f885c..18b0a2e0e3b2 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -1351,6 +1351,11 @@ void kthread_use_mm(struct mm_struct *mm)
> > 	WARN_ON_ONCE(tsk->mm);
> > 
> > 	task_lock(tsk);
> > +	/*
> > +	 * membarrier() requires a full barrier before switching mm.
> > +	 */
> > +	smp_mb__after_spinlock();
> > +
> > 	/* Hold off tlb flush IPIs while switching mm's */
> > 	local_irq_disable();
> > 	active_mm = tsk->active_mm;
> > diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> > index c38014c2ed66..44fafa6e1efd 100644
> > --- a/kernel/sched/membarrier.c
> > +++ b/kernel/sched/membarrier.c
> > @@ -277,21 +277,6 @@ static void ipi_sync_rq_state(void *info)
> > 	smp_mb();
> > }
> > 
> > -void membarrier_exec_mmap(struct mm_struct *mm)
> > -{
> > -	/*
> > -	 * Issue a memory barrier before clearing membarrier_state to
> > -	 * guarantee that no memory access prior to exec is reordered after
> > -	 * clearing this state.
> > -	 */
> > -	smp_mb();
> > -	/*
> > -	 * Keep the runqueue membarrier_state in sync with this mm
> > -	 * membarrier_state.
> > -	 */
> > -	this_cpu_write(runqueues.membarrier_state, 0);
> > -}
> > -
> > void membarrier_update_current_mm(struct mm_struct *next_mm)
> > {
> > 	struct rq *rq = this_rq();
> > --
> > 2.33.1
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

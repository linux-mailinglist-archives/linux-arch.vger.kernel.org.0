Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D606E2CF5A1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgLDUYz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 15:24:55 -0500
Received: from mail.efficios.com ([167.114.26.124]:46594 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgLDUYy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 15:24:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6EBC22CE4B4;
        Fri,  4 Dec 2020 15:24:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XtVvbHAWYHXs; Fri,  4 Dec 2020 15:24:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F13DC2CE14C;
        Fri,  4 Dec 2020 15:24:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F13DC2CE14C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1607113453;
        bh=rq5dcyyJkV2nJGQEkk2dkiNiyZMC3h59InBJAZr7LGk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DQb+IXuMLZiZkl6/FKac7EjCLRftFpRpG6vh2qYMFlB5MzringJwiSc9VN6d1JS3B
         VAX28zdbm1L0+8m30VetC1Nuc3+0Wr+h8ppP1ibmQOzBLu/dTpDC4rlf780XEZDhC9
         xse6ZXafoSIDFb4SkuUXoZ5GRqO4Pbc9lpa/lZREcejg/xvXYFNBaaUm/tWyLwPwy2
         JM9HwsM2HTDmLo8yVFkZaNkQK34XjGOik/GG0k6lQurtLXVkBSz3xzCt4jpn1WjmVT
         fXj3Wmj7Vf/0vnVj6JGQVNtocDJV18sw0OKYnNdCu+woXidVrdNr0II7meWx9FcVuL
         NI1Umzxpn3KbQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JUD6KWMJdzGL; Fri,  4 Dec 2020 15:24:12 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DF2D12CE2F7;
        Fri,  4 Dec 2020 15:24:12 -0500 (EST)
Date:   Fri, 4 Dec 2020 15:24:12 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        riel <riel@surriel.com>, Dave Hansen <dave.hansen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>
Message-ID: <720512461.6585.1607113452812.JavaMail.zimbra@efficios.com>
In-Reply-To: <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org>
References: <cover.1607059162.git.luto@kernel.org> <203d39d11562575fd8bd6a094d97a3a332d8b265.1607059162.git.luto@kernel.org>
Subject: Re: [RFC v2 1/2] [NEEDS HELP] x86/mm: Handle unlazying membarrier
 core sync in the arch code
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: x86/mm: Handle unlazying membarrier core sync in the arch code
Thread-Index: lxVQX1VMi8/RWcw0PClIFIaXCQc/vA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Dec 4, 2020, at 12:26 AM, Andy Lutomirski luto@kernel.org wrote:

> The core scheduler isn't a great place for
> membarrier_mm_sync_core_before_usermode() -- the core scheduler doesn't
> actually know whether we are lazy.  With the old code, if a CPU is
> running a membarrier-registered task, goes idle, gets unlazied via a TLB
> shootdown IPI, and switches back to the membarrier-registered task, it
> will do an unnecessary core sync.
> 
> Conveniently, x86 is the only architecture that does anything in this
> hook, so we can just move the code.
> 
> XXX: there are some comments in swich_mm_irqs_off() that seem to be
> trying to document what barriers are expected, and it's not clear to me
> that these barriers are actually present in all paths through the
> code.  So I think this change makes the code more comprehensible and
> has no effect on the code's correctness, but I'm not at all convinced
> that the code is correct.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> arch/x86/mm/tlb.c   | 17 ++++++++++++++++-
> kernel/sched/core.c | 14 +++++++-------
> 2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 3338a1feccf9..23df035b80e8 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -8,6 +8,7 @@
> #include <linux/export.h>
> #include <linux/cpu.h>
> #include <linux/debugfs.h>
> +#include <linux/sched/mm.h>
> 
> #include <asm/tlbflush.h>
> #include <asm/mmu_context.h>
> @@ -496,6 +497,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> mm_struct *next,
> 		 * from one thread in a process to another thread in the same
> 		 * process. No TLB flush required.
> 		 */
> +
> +		// XXX: why is this okay wrt membarrier?
> 		if (!was_lazy)
> 			return;

As I recall, when the scheduler switches between threads which belong to
the same mm, it does not have to provide explicit memory barriers for
membarrier because it does not change the "rq->curr->mm" value which is
used as condition in the membarrier loop to send the IPI.

> 
> @@ -508,12 +511,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct
> mm_struct *next,
> 		smp_mb();
> 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
> 		if (this_cpu_read(cpu_tlbstate.ctxs[prev_asid].tlb_gen) ==
> -				next_tlb_gen)
> +		    next_tlb_gen) {
> +			/*
> +			 * We're reactivating an mm, and membarrier might
> +			 * need to serialize.  Tell membarrier.
> +			 */
> +
> +			// XXX: I can't understand the logic in
> +			// membarrier_mm_sync_core_before_usermode().  What's
> +			// the mm check for?
> +			membarrier_mm_sync_core_before_usermode(next);

I think you mean the:

        if (current->mm != mm)
                return;

check at the beginning.

We have to look at it from the scheduler context from which this function is called
(yeah, I know, it's not so great to mix up scheduler and mm states like this).

in finish_task_switch() we have:

        struct mm_struct *mm = rq->prev_mm;
[...]
        if (mm) {
                membarrier_mm_sync_core_before_usermode(mm);
                mmdrop(mm);
        }

I recall that this current->mm vs rq->prev_mm check is just there to
figure out whether we are in lazy tlb mode, and don't sync core in lazy
tlb mode. Hopefully I'm not stating anything stupid here, maybe Peter
could enlighten us. And you should definitely be careful when calling this
helper from other contexts, as it was originally crafted only for that
single use in the scheduler.


> 			return;
> +		}
> 
> 		/*
> 		 * TLB contents went out of date while we were in lazy
> 		 * mode. Fall through to the TLB switching code below.
> +		 * No need for an explicit membarrier invocation -- the CR3
> +		 * write will serialize.
> 		 */
> 		new_asid = prev_asid;
> 		need_flush = true;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..6c4b76147166 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3619,22 +3619,22 @@ static struct rq *finish_task_switch(struct task_struct
> *prev)
> 	kcov_finish_switch(current);
> 
> 	fire_sched_in_preempt_notifiers(current);
> +
> 	/*
> 	 * When switching through a kernel thread, the loop in
> 	 * membarrier_{private,global}_expedited() may have observed that
> 	 * kernel thread and not issued an IPI. It is therefore possible to
> 	 * schedule between user->kernel->user threads without passing though
> 	 * switch_mm(). Membarrier requires a barrier after storing to
> -	 * rq->curr, before returning to userspace, so provide them here:
> +	 * rq->curr, before returning to userspace, and mmdrop() provides
> +	 * this barrier.
> 	 *
> -	 * - a full memory barrier for {PRIVATE,GLOBAL}_EXPEDITED, implicitly
> -	 *   provided by mmdrop(),
> -	 * - a sync_core for SYNC_CORE.
> +	 * XXX: I don't think mmdrop() actually does this.  There's no
> +	 * smp_mb__before/after_atomic() in there.

I recall mmdrop providing a memory barrier. It looks like I event went though the
trouble of documenting it myself. ;-)

static inline void mmdrop(struct mm_struct *mm)
{
        /*
         * The implicit full barrier implied by atomic_dec_and_test() is
         * required by the membarrier system call before returning to
         * user-space, after storing to rq->curr.
         */
        if (unlikely(atomic_dec_and_test(&mm->mm_count)))
                __mmdrop(mm);
}


> 	 */
> -	if (mm) {
> -		membarrier_mm_sync_core_before_usermode(mm);

OK so here is the meat. The current code is using the (possibly incomplete)
lazy TLB state known by the scheduler to sync core, and it appears it may be
a bit more heavy that what is strictly needed.

Your change instead rely on the internal knowledge of lazy TLB within x86
switch_mm_irqs_off to achieve this, which overall seems like an improvement.

I agree with Nick's comment that it should go on top of his exit_lazy_mm
patches.

Thanks,

Mathieu


> +	if (mm)
> 		mmdrop(mm);
> -	}
> +
> 	if (unlikely(prev_state == TASK_DEAD)) {
> 		if (prev->sched_class->task_dead)
> 			prev->sched_class->task_dead(prev);
> --
> 2.28.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

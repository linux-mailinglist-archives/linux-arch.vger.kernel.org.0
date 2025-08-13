Return-Path: <linux-arch+bounces-13159-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2AB24FA0
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 18:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3681F5A23AB
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4E2868AC;
	Wed, 13 Aug 2025 16:10:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878B23A9BB;
	Wed, 13 Aug 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101408; cv=none; b=T6Ftc9rPGQjEZpCztS4h7uymGLtLROdmtQIT7FHolgWuCiKZZvqBMlo2Y0pLWpv59BNsDnWWAKuX4qThQGSsbuWgyqjvKoqQZ2Oi5g3o7gPVMhs523upgtQcSgngIRn60J6od7Ug4gxdBMPgQdZK0e8N7xKghEiKo017Y6/nhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101408; c=relaxed/simple;
	bh=7EUD+30GOOiF0HQRy00RHvsbBxoJiqxPdGiWSNqyz7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCbKrfDb90s4OD0jsoy87dryw4r07No/Qb5o6bI1Y4ZWL64mAG1AUkeZlxGyCJoFaWLtw0jWxDoUHaMs0fweAXb/+JpcrU5GC0bDaa9KVMpeZLGidaFwXcmC676EoimJWnTkOUJ+ZYbsvyGWO4jy5kUCjGpr4lr3vTqDcZa5HFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C8CC4CEEB;
	Wed, 13 Aug 2025 16:10:02 +0000 (UTC)
Date: Wed, 13 Aug 2025 17:09:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	arnd@arndb.de, will@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aJy414YufthzC1nv@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bz98sqb.fsf@oracle.com>

On Mon, Aug 11, 2025 at 02:15:56PM -0700, Ankur Arora wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Thu, Jun 26, 2025 at 09:48:01PM -0700, Ankur Arora wrote:
> >> +#ifndef __smp_cond_load_relaxed_timewait
> >> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,	\
> >> +					 time_expr, time_end,		\
> >> +					 slack) ({			\
> >> +	typeof(ptr) __PTR = (ptr);					\
> >> +	__unqual_scalar_typeof(*ptr) VAL;				\
> >> +	u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;			\
> >> +	u64 __prev = 0, __end = (time_end);				\
> >> +	u64 __slack = slack;						\
> >> +	bool __wait = false;						\
> >> +									\
> >> +	for (;;) {							\
> >> +		VAL = READ_ONCE(*__PTR);				\
> >> +		if (cond_expr)						\
> >> +			break;						\
> >> +		cpu_relax();						\
> >> +		if (++__n < __spin)					\
> >> +			continue;					\
> >> +		if (!(__prev = policy((time_expr), __prev, __end,	\
> >> +					  &__spin, &__wait, __slack)))	\
> >> +			break;						\
> >> +		if (__wait)						\
> >> +			__smp_timewait_store(__PTR, VAL);		\
> >> +		__n = 0;						\
> >> +	}								\
> >> +	(typeof(*ptr))VAL;						\
> >> +})
> >> +#endif
> >
> > TBH, this still looks over-engineered to me, especially with the second
> > patch trying to reduce the spin loops based on the remaining time. Does
> > any of the current users of this interface need it to get more precise?
> 
> No, neither of rqspinlock nor poll_idle() really care about precision.
> And, the slack even in this series is only useful for the waiting
> implementation.

I pretty much came to the same conclusion. I guess it depends on how we
implement it. With WFET, the precision depends on the hardware clock.
For WFE, we could use the 100us event stream only or we could do like
__delay() and fall back to busy spinning for smaller (or end of)
intervals.

The spinning variant may have some random slack depending on how long it
loops before checking the clock.

> > Also I feel the spinning added to poll_idle() is more of an architecture
> > choice as some CPUs could not cope with local_clock() being called too
> > frequently.
> 
> Just on the frequency point -- I think it might be a more general
> problem that just on specific architectures.
> 
> Architectures with GENERIC_SCHED_CLOCK could use a multitude of
> clocksources and from a quick look some of them do iomem reads.
> (AFAICT GENERIC_SCHED_CLOCK could also be selected by the clocksource
> itself, so an architecture header might not need to be an arch choice
> at  all.)
> 
> Even for something like x86 which doesn't use GENERIC_SCHED_CLOCK,
> we might be using tsc or jiffies or paravirt-clock all of which would
> have very different performance characteristics. Or, just using a
> clock more expensive than local_clock(); rqspinlock uses
> ktime_get_mono_fast_ns().
> 
> So, I feel we do need a generic rate limiter.

That's a good point but the rate limiting is highly dependent on the
architecture, what a CPU does in the loop, how fast a loop iteration is.
That's why I'd keep it hidden in the arch code.

> > The above generic implementation takes a spin into
> > consideration even if an arch implementation doesn't need it (e.g. WFET
> > or WFE). Yes, the arch policy could set a spin of 0 but it feels overly
> > complicated for the generic implementation.
> 
> Agree with the last point. My thought was that it might be okay to always
> optimistically spin a little, just because WFE*/MWAITX etc might (?)
> have a entry/exit cost even when the wakeup is immediate.

They key is whether the cost is more expensive than some spinning. On
arm64, cpu_relax() doesn't do anything, so WFE is not any worse even if
it exits immediately (e.g. a SEVL+WFE loop). The only benefit would be
if the cost of local_clock() is more expensive than some busy spinning.
The arch code is better placed to know what kind of spinning is best.

> Though the code is wrong in that it always waits right after evaluating
> the policy. I should have done something like this instead:
> 
> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,       \
> +                                        time_expr, time_end,           \
> +                                        slack) ({                      \
> +       typeof(ptr) __PTR = (ptr);                                      \
> +       __unqual_scalar_typeof(*ptr) VAL;                               \
> +       u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;                   \
> +       u64 __prev = 0, __end = (time_end);                             \
> +       u64 __slack = slack;                                            \
> +       bool __wait = false;                                            \
> +                                                                       \
> +       for (;;) {                                                      \
> +               VAL = READ_ONCE(*__PTR);                                \
> +               if (cond_expr)                                          \
> +                       break;                                          \
> +               cpu_relax();                                            \
> +               if (++__n < __spin)                                     \
> +                       continue;                                       \
> +               if (__wait)                                             \
> +                       __smp_timewait_store(__PTR, VAL);               \
> +               if (!(__prev = policy((time_expr), __prev, __end,       \
> +                                         &__spin, &__wait, __slack)))  \
> +                       break;                                          \
> +               __n = 0;                                                \
> +       }                                                               \
> +       (typeof(*ptr))VAL;                                              \
> +})

I think both variants work just fine. The original one made more sense
with waiting immediately after the policy decided that it is needed.
With the above, you go through the loop one more time before detecting
__wait == true.

I thought the current __smp_cond_load_acquire_timewait() is not doing
the right thing but it does check cond_expr immediately after exiting
__cmpwait_relaxed() (if no timeout), so no unnecessary waiting.

> >> +#define __check_time_types(type, a, b)			\
> >> +		(__same_type(typeof(a), type) &&	\
> >> +		 __same_type(typeof(b), type))
> >> +
> >> +/**
> >> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
> >> + * guarantees until a timeout expires.
> >> + * @ptr: pointer to the variable to wait on
> >> + * @cond: boolean expression to wait for
> >> + * @time_expr: monotonic expression that evaluates to the current time
> >> + * @time_end: end time, compared against time_expr
> >> + * @slack: how much timer overshoot can the caller tolerate?
> >> + * Useful for when we go into wait states. A value of 0 indicates a high
> >> + * tolerance.
> >> + *
> >> + * Note that all times (time_expr, time_end, and slack) are in microseconds,
> >> + * with no mandated precision.
> >> + *
> >> + * Equivalent to using READ_ONCE() on the condition variable.
> >> + */
> >> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_expr,	\
> >> +				       time_end, slack) ({		\
> >> +	__unqual_scalar_typeof(*ptr) _val;				\
> >> +	BUILD_BUG_ON_MSG(!__check_time_types(u64, time_expr, time_end),	\
> >> +			 "incompatible time units");			\
> >> +	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
> >> +						__smp_cond_policy,	\
> >> +						time_expr, time_end,	\
> >> +						slack);			\
> >> +	(typeof(*ptr))_val;						\
> >> +})
> >
> > Looking at the current user of the acquire variant - rqspinlock, it does
> > not even bother with a time_expr but rather added the time condition to
> > cond_expr. I don't think it has any "slack" requirements, only that
> > there's no deadlock eventually.
> 
> So, that code only uses smp_cond_load_*_timewait() on arm64. Everywhere
> else it just uses smp_cond_load_acquire() and because it jams both
> of these interfaces together, it doesn't really use time_expr.
> 
> But, it needs more extensive rework so all platforms can use
> __smp_cond_load_acquire_timewait with the deadlock check folded
> inside its own policy handler.

We can have a generic:

#define smp_cond_load_acquire_timewait(ptr, cond_expr, time_expr) \
	smp_cond_load_acquire(ptr, (cond_expr) || (time_expr))

with some big comment that it may deadlock if an architecture does not
regularly check timer_expr in the absence of a *ptr update.

Alternatively, just define res_smp_cond_load_acquire() in the bpf code
to take separate cond_expr and time_expr and do an 'or' between them in
the default implementation.

> > About poll_idle(), are there any slack requirement or we get away
> > without?
> 
> I don't believe there are any slack requirements. Definitely not for
> rqspinlock (given that it has a large timeout) and I believe also
> not for poll_idle() since a timeout delay only leads to a slightly
> delayed deeper sleep.
> 
> Question for Rafael, Daniel: With smp_cond_load_relaxed_timewait(), when
> used in waiting mode instead of via the usual cpu_relax() spin, we
> could overshoot by an architecturally defined granularity.
> On arm64, that could be ~100us in the worst case. Do we have hard
> requirements about timer overshoot in poll_idle()?

I can see a CPUIDLE_POLL_MIN and MAX defined as 10us and 250us
respectively (for a HZ of 250). Not sure it matters if we overshoot by
100us. If it does, we should do like the __delay() implementation with a
fall-back to a busy loop.

> > I think we have two ways forward (well, at least):
> >
> > 1. Clearly define what time_end is and we won't need a time_expr at all.
> >    This may work for poll_idle(), not sure about rqspinlock. The
> >    advantage is that we can drop the 'slack' argument since none of the
> >    current users seem to need it. The downside is that we need to know
> >    exactly what this time_end is to convert it to timer cycles for a
> >    WFET implementation on arm64.
> >
> > 2. Drop time_end and only leave time_expr as a bool (we don't care
> >    whether it uses ns, jiffies or whatever underneath, it's just a
> >    bool). In this case, we could use a 'slack' argument mostly to make a
> >    decision on whether we use WFET, WFE or just polling with
> >    cpu_relax(). For WFET, the wait time would be based on the slack
> >    value rather than some absolute end time which we won't have.
> >
> > I'd go with (2), it looks simpler. Maybe even drop the 'slack' argument
> > for the time being until we have a clear user. The fallback on arm64
> > would be from wfe (if event streaming available), wfet with the same
> > period as the event stream (in the absence of a slack argument) or
> > cpu_relax().
> 
> So I like the approach with (2) quite a bit. It'll simplify the time
> handling quite nicely. And, I think it is also good to drop slack
> unless there's a use for it.
> 
> There's just one problem, which is that a notion of time-remaining
> still seems quite important to me. Without it, it's difficult to know
> how often to do the time-check etc. I could use an arbitrary
> parameter, say evaluate time_expr once every N cpu_relax() loops etc
> but that seems worse than the current approach.
> 
> So, how about replacing the bool time_expr, with a time_remaining_expr
> (s32) which evaluates to a fixed time unit (ns).

I'd use ktime_t instead of s32. It is already signed and can represent
(negative) time deltas. The downside is that we need to use
ns_to_ktime() etc. for conversion.

However, in the absence of some precision requirement for the potential
two users of this interface, I think we complicate things unnecessarily.
The only advantage is if you want to make it future proof, in case we
ever need more precision.

> This also gives the WFET a clear end time (though it would still need
> to be converted to timer cycles) but the WFE path could stay simple
> by allowing an overshoot instead of falling back to polling.

For arm64, both WFE and WFET would be woken up by the event stream
(which is enabled on all production systems). The only reason to use
WFET is if you need smaller granularity than the event stream period
(100us). In this case, we should probably also add a fallback from WFE
to a busy loop.

-- 
Catalin


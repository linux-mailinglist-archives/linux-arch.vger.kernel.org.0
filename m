Return-Path: <linux-arch+bounces-13167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5AB26474
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BCD1C85D71
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D82F2913;
	Thu, 14 Aug 2025 11:39:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B322EE29B;
	Thu, 14 Aug 2025 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171562; cv=none; b=CNxnCatTFXQ98oqbS4+kQfNiLHn7hpxTER6Is9UBNhWacTB9WlwDKasPUT/hjm7rxJBY9Cd9GU6PQIbZxb3dv7+s5ZRIkkSQcq8ATnVlLA56LwuoRJ1tElSgH7v2lFh/1L6ngxInlgE6ISifEP3EVff0v+SZ/e50jP4RT8wXnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171562; c=relaxed/simple;
	bh=Eir/rgS3kgL52Co3KkPLtwcZ4CRSV9Q+wvSC4VDLnRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHVihryX3iZe8cjzMeiTuCtvUGOg5fvghn9t9BkDJGuN5bONeWmQQXDtNh1j/gkUKTFNU2mySt3ASypK+KDh+/GdMrL3h4W9ar4QdQJvRnaSuszlKkyg2YU2gMVksYC7zLfJ6vkBrxAOJx3qtZVqxWPiXBqInlsDvlEr7OGJCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4A0C4CEED;
	Thu, 14 Aug 2025 11:39:17 +0000 (UTC)
Date: Thu, 14 Aug 2025 12:39:14 +0100
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
Message-ID: <aJ3K4tQCztOXF6hO@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com>
 <87bjoi2wdf.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjoi2wdf.fsf@oracle.com>

On Thu, Aug 14, 2025 at 12:30:36AM -0700, Ankur Arora wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Mon, Aug 11, 2025 at 02:15:56PM -0700, Ankur Arora wrote:
> >> Catalin Marinas <catalin.marinas@arm.com> writes:
> >> > Also I feel the spinning added to poll_idle() is more of an architecture
> >> > choice as some CPUs could not cope with local_clock() being called too
> >> > frequently.
> >>
> >> Just on the frequency point -- I think it might be a more general
> >> problem that just on specific architectures.
> >>
> >> Architectures with GENERIC_SCHED_CLOCK could use a multitude of
> >> clocksources and from a quick look some of them do iomem reads.
> >> (AFAICT GENERIC_SCHED_CLOCK could also be selected by the clocksource
> >> itself, so an architecture header might not need to be an arch choice
> >> at  all.)
> >>
> >> Even for something like x86 which doesn't use GENERIC_SCHED_CLOCK,
> >> we might be using tsc or jiffies or paravirt-clock all of which would
> >> have very different performance characteristics. Or, just using a
> >> clock more expensive than local_clock(); rqspinlock uses
> >> ktime_get_mono_fast_ns().
> >>
> >> So, I feel we do need a generic rate limiter.
> >
> > That's a good point but the rate limiting is highly dependent on the
> > architecture, what a CPU does in the loop, how fast a loop iteration is.
> >
> > That's why I'd keep it hidden in the arch code.
> 
> Yeah, this makes sense. However, I would like to keep as much of the
> code that does this common.

You can mimic what poll_idle() does for x86 in the generic
implementation, maybe with some comment referring to the poll_idle() CPU
usage of calling local_clock() in a loop. However, allow the arch code
to override the whole implementation and get rid of the policy. If an
arch wants to spin for some power reason, it can do it itself. The code
duplication for a while loop is much more readable than a policy setting
some spin/wait parameters just to have a single spin loop. If at some
point we see some pattern, we could revisit the common code.

For arm64, I doubt the extra spinning makes any difference. Our
cpu_relax() doesn't do anything (almost), it's probably about the same
cost as reading the monotonic clock. I also see a single definition
close enough to the logic in __delay() on arm64. It would be more
readable than a policy callback setting wait/spin with a separate call
for actually waiting. Well, gut feel, let's see how that would look
like.

> Currently the spin rate limit is scaled up or down based on the current
> spin (or SMP_TIMEWAIT_SPIN_BASE) in the common __smp_cond_spinwait()
> which implements a default policy.
> SMP_TIMEWAIT_SPIN_BASE can already be chosen by the architecture but
> that doesn't allow it any runtime say in the spinning.
> 
> I think a good way to handle this might be the same way that the wait
> policy is handled. When the architecture handler (__smp_cond_timewait()
> on arm64) is used, it should be able to choose both spin and wait and
> can feed those back into __smp_cond_spinwait() which can do the scaling
> based on that.

Exactly.

> > However, in the absence of some precision requirement for the potential
> > two users of this interface, I think we complicate things unnecessarily.
> > The only advantage is if you want to make it future proof, in case we
> > ever need more precision.
> 
> There's the future proofing aspect but also having time-remaining
> simplifies the rate limiting of the time-check because now it can
> rate-limit depending on how often the policy handler is called and
> the remaining time.

To keep things simple, I'd skip the automatic adjustment of the rate
limiting in the generic code. Just go for a fixed one until someone
complains about the slack.

> >> This also gives the WFET a clear end time (though it would still need
> >> to be converted to timer cycles) but the WFE path could stay simple
> >> by allowing an overshoot instead of falling back to polling.
> >
> > For arm64, both WFE and WFET would be woken up by the event stream
> > (which is enabled on all production systems). The only reason to use
> > WFET is if you need smaller granularity than the event stream period
> > (100us). In this case, we should probably also add a fallback from WFE
> > to a busy loop.
> 
> What do you think would be a good boundary for transitioning to a busy
> loop?
> 
> Say, we have < 100us left and the event-stream is 100us. We could do
> what __delay() does and spin for the remaining time. But given that we
> dont' care about precision at least until there's need for it, it seems
> to be better to err on the side of saving power.
> 
> So, how about switching to busy-looping when we get to event-stream-period/4?
> (and note that in a comment block.)

Let's do like __delay() (the principle, not necessarily copying the
code) - start with WFET if available, WFE otherwise. For the latter,
when the time left is <100us, fall back to spinning. We can later get
someone to benchmark the power usage and we can revisit. Longer term,
WFET would be sufficient without any spinning.

That said, I thin our __delay() implementation doesn't need spinning if
WFET is available:

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index cb2062e7e234..5d4c28db399a 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -43,10 +43,10 @@ void __delay(unsigned long cycles)
 
 		while ((get_cycles() - start + timer_evt_period) < cycles)
 			wfe();
-	}
 
-	while ((get_cycles() - start) < cycles)
-		cpu_relax();
+		while ((get_cycles() - start) < cycles)
+			cpu_relax();
+	}
 }
 EXPORT_SYMBOL(__delay);
 
-- 
Catalin


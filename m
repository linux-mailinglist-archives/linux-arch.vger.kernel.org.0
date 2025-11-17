Return-Path: <linux-arch+bounces-14844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA06AC66258
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D014358F98
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D031E0EB;
	Mon, 17 Nov 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRxTQULB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W8izBf6H"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0D3009F6;
	Mon, 17 Nov 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412694; cv=none; b=Mp5dwwXSoDpd+rKjSReddTtiUdZP5bv+vgHQg0Q6BidjLjU4lUi2NlE124KrIVojQ9Xc6mlZUHvAP1Alel9zASQFz6LjlpCue/OzDDf5BC6ji9MkPdRvE2T3aLlNVBp+l0DOdjoZcX3EVGhPwwZkAs0MnCstOORZeKJF5kFR52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412694; c=relaxed/simple;
	bh=wN8fmt7NpOMhD4sOAeUk6u1/7HL7xBaDdmC6VgoHqtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9hP2/Xyy3kgyYOsAc2jWhzJUn8cCZRBapBvdl559BE/SMsZN22ksivAQX44oRln8T1nA5gTWI12ud5jwUVhGKR2coPzN0NzCb/TqfodGgKEPDAkhX0VDAdGhFXpCeO1G44yQVQqQumRScTMs+1SU7fOGD5LYitzv+dK5gC+Wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRxTQULB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W8izBf6H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763412690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Agw1lL1KrApoZxOnjQoLszxB8TRlkrFXynKPAIydGPA=;
	b=oRxTQULB+SQN5VgymjV0XVwPUSjexUuAlXw6RKJBjlF9Uf/dTFA7P1DGg6KWAYwg8dv1al
	P41P51GIXKVE6VNU/JQ3sPfyyYyWqXfPgxkID3ioU1MVzx3CpFjIQlHls1rEqwn2Rtc5lO
	1BsXrdLO5imqPw3IdKsNJXxhD6LEgT+c7cf+GdI7z9d6qmmCkFEZYP9O/wakhyR9+zpuvG
	MWwmnNMA/Uhz17Ia96LevSl8RYtQ/GIptFPzjOadAlH1/eq5eMzdlqt2xQ+uvYdAHNiUUI
	5yJDtxOggwFFFK7d/HSog99nsP6PzzlGxUQg/4nCy8NXGsuHBRrjP/GbQXhcdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763412690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Agw1lL1KrApoZxOnjQoLszxB8TRlkrFXynKPAIydGPA=;
	b=W8izBf6HBNgZEWH5dN3ip8wM6W+5KIxEZv5FbG6hYnVXcEa88DDEDID6vOLx7Q1lEqxeg7
	TtDeBJWWq06A+NBg==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v2 4/8] genirq: soft_moderation: implement adaptive
 moderation
In-Reply-To: <20251116182839.939139-5-lrizzo@google.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-5-lrizzo@google.com>
Date: Mon, 17 Nov 2025 21:51:29 +0100
Message-ID: <87jyzo757y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
> Add two control parameters (target_irq_rate and hardirq_percent)
> to indicate the desired maximum values for these two metrics.
>
> Every update_ms the hook in handle_irq_event() recomputes the total and
> local interrupt rate and the amount of time spent in hardirq, compares
> the values with the targets, and adjusts the moderation delay up or down.
>
> The interrupt rate is computed in a scalable way by counting interrupts
> per-CPU, and aggregating the value in a global variable only every
> update_ms. Only CPUs that actively process interrupts are actually
> accessing the shared variable, so the system scales well even on very
> large servers.

You still fail to explain why this is required and why a per CPU
moderation is not sufficient and what the benefits of the approach are.

I'm happy to refer you to Documentation once more. It's well explained
there.

> +/* Measure and assess time spent in hardirq. */
> +static inline bool hardirq_high(struct irq_mod_state *ms, u64 delta_time, u32 hardirq_percent)
> +{
> +	bool above_threshold = false;
> +
> +	if (IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING)) {
> +		u64 irqtime, cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];
> +
> +		irqtime = cur - ms->last_irqtime;
> +		ms->last_irqtime = cur;
> +
> +		above_threshold = irqtime * 100 > delta_time * hardirq_percent;
> +		ms->hardirq_high += above_threshold;
> +	}
> +	return above_threshold;
> +}
> +
> +/* Measure and assess total and per-CPU interrupt rates. */
> +static inline bool irqrate_high(struct irq_mod_state *ms, u64 delta_time,
> +				u32 target_rate, u32 steps)
> +{
> +	u64 irq_rate, my_irq_rate, tmp, delta_irqs, active_cpus;
> +	bool my_rate_high, global_rate_high;
> +
> +	my_irq_rate = (ms->irq_count * NSEC_PER_SEC) / delta_time;
> +	/* Accumulate global counter and compute global irq rate. */
> +	tmp = atomic_long_add_return(ms->irq_count, &irq_mod_info.total_intrs);
> +	ms->irq_count = 1;
> +	delta_irqs = tmp - ms->last_total_irqs;
> +	ms->last_total_irqs = tmp;
> +	irq_rate = (delta_irqs * NSEC_PER_SEC) / delta_time;
> +
> +	/*
> +	 * Count how many CPUs handled interrupts in the last interval, needed
> +	 * to determine the per-CPU target (target_rate / active_cpus).
> +	 * Each active CPU increments the global counter approximately every
> +	 * update_ns. Scale the value by (update_ns / delta_time) to get the
> +	 * correct value. Also apply rounding and make sure active_cpus > 0.
> +	 */
> +	tmp = atomic_long_add_return(1, &irq_mod_info.total_cpus);
> +	active_cpus = tmp - ms->last_total_cpus;
> +	ms->last_total_cpus = tmp;
> +	active_cpus = (active_cpus * ms->update_ns + delta_time / 2) / delta_time;
> +	if (active_cpus < 1)
> +		active_cpus = 1;
> +
> +	/* Compare with global and per-CPU targets. */
> +	global_rate_high = irq_rate > target_rate;
> +	my_rate_high = my_irq_rate * active_cpus * irq_mod_info.scale_cpus > target_rate * 100;
> +
> +	/* Statistics. */
> +	smooth_avg(&ms->irq_rate, irq_rate, steps);
> +	smooth_avg(&ms->my_irq_rate, my_irq_rate, steps);
> +	smooth_avg(&ms->scaled_cpu_count, active_cpus * 256, steps);
> +	ms->my_irq_high += my_rate_high;
> +	ms->irq_high += global_rate_high;
> +
> +	/* Moderate on this CPU only if both global and local rates are high. */

Because it's desired that CPUs can be starved by interrupts when enough
other CPUs only have a very low rate? I'm failing to understand that
logic and the comprehensive rationale in the change log does not help either.

> +	return global_rate_high && my_rate_high;
> +}
> +
> +/* Adjust the moderation delay, called at most every update_ns. */
> +void __irq_moderation_adjust_delay(struct irq_mod_state *ms, u64 delta_time)
> +{
> +	u32 hardirq_percent = READ_ONCE(irq_mod_info.hardirq_percent);
> +	u32 target_rate = READ_ONCE(irq_mod_info.target_irq_rate);
> +	bool below_target = true;
> +	u32 steps;
> +
> +	if (target_rate == 0 && hardirq_percent == 0) {
> +		/* Use fixed moderation delay. */
> +		ms->mod_ns = ms->delay_ns;
> +		ms->irq_rate = 0;
> +		ms->my_irq_rate = 0;
> +		ms->scaled_cpu_count = 0;
> +		return;
> +	}
> +
> +	/* Compute decay steps based on elapsed time, bound to a reasonable value. */
> +	steps = delta_time > 10 * ms->update_ns ? 10 : 1 + (delta_time / ms->update_ns);
> +
> +	if (target_rate > 0 && irqrate_high(ms, delta_time, target_rate, steps))
> +		below_target = false;
> +
> +	if (hardirq_percent > 0 && hardirq_high(ms, delta_time, hardirq_percent))
> +		below_target = false;

So that rate limits a per CPU overload, but only when IRQTIME accounting
is enabled. Oh well...

> +	/* Controller: adjust delay with exponential decay/grow. */
> +	if (below_target) {
> +		ms->mod_ns -= ms->mod_ns * steps / (steps + irq_mod_info.decay_factor);
> +		if (ms->mod_ns < 100)
> +			ms->mod_ns = 0;

These random numbers used to limit things are truly interresting and
easy to understand - NOT.

> +	} else {
> +		/* Exponential grow does not restart if value is too small. */
> +		if (ms->mod_ns < 500)
> +			ms->mod_ns = 500;
> +		ms->mod_ns += ms->mod_ns * steps / (steps + irq_mod_info.grow_factor);
> +		if (ms->mod_ns > ms->delay_ns)
> +			ms->mod_ns = ms->delay_ns;
> +	}

Why does this need separate grow and decay factors? Just because more
knobs are better?

> +}
> +
>  /* Moderation timer handler. */
>  static enum hrtimer_restart timer_cb(struct hrtimer *timer)
>  {
> @@ -169,8 +289,10 @@ static inline int set_moderation_mode(struct irq_desc *desc, bool enable)
>  /* Print statistics */
>  static int moderation_show(struct seq_file *p, void *v)
>  {
> +	ulong irq_rate = 0, irq_high = 0, my_irq_high = 0, hardirq_high = 0;
>  	uint delay_us = irq_mod_info.delay_us;
> -	int j;
> +	u64 now = ktime_get_ns();
> +	int j, active_cpus = 0;
>  
>  #define HEAD_FMT "%5s  %8s  %8s  %4s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %11s  %11s  %9s\n"
>  #define BODY_FMT "%5u  %8u  %8u  %4u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %11u  %11u  %9u\n"
> @@ -182,6 +304,23 @@ static int moderation_show(struct seq_file *p, void *v)
>  
>  	for_each_possible_cpu(j) {
>  		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
> +		u64 age_ms = min((now - ms->last_ns) / NSEC_PER_MSEC, (u64)999999);

Not new in this patch: All of those accesses to remote CPU state are
racy and need to be annotated. This clearly never saw any testing with
KCSAN enabled. I'm happy to point to Documentation once again.

What's new is that this one is obviously broken on 32-bit because read
and write of a 64-bit value are split.

> +		if (age_ms < 10000) {
> +			/* Average irq_rate over recently active CPUs. */
> +			active_cpus++;
> +			irq_rate += ms->irq_rate;
> +		} else {
> +			ms->irq_rate = 0;
> +			ms->my_irq_rate = 0;
> +			ms->scaled_cpu_count = 64;
> +			ms->scaled_src_count = 64;
> +			ms->mod_ns = 0;
> +		}
> +
> +		irq_high += ms->irq_high;
> +		my_irq_high += ms->my_irq_high;
> +		hardirq_high += ms->hardirq_high;
>  
>  		seq_printf(p, BODY_FMT,
>  			   j, ms->irq_rate, ms->my_irq_rate,
> @@ -195,9 +334,34 @@ static int moderation_show(struct seq_file *p, void *v)
>  	seq_printf(p, "\n"
>  		   "enabled              %s\n"
>  		   "delay_us             %u\n"
> -		   "timer_rounds         %u\n",
> +		   "timer_rounds         %u\n"
> +		   "target_irq_rate      %u\n"
> +		   "hardirq_percent      %u\n"
> +		   "update_ms            %u\n"
> +		   "scale_cpus           %u\n"
> +		   "count_timer_calls    %s\n"
> +		   "count_msi_calls      %s\n"
> +		   "decay_factor         %u\n"
> +		   "grow_factor          %u\n",
>  		   str_yes_no(delay_us > 0),
> -		   delay_us, irq_mod_info.timer_rounds);
> +		   delay_us, irq_mod_info.timer_rounds,
> +		   irq_mod_info.target_irq_rate, irq_mod_info.hardirq_percent,
> +		   irq_mod_info.update_ms, irq_mod_info.scale_cpus,
> +		   str_yes_no(irq_mod_info.count_timer_calls),
> +		   str_yes_no(irq_mod_info.count_msi_calls),
> +		   irq_mod_info.decay_factor, irq_mod_info.grow_factor);
> +
> +	seq_printf(p,
> +		   "irq_rate             %lu\n"
> +		   "irq_high             %lu\n"
> +		   "my_irq_high          %lu\n"
> +		   "hardirq_percent_high %lu\n"
> +		   "total_interrupts     %lu\n"
> +		   "total_cpus           %lu\n",
> +		   active_cpus ? irq_rate / active_cpus : 0,
> +		   irq_high, my_irq_high, hardirq_high,
> +		   READ_ONCE(*((ulong *)&irq_mod_info.total_intrs)),
> +		   READ_ONCE(*((ulong *)&irq_mod_info.total_cpus)));

The more I look at this insane amount of telemetry the more I am
convinced that this is overly complex just for complexity sake.

Thanks,

        tglx


Return-Path: <linux-arch+bounces-15500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC6CCD5BF
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 20:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DCB430B7F94
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419B376BC2;
	Thu, 18 Dec 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="34Fp4cb7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H9QGndc8"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740C362130;
	Thu, 18 Dec 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073638; cv=none; b=tS+K8+UtKRukkcTpz886f/W5YaJ5QSactL0x6GdLm94F7vQyzzRXAJFtMIWJ31AuOhh3faLYT7mtjAWRR9y3XE1whqjoPBhoXukoNELGTiU94hZswJ5K3x2N7FePFsK0IRbnAvwh1pV6KLU5qSJsIXQZxibgSVu3Ul/ItfGNwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073638; c=relaxed/simple;
	bh=hlRbvFEZnhiWhzdZGiJpvVUjhTaJo0CkNBM2BDzfoo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VvxDLMd0JFx0L1LapZ5fhU1t0H5bb1+A7bt6ZPPytjzANrg9rOUADa8UMKah6jzEYYY9zK/rdLpQ3czb233IsoYZqUpOtE0tNQi52LqRBDP+2PkquO0iTCItS+YmmdZK3mDhKpewgt5mU7l3z6gSPis75Hu1pbI7JG5VWgbbxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=34Fp4cb7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H9QGndc8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766073632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWdSiplMDGwv3wXAq7CGyCUnNkEGK03e3coBLLf46WM=;
	b=34Fp4cb7iZKM2RbuBzCAZTajNLrZ9V6zIPp6me5WsstpEhO7byLjtuHgE6DHomtgyn641S
	rsYJTc1qTMB1QSKVJostIrOF/OiuC4e1exU/w9fFLMmelirJU9IDiaiBxN3mGuFw1PvLe9
	yHdTom1vnWRyTpCcD4QPxioUVw0ZRgINbLJyZFoF9/ZdybGhj/X+oJ1R1SGyZ7SWfZStm9
	vCpZieeCJwJ0zYULxCrcURqSIWfvmrVskoY9ZNriKfUbrdvfZiZjSHwKq1Vc2R8GdVHTO5
	aOGy0R2zfIj9zJeNFDvhLRohrk6z0TTkXFYKhJTuM5j9L16zBd4Y0FaR7D2kjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766073632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWdSiplMDGwv3wXAq7CGyCUnNkEGK03e3coBLLf46WM=;
	b=H9QGndc8IXJfPIchlBQphpR7irLiRFO3CQv45tm6S7faUvSXPoxq0w4eE2388U4sUAt6QY
	NOI758bDFcjFMRDQ==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH-v3 2/3] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM)
In-Reply-To: <20251217112128.1401896-3-lrizzo@google.com>
References: <20251217112128.1401896-1-lrizzo@google.com>
 <20251217112128.1401896-3-lrizzo@google.com>
Date: Thu, 18 Dec 2025 17:00:29 +0100
Message-ID: <87sed7bx0i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 17 2025 at 11:21, Luigi Rizzo wrote:
> +module_param_named(hardirq_percent, irq_mod_info.hardirq_percent, uint, 0444);
> +MODULE_PARM_DESC(hardirq_percent, "Target max hardirq percentage, 0 off, range 0-100.");
> +
> +module_param_named(target_intr_rate, irq_mod_info.target_intr_rate, uint, 0444);
> +MODULE_PARM_DESC(target_intr_rate, "Target max interrupt rate, 0 off, range 0-50000000.");
> +
> +module_param_named(update_ms, irq_mod_info.update_ms, uint, 0444);
> +MODULE_PARM_DESC(update_ms, "Update interval in milliseconds, range 1-100");

Comment about command line parameters still applies

>  DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
>  
>  DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
> @@ -142,27 +167,72 @@ static int set_mode(struct irq_desc *desc, bool enable)
>  /* Print statistics */
>  static int moderation_show(struct seq_file *p, void *v)
>  {
> +	ulong intr_rate = 0, irq_high = 0, my_irq_high = 0, hardirq_high = 0;
>  	uint delay_us = irq_mod_info.delay_us;
> -	int j;
> +	u64 now = ktime_get_ns();
> +	int j, active_cpus = 0;
>  
> -#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
> -#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"
> +#define HEAD_FMT "%5s  %8s  %8s  %4s  %8s  %11s  %11s  %11s  %11s  %11s  %9s\n"
> +#define BODY_FMT "%5u  %8u  %8u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %9u\n"

Sigh.

>  	seq_printf(p, HEAD_FMT,
> -		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
> +		   "# CPU", "irq/s", "my_irq/s", "cpus", "delay_ns",
> +		   "irq_hi", "my_irq_hi", "hardirq_hi", "timer_set",
> +		   "enqueue", "stray_irq");
>  
>  	for_each_possible_cpu(j) {
>  		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
> +		/* Watch out, epoch start_ns is 64 bits. */
> +		u64 epoch_start_ns = atomic64_read((atomic64_t *)&ms->epoch_start_ns);

No. We are not casting this to an atomic when the write side is non-atomic.

> +		s64 age_ms = min((now - epoch_start_ns) / NSEC_PER_MSEC, (u64)999999);
> +
> +		if (age_ms < 10000) {
> +			/* Average intr_rate over recently active CPUs. */
> +			active_cpus++;
> +			intr_rate += ms->intr_rate;

data_race() - applies to _all_ remote accesses.

> +		} else {
> +			age_ms = -1;
> +			ms->intr_rate = 0;
> +			ms->my_intr_rate = 0;
> +			ms->scaled_cpu_count = 0;
> +			ms->mod_ns = 0;

So this overwrites data which can be concurrently modified on the remote
CPU. How is that even remotely correct?

> @@ -48,9 +66,20 @@ extern struct irq_mod_info irq_mod_info;
>   *
>   * Used once per epoch:
>   * @version:		version fetched from irq_mod_info
> + * @delay_ns:		fetched from irq_mod_info
> + * @epoch_ns:		duration of last epoch
> + * @last_total_intrs:	from irq_mod_info
> + * @last_total_cpus:	from irq_mod_info
> + * @last_irqtime:	from cpustat[CPUTIME_IRQ]
>   *
>   * Statistics
> + * @intr_rate:		smoothed global interrupt rate
> + * @my_intr_rate:	smoothed interrupt rate for this CPU

my_intr_rate is a very descriptive name for the content. NOT.

>   * @timer_set:		how many timer_set calls
> + * @scaled_cpu_count:	smoothed CPU count (scaled)
> + * @irq_high:		how many times global irq above threshold
> + * @my_irq_high:	how many times local irq above threshold

What's this MY about? This is per CPU, right? So local_irq_high or
something like that and then name the other one global_irq_high so it's
entirely clear what this is about. Applies for the above too.

>  DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
>  
> +#define MIN_SCALING_FACTOR 8u
>  extern struct static_key_false irq_moderation_enabled_key;

Your choices of using newlines are truly interesting.

> +++ b/kernel/irq/irq_moderation_hook.c

This needs a new file because?

> +static inline u32 smooth_avg(u32 old, u32 cur, u32 steps)
> +{
> +	const u32 smooth_factor = 64;
> +
> +	steps = min(steps, smooth_factor - 1);
> +	return ((smooth_factor - steps) * old + steps * cur) / smooth_factor;

Still lacks an explanation what this does.

> +/* Measure and assess total and per-CPU interrupt rates. */
> +static inline bool irqrate_high(struct irq_mod_state *ms, u32 target_rate, u32 steps)
> +{
> +	u32 intr_rate, my_intr_rate, delta_intrs, active_cpus, tmp;
> +	bool my_rate_high, global_rate_high;
> +
> +	my_intr_rate = ((u64)ms->intr_count * NSEC_PER_SEC) / ms->epoch_ns;
> +
> +	/* Accumulate global counter and compute global interrupt rate. */
> +	tmp = atomic_add_return(ms->intr_count, &irq_mod_info.total_intrs);
> +	ms->intr_count = 1;
> +	delta_intrs = tmp - ms->last_total_intrs;
> +	ms->last_total_intrs = tmp;
> +	intr_rate = ((u64)delta_intrs * NSEC_PER_SEC) / ms->epoch_ns;
> +
> +	/*
> +	 * Count how many CPUs handled interrupts in the last epoch, needed
> +	 * to determine the per-CPU target (target_rate / active_cpus).
> +	 * Each active CPU increments the global counter approximately every
> +	 * update_ns. Scale the value by (update_ns / ms->epoch_ns) to get the
> +	 * correct value. Also apply rounding and make sure active_cpus > 0.
> +	 */
> +	tmp = atomic_add_return(1, &irq_mod_info.total_cpus);
> +	active_cpus = tmp - ms->last_total_cpus;
> +	ms->last_total_cpus = tmp;
> +	active_cpus = (active_cpus * ms->update_ns + ms->epoch_ns / 2) / ms->epoch_ns;
> +	if (active_cpus < 1)
> +		active_cpus = 1;
> +
> +	/* Compare with global and per-CPU targets. */
> +	global_rate_high = intr_rate > target_rate;
> +
> +	/*
> +	 * Short epochs may lead to underestimate the number of active CPUs.
> +	 * Apply a scaling factor to compensate. This may make the controller
> +	 * a bit more aggressive but does not harm system throughput.
> +	 */
> +	my_rate_high = my_intr_rate * active_cpus * irq_mod_info.scale_cpus > target_rate * 100;
> +
> +	/* Statistics. */
> +	ms->intr_rate = smooth_avg(ms->intr_rate, intr_rate, steps);
> +	ms->my_intr_rate = smooth_avg(ms->my_intr_rate, my_intr_rate, steps);
> +	ms->scaled_cpu_count = smooth_avg(ms->scaled_cpu_count, active_cpus * 256, steps);
> +	ms->my_irq_high += my_rate_high;
> +	ms->irq_high += global_rate_high;
> +
> +	/* Moderate on this CPU only if both global and local rates are high. */
> +	return global_rate_high && my_rate_high;
> +}
> +
> +/* Periodic adjustment, called once per epoch. */
> +void irq_moderation_update_epoch(struct irq_mod_state *ms)
> +{
> +	const u32 hardirq_percent = READ_ONCE(irq_mod_info.hardirq_percent);
> +	const u32 target_rate = READ_ONCE(irq_mod_info.target_intr_rate);
> +	const u32 min_delay_ns = 500;
> +	bool above_target = false;
> +	u32 version;
> +	u32 steps;
> +
> +	/* Fetch updated parameters. */
> +	while ((version = READ_ONCE(irq_mod_info.version)) != ms->version) {
> +		ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
> +		ms->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
> +		ms->delay_ns = ms->mod_ns;
> +		ms->version = version;
> +	}
> +
> +	if (target_rate == 0 && hardirq_percent == 0) {
> +		/* Use fixed moderation delay. */
> +		ms->mod_ns = ms->delay_ns;
> +		ms->intr_rate = 0;
> +		ms->my_intr_rate = 0;
> +		ms->scaled_cpu_count = 0;
> +		return;
> +	}

So this evaluates modifiable parameters in three steps. Why isn't that
all evaluated under the sequence/version mechanics or at least the
hardirq percentage and the target rate reevaluated when there is new data?

Thanks,

        tglx


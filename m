Return-Path: <linux-arch+bounces-14724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEFBC56CAC
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0114E3F3A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967592E6CA8;
	Thu, 13 Nov 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="klNFAP/i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gE4keyiA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779702D7D47;
	Thu, 13 Nov 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028913; cv=none; b=BIbogm2+kLN8M9QGEQI0WsO+VQ+R3wsnwRVv23l/k1h5TJn9FReOAf+2qes6OUc8YLF8mrLUjxouo+QxVrQWC+Bk/V4D/+pgwmMbylOlrZN82ZyfzG9pkKR2ob+ShxueYu5pJN5oDQYJ9GLLLoMIrGAHx92wR5ZA42sVdxdVVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028913; c=relaxed/simple;
	bh=+5Cyxp95Jzqq7U/1RGSpLfUHMzN7zM19XQsbHif2DQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUzzy77cNh77YVBwEAgXVtq1RQnnfvt1cqmUodzq5RF2x1jXL/nUjBWzlJA3TduCiZfpk3O9Di0ZxYAs3bLbO/pCNjI3RYsAqPTtZlUgCKlfv2QM/tsBfrQqT6qbsl9bmyge1BaWfCVCyVFsu8+cmkiGZaH42tsCJ107//v4AXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=klNFAP/i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gE4keyiA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763028906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aEdGT1XMAfbq441cvq035PXE7HfbZaieyKww16X5+ck=;
	b=klNFAP/i1M3GbAQlJ9RLhk3Bm87jG6amN+OHkiIfdJdND/hbqDCaU36uTGSQqG45Di+p3y
	y7ynlfnzFYfVLshIeAn3J0KlWUjy+q2tX6Ef/6WKAQFaI6+9FfR9jvvrgHCdfNOAbooRVy
	1cDsXGD47hpX3jrr3XOtnObdA0N1BNk15f4EFsVjItsbZVCZYxsdowqaJRh6H1cr1Pi5AE
	C+sbon7bERF9QFzx6lVYbGIfulKYFYyMwm+jYDSCC+n3FjcqsdZs6Kb9XuY4XHB2AS2d8j
	7FSQEVDKig6M337GxiKoPAm+/v5Hsa2W5C2NT+akjisJZ54mAwou54wQzMfYUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763028906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aEdGT1XMAfbq441cvq035PXE7HfbZaieyKww16X5+ck=;
	b=gE4keyiAi58fm66tfoA/GF5LMgCAYEG22lFCU/wDtTsGrZ1CKIDvjtAe/VRee3lOGEXvGm
	TBYA+lseNpbMWjBg==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 4/6] genirq: soft_moderation: implement adaptive moderation
In-Reply-To: <20251112192408.3646835-5-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-5-lrizzo@google.com>
Date: Thu, 13 Nov 2025 11:15:05 +0100
Message-ID: <87o6p6ck7q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
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

This explains the what. But it does not provide any rationale for it.

> +/* Adjust the moderation delay, called at most every update_ns */
> +void __irq_moderation_adjust_delay(struct irq_mod_state *ms, u64 delta_time, u64 update_ns)
> +{
> +	/* Fetch configuration */
> +	u32 target_rate = clamp(irq_mod_info.target_irq_rate, 0u, 50000000u);
> +	u32 hardirq_percent = clamp(irq_mod_info.hardirq_percent, 0u, 100u);

This is all racy against a concurrent write, so that requires
READ_ONCE(), no?

> +	bool below_target = true;
> +	/* Compute decay steps based on elapsed time */
> +	u32 steps = delta_time > 10 * update_ns ? 10 : 1 + (delta_time / update_ns);
> +
> +	if (target_rate == 0 && hardirq_percent == 0) {	/* use fixed delay */
> +		ms->mod_ns = ms->delay_ns;
> +		ms->irq_rate = 0;
> +		ms->my_irq_rate = 0;
> +		ms->cpu_count = 0;
> +		return;
> +	}
> +
> +	if (target_rate > 0) {	/* control total and individual CPU rate */
> +		u64 irq_rate, my_irq_rate, tmp, delta_irqs, num_cpus;
> +		bool my_rate_ok, global_rate_ok;
> +
> +		/* Update global number of interrupts */
> +		if (ms->irq_count < 1)	/* make sure it is always > 0 */

And how does it become < 1?

> +			ms->irq_count = 1;
> +		tmp = atomic_long_add_return(ms->irq_count, &irq_mod_info.total_intrs);
> +		delta_irqs = tmp - ms->last_total_irqs;
> +
> +		/* Compute global rate, check if we are ok */
> +		irq_rate = (delta_irqs * NSEC_PER_SEC) / delta_time;
> +		global_rate_ok = irq_rate < target_rate;
> +
> +		ms->last_total_irqs = tmp;

I really had to find this update. Can you please just keep that stuff
together?

        tmp = ...;
        delta = tmp - ms->xxxx;
        ms->xxxx = tmp;

> +		/*
> +		 * num_cpus is the number of CPUs actively handling interrupts
> +		 * in the last interval. CPUs handling less than the fair share
> +		 * target_rate / num_cpus do not need to be throttled.
> +		 */
> +		tmp = atomic_long_add_return(1, &irq_mod_info.total_cpus);
> +		num_cpus = tmp - ms->last_total_cpus;
> +		/* scale proportionally to time, reduce errors if we are idle for too long */
> +		num_cpus = 1 + (num_cpus * update_ns + delta_time / 2) / delta_time;

I still fail to see why this global scale is required and how it is
correct. This can starve out a particular CPU which handles the bulk of
interrupts, no?

> +		/* Short intervals may underestimate sources. Apply a scale factor */
> +		num_cpus = num_cpus * get_scale_cpus() / 100;
> +
> +		/* Compute our rate, check if we are ok */
> +		my_irq_rate = (ms->irq_count * NSEC_PER_SEC) / delta_time;
> +		my_rate_ok = my_irq_rate * num_cpus < target_rate;
> +
> +		ms->irq_count = 1;	/* reset for next cycle */
> +		ms->last_total_cpus = tmp;
> +
> +		/* Use instantaneous rates to react. */
> +		below_target = global_rate_ok || my_rate_ok;
> +
> +		/* Statistics (rates are smoothed averages) */
> +		smooth_avg(&ms->irq_rate, irq_rate, steps);
> +		smooth_avg(&ms->my_irq_rate, my_irq_rate, steps);
> +		smooth_avg(&ms->cpu_count, num_cpus * 256, steps); /* scaled */
> +		ms->my_irq_high += !my_rate_ok;
> +		ms->irq_high += !global_rate_ok;
> +	}
> +
> +	if (hardirq_percent > 0) {		/* control time spent in hardirq */
> +		u64 cur = kcpustat_this_cpu->cpustat[CPUTIME_IRQ];

Depends on CONFIG_IRQ_TIME_ACCOUNTING=y, no?

> +		u64 irqtime = cur - ms->last_irqtime;
> +		bool hardirq_ok = irqtime * 100 < delta_time * hardirq_percent;
> +
> +		below_target &= hardirq_ok;
> +		ms->last_irqtime = cur;
> +		ms->hardirq_high += !hardirq_ok;	/* statistics */
> +	}
> +
> +	/* Controller: move mod_ns up/down if we are above/below target */
> +	if (below_target) {
> +		ms->mod_ns -= ms->mod_ns * steps / (steps + get_decay_factor());
> +		if (ms->mod_ns < 100)
> +			ms->mod_ns = 0;
> +	} else if (ms->mod_ns < 500) {
> +		ms->mod_ns = 500;

Random numbers pulled out of thin air. That's all over the place.

> +	} else {
> +		ms->mod_ns += ms->mod_ns * steps / (steps + get_grow_factor());
> +		if (ms->mod_ns > ms->delay_ns)
> +			ms->mod_ns = ms->delay_ns;	/* cap to delay_ns */
> +	}
> +}

Thanks,

        tglx


Return-Path: <linux-arch+bounces-14837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F38C6506A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F2A93639A7
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145172BF3E2;
	Mon, 17 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MOSlwQXu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzfyB+L2"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF82BEC30;
	Mon, 17 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395320; cv=none; b=VaMSX/44ESs1l//jf4w475bwoxPWAowo6115G3BhPcU4vBgfNa/Bz/nW1muBxzKmRQNcuq7qf7NJlGB1mekP2s2lBtFs3Vi9RuZCoOkMyz8L/u9otaZlizK9ao6luRJZVWXEmP4fc7A420rLfLR0KGQCrQ+we959SqyyjB04qrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395320; c=relaxed/simple;
	bh=/bDhPxqWcSOXNHSzLXjTbMU4HdLO7Kz6FKbNXZulUuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0455vkELi/ut+3zsAFZsfWtP523Z+5BA3YiKkfG4G6Bhus4aoqpB1iFMu0YQpGQq4qm3Bao0iDARaidsbfUjlduiIqojoHFYtVPQAyd6Rlb3MZq1xgP6H/Zr2S9bCtb8Hi1wur7aj96nCUGvGJsr/M9bcxFXnluC2TqS0ykG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MOSlwQXu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzfyB+L2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763395311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOhFoErLEznTRFRgIdJg9ybcZm6YTsthnoRTsVL/SWE=;
	b=MOSlwQXuLgADkZz//yRrqp56EF989/Ad9qRiGz+EMywn6lAKW9rrmSSF2qoLrUMZK7/BRC
	SJfWBEkP5nnn6SV4UPqIYrvF8N65C5Ian9BeCSeDqQxpzbXBm8wD0G6/KD0C5CmUVS4B4m
	HPbsmX++v6zDYc5aXQragpCKNHDLRsLuf+gvnCf/o8beOH7B/OgvOYeRsmwosg6gFz3E5R
	eoVF3ESn7UW+AzGTn2wgHDWvJ966rcRCnMYwFlpvmIiC5P4D/OPohGydS2Cj1lPuVp7VEg
	wpGmwjkyLqscyMgXa4iFQR2I0YhhC2onBq/enQ7NMT+mfwic/C43RAnBatJeRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763395311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOhFoErLEznTRFRgIdJg9ybcZm6YTsthnoRTsVL/SWE=;
	b=jzfyB+L2WZsnSiNg3tDYBpt+ZnsmUcq754/NzpsfuXlsQEtCog2Qoa6rrEfUmPgEJextYW
	++HKZXzZaoG7vjDw==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
In-Reply-To: <20251116182839.939139-3-lrizzo@google.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-3-lrizzo@google.com>
Date: Mon, 17 Nov 2025 17:01:50 +0100
Message-ID: <87wm3o7imp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
> +/* Handlers for /proc/irq/NN/soft_moderation */
> +static int mode_show(struct seq_file *p, void *v)
> +{
> +	struct irq_desc *desc = p->private;
> +
> +	if (!desc)
> +		return -ENOENT;
> +
> +	seq_printf(p, "%s irq %u trigger 0x%x %s %smanaged %slazy handle_irq %pB\n",
> +		   desc->mod.enable ? "on" : "off", desc->irq_data.irq,
> +		   irqd_get_trigger_type(&desc->irq_data),
> +		   irqd_is_level_type(&desc->irq_data) ? "Level" : "Edge",
> +		   irqd_affinity_is_managed(&desc->irq_data) ? "" : "un",
> +		   irq_settings_disable_unlazy(desc) ? "un" : "", desc->handle_irq

Why are you exposing randomly picked information here? The only thing
what's interesting is whether the interrupt is moderated or not. The
interrupt number is redundant information. And all the other internal
details are available in debugfs already.

> +/* Per-CPU state initialization */
> +static void irq_moderation_percpu_init(void *data)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +
> +	INIT_LIST_HEAD(&ms->descs);
> +}
> +
> +static int cpuhp_setup_cb(uint cpu)
> +{
> +	irq_moderation_percpu_init(NULL);
> +	return 0;
> +}
> +
> +static void clamp_parameter(uint *dst, uint val)
> +{
> +	struct param_names *n = param_names;
> +	uint i;
> +
> +	for (i = 0; i < ARRAY_SIZE(param_names); i++, n++) {
> +		if (dst == n->val) {
> +			*dst = clamp(val, n->min, n->max);
> +			return;
> +		}
> +	}
> +}
> +
> +static int __init init_irq_moderation(void)
> +{
> +	uint *cur;
> +
> +	on_each_cpu(irq_moderation_percpu_init, NULL, 1);

That's pointless. Register the hotplug callback without 'nocalls' and
let the hotplug code handle it.

> +	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "moderation:online", cpuhp_setup_cb, NULL);

> +#ifdef CONFIG_IRQ_SOFT_MODERATION
> +
> +/**
> + * struct irq_mod_info - global configuration parameters and state
> + * @total_intrs:	running count updated every update_ms
> + * @total_cpus:		as above, active CPUs in this interval
> + * @procfs_write_ns:	last write to /proc/irq/soft_moderation
> + * @delay_us:		fixed delay, or maximum for adaptive
> + * @target_irq_rate:	target maximum interrupt rate
> + * @hardirq_percent:	target maximum hardirq percentage
> + * @timer_rounds:	how many timer polls once moderation fires
> + * @update_ms:		how often to update delay/rate/fraction
> + * @scale_cpus:		(percent) scale factor to estimate active CPUs
> + * @count_timer_calls:	count timer calls for irq limits
> + * @count_msi_calls:	count calls from posted_msi for irq limits
> + * @decay_factor:	smoothing factor for the control loop, keep at 16
> + * @grow_factor:	smoothing factor for the control loop, keep it at 8
> + */
> +struct irq_mod_info {
> +	/* These fields are written to by all CPUs */
> +	____cacheline_aligned
> +	atomic_long_t total_intrs;
> +	atomic_long_t total_cpus;
> +
> +	/* These are mostly read (frequently), so use a different cacheline */
> +	____cacheline_aligned
> +	u64 procfs_write_ns;
> +	uint delay_us;

I asked you last time already to follow the TIP tree documentation, no?

> +	uint target_irq_rate;
> +	uint hardirq_percent;
> +	uint timer_rounds;
> +	uint update_ms;
> +	uint scale_cpus;
> +	uint count_timer_calls;
> +	uint count_msi_calls;
> +	uint decay_factor;
> +	uint grow_factor;
> +	uint pad[];
> +};

And again you decided to add these fat data structures all in once with
no usage. I told you last time that this is unreviewable and that stuff
should be introduced gradually with the usage.

Feel free to ignore my feedback, but don't be upset if I ignore your
patches then.

Thanks,

        tglx


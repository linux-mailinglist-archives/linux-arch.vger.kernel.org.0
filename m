Return-Path: <linux-arch+bounces-14720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41EC56A01
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38E63B8EF0
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 09:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398752D77FF;
	Thu, 13 Nov 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7hlbER9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z+QmZkkw"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF125F975;
	Thu, 13 Nov 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026190; cv=none; b=q8jyXMYL239h9YZGV9DlT3oEXmPL89QKhYROS4L3RJgb2nbaQ+gsAdFyMaSCKR7+q0m4uxhoYJ75NsTyS58wq/+PcVueG5dOZTlBvIlSWR3xMkG240Z/aemu+MXjCXzlYaj+9G+fjRbIHcEusIJgTPE5LUs0VweB63s83DTE+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026190; c=relaxed/simple;
	bh=vjSvVyJQHvq+USH9DDR6SjJqa6ZV/kS8kVijHw768+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WVOm9SwKb/hPelULhUYgfA6uGJMchNhBLkc04w+zbHxhJQJKmL0fyZG0u5SEyq+9UBpFBzknloN4CcSWsAwLmQm+QXWJ6o4iPTWqcZOX6EEcGePlhgrwdf2pSiVOuqARae/OAvuYVue7j/9vZvXrD4WE96VWNuDUAlH87sRFJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q7hlbER9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z+QmZkkw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763026185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qpw0hRuKINxgKEmW7Bg1AV0OQLtxyPMuS9s5glTwJ8=;
	b=q7hlbER9WZZ2j8yLeMyBFgBHdSUHhB2cf2m1+xydI6+V7Y+ES71/wvdRdpwOJjOVxXM6Qe
	9/WUj15zMxpDkm+MMNwZ3vhnueQzgaZLm5ZcYRAKgSi/tzGtgfwlgxVRIpGeoHqboTWYo7
	Hpf07ACqIEMxDyAsXRkOTLWc8CBFF42c/ZQRHp1ESLLv5PkaSkHS8K6iZI+EqclCg3pbnU
	UDDoskb0CH8fqhTjockzhFMVBWiQJlX2r2EATndz0vavZFecRVqHXtq4TyNjv+4A0a1wQx
	T5NBCNua2czY4cMtCAur0PKm4z1AmHVs1FBtqJ/f1z7xwplVW3F3LCUJqOFCpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763026185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qpw0hRuKINxgKEmW7Bg1AV0OQLtxyPMuS9s5glTwJ8=;
	b=z+QmZkkwijV2Stf4jAqEWSH93wDEgKBEO3Vbp64tJHqNozherZuoTAQmB0BQXWG+/1kyn0
	6JYFLmznqClpe6Aw==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 2/6] genirq: soft_moderation: add base files, procfs hooks
In-Reply-To: <20251112192408.3646835-3-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-3-lrizzo@google.com>
Date: Thu, 13 Nov 2025 10:29:43 +0100
Message-ID: <87346ie0vs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> Add the main core files that implement soft_moderation, limited to static
> moderation, plus related small changes to include/linux/interrupt.h,
> kernel/irq/Makefile, and kernel/irq/proc.c
>
> - include/linux/irq_moderation.h has the two main struct, prototypes
>   and inline hooks
>
> - kernel/irq/irq_moderation.c has the procfs handlers

I can see that from the patch. This has zero useful information. See
Documentation.

> The code is not yet hooked to the interrupt handler, so
> the feature is disabled but we can see the module parameters

Who is 'we'?

> /sys/module/irq_moderation/parameters and read/write the procfs entries
> /proc/irq/soft_moderation and /proc/irq/NN/soft_moderation.
>
> Examples:
> cat /proc/irq/soft_moderation
> echo "delay_us=345" > /proc/irq/soft_moderation
> echo 1 | tee /proc/irq/*/nvme*/../soft_moderation

That's impressive to be able to write into proc/... 

> +/*
> + * Platform wide software interrupt moderation, see
> + * Documentation/core-api/irq/irq-moderation.rst
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/hrtimer.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>

includes are ordered alphabetically.

> +#ifdef CONFIG_IRQ_SOFT_MODERATION
> +
> +/* Global configuration parameters and state */
> +struct irq_mod_info {
> +	/* These fields are written to by all CPUs */
> +	____cacheline_aligned
> +	atomic_long_t total_intrs; /* running count updated every update_ms */
> +	atomic_long_t total_cpus; /* as above, active CPUs in this interval */

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +
> +	/* These are mostly read (frequently), so use a different cacheline */
> +	____cacheline_aligned
> +	u64 procfs_write_ns;	/* last write to /proc/irq/soft_moderation */
> +	uint delay_us;		/* fixed delay, or maximum for adaptive */
> +	uint target_irq_rate;	/* target interrupt rate */
> +	uint hardirq_percent;	/* target maximum hardirq percentage */
> +	uint timer_rounds;	/* how many timer polls once moderation fires */
> +	uint update_ms;		/* how often to update delay/rate/fraction */
> +	uint scale_cpus;	/* (percent) scale factor to estimate active CPUs */
> +	uint count_timer_calls;	/* count timer calls for irq limits */
> +	uint count_msi_calls;	/* count calls from posted_msi for irq limits */
> +	uint decay_factor;	/* keep it at 16 */
> +	uint grow_factor;	/* keep it at 8 */
> +	int pad[] ____cacheline_aligned;
> +};
> +
> +extern struct irq_mod_info irq_mod_info;
> +
> +/* Per-CPU moderation state */
> +struct irq_mod_state {
> +	struct hrtimer timer;	/* moderation timer */
> +	struct list_head descs;	/* moderated irq_desc on this CPU */
> +
> +	/* Counters on last time we updated moderation delay */
> +	u64 last_ns;		/* time of last update */
> +	u64 last_irqtime;	/* from cpustat[CPUTIME_IRQ] */
> +	u64 last_total_irqs;
> +	u64 last_total_cpus;
> +
> +	bool in_posted_msi;	/* don't suppress handle_irq, set in posted_msi handler */
> +	bool kick_posted_msi;	/* kick posted_msi from the timer callback */
> +
> +	u32 cycles;		/* calls since last ktime_get_ns() */
> +	s32 irq_count;		/* irqs in the last cycle, signed as we also decrement */
> +	u32 delay_ns;		/* fetched from irq_mod_info */
> +	u32 mod_ns;		/* recomputed every update_ms */
> +	u32 sleep_ns;		/* accumulated time for actual delay */
> +	s32 rounds_left;	/* how many rounds left for moderation */
> +
> +	/* Statistics */
> +	u32 irq_rate;		/* smoothed global irq rate */;
> +	u32 my_irq_rate;	/* smoothed irq rate for this CPU */;
> +	u32 cpu_count;		/* smoothed CPU count (scaled) */;
> +	u32 src_count;		/* smoothed irq sources count (scaled) */;
> +	u32 irq_high;		/* how many times above each threshold */
> +	u32 my_irq_high;
> +	u32 hardirq_high;
> +	u32 timer_set;		/* counters for various events */
> +	u32 timer_fire;
> +	u32 disable_irq;
> +	u32 enable_irq;
> +	u32 timer_calls;
> +	u32 from_posted_msi;
> +	u32 stray_irq;
> +	int pad[] ____cacheline_aligned;
> +};

Most of this is not used at all at this point. So why introduce massive
data structures with fields w/o usage. That's unreviewable.


> +static inline bool irq_moderation_enabled(void)
> +{
> +	return READ_ONCE(irq_mod_info.delay_us);

This really wants to be a static key.

> +}
> +

> +/* Called on each interrupt for adaptive moderation delay adjustment */
> +static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
> +{
> +	u64 now, delta_time, update_ns;
> +
> +	ms->irq_count++;
> +	if (ms->cycles++ < 16)	/* ktime_get_ns() is expensive, don't do too often */

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#comment-style

> +		return;
> +	ms->cycles = 0;
> +	now = ktime_get_ns();
> +	delta_time = now - ms->last_ns;
> +	update_ns = irq_moderation_get_update_ms() * NSEC_PER_MSEC;
> +
> +	/* Run approximately every update_ns, a little bit early is ok */
> +	if (delta_time < update_ns - 5000)
> +		return;
> +
> +	/* Fetch important state */

That's a truly helpful comment. It tells me exactly nothing.

> +	ms->delay_ns = clamp(irq_mod_info.delay_us, 1u, 500u) * NSEC_PER_USEC;
> +
> +	ms->last_ns = now;
> +	ms->mod_ns = ms->delay_ns;
> +}
> +
> +/* Return true if timer is active or delay is large enough to require moderation */
> +static inline bool irq_moderation_needed(struct irq_mod_state *ms)
> +{
> +	if (!hrtimer_is_queued(&ms->timer)) {
> +		ms->sleep_ns += ms->mod_ns;     /* accumulate sleep time */
> +		if (ms->sleep_ns < 10000)       /* no moderation if too small */

Don't use magic constants. Use proper defines with descriptive names.

> +			return false;
> +	}
> +	return true;
> +}
> +
> +void disable_irq_nosync(unsigned int irq);
> +
> +/*
> + * Use in handle_irq_event() before calling the handler. Decide whether this
> + * desc should be moderated, and in case disable the irq and add the desc to
> + * the list for this CPU.
> + */
> +static inline void irq_moderation_hook(struct irq_desc *desc)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +
> +	if (!irq_moderation_enabled())
> +		return;
> +
> +	if (!READ_ONCE(desc->moderation_mode))
> +		return;
> +
> +	irq_moderation_adjust_delay(ms);
> +
> +	if (!list_empty(&desc->ms_node)) {
> +		/*
> +		 * Very unlikely, stray interrupt while the desc is moderated.
> +		 * Unfortunately we cannot ignore it, just count it.

What means 'cannot ignore it' ?

> +		 */
> +		ms->stray_irq++;
> +		return;
> +	}
> +
> +	if (!irq_moderation_needed(ms))
> +		return;
> +
> +	list_add(&desc->ms_node, &ms->descs); /* Add to list of moderated desc */

That assumes that the interrupt is targeted to a specific CPU. How does
that interact with affinity changes or platforms which use multi-CPU affinities?

> +	/*
> +	 * disable the irq. This will also cause irq_can_handle() return false

Sentences start with an uppercase letter.

> +	 * (through irq_can_handle_actions()), and that will prevent a handler
> +	 * instance to be run again while the descriptor is being moderated.
> +	 *
> +	 * irq_moderation_epilogue() will then start the timer if needed.
> +	 */
> +	ms->disable_irq++;
> +	disable_irq_nosync(desc->irq_data.irq); /* desc must be unlocked */

How does this work with suspend?

> +}
> +
> +/* After the handler, if desc is moderated, make sure the timer is active. */
> +static inline void irq_moderation_epilogue(const struct irq_desc *desc)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);

Lacks a check whether moderation is enabled or not.

> +	if (!list_empty(&desc->ms_node) && !hrtimer_is_queued(&ms->timer))
> +		irq_moderation_start_timer(ms);
> +}
> +
> +#else	/* empty stubs to avoid conditional compilation */
> +
> +static inline void irq_moderation_hook(struct irq_desc *desc) {}
> +static inline void irq_moderation_epilogue(const struct irq_desc *desc) {}
> +
> +#endif /* CONFIG_IRQ_SOFT_MODERATION */
> +
> +#endif /* _LINUX_IRQ_MODERATION_H */
> diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
> index 6ab3a40556670..c06da43d644f2 100644
> --- a/kernel/irq/Makefile
> +++ b/kernel/irq/irq_moderation.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/proc_fs.h>
> +
> +#include <linux/irq_moderation.h>
> +#include <linux/kernel_stat.h>	/* interrupt.h, kcpustat_this_cpu */

These comments are pointless.

> +static_assert(offsetof(struct irq_mod_info, procfs_write_ns) == 64);

What guarantees that a platform has a cacheline size of 64?

> +struct irq_mod_info irq_mod_info ____cacheline_aligned = {
> +	.delay_us = 100,
> +	.update_ms = 1,
> +	.count_timer_calls = true,
> +};
> +
> +module_param_named(delay_us, irq_mod_info.delay_us, uint, 0444);
> +MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 10..500.");
> +
> +module_param_named(timer_rounds, irq_mod_info.timer_rounds, uint, 0444);
> +MODULE_PARM_DESC(timer_rounds, "How many extra timer polls once moderation triggered.");
> +
> +DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
> +
> +static void smooth_avg(u32 *dst, u32 val, u32 steps)
> +{
> +	*dst = ((64 - steps) * *dst + steps * val) / 64;
> +}
> +
> +/* moderation timer handler, called in hardintr context */
> +static enum hrtimer_restart moderation_timer_cb(struct hrtimer *timer)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +	struct irq_desc *desc, *next;
> +	uint srcs = 0;
> +
> +	ms->timer_fire++;
> +	WARN_ONCE(ms->timer_set != ms->timer_fire,
> +		  "CPU %d timer set %d fire %d (lost events?)\n",
> +		  smp_processor_id(), ms->timer_set, ms->timer_fire);
> +
> +	ms->rounds_left--;
> +
> +	if (ms->rounds_left > 0) {
> +		/* Timer still alive. Just call the handlers */
> +		list_for_each_entry_safe(desc, next, &ms->descs, ms_node) {
> +			ms->irq_count += irq_mod_info.count_timer_calls;
> +			ms->timer_calls++;
> +			handle_irq_event_percpu(desc);

That lacks setting the INPROGRESS flag.

> +		}
> +		ms->timer_set++;
> +		hrtimer_forward_now(&ms->timer, ms->sleep_ns);
> +		return HRTIMER_RESTART;
> +	}
> +
> +	/* Last round, remove from list and enable_irq() */
> +	list_for_each_entry_safe(desc, next, &ms->descs, ms_node) {
> +		list_del(&desc->ms_node);
> +		INIT_LIST_HEAD(&desc->ms_node);
> +		srcs++;
> +		ms->enable_irq++;
> +		enable_irq(desc->irq_data.irq);	/* ok if the sync_lock/unlock are NULL */
> +	}
> +	smooth_avg(&ms->src_count, srcs * 256, 1);
> +
> +	ms->sleep_ns = 0;	/* prepare to accumulate next moderation delay */
> +
> +	WARN_ONCE(ms->disable_irq != ms->enable_irq,
> +		  "CPU %d irq disable %d enable %d (%s)\n",
> +		  smp_processor_id(), ms->disable_irq, ms->enable_irq,
> +		     "bookkeeping error, some irq qill be stuck");
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/* Initialize moderation state in desc_set_defaults() */
> +void irq_moderation_init_fields(struct irq_desc *desc)
> +{
> +	INIT_LIST_HEAD(&desc->ms_node);
> +	desc->moderation_mode = 0;
> +}
> +
> +/* Per-CPU state initialization */
> +void irq_moderation_percpu_init(void)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +
> +	hrtimer_setup(&ms->timer, moderation_timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
> +	INIT_LIST_HEAD(&ms->descs);
> +}

Where is this called?

> +static void set_moderation_mode(struct irq_desc *desc, bool mode)
> +{
> +	if (desc) {

Why would desc be NULL?

> +		struct irq_chip *chip = desc->irq_data.chip;
> +
> +		/* Make sure this is msi and we can run enable_irq from irq context */
> +		mode &= desc->handle_irq == handle_edge_irq && chip && chip->irq_bus_lock == NULL &&
> +				chip->irq_bus_sync_unlock == NULL;
> +		if (mode != desc->moderation_mode)
> +			desc->moderation_mode = mode;
> +	}
> +}
> +
> +#pragma clang diagnostic error "-Wformat"

What's that for?

> +/* Print statistics */
> +static int moderation_show(struct seq_file *p, void *v)
> +{
> +	ulong irq_rate = 0, irq_high = 0, my_irq_high = 0, hardirq_high = 0;
> +	uint delay_us = irq_mod_info.delay_us;
> +	struct irq_mod_state *ms;
> +	u64 now = ktime_get_ns();
> +	int j, active_cpus = 0;
> +	struct irq_desc *desc = p->private;
> +
> +	if (desc) {
> +		seq_printf(p, "%s\n", desc->moderation_mode ? "on" : "off");
> +		return 0;
> +	}
> +
> +	seq_puts(p, "# CPU     irq/s  my_irq/s  cpus  srcs  delay_ns       irq_hi     my_irq_hi"
> +		 "   hardirq_hi    timer_set  disable_irq    from_msi  timer_calls  stray_irq\n");
> +	for_each_online_cpu(j) {

Racy agains CPU hotplug.

> +		ms = per_cpu_ptr(&irq_mod_state, j);
> +		if (now - ms->last_ns > NSEC_PER_SEC) {
> +			ms->my_irq_rate = 0;
> +			ms->irq_rate = 0;
> +			ms->cpu_count = 0;
> +		} else {	/* average irq_rate over active CPUs */
> +			active_cpus++;
> +			irq_rate += ms->irq_rate;
> +		}
> +		/* compute totals */
> +		irq_high += ms->irq_high;
> +		my_irq_high += ms->my_irq_high;
> +		hardirq_high += ms->hardirq_high;
> +
> +		seq_printf(p, "%5u  %8u  %8u  %4u  %4u  %8u  %11u  %11u  %11u  %11u  %11u  %11u  %11u  %9u\n",
> +			   j, ms->irq_rate, ms->my_irq_rate, (ms->cpu_count + 128) / 256,
> +			   (ms->src_count + 128) / 256, ms->mod_ns, ms->irq_high, ms->my_irq_high,
> +			   ms->hardirq_high, ms->timer_set, ms->disable_irq,
> +			   ms->from_posted_msi, ms->timer_calls, ms->stray_irq);
> +	}
> +
> +	seq_printf(p, "\n"
> +		   "enabled              %s\n"
> +		   "delay_us             %u\n"
> +		   "timer_rounds         %u\n"
> +		   "count_timer_calls    %s\n",
> +		   str_yes_no(delay_us),
> +		   delay_us,
> +		   irq_mod_info.timer_rounds,
> +		   str_yes_no(irq_mod_info.count_timer_calls));
> +
> +	return 0;
> +}
> +
> +static int moderation_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, moderation_show, pde_data(inode));
> +}
> +
> +/* helpers to set values */
> +struct var_names {
> +	const char *name;
> +	uint *val;
> +	int min;
> +	int max;
> +} var_names[] = {
> +	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
> +	{ "timer_rounds", &irq_mod_info.timer_rounds, 0, 50 },
> +	{ "count_timer_calls", &irq_mod_info.count_timer_calls, 0, 1 },
> +	{}

Don't use zero terminated arrays. Use ARRAY_SIZE() for loop termination.

> +};
> +
> +static int set_parameter(const char *buf, int len)
> +{
> +	struct var_names *n;
> +	int l, val;
> +
> +	for (n = var_names; n->name; n++) {
> +		l = strlen(n->name);
> +		if (len >= l + 2 && !strncmp(buf, n->name, l) && buf[l] == '=')
> +			break;
> +	}
> +	if (!n->name || !n->val)
> +		return -EINVAL;
> +	if (kstrtouint(buf + l + 1, 0, &val))
> +		return -EINVAL;
> +	WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
> +	irq_mod_info.procfs_write_ns = ktime_get_ns();

The point of this time stamp is?

> +	return len;
> +}
> +
> +static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	char val[40];	/* bounded string size */
> +	struct irq_desc *desc = (struct irq_desc *)pde_data(file_inode(f));
> +
> +	if (count == 0 || count + 1 > sizeof(val))
> +		return -EINVAL;
> +	if (copy_from_user(val, buf, count))
> +		return -EFAULT;
> +	val[count] = '\0';
> +	if (val[count - 1] == '\n')
> +		val[count - 1] = '\0';
> +	if (!desc)
> +		return set_parameter(val, count);
> +
> +	if (!strcmp(val, "off") || !strcmp(val, "0"))
> +		set_moderation_mode(desc, false);
> +	else if (!strcmp(val, "on") || !strcmp(val, "1"))
> +		set_moderation_mode(desc, true);

kstrtobool() exists for a reason.

> +	else
> +		return -EINVAL;
> +	return count;	/* consume all */

Code reuse is fine, but this really want's to be seperated for the
control parameters and the per interrupt ones.

> +}
> +
> +static const struct proc_ops proc_ops = {
> +	.proc_open	= moderation_open,
> +	.proc_read	= seq_read,
> +	.proc_lseek	= seq_lseek,
> +	.proc_release	= single_release,
> +	.proc_write	= moderation_write,
> +};
> +
> +void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode)
> +{
> +	if (umode)

Seriously? What's wrong with having irq_moderation_procfs_add/remove() ?

> +		proc_create_data("soft_moderation", umode, desc->dir, &proc_ops, desc);
> +	else
> +		remove_proc_entry("soft_moderation", desc->dir);
> +}
> +
> +static int __init init_irq_moderation(void)
> +{
> +	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, (void *)0);
> +	return 0;
> +}

The selection of code which goes into this patch is pretty random. Some
handling functions and a big pile of procfs muck. Reviewing this series
is a pain.

Thanks,

        tglx




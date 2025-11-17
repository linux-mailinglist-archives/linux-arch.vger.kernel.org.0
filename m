Return-Path: <linux-arch+bounces-14842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091CC65FB6
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 20:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C00BF34379C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58832C932;
	Mon, 17 Nov 2025 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="czayLAWu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYJiYvcg"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388982309B9;
	Mon, 17 Nov 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407854; cv=none; b=ug592YfvhK5IwEjol6VdUyEpItrwTRDszMK4fJJOp/Un6B1DEcCBBPWl7UvK3q8DXil5G/5sQOjln4y9d6WQQOf+Lm26ExsJu/WuQGThCftpKvWlqKAYFM2lJvx1yaQnGMdhlTw7t7EU/B0RRVbb1QfxD4BkkzBKRd/kGhQtxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407854; c=relaxed/simple;
	bh=gk2OQybpddw8dncqyQocbTmgf6PjRsIgs0Wlulh4nlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lu8CQakBMrPrVKyrFgF1YLYApaTLgtGTolbLaLITZecu7MLs6OviJg90rEHwhQQj5IaK0OGlV/8DruxfFT4RMrmlw4ldg7y6sCOnGlxAJgClk9GlcvV7SIZWE711Wj+qYyIuAk/FEBAYMOMMBF4G5mTYhctFqc442SPnrnmFVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=czayLAWu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYJiYvcg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763407849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhC4gOcUSTTAoQ+SvlmfyEtBu/EtdmVj+Ix1NpR83Us=;
	b=czayLAWuv2973ph1goBavcx4K6LZ6Qd1is8hhfos3hU/5Z1+D/5Swzi4cheWVaN/Mqme5O
	BKIIbJwR90Utj/A0tEWi5lRSQNXMluZAb/kfde5rJaJTsTKu7F+hawVdq4pHlraVPLkWrk
	oR1Q55L9zPCNNo9KkoOZ6PTVrK3wOv3SUVBuuxdonXpgyw4tWeJ7+y/u2b318/vsXlUFzp
	XibmSb8FOLJCFna/KVpMeW7jcxhBjePkfX6c+DwO+dr9Zi4zwRjpPpxmntvH2GoA6RJdsc
	L3LvO9o7KpCrT6ZnHajSERYJlv6rDeudwWFrsnrDQ+1+pPE4ZorGIW6jlIKdpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763407849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhC4gOcUSTTAoQ+SvlmfyEtBu/EtdmVj+Ix1NpR83Us=;
	b=dYJiYvcg4Em4HM5kHNCniKfDdhgW8xn4voAP6P5O0/ALw9N7Vlx0xaA+RyVxkuKVODqhk8
	e7OjYuITYwvdUPCQ==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v2 3/8] genirq: soft_moderation: implement fixed moderation
In-Reply-To: <20251116182839.939139-4-lrizzo@google.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-4-lrizzo@google.com>
Date: Mon, 17 Nov 2025 20:30:48 +0100
Message-ID: <87seec78yf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
>  
> +DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
> +EXPORT_SYMBOL(irq_moderation_enabled_key);

Why needs this to be exported? No code outside of the interrupt core has
to know about this and the core code is always built-in.

> +static inline void smooth_avg(u32 *dst, u32 val, u32 steps)
> +{
> +	*dst = ((64 - steps) * *dst + steps * val) / 64;

How is this correct for steps > 64?

Also this is unreadable. Just make this

u32 foo(u32 cur, u32 val, u32 steps)
{
        return .....;
}

and add proper documentation what this function is about and the
expected and valid input parameters.

> +/* Moderation timer handler. */
> +static enum hrtimer_restart timer_cb(struct hrtimer *timer)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +	struct irq_desc *desc, *next;
> +	uint srcs = 0;
> +
> +	ms->timer_fire++;
> +	WARN_ONCE(ms->timer_set != ms->timer_fire,
> +		  "CPU %d timer set %d fire %d (lost events?)\n",
> +		  smp_processor_id(), ms->timer_set, ms->timer_fire);

This whole paranoid debug code is required because this code is so
convoluted that it can't validated for correctness, right?

> +	ms->rounds_left--;
> +
> +	if (ms->rounds_left > 0) {
> +		/* Timer still alive, just call the handlers. */
> +		list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
> +			ms->irq_count += irq_mod_info.count_timer_calls;
> +			ms->timer_calls++;
> +			handle_irq_event_percpu(desc);

I told you before that running the handler w/o the INPROGRESS flag set
is inconsistent state, no?

But what's worse is that this completely ignores the real disabled
state.

interrupt()
        ....
        moderate()      	-> disable depth = 1

...

Driver code
       disable_irq()		-> disable depth = 2

timer()
       handle_irq_event()       -> BUG

And the more I think about it the more I'm convinced that abusing the
disabled state is the wrong thing to do. The interrupt is definitely not
disabled at all and all you create is inconsistent state.

So no. That needs more thought and a different mechanism to reflect that
moderated state.

> +		}
> +		ms->timer_set++;
> +		hrtimer_forward_now(&ms->timer, ms->sleep_ns);
> +		return HRTIMER_RESTART;
> +	}
> +
> +	/* Last round, remove from list and enable_irq(). */
> +	list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
> +		list_del(&desc->mod.ms_node);
> +		INIT_LIST_HEAD(&desc->mod.ms_node);

                list_del_init();

> +		srcs++;
> +		ms->enable_irq++;
> +		enable_irq(desc->irq_data.irq);
> +	}
> +	smooth_avg(&ms->scaled_src_count, srcs * 256, 1);
> +
> +	/* Prepare to accumulate next moderation delay. */
> +	ms->sleep_ns = 0;
> +
> +	WARN_ONCE(ms->disable_irq != ms->enable_irq,
> +		  "CPU %d irq disable %d enable %d (%s)\n",
> +		  smp_processor_id(), ms->disable_irq, ms->enable_irq,
> +		  "bookkeeping error, some irq will be stuck");

Oh well....

> +	return HRTIMER_NORESTART;
> +}

> +static void update_enable_key(void)
> +{
> +	bool newval = irq_mod_info.delay_us != 0;
> +
> +	if (newval != static_key_enabled(&irq_moderation_enabled_key)) {

Pointless exercise. static_branch_enable/disable() handle that already

> +		if (newval)
> +			static_branch_enable(&irq_moderation_enabled_key);
> +		else
> +			static_branch_disable(&irq_moderation_enabled_key);
> +	}
> +}
> +
>  static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
>  {
>  	struct param_names *n = param_names;
> @@ -176,6 +254,8 @@ static ssize_t moderation_write(struct file *f, const char __user *buf, size_t c
>  		if (kstrtouint(cmd + l + 1, 0, &val))
>  			return -EINVAL;
>  		WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
> +		if (n->val == &irq_mod_info.delay_us)
> +			update_enable_key();
>  		/* Record last parameter change, for use in the control loop. */
>  		irq_mod_info.procfs_write_ns = ktime_get_ns();
>  		return count;
> @@ -258,6 +338,7 @@ static void irq_moderation_percpu_init(void *data)
>  {
>  	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
>  
> +	hrtimer_setup(&ms->timer, timer_cb, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
>  	INIT_LIST_HEAD(&ms->descs);

I'm not convinced that you need that online callback at all. None of
this must run on the target CPU. All of that can be done from the boot
CPU in a for_each_possible_cpu() loop. It's a one time initialization, no?

>  }
>  
> @@ -293,6 +374,7 @@ static int __init init_irq_moderation(void)
>  
>  	/* Finally, set delay_us to enable moderation if needed. */
>  	clamp_parameter(&irq_mod_info.delay_us, mod_delay_us);
> +	update_enable_key();
>  
>  	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, NULL);
>  	return 0;
> diff --git a/kernel/irq/irq_moderation.h b/kernel/irq/irq_moderation.h
> index ccb8193482b51..d9bc672ffd6f1 100644
> --- a/kernel/irq/irq_moderation.h
> +++ b/kernel/irq/irq_moderation.h
> @@ -136,11 +136,113 @@ struct irq_mod_state {
>  
>  DECLARE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
>  
> +extern struct static_key_false irq_moderation_enabled_key;
> +
> +/* Called on each interrupt for adaptive moderation delay adjustment. */
> +static inline void irq_moderation_adjust_delay(struct irq_mod_state *ms)
> +{
> +	u64 now, delta_time;
> +
> +	ms->irq_count++;
> +	/* ktime_get_ns() is expensive, don't do too often */
> +	if (ms->irq_count & 0xf)

Magic number and what's wrong with using %?

> +		return;
> +	now = ktime_get_ns();
> +	delta_time = now - ms->last_ns;
> +
> +	/* Run approximately every update_ns, a little bit early is ok. */
> +	if (delta_time < ms->update_ns - 5000)

Again. These hardcoded magic numbers all over the place without any
rationale are annoying.

> +		return;
> +
> +	ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
> +	ms->delay_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
> +
> +	ms->mod_ns = ms->delay_ns;

So you need to read time and do a incomprehensible comparison in order
to store the same values over and over? Both values are initialized
during init and cannot be changed afterwards. Oh well...

> +}
> +
> +/* Return true if timer is active or delay is large enough to require moderation */
> +static inline bool irq_moderation_needed(struct irq_mod_state *ms)
> +{
> +	const u32 min_delay_ns = 10000;

Yet another magic number....

> +	if (!hrtimer_is_queued(&ms->timer)) {
> +		/* accumulate sleep time, no moderation if too small */

Sentences still start with an uppercase letter.

> +		ms->sleep_ns += ms->mod_ns;

How is this accumulating sleep time? It's adding the configured delay
value (nanoseconds) to ms->sleep_ns unconditionally on every interrupt
which is handled on a CPU. It has no relation to time at all.

> +		if (ms->sleep_ns < min_delay_ns)
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
> +	if (!static_branch_unlikely(&irq_moderation_enabled_key))
> +		return;
> +
> +	if (!READ_ONCE(desc->mod.enable))
> +		return;
> +
> +	irq_moderation_adjust_delay(ms);
> +
> +	if (!list_empty(&desc->mod.ms_node)) {
> +		/*
> +		 * Very unlikely, stray interrupt while the desc is moderated.

Moderating 'the desc'? The interrupt is moderated, no?

> +		 * We cannot ignore it or we may miss events, but do count it.

This comment still does not make sense. What can't you ignore and how
does counting and returning prevent missing an event?

> +		 */
> +		ms->stray_irq++;
> +		return;
> +	}
> +
> +	if (!irq_moderation_needed(ms))
> +		return;
> +
> +	/* Add to list of moderated desc on this CPU */
> +	list_add(&desc->mod.ms_node, &ms->descs);

Right and if this CPU is hot-unplugged afterwards then this interrupt is
dead forever. If the timer is still armed it is migrated to an online
CPU...

Also what protects the list against a teardown of an interrupt which is
enqueued in that list? Nothing at all, which means there is a UAF
built-in.

> +	/*
> +	 * Disable the irq. This will also cause irq_can_handle() return false

s/irq/interrupt/ Use proper words please.

> +	 * (through irq_can_handle_actions()), and that will prevent a handler
> +	 * instance to be run again while the descriptor is being moderated.
> +	 *
> +	 * irq_moderation_epilogue() will then start the timer if needed.

It's needed unconditionally after adding it to the list and disabling
it. So why can't you do it right here?

> +	 */
> +	ms->disable_irq++;
> +	disable_irq_nosync(desc->irq_data.irq);
> +}
> +
> +static inline void irq_moderation_start_timer(struct irq_mod_state *ms)
> +{
> +	ms->timer_set++;
> +	ms->rounds_left = READ_ONCE(irq_mod_info.timer_rounds) + 1;
> +	hrtimer_start_range_ns(&ms->timer, ns_to_ktime(ms->sleep_ns),
> +			       /*range*/2000, HRTIMER_MODE_REL_PINNED_HARD);

This glued in comment is better than a properly named constant, right?

> +}
> +
> +/* After the handler, if desc is moderated, make sure the timer is active. */
> +static inline void irq_moderation_epilogue(const struct irq_desc *desc)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +

This still lacks a check whether this moderation muck is enabled at
all. And no, the list_empty() check is not the right thing for
that. That's what the static key is for.

But that's moot as there is no real reason for this epilogue to exist in
the first place.

Thanks,

        tglx


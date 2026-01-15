Return-Path: <linux-arch+bounces-15812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EF0D28C5C
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 22:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 541803008CA6
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F3C30DEDC;
	Thu, 15 Jan 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWyzOioL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3717DE36;
	Thu, 15 Jan 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513203; cv=none; b=mHbNzcuHfaNZs/lBX392lDYMi1iPzt6pIylfOi8s4Rd2PbcGKDcNLjYb5cnL2Di2WY7E5Lk1LG1mhe/8jjZ+daKeOy22uYPzXszAOBCqDxOg+3g37DeNy5nFkquzFN9l+VObjEBLT/UwoLSkcv74MognH7skkZFpztRCBr3Cboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513203; c=relaxed/simple;
	bh=H2tqhY/L7fZpMJuvdRAdTm85nX9NbzzYIbijtXyZC4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDkn6Gx8YUX2TWGcC9H5VDi+YyyED6Qz0O2+dPDRgXYOXHAISsxufbz+bfLxB02NKsmkM6CugGpalfBq12gvVAluMaFgGJnum1UwEhFPkyVZ3OFYC4Y0pifuN4R3m4wkOaWzkA6IXKZqOpO5GLksl+sZx3L4HhgU6mod6/jNeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWyzOioL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEA4C116D0;
	Thu, 15 Jan 2026 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513203;
	bh=H2tqhY/L7fZpMJuvdRAdTm85nX9NbzzYIbijtXyZC4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MWyzOioLluZNWSbnVfJYJ0PD7g9nW3nyFffR8SjMzafqanEZcXHZ8l5cRzE2VrSSv
	 cuUummSbRXN50vxYnbt6O7OgOhSca0WC4MGZB8GTZcmY8/mP82tdbEnXRdK7wEFKpA
	 xttPuhGMN/aB6mvy5E/zZ9+OmPtco2BZ1UX/CfBgbB7BrM18Fljx4hCkLqrLaTcKkL
	 wXkFcxLKspne1EYWrOys9yxEwFq4vYZyIzmdKIwqWQ1DQq2nKv+sVUNr9vwaXa3pw5
	 mpiEC8Epdrwt2DMav+PLsHnqMUd1qBX+/rGW3UfJK0akO/suKZWAonEfk5qMCPQg2a
	 yJJkcKFoAI6RQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v4 2/3] genirq: Fixed-delay Global Software Interrupt
 Moderation (GSIM)
In-Reply-To: <20260115155942.482137-3-lrizzo@google.com>
References: <20260115155942.482137-1-lrizzo@google.com>
 <20260115155942.482137-3-lrizzo@google.com>
Date: Thu, 15 Jan 2026 22:39:58 +0100
Message-ID: <87sec6368h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15 2026 at 15:59, Luigi Rizzo wrote:
> Some platforms show reduced I/O performance when the total device
> interrupt rate across the entire platform becomes too high.
>
> Interrupt moderation can be used to rate-limit individual interrupts,
> and as a consequence also the total rate. Not all devices implement
> moderation in hardware, or they may have impractically coarse granularity
> (e.g. NVME specifies 100us).
>
> GSIM implements interrupt moderation in software, allowing control of
> interrupt rates even without hardware support. It als provides a building
> block for more sophisticated, adaptive mechanisms.
>
> Moderation is enabled/disabled per interrupt source with
>
>   echo 1 > /proc/irq/NN/soft_moderation # use 0 to disable
>
> For interrupts with moderation enabled, the delay is fixed, and equal
> for all.  It is configured via procfs (range 0-500, 0 means disabled):
>
>   echo delay_us=3DXX > /proc/irq/soft_moderation

Interesting that you can successfully write into a directory...

> Per CPU statistics on how often moderation is used are available via
>
>   cat /proc/irq/soft_moderation/stats
>
> +/**
> + * struct irq_desc_mod - interrupt moderation information
> + * @ms_node:		per-CPU list of moderated irq_desc

How is that node a per-CPU list?

> + */
> +struct irq_desc_mod {
> +#ifdef CONFIG_IRQ_SW_MODERATION
> +	struct list_head	ms_node;
> +#endif
> +};

> +/* Actually start moderation. */
> +bool irq_moderation_do_start(struct irq_desc *desc, struct irq_mod_state=
 *m)
> +{
> +	lockdep_assert_irqs_disabled();

You rather assert that desc::lock is held, which implies interrupts disable=
d.

> +	if (!hrtimer_is_queued(&m->timer)) {
> +		const u32 min_delay_ns =3D 10000;
> +		const u64 slack_ns =3D 2000;
> +
> +		/* Accumulate sleep time, no moderation if too small. */
> +		m->sleep_ns +=3D m->mod_ns;
> +		if (m->sleep_ns < min_delay_ns)
> +			return false;
> +		/* We need moderation, start the timer. */
> +		m->timer_set++;
> +		hrtimer_start_range_ns(&m->timer, ns_to_ktime(m->sleep_ns),
> +				       slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
> +	}
> +
> +	/*
> +	 * Add to the timer list and __disable_irq() to prevent serving subsequ=
ent

__disable_irq() is an interesting new verb.

> +	 * interrupts.
> +	 */
> +	if (!list_empty(&desc->mod_state.ms_node)) {
> +		/* Very unlikely, stray interrupt while moderated. */
> +		m->stray_irq++;

How does that happen? handle_..._irq() returns early when the moderated
flag is set, no? If at all then this needs a WARN_ON_ONCE() because then
the underlying logic is broken.

> +	} else {
> +		m->enqueue++;
> +		list_add(&desc->mod_state.ms_node, &m->descs);
> +		__disable_irq(desc);
> +	}
> +	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_IRQ_MODERATED);
> +	return true;
> +}
> +
> +/* Initialize moderation state, used in desc_set_defaults() */
> +void irq_moderation_init_fields(struct irq_desc_mod *mod_state)
> +{
> +	INIT_LIST_HEAD(&mod_state->ms_node);
> +}

Why does that have to be a function and not a trivial inline?

> +
> +static int set_mode(struct irq_desc *desc, bool enable)
> +{
> +	struct irq_data *irqd =3D &desc->irq_data;
> +	struct irq_chip *chip =3D irqd->chip;
> +
> +	lockdep_assert_held(&desc->lock);
> +
> +	if (!enable) {
> +		irq_settings_clr_and_set(desc, _IRQ_SW_MODERATION, 0);
> +		return 0;
> +	}
> +
> +	/* Moderation is only supported in specific cases. */
> +	enable &=3D !irqd_is_level_type(irqd);
> +	enable &=3D irqd_is_single_target(irqd);
> +	enable &=3D !chip->irq_bus_lock && !chip->irq_bus_sync_unlock;
> +	enable &=3D chip->irq_mask && chip->irq_unmask;
> +	enable &=3D desc->handle_irq =3D=3D handle_edge_irq || desc->handle_irq=
 =3D=3D handle_fasteoi_irq;
> +	if (!enable)
> +		return -EOPNOTSUPP;
> +
> +	irq_settings_clr_and_set(desc, 0, _IRQ_SW_MODERATION);
> +	return 0;
> +}
> +
> +/* Helpers to set and clamp values from procfs or at init. */
> +struct swmod_param {
> +	const char	*name;
> +	int		(*wr)(struct swmod_param *n, const char __user *s, size_t count);
> +	void		(*rd)(struct seq_file *p);
> +	void		*val;

Why is this a void pointer if all parameters are u32? They better
are because the min/max values are too. But then you would not have to
type cast @val in the read and write functions, which is superior over
proper data types, right?

Aside of that all of this should be unsigned int and not u32 because non
of this is hardware related.

> +	u32		min;
> +	u32		max;
> +};

I'm really not convinced that any of this is actually an improvement
over properly separated write functions.

> +
> +static int swmod_wr_u32(struct swmod_param *n, const char __user *s, siz=
e_t count)
> +{
> +	u32 res;
> +	int ret =3D kstrtouint_from_user(s, count, 0, &res);
> +
> +	if (!ret) {
> +		WRITE_ONCE(*(u32 *)(n->val), clamp(res, n->min, n->max));

This is just wrong. If the value is outside of the valid region, then
this needs to be rejected and not silently clamped.

> +		ret =3D count;
> +	}
> +	return ret;
> +}
> +
> +static void swmod_rd_u32(struct seq_file *p)
> +{
> +	struct swmod_param *n =3D p->private;
> +
> +	seq_printf(p, "%u\n", *(u32 *)(n->val));
> +}
> +
> +static int swmod_wr_delay(struct swmod_param *n, const char __user *s, s=
ize_t count)
> +{
> +	int ret =3D swmod_wr_u32(n, s, count);
> +
> +	if (ret >=3D 0)
> +		update_enable_key();
> +	return ret;
> +}
> +
> +#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
> +#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"
> +
> +#pragma clang diagnostic error "-Wformat"

I told you before that this is bogus:

kernel/irq/irq_moderation.c:217: warning: ignoring =E2=80=98#pragma clang d=
iagnostic=E2=80=99 [-Wunknown-pragmas]
  217 | #pragma clang diagnostic error "-Wformat"

Not everyone uses clang.

> +/* Print statistics */
> +static void rd_stats(struct seq_file *p)
> +{
> +	uint delay_us =3D irq_mod_info.delay_us;
> +	int cpu;
> +
> +	seq_printf(p, HEAD_FMT,
> +		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
> +
> +	for_each_possible_cpu(cpu) {
> +		struct irq_mod_state cur;
> +
> +		/* Copy statistics, will only use some 32bit values, races ok. */
> +		data_race(cur =3D *per_cpu_ptr(&irq_mod_state, cpu));
> +		seq_printf(p, BODY_FMT,
> +			   cpu, cur.mod_ns, cur.timer_set, cur.enqueue, cur.stray_irq);
> +	}
> +
> +	seq_printf(p, "\n"
> +		   "enabled              %s\n"
> +		   "delay_us             %u\n",
> +		   str_yes_no(delay_us > 0),
> +		   delay_us);

Again: Why is this printing anything when it's disabled. There is zero
value for that.

> +}
> +
> +static int moderation_show(struct seq_file *p, void *v)
> +{
> +	struct swmod_param *n =3D p->private;
> +
> +	if (!n || !n->rd)
> +		return -EINVAL;

How can either of these conditions be true?

> +	n->rd(p);
> +	return 0;
> +}
> +
> +static int moderation_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, moderation_show, pde_data(inode));
> +}
> +
> +static struct swmod_param param_names[] =3D {
> +	{ "delay_us", swmod_wr_delay, swmod_rd_u32, &irq_mod_info.delay_us, 0, =
500 },
> +	{ "stats", NULL, rd_stats},

C89 struct initializers are broken. Either use proper C99 initializers
or use a macro which hides them away.

> +};
> +
> +static ssize_t moderation_write(struct file *f, const char __user *buf, =
size_t count, loff_t *ppos)
> +{
> +	struct swmod_param *n =3D (struct swmod_param *)pde_data(file_inode(f));
> +
> +	return n && n->wr ? n->wr(n, buf, count) : -EINVAL;

How is n =3D NULL?

> +}
> +
> +static const struct proc_ops proc_ops =3D {
> +	.proc_open	=3D moderation_open,
> +	.proc_read	=3D seq_read,
> +	.proc_lseek	=3D seq_lseek,
> +	.proc_release	=3D single_release,
> +	.proc_write	=3D moderation_write,
> +};
> +
> +/* Handlers for /proc/irq/NN/soft_moderation */
> +static int mode_show(struct seq_file *p, void *v)
> +{
> +	struct irq_desc *desc =3D p->private;
> +
> +	seq_puts(p, irq_settings_moderation_allowed(desc) ? "on\n" : "off\n");
> +	return 0;
> +}
> +
> +static ssize_t mode_write(struct file *f, const char __user *buf, size_t=
 count, loff_t *ppos)

mode_show() and mode_write() are really as undescriptive as it gets.

> +{
> +	struct irq_desc *desc =3D (struct irq_desc *)pde_data(file_inode(f));
> +	bool enable;
> +	int ret =3D kstrtobool_from_user(buf, count, &enable);
> +
> +	if (!ret) {
> +		guard(raw_spinlock_irqsave)(&desc->lock);

raw_spinlock_irq - there is nothing to save. This is thread context.

> +		ret =3D set_mode(desc, enable);

Why is this set_mode() function 100 lines above instead of being just
next to the usage site? Makes following the code easier, right?

> +	}
> +	return ret ? : count;
> +}


> +/* Used on timer expiration or CPU shutdown. */
> +static void drain_desc_list(struct irq_mod_state *m)
> +{
> +	struct irq_desc *desc, *next;
> +
> +	/* Remove from list and enable interrupts back. */
> +	list_for_each_entry_safe(desc, next, &m->descs, mod_state.ms_node) {
> +		guard(raw_spinlock)(&desc->lock);
> +		list_del_init(&desc->mod_state.ms_node);
> +		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_IRQ_MODERATED);
> +		/* Protect against competing free_irq(). */

It's not competing. It's concurrent. Can you please use precise wording?

> +		if (desc->action)
> +			__enable_irq(desc);
> +	}
> +}
> +
> +static enum hrtimer_restart timer_callback(struct hrtimer *timer)
> +{
> +	struct irq_mod_state *m =3D this_cpu_ptr(&irq_mod_state);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	drain_desc_list(m);
> +	/* Prepare to accumulate next moderation delay. */
> +	m->sleep_ns =3D 0;
> +	return HRTIMER_NORESTART;
> +}
> +
> +/* Hotplug callback for setup. */
> +static int cpu_setup_cb(uint cpu)

unsigned int

> +{
> +	struct irq_mod_state *m =3D this_cpu_ptr(&irq_mod_state);
> +
> +	hrtimer_setup(&m->timer, timer_callback,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
> +	INIT_LIST_HEAD(&m->descs);
> +	m->moderation_allowed =3D true;
> +	return 0;
> +}
> +
> +/*
> + * Hotplug callback for shutdown.
> + * Mark the CPU as offline for moderation, and drain the list of masked
> + * interrupts. Any subsequent interrupt on this CPU will not be
> + * moderated, but they will be on the new target.
> + */
> +static int cpu_remove_cb(uint cpu)

Ditto

> +{
> +	struct irq_mod_state *m =3D this_cpu_ptr(&irq_mod_state);
> +
> +	guard(irqsave)();

Lacks a comment explanaining why this needs to be irqsave. The hotplug
callback does not require that.

> +	m->moderation_allowed =3D false;
> +	drain_desc_list(m);
> +	hrtimer_cancel(&m->timer);
> +	return 0;
> +}
> +
> +static void(mod_pm_prepare_cb)(void *arg)

What are those brackets around the function name for aside of making the
code unreadable?

> +{
> +	cpu_remove_cb(smp_processor_id());
> +}
> +
> +static void(mod_pm_resume_cb)(void *arg)

Ditto.

> +{
> +	cpu_setup_cb(smp_processor_id());
> +}
> +

> +static void __init clamp_parameter(u32 *dst, u32 val)
> +{
> +	struct swmod_param *n =3D param_names;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(param_names); i++, n++) {
> +		if (dst =3D=3D n->val) {
> +			WRITE_ONCE(*dst, clamp(val, n->min, n->max));
> +			return;
> +		}
> +	}
> +}

> +static int __init init_irq_moderation(void)
> +{
> +	struct proc_dir_entry *dir;
> +	struct swmod_param *n;
> +	int i;
> +
> +	/* Clamp all initial values to the allowed range. */
> +	for (uint *cur =3D &irq_mod_info.delay_us; cur < irq_mod_info.params_en=
d; cur++)
> +		clamp_parameter(cur, *cur);

This is required because someone might have put an invalid value into
the struct initializer, right?

> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irq_moderation", cpu_setup_cb, =
cpu_remove_cb);

Can fail....

> +	register_pm_notifier(&mod_nb);

Ditto.

> +	update_enable_key();

This is required to make sure it's disabled as it might have enabled
itself magically?

> +	dir =3D proc_mkdir("irq/soft_moderation", NULL);
> +	if (!dir)
> +		return 0;
> +	for (i =3D 0, n =3D param_names; i < ARRAY_SIZE(param_names); i++, n++)
> +		proc_create_data(n->name, n->wr ? 0644 : 0444, dir, &proc_ops, n);

Can fail too.

> +	return 0;
> +}
> +

Pointless new line.

> +device_initcall(init_irq_moderation);

> +/**
> + * struct irq_mod_info - global configuration parameters and state
> + * @delay_us:		maximum delay
> + * @update_ms:		how often to update delay (epoch duration)
> + */
> +struct irq_mod_info {
> +	u32		delay_us;
> +	u32		update_ms;
> +	u32		params_end[];

What is this params_end[] for? A made up substitute for ARRAY_SIZE()?

> +};
> +
> +extern struct irq_mod_info irq_mod_info;

> +static inline void check_epoch(struct irq_mod_state *m)
> +{
> +	const u64 now =3D ktime_get_ns(), epoch_ns =3D now - atomic64_read(&m->=
epoch_start_ns);
> +	const u32 slack_ns =3D 5000;
> +
> +	/* Run approximately every update_ns, a little bit early is ok. */
> +	if (epoch_ns < m->update_ns - slack_ns)
> +		return;
> +	/* Fetch updated parameters. */
> +	m->update_ns =3D READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
> +	m->mod_ns =3D READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
> +}

TBH, this is the most convoluted way to handle global parameters which I
have seen in a long time.

First you need the intr_count & 0xF check, then you read time and
subtract the start and have another comparison to avoid reading and
multiplying the global parameters on every invocation.

Just to make it more interresting:

     epoch_start_ns is never set, so this time based rate limit does not
     work at all.

I don't care whether you "fix" this in the next patch or not. Patches
have to be self contained, functional and comprehensible on their own.

That's just completely bonkers. These variables are updated by user
space every now and then, if at all.

So either you read directly from the global struct (you need obviously
nano seconds converted struct members for that) or you update the per
CPU instances from the write functions or you use a sequence counter as
everyone else does.

Thanks,

        tglx


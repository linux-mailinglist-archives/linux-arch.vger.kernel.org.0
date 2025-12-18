Return-Path: <linux-arch+bounces-15499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291ACCC8F4
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 16:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B405309DDBA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC53128CD;
	Thu, 18 Dec 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUQSzND/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8dYc5ugp"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3933C527;
	Thu, 18 Dec 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072715; cv=none; b=EhRMr5pbR8UFOL3EtEPZFpzn/WueqESzK70L77avWc2Mov1hB1Ga6xHOOraF81BYw6T/yt8+Sxyu0qQFpibXzWYopk03yYv0mt3TQzGA2DoAB7ykZ1b3KNhpGpBLqMl/Jv/2lW2M2dg1Z0cc22POD6x6IZ3lMdGXSCepXwSRqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072715; c=relaxed/simple;
	bh=KgUEwrbkeS4hLrnI+LNZ9gEiSqxTZPX9pIZ3cIGZuew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OeYjpDwG7NfeuROa2E0QxPUScCtsKdIBH14MyClEsEGatjxZYLEBZKSNnzh/I9+n3xlSxfcjhy2DLU4NbBjiekwwoElsyFKR+QfXg5C+cw8yzd+a/cJ7ZqhoxGWunjxOK0E5PVHJQ2n3gegjWWatgjZiYURjXx97LWbKuQTGMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUQSzND/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8dYc5ugp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766072703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFNo+ddMYnq81IT/X+ELQQrEyznGTHEuryeKLd4L9Ec=;
	b=cUQSzND/cNU2H094HTxCuOdTN2OsZBM6geNQZI3MWGsGW61bduSryHxOgb7e5eZ/yw1t+F
	jyW417USjfVnvpUKcLMcF+H5F/JQnvyFF7bxczq33/oSFZvyafxcS0GEXcU5zx7Bt2GHRH
	ggC+60IOyPpb/kwQini60yRCd//kLvhWIFSaOqI/4WGEluxHc4+MWBjcBkfrW3KPHW152q
	9RRb5pgWZUpgjeR7OnApOWhb+4fhUfMFw3LroW7sjAGcbltP3m7E2zUd7y50cQyQR8kxO7
	zk0hWg0mJ3q7jyL+U1Y0AuCTmkUuWFslX+IMvKzZGfhM5lZK64OTlHlxVGrDZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766072703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFNo+ddMYnq81IT/X+ELQQrEyznGTHEuryeKLd4L9Ec=;
	b=8dYc5ugpl5bz6v9qagZi0ac9EQDsfKaX2jfJBRmERcBV7DAZgAFhYQlvt7vcRD5Y5V6sTk
	PPUn0YfqFLfnHRAA==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH-v3 1/3] genirq: Fixed Global Software Interrupt
 Moderation (GSIM)
In-Reply-To: <20251217112128.1401896-2-lrizzo@google.com>
References: <20251217112128.1401896-1-lrizzo@google.com>
 <20251217112128.1401896-2-lrizzo@google.com>
Date: Thu, 18 Dec 2025 16:37:57 +0100
Message-ID: <87v7i3by22.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 17 2025 at 11:21, Luigi Rizzo wrote:
>  include/linux/irqdesc.h          |  23 ++
>  kernel/irq/Kconfig               |  12 +
>  kernel/irq/Makefile              |   1 +
>  kernel/irq/chip.c                |  16 +-
>  kernel/irq/irq_moderation.c      | 414 +++++++++++++++++++++++++++++++
>  kernel/irq/irq_moderation.h      |  93 +++++++
>  kernel/irq/irq_moderation_hook.h | 104 ++++++++
>  kernel/irq/irqdesc.c             |   1 +
>  kernel/irq/proc.c                |   3 +

This does too many things at once and is barely reviewable.

> +#ifdef CONFIG_IRQ_SOFT_MODERATION
> +
> +/**
> + * struct irq_desc_mod - interrupt moderation information
> + * @ms_node:		per-CPU list of moderated irq_desc
> + * @enable:		enable moderation on this descriptor
> + */
> +struct irq_desc_mod {
> +	struct list_head	ms_node;
> +	bool			enable;
> +};
> +
> +void irq_moderation_init_fields(struct irq_desc_mod *mod);

Why has this to be in the global header? The function is only used in
the core code.

> +
> +#else
> +
> +struct irq_desc_mod {};
> +static inline void irq_moderation_init_fields(struct irq_desc_mod *mod) {}
> +

Get rid of all these extra new lines. They provide no real value.

> +# Support platform wide software interrupt moderation
> +config IRQ_SOFT_MODERATION
> +	bool "Enable platform wide software interrupt moderation"
> +	depends on PROC_FS=y

  depends on PROC_FS

> @@ -739,6 +740,13 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  
>  	guard(raw_spinlock)(&desc->lock);
>  
> +	if (irq_moderation_skip_moderated(desc)) {
> +		mask_irq(desc);
> +		desc->istate |= IRQS_PENDING;
> +		cond_eoi_irq(chip, &desc->irq_data);
> +		return;
> +	}

This is not how it works. That has to be integrated into the existing
checks so that the non-moderated case does not have extra conditional
branches. Something like this:

static bool irq_can_handle_pm(struct irq_desc *desc)
{
        <SNIP>

	if (!irqd_has_set(irqd, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED | IRQD_IRQ_MODERATED))
		return true;

and then handle the moderated case in that function and return false if
it can't handle it.

>  	cond_unmask_eoi_irq(desc, chip);
>  
> +	if (irq_moderation_hook(desc))
> +		return;

Can you please come up with a decriptive function name? 'hook' says nothing.

> +/* Recommended values. */
> +struct irq_mod_info irq_mod_info ____cacheline_aligned = {
> +	.update_ms		= 5,
> +};
> +
> +module_param_named(delay_us, irq_mod_info.delay_us, uint, 0444);
> +MODULE_PARM_DESC(delay_us, "Max moderation delay us, 0 = moderation off, range 0-500.");

What enforces the 0-500 range?

This also lacks a description in Documentation/admin-guide/kernel-parameters.txt.

But why having command line parameters at all? Moderation needs to be
enabled for the relevant interrupts once the system came up, so changing
those parameters can be done in user space init code.

> +DEFINE_PER_CPU_ALIGNED(struct irq_mod_state, irq_mod_state);
> +
> +DEFINE_STATIC_KEY_FALSE(irq_moderation_enabled_key);
> +
> +/* Initialize moderation state, used in desc_set_defaults() */
> +void irq_moderation_init_fields(struct irq_desc_mod *mod)
> +{
> +	INIT_LIST_HEAD(&mod->ms_node);
> +	mod->enable = false;

When you integrate it into the irq_data state, then this extra boolean
is not required.

> +}
> +
> +static int set_mode(struct irq_desc *desc, bool enable)
> +{
> +	lockdep_assert_held(&desc->lock);

New line please to separate the assert and the code.

> +	if (enable) {

Please handle the !enable case first and spare the indentation below.

> +		struct irq_data *irqd = &desc->irq_data;
> +		struct irq_chip *chip = irqd->chip;
> +
> +		/* Moderation is only supported in specific cases. */
> +		enable &= !irqd_is_level_type(irqd);
> +		enable &= irqd_is_single_target(irqd);
> +		enable &= !chip->irq_bus_lock && !chip->irq_bus_sync_unlock;
> +		enable &= chip->irq_mask && chip->irq_unmask;
> +		enable &= desc->handle_irq == handle_edge_irq ||
> +				desc->handle_irq == handle_fasteoi_irq;
> +		if (!enable)
> +			return -EOPNOTSUPP;
> +	}
> +	desc->mod.enable = enable;
> +	return 0;
> +}
> +
> +#pragma clang diagnostic error "-Wformat"

New line please. This glued together stuff is horrible to read.

> +/* Print statistics */
> +static int moderation_show(struct seq_file *p, void *v)
> +{
> +	uint delay_us = irq_mod_info.delay_us;
> +	int j;
> +
> +#define HEAD_FMT "%5s  %8s  %11s  %11s  %9s\n"
> +#define BODY_FMT "%5u  %8u  %11u  %11u  %9u\n"

Please don't put defines into the function body. That's just breaking
the reading flow.

> +	seq_printf(p, HEAD_FMT,
> +		   "# CPU", "delay_ns", "timer_set", "enqueue", "stray_irq");
> +
> +	for_each_possible_cpu(j) {
> +		struct irq_mod_state *ms = per_cpu_ptr(&irq_mod_state, j);
> +
> +		seq_printf(p, BODY_FMT,
> +			   j, ms->mod_ns, ms->timer_set, ms->enqueue, ms->stray_irq);
> +	}

Why is this printing all the stats unconditionally, i.e. even when it's disabled?

> +	seq_printf(p, "\n"
> +		   "enabled              %s\n"
> +		   "delay_us             %u\n",
> +		   str_yes_no(delay_us > 0),
> +		   delay_us);
> +
> +	return 0;
> +}
> +
> +static int moderation_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, moderation_show, pde_data(inode));
> +}
> +
> +/* Helpers to set and clamp values from procfs or at init. */
> +struct param_names {
> +	const char *name;
> +	uint *val;
> +	uint min;
> +	uint max;

Struct formatting is wrong, but see below.

> +};
> +
> +static struct param_names param_names[] = {
> +	{ "delay_us", &irq_mod_info.delay_us, 0, 500 },
> +	/* Entries with no name cannot be set at runtime. */
> +	{ "", &irq_mod_info.update_ms, 1, 100 },

Why is this a parameter if it can't be set at all? It's initialized to 5
and nowhere modifiable.

> +};
> +
> +static void update_enable_key(void)
> +{
> +	struct static_key_false *key = &irq_moderation_enabled_key;
> +
> +	if (irq_mod_info.delay_us != 0)
> +		static_branch_enable(key);
> +	else
> +		static_branch_disable(key);
> +}
> +
> +static ssize_t moderation_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	uint i, val, copy_len, name_len;
> +	struct param_names *n;
> +	char cmd[40];
> +
> +	copy_len = min(sizeof(cmd) - 1, count);
> +	if (count == 0)
> +		return -EINVAL;
> +	if (copy_from_user(cmd, buf, copy_len))
> +		return -EFAULT;
> +	cmd[copy_len] = '\0';
> +	for (i = 0, n = param_names;  i < ARRAY_SIZE(param_names); i++, n++) {
> +		name_len = strlen(n->name);
> +		if (name_len < 1 || copy_len < name_len + 2 || strncmp(cmd, n->name, name_len) ||
> +		    cmd[name_len] != '=')
> +			continue;
> +		if (kstrtouint(cmd + name_len + 1, 0, &val))
> +			return -EINVAL;
> +		WRITE_ONCE(*(n->val), clamp(val, n->min, n->max));
> +		if (n->val == &irq_mod_info.delay_us)
> +			update_enable_key();
> +		/* Notify parameter update. */
> +		irq_mod_info.version++;
> +		return count;
> +	}
> +	return -EINVAL;

This is truly horrible. What's wrong with having:

     /proc/irq/soft_moderation/stats
     /proc/irq/soft_moderation/$parameter1
     ...
     /proc/irq/soft_moderation/$parameterN

and then use kstrto*_from_user() in the write functions?

To simplify that, you can create DEFINE_PROC_SHOW_STORE_ATTRIBUTE
similar to DEFINE_PROC_SHOW_ATTRIBUTE.

Also what serializes reads vs. writes and writes vs. writes?

> +/* Handlers for /proc/irq/NN/soft_moderation */
> +static int mode_show(struct seq_file *p, void *v)
> +{
> +	struct irq_desc *desc = p->private;
> +
> +	if (!desc)
> +		return -ENOENT;
> +
> +	seq_puts(p, desc->mod.enable ? "on\n" : "off\n");
> +	return 0;
> +}
> +
> +static ssize_t mode_write(struct file *f, const char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct irq_desc *desc = (struct irq_desc *)pde_data(file_inode(f));
> +	char cmd[40];
> +	bool enable;
> +	int ret;
> +
> +	if (!desc)
> +		return -ENOENT;

How can desc be NULL when the file exists?

> +	if (count == 0 || count + 1 > sizeof(cmd))
> +		return -EINVAL;
> +	if (copy_from_user(cmd, buf, count))
> +		return -EFAULT;
> +	cmd[count] = '\0';
> +
> +	ret = kstrtobool(cmd, &enable);

kstrtobool_from_user()

> +	if (!ret) {
> +		guard(raw_spinlock_irqsave)(&desc->lock);

raw_spinlock_irq. There is nothing to save here, interrupts are enabled.

> +		ret = set_mode(desc, enable);
> +	}
> +	return ret ? : count;
> +}

> +/* Used on timer expiration or CPU shutdown. */
> +static void drain_desc_list(struct irq_mod_state *ms)
> +{
> +	struct irq_desc *desc, *next;
> +
> +	/* Remove from list and enable interrupts back. */
> +	list_for_each_entry_safe(desc, next, &ms->descs, mod.ms_node) {
> +		guard(raw_spinlock)(&desc->lock);
> +		list_del_init(&desc->mod.ms_node);
> +		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> +		/* Protect against competing free_irq(). */

s/competing/concurrent/

> +		if (desc->action)
> +			__enable_irq(desc);
> +	}
> +}
> +
> +static enum hrtimer_restart timer_callback(struct hrtimer *timer)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +
> +	drain_desc_list(ms);
> +	/* Prepare to accumulate next moderation delay. */
> +	ms->sleep_ns = 0;
> +	return HRTIMER_NORESTART;
> +}
> +
> +/* Hotplug callback for setup. */
> +static int cpu_setup_cb(uint cpu)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +
> +	if (ms->moderation_on)
> +		return 0;

How can that be enabled at the point when this is invoked?

> +	hrtimer_setup(&ms->timer, timer_callback,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
> +	INIT_LIST_HEAD(&ms->descs);
> +	smp_mb();

Undocumented barrier. Where is the counterpart and what does it protect
against? This is a per CPU state with no SMP relevance, no?

> +	ms->moderation_on = true;
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
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +	unsigned long flags;
> +
> +	local_irq_save(flags);

        guard(irqsave)()

But please double check whether save is required at all.

> +	ms->moderation_on = false;
> +	drain_desc_list(ms);
> +	hrtimer_cancel(&ms->timer);
> +	local_irq_restore(flags);
> +	return 0;
> +}
> +
> +static void(mod_pm_prepare_cb)(void *arg)
> +{
> +	cpu_remove_cb(smp_processor_id());
> +}
> +
> +static void(mod_pm_resume_cb)(void *arg)
> +{
> +	cpu_setup_cb(smp_processor_id());
> +}
> +
> +static int mod_pm_notifier_cb( struct notifier_block *nb, unsigned long event, void *unused)
> +{
> +	switch (event) {
> +	case PM_SUSPEND_PREPARE:
> +		on_each_cpu(mod_pm_prepare_cb, NULL, 1);
> +		break;
> +	case PM_POST_SUSPEND:
> +		on_each_cpu(mod_pm_resume_cb, NULL, 1);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block mod_nb = {
> +	.notifier_call = mod_pm_notifier_cb,
> +	.priority = 100,

struct formatting.

> +};
> +
> +static void clamp_parameter(uint *dst, uint val)
> +{
> +	struct param_names *n = param_names;
> +
> +	for (int i = 0; i < ARRAY_SIZE(param_names); i++, n++) {
> +		if (dst == n->val) {
> +			WRITE_ONCE(*dst, clamp(val, n->min, n->max));
> +			return;
> +		}
> +	}
> +}
> +
> +static int __init init_irq_moderation(void)
> +{
> +	/* Clamp all initial values to the allowed range, update version. */
> +	for (uint *cur = &irq_mod_info.delay_us; cur < irq_mod_info.pad; cur++)

This is just wrong. If one of the parameter sizes is changed, then this
goes south....

Get rid of the module parameter and you can spare all this hackery as
the procfs entries have limit checks.

> +		clamp_parameter(cur, *cur);
> +	irq_mod_info.version++;

What's 'version'? I assume it's a sequence number to detect
updates. Then name it that way.

> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "irq_moderation", cpu_setup_cb, cpu_remove_cb);

That can fail...

> +	register_pm_notifier(&mod_nb);
> +
> +	update_enable_key();
> +
> +	proc_create_data("irq/soft_moderation", 0644, NULL, &proc_ops, NULL);
> +	return 0;
> +}
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_VERSION("1.0");
> +MODULE_AUTHOR("Luigi Rizzo <lrizzo@google.com>");
> +MODULE_DESCRIPTION("Global Software Interrupt Moderation");
> +module_init(init_irq_moderation);

When you remove the module parameters then you can get rid of this whole
module muck and explicitely invoke the moderation init from the irq
procfs init.

> + *
> + * Used once per epoch:
> + * @version:		version fetched from irq_mod_info

This still does not explain what version is about. If you add comments
then please make them useful.

> + * Statistics
> + * @timer_set:		how many timer_set calls
> + */
> +struct irq_mod_state {
> +	/* Used on every interrupt. */
> +	struct hrtimer		timer;
> +	bool			moderation_on;
> +	u32			intr_count;
> +	u32			sleep_ns;
> +	u32			mod_ns;
> +
> +	/* Used less frequently. */
> +	u64			epoch_start_ns;
> +	u32			update_ns;
> +	u32			stray_irq;
> +
> +	/* Used once per epoch per source. */
> +	struct list_head	descs;
> +	u32			enqueue;
> +
> +	/* Used once per epoch. */

Duplicated information. That's already in the kernel doc, no?

> +	u32			version;
> +
> +	/* Statistics */
> +	u32			timer_set;
> +};
> +
> diff --git a/kernel/irq/irq_moderation_hook.h b/kernel/irq/irq_moderation_hook.h
> new file mode 100644
> index 0000000000000..f9ac3005f69f4
> --- /dev/null
> +++ b/kernel/irq/irq_moderation_hook.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> +
> +#ifndef _LINUX_IRQ_MODERATION_HOOK_H
> +#define _LINUX_IRQ_MODERATION_HOOK_H

Why does that need another header file when it includes the other one anyway?

> +/* Interrupt hooks for Global Software Interrupt Moderation, GSIM */
> +
> +#include <linux/hrtimer.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/kernel.h>
> +
> +#include "irq_moderation.h"
> +
> +#ifdef CONFIG_IRQ_SOFT_MODERATION
> +
> +static inline void __maybe_new_epoch(struct irq_mod_state *ms)

__maybe_new_epoch() is really awesome. check_epoch() perhaps?

> +{
> +	const u64 now = ktime_get_ns(), epoch_ns = now - ms->epoch_start_ns;
> +	const u32 slack_ns = 5000;
> +	u32 version;
> +
> +	/* Run approximately every update_ns, a little bit early is ok. */
> +	if (epoch_ns < ms->update_ns - slack_ns)
> +		return;
> +	ms->epoch_start_ns = now;
> +	/* Fetch updated parameters. */
> +        while ((version = READ_ONCE(irq_mod_info.version)) != ms->version) {

Spaces instead of tab

> +		ms->update_ns = READ_ONCE(irq_mod_info.update_ms) * NSEC_PER_MSEC;
> +		ms->mod_ns = READ_ONCE(irq_mod_info.delay_us) * NSEC_PER_USEC;
> +		ms->version = version;
> +        }

So that version thing is an open coded sequence count, right? What's
wrong with using a real sequence count?

> +}
> +
> +static inline bool irq_moderation_needed(struct irq_desc *desc, struct irq_mod_state *ms)
> +{
> +	if (!hrtimer_is_queued(&ms->timer)) {
> +		const u32 min_delay_ns = 10000;
> +		const u64 slack_ns = 2000;
> +
> +		/* Accumulate sleep time, no moderation if too small. */
> +		ms->sleep_ns += ms->mod_ns;
> +		if (ms->sleep_ns < min_delay_ns)
> +			return false;
> +		/* We need moderation, start the timer. */
> +		ms->timer_set++;
> +		hrtimer_start_range_ns(&ms->timer, ns_to_ktime(ms->sleep_ns),
> +				       slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
> +	}
> +
> +	/*
> +	 * Add to the timer list and __disable_irq() to prevent serving subsequent
> +	 * interrupts.
> +	 */
> +	if (!list_empty(&desc->mod.ms_node)) {
> +		/* Very unlikely, stray interrupt while moderated. */
> +		ms->stray_irq++;

Why is this not caught on entry to the handler? If this ends up here
with the node queued, then that's a bug IMO.

> +	} else {
> +		ms->enqueue++;
> +		list_add(&desc->mod.ms_node, &ms->descs);
> +		__disable_irq(desc);
> +	}
> +	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
> +	return true;
> +}
> +
> +/*
> + * Use after running the handler, with lock held. If this source should be
> + * moderated, disable it, add to the timer list for this CPU and return true.
> + */
> +static inline bool irq_moderation_hook(struct irq_desc *desc)
> +{
> +	struct irq_mod_state *ms = this_cpu_ptr(&irq_mod_state);
> +
> +	if (!static_branch_unlikely(&irq_moderation_enabled_key))
> +		return false;
> +	if (!desc->mod.enable)
> +		return false;
> +	if (!ms->moderation_on)
> +		return false;
> +
> +	ms->intr_count++;
> +
> +	/* Is this a new epoch? ktime_get_ns() is expensive, don't check too often. */

This comment is confusing.

> +	if ((ms->intr_count & 0xf) == 0)
> +		__maybe_new_epoch(ms);
> +
> +	return irq_moderation_needed(desc, ms);
> +}
> +
> +/* On entry of desc->irq_handler() tell handler to skip moderated interrupts. */
> +static inline bool irq_moderation_skip_moderated(struct irq_desc *desc)
> +{
> +	return !list_empty(&desc->mod.ms_node);

See above ....

Thanks,

        tglx


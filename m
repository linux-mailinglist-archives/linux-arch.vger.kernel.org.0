Return-Path: <linux-arch+bounces-14845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B8C663DA
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 22:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EA8A4E7B6A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D1F2D0C63;
	Mon, 17 Nov 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kPljtp7B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mV7SaHSJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBB299959;
	Mon, 17 Nov 2025 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414100; cv=none; b=cfMFVlxUKGv77UvUmZ1zwtViA0z+4b16xs6slnJcIDq/yIMVRqWakclQizvK2rU9owSFkWAhkqV0u6zljmr6fg6VxeEVxYehtyR2q5oIQpOf4gYz5xQPf9O8S29mogh2NIx1GFYwQ9ZH0+EfpPR+wteGD3UhcqQYxg5dSaACRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414100; c=relaxed/simple;
	bh=lX8wI6PQ/2D7rcjjkXgwvAXUE5/1D/Qqse9qSYErmr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZKn0WhMExXZaICp0Jc7lEy2P64NVRx1arbGkpi299ERsmClUdn0OmGqVKrg2OgFCJU8okzadSgneAT8/RbogjFbE0B4GYhRPvPLqk3iqkXFu8IcUBAzDWLdyCj68hyt5lSV9fVyhBytAPw6fm0JQ2R/KVnp4odzHmMUtqeRpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kPljtp7B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mV7SaHSJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763414096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqSqZmb/QHBEB1yfgKv8nyzvBFCA2b0ocHfKwS4/9j0=;
	b=kPljtp7Bo/1TLcxh7lHVJxhNwlWRqaos518VL52255LyCeZVmYiprCkhtgcvqNqbBUrVj2
	H1AILC74yhL5o24gA3oNKowivwXO2Ai2y/recFeyg7BrYAoAKvBOmPu0lc1x4uHn+Ito7Z
	BufM4aVpEA0cFtijqkq5TET2AN6z6irnzzJB7PkG1jlLr2aJ70paftSSPB+RbFoO0TN3pC
	RVgyg8gnVVDsiVAvfaH1qBaZ8P2dz2FMrPqkYB/UQKj2reBU5Q9kspypcEkQNOtNNHfiuM
	jbPEzlkTSPOX/2GUySqrjpYgijEcrOBnKPXv3bBOilHMpJ8zOApmDEZGL1uqzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763414096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqSqZmb/QHBEB1yfgKv8nyzvBFCA2b0ocHfKwS4/9j0=;
	b=mV7SaHSJ0MfZtcLdUSR1Uo/Rua+DQ7d/bf/tvrL9YVZlz/7RrNCs6PHGOqJRzachwx++B3
	lDMN0mR6RfdAlhBw==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v2 5/8] x86/irq: soft_moderation: add support for
 posted_msi (intel)
In-Reply-To: <20251116182839.939139-6-lrizzo@google.com>
References: <20251116182839.939139-1-lrizzo@google.com>
 <20251116182839.939139-6-lrizzo@google.com>
Date: Mon, 17 Nov 2025 22:14:56 +0100
Message-ID: <87h5us744v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 16 2025 at 18:28, Luigi Rizzo wrote:
> On recent Intel CPUs, kernels compiled with CONFIG_X86_POSTED_MSI=y,
> and the boot option "intremap=posted_msi", all MSI interrupts
> that hit a CPU issue a single POSTED_MSI interrupt processed by
> sysvec_posted_msi_notification() instead of having separate interrupts.
>
> This change adds soft moderation hooks to the above handler.

'This change' is not any better than 'This patch'.

> Soft moderation on posted_msi does not require per-source enable,
> irq_moderation.delay_us > 0 suffices.
>
> To test it, run a kernel with the above options and enable moderation by
> setting delay_us > 0.  The column "from_msi" in /proc/irq/soft_moderation
> will show a non-zero value.

Impressive. But it would be more impressive and useful to actualy have
an explanation why this is required and what the benefits are.

>  CFLAGS_head32.o := -fno-stack-protector
>  CFLAGS_head64.o := -fno-stack-protector
> -CFLAGS_irq.o := -I $(src)/../include/asm/trace
> +CFLAGS_irq.o := -I $(src)/../include/asm/trace -I $(srctree)/kernel/irq

Not going to happen. Architecture code has no business to tap into
generic core infrastructure.

> --- a/kernel/irq/irq_moderation.c
> +++ b/kernel/irq/irq_moderation.c
> @@ -11,6 +11,13 @@
>  #include "internals.h"
>  #include "irq_moderation.h"

>  
> +#ifdef CONFIG_X86

Architecture specific muck has absolutely no place in generic code.

> +#include <asm/apic.h>
> +#include <asm/irq_remapping.h>
> +#else
> +static inline bool posted_msi_supported(void) { return false; }
> +#endif
> +
>  /*
>   * Platform-wide software interrupt moderation.
>   *
> @@ -32,6 +39,10 @@
>   *   moderation on that CPU/irq. If so, calls disable_irq_nosync() and starts
>   *   an hrtimer with appropriate delay.
>   *
> + * - Intel only: using "intremap=posted_msi", all the above is done in
> + *   sysvec_posted_msi_notification(). In this case all host device interrupts
> + *   are subject to moderation.
> + *
>   * - the timer callback calls enable_irq() for all disabled interrupts on that
>   *   CPU. That in turn will generate interrupts if there are pending events.
>   *
> @@ -230,6 +241,17 @@ static enum hrtimer_restart timer_cb(struct hrtimer *timer)
>  
>  	ms->rounds_left--;
>  
> +#ifdef CONFIG_X86_POSTED_MSI
> +	if (ms->kick_posted_msi) {
> +		if (ms->rounds_left == 0)
> +			ms->kick_posted_msi = false;
> +		/* Next call will be from timer, count it conditionally. */
> +		ms->dont_count = !irq_mod_info.count_timer_calls;

TBH, this is one of the worst hacks I've seen in a long time. It's
admittedly creative, but that's unmaintainable and the worst precedent
to open the flood gates for random architecture hacks in generic core
code.

If you want this to work for that posted MSI muck, then this needs
proper integration of those posted vectors into the interrupt core and a
sane mechanism to do the accounting.

> @@ -476,6 +500,18 @@ static ssize_t mode_write(struct file *f, const char __user *buf, size_t count,
>  	ret = kstrtobool(cmd, &enable);
>  	if (!ret)
>  		ret = set_moderation_mode(desc, enable);
> +	if (ret) {
> +		/* extra helpers for prodkernel */
> +		if (cmd[count - 1] == '\n')
> +			cmd[count - 1] = '\0';
> +		ret = 0;
> +		if (!strcmp(cmd, "managed"))
> +			irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
> +		else if (!strcmp(cmd, "unmanaged"))
> +			irqd_clear(&desc->irq_data, IRQD_AFFINITY_MANAGED);

What the heck? Can you spare me the exposure to random google internal
garbage? My eyes are bleeding already enough.

Thanks,

        tglx


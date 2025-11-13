Return-Path: <linux-arch+bounces-14719-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B7C5640F
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 09:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 696384E5391
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9230C62E;
	Thu, 13 Nov 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SVlXkbb5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0W7E+xt7"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54F27EFEF;
	Thu, 13 Nov 2025 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021884; cv=none; b=H80dVHMYh7ZYhkefU3OX77FbnR3YJSO1bXpK5GRjpKTTWOx/WPM9csmyyDZzG9twdYa8+WtiqD3h/kwtXO5iQW5sJWogCRCCjzOnIwSgWNNUb5EhXzLTOKUra/G2P87i65VaMN4e57kYr60wQyfJPjAeGkvdRoI+BgDqW3elUzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021884; c=relaxed/simple;
	bh=QJL05NASSqmKJM2ZAvuRynf14G6yPqZKrBziwLJTDMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEikUwu0a/woUK09h4QuA+7UCnAgml3ATFxV9zol7eQDq2ETmpgmIxF2FwOndJOO0xHL9ssewDn3lqtj86vcD/gxJ9xSzDMZb9aL6GvYfH38pJqyivzTmpMDMTJszPR9AanVuSPU6EUdzb9vVAmQWFaMKURD7Ebez/WE+1+LzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SVlXkbb5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0W7E+xt7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763021880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p9c+8hT5tm38HSr4+wd1+1TCOohy6SvD8YlE+riwipc=;
	b=SVlXkbb5fGgJGUgIIIEugCE/vHVj02AvZSlFLGXXxomVDISJ7bspACB8NpMIHc+lCJ5Rn7
	NVTrmr8d63EgJ6OVv8XFCGB8/31FJyrTT4N9LkmhS5lJ6I1e/UxWJOWuvIziRFuMUJ4O9C
	lWWqbI7ha8fy31A2FjhimpBKrJIuvkGLZ0aKoW+67Jpca01wcqr26X1KipT2tZPBqybyqJ
	S6+VqAn58bpzrCcExMcUyuJPJE/rRzcuWASigYW1Mt9FtfSq0nXKMj0EjMYbZ9zynOMmGB
	+BcBQjEeAdt5Jnt4sHb8d7tN+bR7zjXiZPl8GGv80TYJe5Fi8KRRa6+nn6PjhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763021880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p9c+8hT5tm38HSr4+wd1+1TCOohy6SvD8YlE+riwipc=;
	b=0W7E+xt73HyzWMaKAGee39shXVvkN8XYmnYZEbpYtRtf4hzwPVN5c1FkWL2l+TQsueUH9p
	MSDdlnejr/2C4GAw==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 1/6] genirq: platform wide interrupt moderation:
 Documentation, Kconfig, irq_desc
In-Reply-To: <20251112192408.3646835-2-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-2-lrizzo@google.com>
Date: Thu, 13 Nov 2025 09:17:59 +0100
Message-ID: <875xbee47c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:
> Platform wide software interrupt moderation ("soft_moderation" in this
> patch series) specifically addresses a limitation of platforms from many

"in this patch series" becomes meaningless when this is actually merged
into git.

> vendors whose I/O performance drops significantly when the total rate of
> MSI-X interrupts is too high (e.g 1-3M intr/s depending on the platform).
>
> Conventional interrupt moderation operates separately on each source,
> hence the configuration should target the worst case. On large servers
> with hundreds of interrupt sources, keeping the total rate bounded would
> require delays of 100-200us; and adaptive moderation would have to reach
> those delays with as little as 10K intr/s per source. These values are
> unacceptable for RPC or transactional workloads.
>
> To address this problem, this code measures efficiently the total and
> per-CPU interrupt rates, so that individual moderation delays can be
> adjusted based on actual global and local load. This way, the system
> controls both global interrupt rates and individual CPU load, and
> tunes delays so they are normally 0 or very small except during actual
> local/global overload.
>
> Configuration is easy and robust. System administrators specify the
> maximum targets (moderation delay; interrupt rate; and fraction of time
> spent in hardirq), and per-CPU control loops adjust actual delays to try
> and keep metrics within the bounds.
>
> There is no need for exact targets, because the system is adaptive; the
> defaults delay_us=100, target_irq_rate=1000000, hardirq_frac=70 intr/s,
> are good almost everywhere.
>
> The system does not rely on any special hardware feature except from
> MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X
>
> Boot defaults are set via module parameters (/sys/module/irq_moderation
> and /sys/module/${DRIVER}) or at runtime via /proc/irq/moderation, which
> is also used to export statistics.  Moderation on individual irq can be
> turned on/off via /proc/irq/NN/moderation .
>
> The system does not rely on any special hardware feature except from
> MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X

You said that 8 lines above already, but I can't see where the PBA
dependency actually is.

> This initial patch adds Documentation, Kconfig option, two fields in

git grep 'This patch' Documentation/process/

> struct irq_desc, and prototypes in include/linux/interrupt.h

Please do not describe trivial implementation details in the change log.

> No functional impact.
>
> Enabling the option will just extend struct irq_desc with two fields.
>
> CONFIG_SOFT_IRQ_MODERATION=y
> ---

Clearly lacks a 'Signed-off-by' as all the other patches do.

The patch submission rules are well documented.

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html

and please also read and follow:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> +#ifdef CONFIG_IRQ_SOFT_MODERATION
> +
> +void irq_moderation_percpu_init(void);
> +void irq_moderation_init_fields(struct irq_desc *desc);
> +/* add/remove /proc/irq/NN/soft_moderation */
> +void irq_moderation_procfs_entry(struct irq_desc *desc, umode_t umode);
> +
> +#else   /* empty stubs to avoid conditional compilation */

The canonical format is:

#else /* CONFIG_IRQ_SOFT_MODERATION */
...
#endif /* !CONFIG_IRQ_SOFT_MODERATION */

But that aside, what's the point of adding these prototypes and stubs
without an implementation?

>  /*
>   * We want to know which function is an entrypoint of a hardirq or a softirq.
>   */
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index fd091c35d5721..4eb05bc456abe 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -112,6 +112,11 @@ struct irq_desc {
>  #endif
>  	struct mutex		request_mutex;
>  	int			parent_irq;
> +#ifdef CONFIG_IRQ_SOFT_MODERATION
> +	/* mode: 0: off, 1: disable_irq_nosync() */
> +	u8			moderation_mode; /* written in procfs, read on irq */
> +	struct list_head	ms_node;	/* per-CPU list of moderated irq_desc */

Don't use tail comments and document the members in the exisiting struct
documentation. It's not that hard to keep something consistent.

Again. What's the point of adding this without usage?

You can also avoid the #ifdeffery by doing:

#ifdef CONFIG_IRQ_SOFT_MODERATION
struct irq_desc_mod {
       ....
       ....
};
#else
struct irq_desc_mod { };
#endif


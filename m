Return-Path: <linux-arch+bounces-14723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4BC56ABB
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2279F350CD4
	for <lists+linux-arch@lfdr.de>; Thu, 13 Nov 2025 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166428CF52;
	Thu, 13 Nov 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoR9LjnG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wIjQOY9+"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490A2D73B4;
	Thu, 13 Nov 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027115; cv=none; b=OL7PauKSS9nizmQfo/Li1quPPOlZ/DA95v6U/n98IKfHC3L4uLzN6BsrhzMjxc/G/1IMrbB+/aHwSOgfMf7kVe7WyUvElZAsYRZBHZv4IVX75Hrfct/lP/3H23cS5r7f4CKYDjE7UiUaL5seD14N5JxzESry/bV7w/CL756gvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027115; c=relaxed/simple;
	bh=G+Ewg+XYj1g/Oyg7Wx0kPV7SZfg9K/qiuHqguKr1K3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gfOFesVNiWPemWDCpdvMzAUo0p1Qsv8IVpyjzZLBIXiHUFKQ6V7j/4BLocNmKJ0CMS37hjr8snJ/Thbvh4qfx3J6+9Mn5zl8ESKIMpuTQN4LP74cV25navTLElgtZz+7NBIDOuVMGjeUtcNa/Lj5TeAAsaIEcIhlFL+ejm1gHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoR9LjnG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wIjQOY9+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763027112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0xcV4AUOpgYuHcm6GYpCuUeJ+XHjCJUJxFzzrTh7J0=;
	b=UoR9LjnGxVWUpSFDhaI4B3qeEK4etirzjLbAk657rQcl374S6zL8kzOGcxvJMS+1oO4ojD
	vPJ8pHmkd95OTCYhiEuUNj+s9E/ezY4ZSk5w50IZu/2CIGVz7RtZocrhCcg3eKjO2KdulF
	3OM46xspoqKWKXassH/bh561DwsnAEFj3ZS00P8/EjRZezZ3hQLBZ/xlCZi8hAK+MJMkJ5
	tLkKQCOMww1bW6ZiWWs6Ap2tk0Dyg5r7Y2AE3DVBHkPD/+wtGE0G8LQ094Xs09fnUzxwvG
	L4W01BHnbhAUzk/WurIi2JaTEVrm8w5cm8FDiG+cmm8mVK7HjutCbr3ZBfFrlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763027112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0xcV4AUOpgYuHcm6GYpCuUeJ+XHjCJUJxFzzrTh7J0=;
	b=wIjQOY9+ig7PUliooeiye8IQmGP2yxTChG7vGi2+kc3z4wf9VZifycW7hOzweM3RdU8u6U
	TItFHCWrAr7hlSDQ==
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH 3/6] genirq: soft_moderation: activate hooks in
 handle_irq_event()
In-Reply-To: <20251112192408.3646835-4-lrizzo@google.com>
References: <20251112192408.3646835-1-lrizzo@google.com>
 <20251112192408.3646835-4-lrizzo@google.com>
Date: Thu, 13 Nov 2025 10:45:11 +0100
Message-ID: <87tsyycllk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 12 2025 at 19:24, Luigi Rizzo wrote:

Forgot to mention it on the earlier patches. The subject line is wrong
in multiple aspects. See documentation.

>  arch/x86/kernel/cpu/common.c | 1 +
>  drivers/irqchip/irq-gic-v3.c | 2 ++

How are those related to the subject? 

>  kernel/irq/handle.c          | 3 +++
>  kernel/irq/irqdesc.c         | 1 +
>  4 files changed, 7 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 02d97834a1d4d..1953419fde6ff 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2440,6 +2440,7 @@ void cpu_init(void)
>  
>  		intel_posted_msi_init();
>  	}
> +	irq_moderation_percpu_init();

Why is this called in architecture specific code? There is absolutely
nothing architecture specific about this. The CPU hotplug infrastructure
can handle this just fine in a generic way.
  
>  #include <asm/irq_regs.h>
> @@ -254,9 +255,11 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
>  	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>  	raw_spin_unlock(&desc->lock);
>  
> +	irq_moderation_hook(desc); /* may disable irq so must run unlocked */

That's just wrong. That can trivially be implemented in a way which
works with the lock held.

>  	ret = handle_irq_event_percpu(desc);
>  	raw_spin_lock(&desc->lock);
> +	irq_moderation_epilogue(desc); /* start moderation timer if needed */
>  	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>  	return ret;
>  }
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index db714d3014b5f..e3efbecf5b937 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
>  	desc->tot_count = 0;
>  	desc->name = NULL;
>  	desc->owner = owner;
> +	irq_moderation_init_fields(desc);

That's clearly part of activation in handle_irq_event() ....

Thanks

        tglx



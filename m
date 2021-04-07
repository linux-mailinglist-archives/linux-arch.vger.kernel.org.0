Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FCB35767C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhDGVJ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 17:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDGVJ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 17:09:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14C3E611CC;
        Wed,  7 Apr 2021 21:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617829788;
        bh=pjqv+FUnyBOEfZSsSEQmFkj/fnKdTUEo7j9HDoo+s/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOmINKk4fSkxAMILQn3PSsS55JbYYRTXE/hsUWCtUGH3f9Vf60kaAJJUDWkgRUc4/
         f4i8dIsywmHSD2Uuz//BJ3qD2SJCB+HBX98kCOPgHkc0RMl+97j+L2lUoxcQ1oFvAi
         8kcbgOuF785HDon0d2KdX56Rig5lS/zj7rm4YzOo48zmTIv+Z5tLTU2Z96jIn0aRuq
         FD0fXNGyQOM+wXWqHzJhBhnAmjBU5WQ/Bk36O8fJzn99NmfEzP8xY+9Eha5NvN1MEJ
         MAE0Z57wx8y/OseKbPPavOzvGwKlnPF6MUhuOZ4GjUuFzyBAfO33RHBwLavCgwBPfZ
         wxYwRZcs1wGYg==
Date:   Wed, 7 Apr 2021 22:09:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/18] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <20210407210940.GC16198@willie-the-truck>
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-16-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402090542.131194-16-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 02, 2021 at 06:05:39PM +0900, Hector Martin wrote:
> This is the root interrupt controller used on Apple ARM SoCs such as the
> M1. This irqchip driver performs multiple functions:
> 
> * Handles both IRQs and FIQs
> 
> * Drives the AIC peripheral itself (which handles IRQs)
> 
> * Dispatches FIQs to downstream hard-wired clients (currently the ARM
>   timer).
> 
> * Implements a virtual IPI multiplexer to funnel multiple Linux IPIs
>   into a single hardware IPI
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/irqchip/Kconfig         |   8 +
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-apple-aic.c | 837 ++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h      |   1 +
>  5 files changed, 849 insertions(+)
>  create mode 100644 drivers/irqchip/irq-apple-aic.c

Couple of stale comment nits:

> +static void aic_ipi_unmask(struct irq_data *d)
> +{
> +	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> +	u32 irq_bit = BIT(irqd_to_hwirq(d));
> +
> +	atomic_or(irq_bit, this_cpu_ptr(&aic_vipi_enable));
> +
> +	/*
> +	 * The atomic_or() above must complete before the atomic_read_acquire() below to avoid
> +	 * racing aic_ipi_send_mask().
> +	 */

(the atomic_read_acquire() is now an atomic_read())

> +	smp_mb__after_atomic();
> +
> +	/*
> +	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
> +	 * No barriers needed here since this is a self-IPI.
> +	 */
> +	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit)
> +		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
> +}
> +
> +static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
> +{
> +	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> +	u32 irq_bit = BIT(irqd_to_hwirq(d));
> +	u32 send = 0;
> +	int cpu;
> +	unsigned long pending;
> +
> +	for_each_cpu(cpu, mask) {
> +		/*
> +		 * This sequence is the mirror of the one in aic_ipi_unmask();
> +		 * see the comment there. Additionally, release semantics
> +		 * ensure that the vIPI flag set is ordered after any shared
> +		 * memory accesses that precede it. This therefore also pairs
> +		 * with the atomic_fetch_andnot in aic_handle_ipi().
> +		 */
> +		pending = atomic_fetch_or_release(irq_bit, per_cpu_ptr(&aic_vipi_flag, cpu));
> +
> +		/*
> +		 * The atomic_fetch_or_release() above must complete before the
> +		 * atomic_read_acquire() below to avoid racing aic_ipi_unmask().
> +		 */

(same here)

> +		smp_mb__after_atomic();
> +
> +		if (!(pending & irq_bit) &&
> +		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit))
> +			send |= AIC_IPI_SEND_CPU(cpu);
> +	}

But with that:

Acked-by: Will Deacon <will@kernel.org>

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8950D32EDB5
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhCEPFe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCEPF0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:05:26 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C647FC061574;
        Fri,  5 Mar 2021 07:05:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so2273475pfu.8;
        Fri, 05 Mar 2021 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBuTidaAi6iwCqMpRkLwLZrGR1e8aOX98e+4hVPySss=;
        b=lcmixUX6YegcsdUJe3+kVvgS2KXWlyVjhgykODPMN7gGrrTc/RhzkOTA/XNJK/2kEo
         Mz+bRk5IRaqnBG3GjYfQNIfanQW/GK+49TQXnoXhVpxoAKYu7aZCeLSKRQ4hppdclxpp
         kL9o6sLLFNzbTI5Dm+vMyPeCtioXY97nVXq3iCfyspxX+u5gHZ+V0JTe127ltY/4QLcm
         5eho94oTYQZwC6pXbn1kPgmIGXZNKKDzjDt/RMm6PFic3oLg3IijVzmZI8GmAqoQHmO9
         HY37IoXcfkle59kc/DHibr7SSTeiNa5/j8HVbX+GA03midoCBXhBZu1NvAhfUREGhmIB
         oCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBuTidaAi6iwCqMpRkLwLZrGR1e8aOX98e+4hVPySss=;
        b=QA5NVLVb+gUf3gPcZtvpysjuFopO1eh6qG4gA+KX47zK3/gs80mRF1ZvmBxpc950RM
         CbBmS6hoyUrQae2x3GA/B0ecd62KDzUmf9xVCZ0Nzf/a7j1PWPU33tTiWPFRAUDrtqfn
         551ltUfBnGm+MGQZcm442L4QblH631HMpqCYzcbVSEUAngLKdlr/a2iReIJhZZPvdMok
         u8U+7GdE5BBDblZ8Y6qhA5vtF7BHL0uzsiVc84X+1KjdNwtqtlNBojsArk0rtXfvcnxP
         euos0aST/sxDsi8ry0pq202PNEQqtSZOwCZzaBSUohV+85fZXmoplwjtIhZtPOLX2Ovx
         7vyw==
X-Gm-Message-State: AOAM532v6f7rjKihpVG9RRSElRCEEfikymBmEkYlcdAfJPuImD9X4nu7
        5yabBm9Yntdv25K++3E6ivCLCqftb/CGxJIIGik=
X-Google-Smtp-Source: ABdhPJxj8+iP5+xaC9ZC+EsDKt8oM6DmSbnNGsU+YI8Ww4DOTpmFYGme8ndS9PqZtW501q/eIxT9iJ9OCL8HO+I+KjE=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr9147237pgf.4.1614956725251;
 Fri, 05 Mar 2021 07:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-17-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-17-marcan@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 17:05:08 +0200
Message-ID: <CAHp75Vco_rcjHJ4THLZ8CJP=yX2fesfAo_tOY8zohfSmTLEVgw@mail.gmail.com>
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 11:41 PM Hector Martin <marcan@marcan.st> wrote:
>
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

...

> + *   - <0 nr flags> - hwirq #nr
> + *   - <1 nr flags> - FIQ #nr
> + *     - nr=0  Physical HV timer
> + *     - nr=1  Virtual HV timer
> + *     - nr=2  Physical guest timer
> + *     - nr=3  Virtual guest timer

> + *

Unneeded blank line.

> + */

...

> +#define pr_fmt(fmt) "%s: " fmt, __func__

This is not needed, really, if you have unique / distinguishable
messages in the first place.
Rather people include module names, which may be useful.

...

> +#define MASK_REG(x)            (4 * ((x) >> 5))
> +#define MASK_BIT(x)            BIT((x) & 0x1f)

GENMASK(4,0)

...

> +/*
> + * Max 31 bits in IPI SEND register (top bit is self).
> + * >=32-core chips will need code changes anyway.
> + */
> +#define AIC_MAX_CPUS           31

I would put it as (32 - 1) to show that the register is actually 32-bit long.

...

> +static atomic_t aic_vipi_flag[AIC_MAX_CPUS];
> +static atomic_t aic_vipi_enable[AIC_MAX_CPUS];

Isn't it easier to handle these when they are full width, i.e. 32
items per the array?

...

> +static int aic_irq_set_affinity(struct irq_data *d,
> +                               const struct cpumask *mask_val, bool force)
> +{
> +       irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +       struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> +       int cpu;
> +
> +       if (hwirq > ic->nr_hw)

>= ?

> +               return -EINVAL;
> +
> +       if (force)
> +               cpu = cpumask_first(mask_val);
> +       else
> +               cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +
> +       aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
> +       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +
> +       return IRQ_SET_MASK_OK;
> +}

...

> +static void aic_fiq_mask(struct irq_data *d)
> +{
> +       /* Only the guest timers have real mask bits, unfortunately. */
> +       switch (d->hwirq) {
> +       case AIC_TMR_GUEST_PHYS:
> +               sysreg_clear_set_s(SYS_APL_VM_TMR_FIQ_ENA_EL1, VM_TMR_FIQ_ENABLE_P, 0);
> +               break;
> +       case AIC_TMR_GUEST_VIRT:
> +               sysreg_clear_set_s(SYS_APL_VM_TMR_FIQ_ENA_EL1, VM_TMR_FIQ_ENABLE_V, 0);
> +               break;

default case? // some compilers may not be happy
Ditto for all similar places in the series.

> +       }
> +}

...

> +#define TIMER_FIRING(x)                                                        \
> +       (((x) & (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK |            \
> +                ARCH_TIMER_CTRL_IT_STAT)) ==                                  \
> +        (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT))

It's a bit hard to read. Perhaps

#define FOO_MASK  (_ENABLE | _STAT)
#define _FIRING ... (FOO_MASK | _MASK == FOO_MASK)

?

...

> +       if ((read_sysreg_s(SYS_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT))
> +                       == (FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {

It's better to have == on the previous line.

...

> +       for_each_set_bit(i, &firing, AIC_NR_SWIPI) {
> +               handle_domain_irq(aic_irqc->ipi_domain, i, regs);
> +       }

No {} needed.

...

> +static int aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
> +{
> +       int base_ipi;

Introducing a temporary variable may help with readability

...  *d = irqc->hw_domain;

> +       irqc->ipi_domain = irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWIPI,
> +                                                   &aic_ipi_domain_ops, irqc);
> +       if (WARN_ON(!irqc->ipi_domain))
> +               return -ENODEV;
> +
> +       irqc->ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
> +       irq_domain_update_bus_token(irqc->ipi_domain, DOMAIN_BUS_IPI);
> +
> +       base_ipi = __irq_domain_alloc_irqs(irqc->ipi_domain, -1, AIC_NR_SWIPI,
> +                                          NUMA_NO_NODE, NULL, false, NULL);
> +
> +       if (WARN_ON(!base_ipi)) {
> +               irq_domain_remove(irqc->ipi_domain);
> +               return -ENODEV;
> +       }
> +
> +       set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
> +
> +       return 0;
> +}

...

> +       return 0;
> +

Extra blank line.

...

> +       irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
> +                                                  irqc->nr_hw + AIC_NR_FIQ,
> +                                                  &aic_irq_domain_ops, irqc);

If you are sure it will be always OF-only, why not to use
irq_domain_add_linear()?

...

> +       for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
> +               aic_ic_write(irqc, AIC_MASK_SET + i * 4, ~0);
> +       for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
> +               aic_ic_write(irqc, AIC_SW_CLR + i * 4, ~0);

~0 is a beast when it suddenly gets into > int size.

I would recommend using either GENMASK() if it's a bit field, or
type_MAX values if it's a plain number.

-- 
With Best Regards,
Andy Shevchenko

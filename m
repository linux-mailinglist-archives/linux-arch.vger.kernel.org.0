Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D234824C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 20:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhCXT6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 15:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238049AbhCXT5u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 15:57:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E610E61A25;
        Wed, 24 Mar 2021 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616615870;
        bh=QiCbZkHWhUmmia+hfx+diW6GwLwnxWujJIW3E4k+dBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp8iXo5yAj8CpflelQk1ZlliNJnw9hIoPaDoO9fkcFudLplk8fo4QJhnGa9hm9t4i
         IjP6GSfUY7H8ufNS2hftkNzgMRdqiHLTNeEwbH8WDHE6IU2X/1N7X3Aa4NjZMRL3/9
         o+ySZcp+4PFf+jH+bMGMd48kOEWyOnhUtfFa7ZHO688yMXnkS43Mye93KOYXUwB42n
         uUNRnScEc7TMkQFvksVPo5b0QjpKMftaFtryoeKOBE/N6giaNVOap8BgWTAM/FZ1kf
         s6A70nCw6TjT4bi3fmWE7sqQzdsDTouwwX2EUFXGAcucKdSxr6HS2AlWizDzOYIYeC
         a3kkqAmCS1aUA==
Date:   Wed, 24 Mar 2021 19:57:42 +0000
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the
 Apple Interrupt Controller
Message-ID: <20210324195742.GA13474@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-17-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-17-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Hector,

Sorry it took me so long to get to this. Some comments below.

On Fri, Mar 05, 2021 at 06:38:51AM +0900, Hector Martin wrote:
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
>  drivers/irqchip/irq-apple-aic.c | 710 ++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h      |   1 +
>  5 files changed, 722 insertions(+)
>  create mode 100644 drivers/irqchip/irq-apple-aic.c

[...]

> + * Implementation notes:
> + *
> + * - This driver creates two IRQ domains, one for HW IRQs and internal FIQs,
> + *   and one for IPIs.
> + * - Since Linux needs more than 2 IPIs, we implement a software IRQ controller
> + *   and funnel all IPIs into one per-CPU IPI (the second "self" IPI is unused).
> + * - FIQ hwirq numbers are assigned after true hwirqs, and are per-cpu.
> + * - DT bindings use 3-cell form (like GIC):
> + *   - <0 nr flags> - hwirq #nr
> + *   - <1 nr flags> - FIQ #nr
> + *     - nr=0  Physical HV timer
> + *     - nr=1  Virtual HV timer
> + *     - nr=2  Physical guest timer
> + *     - nr=3  Virtual guest timer
> + *
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__

General nit: but I suspect many of the prints in here probably want to be
using the *_ratelimited variants.

> +static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
> +{
> +	struct aic_irq_chip *ic = aic_irqc;
> +	u32 event, type, irq;
> +
> +	do {
> +		/*
> +		 * We cannot use a relaxed read here, as DMA needs to be
> +		 * ordered with respect to the IRQ firing.
> +		 */

I think this could be a bit clearer: the readl() doesn't order any DMA
accesses, but instead means that subsequent reads by the CPU are ordered
(which may be from a buffer which was DMA'd to) are ordered after the
read of the MMIO register.

> +		event = readl(ic->base + AIC_EVENT);
> +		type = FIELD_GET(AIC_EVENT_TYPE, event);
> +		irq = FIELD_GET(AIC_EVENT_NUM, event);
> +
> +		if (type == AIC_EVENT_TYPE_HW)
> +			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
> +		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
> +			aic_handle_ipi(regs);
> +		else if (event != 0)
> +			pr_err("Unknown IRQ event %d, %d\n", type, irq);
> +	} while (event);
> +
> +	/*
> +	 * vGIC maintenance interrupts end up here too, so we need to check
> +	 * for them separately. Just report and disable vGIC for now, until
> +	 * we implement this properly.
> +	 */
> +	if ((read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
> +		read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
> +		pr_err("vGIC IRQ fired, disabling.\n");
> +		sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
> +	}

What prevents all these system register accesses being speculated up before
the handler?

> +}
> +
> +static int aic_irq_set_affinity(struct irq_data *d,
> +				const struct cpumask *mask_val, bool force)
> +{
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> +	int cpu;
> +
> +	if (hwirq > ic->nr_hw)
> +		return -EINVAL;
> +
> +	if (force)
> +		cpu = cpumask_first(mask_val);
> +	else
> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +
> +	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
> +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +
> +	return IRQ_SET_MASK_OK;
> +}
> +
> +static int aic_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +	return (type == IRQ_TYPE_LEVEL_HIGH) ? 0 : -EINVAL;
> +}
> +
> +static struct irq_chip aic_chip = {
> +	.name = "AIC",
> +	.irq_mask = aic_irq_mask,
> +	.irq_unmask = aic_irq_unmask,

I know these are driven by the higher-level irq chip code, but I'm a bit
confused as to what provides ordering if, e.g. something ends up calling:

	aic_chip.irq_mask(d);
	...
	aic_chip.irq_unmask(d);

I can't see any ISBs in here and they're writing to two different registers,
so can we end up with the IRQ masked after this sequence?

> +/*
> + * IPI irqchip
> + */
> +
> +static void aic_ipi_mask(struct irq_data *d)
> +{
> +	u32 irq_bit = BIT(irqd_to_hwirq(d));
> +	int this_cpu = smp_processor_id();
> +
> +	/* No specific ordering requirements needed here. */
> +	atomic_andnot(irq_bit, &aic_vipi_enable[this_cpu]);
> +}

Why not use a per-cpu variable here instead of an array of atomics? The pcpu
API has things for atomic updates (e.g. or, and, xchg).

> +static void aic_ipi_unmask(struct irq_data *d)
> +{
> +	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> +	u32 irq_bit = BIT(irqd_to_hwirq(d));
> +	int this_cpu = smp_processor_id();
> +
> +	/*
> +	 * This must complete before the atomic_read_acquire() below to avoid
> +	 * racing aic_ipi_send_mask(). Use a dummy fetch op with release
> +	 * semantics for this. This is arch-specific: ARMv8 B2.3.3 specifies
> +	 * that writes with Release semantics are Barrier-ordered-before reads
> +	 * with Acquire semantics, even though the Linux arch-independent
> +	 * definition of these atomic ops does not.
> +	 */

I think a more idiomatic (and portable) way to do this would be to use
the relaxed accessors, but with smp_mb__after_atomic() between them. Do you
have a good reason for _not_ doing it like that?

> +	(void)atomic_fetch_or_release(irq_bit, &aic_vipi_enable[this_cpu]);
> +
> +	/*
> +	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
> +	 * No barriers needed here since this is a self-IPI.
> +	 */
> +	if (atomic_read_acquire(&aic_vipi_flag[this_cpu]) & irq_bit)

"No barriers needed here" right before an acquire is confusing ;)

> +		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(this_cpu));
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
> +		pending = atomic_fetch_or_release(irq_bit, &aic_vipi_flag[cpu]);

(same here)

> +		if (!(pending & irq_bit) && (atomic_read_acquire(&aic_vipi_enable[cpu]) & irq_bit))
> +			send |= AIC_IPI_SEND_CPU(cpu);
> +	}
> +
> +	/*
> +	 * The flag writes must complete before the physical IPI is issued
> +	 * to another CPU. This is implied by the control dependency on
> +	 * the result of atomic_read_acquire() above, which is itself
> +	 * already ordered after the vIPI flag write.
> +	 */
> +	if (send)
> +		aic_ic_write(ic, AIC_IPI_SEND, send);
> +}
> +
> +static struct irq_chip ipi_chip = {
> +	.name = "AIC-IPI",
> +	.irq_mask = aic_ipi_mask,
> +	.irq_unmask = aic_ipi_unmask,
> +	.ipi_send_mask = aic_ipi_send_mask,
> +};
> +
> +/*
> + * IPI IRQ domain
> + */
> +
> +static void aic_handle_ipi(struct pt_regs *regs)
> +{
> +	int this_cpu = smp_processor_id();
> +	int i;
> +	unsigned long enabled, firing;
> +
> +	/*
> +	 * Ack the IPI. We need to order this after the AIC event read, but
> +	 * that is enforced by normal MMIO ordering guarantees.
> +	 */
> +	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
> +
> +	/*
> +	 * The mask read does not need to be ordered. Only we can change
> +	 * our own mask anyway, so no races are possible here, as long as
> +	 * we are properly in the interrupt handler (which is covered by
> +	 * the barrier that is part of the top-level AIC handler's readl()).
> +	 */
> +	enabled = atomic_read(&aic_vipi_enable[this_cpu]);
> +
> +	/*
> +	 * Clear the IPIs we are about to handle. This pairs with the
> +	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
> +	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
> +	 * before IPI handling code (to avoid races handling vIPIs before they
> +	 * are signaled). The former is taken care of by the release semantics
> +	 * of the write portion, while the latter is taken care of by the
> +	 * acquire semantics of the read portion.
> +	 */
> +	firing = atomic_fetch_andnot(enabled, &aic_vipi_flag[this_cpu]) & enabled;

Does this also need to be ordered after the Ack? For example, if we have
something like:

CPU 0						CPU 1
						<some other IPI>
aic_ipi_send_mask()
						atomic_fetch_andnot(flag)
	atomic_fetch_or_release(flag)
	aic_ic_write(AIC_IPI_SEND)
						aic_ic_write(AIC_IPI_ACK)

sorry if it's a stupid question, I'm just not sure about the cases in which
the hardware will pend things for you.

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3486D34CFAC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhC2MFC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 08:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhC2MEy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 08:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1DFC61930;
        Mon, 29 Mar 2021 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617019493;
        bh=ffh6M924/rxjUnoRUIqHYy/8ZaEz5qQCxPUEUO6zW3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAUE3LeaIbErQXuzlruAMJF7ezMe0XDisUWq9SRIaSenVGYdOqQsPb6DXmeutd+4B
         RVsaWw6RpULtuZ19QtA62lEwIRmRef8XA+nzEAVmQGV5R6l12mzXPWJk5+P1NSaVqR
         mKRaNnam9qez0chbfC+YALm13d+YdOA0BhHKmnYALroYW9QgIxoBrl1Q4JTIVyVhXd
         Ap5K7h3uzHNl6OE/Gc00gMsmpKGiHzvpeis2JfAxK9Ir+R4mV9MTROlEYtAsR0T14Z
         B+CtwNl77R52lEUcBB6Bmve2Chm5UyJrrmORJiXURwA1lfewXKseHYHq1RYTdOGFCe
         M4fkzlyiLhykA==
Date:   Mon, 29 Mar 2021 13:04:42 +0100
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
Message-ID: <20210329120442.GA3636@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-17-marcan@marcan.st>
 <20210324195742.GA13474@willie-the-truck>
 <3564ed98-6ad6-7ddd-01d2-36d7f5af90e0@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3564ed98-6ad6-7ddd-01d2-36d7f5af90e0@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Hector,

On Fri, Mar 26, 2021 at 05:58:15PM +0900, Hector Martin wrote:
> On 25/03/2021 04.57, Will Deacon wrote:
> > > +		event = readl(ic->base + AIC_EVENT);
> > > +		type = FIELD_GET(AIC_EVENT_TYPE, event);
> > > +		irq = FIELD_GET(AIC_EVENT_NUM, event);
> > > +
> > > +		if (type == AIC_EVENT_TYPE_HW)
> > > +			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
> > > +		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
> > > +			aic_handle_ipi(regs);
> > > +		else if (event != 0)
> > > +			pr_err("Unknown IRQ event %d, %d\n", type, irq);
> > > +	} while (event);
> > > +
> > > +	/*
> > > +	 * vGIC maintenance interrupts end up here too, so we need to check
> > > +	 * for them separately. Just report and disable vGIC for now, until
> > > +	 * we implement this properly.
> > > +	 */
> > > +	if ((read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
> > > +		read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
> > > +		pr_err("vGIC IRQ fired, disabling.\n");
> > > +		sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
> > > +	}
> > 
> > What prevents all these system register accesses being speculated up before
> > the handler?
> 
> Nothing, but that's not a problem, is it? If the condition is met, it means
> the vGIC IRQ *is* firing and needs clearing. We don't particularly care if
> this happens before, after, or during the rest of the IRQ handling.
> 
> I changed the message to this, because we actually should never hit this
> path with correctly-working KVM code (it takes care of it before this
> handler runs):
> 
> pr_err_ratelimited("vGIC IRQ fired and not handled by KVM, disabling.\n");

Looks good.

> > > +static struct irq_chip aic_chip = {
> > > +	.name = "AIC",
> > > +	.irq_mask = aic_irq_mask,
> > > +	.irq_unmask = aic_irq_unmask,
> > 
> > I know these are driven by the higher-level irq chip code, but I'm a bit
> > confused as to what provides ordering if, e.g. something ends up calling:
> > 
> > 	aic_chip.irq_mask(d);
> > 	...
> > 	aic_chip.irq_unmask(d);
> > 
> > I can't see any ISBs in here and they're writing to two different registers,
> > so can we end up with the IRQ masked after this sequence?
> 
> Wait, aren't MMIO writes to the same peripheral using device-nGnRnE memory
> modes always ordered with respect to each other? I thought the _relaxed
> versions were only trouble when mixed with memory/DMA buffers, and MMIO for
> any given peripheral always takes effect in program order.

Sorry, this was my mistake -- I seem to have mixed up the MMIO parts with
the system register parts. In this case, aic_irq_[un]mask() are MMIO writes,
so things work out. It's the FIQ mask/unmask code that needs the ISBs.

> > > +static void aic_ipi_mask(struct irq_data *d)
> > > +{
> > > +	u32 irq_bit = BIT(irqd_to_hwirq(d));
> > > +	int this_cpu = smp_processor_id();
> > > +
> > > +	/* No specific ordering requirements needed here. */
> > > +	atomic_andnot(irq_bit, &aic_vipi_enable[this_cpu]);
> > > +}
> > 
> > Why not use a per-cpu variable here instead of an array of atomics? The pcpu
> > API has things for atomic updates (e.g. or, and, xchg).
> 
> One CPU still needs to be able to mutate the flags of another CPU to fire an
> IPI; AIUI the per-cpu ops are *not* atomic for concurrent access by multiple
> CPUs, and in fact there is no API for that, only for "this CPU".

Huh, I really thought we had an API for that, but you're right. Oh well! But
I'd still suggest a per-cpu atomic_t in that case, rather than the array.

> > > +static void aic_ipi_unmask(struct irq_data *d)
> > > +{
> > > +	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
> > > +	u32 irq_bit = BIT(irqd_to_hwirq(d));
> > > +	int this_cpu = smp_processor_id();
> > > +
> > > +	/*
> > > +	 * This must complete before the atomic_read_acquire() below to avoid
> > > +	 * racing aic_ipi_send_mask(). Use a dummy fetch op with release
> > > +	 * semantics for this. This is arch-specific: ARMv8 B2.3.3 specifies
> > > +	 * that writes with Release semantics are Barrier-ordered-before reads
> > > +	 * with Acquire semantics, even though the Linux arch-independent
> > > +	 * definition of these atomic ops does not.
> > > +	 */
> > 
> > I think a more idiomatic (and portable) way to do this would be to use
> > the relaxed accessors, but with smp_mb__after_atomic() between them. Do you
> > have a good reason for _not_ doing it like that?
> 
> Not particularly, other than symmetry with the case below.

I think it would be better not to rely on arm64-specific ordering unless
there's a good reason to.

> > > +		/*
> > > +		 * This sequence is the mirror of the one in aic_ipi_unmask();
> > > +		 * see the comment there. Additionally, release semantics
> > > +		 * ensure that the vIPI flag set is ordered after any shared
> > > +		 * memory accesses that precede it. This therefore also pairs
> > > +		 * with the atomic_fetch_andnot in aic_handle_ipi().
> > > +		 */
> > > +		pending = atomic_fetch_or_release(irq_bit, &aic_vipi_flag[cpu]);
> 
> We do need the return data here, and the release semantics (or another
> barrier before it). But the read below can be made relaxed and a barrier
> used instead, and then the same patern above except with a plain
> atomic_or().

Yes, I think using atomic_fetch_or() followed by atomic_read() would be
best (obviously with the relevant comments!)

> 
> > > +		if (!(pending & irq_bit) && (atomic_read_acquire(&aic_vipi_enable[cpu]) & irq_bit))
> > > +			send |= AIC_IPI_SEND_CPU(cpu);
> > > +	}
> 
> [...]
> 
> > > +	/*
> > > +	 * Clear the IPIs we are about to handle. This pairs with the
> > > +	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
> > > +	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
> > > +	 * before IPI handling code (to avoid races handling vIPIs before they
> > > +	 * are signaled). The former is taken care of by the release semantics
> > > +	 * of the write portion, while the latter is taken care of by the
> > > +	 * acquire semantics of the read portion.
> > > +	 */
> > > +	firing = atomic_fetch_andnot(enabled, &aic_vipi_flag[this_cpu]) & enabled;
> > 
> > Does this also need to be ordered after the Ack? For example, if we have
> > something like:
> > 
> > CPU 0						CPU 1
> > 						<some other IPI>
> > aic_ipi_send_mask()
> > 						atomic_fetch_andnot(flag)
> > 	atomic_fetch_or_release(flag)
> > 	aic_ic_write(AIC_IPI_SEND)
> > 						aic_ic_write(AIC_IPI_ACK)
> > 
> > sorry if it's a stupid question, I'm just not sure about the cases in which
> > the hardware will pend things for you.
> 
> It is ordered, right? As the comment says, it "needs to be ordered after the
> aic_ic_write() above". atomic_fetch_andnot() is *supposed* to be fully
> ordered and that should include against the writel_relaxed() on
> AIC_IPI_FLAG. On ARM it turns out it's not quite fully ordered, but the
> acquire semantics of the read half are sufficient for this case, as they
> guarantee the flags are always read after the FIQ has been ACKed.

Sorry, I missed that the answer to my question was already written in the
comment. However, I'm still a bit unsure about whether the memory barriers
give you what you need here. The barrier in atomic_fetch_andnot() will
order the previous aic_ic_write(AIC_IPI_ACK) for the purposes of other
CPUs reading those locations, but it doesn't say anything about when the
interrupt controller actually changes state after the Ack.

Given that the AIC is mapped Device-nGnRnE, the Arm ARM offers:

  | Additionally, for Device-nGnRnE memory, a read or write of a Location
  | in a Memory-mapped peripheral that exhibits side-effects is complete
  | only when the read or write both:
  |
  | * Can begin to affect the state of the Memory-mapped peripheral.
  | * Can trigger all associated side-effects, whether they affect other
  |   peripheral devices, PEs, or memory.

so without AIC documentation I can't tell whether completion of the Ack write
just begins the process of an Ack (in which case we might need something like
a read-back), or whether the write response back from the AIC only occurs once
the Ack has taken effect. Any ideas?

> Cheeers,

No prooblem :)

Will

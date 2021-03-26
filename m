Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300D134A382
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 09:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZI6p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCZI61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 04:58:27 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDEDC0613AA;
        Fri, 26 Mar 2021 01:58:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DF5F63FA6A;
        Fri, 26 Mar 2021 08:58:17 +0000 (UTC)
To:     Will Deacon <will@kernel.org>
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
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-17-marcan@marcan.st>
 <20210324195742.GA13474@willie-the-truck>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <3564ed98-6ad6-7ddd-01d2-36d7f5af90e0@marcan.st>
Date:   Fri, 26 Mar 2021 17:58:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210324195742.GA13474@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

No worries, I was busy until a couple days ago anyway.

On 25/03/2021 04.57, Will Deacon wrote:
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
> 
> General nit: but I suspect many of the prints in here probably want to be
> using the *_ratelimited variants.

You're right, everything complaining about spurious/unsupported stuff is 
probably safer rate-limited. I also made them all pr_err_ratelimited, 
since nothing should be trying to use that hardware before we get around 
to supporting it in this driver.

>> +static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
>> +{
>> +	struct aic_irq_chip *ic = aic_irqc;
>> +	u32 event, type, irq;
>> +
>> +	do {
>> +		/*
>> +		 * We cannot use a relaxed read here, as DMA needs to be
>> +		 * ordered with respect to the IRQ firing.
>> +		 */
> 
> I think this could be a bit clearer: the readl() doesn't order any DMA
> accesses, but instead means that subsequent reads by the CPU are ordered
> (which may be from a buffer which was DMA'd to) are ordered after the
> read of the MMIO register.

Good point, reworded it for v4:

/*
  * We cannot use a relaxed read here, as reads from DMA buffers
  * need to be ordered after the IRQ fires.
  */

> 
>> +		event = readl(ic->base + AIC_EVENT);
>> +		type = FIELD_GET(AIC_EVENT_TYPE, event);
>> +		irq = FIELD_GET(AIC_EVENT_NUM, event);
>> +
>> +		if (type == AIC_EVENT_TYPE_HW)
>> +			handle_domain_irq(aic_irqc->hw_domain, irq, regs);
>> +		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
>> +			aic_handle_ipi(regs);
>> +		else if (event != 0)
>> +			pr_err("Unknown IRQ event %d, %d\n", type, irq);
>> +	} while (event);
>> +
>> +	/*
>> +	 * vGIC maintenance interrupts end up here too, so we need to check
>> +	 * for them separately. Just report and disable vGIC for now, until
>> +	 * we implement this properly.
>> +	 */
>> +	if ((read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
>> +		read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
>> +		pr_err("vGIC IRQ fired, disabling.\n");
>> +		sysreg_clear_set_s(SYS_ICH_HCR_EL2, ICH_HCR_EN, 0);
>> +	}
> 
> What prevents all these system register accesses being speculated up before
> the handler?

Nothing, but that's not a problem, is it? If the condition is met, it 
means the vGIC IRQ *is* firing and needs clearing. We don't particularly 
care if this happens before, after, or during the rest of the IRQ handling.

I changed the message to this, because we actually should never hit this 
path with correctly-working KVM code (it takes care of it before this 
handler runs):

pr_err_ratelimited("vGIC IRQ fired and not handled by KVM, disabling.\n");

>> +static struct irq_chip aic_chip = {
>> +	.name = "AIC",
>> +	.irq_mask = aic_irq_mask,
>> +	.irq_unmask = aic_irq_unmask,
> 
> I know these are driven by the higher-level irq chip code, but I'm a bit
> confused as to what provides ordering if, e.g. something ends up calling:
> 
> 	aic_chip.irq_mask(d);
> 	...
> 	aic_chip.irq_unmask(d);
> 
> I can't see any ISBs in here and they're writing to two different registers,
> so can we end up with the IRQ masked after this sequence?

Wait, aren't MMIO writes to the same peripheral using device-nGnRnE 
memory modes always ordered with respect to each other? I thought the 
_relaxed versions were only trouble when mixed with memory/DMA buffers, 
and MMIO for any given peripheral always takes effect in program order.

>> +static void aic_ipi_mask(struct irq_data *d)
>> +{
>> +	u32 irq_bit = BIT(irqd_to_hwirq(d));
>> +	int this_cpu = smp_processor_id();
>> +
>> +	/* No specific ordering requirements needed here. */
>> +	atomic_andnot(irq_bit, &aic_vipi_enable[this_cpu]);
>> +}
> 
> Why not use a per-cpu variable here instead of an array of atomics? The pcpu
> API has things for atomic updates (e.g. or, and, xchg).

One CPU still needs to be able to mutate the flags of another CPU to 
fire an IPI; AIUI the per-cpu ops are *not* atomic for concurrent access 
by multiple CPUs, and in fact there is no API for that, only for "this CPU".

>> +static void aic_ipi_unmask(struct irq_data *d)
>> +{
>> +	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
>> +	u32 irq_bit = BIT(irqd_to_hwirq(d));
>> +	int this_cpu = smp_processor_id();
>> +
>> +	/*
>> +	 * This must complete before the atomic_read_acquire() below to avoid
>> +	 * racing aic_ipi_send_mask(). Use a dummy fetch op with release
>> +	 * semantics for this. This is arch-specific: ARMv8 B2.3.3 specifies
>> +	 * that writes with Release semantics are Barrier-ordered-before reads
>> +	 * with Acquire semantics, even though the Linux arch-independent
>> +	 * definition of these atomic ops does not.
>> +	 */
> 
> I think a more idiomatic (and portable) way to do this would be to use
> the relaxed accessors, but with smp_mb__after_atomic() between them. Do you
> have a good reason for _not_ doing it like that?

Not particularly, other than symmetry with the case below.

>> +		/*
>> +		 * This sequence is the mirror of the one in aic_ipi_unmask();
>> +		 * see the comment there. Additionally, release semantics
>> +		 * ensure that the vIPI flag set is ordered after any shared
>> +		 * memory accesses that precede it. This therefore also pairs
>> +		 * with the atomic_fetch_andnot in aic_handle_ipi().
>> +		 */
>> +		pending = atomic_fetch_or_release(irq_bit, &aic_vipi_flag[cpu]);

We do need the return data here, and the release semantics (or another 
barrier before it). But the read below can be made relaxed and a barrier 
used instead, and then the same patern above except with a plain 
atomic_or().

>> +		if (!(pending & irq_bit) && (atomic_read_acquire(&aic_vipi_enable[cpu]) & irq_bit))
>> +			send |= AIC_IPI_SEND_CPU(cpu);
>> +	}

[...]

>> +	/*
>> +	 * Clear the IPIs we are about to handle. This pairs with the
>> +	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
>> +	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
>> +	 * before IPI handling code (to avoid races handling vIPIs before they
>> +	 * are signaled). The former is taken care of by the release semantics
>> +	 * of the write portion, while the latter is taken care of by the
>> +	 * acquire semantics of the read portion.
>> +	 */
>> +	firing = atomic_fetch_andnot(enabled, &aic_vipi_flag[this_cpu]) & enabled;
> 
> Does this also need to be ordered after the Ack? For example, if we have
> something like:
> 
> CPU 0						CPU 1
> 						<some other IPI>
> aic_ipi_send_mask()
> 						atomic_fetch_andnot(flag)
> 	atomic_fetch_or_release(flag)
> 	aic_ic_write(AIC_IPI_SEND)
> 						aic_ic_write(AIC_IPI_ACK)
> 
> sorry if it's a stupid question, I'm just not sure about the cases in which
> the hardware will pend things for you.

It is ordered, right? As the comment says, it "needs to be ordered after 
the aic_ic_write() above". atomic_fetch_andnot() is *supposed* to be 
fully ordered and that should include against the writel_relaxed() on 
AIC_IPI_FLAG. On ARM it turns out it's not quite fully ordered, but the 
acquire semantics of the read half are sufficient for this case, as they 
guarantee the flags are always read after the FIQ has been ACKed.

Cheeers,
-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

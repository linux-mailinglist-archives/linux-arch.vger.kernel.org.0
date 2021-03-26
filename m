Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACC734A2CF
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 08:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZH56 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 03:57:58 -0400
Received: from marcansoft.com ([212.63.210.85]:41058 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhCZH5k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 03:57:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 40EB041982;
        Fri, 26 Mar 2021 07:57:31 +0000 (UTC)
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
 <20210304213902.83903-17-marcan@marcan.st> <874khlzsa3.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7a7363cd-01e9-645c-e9b8-a81005210253@marcan.st>
Date:   Fri, 26 Mar 2021 16:57:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <874khlzsa3.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/03/2021 22.31, Marc Zyngier wrote:
>> +	if ((read_sysreg_s(SYS_ICH_HCR_EL2) & ICH_HCR_EN) &&
>> +		read_sysreg_s(SYS_ICH_MISR_EL2) != 0) {
>> +		pr_err("vGIC IRQ fired, disabling.\n");
> 
> Please add a _ratelimited here. Whilst debugging KVM on this machine,
> I ended up with this firing at such a rate that it was impossible to
> do anything useful. Ratelimiting it allowed me to pinpoint the
> problem.

Ouch. Done for v4.

>> +static void aic_fiq_eoi(struct irq_data *d)
>> +{
>> +	/* We mask to ack (where we can), so we need to unmask at EOI. */
>> +	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
> 
> Ah, be careful here: irqd_irq_masked() doesn't do what you think it
> does for per-CPU interrupts. It's been on my list to fix for the rVIC
> implementation, but I never got around to doing it, and all decent ICs
> hide this from SW by having a HW-managed mask, similar to what is on
> the IRQ side.
> 
> I can see two possibilities:
> 
> - you can track the masked state directly and use that instead of
>    these predicates
> 
> - you can just drop the masking altogether as this is only useful to a
>    hosted hypervisor (KVM), which will have to do its own masking
>    behind the scenes anyway
> 

Since you're using the masking in KVM after all, I'm tracking the mask 
state in a percpu variable now. Also folded in your two minor bugfixes 
from the KVM series. Cheers!


-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

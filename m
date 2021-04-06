Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217FC355C1E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhDFTWF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 15:22:05 -0400
Received: from marcansoft.com ([212.63.210.85]:49944 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhDFTWF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 15:22:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 30DF941E64;
        Tue,  6 Apr 2021 19:21:48 +0000 (UTC)
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
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-16-marcan@marcan.st> <87ft03p9cd.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v4 15/18] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <5a4a0ab4-5a4e-1f1c-f6c6-97439b95e7ee@marcan.st>
Date:   Wed, 7 Apr 2021 04:21:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ft03p9cd.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/04/2021 03.16, Marc Zyngier wrote:
> Hi Hector,
> 
> On Fri, 02 Apr 2021 10:05:39 +0100,
> Hector Martin <marcan@marcan.st> wrote:
>> +		/*
>> +		 * In EL1 the non-redirected registers are the guest's,
>> +		 * not EL2's, so remap the hwirqs to match.
>> +		 */
>> +		if (!is_kernel_in_hyp_mode()) {
>> +			switch (fwspec->param[1]) {
>> +			case AIC_TMR_GUEST_PHYS:
>> +				*hwirq = ic->nr_hw + AIC_TMR_HV_PHYS;
>> +				break;
>> +			case AIC_TMR_GUEST_VIRT:
>> +				*hwirq = ic->nr_hw + AIC_TMR_HV_VIRT;
>> +				break;
>> +			case AIC_TMR_HV_PHYS:
>> +			case AIC_TMR_HV_VIRT:
>> +				return -ENOENT;
>> +			default:
>> +				break;
>> +			}
>> +		}
> 
> Urgh, this is nasty. You are internally remapping the hwirq from one
> timer to another in order to avoid accessing the enable register
> which happens to be an EL2 only register?

The remapping is to make the IRQs route properly at all.

There are EL2 and EL0 timers, and on GIC each timer goes to its own IRQ. 
But here there are no real IRQs, everything's a FIQ. However, thanks to 
VHE, the EL2 timer shows up as the EL0 timer, and the EL0 timer is 
accessed via EL02 registers, when in EL2. So in EL2/VHE mode, "HV" means 
EL0 and "guest" means EL02, while in EL1, there is no HV and "guest" 
means EL0. And since we figure out which IRQ fired by reading timer 
registers, this is what matters. So I map the guest IRQs to the HV 
hwirqs in EL1 mode, which makes this all work out. Then the timer code 
goes and ends up undoing all this logic again, so we map to separate 
fake "IRQs" only to end up right back at using the same timer registers 
anuway :-)

Really, the ugliness here is that the constant meaning is overloaded. In 
fwspec context they mean what they say on the tin, while in hwirq 
context "HV" means EL0 and "guest" means EL02 (other FIQs would be 
passed through unchanged). Perhaps some additional defines might help 
clarify this? Say, at the top of this file (not in the binding),

/*
  * Pass-through mapping from real timers to the correct registers to
  * access them in EL2/VHE mode. When running in EL1, this gets
  * overridden to access the guest timer using EL0 registers.
  */
#define AIC_TMR_EL0_PHYS AIC_TMR_HV_PHYS
#define AIC_TMR_EL0_VIRT AIC_TMR_HV_VIRT
#define AIC_TMR_EL02_PHYS AIC_TMR_GUEST_PHYS
#define AIC_TMR_EL02_VIRT AIC_TMR_GUEST_VIRT

Then the irqchip/FIQ dispatch side can use the EL* constants, the 
default pass-through mapping is appropriate for VHE/EL2 mode, and 
translation can adjust it for EL1 mode.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

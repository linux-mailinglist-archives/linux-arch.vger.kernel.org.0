Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90C93493B1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCYOIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhCYOIQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Mar 2021 10:08:16 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65091C06174A;
        Thu, 25 Mar 2021 07:08:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 354CF41A6E;
        Thu, 25 Mar 2021 14:07:42 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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
        DTML <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-9-marcan@marcan.st>
 <20210324181210.GB13181@willie-the-truck>
 <CAK8P3a0913Hs4VfHjdDY1WTAQvMzC83LJcP=9zeE0C-terfBhA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h: Add a non-posted variant
 of ioremap()
Message-ID: <9e510158-551a-3feb-bdba-17e070f12a8e@marcan.st>
Date:   Thu, 25 Mar 2021 23:07:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0913Hs4VfHjdDY1WTAQvMzC83LJcP=9zeE0C-terfBhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25/03/2021 04.09, Arnd Bergmann wrote:
> On Wed, Mar 24, 2021 at 7:12 PM Will Deacon <will@kernel.org> wrote:
>>
>>> +/*
>>> + * ioremap_np needs an explicit architecture implementation, as it
>>> + * requests stronger semantics than regular ioremap(). Portable drivers
>>> + * should instead use one of the higher-level abstractions, like
>>> + * devm_ioremap_resource(), to choose the correct variant for any given
>>> + * device and bus. Portable drivers with a good reason to want non-posted
>>> + * write semantics should always provide an ioremap() fallback in case
>>> + * ioremap_np() is not available.
>>> + */
>>> +#ifndef ioremap_np
>>> +#define ioremap_np ioremap_np
>>> +static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
>>> +{
>>> +     return NULL;
>>> +}
>>> +#endif
>>
>> Can we implement the generic pci_remap_cfgspace() in terms of ioremap_np()
>> if it is supported by the architecture? That way, we could avoid defining
>> both on arm64.
> 
> Good idea. It needs a fallback in case the ioremap_np() fails on most
> architectures, but that sounds easy enough.
> 
> Since pci_remap_cfgspace() only has custom implementations, it sounds like
> we can actually make the generic implementation unconditional in the end,
> but that requires adding ioremap_np() on 32-bit as well, and I would keep
> that separate from this series.

Sounds good; I'm adding a patch to adjust the generic implementation and 
remove the arm64 one in v4, and we can then complete the cleanup for 
other arches later.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

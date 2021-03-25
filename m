Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2C349488
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 15:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhCYOta (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 10:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhCYOtO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 10:49:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 837F7619F9;
        Thu, 25 Mar 2021 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616683753;
        bh=g2ZlXDmeEeZxEkxEnqAn7onjv8xh5BForWiFk2ex04U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B7AXfE4jFRrobfpRw2FaAYKC6MvyXtU6obWFBYkN0lGwjbQiFaLragEzkHbZItBws
         QBand/1dIuqMlS8nHo0I+YXxuG4FUSBqCuL4lSjtB1KNR8ZC5A0dHPTgjp6C4Oj477
         YGYoQaHRwjTqkyAUy9nju41KQckd840sj7rAx2b0qbeWS73PVSRLi5XxftNFChRgBj
         A74iOhWJ7Z2hED2cBG6LJSpp0VhA5RVDGFxCz/bh5Feg/yMuNLIKAvIJSpdBVn+DEc
         g38Q/XF19LYytoglY1yJyqNca2iKkNPAL5ceWnMOmYHNen+O1Ivl6iLodMdhA7We0k
         rrMK1jKks2Uxg==
Date:   Thu, 25 Mar 2021 14:49:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h: Add a non-posted variant
 of ioremap()
Message-ID: <20210325144905.GA15109@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-9-marcan@marcan.st>
 <20210324181210.GB13181@willie-the-truck>
 <CAK8P3a0913Hs4VfHjdDY1WTAQvMzC83LJcP=9zeE0C-terfBhA@mail.gmail.com>
 <9e510158-551a-3feb-bdba-17e070f12a8e@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e510158-551a-3feb-bdba-17e070f12a8e@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 25, 2021 at 11:07:40PM +0900, Hector Martin wrote:
> On 25/03/2021 04.09, Arnd Bergmann wrote:
> > On Wed, Mar 24, 2021 at 7:12 PM Will Deacon <will@kernel.org> wrote:
> > > 
> > > > +/*
> > > > + * ioremap_np needs an explicit architecture implementation, as it
> > > > + * requests stronger semantics than regular ioremap(). Portable drivers
> > > > + * should instead use one of the higher-level abstractions, like
> > > > + * devm_ioremap_resource(), to choose the correct variant for any given
> > > > + * device and bus. Portable drivers with a good reason to want non-posted
> > > > + * write semantics should always provide an ioremap() fallback in case
> > > > + * ioremap_np() is not available.
> > > > + */
> > > > +#ifndef ioremap_np
> > > > +#define ioremap_np ioremap_np
> > > > +static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
> > > > +{
> > > > +     return NULL;
> > > > +}
> > > > +#endif
> > > 
> > > Can we implement the generic pci_remap_cfgspace() in terms of ioremap_np()
> > > if it is supported by the architecture? That way, we could avoid defining
> > > both on arm64.
> > 
> > Good idea. It needs a fallback in case the ioremap_np() fails on most
> > architectures, but that sounds easy enough.
> > 
> > Since pci_remap_cfgspace() only has custom implementations, it sounds like
> > we can actually make the generic implementation unconditional in the end,
> > but that requires adding ioremap_np() on 32-bit as well, and I would keep
> > that separate from this series.
> 
> Sounds good; I'm adding a patch to adjust the generic implementation and
> remove the arm64 one in v4, and we can then complete the cleanup for other
> arches later.

Cheers. Don't forget to update the comment in the generic code which
complains about the lack of an ioremap() API for non-posted writes ;)

Will

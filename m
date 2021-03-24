Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0553D348143
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 20:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhCXTKO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 15:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237772AbhCXTKN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 15:10:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BDA761984;
        Wed, 24 Mar 2021 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616613013;
        bh=wKhyXf6OlPLejS4AH7GTGSIzqqY9qRZukCMZkBu099w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G61Cr45O+elwyR/Y2OiX79rDPdpRo0XR2Jh/YMmaOL2YNzoCkZiIwahwgfZy1wfK0
         cOxgBb2diXWjknqOdE6yujML3doG84SJFIn1wiD7M7025OHC7fXy9FhW85phWCj8Kp
         OAfgeXQ7WhAYwjcg+g6tTo5qvWvUAj/yjAIOuu5b8eZaIrpFLbSGKTH6kIfVxtQg1P
         C60rjV2jsP2tQpPl4mqlf4u7/ytzVR4qdHmilkCnjtk1X6061h6WmR/e5a/PcmFjlm
         WZSRhhpgbs2v78NtbE8881nwWHkpizSPjuvrgZ5WH1MK0BEs/uAqhYLwwPI60s0xTw
         qsza7yUGbGEvg==
Received: by mail-oi1-f170.google.com with SMTP id w70so21928534oie.0;
        Wed, 24 Mar 2021 12:10:13 -0700 (PDT)
X-Gm-Message-State: AOAM531M0W4Ko8nFpsFiacc3q/I6jVMiXxXs2+XzTi1pOLGOTIt/nwoy
        1c866cN3kPuhhC8gHE55EKB8a1SpT7WGSI2G2wE=
X-Google-Smtp-Source: ABdhPJyy3btPqFmSL9PcWCqNAYtZ5UJz1aUhBJwCm0wMQoxjVzMJONR+PSjjRGcyU9ttBf/7kC+FA3xiuJdCSA0X9oE=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr3289587oie.67.1616613012429;
 Wed, 24 Mar 2021 12:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-9-marcan@marcan.st>
 <20210324181210.GB13181@willie-the-truck>
In-Reply-To: <20210324181210.GB13181@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Mar 2021 20:09:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0913Hs4VfHjdDY1WTAQvMzC83LJcP=9zeE0C-terfBhA@mail.gmail.com>
Message-ID: <CAK8P3a0913Hs4VfHjdDY1WTAQvMzC83LJcP=9zeE0C-terfBhA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h: Add a non-posted variant
 of ioremap()
To:     Will Deacon <will@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 24, 2021 at 7:12 PM Will Deacon <will@kernel.org> wrote:
>
> > +/*
> > + * ioremap_np needs an explicit architecture implementation, as it
> > + * requests stronger semantics than regular ioremap(). Portable drivers
> > + * should instead use one of the higher-level abstractions, like
> > + * devm_ioremap_resource(), to choose the correct variant for any given
> > + * device and bus. Portable drivers with a good reason to want non-posted
> > + * write semantics should always provide an ioremap() fallback in case
> > + * ioremap_np() is not available.
> > + */
> > +#ifndef ioremap_np
> > +#define ioremap_np ioremap_np
> > +static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
> > +{
> > +     return NULL;
> > +}
> > +#endif
>
> Can we implement the generic pci_remap_cfgspace() in terms of ioremap_np()
> if it is supported by the architecture? That way, we could avoid defining
> both on arm64.

Good idea. It needs a fallback in case the ioremap_np() fails on most
architectures, but that sounds easy enough.

Since pci_remap_cfgspace() only has custom implementations, it sounds like
we can actually make the generic implementation unconditional in the end,
but that requires adding ioremap_np() on 32-bit as well, and I would keep
that separate from this series.

        Arnd

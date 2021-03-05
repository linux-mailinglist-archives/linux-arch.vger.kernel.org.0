Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4232F53B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCEVRd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 16:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhCEVRb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 16:17:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD21A650A3;
        Fri,  5 Mar 2021 21:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614979050;
        bh=Uq2IgJr9kfuVZlHKajDc//q6GSI/XAvfSiCyKzo1V8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lRdKSARLHY86Mf+trKqlx5nDF6gUxXjau8jUulM0OvPHJnGHI+M8ySKktY8XXjiyh
         gPgeYM/hOkWA4pMjlJBG1uE3K67vpVrBNMG/PLuFLxreBluK7TN771IUBPk0n+Q+8m
         5aB2L2Fm24Sb5y0llCK3eB4e9semIXGj8Gk5B9jGiSxqIgHAk5WWHM5WV9BqyYS7ka
         U5jPmZBMU21t0Kk5r//0EHI6e0rxIvN2x05/oinlGGebESgDGGUGa8aU+z8zYR8O/G
         eYaEoUL45CG6w7DeJ8XM1Orfk3FuygeAiRz8Fm/I6OvluvPaW88PVV95UXoj8xQ6ER
         XAa1IhBeRCPng==
Received: by mail-oi1-f174.google.com with SMTP id j1so4052533oiw.3;
        Fri, 05 Mar 2021 13:17:30 -0800 (PST)
X-Gm-Message-State: AOAM530dA6UOr9jnM5OrYtXqtNf0U7+CGMl5YFfkHAHPYsXgeWGLrxmR
        5dY6TKh2vJd1VFqHzAZCHCRd/KqEHL3/rlrzzOs=
X-Google-Smtp-Source: ABdhPJxuxTnyW6QlTJAPT3FkZfYcbHpraEjPrLMerJHage2MvI0443wfkGa8phS23+Oq983m1NS18jdBnjhB5h3CRcA=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr8198762oib.67.1614979049957;
 Fri, 05 Mar 2021 13:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com> <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st>
In-Reply-To: <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 5 Mar 2021 22:17:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
Message-ID: <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Hector Martin <marcan@marcan.st>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>,
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
        DTML <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 5, 2021 at 7:18 PM Hector Martin <marcan@marcan.st> wrote:
>
> On 06/03/2021 02.39, Rob Herring wrote:
> >> -       return ioremap(res.start, resource_size(&res));
> >> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> >> +               return ioremap_np(res.start, resource_size(&res));
> >> +       else
> >> +               return ioremap(res.start, resource_size(&res));
> >
> > This and the devm variants all scream for a ioremap_extended()
> > function. IOW, it would be better if the ioremap flavor was a
> > parameter. Unless we could implement that just for arm64 first, that's
> > a lot of refactoring...
>
> I agree, but yeah... that's one big refactor to try to do now...

FWIW, there is ioremap_prot() that Christoph introduced in 2019
for a few architectures.  I suppose it would be nice to lift
that out architecture specific code and completely replace the
unusual variants, leaving only ioremap(), ioremap_prot() and
memremap() but dropping the _nc, _cached, _wc, _wt and _np
versions in favor of an extensible set of flags.

Then again, I would not make that a prerequisite for the merge
of the M1 support.

> > What's the code path using these functions on the M1 where we need to
> > return 'posted'? It's just downstream PCI mappings (PCI memory space),
> > right? Those would never hit these paths because they don't have a DT
> > node or if they do the memory space is not part of it. So can't the
> > check just be:
> >
> > bool of_mmio_is_nonposted(struct device_node *np)
> > {
> >      return np && of_machine_is_compatible("apple,arm-platform");
> > }
>
> Yes; the implementation was trying to be generic, but AIUI we don't need
> this on M1 because the PCI mappings don't go through this codepath, and
> nothing else needs posted mode. My first hack was something not too
> unlike this, then I was going to get rid of apple,arm-platform and just
> have this be a generic mechanism with the properties, but then we added
> the optimization to not do the lookups on other platforms, and now we're
> coming full circle... :-)

I never liked the idea of having a list of platforms that need a
special hack, please let's not go back to that.

         Arnd

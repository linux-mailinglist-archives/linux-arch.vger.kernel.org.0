Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71C32F044
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCEQoC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:44:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhCEQno (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 11:43:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41F6E6508B;
        Fri,  5 Mar 2021 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614962624;
        bh=LU9abYarido7jBUFI+h2VPbi2pDJZpL4e6lVWkDvYEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AOuCgeOm68/J35XdVGCCO8ObjBJTPneMFSBUISgLzKiwKQ3i4kgD18HMxT2Iw48vM
         qWAAZJfmamD3N/ZAm48YBZWXiUtRjKCfaEjQ+WVQ2AC5Dm2duScHddzPa+Ei7Vyhim
         XuiZKe/AaiFmlxHLirNqcoqlJ0GemxUGXpcMzUW+RVHE57OzkYY52LWsPt9tZLD1Dm
         2hUCGHpuB1IUu5ad30iHnFh/3RWUwdxsyM9XFG9QISrzDcEfASyqBuQoD7G2ZQVjen
         9mf2Zy9zKpqINWBxzS4c0m7OqjATJEO0sceAo57Ti8Y0MJDJSpmI2kX0hC3EzzmkDL
         hX7bVP3Md+WDg==
Received: by mail-ot1-f43.google.com with SMTP id g8so2397197otk.4;
        Fri, 05 Mar 2021 08:43:44 -0800 (PST)
X-Gm-Message-State: AOAM533jyLqcasg0cL/+vKaSF5K5buniGM4xfrYNXyWShX0H/8s6Fw5b
        elwl3fXgUuBpUzN74kXCxnDQBngn8CCWfT0YQhA=
X-Google-Smtp-Source: ABdhPJwz5Ow9XqsCCIrLLR9sMDo1pxHzHSiQz3uG5gZVUFQzrpgBZzCWoAerPcV8PVcXgONzd+LKsBQ6Gbx962ZNWVY=
X-Received: by 2002:a9d:12e1:: with SMTP id g88mr5425358otg.305.1614962623492;
 Fri, 05 Mar 2021 08:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
 <04ea35d6-cd7d-d6de-75ae-59b1e0c77f04@marcan.st> <CAHp75Vd6adVM94G1vCrQcZoegQFWHbK14YRRuBTQZwrM5CV2jQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd6adVM94G1vCrQcZoegQFWHbK14YRRuBTQZwrM5CV2jQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 5 Mar 2021 17:43:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1X4DyWdeBM1Vx+QMXU7+VhJrLHFLVzwAE4a4mb_xuqMQ@mail.gmail.com>
Message-ID: <CAK8P3a1X4DyWdeBM1Vx+QMXU7+VhJrLHFLVzwAE4a4mb_xuqMQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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

On Fri, Mar 5, 2021 at 5:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Mar 5, 2021 at 5:55 PM Hector Martin <marcan@marcan.st> wrote:
> > On 06/03/2021 00.13, Andy Shevchenko wrote:
>
> ...
>
> > >> -       return ioremap(res.start, resource_size(&res));
> > >> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> > >> +               return ioremap_np(res.start, resource_size(&res));
> > >> +       else
> > >> +               return ioremap(res.start, resource_size(&res));
> > >
> > > This doesn't sound right. Why _np is so exceptional? Why don't we have
> > > other flavours (it also rings a bell to my previous comment that the
> > > flag in ioresource is not in the right place)?
> >
> > This is different from other variants, because until now *drivers* have
> > made the choice of what ioremap mode to use based on device requirements
> > (which means ioremap() 99% of the time, and then framebuffers and other
> > memory-ish things such use something else). Now we have a *SoC fabric*
> > that is calling the shots on what ioremap mode we have to use - and
> > *every* non-PCIe driver needs to use ioremap_np() on these SoCs, or they
> > break. So it seems a lot cleaner to make the choice for drivers here to
> > upgrade ioremap() to ioremap_np() for SoCs that need it.
>
> Yes, that is a good idea. Once we discussed x86 and _uc cases and
> actually on x86 it makes a lot of sense to have ioremap() ==
> ioremap_uc(). Can't be this a similar case here?

The difference is that ioremap() should be ioremap_uc() on /all/
architectures, it's just that x86 and ia64 for a long time were the
exception and defined ioremap() as 'do whatever the mtrr says'.

> Arnd, what do you think of actually providing an ioremap() as some
> kind of "best for the architecture the code is running on"?

Linus has been pretty clear about wanting all the default functions
to have similar behavior across architectures and be at least as
strict as x86. In case of ioremap() that usually means that writes
are posted, because they are that way on PCI buses on x86.

There are definitely some advantages of making all writes non-posted
by default on Arm because that would be a simpler model, but there
are some important downsides:

- non-posted writes can be much slower than posted ones, depending
  on the specific hardware

- it would change the behavior of all Arm platforms, with no easy
  way to validate it

- setting ioremap() on PCI buses non-posted only makes them
  only slower but not more reliable, because the non-posted flag
  on the bus is discarded by the PCI host bridge.

> Otherwise if the same driver happens to be needed on different
> architectures, oops, ifdeffery or simple conditionals over the code is
> really not the best way to solve it.

The behavior of devm_platform_ioremap_resource() is now to
do the right thing automatically, and I think that is good enough. For
all I can tell, we can use that in all drivers without conditional
compilation.

> > If we don't do something like this here or in otherwise common code,
> > we'd have to have an open-coded "if apple then ioremap_np, else ioremap"
> > in every driver that runs on-die devices on these SoCs, even ones that
> > are otherwise standard and need few or no Apple-specific quirks.
>
> Exactly! But what about architectures where _uc is that one? So, why
> does your patch only take part of _np case?
> (Hint we have x86 Device Tree based platforms)

Usually, the driver knows the requirements, and they are independent
of the platform. If a driver wants _wc or _wt mappings, it will want that
on all machines, and should be able to deal with platforms that implement
that through a stricter mapping.

The two drivers that need to override ioremap() to ioremap_uc()
in order to override the mtrr already have that logic. You are right
that these are a bit like the _np() case in that the device needs
something stricter than the default mapping, but the difference is
that for x86 ioremap_uc() this is needed to work around broken
firmware, while for the apple ioremap_np() case we trust the firmware
to tell us what to do.

> Yep, and why not to make ioremap() == ioremap_nc() on architecture
> that requires it?
> Can it be detected at run time?

I think doing this requires auditing a lot of legacy driver code,
especially drivers/video/fbdev. Once all drivers that need write-combining
mappings explicitly ask for them, the default ioremap can be changed
over to act like ioremap_nc() on the remaining two architectures that
don't do that yet.

There has been a lot of work toward that goal, but the problem
is knowing exactly which drivers need it.

       Arnd

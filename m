Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE532EFB4
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCEQJC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhCEQIo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 11:08:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC81DC061574;
        Fri,  5 Mar 2021 08:08:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fu20so2131647pjb.2;
        Fri, 05 Mar 2021 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzJbcn2Bf5oIu0/VNNTub9S9qN/KmbJZUnNKqWz1BGo=;
        b=rroJgfmQ2M/jLVa81ZRwdlOpZlc/i58e/utvcm+/9AmUuAkiK5M7N1AqYMbmsQcv1p
         KDydQUJGmINsBe/lgKRJFbnRl11l6g0ZBfDWJFlwUM81q36D4crLAORsUeTm5NXlCOMj
         Jnz6qps8GrCSfrNMi4kvIIvtCiTXfendATiKWpTTuLWJHZsKQi/V0tYOE2WVGC9Jkd/0
         D6y2d3HEtTwbL0vPkmcScw2DUFzr+t5WHgBHRrVm7HQzddOMcueTHZoChTsd1Kig4B9U
         L0hr5NRhPfQSdNCl4II0uLIE6wJQ4ZUGmuLsYHyHTtTBuar+GM8phhfh3a6NrFL1jazX
         5zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzJbcn2Bf5oIu0/VNNTub9S9qN/KmbJZUnNKqWz1BGo=;
        b=VyqU2/nJSiweNX3u4912rfIEwt5GYVF5GmtKaJsczC01UBwh1OP96dtsfQ8TfJ5ZUy
         RMvdHZnnr5mw+JnPBgKH9nPmVev9Zj68OND7wfGXlpvsVkipHcIZlqSDagqCGWSJWSEw
         jnLftwJ2ISxHemuyW7nlcsr1gjn6ovc7IFug7qxz3e4ytjqc37++nY8l0FuN0opm9Y+v
         ZOVDhujdRXKVZkUhM4zhfLx7IuMOyqMF0VUr3UAff9gMO5xE86JWnP4OSpp/AgRADjaT
         yv9A7TW3OlPDR48OzbxiyrDzJ7leCK11C3W8qc7udCKXg+5gGOhnRTsna6yLLO63vVmU
         5tBg==
X-Gm-Message-State: AOAM532WCQNSnZmrw7cADRLfb2UTf3YhL04b7h1wNUAMiXqJInu2pubU
        buVkY2n91GKbBvccAWkDKsyF2l4qAnWKIiKyaLw=
X-Google-Smtp-Source: ABdhPJzLoPhSeJGxlr3MgS/Wnn4G2jekmS6UM0SXi3AaYSt6vBAtWIJWjPFM+bWm2F/zbWUX+E55FpdwKOjY9W6AbMU=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr11418889pjx.181.1614960523418;
 Fri, 05 Mar 2021 08:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com> <04ea35d6-cd7d-d6de-75ae-59b1e0c77f04@marcan.st>
In-Reply-To: <04ea35d6-cd7d-d6de-75ae-59b1e0c77f04@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 18:08:27 +0200
Message-ID: <CAHp75Vd6adVM94G1vCrQcZoegQFWHbK14YRRuBTQZwrM5CV2jQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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

On Fri, Mar 5, 2021 at 5:55 PM Hector Martin <marcan@marcan.st> wrote:
> On 06/03/2021 00.13, Andy Shevchenko wrote:

...

> >> -       return ioremap(res.start, resource_size(&res));
> >> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> >> +               return ioremap_np(res.start, resource_size(&res));
> >> +       else
> >> +               return ioremap(res.start, resource_size(&res));
> >
> > This doesn't sound right. Why _np is so exceptional? Why don't we have
> > other flavours (it also rings a bell to my previous comment that the
> > flag in ioresource is not in the right place)?
>
> This is different from other variants, because until now *drivers* have
> made the choice of what ioremap mode to use based on device requirements
> (which means ioremap() 99% of the time, and then framebuffers and other
> memory-ish things such use something else). Now we have a *SoC fabric*
> that is calling the shots on what ioremap mode we have to use - and
> *every* non-PCIe driver needs to use ioremap_np() on these SoCs, or they
> break. So it seems a lot cleaner to make the choice for drivers here to
> upgrade ioremap() to ioremap_np() for SoCs that need it.

Yes, that is a good idea. Once we discussed x86 and _uc cases and
actually on x86 it makes a lot of sense to have ioremap() ==
ioremap_uc(). Can't be this a similar case here?
Arnd, what do you think of actually providing an ioremap() as some
kind of "best for the architecture the code is running on"?

Otherwise if the same driver happens to be needed on different
architectures, oops, ifdeffery or simple conditionals over the code is
really not the best way to solve it.

> If we don't do something like this here or in otherwise common code,
> we'd have to have an open-coded "if apple then ioremap_np, else ioremap"
> in every driver that runs on-die devices on these SoCs, even ones that
> are otherwise standard and need few or no Apple-specific quirks.

Exactly! But what about architectures where _uc is that one? So, why
does your patch only take part of _np case?
(Hint we have x86 Device Tree based platforms)

> We're still going to have to patch some drivers to use managed APIs that
> can properly hit this conditional (like I did for samsung_tty) in cases
> where they currently don't, but that's a lot cleaner than an open-coded
> conditional, I think (and often comes with other benefits anyway).
>
> Note that wholesale making ioremap() behave like ioremap_np() at the
> arch level as as SoC quirk is not an option - for extenal PCIe devices,
> we still need to use ioremap(). We tried this approach initially but it
> doesn't work. Hence we arrived at this solution which describes the
> required mode in the devicetree, at the bus level (which makes sense,
> since that represents the fabric), and then these wrappers can use that
> information, carried over via the bit in struct device, to pick the
> right ioremap mode.
>
> It doesn't really make sense to include the other variants here, because
> _np is strictly stronger than the default. Downgrading ioremap to any
> other variant would break most drivers, badly. However, upgrading to
> ioremap_np() is always correct (if possibly slower), on platforms where
> it is allowed by the bus. In fact, I bet that on many systems nGnRE
> already behaves like nGnRnE anyway. I don't know why Apple didn't just
> allow nGnRE mappings to work (behaving like nGnRnE) instead of making
> them explode, which is the whole reason we have to do this.

Yep, and why not to make ioremap() == ioremap_nc() on architecture
that requires it?
Can it be detected at run time?

...

> >> +       while (node) {
> >> +               if (!of_property_read_bool(node, "ranges")) {
> >> +                       break;
> >> +               } else if (of_property_read_bool(node, "nonposted-mmio")) {
> >> +                       of_node_put(node);
> >> +                       return true;
> >> +               } else if (of_property_read_bool(node, "posted-mmio")) {
> >> +                       break;
> >> +               }
> >> +               parent = of_get_parent(node);
> >> +               of_node_put(node);
> >> +               node = parent;
> >> +       }
> >
> > I believe above can be slightly optimized. Don't we have helpers to
> > traverse to all parents?
>
> Keep in mind the logic here is that it stops on the first instance of
> either property, and does not traverse non-translatable boundaries. Are
> there helpers that can implement this kind of complex logic? It's not a
> simple recursive property lookup.

I am aware of what it does and I believe if we don't have such a
helper yet we may introduce it and maybe even existing users of
something similar can utilize it.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C43312AC
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 16:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCHP5B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 10:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCHP4r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 10:56:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B7906523A;
        Mon,  8 Mar 2021 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219006;
        bh=AMnX0SygVGdsOpsu02CyTU1ONKxzUU3oyic44NgULgI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDVw4MdENfuLbuKeqvtBWjNwSH2rGzMMF/UVPMnMptRWwixmLjWouenUjUaZVGD/2
         VDMzOioc+4g7dqsc/yvW88uPL+29CGqQCCcpQzmxLxhV7KMxKvQtgk6ST1Kjl8y1q2
         duBbBAIERhBaUMUImlm/GCfe1/7FPwjyV+UM9oTNfa1Q/kDnW7sUHWtWfot6bOFk3y
         1mqTkQCxIg0qqeUjcAZYP5AIzpA3NpprexEMQKdpGNeQYrMHp22XkRRVLOa26628X/
         y1UFObeUQDmDtkDsdbhoJ2hHWCISQWABVWk7BJg3tO6uwI9Am6lX8TVOpfl/KC4tf3
         GoDVG1lJDWslw==
Received: by mail-ed1-f51.google.com with SMTP id d13so15511359edp.4;
        Mon, 08 Mar 2021 07:56:46 -0800 (PST)
X-Gm-Message-State: AOAM532tV9yA+5I+6LKx8BpO+aC5xGnjjW7VmpqucMgr5UpNmm19fadp
        1YCMJyacjIeBcqsG6poivuYRn+lcyBN3HwMcKg==
X-Google-Smtp-Source: ABdhPJwH/b4ZAsQVcZUHxUxeVuQH7gPalQFtNSoosBJOJIGZEktZbjD5b3DoKZKlUThK2W/ME6qwN0vqO1cuyxhhGEI=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr22380286edb.373.1615219004932;
 Mon, 08 Mar 2021 07:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Mar 2021 08:56:32 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
Message-ID: <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
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

On Fri, Mar 5, 2021 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Mar 5, 2021 at 7:18 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > On 06/03/2021 02.39, Rob Herring wrote:
> > >> -       return ioremap(res.start, resource_size(&res));
> > >> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> > >> +               return ioremap_np(res.start, resource_size(&res));
> > >> +       else
> > >> +               return ioremap(res.start, resource_size(&res));
> > >
> > > This and the devm variants all scream for a ioremap_extended()
> > > function. IOW, it would be better if the ioremap flavor was a
> > > parameter. Unless we could implement that just for arm64 first, that's
> > > a lot of refactoring...
> >
> > I agree, but yeah... that's one big refactor to try to do now...
>
> FWIW, there is ioremap_prot() that Christoph introduced in 2019
> for a few architectures.  I suppose it would be nice to lift
> that out architecture specific code and completely replace the
> unusual variants, leaving only ioremap(), ioremap_prot() and
> memremap() but dropping the _nc, _cached, _wc, _wt and _np
> versions in favor of an extensible set of flags.
>
> Then again, I would not make that a prerequisite for the merge
> of the M1 support.
>
> > > What's the code path using these functions on the M1 where we need to
> > > return 'posted'? It's just downstream PCI mappings (PCI memory space),
> > > right? Those would never hit these paths because they don't have a DT
> > > node or if they do the memory space is not part of it. So can't the
> > > check just be:
> > >
> > > bool of_mmio_is_nonposted(struct device_node *np)
> > > {
> > >      return np && of_machine_is_compatible("apple,arm-platform");
> > > }
> >
> > Yes; the implementation was trying to be generic, but AIUI we don't need
> > this on M1 because the PCI mappings don't go through this codepath, and
> > nothing else needs posted mode. My first hack was something not too
> > unlike this, then I was going to get rid of apple,arm-platform and just
> > have this be a generic mechanism with the properties, but then we added
> > the optimization to not do the lookups on other platforms, and now we're
> > coming full circle... :-)
>
> I never liked the idea of having a list of platforms that need a
> special hack, please let's not go back to that.

I'm a fan of generic solutions as much as anyone, but not when there's
a single user. Yes, there could be more, but we haven't seen any yet
and Apple seems to have a knack for doing special things. I'm pretty
sure posted vs. non-posted has been a possibility with AXI buses from
the start, so it's not like this is a new thing we're going to see
frequently on new platforms.

A generic property we have to support forever because there's zero
visibility if someone uses them. At least with something platform
specific, we know if it's in use or can be removed. That's something I
just checked recently with some of the PPC irq work-arounds (spoiler:
yes, those 'old world Mac' are). I'm a bit less worried about this
aspect given we can probably assume someone will still be using M1
Macs in 20+ years.

The other situation I worry about here is another arch has implicitly
defaulted to non-posted instead of posted. It could just be non-posted
was what worked everywhere and Linux couldn't distinguish. Now someone
sees we have this new posted vs. non-posted handling and can optimize
some mappings on their platform and we have to have per arch defaults
(like 'dma-coherent' now).

Rob

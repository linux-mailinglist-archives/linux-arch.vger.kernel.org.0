Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D425331898
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 21:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCHUa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 15:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCHUaM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 15:30:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABF3D65299;
        Mon,  8 Mar 2021 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615235411;
        bh=Z575lVGPBfuAgtfOeWzz+Rq41DmqJRD8p6ieml212ZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=heqU6iuJLSb0g+w8KLlZ9xvGIF9oBxx+DcX4J0DzvHhPncWb2BQmQurE7aNISIwhs
         N72WR5vUIpIGl3Nfy7B3qgXNqHYy1TLZPJHFm02b3LtJ+tc0Azy5Nsc/iZssBOqVnb
         txc15IGC3J7LBZGXBRcvRc60E4QkBRZUfaLjQML5+o6mW9FcPKLVGHq27v2kf+JKsW
         oxhEc1UcYvRSz8Kdkb7Kj2/mI0lEHAG7V4FuFOC6mMR3M6s6uyldZqn4Nnl5A9AXvg
         JzYz7DYErCJ5u8H5qpVxmJgedM0FRJY3D+esnrOBt1m74k6bdfuU0+HlrTyTq45+B+
         Hc3pc12kAFHCw==
Received: by mail-ot1-f52.google.com with SMTP id f33so10513123otf.11;
        Mon, 08 Mar 2021 12:30:11 -0800 (PST)
X-Gm-Message-State: AOAM5306y9w49tG5o09xf6Q+vSzwGyM0kxusEAVTNUwsfE1vX8hQ7Bem
        aoXAWCAi0fBh9Cz1UQjf9n5qB0Ah/H1B70vWc3w=
X-Google-Smtp-Source: ABdhPJy6rWkrMOdlTTTDQyrPIoB4JKQiF6S833KGy3zJtRbzvfqY9DZfdUJofhvQHvdvpSg5Bctz65fFVfhKR+P6FmA=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3633116otq.251.1615235410953;
 Mon, 08 Mar 2021 12:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
In-Reply-To: <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Mar 2021 21:29:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
Message-ID: <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Rob Herring <robh@kernel.org>
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

On Mon, Mar 8, 2021 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Mar 5, 2021 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Fri, Mar 5, 2021 at 7:18 PM Hector Martin <marcan@marcan.st> wrote:
>
> > > > What's the code path using these functions on the M1 where we need to
> > > > return 'posted'? It's just downstream PCI mappings (PCI memory space),
> > > > right? Those would never hit these paths because they don't have a DT
> > > > node or if they do the memory space is not part of it. So can't the
> > > > check just be:
> > > >
> > > > bool of_mmio_is_nonposted(struct device_node *np)
> > > > {
> > > >      return np && of_machine_is_compatible("apple,arm-platform");
> > > > }
> > >
> > > Yes; the implementation was trying to be generic, but AIUI we don't need
> > > this on M1 because the PCI mappings don't go through this codepath, and
> > > nothing else needs posted mode. My first hack was something not too
> > > unlike this, then I was going to get rid of apple,arm-platform and just
> > > have this be a generic mechanism with the properties, but then we added
> > > the optimization to not do the lookups on other platforms, and now we're
> > > coming full circle... :-)
> >
> > I never liked the idea of having a list of platforms that need a
> > special hack, please let's not go back to that.
>
> I'm a fan of generic solutions as much as anyone, but not when there's
> a single user. Yes, there could be more, but we haven't seen any yet
> and Apple seems to have a knack for doing special things. I'm pretty
> sure posted vs. non-posted has been a possibility with AXI buses from
> the start, so it's not like this is a new thing we're going to see
> frequently on new platforms.

Ok, but if we make it a platform specific bit, I would prefer not
to do the IORESOURCE_MEM_NONPOSTED flag either but
instead keep the logic in the device drivers that call ioremap().

This is obviously more work for the drivers, but at least it keeps
the common code free of the hack while also allowing drivers to
use ioremap_np() intentionally on other platforms.

> The other situation I worry about here is another arch has implicitly
> defaulted to non-posted instead of posted. It could just be non-posted
> was what worked everywhere and Linux couldn't distinguish. Now someone
> sees we have this new posted vs. non-posted handling and can optimize
> some mappings on their platform and we have to have per arch defaults
> (like 'dma-coherent' now).

I think one of the dark secrets of MMIO is that a lot of drivers
get the posted behavior wrong by assuming that a writel() before
a spin_unlock() is protected by that unlock. This may in fact work
on many architectures but is broken on PCI and on local devices
for ARM.

Having a properly working (on non-PCI) ioremap_np() interface
would be nice here, as it could be used to document when drivers
rely on non-posted behavior, and cause the ioremap to fail when
running on architectures that don't support nonposted maps.

       Arnd

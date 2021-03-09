Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4C33259C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhCIMlv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 07:41:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhCIMlg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 07:41:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B0B36529E;
        Tue,  9 Mar 2021 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615293696;
        bh=54A2A0Kb1ZFFWRRdx3zNsT+EhwC/DJL9erZDIQNN0Tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f5aSC4o+8v3PrI4iPCVnAWgNaDDZGLK9h4Bzg7X/GabHGW4e1KC9vwMc4XJjnbjpz
         10APnc66VtVVqBKuhZD0l45AjY5/Amgeyb9EVjU3GuYvzrKdRAbui8CFkiOlmlXcTq
         Hwd/rAArocNDoY8MTTTyVLTSKEYdbZgTSBnJhIawwXoFxP22IEOfD9jiHVOmAoXizI
         mH/cUOKNXyeXuTqirGA5U/o13O/xTZ7MLZiehSwFLD4LOEsDcgKmxKnEX3Th7l4Lag
         Nofue4Gm+YIbMEpcGWDYnPOhxBjVs4KoB2CEbu/ttjT4NEa/GqK81zZ3KsvJ1oP7gk
         aL4o0jzyws89g==
Received: by mail-oi1-f169.google.com with SMTP id f3so14719832oiw.13;
        Tue, 09 Mar 2021 04:41:36 -0800 (PST)
X-Gm-Message-State: AOAM532ZJggCknAe8xDN/05dshkh5/PaXRDerObcFqKqg3y2O4JPP/px
        4nWXbrMoRTuMb3iCEOUIX/ulMk3bJ97qYGiD/ME=
X-Google-Smtp-Source: ABdhPJy6VatYtJ/swndVE4EQRIBHgRqbTjvCoS5T8FjJaiD4ljz4scReuWAj47J+nxN5H5qwFFajcOJ21lkxpBHFnHE=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr2704125oib.67.1615293695537;
 Tue, 09 Mar 2021 04:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org> <CACRpkdZd_PU-W37szfGL7J2RYWhZzXdX342vt93H7mWXdh5iHA@mail.gmail.com>
In-Reply-To: <CACRpkdZd_PU-W37szfGL7J2RYWhZzXdX342vt93H7mWXdh5iHA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 9 Mar 2021 13:41:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a104VXhPHuWaJVEw3uMEp3rSEHsFJ6w2sW4FhNjiQ2VQQ@mail.gmail.com>
Message-ID: <CAK8P3a104VXhPHuWaJVEw3uMEp3rSEHsFJ6w2sW4FhNjiQ2VQQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Hector Martin <marcan@marcan.st>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
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

On Tue, Mar 9, 2021 at 12:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Mar 8, 2021 at 10:13 PM Rob Herring <robh@kernel.org> wrote:
> > On Mon, Mar 08, 2021 at 09:29:54PM +0100, Arnd Bergmann wrote:
>
> > > This is obviously more work for the drivers, but at least it keeps
> > > the common code free of the hack while also allowing drivers to
> > > use ioremap_np() intentionally on other platforms.
> >
> > I don't agree. The problem is within the interconnect. The device and
> > its driver are unaware of this.
>
> If it is possible that a driver needs to use posted access on one
> SoC and nonposted on another SoC then clearly the nature
> of the access need to be part of the memory access abstraction,
> obviously ioremap() one way or another.

There are two possible scenarios:

- drivers that we already know are shared between apple and
  other vendors (s3c-serial, pasemi i2c) would need to use
  nonposted mmio on Apple but can use either one on other
  platforms. On non-ARM CPUs, the ioremap_np() function
  might fail when the hardware only supports posted writes.

- A driver writer may want to choose between posted and
  nonposted mmio based on performance considerations:
  if writes are never serialized, posted writes should always
  be faster. However, if the driver uses a spinlock to serialize
  writes, then a nonposted write is likely faster than a posted
  write followed by a read that serializes the spin_unlock.
  In this case we want the driver to explicitly pick one over
  the other, and not have rely on bus specific magic.

> Having the driver conditionally use different ioremap_*
> functions depending on SoC seems awkward. We had different
> execution paths for OF and ACPI drivers and have been working
> hard to create fwnode to abstract this away for drivers used with
> both abstractions for example. If we can hide it from drivers
> from day 1 I think we can save maintenance costs in the long
> run.
>
> Given that the Apple silicon through it's heritage from Samsung
> S3C (the genealogy is unclear to me) already share drivers with
> this platform, this seems to already be the case so it's not a
> theoretical use case.

As far as I can tell, there are only a handful of soc specific drivers
that are actually shared with other platforms. Aside from serial
and i2c, these are the ones that I can see being shared:

- there is an on-chip nvme host controller that is not PCI. So far,
  nobody else does this, but it can clearly happen in the future

- I think one of the USB controllers is a standard designware
  part, while the others are PCI devices.

- The PCI host bridge may be close enough to the standard
   that we can use the generic driver for config space access.

        Arnd

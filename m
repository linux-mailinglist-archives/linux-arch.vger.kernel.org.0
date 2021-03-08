Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BEB331923
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCHVNT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 16:13:19 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:46173 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhCHVNK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 16:13:10 -0500
Received: by mail-il1-f178.google.com with SMTP id i18so10144329ilq.13;
        Mon, 08 Mar 2021 13:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fcnQ1fWh7dOXc0nPHKWRY8Kcn+PjLMVIQs7p6M7RJ6g=;
        b=k8eKLvKlIrp4di+2vK8We8o4d/eLNOhj8iy4X+MkoEech2rw6IYludZS7yWxJ/t8kQ
         gviEk5e/89CM2RtpklnEgPJ9iEZjCp9zp1bC67uSAHfKezRJuwoYimIQRI6sjV7bCWtO
         x//L4Qig2Flot1vpN4bSioV54HUq3NNo2aDyujUn9Bf1ajfa5+DoE6mipjbrdioqFITL
         jBxkHQncA49Hx1tQkktgnDAOEJoVbp5auuwPpmMv66EnmNxE6ZpC1D1e4fvPXF/OrGlG
         IuAmTBV+gWLLGiNm3zD+rXuc6SxFIKVJLrn+rG1rhLjoFz+8IsSP61xGXLMRpRj1uyuP
         PbEA==
X-Gm-Message-State: AOAM53388g29eQM1nf9/cFQR8hpmRAjX3i6SAx1gvmS+gv0uvadv6LWS
        +wbQYKcF7277DDXC29zfvmoZViUXHw==
X-Google-Smtp-Source: ABdhPJzNitNxfehHw+/PqMAXOmV3ukxp5cvqiLWmITbiKKGn5+NdeNlMiHouIx+cCiR+8uCl4Qckyw==
X-Received: by 2002:a92:4a10:: with SMTP id m16mr23016369ilf.240.1615237989913;
        Mon, 08 Mar 2021 13:13:09 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g14sm6506236ioc.38.2021.03.08.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:13:09 -0800 (PST)
Received: (nullmailer pid 2965493 invoked by uid 1000);
        Mon, 08 Mar 2021 21:13:06 -0000
Date:   Mon, 8 Mar 2021 14:13:06 -0700
From:   Rob Herring <robh@kernel.org>
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
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
Message-ID: <20210308211306.GA2920998@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st>
 <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 08, 2021 at 09:29:54PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 8, 2021 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Mar 5, 2021 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Fri, Mar 5, 2021 at 7:18 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > > > > What's the code path using these functions on the M1 where we need to
> > > > > return 'posted'? It's just downstream PCI mappings (PCI memory space),
> > > > > right? Those would never hit these paths because they don't have a DT
> > > > > node or if they do the memory space is not part of it. So can't the
> > > > > check just be:
> > > > >
> > > > > bool of_mmio_is_nonposted(struct device_node *np)
> > > > > {
> > > > >      return np && of_machine_is_compatible("apple,arm-platform");
> > > > > }
> > > >
> > > > Yes; the implementation was trying to be generic, but AIUI we don't need
> > > > this on M1 because the PCI mappings don't go through this codepath, and
> > > > nothing else needs posted mode. My first hack was something not too
> > > > unlike this, then I was going to get rid of apple,arm-platform and just
> > > > have this be a generic mechanism with the properties, but then we added
> > > > the optimization to not do the lookups on other platforms, and now we're
> > > > coming full circle... :-)
> > >
> > > I never liked the idea of having a list of platforms that need a
> > > special hack, please let's not go back to that.
> >
> > I'm a fan of generic solutions as much as anyone, but not when there's
> > a single user. Yes, there could be more, but we haven't seen any yet
> > and Apple seems to have a knack for doing special things. I'm pretty
> > sure posted vs. non-posted has been a possibility with AXI buses from
> > the start, so it's not like this is a new thing we're going to see
> > frequently on new platforms.
> 
> Ok, but if we make it a platform specific bit, I would prefer not
> to do the IORESOURCE_MEM_NONPOSTED flag either but
> instead keep the logic in the device drivers that call ioremap().

That seems like an orthogonal decision to me.

> This is obviously more work for the drivers, but at least it keeps
> the common code free of the hack while also allowing drivers to
> use ioremap_np() intentionally on other platforms.

I don't agree. The problem is within the interconnect. The device and 
its driver are unaware of this.

The other idea I had was doing a compatible other than 'simple-bus' for 
the bus node which could imply non-posted io and any other quirks in 
Apple's bus implementation. However, something different there means 
updates in lots of places (schemas, dtc checks, etc.) unless we kept 
'simple-bus' as a fallback.

Let's just stick with 'nonposted-mmio', but drop 'posted-mmio'. I'd 
rather know if and when we need 'posted-mmio'. It does need to be added 
to the DT spec[1] and schema[2] though (GH PRs are fine for both).

> > The other situation I worry about here is another arch has implicitly
> > defaulted to non-posted instead of posted. It could just be non-posted
> > was what worked everywhere and Linux couldn't distinguish. Now someone
> > sees we have this new posted vs. non-posted handling and can optimize
> > some mappings on their platform and we have to have per arch defaults
> > (like 'dma-coherent' now).
> 
> I think one of the dark secrets of MMIO is that a lot of drivers
> get the posted behavior wrong by assuming that a writel() before
> a spin_unlock() is protected by that unlock. This may in fact work
> on many architectures but is broken on PCI and on local devices
> for ARM.
> 
> Having a properly working (on non-PCI) ioremap_np() interface
> would be nice here, as it could be used to document when drivers
> rely on non-posted behavior, and cause the ioremap to fail when
> running on architectures that don't support nonposted maps.

Good to know.

Rob

[1] https://github.com/devicetree-org/devicetree-specification
[2] https://github.com/devicetree-org/dt-schema

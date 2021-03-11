Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70FE3378C6
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 17:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhCKQIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 11:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234251AbhCKQHy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Mar 2021 11:07:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 324B064FE0;
        Thu, 11 Mar 2021 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615478873;
        bh=pXOvTZ1IokKP8QFCkV6oDbP4OXAUL6e86ROIq5Qy/N4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rZMT6a200ZkKFIlC64Y95Lh3CoGbWKVA2aLSJkPb2X6OXLMM0NAuzEyiJxE5qtz6Q
         2x3xdSfRZ0/MgYjjuEM0VymM6kzq8k6XmaRcfps/Rki3AC8up5cTQyG5u1XC6gUdYJ
         1PfVCUvGYd1A9vvqVkt1HwbCfRdHz2fhLyTY091zzEOsWSKKhvPdBVEWOFCm5u0o6r
         V2NGMQ9BkbxtETNLle012GrRgOvuiN0rFIW5pocXoXxLRSv26uwvdRdPpUXFKs2e2P
         jIvGl9CCnf1te4crIJSI1VPWMomudF01F835zyKfB/N5UDaieiPZNoKX2Ulm23vE0S
         Pby9egD1kUo4Q==
Received: by mail-ed1-f45.google.com with SMTP id o19so3567770edc.3;
        Thu, 11 Mar 2021 08:07:53 -0800 (PST)
X-Gm-Message-State: AOAM530HGztStma8XYK1lQkj9QiG8zjRmmbjIqAk5+8njKTjP7sab/VV
        cC9Y8MOFRDrekNuz0YUN2QbygHt7x9zZRNhFMw==
X-Google-Smtp-Source: ABdhPJwh0zy/AA3dwvHP0ss4e/UZQzkR+M2OyHWosMY+syFfm3IVTHTSFDCDiietVvYSjMrWkrCPxF9N6Z9+zN2q05g=
X-Received: by 2002:aa7:d385:: with SMTP id x5mr9353487edq.289.1615478871516;
 Thu, 11 Mar 2021 08:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org> <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
 <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
 <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st> <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
 <332c0b9a-dcfd-4c3b-9038-47cbda90eb3f@marcan.st> <CAL_Jsq+X7JPm-xrxmy5bGKSuLO59yk6S=EuXmdMn0FwhpZAD7A@mail.gmail.com>
 <CAK8P3a2HWbHc-aGHk792TVh6ea2j+aKswYrB6EBsjPA6fH1=xA@mail.gmail.com>
In-Reply-To: <CAK8P3a2HWbHc-aGHk792TVh6ea2j+aKswYrB6EBsjPA6fH1=xA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Mar 2021 09:07:39 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKYpsXKvcw7xbbYx6z7Cg3P9DxcpLUnOG+m0xeSRO7v_g@mail.gmail.com>
Message-ID: <CAL_JsqKYpsXKvcw7xbbYx6z7Cg3P9DxcpLUnOG+m0xeSRO7v_g@mail.gmail.com>
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

On Thu, Mar 11, 2021 at 2:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 6:01 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Mar 10, 2021 at 1:27 AM Hector Martin <marcan@marcan.st> wrote:
> > >
> > > On 10/03/2021 07.06, Rob Herring wrote:
> > > >> My main concern here is that this creates an inconsistency in the device
> > > >> tree representation that only works because PCI drivers happen not to
> > > >> use these code paths. Logically, having "nonposted-mmio" above the PCI
> > > >> controller would imply that it applies to that bus too. Sure, it doesn't
> > > >> matter for Linux since it is ignored, but this creates an implicit
> > > >> exception that PCI buses always use posted modes.
> > > >
> > > > We could be stricter that "nonposted-mmio" must be in the immediate
> > > > parent. That's kind of in line with how addressing already works.
> > > > Every level has to have 'ranges' to be an MMIO address, and the
> > > > address cell size is set by the immediate parent.
> > > >
> > > >> Then if a device comes along that due to some twisted fabric logic needs
> > > >> nonposted nGnRnE mappings for PCIe (even though the actual PCIe ops will
> > > >> end up posted at the bus anyway)... how do we represent that? Declare
> > > >> that another "nonposted-mmio" on the PCIe bus means "no, really, use
> > > >> nonposted mmio for this"?
> > > >
> > > > If we're strict, yes. The PCI host bridge would have to have "nonposted-mmio".
> > >
> > > Works for me; then let's just make it non-recursive.
> > >
> > > Do you think we can get rid of the Apple-only optimization if we do
> > > this? It would mean only looking at the parent during address
> > > resolution, not recursing all the way to the top, so presumably the
> > > performance impact would be quite minimal.
>
> Works for me.
>
> > Yeah, that should be fine. I'd keep an IS_ENABLED() config check
> > though. Then I'll also know if anyone else needs this.
>
> Ok, makes sense.
>
> Conceptually, I'd like to then see a check that verifies that the
> property is only set for nodes whose parent also has it set, since
> that is how AXI defines it: A bus can wait for the ack from its
> child node, or it can acknowledge the write to its parent early.
> However, this breaks down as soon as a bus does the early ack:
> all its children by definition use posted writes (as seen by the
> CPU), even if they wait for stores that come from other masters.
>
> Does this make sense to you?

BTW, I don't think it's clear in this thread, but the current
definition proposed for the spec[1] and schema is 'nonposted-mmio' is
specific to 'simple-bus'. I like this restriction and we can expand
where 'nonposted-mmio' is allowed later if needed.

It's possible to express in json-schema, but I think it wouldn't be
pretty. Json-schema is not great for expressing inter-property
constraints and it gets worse if we're talking inter-node constraints.
I'd like to define a way to do python snippets of code for something
like this, but that's way down on the wish list.

Rob

[1] https://github.com/devicetree-org/devicetree-specification/pull/40

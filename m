Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29753389E9
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 11:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhCLKUe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 05:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233158AbhCLKUU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 05:20:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36AA265014;
        Fri, 12 Mar 2021 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615544420;
        bh=Ifsr9yM9IkQPwSwMx+ywHOlUP37f5ulHyfp022mvO2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OeFAX9kP3QepFXQNlgoNBt/rCJK6ttlPb2z66g1Fm9rBpVgFrq/J8kdQjGgUsInD4
         gufTH3sTe9dQr7Dv3m1+s38h6IxRmnl+E95aqXEnsDLBUvAp6tR8rtqUgKcqpjxqp2
         /PLNgpAvUkhC6Nro80THrKr0uqEtcFagUQuiAA0MxjNvaSxWM5vILNol9qLy+s28F6
         J+T1KgsOG6jMO3vUye9dOowxxCxt5qUUjvK/5fFSPtD4TT0Oc8cjHH1n0ypjxeC82d
         7Bak7Zg5DjTXfZcRczfdSQNNgm2GdpCsxPAV6Z1gx+V3gwNXNzj3L7oBFGUwlhPO3w
         6fsJIXl0X2yqA==
Received: by mail-oo1-f43.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so1042119ool.0;
        Fri, 12 Mar 2021 02:20:20 -0800 (PST)
X-Gm-Message-State: AOAM533k97eGVayFQI6keYBO7LQKA/Fe9Aiu0lnA2lImthZVNwReb6d2
        edS4zM+Glo2wjHxtQLGRnW6k0jzghbcXCLlQ/9k=
X-Google-Smtp-Source: ABdhPJyxJbTVd+9o1L3Cm7RfyBDoKQYmHOnVheMTVTvF/CCztalbxCtJGX/FPRh6wEI0bbDfWUx947MungyzyrTvGEI=
X-Received: by 2002:a4a:e9a2:: with SMTP id t2mr2692533ood.15.1615544419338;
 Fri, 12 Mar 2021 02:20:19 -0800 (PST)
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
 <CAL_JsqKYpsXKvcw7xbbYx6z7Cg3P9DxcpLUnOG+m0xeSRO7v_g@mail.gmail.com>
 <CAK8P3a2iASEZf-YRh2SHYhNdUtpo8sdkuoxfk_MonXpXBk1kbg@mail.gmail.com> <CAL_JsqK200WcxD3PP1FToc5w2dyF3b6TYnf2oNd9Mpz77g68og@mail.gmail.com>
In-Reply-To: <CAL_JsqK200WcxD3PP1FToc5w2dyF3b6TYnf2oNd9Mpz77g68og@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Mar 2021 11:20:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3-aLCzWnGv0LPb3KPs_cUy6DXrz3QV5x7aNOU2Zi_48g@mail.gmail.com>
Message-ID: <CAK8P3a3-aLCzWnGv0LPb3KPs_cUy6DXrz3QV5x7aNOU2Zi_48g@mail.gmail.com>
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

On Thu, Mar 11, 2021 at 7:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 11, 2021 at 9:48 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Thu, Mar 11, 2021 at 5:10 PM Rob Herring <robh@kernel.org> wrote:
> > > On Thu, Mar 11, 2021 at 2:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > On Wed, Mar 10, 2021 at 6:01 PM Rob Herring <robh@kernel.org> wrote:
> > > > Ok, makes sense.
> > > >
> > > > Conceptually, I'd like to then see a check that verifies that the
> > > > property is only set for nodes whose parent also has it set, since
> > > > that is how AXI defines it: A bus can wait for the ack from its
> > > > child node, or it can acknowledge the write to its parent early.
> > > > However, this breaks down as soon as a bus does the early ack:
> > > > all its children by definition use posted writes (as seen by the
> > > > CPU), even if they wait for stores that come from other masters.
> > > >
> > > > Does this make sense to you?
> > >
> > > BTW, I don't think it's clear in this thread, but the current
> > > definition proposed for the spec[1] and schema is 'nonposted-mmio' is
> > > specific to 'simple-bus'. I like this restriction and we can expand
> > > where 'nonposted-mmio' is allowed later if needed.
> >
> > That sounds ok, as long as we can express everything for the mac
> > at the moment. Do we need to explicitly add a description to allow
> > the property in the root node in addition to simple-bus to be able
> > to enforce the rule about parent buses also having it?
>
> IMO it should not be allowed in the root node. That's a failure to
> define a bus node.

My interpretation would be that the root node defines the first bus
connected to the CPU(s) themselves, which may already have
posted writes. If writes on that bus are posted, then no child could
be non-posted.

I suppose it depends a bit on the mental model of what the nodes
refer to. If you say that there cannot be a device with registers
directly on the root node, but every bus defines its own space,
then we don't need this, but I think a lot of machines would break
if you try to enforce the rule that there cannot be devices on
the root node.

> Also, would that mean your memory has to be non-posted!?

Good question. You could argue that this should not be because you
don't want to use ioremap_np() flags but instead want this to be
normal cacheable memory instead of device memory.

On the other hand, you definitely don't want memory stores to be
posted, as that would break coherency between the CPUs when
a wmb() no longer has an effect.

       Arnd

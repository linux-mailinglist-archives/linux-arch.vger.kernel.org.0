Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB562337418
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhCKNfp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 08:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhCKNfX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Mar 2021 08:35:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C174464FF5;
        Thu, 11 Mar 2021 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615469722;
        bh=6q4IiXUJWgYscOCHecS9Mt3djdFy8TY6aKd4onYASzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqYI40kpdj9pTyDaevY8Rj3aeYiZ42jbr3bj19Mi76nRVXy04kZ924TdIsyUPe5nI
         kVHCtANhj9MAOhAsi4EcR9R2xtU4MvIMQr7ZTEzzjdilqv+4kCNlORUhtjd8pMR2TR
         a5HSjhZpsqZyxNzVFKbM1y69DNNfFHM24NsdO67YBiYrU14vwxDLEm6ecS2AiOzBc9
         4SaZgpwGtDHuQC9aKCe8UCl1mVfahUsXDBZvkbTfyKbiCpAGeKylgMr9UdZ6gr8xb+
         GjGi8i8c01jNVRFO8iKW48+xTZ+NV+BcVcnm/aJ83vcD+4RmlPuxgYInkS79eYQnk7
         IxUX0bVdkDD8A==
Received: by mail-oi1-f174.google.com with SMTP id u198so18155082oia.4;
        Thu, 11 Mar 2021 05:35:22 -0800 (PST)
X-Gm-Message-State: AOAM532+Ces9QDIaU/LU6w45qWc3ktC+O6h9xmA/qhDkN8dL6z/uTpDG
        dr3KBk9UwQU3d5GwGf+egq8FbHrimebEd9Ewrps=
X-Google-Smtp-Source: ABdhPJxVF0HenIu8QBC6I7NhfOa4G3V0f41d1dKsWotCdWeJNJpyBNdwAHcVht7bLnu5j10LoEjZUejMgModqVzmgxA=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr6048962oib.67.1615469721794;
 Thu, 11 Mar 2021 05:35:21 -0800 (PST)
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
 <CAK8P3a2HWbHc-aGHk792TVh6ea2j+aKswYrB6EBsjPA6fH1=xA@mail.gmail.com> <7ee4a1ac-9fd4-3eca-853d-d12a16ddbb60@marcan.st>
In-Reply-To: <7ee4a1ac-9fd4-3eca-853d-d12a16ddbb60@marcan.st>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 11 Mar 2021 14:35:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1-7nybm5kRVN6WP-+0vy+TWzqHJsMXwz8QtH2jhW+1gQ@mail.gmail.com>
Message-ID: <CAK8P3a1-7nybm5kRVN6WP-+0vy+TWzqHJsMXwz8QtH2jhW+1gQ@mail.gmail.com>
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

On Thu, Mar 11, 2021 at 1:11 PM Hector Martin <marcan@marcan.st> wrote:
> On 11/03/2021 18.12, Arnd Bergmann wrote:
> > On Wed, Mar 10, 2021 at 6:01 PM Rob Herring <robh@kernel.org> wrote:
> >> On Wed, Mar 10, 2021 at 1:27 AM Hector Martin <marcan@marcan.st> wrote:
> >>> Works for me; then let's just make it non-recursive.
> >>>
> >>> Do you think we can get rid of the Apple-only optimization if we do
> >>> this? It would mean only looking at the parent during address
> >>> resolution, not recursing all the way to the top, so presumably the
> >>> performance impact would be quite minimal.
> >
> > Works for me.
>
> Incidentally, even though it would now be unused, I'd like to keep the
> apple,arm-platform compatible at this point; we've already been pretty
> close to a use case for it, and I don't want to have to fall back to a
> list of SoC compatibles if we ever need another quirk for all Apple ARM
> SoCs (or break backwards compat). It doesn't really hurt to have it in
> the binding and devicetrees, right?

Yes, keeping the compatible string is a good idea regardless.

> >> Yeah, that should be fine. I'd keep an IS_ENABLED() config check
> >> though. Then I'll also know if anyone else needs this.
> >
> > Ok, makes sense.
> >
> > Conceptually, I'd like to then see a check that verifies that the
> > property is only set for nodes whose parent also has it set, since
> > that is how AXI defines it: A bus can wait for the ack from its
> > child node, or it can acknowledge the write to its parent early.
> > However, this breaks down as soon as a bus does the early ack:
> > all its children by definition use posted writes (as seen by the
> > CPU), even if they wait for stores that come from other masters.
> >
> > Does this make sense to you?
>
> Makes sense. This shouldn't really be something the kernel concerns
> itself with at runtime, just something for the dts linting, right?
>
> I assume this isn't representable in json-schema, so it would presumably
> need some ad-hoc validation code.

Agreed, having a check in either dtc or expressed in the json scheme
is better than a runtime check. I assume Rob would know how to best
add such a check.

     Arnd

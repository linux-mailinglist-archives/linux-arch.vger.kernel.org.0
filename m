Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0509A333156
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhCIWGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 17:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCIWG0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 17:06:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD71165092;
        Tue,  9 Mar 2021 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615327585;
        bh=Yv8N+lvXzeDwu/BV9QWlF/ECq72HLpbo3iSHF+ZDqfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b9PbhBz+g4RuhQnFFoZGqEnaAdoqx/n8ibHQd9UksEzDN3OCX8g8VaguKgjXoL8J9
         aK9u69eyvc/BWTuwS8lIYuYCkHy59HLZXXgXNYp9FjDiau6yjAt2HeUm+013Kw5Je2
         fOmbG/pfsOiHIO87xqtO5925x7LNyMkFRL8jPM+CqOD5WKNM8wZsVtU+E/xPq3BAgh
         yD6Xj9V9NiRiYM65qk/6iUIk20/73ihjOCansOlQuZAZb99W+QpfrcANFglpfGkGoK
         O/oUo6ct+GlE7wJQiPrS/ZXY9h2uDPHBVRRnlHVtGMPgVJlSGmB+yRs1lzMXstoZju
         IJg8ssOyCZa/A==
Received: by mail-qv1-f54.google.com with SMTP id x13so7242173qvj.7;
        Tue, 09 Mar 2021 14:06:25 -0800 (PST)
X-Gm-Message-State: AOAM532qu2xyOXoypO2VVCZQqxMgebdhYqG4qhMXKNL4yOgMSpEUqAyY
        1Iu+rWriPgAtHc2G/20/myanriqS9kdq89tdVw==
X-Google-Smtp-Source: ABdhPJy1C6AzP09b9wus1ZVT5E/CtXLEugZNjwqSvxHP9P4lOiRLRzFWXQ3jpvPXSnSw2MikeoWzpKJ2j9KJLzk621o=
X-Received: by 2002:a0c:f092:: with SMTP id g18mr201509qvk.11.1615327584670;
 Tue, 09 Mar 2021 14:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org> <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
 <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com> <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st>
In-Reply-To: <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 15:06:13 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
Message-ID: <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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

On Tue, Mar 9, 2021 at 1:24 PM Hector Martin <marcan@marcan.st> wrote:
>
> On 10/03/2021 00.48, Rob Herring wrote:
> > On Mon, Mar 8, 2021 at 2:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >>
> >> On Mon, Mar 8, 2021 at 10:14 PM Rob Herring <robh@kernel.org> wrote:
> >>> On Mon, Mar 08, 2021 at 09:29:54PM +0100, Arnd Bergmann wrote:
> >>>> On Mon, Mar 8, 2021 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> Let's just stick with 'nonposted-mmio', but drop 'posted-mmio'. I'd
> >>> rather know if and when we need 'posted-mmio'. It does need to be added
> >>> to the DT spec[1] and schema[2] though (GH PRs are fine for both).
> >>
> >> I think the reason for having "posted-mmio" is that you cannot properly
> >> define the PCI host controller nodes on the M1 without that: Since
> >> nonposted-mmio applies to all child nodes, this would mean the PCI
> >> memory space gets declared as nonposted by the DT, but the hardware
> >> requires it to be mapped as posted.
> >
> > I don't think so. PCI devices wouldn't use any of the code paths in
> > this patch. They would map their memory space with plain ioremap()
> > which is posted.
>
> My main concern here is that this creates an inconsistency in the device
> tree representation that only works because PCI drivers happen not to
> use these code paths. Logically, having "nonposted-mmio" above the PCI
> controller would imply that it applies to that bus too. Sure, it doesn't
> matter for Linux since it is ignored, but this creates an implicit
> exception that PCI buses always use posted modes.

We could be stricter that "nonposted-mmio" must be in the immediate
parent. That's kind of in line with how addressing already works.
Every level has to have 'ranges' to be an MMIO address, and the
address cell size is set by the immediate parent.

> Then if a device comes along that due to some twisted fabric logic needs
> nonposted nGnRnE mappings for PCIe (even though the actual PCIe ops will
> end up posted at the bus anyway)... how do we represent that? Declare
> that another "nonposted-mmio" on the PCIe bus means "no, really, use
> nonposted mmio for this"?

If we're strict, yes. The PCI host bridge would have to have "nonposted-mmio".

Rob

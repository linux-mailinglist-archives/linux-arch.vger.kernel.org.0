Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B09334493
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCJRCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 12:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233655AbhCJRB6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 12:01:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A5FA64FCA;
        Wed, 10 Mar 2021 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615395717;
        bh=5LZ7c4U4IAUXXoygU0w5CR3jOKIDBj1RXMdFN86MevM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b5q13A9vKkWPc/S2db+xOtVll5VS6u+2t6fCOQtiIUBFLLDdzVTyOI+P3UeGL+LqJ
         7Elkm2kmhr5CpRnO2X65A+H6fhh08GnA/WZocXK+qekvB2TMURd3J8UgsqR1NfmFxy
         fDonUJ45jhqpGSvmkgJUFSjgA6p0MSXOK2M6hq+6iVQgE7ghxEkPMetdhH7pMmlX+o
         cOjW0m8/LKBPl6s3lctW6O2TtGutJaNWf1VaOiJ33Nq8iQxmlrU/PpR2RsOIZkmy0D
         GyUobzwlzzFIqj7QIzHuu+VDiWYgi4SVCChUfIiVW79wRLAtbqMDYlXwptMkpZAMVn
         lloGmQa4FN/LQ==
Received: by mail-ed1-f48.google.com with SMTP id w9so29022145edt.13;
        Wed, 10 Mar 2021 09:01:57 -0800 (PST)
X-Gm-Message-State: AOAM530KCNGOc9UWduhTNmkxpbxEUUcZnZx2dKf1QRq8pCP7eaYalsLB
        e8zsS1z9pKqpMVuOCDEDipti2ju9lBMiBqrhUQ==
X-Google-Smtp-Source: ABdhPJyyjiOqDNU+GsRsusWQw6pd7IjZqC3Hzchz/EIeuYg4YBLw4UApJuUQRJ4ZYOdJ7x1nylPn+YQBn+IB+ohTiOE=
X-Received: by 2002:aa7:d3d8:: with SMTP id o24mr4394042edr.165.1615395715853;
 Wed, 10 Mar 2021 09:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org> <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
 <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
 <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st> <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
 <332c0b9a-dcfd-4c3b-9038-47cbda90eb3f@marcan.st>
In-Reply-To: <332c0b9a-dcfd-4c3b-9038-47cbda90eb3f@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Mar 2021 10:01:43 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+X7JPm-xrxmy5bGKSuLO59yk6S=EuXmdMn0FwhpZAD7A@mail.gmail.com>
Message-ID: <CAL_Jsq+X7JPm-xrxmy5bGKSuLO59yk6S=EuXmdMn0FwhpZAD7A@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 1:27 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 10/03/2021 07.06, Rob Herring wrote:
> >> My main concern here is that this creates an inconsistency in the device
> >> tree representation that only works because PCI drivers happen not to
> >> use these code paths. Logically, having "nonposted-mmio" above the PCI
> >> controller would imply that it applies to that bus too. Sure, it doesn't
> >> matter for Linux since it is ignored, but this creates an implicit
> >> exception that PCI buses always use posted modes.
> >
> > We could be stricter that "nonposted-mmio" must be in the immediate
> > parent. That's kind of in line with how addressing already works.
> > Every level has to have 'ranges' to be an MMIO address, and the
> > address cell size is set by the immediate parent.
> >
> >> Then if a device comes along that due to some twisted fabric logic needs
> >> nonposted nGnRnE mappings for PCIe (even though the actual PCIe ops will
> >> end up posted at the bus anyway)... how do we represent that? Declare
> >> that another "nonposted-mmio" on the PCIe bus means "no, really, use
> >> nonposted mmio for this"?
> >
> > If we're strict, yes. The PCI host bridge would have to have "nonposted-mmio".
>
> Works for me; then let's just make it non-recursive.
>
> Do you think we can get rid of the Apple-only optimization if we do
> this? It would mean only looking at the parent during address
> resolution, not recursing all the way to the top, so presumably the
> performance impact would be quite minimal.

Yeah, that should be fine. I'd keep an IS_ENABLED() config check
though. Then I'll also know if anyone else needs this.

Rob

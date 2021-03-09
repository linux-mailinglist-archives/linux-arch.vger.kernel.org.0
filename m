Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C382A332AFF
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 16:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhCIPsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 10:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhCIPsb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 10:48:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83B2F6525F;
        Tue,  9 Mar 2021 15:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615304910;
        bh=BHEDDhLgphZzaj7IBNRHUe5wpWfdaAtzCDRMEm59Td4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WV8BkwWZHuegaK421aKCzu65nlfF3NR1LiCQEch1R/BhBMgYtEAKwqpqZ0oAa0FKU
         Vqnu4Lz1RgfkGn+3MfHh1WU1PopTrZjaEjtv68Ryzzkf0H2cJuwcLBomHX4MCrsLNi
         Lpi1WH1M6jxsHhhih0memdEl5dnmxjx/ffZJGrYTxDeK8DIetC14jnHXQNGbrntNC4
         uTU1k+WXl9F4whkRJxEj5pqibQKgz9Q4/T9TcnVILkLUDkWciHGdYl+tkL0x392xml
         uMblIyAk3vLeG1w/tHr+xlhyHF6qT+PYGYh9Ravu3dih1d3RAnDrIV9imALbVrDSKN
         W+73kDyiaZI3A==
Received: by mail-ed1-f48.google.com with SMTP id dm26so21029195edb.12;
        Tue, 09 Mar 2021 07:48:30 -0800 (PST)
X-Gm-Message-State: AOAM532Z53VYnE0rCbCVfuxALHWJi7FvBYrIkKbiH0Ar1Y81PrScTMbU
        DKCNeLJkeaH897DPdhciT1bZJxEFIUzZL+wv3w==
X-Google-Smtp-Source: ABdhPJxV5XCnS45TAr4+B2+ig1cxhxtG4MMbYqVXoYfVd4hAqlaPl8H/s/yCm4qWvnmTnSV0ZHH3LccBzcWQZpWr2JY=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr4880507edb.62.1615304909030;
 Tue, 09 Mar 2021 07:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org> <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
In-Reply-To: <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 08:48:17 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
Message-ID: <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
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

On Mon, Mar 8, 2021 at 2:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Mar 8, 2021 at 10:14 PM Rob Herring <robh@kernel.org> wrote:
> > On Mon, Mar 08, 2021 at 09:29:54PM +0100, Arnd Bergmann wrote:
> > > On Mon, Mar 8, 2021 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Let's just stick with 'nonposted-mmio', but drop 'posted-mmio'. I'd
> > rather know if and when we need 'posted-mmio'. It does need to be added
> > to the DT spec[1] and schema[2] though (GH PRs are fine for both).
>
> I think the reason for having "posted-mmio" is that you cannot properly
> define the PCI host controller nodes on the M1 without that: Since
> nonposted-mmio applies to all child nodes, this would mean the PCI
> memory space gets declared as nonposted by the DT, but the hardware
> requires it to be mapped as posted.

I don't think so. PCI devices wouldn't use any of the code paths in
this patch. They would map their memory space with plain ioremap()
which is posted.

Rob

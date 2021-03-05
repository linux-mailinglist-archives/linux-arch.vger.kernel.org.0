Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4D32EF5F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCEPvr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCEPv0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 10:51:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 763CE65098;
        Fri,  5 Mar 2021 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614959485;
        bh=xaeKME6Ua+2h67Q5RJolMrcXStqSWyB8CTRElNWIdNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rRBl/eyvNDoud0LUtrcLX3ZHlvFGYju9nRGC39q3t+sL/avqv7YMNUYtgGz+64bC4
         ba8t52YZcQZP3AD6bZ40jv96cX+sdGEI0xEQY69Fbif8/ZX1LK24REnFh0qun1HSu0
         5IczDBfK5rRw7HW1wAcDu2AahDGioeTqPBOqmZTXY20PjFiFwdylWietKbwwJKWI9O
         Uk8JbPVhPc8ueXo/5GNzJcCWtvuK07/7q06/fB7srsrwWAEMz62zIBsYjdlgx7dQU9
         7StWGQz91kPVR5yitBRxn8gdnBYy3vcdj8DLTrS8breER6uZJnWc2M72edeVGicex9
         VEiPkVgxaxidQ==
Received: by mail-ot1-f44.google.com with SMTP id j8so2244956otc.0;
        Fri, 05 Mar 2021 07:51:25 -0800 (PST)
X-Gm-Message-State: AOAM5326SrXlvMIBpYRMXBOye3ZeFynQj4E8mh7z7mkwHAadR9s876Cu
        wzR+KylaFjbfe9TeKm4xa09dUXKqy3CUkBcPyvY=
X-Google-Smtp-Source: ABdhPJy9oV+4qLl47P+rrukasKtK8n7azdZjxa8hAXJBGcPPcFGMLNqAWqsBN3UFc1UFX0r7zYKKwNbJzSCj+keSlF4=
X-Received: by 2002:a9d:12e1:: with SMTP id g88mr5226195otg.305.1614959484753;
 Fri, 05 Mar 2021 07:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-11-marcan@marcan.st>
 <CACRpkdYeeUb6WUe_RBxBEjNnTJ9o55Z-8Ma7CLokFOdCtF0M+Q@mail.gmail.com> <CAHp75VfEshraJMUfmCNvMgm5yVRNLk-yDkbJ+6m6NuLV4tme7g@mail.gmail.com>
In-Reply-To: <CAHp75VfEshraJMUfmCNvMgm5yVRNLk-yDkbJ+6m6NuLV4tme7g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 5 Mar 2021 16:51:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a20yXBktB_QqgqgSP69-PXnfs1AwNOf01v-DYFWktmRYQ@mail.gmail.com>
Message-ID: <CAK8P3a20yXBktB_QqgqgSP69-PXnfs1AwNOf01v-DYFWktmRYQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 10/27] docs: driver-api: device-io: Document
 ioremap() variants & access funcs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 5, 2021 at 4:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 5, 2021 at 12:25 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > > This documents the newly introduced ioremap_np() along with all the
> > > other common ioremap() variants, and some higher-level abstractions
> > > available.
> > >
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> >
> > I like this, I just want one change:
> >
> > Put the common ioremap() on top in all paragraphs, so the norm
> > comes before the exceptions.
> >
> > I.e. it is weird to mention ioremap_np() before mentioning ioremap().
>
> +1 here. That is what I have stumbled upon reading carefully.

In that case, the order should probably be:

ioremap
ioremap_wc
ioremap_wt
ioremap_np
ioremap_uc
ioremap_cache

Going from most common to least common, rather than going from
strongest to weakest.

       Arnd

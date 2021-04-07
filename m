Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321E7357675
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhDGVDf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 17:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhDGVDf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 17:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D5E6610CA;
        Wed,  7 Apr 2021 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617829405;
        bh=QazZLBnfh7mh8f3Fj68kQd7sXfjGSgTDndIHosthxL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSQCD3KSoBzBp2essdxE7F30l8Eu/UfwUFDLbXBKcCLcNFS2TuqDN2tJvw9ryqkj9
         8670l+ApuQ6VwuBNZBOy2qQeMlQgIZw7rqndfcbOfz+ZeRTnCPpNrfg8wPDQTxw35l
         ciziAvNWlZSM7xG3zZrsAyS7d4e9q81xMbFzrADvu0qdSySyHAeEsRq7VegSJc9D8o
         cTYkG21eY+5sEVgMogCjiFE+C4JFJc4acYHoNMMp1IZEqRJfNxc1RKjEbJXWsVS65R
         WNFihv7onIOI98CEYKTbGE5k7+siFsDWuFTveRXc44htKxsgAwlCa/IxTRMi8E9HIE
         jS2GSbE6ZRZOA==
Date:   Wed, 7 Apr 2021 22:03:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/18] asm-generic/io.h: implement pci_remap_cfgspace
 using ioremap_np
Message-ID: <20210407210317.GB16198@willie-the-truck>
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-12-marcan@marcan.st>
 <CAHp75Vcghw6=05vbhX5J8sHoo78JMoq5z4w9__XcocrtRVjF3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcghw6=05vbhX5J8sHoo78JMoq5z4w9__XcocrtRVjF3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 04:27:42PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 2, 2021 at 12:07 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > Now that we have ioremap_np(), we can make pci_remap_cfgspace() default
> > to it, falling back to ioremap() on platforms where it is not available.
> >
> > Remove the arm64 implementation, since that is now redundant. Future
> > cleanups should be able to do the same for other arches, and eventually
> > make the generic pci_remap_cfgspace() unconditional.
> 
> ...
> 
> > +       void __iomem *ret = ioremap_np(offset, size);
> > +
> > +       if (!ret)
> > +               ret = ioremap(offset, size);
> > +
> > +       return ret;
> 
> Usually negative conditions are worse for cognitive functions of human beings.
> (On top of that some patterns are applied)
> 
> I would rewrite above as
> 
> void __iomem *ret;
> 
> ret = ioremap_np(offset, size);
> if (ret)
>   return ret;
> 
> return ioremap(offset, size);

Looks like it might be one of those rare occasions where the GCC ternary if
extension thingy comes in handy:

	return ioremap_np(offset, size) ?: ioremap(offset, size);

but however it's done, the logic looks good to me and thanks Hector for
updating this:

Acked-by: Will Deacon <will@kernel.org>

Will

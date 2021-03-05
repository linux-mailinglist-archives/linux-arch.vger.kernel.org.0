Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFF32EE1A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhCEPOJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCEPNx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:13:53 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CBDC061574;
        Fri,  5 Mar 2021 07:13:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so2391134pfk.1;
        Fri, 05 Mar 2021 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0eleFytR2/yM+dxl23Ms8EpKkzd5tBsQkHtS/SXNX0k=;
        b=BhZwf7o+ARbMRBKOyhSfvcpfSTMGDi8E6QYOHnXlb3DIKi4CTzEOJzxP2Mdety9KY7
         9vn7+HDjtu8E8P9If2rP2c1glzgyUYFgsvAvSIZ6hA21gVR0nl1+wqZU9q5ySjoI+zgm
         MCJTjsr2Eb/I4wth2uEEh+h4cTyw4AOu5PThBSfdL5maY20PLrIJ0B7hI6u+rCh9fjVU
         h5UQXzapNPhsQWyl08uX6BQjgtAZHg9lt6OryZ3k126bvOygbf+tUGCTm+5cjOWavH3A
         +d1BihC+s+3NuFmhZDbxI0/mKzKJwVFwzLdVeBDSfAR0OQn1zSeDI5LDchdib2vG4cyy
         4raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eleFytR2/yM+dxl23Ms8EpKkzd5tBsQkHtS/SXNX0k=;
        b=p+qYy4ZXpa2arPzvzvyhoBvaqYuYjHYMMZEFZgZ77uqtxBgvHClRNYy0AgKXkkjZjh
         CT1a2R2IBzBabwwnyUjnP+KOHgV/n2GpjbhTsF8pYrhckC71AI+ecEXFFrO5C/kxQnLE
         97+R2Mi49ArSNR2E8/EvgyqMrCmsOQ6CGzyV75RT9DC6Zblx2Ge9fEgGxB6HWQpBF37I
         3zImCqGyVCewRmtzAR5RrwC22EcTTVtoIfQAQzXFhXnnCSdblqHuOuYDvfrUwcWx8BT6
         oOmC/s86l6DeekndeJMlpAT7kJN1+0tuYd4eHUsd25HN89ENXupls8YWKP1tQBhKrlvr
         A+Og==
X-Gm-Message-State: AOAM5302RmggO8HWQZh62X74r5EAJe2xNa5UuySr8fnMbgY0leZfF68i
        Fw/a9VtKcQk2Ndxmf4qsZTCSeZsw5mEKdybMvfhqawuEi424uw==
X-Google-Smtp-Source: ABdhPJy6ItIglcuderuEnfARE6d7B9METFkClRBMWOPNEjL7y8zg14IVBTva4UrBbARAxuw3VEqdm6QYPMMoBRzIK1M=
X-Received: by 2002:a63:ce15:: with SMTP id y21mr9188159pgf.4.1614957232385;
 Fri, 05 Mar 2021 07:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-13-marcan@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 17:13:36 +0200
Message-ID: <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 11:40 PM Hector Martin <marcan@marcan.st> wrote:
>
> This implements the 'nonposted-mmio' and 'posted-mmio' boolean
> properties. Placing these properties in a bus marks all child devices as
> requiring non-posted or posted MMIO mappings. If no such properties are
> found, the default is posted MMIO.
>
> of_mmio_is_nonposted() performs the tree walking to determine if a given
> device has requested non-posted MMIO.
>
> of_address_to_resource() uses this to set the IORESOURCE_MEM_NONPOSTED
> flag on resources that require non-posted MMIO.
>
> of_iomap() and of_io_request_and_map() then use this flag to pick the
> correct ioremap() variant.
>
> This mechanism is currently restricted to Apple ARM platforms, as an
> optimization.

...

> @@ -896,7 +899,10 @@ void __iomem *of_iomap(struct device_node *np, int index)
>         if (of_address_to_resource(np, index, &res))
>                 return NULL;
>
> -       return ioremap(res.start, resource_size(&res));
> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> +               return ioremap_np(res.start, resource_size(&res));
> +       else
> +               return ioremap(res.start, resource_size(&res));

This doesn't sound right. Why _np is so exceptional? Why don't we have
other flavours (it also rings a bell to my previous comment that the
flag in ioresource is not in the right place)?

...

> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> +               mem = ioremap_np(res.start, resource_size(&res));
> +       else
> +               mem = ioremap(res.start, resource_size(&res));
> +

Ditto.

...

> +       while (node) {
> +               if (!of_property_read_bool(node, "ranges")) {
> +                       break;
> +               } else if (of_property_read_bool(node, "nonposted-mmio")) {
> +                       of_node_put(node);
> +                       return true;
> +               } else if (of_property_read_bool(node, "posted-mmio")) {
> +                       break;
> +               }
> +               parent = of_get_parent(node);
> +               of_node_put(node);
> +               node = parent;
> +       }

I believe above can be slightly optimized. Don't we have helpers to
traverse to all parents?

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37C532EF98
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhCEQFt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhCEQFW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 11:05:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B7365092;
        Fri,  5 Mar 2021 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614960322;
        bh=ChyQh3jUOf3mpcLiwmUiTp3mAW4ljibFzKZwZJvYMcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TaVWfxx4/vllC7hR6YYISHmND4Na36dmQm1N7qtCjMqLrOljM3V4QVNTIJr2Q7MzX
         8Mdq1njeGpl00EUjSWfKgk5KOmIoNd0BIGbuZx6U1oQY5+7DU3KGWUeiSta1GOHZAl
         zw2h4zndDgOaeFsFrI+v6I6ZmRks5IiVdtT7YjuYcN/MMibqGV+QqWudpCusRoVN7J
         r5cf4v/UlOh/381LqQhLzLxmPZmenrTNwALp3rDJ7ju/rTDDGShcgc7RTz2M7QwwOx
         YxCJDPqhTkDLQEKTNEHtEKofYboTBlMvJsV99zUz6QESINCFUmHsgfFInqmtFsiDtf
         +KbobAmBDhlNg==
Received: by mail-ej1-f46.google.com with SMTP id w1so4440407ejf.11;
        Fri, 05 Mar 2021 08:05:22 -0800 (PST)
X-Gm-Message-State: AOAM531weEzW8sJSNcbA8txXXKYvQDTDEA+25tJjnHAgHdV9McM5OVoE
        ObExncvd6cKulToQG/AmAzCXCZYpCRdXU1WxVA==
X-Google-Smtp-Source: ABdhPJwUc4XxP2OrKgKoWP3l/xIeHgoelPjOuT9cmvaXTMfKex+qDw3goxqSBhbjX88yTcUVjAFeGozCqyLLXTE1hAc=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr2843037ejz.341.1614960320807;
 Fri, 05 Mar 2021 08:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
In-Reply-To: <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 5 Mar 2021 10:05:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJsYMUpzH-2kEjQ-bDYAcxAB5Jgjp-2awjs3z00f3Gs+Q@mail.gmail.com>
Message-ID: <CAL_JsqJsYMUpzH-2kEjQ-bDYAcxAB5Jgjp-2awjs3z00f3Gs+Q@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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

On Fri, Mar 5, 2021 at 9:13 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Mar 4, 2021 at 11:40 PM Hector Martin <marcan@marcan.st> wrote:
> >
> > This implements the 'nonposted-mmio' and 'posted-mmio' boolean
> > properties. Placing these properties in a bus marks all child devices as
> > requiring non-posted or posted MMIO mappings. If no such properties are
> > found, the default is posted MMIO.
> >
> > of_mmio_is_nonposted() performs the tree walking to determine if a given
> > device has requested non-posted MMIO.
> >
> > of_address_to_resource() uses this to set the IORESOURCE_MEM_NONPOSTED
> > flag on resources that require non-posted MMIO.
> >
> > of_iomap() and of_io_request_and_map() then use this flag to pick the
> > correct ioremap() variant.
> >
> > This mechanism is currently restricted to Apple ARM platforms, as an
> > optimization.
>
> ...
>
> > @@ -896,7 +899,10 @@ void __iomem *of_iomap(struct device_node *np, int index)
> >         if (of_address_to_resource(np, index, &res))
> >                 return NULL;
> >
> > -       return ioremap(res.start, resource_size(&res));
> > +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> > +               return ioremap_np(res.start, resource_size(&res));
> > +       else
> > +               return ioremap(res.start, resource_size(&res));
>
> This doesn't sound right. Why _np is so exceptional? Why don't we have
> other flavours (it also rings a bell to my previous comment that the
> flag in ioresource is not in the right place)?
>
> ...
>
> > +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> > +               mem = ioremap_np(res.start, resource_size(&res));
> > +       else
> > +               mem = ioremap(res.start, resource_size(&res));
> > +
>
> Ditto.
>
> ...
>
> > +       while (node) {
> > +               if (!of_property_read_bool(node, "ranges")) {
> > +                       break;
> > +               } else if (of_property_read_bool(node, "nonposted-mmio")) {
> > +                       of_node_put(node);
> > +                       return true;
> > +               } else if (of_property_read_bool(node, "posted-mmio")) {
> > +                       break;
> > +               }
> > +               parent = of_get_parent(node);
> > +               of_node_put(node);
> > +               node = parent;
> > +       }
>
> I believe above can be slightly optimized. Don't we have helpers to
> traverse to all parents?

We don't. I only found a handful of cases mostly in arch/powerpc.
Given that and this series is big enough already, I don't think we
need a helper as part of it. But patches welcome.

Rob

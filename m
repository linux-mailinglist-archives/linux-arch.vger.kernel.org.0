Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6794330D0A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 13:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCHMCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHMCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 07:02:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124C1C06174A;
        Mon,  8 Mar 2021 04:02:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y67so7073083pfb.2;
        Mon, 08 Mar 2021 04:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlusgLjbLKUTAaP82nwfxxVRLneDG0S3dn7MKQ5uqQM=;
        b=AC/7yM68lti9c3ma6GRYkZHCqxY18TVJx6TlAzforETOsZcAandJdLTzfFeIB6R0Rh
         SxAm7dXNu3QrnjZrpk+AWTZ7GbZ33D6VxUDP+yDUTrBy9Nk16ZlYp+rpb8eAi4+eELQF
         1etohEM3QB5MVgkpxQUh6HRyZTF6XbpOXmz/8HuhF/vJMYsJVQ+L6yeA+er1fMzMph34
         ncdkbKHGZIhvxyhLuTth5LyqOZswcZbXFl8J7asTlFnPh9x+SoxUTnCWEaLiXpeZL3lS
         q4YoZgTM5g7iv8y8FdU/VMjzze3TFl2Ic9Vrbj02f515mzYjHNTqxNn58hC8apYYJ8FF
         Iy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlusgLjbLKUTAaP82nwfxxVRLneDG0S3dn7MKQ5uqQM=;
        b=rDHntY2Mev8f+5fm2CAqtUh1EnYcmDJpUpeqzYBLjrEGav6tQlfPz4El8rTUXy49w9
         SFi1cC1imTosCDSEDAOgCe0rhSO0h68n0Q4ww+yQhddF1jTL9gvoEqdtdLmu0H147tK6
         CQafEJPM/a/UE/GPKva3qwwA8qNLIVQD7nCy8xjOVBgPqKVxx1F8FMze8GUVMFWW9GIo
         fdHhY16zyY4I4WbLMFKUcFBtrZqwvJv2fptcILBAFS0Uxgq4GQ0vwuLe1zFhYuFSYSPR
         xr0s6L8fubTlqrcXgEPnLSLE97yBgUfRmVjLnNMrvoT5/n3QCAX9RTw2OFstWfpo3chY
         PK4w==
X-Gm-Message-State: AOAM531kvEjGhxDpN8ACbpb15LZTUpdm9FhNtojTtCN9VrX4g9sF/DhI
        78tsm7k/xZ/x2w7FGHUaFpW/BvXVoNwlLxVq8lc=
X-Google-Smtp-Source: ABdhPJykVLNhDhqQhXCcqXCmdA5Au+rowhNnrtIiQx35C+rH8rgT4Wo9r/DwSPnYYy9FT7AFGX87SD/h3Lz7e6itYyY=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr19910116pfc.40.1615204966584; Mon, 08
 Mar 2021 04:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-17-marcan@marcan.st>
 <CAHp75Vco_rcjHJ4THLZ8CJP=yX2fesfAo_tOY8zohfSmTLEVgw@mail.gmail.com> <875z21zwy2.wl-maz@kernel.org>
In-Reply-To: <875z21zwy2.wl-maz@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Mar 2021 14:02:29 +0200
Message-ID: <CAHp75Vcgy1rB0LHHb+=mruAc-M-rGdfS0UnMh4xU1xkLxOycFA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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

On Mon, Mar 8, 2021 at 1:50 PM Marc Zyngier <maz@kernel.org> wrote:
> On Fri, 05 Mar 2021 15:05:08 +0000,
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > +#define TIMER_FIRING(x)                                                        \
> > > +       (((x) & (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_MASK |            \
> > > +                ARCH_TIMER_CTRL_IT_STAT)) ==                                  \
> > > +        (ARCH_TIMER_CTRL_ENABLE | ARCH_TIMER_CTRL_IT_STAT))
> >
> > It's a bit hard to read. Perhaps
> >
> > #define FOO_MASK  (_ENABLE | _STAT)
> > #define _FIRING ... (FOO_MASK | _MASK == FOO_MASK)
>
> The expression above is a direct translation of the architecture
> reference manual, and I'd rather not have that hidden behind a bunch
> of obscure macros.

OK!

...

> > > +       irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
> > > +                                                  irqc->nr_hw + AIC_NR_FIQ,
> > > +                                                  &aic_irq_domain_ops, irqc);
> >
> > If you are sure it will be always OF-only, why not to use
> > irq_domain_add_linear()?
>
> The OF-only API is deprecated, and there is no point in using it for
> *new* code, specially when things like IPI allocation require the use
> of the modern API. For arm64 root controllers, that's the way to go.

Good to know, thanks!

-- 
With Best Regards,
Andy Shevchenko

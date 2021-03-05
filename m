Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E66C32EE5D
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 16:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCEPUF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 10:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCEPTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 10:19:46 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003EC061574;
        Fri,  5 Mar 2021 07:19:45 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t26so1587810pgv.3;
        Fri, 05 Mar 2021 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOwzVtdSZN3Mcc6ru/DtiZXCgWq3L7CnPEmLp7eBzyY=;
        b=hk0W+oEhT/rlmb4k6N1zzaT1VFxS8NVWKLhR8E5O8DCl9+cAG4aQMXRp0n3OGLMhGs
         GFvWXtxEsay1ZLJzVmyIWyspeUN91t7w5zG7ENk4W6e3Eq+4vhKaQPkWPGgHgBBZNYHL
         Al35Ou5WH8msg/mtgp4rFz45uITmiL6gJNMUORvaviYmCIzcxVLrvAPUsCrfrnIfSBFL
         /TU02D4CBUH3w1tweH/aNrwg4gdw3v4wCfQge4CTg5LrfCRi0A0BhGqiPQcNjGWX1T4m
         LrBHjUfgSib9TO5V2huX1SHNOVGzBAjUfzExI/H5b5glBQ4PwFPFLpG/+kwZdrCqC2+a
         P4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOwzVtdSZN3Mcc6ru/DtiZXCgWq3L7CnPEmLp7eBzyY=;
        b=kN72TxEVrnLXF8crgzWsb0U0AigNQLJhpULGZaZPPhU1IlRhzORR7dOp+6+KDLWNJh
         pD2gByNbzHfaCNd14q4iueS9lYy3nfaEwCbwUpaTu0B1NP0BMTj6FGDF8HEmIZ+Arx7o
         yxDj8Hp2RUyaucG2tYTPmU85rFPKiKvRSz0+17oiYSNbxf4dbCiLAN9MC12CyHTE+3PS
         PdNiUnIV6qgt9caoD+UnADHX3d/Ie7VSWPzi9eOEWPP2JQBOkUwLXvrWkDaKNmnuuk2X
         gRnH2RYA2UzyrODA8wEokfhMx4r43AikOvphiFaeYiKB0+fnozI6OnnMX54mJyjE/db2
         otnw==
X-Gm-Message-State: AOAM532REalkd3H1d8niXtwhuLi1TBmeDaDiTj25RoWV8XdKfGRuo2GO
        I5l91341f7PhzB+7UDEZ3MQ58pSIcIjtZpC8mxg=
X-Google-Smtp-Source: ABdhPJxxxItHDKqmrPdbQja5GEzQAgqG8i/ggoAr5RBsl0yKB14P57ZpL5tYhovl3rx4zMTmAU8vESO/+qlNyO1Nsj0=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr8909928pgq.203.1614957585225;
 Fri, 05 Mar 2021 07:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-23-marcan@marcan.st>
 <fe2cbf68-8b88-5128-035d-f941a9d17d74@canonical.com>
In-Reply-To: <fe2cbf68-8b88-5128-035d-f941a9d17d74@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 17:19:29 +0200
Message-ID: <CAHp75VePm=O+xxeEibC=BptwK+vd9TfgJ6mAid=smqpNgozDoQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 22/27] tty: serial: samsung_tty: Use devm_ioremap_resource
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
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

On Fri, Mar 5, 2021 at 12:55 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 04/03/2021 22:38, Hector Martin wrote:
> > This picks up the non-posted I/O mode needed for Apple platforms to
> > work properly.
> >
> > This removes the request/release functions, which are no longer
> > necessary, since devm_ioremap_resource takes care of that already. Most
> > other drivers already do it this way, anyway.
> >

For the patches 18-22, with Krzysztof's and mine comments addressed
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 25 +++----------------------
> >  1 file changed, 3 insertions(+), 22 deletions(-)
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> Best regards,
> Krzysztof



-- 
With Best Regards,
Andy Shevchenko

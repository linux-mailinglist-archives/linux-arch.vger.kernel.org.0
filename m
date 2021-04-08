Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15313581AE
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 13:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhDHLZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 07:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhDHLZR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 07:25:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA604C061761;
        Thu,  8 Apr 2021 04:25:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p10so896211pld.0;
        Thu, 08 Apr 2021 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNlHOXPoa1AVSwT64tviQKrmRjIP6/dQq2uo/ujEyXg=;
        b=qp0/Rap3zfkW7RSQHOmAvkMYTUBWY2+8Bgzvs/A9UQK+O/r/Viauo5Rl//pUypVAO6
         s42eIVBlLZ9Req69nMeB27hCmZ3kJYLqgSZiM/Lwjsno4YP4wuaDIoV1lP5m0B6dn63Y
         XM5nfhiXlBQ/n2U49Jycba8gJaXHVy7hpX4jGJ3SXaisjZ1WoXqQBG8MNB5vwXFGxgR7
         tqD1xhiWSQCmbvXlddzNLD9yaV0OHzlwgboQM0jBCvDZP4qsAY+8Ra8OOM5x/N8QOA+H
         wcKy5b4Tq48vPsym77APSy5tTXFS6ZDkogixZcZsqyC/mdw7N0zFcTxZcIE55NUN2hpk
         +KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNlHOXPoa1AVSwT64tviQKrmRjIP6/dQq2uo/ujEyXg=;
        b=pISWp2rNcXOuBq/y4ln6CPMwKtLPVOrD72H+xDzSgVtc4FgQ0YEVmhD9KMXqFUi3A9
         YarCJwXP2T17CwWyyeDDz0MjQvbJjXzjfsRApwYX2G4eKO86nVDl11BuXu0AxRjSJkza
         Gw9maw8BlSkqa9Vn2QZjwsdfz8MKoSU9+JH76Gnp5eHHL+OkuGiksY1wXLWeFBlaFycX
         5l4ygf/E7SJgRmHKkY3d5mW5hiqikraPAhMYUbCzw1jK44z7yGGPMSKA4G8uCtIsljIH
         9LzAgVRCrr1heE8GMF6MVs1wFPQnkvPKKTQF9GiE53TlyCjvZ9hrUyjzqfFficfPkYKa
         Ohcg==
X-Gm-Message-State: AOAM531/nEiGW1f76feGwYAds/z9SRT2IsJp4Y6JXwtSY9oPGa3eyloI
        vXHXF6oOL9H7TQi1WDqxVmrXuLgMZGC6/cQE/CVy3evo5MUgYfMW
X-Google-Smtp-Source: ABdhPJzpmgt1Vn1p3ptTy+1Wh/v8DyxoLdx6FN8hIZR+wzDKv0ufwJ0Y3kqPjfzWUZqOGHy3WDJbZOZXTX9qGr9xsIs=
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr8250717pje.181.1617881106488;
 Thu, 08 Apr 2021 04:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210402090542.131194-1-marcan@marcan.st> <20210402090542.131194-12-marcan@marcan.st>
 <CAHp75Vcghw6=05vbhX5J8sHoo78JMoq5z4w9__XcocrtRVjF3g@mail.gmail.com>
 <20210407210317.GB16198@willie-the-truck> <a89af1a3-b065-fca3-19d8-b7fd5ca2f1ae@marcan.st>
In-Reply-To: <a89af1a3-b065-fca3-19d8-b7fd5ca2f1ae@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Apr 2021 14:24:50 +0300
Message-ID: <CAHp75Vdyug5zbSpGSDEK9hUY+y+ZLDeAyLsc2HAjEzczCpDOSQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/18] asm-generic/io.h: implement pci_remap_cfgspace
 using ioremap_np
To:     Hector Martin <marcan@marcan.st>
Cc:     Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 8, 2021 at 2:01 PM Hector Martin <marcan@marcan.st> wrote:
> On 08/04/2021 06.03, Will Deacon wrote:
> >> I would rewrite above as
> >>
> >> void __iomem *ret;
> >>
> >> ret = ioremap_np(offset, size);
> >> if (ret)
> >>    return ret;
> >>
> >> return ioremap(offset, size);
> >
> > Looks like it might be one of those rare occasions where the GCC ternary if
> > extension thingy comes in handy:
> >
> >       return ioremap_np(offset, size) ?: ioremap(offset, size);
>
> Today I learned that this one is kosher in kernel code. Handy! Let's go
> with that.

It depends on the maintainer. Greg, for example, doesn't  like this. I
have no strong opinion (I use both variants on case-by-case basis),
though I think in headers better to spell out all conditionals
clearly.

-- 
With Best Regards,
Andy Shevchenko

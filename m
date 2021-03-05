Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635B32ED63
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEOqd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 09:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCEOqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 09:46:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1198C061574;
        Fri,  5 Mar 2021 06:46:09 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fu20so1994750pjb.2;
        Fri, 05 Mar 2021 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLYTD0kAvjqxy4t6HYU1DX6C4LCII/OyaiVaeCrW9qM=;
        b=ukIyLWd7IPrGz9FmT55xeMgIjS0mmGxYHjvHsblVSvKp5DH+2v6c1csGjb8bjvqpKP
         6jd95CW7LyETGi+XP/VoNTtJ7cSHj5EU7NQ2C3CsL2hRV102BUM5CmUjGiXeAIjnya0R
         uvCpCzW+CMQi/sEkyfgtYPgLPK/9TnxDx6U9w9TRkMHKwSYBX+ubyuVgPOubpU62azrO
         Ap8ZLiSMWMpP9qijIog4MyARVO3i+Te3juTjZTuch5RCT5iKDnbTMJUurMN3dWSTlPpe
         rM84CWmNWYc/zecadzic8UHPKKOIU/6BHSQfX5MtKZAaz8GepkfJGAsESZs93jl2574K
         cCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLYTD0kAvjqxy4t6HYU1DX6C4LCII/OyaiVaeCrW9qM=;
        b=pBi5F3bVIaKBNI0bz6R5pNR8F3uM8pX+wVqI4ZZhwA6817cK44+sWUFfPsisH19w/C
         QE8IDHrnVGifHIteIKv7cLjAIX2tTfCCqf8jpXphrGrOioFsYpMfmJim1QShn91/hnb2
         GeolswU4RXO/6RhCGhq2DphoyuF/C7c/NDIZRC5IUfmOEsgHxI/MkESHHETNcLgWILxJ
         8J7cV1AuH0jSc9dWeSErNiZZccIyrx/1CErlIXztJT9RZCtaGsjFGL9w/wxq2KnNCdao
         RpOM5hiEPDDMdl1F+F1McS2J0V7oCnqtKu/XPMhnO5v+2U/PXbxI1ndDqysMObsEr8VY
         n5UQ==
X-Gm-Message-State: AOAM533LQIvsbtPDEcRddPhdiQF3ZRVkZpu0bYXTZHxchpKeN992RF90
        vbs7YhCCMhlbS/81Ait6u2iXIfdVoNCQi9fgUNE=
X-Google-Smtp-Source: ABdhPJy1hcFeT7++NM/FsF4zGG36/dA0n6KUzt61a1Rr+S1F6UUjFavqe8V/stSRz3GNxaBc6EYTzdQVZaZ3LMDXf+g=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr10807897pja.228.1614955569419;
 Fri, 05 Mar 2021 06:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-9-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-9-marcan@marcan.st>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Mar 2021 16:45:53 +0200
Message-ID: <CAHp75Ven4piceFaBhn1kc=vtwM4o-GXmz3eAZoNhU8w+iP5qxQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h: Add a non-posted variant
 of ioremap()
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
> ARM64 currently defaults to posted MMIO (nGnRnE), but some devices
> require the use of non-posted MMIO (nGnRE). Introduce a new ioremap()
> variant to handle this case. ioremap_np() is aliased to ioremap() by
> default on arches that do not implement this variant.

Hmm... But isn't it basically a requirement to those device drivers to
use readX()/writeX() instead of readX_relaxed() / writeX_relaxed()?

...

>  #define IORESOURCE_MEM_32BIT           (3<<3)
>  #define IORESOURCE_MEM_SHADOWABLE      (1<<5)  /* dup: IORESOURCE_SHADOWABLE */
>  #define IORESOURCE_MEM_EXPANSIONROM    (1<<6)
> +#define IORESOURCE_MEM_NONPOSTED       (1<<7)

Not sure it's the right location (in a bit field) for this flag.

-- 
With Best Regards,
Andy Shevchenko

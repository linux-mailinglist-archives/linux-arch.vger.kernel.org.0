Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648C23302DA
	for <lists+linux-arch@lfdr.de>; Sun,  7 Mar 2021 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhCGQCj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Mar 2021 11:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232383AbhCGQCN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 7 Mar 2021 11:02:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B322650FA;
        Sun,  7 Mar 2021 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615132932;
        bh=W3DWtdKbzB/Ewq0JXP5uIPr5sVdrpUWScZRv+BpwOOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uvTAugzrUQYpKuCcE5EB2V7uskUn7uQ1kw3Ti9BBAyqQTmqLgQKYlYnumatE5cRFc
         TxVpaDX8t7wop24oROmlUS96NMdVeY7PBHDIW/T3WSmx/aCPFFh9v3xHu0e6GSI/Rx
         ViYKo1BNlVsFC65pNKLgytdDsWIOhzT8pO1yqotAUcGPJGH0Nj83z5XIkuCh3gzRaP
         RCvB3K4RyMw+BKYpyVQxCNekIzPX2+xiiY9/RoaX+oINmRapsa/7H7PofVuHzmkqdE
         iMY49sccaS1j16kG5oQvyCvriltmludfQy+PNzABu+/0WPz+XC05tDuL+SaC1iYVBI
         NrHiOR3ly/7qQ==
Received: by mail-oi1-f176.google.com with SMTP id x78so8416232oix.1;
        Sun, 07 Mar 2021 08:02:12 -0800 (PST)
X-Gm-Message-State: AOAM530y6b8oPrrVJXGClw9xhwoqQGy/mg1Cjs168qlZpXpvZdilevcY
        QxGhW2KOMGlKtNwmvWNCSSg2hvTE1tOXKtV04i4=
X-Google-Smtp-Source: ABdhPJzpPsfCCAkRmVKn193+pHQBjk17f8dkofO2rKwjX7TbuYoBS5vX7tmjl8lFu8yM18ZXMOLeGO7Q06knumxhjeE=
X-Received: by 2002:aca:5e85:: with SMTP id s127mr13583208oib.67.1615132931842;
 Sun, 07 Mar 2021 08:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-22-marcan@marcan.st>
 <CAHp75Vc+t9_FNHZ0xYNaJ1+Ny+FFeZKA79abxV2NAsZvpBh3Bg@mail.gmail.com>
 <535ff48e-160e-4ba4-23ac-54e478a2f3ee@marcan.st> <CAHp75Vd_kwdjbus3iq_39+p_xRk3rum2ek3nLLFbBDzMwggnKA@mail.gmail.com>
 <05ccc09f-ffea-71cd-4288-beed3020bd45@marcan.st> <d33fffec-28bd-99b2-a8b1-cc83b628e4b3@canonical.com>
In-Reply-To: <d33fffec-28bd-99b2-a8b1-cc83b628e4b3@canonical.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 7 Mar 2021 17:01:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0o4NHjXZ+ePj_Xpcw6ZmonoiR1dfkcsv=3i1JBEF4arA@mail.gmail.com>
Message-ID: <CAK8P3a0o4NHjXZ+ePj_Xpcw6ZmonoiR1dfkcsv=3i1JBEF4arA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Hector Martin <marcan@marcan.st>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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

On Sun, Mar 7, 2021 at 12:34 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> On 05/03/2021 17:29, Hector Martin wrote:
> > On 06/03/2021 01.20, Andy Shevchenko wrote:
> >>> I am just splitting an
> >>> existing function into two, where one takes the lock and the other does
> >>> the work. Do you mean using a different locking function? I'm not
> >>> entirely sure what you're suggesting.
> >>
> >> Yes, as a prerequisite
> >>
> >> spin_lock_irqsave -> spin_lock().
> >
> > Krzysztof, is this something you want in this series? I was trying to
> > avoid logic changes to the non-Apple paths.
>
> I don't quite get the need for such change (the code will be still
> called in interrupt handler, right?), but assuming the "why?" is
> properly documented, it can be a separate patch here.

This is only for readability: the common rule is to not disable
interrupts when they are already disabled, so a reader might wonder
if this instance of the handler is special in some case that it might
be called with interrupts enabled.

There is also a small overhead in accessing the global irq mask
register on some architectures, but for a uart that does not make
any difference of course.

While I'm generally in favor of that kind of cleanup, I'd also
prefer to leave it out of this series -- once you get into details
like this the series gets harder to review.

        Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C74337C21
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 19:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCKSLN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 13:11:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhCKSKf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Mar 2021 13:10:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 773FA65018;
        Thu, 11 Mar 2021 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615486234;
        bh=tmt8DXL/NkkK3fqsKzp1sa5x/enHlRdNBSlE6sT3Ol4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ew/NIGH8ca6hopkG3U8b9r6qb4RL4623K9fly5yItiT+8ubil19Ek3W1I9uzZkXaV
         SS/wUSc4qF2N/+CEdEEjiosqyXdPlQDV6gmsZyGoYiofROwQuELtuvpXLsg41ZUl+I
         zTxb4YH7gGW2lP+bk0UmqouHE1A4Ct9j5CBAZIb/EyFukR+wc5+426TEG3xvSqlTNs
         zrISTJo7Bcn1PT6Tt7VvH6wBUv/FOVlzZjPhhFRyf24OBWtBR8UkBxZNOxnGayUlL3
         qdG/KlD2b/NUv3xynLWzvL7xQCfBHPzi0d+rEqHmljXgXkL98TRQxiPn6hmAPOYpfu
         pO74we79VATfg==
Received: by mail-ej1-f43.google.com with SMTP id e19so48236776ejt.3;
        Thu, 11 Mar 2021 10:10:34 -0800 (PST)
X-Gm-Message-State: AOAM532gIRH9bm3Fo+i0EbsHlRjhxiPQWK5SP7fJE/Yz0D30C1g5zyPH
        LQhMi4sqcRq0QAngd7NwMBkwIHB/s3Zjf6bAFg==
X-Google-Smtp-Source: ABdhPJyUsXPtzO/H83nHUMgfPs1p3wnAlKlkTmdKFFzieSp9RKRftdZy73PPYTvjnRjgXVDraWLRvsEKaxzbwKml2jg=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr4327186ejz.341.1615486232876;
 Thu, 11 Mar 2021 10:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com>
 <20210308211306.GA2920998@robh.at.kernel.org> <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
 <CAL_JsqK8FagJyQVyG5DAocUjLGZT91b6NzDm_DNMW1hdCz51Xg@mail.gmail.com>
 <c5693760-3b18-e8f1-18b6-bae42c05d329@marcan.st> <CAL_Jsq+VLLPa98iaTvOkK-tjuBH4qY7FNEGtufYGv7rXAbwegQ@mail.gmail.com>
 <332c0b9a-dcfd-4c3b-9038-47cbda90eb3f@marcan.st> <CAL_Jsq+X7JPm-xrxmy5bGKSuLO59yk6S=EuXmdMn0FwhpZAD7A@mail.gmail.com>
 <CAK8P3a2HWbHc-aGHk792TVh6ea2j+aKswYrB6EBsjPA6fH1=xA@mail.gmail.com>
 <CAL_JsqKYpsXKvcw7xbbYx6z7Cg3P9DxcpLUnOG+m0xeSRO7v_g@mail.gmail.com> <CAK8P3a2iASEZf-YRh2SHYhNdUtpo8sdkuoxfk_MonXpXBk1kbg@mail.gmail.com>
In-Reply-To: <CAK8P3a2iASEZf-YRh2SHYhNdUtpo8sdkuoxfk_MonXpXBk1kbg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Mar 2021 11:10:20 -0700
X-Gmail-Original-Message-ID: <CAL_JsqK200WcxD3PP1FToc5w2dyF3b6TYnf2oNd9Mpz77g68og@mail.gmail.com>
Message-ID: <CAL_JsqK200WcxD3PP1FToc5w2dyF3b6TYnf2oNd9Mpz77g68og@mail.gmail.com>
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

On Thu, Mar 11, 2021 at 9:48 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Mar 11, 2021 at 5:10 PM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Mar 11, 2021 at 2:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Wed, Mar 10, 2021 at 6:01 PM Rob Herring <robh@kernel.org> wrote:
> > > Ok, makes sense.
> > >
> > > Conceptually, I'd like to then see a check that verifies that the
> > > property is only set for nodes whose parent also has it set, since
> > > that is how AXI defines it: A bus can wait for the ack from its
> > > child node, or it can acknowledge the write to its parent early.
> > > However, this breaks down as soon as a bus does the early ack:
> > > all its children by definition use posted writes (as seen by the
> > > CPU), even if they wait for stores that come from other masters.
> > >
> > > Does this make sense to you?
> >
> > BTW, I don't think it's clear in this thread, but the current
> > definition proposed for the spec[1] and schema is 'nonposted-mmio' is
> > specific to 'simple-bus'. I like this restriction and we can expand
> > where 'nonposted-mmio' is allowed later if needed.
>
> That sounds ok, as long as we can express everything for the mac
> at the moment. Do we need to explicitly add a description to allow
> the property in the root node in addition to simple-bus to be able
> to enforce the rule about parent buses also having it?

IMO it should not be allowed in the root node. That's a failure to
define a bus node. Also, would that mean your memory has to be
non-posted!?

Rob

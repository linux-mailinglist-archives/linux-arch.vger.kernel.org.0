Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9623379EA
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhCKQsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 11:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhCKQs0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Mar 2021 11:48:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED2864FFB;
        Thu, 11 Mar 2021 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615481305;
        bh=FgHbw5HS/VjP7/VZBF5aykDpmElBQPo7RYwq/98R/y0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xjm2VLWQbRLzLjMb3wGyLY/D8Qc6zsY+gHm5tR9VhAap9AW7Ethi7WR+IkUl/0Ven
         86SK1RQXK0WdIlpmesgdJltCy4fWuo7zvsnG84lBdRk/0N5nLcpvF/hUG2KEB5pLoz
         tWo9qSkUf4/NaR5c1K87+wc/ZFqufD/AI9+3vQKwbJ0F6MTGOe0EjpzFbfmJFgp1By
         6it0kiNaV/p+q+R5Epwa6oFu3B96Y6qWUqC8c+bS1k1kY7FIeO2gDXVNEjQ/8GKwYd
         rhLOSyDPImswIt6JrFSqzVhWrt1RA+zyTvkjXNeUBHAjiZOmku848V1UN6kGJtsqcW
         bxfRyUcYFwIww==
Received: by mail-oo1-f46.google.com with SMTP id e19-20020a4a73530000b02901b62c0e1bb6so831805oof.11;
        Thu, 11 Mar 2021 08:48:25 -0800 (PST)
X-Gm-Message-State: AOAM532BIdwPeQXtk+8rcA4oFQkV2ikl5155G19Ek+co8I95IqiPvwaY
        og6VIqYmRUq73oCM8eEBS4Qx5qLkT3pj6c58zYw=
X-Google-Smtp-Source: ABdhPJwIgrbXVP3PRPUXHopliI3qsXWZiXkZVPwqkBfIWll0HvAMT6p5npMnLVv5OxG3dnsn4P6GmJ7wCO0i3CmSEgk=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr7486554ooz.26.1615481304355;
 Thu, 11 Mar 2021 08:48:24 -0800 (PST)
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
 <CAK8P3a2HWbHc-aGHk792TVh6ea2j+aKswYrB6EBsjPA6fH1=xA@mail.gmail.com> <CAL_JsqKYpsXKvcw7xbbYx6z7Cg3P9DxcpLUnOG+m0xeSRO7v_g@mail.gmail.com>
In-Reply-To: <CAL_JsqKYpsXKvcw7xbbYx6z7Cg3P9DxcpLUnOG+m0xeSRO7v_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 11 Mar 2021 17:48:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2iASEZf-YRh2SHYhNdUtpo8sdkuoxfk_MonXpXBk1kbg@mail.gmail.com>
Message-ID: <CAK8P3a2iASEZf-YRh2SHYhNdUtpo8sdkuoxfk_MonXpXBk1kbg@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Rob Herring <robh@kernel.org>
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

On Thu, Mar 11, 2021 at 5:10 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Mar 11, 2021 at 2:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Wed, Mar 10, 2021 at 6:01 PM Rob Herring <robh@kernel.org> wrote:
> > Ok, makes sense.
> >
> > Conceptually, I'd like to then see a check that verifies that the
> > property is only set for nodes whose parent also has it set, since
> > that is how AXI defines it: A bus can wait for the ack from its
> > child node, or it can acknowledge the write to its parent early.
> > However, this breaks down as soon as a bus does the early ack:
> > all its children by definition use posted writes (as seen by the
> > CPU), even if they wait for stores that come from other masters.
> >
> > Does this make sense to you?
>
> BTW, I don't think it's clear in this thread, but the current
> definition proposed for the spec[1] and schema is 'nonposted-mmio' is
> specific to 'simple-bus'. I like this restriction and we can expand
> where 'nonposted-mmio' is allowed later if needed.

That sounds ok, as long as we can express everything for the mac
at the moment. Do we need to explicitly add a description to allow
the property in the root node in addition to simple-bus to be able
to enforce the rule about parent buses also having it?

       Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0B3319D4
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 22:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhCHV4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 16:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231162AbhCHV4c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 16:56:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EFF46523D;
        Mon,  8 Mar 2021 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615240591;
        bh=KMmCb7U2ujabFxkud2d3urqwhs41+pBgCpeNG3URuos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shvsBQVFvq7E6xYk01gjriusngocJaMunvCLQ1nZ2LiXr6HqZOsptcBgfuD3VnmGQ
         lpR36R70KqunemCgUFKzSpM8nXZG9o+7SnvsH3etABbswOk8zvD1Jo6+NlENDYyuDv
         WHUkA/e27cC4Op9IiestvSkydSylG6nR3t3ydutKz9Ra7HIfaNpRpEAarKULQCPz0y
         HwGY0uGH/E0gNZpl4WoKEcHc+b5uG9TBZyx5/VUfepz2hYvce+XbA8NwqEme724qfI
         nkZLjsPL3MRnRThwG4OyccapQkYCwO+hCZcs6cyHrBsPIInBcJZ5luwlt5QNA1ebUN
         2vTINTUt18Etw==
Received: by mail-ot1-f47.google.com with SMTP id a17so10813292oto.5;
        Mon, 08 Mar 2021 13:56:31 -0800 (PST)
X-Gm-Message-State: AOAM5330bCAV2lyNzY7YYDF5EzM0OxV1ZYawXJBJ0eLLM8Fcarqas2zd
        q5IGPKvb/lqZg+Uh4zOKvUp8hiOtB4F6U3saUW0=
X-Google-Smtp-Source: ABdhPJxa7+3TXf8xLA/E0HpUEZafsO9uyBdTJcygHPn2QO83SDsdS9V8PUzozL+D9A/4nZHqTIXj7Xx+nWGOPifP+7w=
X-Received: by 2002:a9d:6341:: with SMTP id y1mr6301932otk.210.1615240590795;
 Mon, 08 Mar 2021 13:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
 <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
 <6e4880b3-1fb6-0cbf-c1a5-7a46fd9ccf62@marcan.st> <CAK8P3a0Hmwt-ywzS-2eEmqyQ0v2SxLsLxFwfTUoWwbzCrBNhsQ@mail.gmail.com>
 <CAL_JsqJHRM59GC3FjvaGLCELemy1uspnGvTEFH6q0OdyBPVSjA@mail.gmail.com>
 <CAK8P3a0_GBB-VYFO5NaySyBJDN2Ra-WMH4WfFrnzgOejmJVG8g@mail.gmail.com> <20210308211306.GA2920998@robh.at.kernel.org>
In-Reply-To: <20210308211306.GA2920998@robh.at.kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Mar 2021 22:56:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
Message-ID: <CAK8P3a2GfzUevuQNZeQarJ4GNFsuDj0g7oFuN940Hdaw06YJbA@mail.gmail.com>
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

On Mon, Mar 8, 2021 at 10:14 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Mar 08, 2021 at 09:29:54PM +0100, Arnd Bergmann wrote:
> > On Mon, Mar 8, 2021 at 4:56 PM Rob Herring <robh@kernel.org> wrote:
>
> Let's just stick with 'nonposted-mmio', but drop 'posted-mmio'. I'd
> rather know if and when we need 'posted-mmio'. It does need to be added
> to the DT spec[1] and schema[2] though (GH PRs are fine for both).

I think the reason for having "posted-mmio" is that you cannot properly
define the PCI host controller nodes on the M1 without that: Since
nonposted-mmio applies to all child nodes, this would mean the PCI
memory space gets declared as nonposted by the DT, but the hardware
requires it to be mapped as posted.

       Arnd

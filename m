Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BEC334C3E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 00:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhCJXMG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 18:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCJXLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Mar 2021 18:11:35 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B33C061761
        for <linux-arch@vger.kernel.org>; Wed, 10 Mar 2021 15:11:34 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h4so27896832ljl.0
        for <linux-arch@vger.kernel.org>; Wed, 10 Mar 2021 15:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fsUvZGKYC5fgx4oei9Q5/ic2uEIxVNyjDNMh2AgyO6I=;
        b=YFJ7SMDaL74sPgY4t2M2TveLoai2GpxFH7T+w02cY0yAPfz4d7STzMXwN2LMQ2iEoZ
         AC3wFDsX/B+jYJXVNzs+y4D9tGf/wEA3njzRA4m7PPgqfVi486jFs5jC4rjhpItvLjMl
         feX0SL4sSjFQxxMpaHtUG3m/yP5ZsWGY2bHZ1JzjeRWLuH3LgTM/weeATOW14t4za+lM
         0oejehpKlmlwaemoSaXKHgvkv/wgRR/MCed4z76h2TRaPLDfBO1rpazJRuqEpn9HXUuZ
         gZsRlyCIDNbKHWfuIFLOxVswPmSPuq2apnjiVRCSHJ7mbVzB2AtDRB2jPCfVazu7Yozu
         i7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsUvZGKYC5fgx4oei9Q5/ic2uEIxVNyjDNMh2AgyO6I=;
        b=jF0Iw6xMRV9/SFtPmBh//GBa/o0tOqxRjrf+ziOXkaQPZ/wiCAwm0p7GIcatElbi5+
         B+LzMPyPqWD55tJV3UYar3GwvtHtmwJP1kE17Y0kJ1g08AQsV6MW8hQ09X6p0jB5Q0iW
         fbzXFLma2HPAGlYi4y8icCDUeU90tdBo6VXcVnp7bEpJXHKMoFPaXoyLN5j15o9hix1y
         nT/2S7HuaQyR675LibxrOXUkTR+b/ZoWB+pnxYl3K78FY9zW3hvAkF38s/IXZHhtGruM
         GfsvNrnMBIBnRQosvT4bxF5F+LFpJSrSAmWfm8mB8QU7AE0f6ESGeVnUiriOgt4ZQJX8
         Q+JQ==
X-Gm-Message-State: AOAM5301ST1+v2NYANBRUCEY0FNHK2l6CHepAODLhNe/zEk2a7ciis2H
        ZWs9W/1ftPZ97Ju7IbJFSBgNv7hzRa4CHQppPW9zSQ==
X-Google-Smtp-Source: ABdhPJzmo5G8NylnSmgEyDfdbat9eWDptGx3+8/H3Ywrq5Z5I67GtCUd0mY3fRoJZXOwQZI5bSexUvc4wSg5BOhWX4M=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr3125411ljc.200.1615417892988;
 Wed, 10 Mar 2021 15:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-26-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-26-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 00:11:22 +0100
Message-ID: <CACRpkdZrFfP3nx=eU-hKKVUfxHHX2J2-__6tjV8hTPgX3qtBDA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 25/27] tty: serial: samsung_tty: Add earlycon
 support for Apple UARTs
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 10:42 PM Hector Martin <marcan@marcan.st> wrote:

> Earlycon support is identical to S3C2410, but Apple SoCs also need
> MMIO mapped as nGnRnE. This is handled generically for normal drivers
> including the normal UART path here, but earlycon uses fixmap and
> runs before that scaffolding is ready.
>
> Since this is the only case where we need this fix, it makes more
> sense to do it here in the UART driver instead of introducing a
> whole fdt nonposted-mmio resolver just for earlycon/fixmap.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Hector Martin <marcan@marcan.st>

This is as elegant as it gets!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

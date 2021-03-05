Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0991832E645
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhCEK0G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhCEKZc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:25:32 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E4C061756
        for <linux-arch@vger.kernel.org>; Fri,  5 Mar 2021 02:25:31 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y12so2052377ljj.12
        for <linux-arch@vger.kernel.org>; Fri, 05 Mar 2021 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leQw7QODR4CyZQiZgP9OPt/5ZEqXQr46bOHgh0kpZlk=;
        b=iSUpKEpRqonYV1gt46fEBjz/fG1evvGP933Hm8NDO8DF1Nf82vxEvrPe92LonMVaj5
         cDE4IcRvvO1ntfTn5itxZs+RgWOz8mw4hJMZdVy/8h2ViibMQXl1AgXPtgXQM11LX0a1
         RhKFE3xqBC792VlT4JGclRKp0uaCgPW6l2Fb9cHIdP+2mUUor2Hr91JIg6O+aC5Fvdbf
         +dYsoxFLntrw49PjvfalTLzJsU9XYkeIK3tTqUIWRgHmgkKh6DAj/8G88mtElmj6EDwm
         mBuK4v6HFEIDG7XjAVIoY9pgDp6ULe7Abxl3AljZx0i4k7liqPevlL5AQL78ZahYYIdz
         kc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leQw7QODR4CyZQiZgP9OPt/5ZEqXQr46bOHgh0kpZlk=;
        b=c7RMF6Xm2wqQwvsKxyMaTU2nsvX4LIPDvAIltoGZsNymX7Vdi/cIlpj//aUiY/Diz0
         RhyBP+Fmg46lkIp5OK6Dwc/jNMkmuXuc6f059gCZtAnB4sKd3nzfQAEmB6bykinc8KlV
         ROFvuuufgMs4T7c1lIWXqHqh4rplNbptG0GJCSkij5IN4w4H9XTagS8xVnCadhh2YZ/r
         mFJedhKJGIGKYIB/iQQIBiUapgcVGkIRk6b/9H9/Eg/6mWzJ7szojPX9wWDrpmaSzy6y
         LmBLDZCFGQC2kK8lspEV3LN7mtNf+4rYWLfdkP07mfqop2MO9knDcWzeeaI2cfBK30A1
         7PqQ==
X-Gm-Message-State: AOAM531AN+qdnYNM/R8XCsEgxladG47lrmeQ9ICxDUH/C/679fYsPbus
        UvDA+vLUFf70tRE5Jr6qiBc6mkg2BW2SeKt+GltGUg==
X-Google-Smtp-Source: ABdhPJxsMc8mauXfaPMwsKihYulLxZ/6kfZ3EeDp5br7yesRj8HC0FjQsUqFiEGezYIKsMpnpQHfiXS3MNRkjkU9flk=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr4752980ljc.368.1614939930235;
 Fri, 05 Mar 2021 02:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-11-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-11-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Mar 2021 11:25:19 +0100
Message-ID: <CACRpkdYeeUb6WUe_RBxBEjNnTJ9o55Z-8Ma7CLokFOdCtF0M+Q@mail.gmail.com>
Subject: Re: [RFT PATCH v3 10/27] docs: driver-api: device-io: Document
 ioremap() variants & access funcs
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 10:40 PM Hector Martin <marcan@marcan.st> wrote:

> This documents the newly introduced ioremap_np() along with all the
> other common ioremap() variants, and some higher-level abstractions
> available.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

I like this, I just want one change:

Put the common ioremap() on top in all paragraphs, so the norm
comes before the exceptions.

I.e. it is weird to mention ioremap_np() before mentioning ioremap().

With that change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

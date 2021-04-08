Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A680358FB2
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhDHWOv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 18:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHWOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 18:14:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD255C061762
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 15:14:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u10so4111207lju.7
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZYFt0LVceFfcAprXRqy7FjMz5TZMkhneNJXsWawHjA=;
        b=jh/m8+mpPAxdKJ0faiWMDsB8ThJ/bVJJ9pnV2DdOmRS9/0Oups3cMyWdWzW18R9i8j
         gbunTrdTzXj61KzAnIHGuLvJ9nkft7x+MraDzr7gFF1yaBGUjtjTTdMiYQ+PunQrg6Mq
         AHGDRg72C/ydMvv4dEfdxZRPqzyRfYLL/pSvqU735sU8zij4s5RgqNN1PZ4wS+Wdi6Ka
         AZRfpoyBNCCwQ3y+fFkFyztWzGjIj4Wpf0KA1axvxXHsmaTEVk+z8NE0++4kRHkHMHFm
         aPIVCbs0pKTV4iffO/p2kmB53EhxBPUETOwOLcv2vlxxWltOmJLjG8b2F2EkOAbgrmI2
         7blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZYFt0LVceFfcAprXRqy7FjMz5TZMkhneNJXsWawHjA=;
        b=mqIylFXeiUlacRkHHDqVhB5iww+cUuoPgubbzw8zbNoeTvhq1Ba6mxj+0WFRx1/Aqi
         gmZBVOFIy7Bc83rVGbNQ/7oU5OWif7a8BCv6p/BwE6Ca/EozHdInFCoPvcJVGgvwyP6H
         RI3DNVn2ukmbj0CmBmIxIK+yj/PGB8m+2IQv+v9+VQjiUyV7hBOqHKmzj9V/Sz1JJqAk
         2Z0a28GizmYhZg8trUn4a6a9U3UFvnWOBkvUjT8XLfP/h0Nxq9o+PyQaK5UF52FUCWvO
         vFXsxK+0+83t0RVkGJCmoi+SgsA33eKqkvRlLhDe25FyWXiPrvRZrbLJtRlxYkzBZCH+
         SE9A==
X-Gm-Message-State: AOAM532IWTcvKyyhQgywiRv5qg7ZvYrKZY7u3Wz5GDrR0dty7JVimg1K
        fQbPk/yGaz/uo5pBXFweYxyipJ3YRhcY2HJg4zNICA==
X-Google-Smtp-Source: ABdhPJzWty7OkE/zjpcMz5z53ansy9SUNQ01JxDM7F1AxOx5za4NUdfe6x0onlsn7zmcaLaN2CQvWeG2UAY2qDU8U9A=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr7305898ljj.467.1617920077290;
 Thu, 08 Apr 2021 15:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <bdb18e9f-fcd7-1e31-2224-19c0e5090706@marcan.st>
In-Reply-To: <bdb18e9f-fcd7-1e31-2224-19c0e5090706@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Apr 2021 00:14:26 +0200
Message-ID: <CACRpkdaijbDoV2rSQsgO3XKnj_Hde8CU9JQ+V9gGePYjvCWJhA@mail.gmail.com>
Subject: Re: [GIT PULL] Apple M1 SoC platform bring-up for 5.13
To:     Hector Martin <marcan@marcan.st>
Cc:     SoC Team <soc@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 8, 2021 at 5:55 PM Hector Martin <marcan@marcan.st> wrote:

> Hi Arnd and all,
>
> Here's the final version of the M1 SoC bring-up series, based on
> v4 which was reviewed here:
>
> https://lore.kernel.org/linux-arm-kernel/20210402090542.131194-1-marcan@marcan.st/T/#u

Excellent work on this series Hector, thanks for working so hard on this!

Yours,
Linus Walleij

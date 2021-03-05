Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341C32E5FE
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEKQv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCEKQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:16:40 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528FC061762
        for <linux-arch@vger.kernel.org>; Fri,  5 Mar 2021 02:16:40 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a17so2076025ljq.2
        for <linux-arch@vger.kernel.org>; Fri, 05 Mar 2021 02:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbH2XnLnL+zeqgwenkERgBp6OdMalagNgmjddUY2upo=;
        b=oosQD1k0ihuNWvZd/OBh3mc8nkdjesc2ilrBKyxU54uLyH7RvMV3qxaKGuxGmyTP9w
         7caTG2bAlHb4RIuwWBoXXdwLHI1wuF1UhzSYqvKKVuPJo2A4M4tpwRjXeJj+xZVUonDX
         UdSpwPE1UpnxNlqFw+lq4Gu6zhZBXm/vANy7gThzJHkn3fTMng4OD0VcMKLNGAbJ8n7Z
         W0DkubhzB0Y3TdGjmmV7fLpOP0x3K5jmP4uOJi8LKa53fUQqinUuitoq9vPbc6ObUogr
         0YzEgMGg0uCnBgL74LwDVEecmp+20X7oEJNr4U+Q+ONNvPT2dwJ+XUWBfEzrflscGCAS
         3YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbH2XnLnL+zeqgwenkERgBp6OdMalagNgmjddUY2upo=;
        b=RP5fvoUKMit4UjILTeYEyIzt2SdqSLuiJ/yH5eDl3+mYgros+Zw4BJpiFMkSIlRReA
         vtxaVBR6QCItrpy9y6Q1FsdLf1bYaaT2/dhkjn4qZ4JNzCcizsv3FkpSL+XOrVB2qqh+
         wQUNC+rKdoTHe7/K0TmKpbhg2NpPmTG2+5bkODsT1Y4VGa3bSgH4VhfB9WVhlAZ8fyf/
         PVk5fTV6v9T5pqj/d/k2vRQQtpYFAD0g4PfquWoeDOGdSXesrALZdLbLh7YETZsysRXC
         38jrRTnVJkTAMO+FTLS4kltSnyvh7iKtgPAhvoNyR8wbrRA2GP8xlmGoL6gsSXhI+7dA
         hDVw==
X-Gm-Message-State: AOAM532jHHWfDS1OdaPK9m+PA+1GN+dSvM9m6RFSBKz1ni/wtxgc2cYP
        fTanSvx+vvv0u3p9fk9qKrruUZ3iM7Nfzv6cu9Qqsw==
X-Google-Smtp-Source: ABdhPJxEx/lpierUGPxwT0L2+ZEtm4VbumUeVdUGn8v87RY30yCJpt4gIIgfdrlbQP0GGfAVxM0ky6MFjfiSwQhsyRg=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr4991292ljw.74.1614939398241;
 Fri, 05 Mar 2021 02:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-4-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-4-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Mar 2021 11:16:26 +0100
Message-ID: <CACRpkdbrEch04BFE+suqmmUHtgHrRBoUtS4_cv8gackqbDYoQQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 03/27] dt-bindings: arm: apple: Add bindings for
 Apple ARM platforms
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

On Thu, Mar 4, 2021 at 10:39 PM Hector Martin <marcan@marcan.st> wrote:

> This introduces bindings for all three 2020 Apple M1 devices:
>
> * apple,j274 - Mac mini (M1, 2020)
> * apple,j293 - MacBook Pro (13-inch, M1, 2020)
> * apple,j313 - MacBook Air (M1, 2020)
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

This way of specifying the SoC makes sense to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

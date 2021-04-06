Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92413559CB
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346696AbhDFQ44 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:56:56 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34517 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbhDFQ4z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 12:56:55 -0400
Received: by mail-ot1-f50.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so15314482otn.1;
        Tue, 06 Apr 2021 09:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tw0RwiCoCBJBLCCQqWVxF82QKnUlb6tubclo5gd7EQs=;
        b=FAi3EaISmRvoOVK+A/2FL5Jkp39dndzKJmBIYJ18R6/TnGJ5U+iqOfTc9mmZtZ/WbV
         otedU8fHCsHkYKICRwyU4Xnh5VO+a2m3cOnJFB8eboMlSFV3jj0akQdyZ4R+VUZiKk0J
         To/Dak85EJrvkA8pwdPcAq3DJOe7wIDkAi/2pfKlkGWKDkLQeW8eab7sJbwrk7a95AqM
         MG3m032nzM/LGsZJHks4X2yC/ItHYUxOfETBnrYseATR0h75DC7Pl1ypEu2eOG3ZT4ZX
         Fij3OFA/0OtkFjAvXZzjfBTCFqOdUMn3d8EkjCaBtyD+sjV+lw02bT16T4WxEnBRt0Qi
         bLqg==
X-Gm-Message-State: AOAM531xmR+KnP5k/z/l1pCTN7xKcI0AXvRqpMuY8R5b9G0FkwzetdSL
        niWxwrH8p287AFr2Ywrm4m8pbAt1Uw==
X-Google-Smtp-Source: ABdhPJwuTaLBj6OVzKDmR7D6lssAr7pKAt8+c7cwsu0N0mLd6fP4Ld2cWsAeBv7ptocA7Ga09sQE2w==
X-Received: by 2002:a9d:7086:: with SMTP id l6mr27135972otj.187.1617728207079;
        Tue, 06 Apr 2021 09:56:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a16sm4808802otk.62.2021.04.06.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:56:46 -0700 (PDT)
Received: (nullmailer pid 1960990 invoked by uid 1000);
        Tue, 06 Apr 2021 16:56:45 -0000
Date:   Tue, 6 Apr 2021 11:56:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/18] arm64: apple: Add initial Apple Mac mini (M1,
 2020) devicetree
Message-ID: <20210406165645.GA1942466@robh.at.kernel.org>
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-19-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402090542.131194-19-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 02, 2021 at 06:05:42PM +0900, Hector Martin wrote:
> This currently supports:
> 
> * SMP (via spin-tables)
> * AIC IRQs
> * Serial (with earlycon)
> * Framebuffer
> 
> A number of properties are dynamic, and based on system firmware
> decisions that vary from version to version. These are expected
> to be filled in by the loader.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                              |   1 +
>  arch/arm64/boot/dts/Makefile             |   1 +
>  arch/arm64/boot/dts/apple/Makefile       |   2 +
>  arch/arm64/boot/dts/apple/t8103-j274.dts |  45 ++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     | 135 +++++++++++++++++++++++
>  5 files changed, 184 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/Makefile
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-j274.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t8103.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>

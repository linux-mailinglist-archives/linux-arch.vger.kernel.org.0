Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3732E6C3
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCEKw2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:52:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50838 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCEKv6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:51:58 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI83o-0000i3-LV
        for linux-arch@vger.kernel.org; Fri, 05 Mar 2021 10:51:56 +0000
Received: by mail-wr1-f70.google.com with SMTP id z17so878062wrv.23
        for <linux-arch@vger.kernel.org>; Fri, 05 Mar 2021 02:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/nIKyVeLDjnLO0XxbWZvWwMQYyfC7R4FZ0wj435gLk=;
        b=C3FI5NipFrgGaEamYGbqsXH0Uj8s05eockbpX9x2amyBsXQHejNZqh1xbNTqsI3Rww
         QriV0yMc+z97CebywtwV9WJ0nVjYE6krIFQrx5aUZMN7fT9Hyj/EX6ZDXfA1Kk68yegF
         tK4ejs5IanLOzqLE8zo5Y0HWiLwBUBZ93rEbLkL4EAwUksaydjUR2x+Hggqi0o9TkXXD
         5pt1xclWZICSVF8YjaW9U/KwEmY02k89ReW8p+WusfDdcHbGOe0C988PzVqaWzKcFc6v
         wDzoEEuop9VN3/ZOys6atwY8D0zSLCteB6plbYKujSgOZ/3iM40sFl1KbiPKb0ZzKKF9
         F2UA==
X-Gm-Message-State: AOAM533e8+Ja7skULGfOy+FVk6nxdcb/qFYPiHUCHHzmueRN2Brq2gGJ
        WH27lLlGYmnPky5ifuOppZiddO/8mSwpSmmtUiMPEdu3xsX4KmzTAN0A488mxQZ947Y43RY8c5v
        xic0lV8Yz8uPnD2626pWEDMf+rDdCFargSXRLpHg=
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr8873168wrh.363.1614941516466;
        Fri, 05 Mar 2021 02:51:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSLx+ynSvyErVHtHDHShr+sqcaIVDFi0ZCngX/tDgR4DOKXKtYquKT+n+xo53Vaj5WTHxikg==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr8873154wrh.363.1614941516303;
        Fri, 05 Mar 2021 02:51:56 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id l21sm2344908wmg.41.2021.03.05.02.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:51:56 -0800 (PST)
Subject: Re: [RFT PATCH v3 21/27] tty: serial: samsung_tty: IRQ rework
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
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
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-22-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ed2ead63-5832-62fb-dd1b-4a64942678b1@canonical.com>
Date:   Fri, 5 Mar 2021 11:51:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-22-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/03/2021 22:38, Hector Martin wrote:
> * Split out s3c24xx_serial_tx_chars from s3c24xx_serial_tx_irq,
>   where only the latter acquires the port lock. This will be necessary
>   on platforms which have edge-triggered IRQs, as we need to call
>   s3c24xx_serial_tx_chars to kick off transmission from outside IRQ
>   context, with the port lock held.
> 
> * Rename s3c24xx_serial_rx_chars to s3c24xx_serial_rx_irq for
>   consistency with the above. All it does now is call two other
>   functions anyway.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 34 +++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

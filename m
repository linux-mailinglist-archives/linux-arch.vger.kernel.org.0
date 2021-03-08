Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0805D33193C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 22:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHVSO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 16:18:14 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:35067 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhCHVR6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Mar 2021 16:17:58 -0500
Received: by mail-io1-f45.google.com with SMTP id g27so11589124iox.2;
        Mon, 08 Mar 2021 13:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PdHqpmeEe/E5CzidwdhsZW8PHGiVau086Os6GE/Z0gQ=;
        b=q8Yh9MfZTfoH0+0Ic6c0XKu8UqUhiGPo2pK5+opwOBjHA1QtLjWJKrvoo+533Xujpc
         5CWxj3gRFnttZ/ozEim5F4MGGNr2PjRLr/IKjv6Yo4wkaG+b+tPYh9426k0Aq8+oER5E
         pLnCF/Ii1kGyz66Axqg0nPCe5YfGqCyKtyI4HUzy/FEkqDO2OsijLC+LGriK5dRc9c3I
         lCA0SF776by0vY3+BlL7IzlH2i5ePj2dQT06ujxEzTvVX8MoEunFBOPEoHj2XxgeQqMO
         sc1tavsWYFpFxNl1NtB3O5wNv8Wusngdcjgp5RASjbul//4fPYaDYScTx6dcWQmFCwtC
         vr8Q==
X-Gm-Message-State: AOAM531J7HUIqwawBQPLljJGlSFZS5f/MlyDMllv5mn0on3f6HKTeC2d
        gwGqubqAeWg/lEHM6Mt3Sg==
X-Google-Smtp-Source: ABdhPJxfCOB4IXJ8CBtDs3YFVp1DpbagK8on+CRElzgbLbnssOs6lMgEbZQpjBoOacX7jgm1MFWpqQ==
X-Received: by 2002:a02:c002:: with SMTP id y2mr25265336jai.107.1615238277658;
        Mon, 08 Mar 2021 13:17:57 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k14sm6465455iob.34.2021.03.08.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:17:57 -0800 (PST)
Received: (nullmailer pid 2971998 invoked by uid 1000);
        Mon, 08 Mar 2021 21:17:53 -0000
Date:   Mon, 8 Mar 2021 14:17:53 -0700
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Alexander Graf <graf@amazon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-serial@vger.kernel.org
Subject: Re: [RFT PATCH v3 23/27] dt-bindings: serial: samsung: Add
 apple,s5l-uart compatible
Message-ID: <20210308211753.GA2971963@robh.at.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-24-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-24-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 05 Mar 2021 06:38:58 +0900, Hector Martin wrote:
> Apple mobile devices originally used Samsung SoCs (starting with the
> S5L8900), and their current in-house SoCs continue to use compatible
> UART peripherals. We'll call this UART variant apple,s5l-uart.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

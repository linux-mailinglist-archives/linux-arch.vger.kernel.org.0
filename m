Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71532E67B
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCEKdg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:33:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEKdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:33:14 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI7j5-0007C8-8j
        for linux-arch@vger.kernel.org; Fri, 05 Mar 2021 10:30:31 +0000
Received: by mail-wr1-f69.google.com with SMTP id h21so850159wrc.19
        for <linux-arch@vger.kernel.org>; Fri, 05 Mar 2021 02:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJu6iNTkK4wSmf0pqRfj82yyDdC0OqRkZT1hSBnQXr8=;
        b=DdtjROOzgJdbAPkLwu2dqztek2GB4TL7TXGgBZQVdepyak2hj8ry90Ejo2Bqh8qcVV
         p8eYuuL+rPPz/BiX3NOKOTgQU6DjQ1IOr45AIxlzB4JyLuJTSEONVkjTMhndaFjegLID
         kUiyapccPkFZAa1kL+7irkrTLp0pARgvrw0ZiIUhAxgbeFnLoTjL30BwdU8UjzZOJ1cU
         yZE3aq1+V19Qxnl1tddg13WRdDfoUknZlNS6mjvGnv5/6T9zMD1LIbQcXMNDMoZ7CSDI
         6D3AC3ZvuHhsmTlkyjtU/NuqoRe5UwldY7A0SFu8TSDmiJFwrF3QDcUbs9tOizW3cOqc
         vVhw==
X-Gm-Message-State: AOAM532fY7hQIjzgP6hOrMDBAFbIuXQ9BgBtumPVgVMMhNSl6qUqYjsn
        e0kg33FQtgFXYzhoIaSSSJt5Rti2vnpFht6OKrA4ZhvYenAwAq7VqzFTc5kofXkd2SgPHxnx9e8
        vVmUzz6+BAWMgXNBv9z0psDlsmPaLTh8J7JW6b7s=
X-Received: by 2002:a1c:7714:: with SMTP id t20mr7981744wmi.107.1614940230674;
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy800OFDrvV/rynegL9gdp5sOoCnfFTAFviFAiUlwZkphbdPaIzFS7W/py4nWV80SKpjFhzmQ==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr7981727wmi.107.1614940230567;
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id 1sm3878530wmj.2.2021.03.05.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:30:30 -0800 (PST)
Subject: Re: [RFT PATCH v3 18/27] tty: serial: samsung_tty: Separate S3C64XX
 ops structure
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
 <20210304213902.83903-19-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <cf61a889-b84d-f788-52f2-9b68bcc83d52@canonical.com>
Date:   Fri, 5 Mar 2021 11:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-19-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 04/03/2021 22:38, Hector Martin wrote:
> Instead of patching a single global ops structure depending on the port
> type, use a separate s3c64xx_serial_ops for the S3C64XX type. This
> allows us to mark the structures as const.
> 
> Also split out s3c64xx_serial_shutdown into a separate function now that
> we have a separate ops structure; this avoids excessive branching
> control flow and mirrors s3c64xx_serial_startup. tx_claimed and
> rx_claimed are only used in the S3C24XX functions.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 71 ++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 17 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

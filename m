Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B432E6B2
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhCEKtn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:49:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50758 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEKta (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:49:30 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI81R-0000YS-60
        for linux-arch@vger.kernel.org; Fri, 05 Mar 2021 10:49:29 +0000
Received: by mail-wr1-f69.google.com with SMTP id e13so891078wrg.4
        for <linux-arch@vger.kernel.org>; Fri, 05 Mar 2021 02:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x355s57mqby7JDxFCF0HuhCS/cEaB4YomcQNrg8OfjI=;
        b=Lp0D0A/u1tcxd3s0VRyRP00eacJVkVtFX51pjwHNr8I4N4pg6LEkZzJDXpxSb9js5F
         7gTqHKYvQf9GsaO+qocmMqIp6jMVsArBobXowLlY6LclEsmstOw9juHOno1mUj9T0GWD
         wrGJIjZTbWiO0NRqMiOJgHGoqtGSHxLzXfujvO87QULTXxlhfSdqt4t8tn9u2GKPi1c1
         8Zt09phrornTzlsjABKA5m46grt7mzVCuPjjpaWslhDwGOgjhKwiUK9UAsoUlPX4h1i+
         dIuE7TtXFE3YlIfk9RhN8n4/qvj/k/NG5hTBVkBKnlwsgF1bAk5HytNO4Rfpa6aJkaK5
         VBag==
X-Gm-Message-State: AOAM531FEiynnjpxdeV73s4fSR7p12uAEgE1mfbyODLBh7L2ZNKNo+jo
        uBngkKGf3j/VNM9DDrkpCuX1ZIyXI4ILF/hQ8zv6r4Yw7Y0AcPY4xS6K/6h6NFl+e79tNgdnqdy
        Nf/a5wIybFXkwHUZLWP0kwSoH4g0xyFc82gBz7Ck=
X-Received: by 2002:adf:b609:: with SMTP id f9mr8296387wre.223.1614941368892;
        Fri, 05 Mar 2021 02:49:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYz6bNl1iPPftQcYDplqdzOSjyJy6jsc5Nui7+7tYXrGSPIMpQb+uLEy89c759e4pgLKfP3w==
X-Received: by 2002:adf:b609:: with SMTP id f9mr8296353wre.223.1614941368730;
        Fri, 05 Mar 2021 02:49:28 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id u4sm4084003wrm.24.2021.03.05.02.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:49:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [RFT PATCH v3 20/27] tty: serial: samsung_tty: Add
 s3c24xx_port_type
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
 <20210304213902.83903-21-marcan@marcan.st>
Message-ID: <079d64da-0e36-d626-fc45-0973519e0ee3@canonical.com>
Date:   Fri, 5 Mar 2021 11:49:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-21-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 04/03/2021 22:38, Hector Martin wrote:
> This decouples the TTY layer PORT_ types, which are exposed to
> userspace, from the driver-internal flag of what kind of port this is.

s/This decouples/Decouple

> 
> This removes s3c24xx_serial_has_interrupt_mask, which was just checking

s/This removes/Remove/

https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L89

This actually also applies to your patch 19 and 21... and maybe more.

> for a specific type anyway.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/tty/serial/samsung_tty.c | 112 +++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 42 deletions(-)
> 
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

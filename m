Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ADE330072
	for <lists+linux-arch@lfdr.de>; Sun,  7 Mar 2021 12:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhCGLmP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 7 Mar 2021 06:42:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49599 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhCGLmN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Mar 2021 06:42:13 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIrlU-0002KB-JX
        for linux-arch@vger.kernel.org; Sun, 07 Mar 2021 11:40:04 +0000
Received: by mail-lj1-f199.google.com with SMTP id k4so2822803ljg.0
        for <linux-arch@vger.kernel.org>; Sun, 07 Mar 2021 03:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IaOI6sfLur1cio+d1DvBU3jWRBzRJHEdk3id990OmYw=;
        b=o/qr0iUhvSU/P6+VaynKrV7hCjjpzzm+p1Z9XnR+gWyW7mSS2nM4ZX9U6vPTO0Eg8S
         /axzfngiRyO0b9z1trjARInQJOFt+XvSJsSZiKpMbdusn5vEUffdRhF51PTe74qFDyXi
         90OauG0fTFjO8Hm1i31OlZjW6JohsjwHebTJrm6aCCiyAwqKkL3sNk/LkeYRwE5uuD3Y
         /ShFzArS+Xz6TD2ytPIWdtE3KmmohvTBjISYRXPMIkjQFFp6HxyP3BCdMbNDkuA17/4o
         cSvbaPm+LdEYeP30DVlxqUcB8Xp8JXDEF8lVS+fvugT0J/KYvRvl/e+go9inuBIb2VTQ
         EtIQ==
X-Gm-Message-State: AOAM5319memomlMWsZ9e+dQsEfbcFe+AHIV/0iOr82OwWuHl4anhTG9+
        qByvs3kcwgB+x4jxAVJlwZxNuJ6aLrQO3bn5E6lIX0a6JaKjNXECVSbXWC8Lc1xKNWk3l5AEEIk
        E2kzFo094LO7hIqoz+NYJJGBMcDRmN+7YAW5wKFc=
X-Received: by 2002:a17:906:b884:: with SMTP id hb4mr10386013ejb.536.1615117203766;
        Sun, 07 Mar 2021 03:40:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzipGzDNC2m7qFZQL7/GmPd9oamLJ2JkMxfSm2OQXdsFLMxQXP2tUZ+TWwrEadIMtG963jLFg==
X-Received: by 2002:a17:906:b884:: with SMTP id hb4mr10385983ejb.536.1615117203555;
        Sun, 07 Mar 2021 03:40:03 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id x10sm4560734ejd.69.2021.03.07.03.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 03:40:03 -0800 (PST)
Subject: Re: [RFT PATCH v3 24/27] tty: serial: samsung_tty: Add support for
 Apple UARTs
To:     Hector Martin <marcan@marcan.st>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-25-marcan@marcan.st>
 <CAHp75VdFTHPfvdNUZEsn-qUCozASEGXeTDkTTUfOTqZ2TMsfiA@mail.gmail.com>
 <2ed7523f-5c11-976f-ac11-f756d7510400@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <b742457e-bf74-0e93-1d24-26f29a0b873a@canonical.com>
Date:   Sun, 7 Mar 2021 12:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <2ed7523f-5c11-976f-ac11-f756d7510400@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/03/2021 18:04, Hector Martin wrote:
> On 06/03/2021 00.28, Andy Shevchenko wrote:
>>> +       case TYPE_APPLE_S5L:
>>> +               WARN_ON(1); // No DMA
>>
>> Oh, no, please use the ONCE variant.
> 
> Thanks, changing this for v4.
> 
>>
>> ...
>>
>>> +       /* Apple types use these bits for IRQ masks */
>>> +       if (ourport->info->type != TYPE_APPLE_S5L) {
>>> +               ucon &= ~(S3C64XX_UCON_TIMEOUT_MASK |
>>> +                               S3C64XX_UCON_EMPTYINT_EN |
>>> +                               S3C64XX_UCON_DMASUS_EN |
>>> +                               S3C64XX_UCON_TIMEOUT_EN);
>>> +               ucon |= 0xf << S3C64XX_UCON_TIMEOUT_SHIFT |
>>
>> Can you spell 0xf with named constant(s), please?
>>
>> In case they are repetitive via the code, introduce either a temporary
>> variable (in case it scoped to one function only), or define it as a
>> constant.
> 
> I'm just moving this code; as far as I can tell this is a timeout value 
> (so just an integer), but I don't know if there is any special meaning 
> to 0xf here. Note that this codepath is for *non-Apple* chips, as the 
> Apple ones don't even have this field (at least not here).

I agree here with Hector. Andi, you propose here unrelated change (which
without documentation might not be doable by Hector).

> 
>>> +       irqreturn_t ret = IRQ_NONE;
>>
>> Redundant. You may return directly.
> 
> What if both interrupts are pending?
> 
>> No IO serialization?
> 
> There is no DMA on the Apple variants (as far as I know; it's not 
> implemented anyway), so there is no need for serializing IO with DMA. In 
> any case, dealing with that is the DMA code's job, the interrupt handler 
> shouldn't need to care.
> 
> If you mean serializing IO with the IRQ: CPU-wise, I would hope that's 
> the irqchip's job (AIC does this with a readl on the event). If you mean 
> ensuring all writes are complete (i.e. posted write issue), on the Apple 
> chips everything is non-posted as explained in the previous patches.
> 
>> Extra blank line (check your entire series for a such)
> 
> Thanks, noted. I'll check the declaration blocks in other patches.
> 
>>> +       ourport->rx_enabled = 1;
>>> +       ourport->tx_enabled = 0;
>>
>> How are these protected against race?
> 
> The serial core should be holding the port mutex for pretty much every 
> call into the driver, as far as I can tell.
> 
>>
>> ...
>>
>>> +               case TYPE_APPLE_S5L: {
>>> +                       unsigned int ucon;
>>> +                       int ret;
>>> +
>>> +                       ret = clk_prepare_enable(ourport->clk);
>>> +                       if (ret) {
>>> +                               dev_err(dev, "clk_enable clk failed: %d\n", ret);
>>> +                               return ret;
>>> +                       }
>>> +                       if (!IS_ERR(ourport->baudclk)) {
>>> +                               ret = clk_prepare_enable(ourport->baudclk);
>>> +                               if (ret) {
>>> +                                       dev_err(dev, "clk_enable baudclk failed: %d\n", ret);
>>> +                                       clk_disable_unprepare(ourport->clk);
>>> +                                       return ret;
>>> +                               }
>>> +                       }
>>
>> Wouldn't it be better to use CLK bulk API?
> 
> Ah, I guess that could save a line or two of code here, even though it 
> requires setting up the array. I'll give it a shot.
> 
>>> +#ifdef CONFIG_ARCH_APPLE
>>
>> Why? Wouldn't you like the one kernel to work on many SoCs?
> 
> This *adds* Apple support, it is not mutually exclusive with all the 
> other SoCs. You can enable all of those options and get a driver that 
> works on all of them. This is the same pattern used throughout the 
> driver for all the other Samsung variants. There is no reason to have 
> Apple SoC support in the samsung driver if the rest of the kernel 
> doesn't have Apple SoC support either, of course.

How ifdef on ARCH_APLLE makes it non-working on many SoCs? All new
platforms are multi... The true question is - do the ifdefs in the code
make it more difficult to read/review?

Best regards,
Krzysztof

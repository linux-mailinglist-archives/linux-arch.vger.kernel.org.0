Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4435E332FEE
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 21:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhCIUbI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 15:31:08 -0500
Received: from marcansoft.com ([212.63.210.85]:50810 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhCIUap (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 15:30:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 877E941A6E;
        Tue,  9 Mar 2021 20:30:25 +0000 (UTC)
Subject: Re: [RFT PATCH v3 17/27] arm64: Kconfig: Introduce CONFIG_ARCH_APPLE
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-18-marcan@marcan.st> <871rcpzmiv.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7bcc40fd-2105-9947-97f4-288e732758c7@marcan.st>
Date:   Wed, 10 Mar 2021 05:30:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <871rcpzmiv.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 09/03/2021 00.35, Marc Zyngier wrote:
> On Thu, 04 Mar 2021 21:38:52 +0000,
> Hector Martin <marcan@marcan.st> wrote:
>>
>> This adds a Kconfig option to toggle support for Apple ARM SoCs.
>> At this time this targets the M1 and later "Apple Silicon" Mac SoCs.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   arch/arm64/Kconfig.platforms | 8 ++++++++
>>   arch/arm64/configs/defconfig | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index cdfd5fed457f..c2b5791e3d69 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -36,6 +36,14 @@ config ARCH_ALPINE
>>   	  This enables support for the Annapurna Labs Alpine
>>   	  Soc family.
>>   
>> +config ARCH_APPLE
>> +	bool "Apple Silicon SoC family"
>> +	select APPLE_AIC
>> +	select ARM64_FIQ_SUPPORT
> 
> Do we still need this FIQ symbol? I though it was now gone...

Whoops! Thanks for the catch, this can go away.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

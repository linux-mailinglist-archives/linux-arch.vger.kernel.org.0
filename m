Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0532E70F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCELO0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 06:14:26 -0500
Received: from marcansoft.com ([212.63.210.85]:52272 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhCELOX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 06:14:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 714C03FA1B;
        Fri,  5 Mar 2021 11:14:12 +0000 (UTC)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
 <20210304213902.83903-28-marcan@marcan.st>
 <e45c15ae-ee81-139c-5da1-a6759e39fd71@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 27/27] arm64: apple: Add initial Apple Mac mini
 (M1, 2020) devicetree
Message-ID: <2a4c461a-51d1-60b7-b698-edb3c0bfb243@marcan.st>
Date:   Fri, 5 Mar 2021 20:14:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e45c15ae-ee81-139c-5da1-a6759e39fd71@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/03/2021 20.03, Krzysztof Kozlowski wrote:
>> +	memory@800000000 {
>> +		device_type = "memory";
>> +		reg = <0x8 0 0x2 0>; /* To be filled by loader */
> 
> Shouldn't this be 0x800000000 with ~0x80000000 length (or whatever is
> more common)? Or did I miss some ranges?

The base model has 8GB of RAM, and RAM always starts at 0x800000000, 
hence that reg property.

It's not actually useful to try to boot Linux like this, because it'll 
step all over device carveouts on both ends and break, but since those 
are potentially dynamic it doesn't really make sense to use a more 
specific example for the dts.

E.g. on my system, with my current firmware version, this ends up 
getting patched to:

reg = <0x8 0x0134c000 0x1 0xda294000>

Thanks,
-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7234A1B6
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 07:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCZGYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 02:24:01 -0400
Received: from [212.63.208.185] ([212.63.208.185]:44310 "EHLO
        mail.marcansoft.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229782AbhCZGXs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2021 02:23:48 -0400
X-Greylist: delayed 58547 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 02:23:46 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EA5CA425DF;
        Fri, 26 Mar 2021 06:23:32 +0000 (UTC)
Subject: Re: [RFT PATCH v3 13/27] arm64: Add Apple vendor-specific system
 registers
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
 <20210304213902.83903-14-marcan@marcan.st>
 <20210324183818.GF13181@willie-the-truck>
 <20210324185921.GA27297@C02TD0UTHF1T.local>
 <20210324190428.GG13181@willie-the-truck>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <00d7b1ea-b455-c443-d350-d71a432573e5@marcan.st>
Date:   Fri, 26 Mar 2021 15:23:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210324190428.GG13181@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25/03/2021 04.04, Will Deacon wrote:
> On Wed, Mar 24, 2021 at 06:59:21PM +0000, Mark Rutland wrote:
>> So far we've kept arch/arm64/ largely devoid of IMP-DEF bits, and it
>> seems a shame to add something with the sole purpose of collating that,
>> especially given arch code shouldn't need to touch these if FW and
>> bootloader have done their jobs right.
>>
>> Can we put the definitions in the relevant drivers? That would sidestep
>> any pain with MAINTAINERS, too.
> 
> If we can genuinely ignore these in arch code, then sure. I just don't know
> how long that is going to be the case, and ending up in a situation where
> these are scattered randomly throughout the tree sounds horrible to me.

I thought we would need some in KVM code, but given the direction Marc's 
series ended up in, it seems we won't. So I'm happy keeping these in the 
respective drivers; if this ends up being messy in the future it 
shouldn't be a big deal to refactor it all into one file again.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

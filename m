Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1763D333008
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhCIUga (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 15:36:30 -0500
Received: from marcansoft.com ([212.63.210.85]:52296 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhCIUgD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Mar 2021 15:36:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 49EFB41982;
        Tue,  9 Mar 2021 20:35:54 +0000 (UTC)
To:     Linus Walleij <linus.walleij@linaro.org>
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
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-27-marcan@marcan.st>
 <CACRpkdYzkOCurtLaeyZ+A6EWnSPGU66by4gYoCpLcn=52hTEPQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 26/27] dt-bindings: display: Add
 apple,simple-framebuffer
Message-ID: <c482f0ed-a0cf-5a87-b9f1-744a044fb44a@marcan.st>
Date:   Wed, 10 Mar 2021 05:35:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYzkOCurtLaeyZ+A6EWnSPGU66by4gYoCpLcn=52hTEPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/03/2021 01.37, Linus Walleij wrote:
> On Thu, Mar 4, 2021 at 10:42 PM Hector Martin <marcan@marcan.st> wrote:
> 
>> Apple SoCs run firmware that sets up a simplefb-compatible framebuffer
>> for us. Add a compatible for it, and two missing supported formats.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Marcan: tell me if you need me to apply this to the drm-misc tree
> and I'll fix it.

I think Arnd is okay merging this one through the SoC tree.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

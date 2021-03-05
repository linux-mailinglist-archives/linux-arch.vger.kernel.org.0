Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611CF32F102
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCERTl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 12:19:41 -0500
Received: from marcansoft.com ([212.63.210.85]:33278 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhCERTf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 12:19:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0610042037;
        Fri,  5 Mar 2021 17:19:25 +0000 (UTC)
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
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
 <20210304213902.83903-13-marcan@marcan.st>
 <CAHp75VdGYDDCRBRmd3O3Mt1opgDdwuRBoS1E=vaVc45h9eR-0w@mail.gmail.com>
 <04ea35d6-cd7d-d6de-75ae-59b1e0c77f04@marcan.st>
 <CAHp75Vd6adVM94G1vCrQcZoegQFWHbK14YRRuBTQZwrM5CV2jQ@mail.gmail.com>
 <CAK8P3a1X4DyWdeBM1Vx+QMXU7+VhJrLHFLVzwAE4a4mb_xuqMQ@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7c56c08f-9382-5db4-647a-1afae79c84de@marcan.st>
Date:   Sat, 6 Mar 2021 02:19:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1X4DyWdeBM1Vx+QMXU7+VhJrLHFLVzwAE4a4mb_xuqMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 01.43, Arnd Bergmann wrote:
> - setting ioremap() on PCI buses non-posted only makes them
>    only slower but not more reliable, because the non-posted flag
>    on the bus is discarded by the PCI host bridge.

Note that this doesn't work here *anyway*. The fabric is picky in both 
directions: thou shalt use nGnRnE for on-SoC MMIO and nGnRE for PCIe 
windows, or else, SError.

Since these devices can support *any* PCI device via Thunderbolt, making 
PCI drivers be the oddball ones needing special APIs would mean hundreds 
of changes needed - the vast majority of PCI drivers in the kernel use 
plain ioremap variants that don't have any flags to look at.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

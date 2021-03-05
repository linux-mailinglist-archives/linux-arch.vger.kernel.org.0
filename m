Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C170732E5DE
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCEKL3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhCEKLR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 05:11:17 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6788C061574;
        Fri,  5 Mar 2021 02:11:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2953542450;
        Fri,  5 Mar 2021 10:11:08 +0000 (UTC)
Subject: Re: [RFT PATCH v3 00/27] Apple M1 SoC platform bring-up
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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
From:   Hector Martin <marcan@marcan.st>
Message-ID: <7ab042aa-7969-a7d4-6ed1-23dc3428a271@marcan.st>
Date:   Fri, 5 Mar 2021 19:11:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/03/2021 06.38, Hector Martin wrote:
> == Merge notes ==
> 
> This patchset depends on both the nVHE changes that are already in
> 5.12-rc1, as well as the FIQ support work currently being reviewed
> at [1]. A tree containing this patchset on top of the required
> dependencies is available at [2][3]. Alternatively, you may apply
> this series on top of Mark's tree at the arm64-fiq-20210302 tag [4][5].

Important warning: these trees are all based on v5.12-rc1, which has a 
bad bug that causes your filesystems to go kaboom if you use a swap file 
[1].

This doesn't affect M1 since we don't *have* storage, but for folks 
testing for regressions on on e.g. Samsung or other ARM boards, please 
make sure you don't use swap files.

[1] 
https://lore.kernel.org/lkml/CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com/

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

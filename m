Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5903632F067
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhCEQvE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhCEQuc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 11:50:32 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63224C061574;
        Fri,  5 Mar 2021 08:50:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5A63A42037;
        Fri,  5 Mar 2021 16:50:22 +0000 (UTC)
Subject: Re: [RFT PATCH v3 27/27] arm64: apple: Add initial Apple Mac mini
 (M1, 2020) devicetree
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     krzysztof.kozlowski@canonical.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        robh@kernel.org, arnd@kernel.org, olof@lixom.net, tony@atomide.com,
        mohamed.mediouni@caramail.com, stan@corellium.com, graf@amazon.com,
        will@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com,
        andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, catalin.marinas@arm.com, hch@infradead.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-28-marcan@marcan.st>
 <e45c15ae-ee81-139c-5da1-a6759e39fd71@canonical.com>
 <2a4c461a-51d1-60b7-b698-edb3c0bfb243@marcan.st>
 <c1bc827f65e47744@bloch.sibelius.xs4all.nl>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <b81d3316-060a-8d52-b921-cfd8884d0895@marcan.st>
Date:   Sat, 6 Mar 2021 01:50:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c1bc827f65e47744@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/03/2021 00.59, Mark Kettenis wrote:
> It may be better to handle the memory reserved by the firmware using a
> "/reserved-memory" node.  I think the benefit of that could be that it
> communicates the entire range of physical memory to the kernel, which
> means it could use large mappings in the page tables.  Unless the
> "/reserved-memory" node defines a region that has the "no-map"
> property of course.

We actually need no-map, because otherwise the CPU could speculate its 
way into these carveouts (it's not just firmware, there's stuff in here 
the CPU really can't be allowed to touch, e.g. the SEP carveout). It 
also breaks simplefb mapping the framebuffer. I thought of the 
reserved-memory approach, but then figured it wouldn't buy us anything 
for this reason.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C059032EFA2
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCEQGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:06:20 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:59389 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCEQF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Mar 2021 11:05:59 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 11:05:58 EST
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 5a33bfea;
        Fri, 5 Mar 2021 16:59:15 +0100 (CET)
Date:   Fri, 5 Mar 2021 16:59:15 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
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
In-Reply-To: <2a4c461a-51d1-60b7-b698-edb3c0bfb243@marcan.st> (message from
        Hector Martin on Fri, 5 Mar 2021 20:14:10 +0900)
Subject: Re: [RFT PATCH v3 27/27] arm64: apple: Add initial Apple Mac mini
 (M1, 2020) devicetree
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-28-marcan@marcan.st>
 <e45c15ae-ee81-139c-5da1-a6759e39fd71@canonical.com> <2a4c461a-51d1-60b7-b698-edb3c0bfb243@marcan.st>
Message-ID: <c1bc827f65e47744@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Fri, 5 Mar 2021 20:14:10 +0900
> 
> On 05/03/2021 20.03, Krzysztof Kozlowski wrote:
> >> +	memory@800000000 {
> >> +		device_type = "memory";
> >> +		reg = <0x8 0 0x2 0>; /* To be filled by loader */
> > 
> > Shouldn't this be 0x800000000 with ~0x80000000 length (or whatever is
> > more common)? Or did I miss some ranges?
> 
> The base model has 8GB of RAM, and RAM always starts at 0x800000000, 
> hence that reg property.
> 
> It's not actually useful to try to boot Linux like this, because it'll 
> step all over device carveouts on both ends and break, but since those 
> are potentially dynamic it doesn't really make sense to use a more 
> specific example for the dts.
> 
> E.g. on my system, with my current firmware version, this ends up 
> getting patched to:
> 
> reg = <0x8 0x0134c000 0x1 0xda294000>

It may be better to handle the memory reserved by the firmware using a
"/reserved-memory" node.  I think the benefit of that could be that it
communicates the entire range of physical memory to the kernel, which
means it could use large mappings in the page tables.  Unless the
"/reserved-memory" node defines a region that has the "no-map"
property of course.

That doesn't really have an impact on this diff though.  The
firmware/bootloader would still have to modify the property on 16GB
models.

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746EE330C2B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 12:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCHLVT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 06:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231784AbhCHLVC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 06:21:02 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCA0650F2;
        Mon,  8 Mar 2021 11:21:01 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lJDwY-000JZJ-8b; Mon, 08 Mar 2021 11:20:58 +0000
Date:   Mon, 08 Mar 2021 11:20:57 +0000
Message-ID: <87a6rdzyau.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Hector Martin <marcan@marcan.st>
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
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h:  Add a non-posted variant of ioremap()
In-Reply-To: <20210304213902.83903-9-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
        <20210304213902.83903-9-marcan@marcan.st>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: marcan@marcan.st, linux-arm-kernel@lists.infradead.org, robh@kernel.org, arnd@kernel.org, olof@lixom.net, krzk@kernel.org, mark.kettenis@xs4all.nl, tony@atomide.com, mohamed.mediouni@caramail.com, stan@corellium.com, graf@amazon.com, will@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com, andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, corbet@lwn.net, catalin.marinas@arm.com, hch@infradead.org, davem@davemloft.net, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 04 Mar 2021 21:38:43 +0000,
Hector Martin <marcan@marcan.st> wrote:
> 
> ARM64 currently defaults to posted MMIO (nGnRnE), but some devices
> require the use of non-posted MMIO (nGnRE). Introduce a new ioremap()
> variant to handle this case. ioremap_np() is aliased to ioremap() by
> default on arches that do not implement this variant.
> 
> sparc64 is the only architecture that needs to be touched directly,
> because it includes neither of the generic io.h or iomap.h headers.
> 
> This adds the IORESOURCE_MEM_NONPOSTED flag, which maps to this
> variant and marks a given resource as requiring non-posted mappings.
> This is implemented in the resource system because it is a SoC-level
> requirement, so existing drivers do not need special-case code to pick
> this ioremap variant.
> 
> Then this is implemented in devres by introducing devm_ioremap_np(),
> and making devm_ioremap_resource() automatically select this variant
> when the resource has the IORESOURCE_MEM_NONPOSTED flag set.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

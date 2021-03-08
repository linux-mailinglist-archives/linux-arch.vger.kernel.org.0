Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF6331455
	for <lists+linux-arch@lfdr.de>; Mon,  8 Mar 2021 18:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHROr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Mar 2021 12:14:47 -0500
Received: from muru.com ([72.249.23.125]:41138 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhCHRO2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Mar 2021 12:14:28 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7368280D4;
        Mon,  8 Mar 2021 17:15:06 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:14:21 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
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
Subject: Re: [RFT PATCH v3 06/27] dt-bindings: timer: arm,arch_timer: Add
 interrupt-names support
Message-ID: <YEZbbe7dFIuPja3u@atomide.com>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-7-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-7-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Hector Martin <marcan@marcan.st> [210304 21:40]:
> Not all platforms provide the same set of timers/interrupts, and Linux
> only needs one (plus kvm/guest ones); some platforms are working around
> this by using dummy fake interrupts. Implementing interrupt-names allows
> the devicetree to specify an arbitrary set of available interrupts, so
> the timer code can pick the right one.
> 
> This also adds the hyp-virt timer/interrupt, which was previously not
> expressed in the fixed 4-interrupt form.

I like this one too:

Reviewed-by: Tony Lindgren <tony@atomide.com>

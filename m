Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4F348065
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhCXSYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237532AbhCXSYD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:24:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AC2C61923;
        Wed, 24 Mar 2021 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616610242;
        bh=K6oHNv+C7LY+kAhzbl3PH+/kTu3OVjYksdUZOBHFlLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKt+MCQzHYhfjqUgacgIFrJphqDrv1Ohu4AIGdvpFurBScBaJjDll3mZalfUguou0
         D+UymlPgk6SPAtFY/tg8jfWe7ktbau3fj4JqqAGepn5WkxoPDHDRk3/Dg2etkgycQv
         B9Bc4YgGOUCyscy2AS2fUwl9hGSoB2FV8UGZWN0EL652pnnjP210+rCXaW/uRv9dU8
         uXfI9Pe3t5Idmq4bfVv5mj9KDAiwKdTmY7xrMxtCFc/1QQ519ap8BTIwBfby74g1DV
         K23ZCo4Xdr6HtfqgQ9Gj573yQ8rKnX2Uh70JgA6/Mz4uLUW9PduLcbjWsAHO8zdJnv
         s5BIhlSmLU3qQ==
Date:   Wed, 24 Mar 2021 18:23:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Hector Martin <marcan@marcan.st>
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
Subject: Re: [RFT PATCH v3 14/27] arm64: move ICH_ sysreg bits from
 arm-gic-v3.h to sysreg.h
Message-ID: <20210324182355.GE13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-15-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-15-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:49AM +0900, Hector Martin wrote:
> These definitions are in arm-gic-v3.h for historical reasons which no
> longer apply. Move them to sysreg.h so the AIC driver can use them, as
> it needs to peek into vGIC registers to deal with the GIC maintentance
> interrupt.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/include/asm/sysreg.h    | 60 ++++++++++++++++++++++++++++++
>  include/linux/irqchip/arm-gic-v3.h | 56 ----------------------------
>  2 files changed, 60 insertions(+), 56 deletions(-)

This would be much easier to remove if you just moved the definitions,
rather than reordered than and changed the comments at the same time!

But I *think* nothing had changed, so:

Acked-by: Will Deacon <will@kernel.org>

Will

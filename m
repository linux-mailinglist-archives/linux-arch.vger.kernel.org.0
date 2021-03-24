Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB173480B3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbhCXSi6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237595AbhCXSi0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B161761A16;
        Wed, 24 Mar 2021 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616611105;
        bh=2goQGhK9s/vJ0sA2UDpMJYC1frOuoZRBT/P1ep5MeLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jY7ScJi+1viiIuWHbYWQ14rsshc4fwsLFktskMndtqTZ3QMnvrFERgftm0Zu1HkB2
         U4M0Ja4iFHE8fT1hLWeMFrAQ3k2UdAph17ovXmz9vIvgifvoLQaqW72X5xtAKpxnSB
         M5t1tU43Itok8Iy5znf/PSLu6gZW/HsVtachVXTXETj1TXjmqCPFngQvAa7Hcz3tvr
         Kd9fcGrUa2wo9Nf7hY4YHh4WL+wKOw4zDUJ2kG6dDC5T99LlO+VpYk39aJMwKFjRDw
         u3kb6uwO5hHl0r6AOSTfcdWetfFlkbYIhDzCM8/XkoKukCVojeiriXwCZntSDQro95
         dY1I923BXMANg==
Date:   Wed, 24 Mar 2021 18:38:18 +0000
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
Subject: Re: [RFT PATCH v3 13/27] arm64: Add Apple vendor-specific system
 registers
Message-ID: <20210324183818.GF13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-14-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-14-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:48AM +0900, Hector Martin wrote:
> Apple ARM64 SoCs have a ton of vendor-specific registers we're going to
> have to deal with, and those don't really belong in sysreg.h with all
> the architectural registers. Make a new home for them, and add some
> registers which are useful for early bring-up.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  MAINTAINERS                           |  1 +
>  arch/arm64/include/asm/sysreg_apple.h | 69 +++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 arch/arm64/include/asm/sysreg_apple.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aec14fbd61b8..3a352c687d4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1646,6 +1646,7 @@ B:	https://github.com/AsahiLinux/linux/issues
>  C:	irc://chat.freenode.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
> +F:	arch/arm64/include/asm/sysreg_apple.h

(this isn't needed with my suggestion below).

>  ARM/ARTPEC MACHINE SUPPORT
>  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> diff --git a/arch/arm64/include/asm/sysreg_apple.h b/arch/arm64/include/asm/sysreg_apple.h
> new file mode 100644
> index 000000000000..48347a51d564
> --- /dev/null
> +++ b/arch/arm64/include/asm/sysreg_apple.h

I doubt apple are the only folks doing this, so can we instead have
sysreg-impdef.h please, and then have an Apple section in there for these
registers? That way, we could also have an imp_sys_reg() macro to limit
CRn to 11 or 15, which is the reserved encoding space for these registers.

We'll cc you for any patches touching the Apple parts, as we don't have
the first clue about what's hiding in there.

> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Apple SoC vendor-defined system register definitions
> + *
> + * Copyright The Asahi Linux Contributors
> +
> + * This file contains only well-understood registers that are useful to
> + * Linux. If you are looking for things to add here, you should visit:
> + *
> + * https://github.com/AsahiLinux/docs/wiki/HW:ARM-System-Registers
> + */
> +
> +#ifndef __ASM_SYSREG_APPLE_H
> +#define __ASM_SYSREG_APPLE_H
> +
> +#include <asm/sysreg.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +
> +/*
> + * Keep these registers in encoding order, except for register arrays;
> + * those should be listed in array order starting from the position of
> + * the encoding of the first register.
> + */
> +
> +#define SYS_APL_PMCR0_EL1		sys_reg(3, 1, 15, 0, 0)
> +#define PMCR0_IMODE			GENMASK(10, 8)
> +#define PMCR0_IMODE_OFF			0
> +#define PMCR0_IMODE_PMI			1
> +#define PMCR0_IMODE_AIC			2
> +#define PMCR0_IMODE_HALT		3
> +#define PMCR0_IMODE_FIQ			4
> +#define PMCR0_IACT			BIT(11)

The Arm ARM says this about imp-def sysregs:

  | The Arm architecture guarantees not to define any register name
  | prefixed with IMP_ as part of the standard Arm architecture.
  |
  | Note
  | Arm strongly recommends that any register names created in the
  | IMPLEMENTATION DEFINED register spaces be prefixed with IMP_ and
  | postfixed with _ELx, where appropriate.

and it seems like we could follow that here without much effort, if you
don't mind.

Will

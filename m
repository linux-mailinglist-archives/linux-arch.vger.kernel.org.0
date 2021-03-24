Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFF348023
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhCXSN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237271AbhCXSNw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:13:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0856061A21;
        Wed, 24 Mar 2021 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616609632;
        bh=X7ZZ1K8yRlc3sjxUN2zWkg4HnGzejqNeoIB193YqAuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiJEkfaTP+Uen8vZPx08TZfz2O4B2E4Jbts1WzbndAkPMUEMQoJvrsnN+U/bJLmTH
         pVTA0/r7Gk0GCF9whuI4YmGzO/o72dZazKNuHqd7bV0DpFEef719sLvvwKvY9iAr7q
         +qBXqQLp04H4DkhH62GKRNonA49dLZ8Tw2H2gLrTcnr7O/KfCadLbfk3cdO+2Fo1cX
         32toJLHE9ebuAzNP1NiAdbSrgCi6aIgsbZLbp7vFajnFvOM2CCwwuWmTdupZsf86zU
         4z63TEn3XKszEZPlQfMx8zAufv562PnxYYKJLLOTIGXaKCt4ISmf7Y5AZ3EM2Z4ne2
         JT2COynBoTLrQ==
Date:   Wed, 24 Mar 2021 18:13:44 +0000
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
Subject: Re: [RFT PATCH v3 05/27] arm64: cputype: Add CPU implementor & types
 for the Apple M1 cores
Message-ID: <20210324181344.GC13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-6-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-6-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:40AM +0900, Hector Martin wrote:
> The implementor will be used to condition the FIQ support quirk.
> 
> The specific CPU types are not used at the moment, but let's add them
> for documentation purposes.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/include/asm/cputype.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index ef5b040dee44..6231e1f0abe7 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -59,6 +59,7 @@
>  #define ARM_CPU_IMP_NVIDIA		0x4E
>  #define ARM_CPU_IMP_FUJITSU		0x46
>  #define ARM_CPU_IMP_HISI		0x48
> +#define ARM_CPU_IMP_APPLE		0x61
>  
>  #define ARM_CPU_PART_AEM_V8		0xD0F
>  #define ARM_CPU_PART_FOUNDATION		0xD00
> @@ -99,6 +100,9 @@
>  
>  #define HISI_CPU_PART_TSV110		0xD01
>  
> +#define APPLE_CPU_PART_M1_ICESTORM	0x022
> +#define APPLE_CPU_PART_M1_FIRESTORM	0x023
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -127,6 +131,8 @@
>  #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
>  #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>  #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
> +#define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
> +#define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)

We usually only merge these when they're needed, but this SoC seems broken
enough that I can see the value in having them from the start :(

Acked-by: Will Deacon <will@kernel.org>

Will

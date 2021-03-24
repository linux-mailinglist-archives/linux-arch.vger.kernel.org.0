Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F5348019
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhCXSMy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237398AbhCXSMS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3F2E61A24;
        Wed, 24 Mar 2021 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616609537;
        bh=MgoXkuObURmUvWuUKdbb9OKYxXjUYO+tnI1HEsW+seM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNZOeiggKvkMd+AmGZyu+AydOXj83oW7ynub4lSjobGEDAnsD4JxGyit4ES49Whfn
         5cXGZJghwajWlTjP3zlctOgas7fnf3F3un2ilMpJ/P2q6GMlHdr6ee00HjzDJmoluZ
         dHQqSr8W02oQUOk2/2fyxniJDNik2LrlSoGDiBIZ14EAiPBC823Hg3Xd31LOZ/r2pd
         JF9jdN36strHOO2F5uVdPNeFJk2Jc56insBYw3zAl8h/30SYdCIBZcyKJseZ0cZ1CR
         s1zSjGNVmWnJNd2rVhYpT2B2+0SkopHJmG49IP6kxbQERGweAlxHfPIHBjMMSn0G3p
         aD6VdTjdhpG0w==
Date:   Wed, 24 Mar 2021 18:12:10 +0000
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
Subject: Re: [RFT PATCH v3 08/27] asm-generic/io.h:  Add a non-posted variant
 of ioremap()
Message-ID: <20210324181210.GB13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-9-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-9-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:43AM +0900, Hector Martin wrote:
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
> ---
>  .../driver-api/driver-model/devres.rst        |  1 +
>  arch/sparc/include/asm/io_64.h                |  4 ++++
>  include/asm-generic/io.h                      | 22 ++++++++++++++++++-
>  include/asm-generic/iomap.h                   |  9 ++++++++
>  include/linux/io.h                            |  2 ++
>  include/linux/ioport.h                        |  1 +
>  lib/devres.c                                  | 22 +++++++++++++++++++
>  7 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index cd8b6e657b94..2f45877a539d 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -309,6 +309,7 @@ IOMAP
>    devm_ioremap()
>    devm_ioremap_uc()
>    devm_ioremap_wc()
> +  devm_ioremap_np()
>    devm_ioremap_resource() : checks resource, requests memory region, ioremaps
>    devm_ioremap_resource_wc()
>    devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index 9bb27e5c22f1..9fbfc9574432 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -409,6 +409,10 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>  #define ioremap_uc(X,Y)			ioremap((X),(Y))
>  #define ioremap_wc(X,Y)			ioremap((X),(Y))
>  #define ioremap_wt(X,Y)			ioremap((X),(Y))
> +static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
> +{
> +	return NULL;
> +}
>  
>  static inline void iounmap(volatile void __iomem *addr)
>  {
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index c6af40ce03be..082e0c96db6e 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -942,7 +942,9 @@ static inline void *phys_to_virt(unsigned long address)
>   *
>   * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
>   * for specific drivers if the architecture choses to implement them.  If they
> - * are not implemented we fall back to plain ioremap.
> + * are not implemented we fall back to plain ioremap. Conversely, ioremap_np()
> + * can provide stricter non-posted write semantics if the architecture
> + * implements them.
>   */
>  #ifndef CONFIG_MMU
>  #ifndef ioremap
> @@ -993,6 +995,24 @@ static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
>  {
>  	return NULL;
>  }
> +
> +/*
> + * ioremap_np needs an explicit architecture implementation, as it
> + * requests stronger semantics than regular ioremap(). Portable drivers
> + * should instead use one of the higher-level abstractions, like
> + * devm_ioremap_resource(), to choose the correct variant for any given
> + * device and bus. Portable drivers with a good reason to want non-posted
> + * write semantics should always provide an ioremap() fallback in case
> + * ioremap_np() is not available.
> + */
> +#ifndef ioremap_np
> +#define ioremap_np ioremap_np
> +static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
> +{
> +	return NULL;
> +}
> +#endif

Can we implement the generic pci_remap_cfgspace() in terms of ioremap_np()
if it is supported by the architecture? That way, we could avoid defining
both on arm64.

Will

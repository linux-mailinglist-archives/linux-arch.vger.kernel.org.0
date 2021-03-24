Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CEA34803D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbhCXSSW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237451AbhCXSSM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:18:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53D9261A1E;
        Wed, 24 Mar 2021 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616609891;
        bh=jLEIjTDMdOEnl8/SfGx6/gltYIIdLbMFJhqthmu7sWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbVwO873llNdsjRRLI+J5vMaoN88DXm+jw+j0sUIZBUclPpTb7Ziu4k6wnsHNiCfF
         Pm2+8JW+mzLubs4Qy/nr2Bk6fhTTesVy3I2z9ELtOFs5HGiaC5QBnIfT3k5o/JzCZm
         Ic42bD5UwJKGUYYHQspuAp5GKrQ60c3dz+5EGEwi1k6ZI7Kx9PkjQEdrNeaBoO8Yhb
         jBw6AICm26Y35MtNLuYn7lyHgfMwRX/Fp97hFQKLceiZRFcnCy5y/YHi8ZYFr7e/xI
         wWLImdBodOm9uRF/OdDCIZd0jNPTDFT32jtdH9eLMTF9V/7O66u5riEBqlrYUlKpOO
         8yaOV23QpmtAQ==
Date:   Wed, 24 Mar 2021 18:18:04 +0000
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
Subject: Re: [RFT PATCH v3 11/27] arm64: Implement ioremap_np() to map MMIO
 as nGnRnE
Message-ID: <20210324181803.GD13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-12-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-12-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:46AM +0900, Hector Martin wrote:
> This is used on Apple ARM platforms, which require most MMIO
> (except PCI devices) to be mapped as nGnRnE.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 5ea8656a2030..953b8703af60 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -169,6 +169,7 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>  
>  #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
>  #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
> +#define ioremap_np(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))

Probably worth noting that whether or not this actually results in a
non-posted mapping depends on the system architecture, but this is the
best we can do, so:

Acked-by: Will Deacon <will@kernel.org>

I would personally prefer that drivers didn't have to care about this, and
ioremap on arm64 figured out the right attributes based on the region being
mapped, but I haven't followed the discussion closely so I won't die on that
hill.

Will

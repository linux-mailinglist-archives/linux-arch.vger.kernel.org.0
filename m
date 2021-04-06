Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8035598A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhDFQr7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 12:47:59 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:44911 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbhDFQr7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2021 12:47:59 -0400
Received: by mail-oo1-f49.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so3834382oom.11;
        Tue, 06 Apr 2021 09:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KsEFQn5ynPj9Q6od5ymvE84NEzlALObqjlPA4SQWRs8=;
        b=Caw06k2MWg1OwP78wZ8gxa1iBXixjWgwRK2lx5HicQ+kWOMh530QGvjE3JBelhmRd0
         l07PZY89Xc+IP2Fe3Q07P00Zrud9P99oyC3rVkj5hNHogjeFOs2WXWYX6NHrkcS77WDB
         P94qXGk/+0YrRAgXMMq1WAsVWu8yQuFD3GSljzjKlW2YkKn3Ln9bZZmwVfedZBvP9wye
         sb+bJ+cmCDA7UEeKzcLBmFvfHHy+K6I9ZkNz1T//ij1po0BAvYPxqH/ngulIh+neVnwM
         dBeZx5xLXFV3/2z9Ru2STWfxz+G2LpmUaRNkVTanJflI0gOfcrhU00ZS71tPKGEe4II+
         yk1w==
X-Gm-Message-State: AOAM533bh+Z9JfB6jSH1+OBEj7zpjZAA7gedjUbhfsCpclV+KT8gGytY
        EzrbMCvb+rUCHrDKj0jiVw==
X-Google-Smtp-Source: ABdhPJwPZn4vyuV4WbEQb7jrirEmMI3mRcpb+G+wNqe7KnEHeN8KG33o//cShwHkWNjdpn2Mmze2sA==
X-Received: by 2002:a4a:d354:: with SMTP id d20mr27213126oos.12.1617727670969;
        Tue, 06 Apr 2021 09:47:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m16sm4687480otj.11.2021.04.06.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:47:50 -0700 (PDT)
Received: (nullmailer pid 1942347 invoked by uid 1000);
        Tue, 06 Apr 2021 16:47:48 -0000
Date:   Tue, 6 Apr 2021 11:47:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
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
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/18] of/address: Add infrastructure to declare MMIO
 as non-posted
Message-ID: <20210406164748.GA1937719@robh.at.kernel.org>
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-13-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402090542.131194-13-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 02, 2021 at 06:05:36PM +0900, Hector Martin wrote:
> This implements the 'nonposted-mmio' boolean property. Placing this
> property in a bus marks all direct child devices as requiring
> non-posted MMIO mappings. If no such property is found, the default
> is posted MMIO.
> 
> of_mmio_is_nonposted() performs this check to determine if a given
> device has requested non-posted MMIO.
> 
> of_address_to_resource() uses this to set the IORESOURCE_MEM_NONPOSTED
> flag on resources that require non-posted MMIO.
> 
> of_iomap() and of_io_request_and_map() then use this flag to pick the
> correct ioremap() variant.
> 
> This mechanism is currently restricted to builds that support Apple ARM
> platforms, as an optimization.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/of/address.c       | 43 ++++++++++++++++++++++++++++++++++++--
>  include/linux/of_address.h |  1 +
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 73ddf2540f3f..6485cc536e81 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -847,6 +847,9 @@ static int __of_address_to_resource(struct device_node *dev,
>  		return -EINVAL;
>  	memset(r, 0, sizeof(struct resource));
>  
> +	if (of_mmio_is_nonposted(dev))
> +		flags |= IORESOURCE_MEM_NONPOSTED;
> +
>  	r->start = taddr;
>  	r->end = taddr + size - 1;
>  	r->flags = flags;
> @@ -896,7 +899,10 @@ void __iomem *of_iomap(struct device_node *np, int index)
>  	if (of_address_to_resource(np, index, &res))
>  		return NULL;
>  
> -	return ioremap(res.start, resource_size(&res));
> +	if (res.flags & IORESOURCE_MEM_NONPOSTED)
> +		return ioremap_np(res.start, resource_size(&res));
> +	else
> +		return ioremap(res.start, resource_size(&res));
>  }
>  EXPORT_SYMBOL(of_iomap);
>  
> @@ -928,7 +934,11 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
>  	if (!request_mem_region(res.start, resource_size(&res), name))
>  		return IOMEM_ERR_PTR(-EBUSY);
>  
> -	mem = ioremap(res.start, resource_size(&res));
> +	if (res.flags & IORESOURCE_MEM_NONPOSTED)
> +		mem = ioremap_np(res.start, resource_size(&res));
> +	else
> +		mem = ioremap(res.start, resource_size(&res));
> +
>  	if (!mem) {
>  		release_mem_region(res.start, resource_size(&res));
>  		return IOMEM_ERR_PTR(-ENOMEM);
> @@ -1094,3 +1104,32 @@ bool of_dma_is_coherent(struct device_node *np)
>  	return false;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> +
> +/**
> + * of_mmio_is_nonposted - Check if device uses non-posted MMIO
> + * @np:	device node
> + *
> + * Returns true if the "nonposted-mmio" property was found for
> + * the device's bus.
> + *
> + * This is currently only enabled on builds that support Apple ARM devices, as
> + * an optimization.
> + */
> +bool of_mmio_is_nonposted(struct device_node *np)
> +{
> +	struct device_node *parent;
> +	bool nonposted;
> +
> +	if (!IS_ENABLED(CONFIG_ARCH_APPLE))
> +		return false;
> +
> +	parent = of_get_parent(np);
> +	if (!parent)
> +		return false;
> +
> +	nonposted = of_property_read_bool(parent, "nonposted-mmio");
> +
> +	of_node_put(parent);
> +	return nonposted;
> +}
> +EXPORT_SYMBOL_GPL(of_mmio_is_nonposted);

Is this needed outside of of/address.c? If not, please make it static 
and don't export.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

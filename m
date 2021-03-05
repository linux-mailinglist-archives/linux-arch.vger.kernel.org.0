Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E325732F17F
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 18:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCERja (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 12:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhCERjU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 12:39:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE85650B8;
        Fri,  5 Mar 2021 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614965960;
        bh=oz8CD8mvufDaXgeo9mikhjqwRzUNd/xTiJlDKiwqo+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1TUctQLA3uKWLY+vhn7k0GJv2v8RrxaGt/HVE+BNEuZyHVMSEGgJp0JXacLRfEW7
         ylRE5yuRqRQBJvWKQt/tEclnnbCm8OOc6JcTnsluGlDnd4HgvzkQpAo5RsS6Cnwh3t
         yvyTAQg83o3eA/844YgMB7/HI24xQZEI0ol2sKjzaLrEWGQ8shLYy0WAx+940aXWW7
         5sRXwFlASk1IpiI7caprYSJS9KxsSOJe30cucqIbdOlx/xemVzWzubWWnZx3Jz57h6
         dMusKgQOIhqeST+Mp/7u3gf5cFCPx9JZNwQbynNNa6/M6DcLbiLEY2+weCMXL7Nahx
         yq8vU11d1r9QA==
Received: by mail-ej1-f50.google.com with SMTP id mj10so5056715ejb.5;
        Fri, 05 Mar 2021 09:39:19 -0800 (PST)
X-Gm-Message-State: AOAM530VKm3v0Qm2XflhDAR9+VL3gPYjyq7HfXjOvAsU0KCRKVY7VyAx
        Z0mIK3L9PnmjYK6nA3lGHKx5MUYdA0ezAzVrbA==
X-Google-Smtp-Source: ABdhPJzNB9E/zgO7udUBiscc4v/up3iTv8YfHuuMDmpq5J4Nv3xNBjZ0s4wgvMRYuy6Lh2LXgZIPKLpFMilMKPS8/Q8=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr3294522ejb.359.1614965958236;
 Fri, 05 Mar 2021 09:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20210304213902.83903-1-marcan@marcan.st> <20210304213902.83903-13-marcan@marcan.st>
In-Reply-To: <20210304213902.83903-13-marcan@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 5 Mar 2021 11:39:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
Message-ID: <CAL_JsqJF2Hz=4U7FR_GOSjCxqt3dpf-CAWFNfsSrDjDLpHqgCA@mail.gmail.com>
Subject: Re: [RFT PATCH v3 12/27] of/address: Add infrastructure to declare
 MMIO as non-posted
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 4, 2021 at 3:40 PM Hector Martin <marcan@marcan.st> wrote:
>
> This implements the 'nonposted-mmio' and 'posted-mmio' boolean
> properties. Placing these properties in a bus marks all child devices as
> requiring non-posted or posted MMIO mappings. If no such properties are
> found, the default is posted MMIO.

I'm still a little hesitant to add these properties and having some
default. I worry about a similar situation as 'dma-coherent' where the
assumed default on non-coherent on Arm doesn't work for PowerPC which
defaults coherent. More below on this.

> of_mmio_is_nonposted() performs the tree walking to determine if a given
> device has requested non-posted MMIO.
>
> of_address_to_resource() uses this to set the IORESOURCE_MEM_NONPOSTED
> flag on resources that require non-posted MMIO.
>
> of_iomap() and of_io_request_and_map() then use this flag to pick the
> correct ioremap() variant.
>
> This mechanism is currently restricted to Apple ARM platforms, as an
> optimization.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/of/address.c       | 72 ++++++++++++++++++++++++++++++++++++--
>  include/linux/of_address.h |  1 +
>  2 files changed, 71 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 73ddf2540f3f..6114dceb1ba6 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -847,6 +847,9 @@ static int __of_address_to_resource(struct device_node *dev,
>                 return -EINVAL;
>         memset(r, 0, sizeof(struct resource));
>
> +       if (of_mmio_is_nonposted(dev))
> +               flags |= IORESOURCE_MEM_NONPOSTED;
> +
>         r->start = taddr;
>         r->end = taddr + size - 1;
>         r->flags = flags;
> @@ -896,7 +899,10 @@ void __iomem *of_iomap(struct device_node *np, int index)
>         if (of_address_to_resource(np, index, &res))
>                 return NULL;
>
> -       return ioremap(res.start, resource_size(&res));
> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> +               return ioremap_np(res.start, resource_size(&res));
> +       else
> +               return ioremap(res.start, resource_size(&res));

This and the devm variants all scream for a ioremap_extended()
function. IOW, it would be better if the ioremap flavor was a
parameter. Unless we could implement that just for arm64 first, that's
a lot of refactoring...

>  }
>  EXPORT_SYMBOL(of_iomap);
>
> @@ -928,7 +934,11 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
>         if (!request_mem_region(res.start, resource_size(&res), name))
>                 return IOMEM_ERR_PTR(-EBUSY);
>
> -       mem = ioremap(res.start, resource_size(&res));
> +       if (res.flags & IORESOURCE_MEM_NONPOSTED)
> +               mem = ioremap_np(res.start, resource_size(&res));
> +       else
> +               mem = ioremap(res.start, resource_size(&res));
> +
>         if (!mem) {
>                 release_mem_region(res.start, resource_size(&res));
>                 return IOMEM_ERR_PTR(-ENOMEM);
> @@ -1094,3 +1104,61 @@ bool of_dma_is_coherent(struct device_node *np)
>         return false;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> +
> +static bool of_nonposted_mmio_quirk(void)
> +{
> +       if (IS_ENABLED(CONFIG_ARCH_APPLE)) {
> +               /* To save cycles, we cache the result for global "Apple ARM" setting */
> +               static int quirk_state = -1;
> +
> +               /* Make quirk cached */
> +               if (quirk_state < 0)
> +                       quirk_state = of_machine_is_compatible("apple,arm-platform");
> +               return !!quirk_state;
> +       }
> +       return false;
> +}
> +
> +/**
> + * of_mmio_is_nonposted - Check if device uses non-posted MMIO
> + * @np:        device node
> + *
> + * Returns true if the "nonposted-mmio" property was found for
> + * the device's bus or a parent. "posted-mmio" has the opposite
> + * effect, terminating recursion and overriding any
> + * "nonposted-mmio" properties in parent buses.
> + *
> + * Recursion terminates if reach a non-translatable boundary
> + * (a node without a 'ranges' property).
> + *
> + * This is currently only enabled on Apple ARM devices, as an
> + * optimization.
> + */
> +bool of_mmio_is_nonposted(struct device_node *np)
> +{
> +       struct device_node *node;
> +       struct device_node *parent;
> +
> +       if (!of_nonposted_mmio_quirk())
> +               return false;
> +
> +       node = of_get_parent(np);
> +
> +       while (node) {
> +               if (!of_property_read_bool(node, "ranges")) {
> +                       break;
> +               } else if (of_property_read_bool(node, "nonposted-mmio")) {
> +                       of_node_put(node);
> +                       return true;
> +               } else if (of_property_read_bool(node, "posted-mmio")) {
> +                       break;
> +               }
> +               parent = of_get_parent(node);
> +               of_node_put(node);
> +               node = parent;
> +       }
> +
> +       of_node_put(node);
> +       return false;

What's the code path using these functions on the M1 where we need to
return 'posted'? It's just downstream PCI mappings (PCI memory space),
right? Those would never hit these paths because they don't have a DT
node or if they do the memory space is not part of it. So can't the
check just be:

bool of_mmio_is_nonposted(struct device_node *np)
{
    return np && of_machine_is_compatible("apple,arm-platform");
}

Note in theory we could use 'assigned-addresses' with PCI, but that's
pretty much never the case with FDT. If we did, we could detect the
device node is a PCI device in that case.

Rob

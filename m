Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E396731
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfHTROa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 13:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbfHTROa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 13:14:30 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571D5233A0;
        Tue, 20 Aug 2019 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566321269;
        bh=WGX3Gxv4dvM3DO7D4Aw57VijAg2RzIOgDn+ZtwXtLuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1yXHm0Cw2txK8FKtm1lYL+ceKrY7DkUGFh280BlxT1m8fd1yJvGoIVx0XuwOhxQFl
         3vnSgFW8lKZ5tU+8Sczz4E2yLgkfj7rC+uZiW9anhIz5JhqNZ2QuOhbB3Db0e6C+Ey
         r3/UkDEl7xBODkwZSZVqMzmvS/NH9009SEaBt8yY=
Received: by mail-qt1-f170.google.com with SMTP id e8so6870132qtp.7;
        Tue, 20 Aug 2019 10:14:29 -0700 (PDT)
X-Gm-Message-State: APjAAAUfp0l50+MstqZXIlWLS4T8CsWC5G/7uPi93UdxV3WCpKXSOVHc
        9FhXM7pzNLqSrdW8Da/pu3QLniQVP2VaWhgM9Q==
X-Google-Smtp-Source: APXvYqyY9ZsBecGQ3Xs5y7LG3j9BHwHgJiDVJDcbMsgosFCxqVWpdQe5Z5wA8XSvdYEItWSHAFvEDYIGvIF5NjfBNsQ=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr26942067qto.224.1566321268306;
 Tue, 20 Aug 2019 10:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-5-nsaenzjulienne@suse.de>
In-Reply-To: <20190820145821.27214-5-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 12:14:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Nr88Nvd_ZA8eJGm4xLwssv7CnDJLsnZyFqiM=EQWYxg@mail.gmail.com>
Message-ID: <CAL_Jsq+Nr88Nvd_ZA8eJGm4xLwssv7CnDJLsnZyFqiM=EQWYxg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] of/fdt: add early_init_dt_get_dma_zone_size()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Wahren <wahrenst@gmx.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>, phill@raspberryi.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Matthias Brugger <mbrugger@suse.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 20, 2019 at 9:58 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Some devices might have weird DMA addressing limitations that only apply
> to a subset of the available peripherals. For example the Raspberry Pi 4
> has two interconnects, one able to address the whole lower 4G memory
> area and another one limited to the lower 1G.
>
> Being an uncommon situation we simply hardcode the device wide DMA
> addressable memory size conditionally to the machine compatible name and
> set 'dma_zone_size' accordingly.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes in v2:
> - New approach to getting dma_zone_size, instead of parsing the dts we
>   hardcode it conditionally to the machine compatible name.
>
>  drivers/of/fdt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 06ffbd39d9af..f756e8c05a77 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -27,6 +27,7 @@
>
>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>  #include <asm/page.h>
> +#include <asm/dma.h>   /* for dma_zone_size */
>
>  #include "of_private.h"
>
> @@ -1195,6 +1196,12 @@ void __init early_init_dt_scan_nodes(void)
>         of_scan_flat_dt(early_init_dt_scan_memory, NULL);
>  }
>
> +void __init early_init_dt_get_dma_zone_size(void)

static

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +{
> +       if (of_fdt_machine_is_compatible("brcm,bcm2711"))
> +               dma_zone_size = 0x3c000000;
> +}
> +
>  bool __init early_init_dt_scan(void *params)
>  {
>         bool status;
> @@ -1204,6 +1211,7 @@ bool __init early_init_dt_scan(void *params)
>                 return false;
>
>         early_init_dt_scan_nodes();
> +       early_init_dt_get_dma_zone_size();
>         return true;
>  }
>
> --
> 2.22.0
>

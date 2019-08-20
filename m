Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2696745
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfHTRQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 13:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTRQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 13:16:56 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA0822DD3;
        Tue, 20 Aug 2019 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566321415;
        bh=36RoA+pZe09a0o8vSPVqwWADJLZpVfbMeIU9BV28nPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XIs9UEkSMvPxBnsd53e7jkN5NEI5/C7h8Ir8aLbuMxhu90HRaE3Sc6lc/xzj2MrL1
         xUG8N1AvPqsw4DNAuxtwFWd/cIXDpfFE4tkp1UYhSdi86yw4x7vtkpqKGbI3cr0Q2O
         KYpy6aYY3wEO3cToKeoOX0ItD4JzAtZeq59NctvU=
Received: by mail-qk1-f173.google.com with SMTP id u190so5141918qkh.5;
        Tue, 20 Aug 2019 10:16:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUEL4K25g6lvblaphjh72eFVv7FmsCpZUEaWRytYzJnIwLdBSyV
        bKZY2ZU1+5abumayQt31Zg2zjVoQVSPbg9dtAg==
X-Google-Smtp-Source: APXvYqwuF+PJndb+CroZT1MS5j54H47bxzE6ji7aLqlNUTkFV6I2ExfzQp8zw3/DWgp/8UNkiC1AWu81liXi+Rz7vJg=
X-Received: by 2002:a37:6944:: with SMTP id e65mr24769246qkc.119.1566321414471;
 Tue, 20 Aug 2019 10:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-4-nsaenzjulienne@suse.de>
In-Reply-To: <20190820145821.27214-4-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 12:16:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Message-ID: <CAL_JsqJT3UNVKpAt+3g-tosy=uCZTosUxD4RfVYjMJ-gpGmPiA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] of/fdt: add of_fdt_machine_is_compatible function
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
> Provides the same functionality as of_machine_is_compatible.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> Changes in v2: None
>
>  drivers/of/fdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9cdf14b9aaab..06ffbd39d9af 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -802,6 +802,13 @@ const char * __init of_flat_dt_get_machine_name(void)
>         return name;
>  }
>
> +static const int __init of_fdt_machine_is_compatible(char *name)

No point in const return (though name could possibly be const), and
the return could be bool instead.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +{
> +       unsigned long dt_root = of_get_flat_dt_root();
> +
> +       return of_flat_dt_is_compatible(dt_root, name);
> +}
> +
>  /**
>   * of_flat_dt_match_machine - Iterate match tables to find matching machine.
>   *
> --
> 2.22.0
>

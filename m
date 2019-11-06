Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6EF1CF3
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfKFR4l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 12:56:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37943 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfKFR4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 12:56:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so4468484pgh.5
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=xZW1gMrCUoJqpGWBEYHWFfV09K+K/0uVmzI4MIoxGS8=;
        b=PGZwZeqhjPGqmbBUrw44Auucb8k6dPtlYxXbuNpTAeEMGmKlsnFWXhrKzSARRD1P5Z
         ofkafacEFrUvuMMQ8srHmApZNGXOM2FXgWNtdGS1rg8UPKc85d79tzD5/t3BF7GMjDtX
         WoCFpoFoR/nlY6sa8P7ME55iO2h9Yfcb7ZSd7Zw+om2XJAjYyCK0yIJtNHDyXsnWFiZL
         JcRZR97cwQ2ZvZRsXx81CQhAqwyUUPUY90oJrysCQQ7l1b0iCyPludGEBBLbIE1elh0S
         JIqszC7OB8xZ2n5/8rEoDBU7MzMibg41EDmgXW2rJwIAtaViAg8zHwFVYITgL2sVpvu1
         UzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=xZW1gMrCUoJqpGWBEYHWFfV09K+K/0uVmzI4MIoxGS8=;
        b=l6BG/+u00W53UNV0bdD4HGNHWJGqZ/W77QXl7r0ATWjP3Whbcgo1H2DQnKlVxFApzq
         c60FK2xxWuICtexmTU3Qyg2ml0M9R2+lpRMciRE0ez2duZdWUzRsj5ZqHDsMuSw2Fwp+
         0OF8g3g9Eina8CJVUD7VVvMs9kgkKRtUbARWhuEkraZeUfIVTF1Nc7g18CGyAr4u69x0
         EPm4JIUp2mha37PHDaNOtCl19O8rcw1P2IaNByjBFgPsP4ABnWKi5Gffw6VNFHyJB88H
         8Kg40zW/TEZqBSHlOu21TiDIlLXPRADbEztM+YP0Sj2k6V3o1kkUqxNgkaNMsOYRG3my
         5OTQ==
X-Gm-Message-State: APjAAAW8rn44HdnlIzo3RJpTV7PMxuL2ZyUqSA7Aj05pwf2+KV9ZkZ96
        b/ofQxaHNtGSF3eLrRyd4nHc0g==
X-Google-Smtp-Source: APXvYqyZI0/opOONYHdOR3l6SH/z69P+ajsTKg8L6ObdzcVPlsahU45e+bD0ChxR/pgAJsTDNgZ9EA==
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr5529604pjb.18.1573062994968;
        Wed, 06 Nov 2019 09:56:34 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z11sm32745913pfg.117.2019.11.06.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 09:56:34 -0800 (PST)
Date:   Wed, 06 Nov 2019 09:56:34 -0800 (PST)
X-Google-Original-Date: Wed, 06 Nov 2019 09:56:23 PST (-0800)
Subject:     Re: [PATCH 10/21] asm-generic: ioremap_uc should behave the same with and without MMU
In-Reply-To: <20191029064834.23438-11-hch@lst.de>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org, monstr@monstr.eu,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-3f709a8a-a8c3-4612-b4de-847d13b4af0a@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Oct 2019 23:48:23 PDT (-0700), Christoph Hellwig wrote:
> Whatever reason there is for the existence of ioremap_uc, and the fact
> that it returns NULL by default on architectures with an MMU applies
> equally to nommu architectures, so don't provide different defaults.
>
> In practice the difference is meaningless as the only portable driver
> that uses ioremap_uc is atyfb which probably doesn't show up on nommu
> devices.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/asm-generic/io.h | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index d02806513670..a98ed6325727 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -935,18 +935,7 @@ static inline void *phys_to_virt(unsigned long address)
>   * defined your own ioremap_*() variant you must then declare your own
>   * ioremap_*() variant as defined to itself to avoid the default NULL return.
>   */
> -
> -#ifdef CONFIG_MMU
> -
> -#ifndef ioremap_uc
> -#define ioremap_uc ioremap_uc
> -static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> -{
> -	return NULL;
> -}
> -#endif
> -
> -#else /* !CONFIG_MMU */
> +#ifndef CONFIG_MMU
>
>  /*
>   * Change "struct page" to physical address.
> @@ -980,14 +969,6 @@ static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>  }
>  #endif
>
> -#ifndef ioremap_uc
> -#define ioremap_uc ioremap_uc
> -static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> -{
> -	return ioremap_nocache(offset, size);
> -}
> -#endif
> -
>  #ifndef ioremap_wc
>  #define ioremap_wc ioremap_wc
>  static inline void __iomem *ioremap_wc(phys_addr_t offset, size_t size)
> @@ -1004,6 +985,21 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
>  }
>  #endif
>
> +/*
> + * ioremap_uc is special in that we do require an explicit architecture
> + * implementation.  In general you do now want to use this function in a

Presumably that's supposed to be "do not want to use"?

> + * driver and use plain ioremap, which is uncached by default.  Similarly
> + * architectures should not implement it unless they have a very good
> + * reason.
> + */
> +#ifndef ioremap_uc
> +#define ioremap_uc ioremap_uc
> +static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #ifdef CONFIG_HAS_IOPORT_MAP
>  #ifndef CONFIG_GENERIC_IOMAP
>  #ifndef ioport_map

With the fix:

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

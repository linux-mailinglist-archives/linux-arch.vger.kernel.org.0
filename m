Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C239884A
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jun 2021 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhFBL17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Jun 2021 07:27:59 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:35815 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhFBL1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jun 2021 07:27:20 -0400
Received: by mail-ua1-f52.google.com with SMTP id n61so1093903uan.2;
        Wed, 02 Jun 2021 04:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AV6hHV9w+Q9HOaDxt1MduQbvvUP04JEJ1UZD5l/XTkY=;
        b=gc2Ix2WYXrd5WBa8hgBCxI97fp6w5lfgSq5y19jK6xflsjm/7Qi77LTamSm8IRE/vZ
         lnVGmmHIYKQplMfJJVLivjdoBII+fcGDZXQIFroxtfBnu/RLUbZkCtLwK0XcdSpflOn+
         xER2ZqTNbCQ0NCRucaAE6MlNe0/kI7sh73nUh/FWk8GeLaGfUiF3FwdD6+zrFuR+0ORf
         K1CCdcfJ+XJ0xQKFMxoeLAvuJ26AHtIo80w4dZe33lMo2RCUovhhCDrjV8a81vMQpegO
         qg5fCQxWEgo8pa/jjVdVqcH/m+lg/4ZdMb3vn8BJTpJAo4JHPXB7eev+FIxZUakZslDF
         TSrg==
X-Gm-Message-State: AOAM5326kVIsA7qV6Ik1uDmkr2fUbjOvpkXbVdz1tzudDiEm6BIC/rPA
        w2ybBhMHmRFC9mAddyxm9vN17wr6GLWCdLUpMZY=
X-Google-Smtp-Source: ABdhPJyzzWa9paQxXHYFBMFScAZBlkmtyILKANDBBOx9rPPA/yxyu03vLu3qpQ9izu7tVqpx2AMkJo4APWbgLQB/p8I=
X-Received: by 2002:ab0:26d8:: with SMTP id b24mr14134972uap.58.1622633136111;
 Wed, 02 Jun 2021 04:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210602105348.13387-1-rppt@kernel.org> <20210602105348.13387-5-rppt@kernel.org>
In-Reply-To: <20210602105348.13387-5-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Jun 2021 13:25:24 +0200
Message-ID: <CAMuHMdUUzMNcWNXCjwZmH-VBC+jH1ShBpeg6EBCdRXv3mwHxsQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] m68k: remove support for DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On Wed, Jun 2, 2021 at 12:54 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> DISCONTIGMEM was replaced by FLATMEM with freeing of the unused memory map
> in v5.11.
>
> Remove the support for DISCONTIGMEM entirely.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/include/asm/page_mm.h
> +++ b/arch/m68k/include/asm/page_mm.h
> @@ -126,25 +126,7 @@ static inline void *__va(unsigned long x)
>
>  extern int m68k_virt_to_node_shift;
>
> -#ifndef CONFIG_DISCONTIGMEM
>  #define __virt_to_node(addr)   (&pg_data_map[0])

With pg_data_map[] removed, this definition can go as well.
Seems to be a leftover from 1008a11590b966b4 ("m68k: switch to MEMBLOCK
 + NO_BOOTMEM")

There are a few more:
arch/m68k/include/asm/mmzone.h:extern pg_data_t pg_data_map[];
arch/m68k/include/asm/mmzone.h:#define NODE_DATA(nid)
(&pg_data_map[nid])

> -#else
> -extern struct pglist_data *pg_data_table[];
> -
> -static inline __attribute_const__ int __virt_to_node_shift(void)
> -{
> -       int shift;
> -
> -       asm (
> -               "1:     moveq   #0,%0\n"
> -               m68k_fixup(%c1, 1b)
> -               : "=d" (shift)
> -               : "i" (m68k_fixup_vnode_shift));
> -       return shift;
> -}
> -
> -#define __virt_to_node(addr)   (pg_data_table[(unsigned long)(addr) >> __virt_to_node_shift()])
> -#endif

> --- a/arch/m68k/mm/init.c
> +++ b/arch/m68k/mm/init.c
> @@ -44,28 +44,8 @@ EXPORT_SYMBOL(empty_zero_page);
>
>  int m68k_virt_to_node_shift;
>
> -#ifdef CONFIG_DISCONTIGMEM
> -pg_data_t pg_data_map[MAX_NUMNODES];
> -EXPORT_SYMBOL(pg_data_map);
> -
> -pg_data_t *pg_data_table[65];
> -EXPORT_SYMBOL(pg_data_table);
> -#endif
> -

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

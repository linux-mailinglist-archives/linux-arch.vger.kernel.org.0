Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A0DBE51
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504610AbfJRHbI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 03:31:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36638 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394031AbfJRHbI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 03:31:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id 67so4178483oto.3;
        Fri, 18 Oct 2019 00:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vcvhB5CLF/+MeUyHDDl7fZL+tAXhkabxwY8RzqlUc4=;
        b=K7Yt9YoviXa1EKl7IKMUxzV7fJKccYRkl/f/zlrsDAxPX7Y9NmcboBMaiUIBkisj6s
         K/0rvmrdS4ruOkQk5Hdy5r6QgqM1ptvNEsMgEXyzH8j6K0hnmphrD4eoFVYR+YrhhTji
         sv+lhgqy6QZRgZD9UXmKb0NmFnA2KEJsRyI8XTEnOKaVxHXC04Fd1wRItkbgJivTsSzv
         WEjfcgaPLmReo38CmBMZ/lqF/gNrP8OH1ATnQNrGFeXk1zTfNbGS0Z139E6RYM4lQPHa
         YGrHDrKdq3kF/mSl878GMtb0SEYzxy5WW3bYfpCTb0nm0HnvYBXtXxIRewJLiRbL9mf0
         r1zg==
X-Gm-Message-State: APjAAAUdHG9sRGDmTM/26149dvkFYcNaNyzvjXWe3Xz+3DsVdopC+4VX
        Fd9KC55bUts+HuDpW7qo55LwNuOur/drHhczNuw=
X-Google-Smtp-Source: APXvYqz5ZTzm2szPG0oqRjP0bYm68wI5cC2zWPx8OuV5blCVSPhZgU0siPaT+bnCFclqt0wG9CC25EAYDHrDP1i11C0=
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr6117171otj.107.1571383865678;
 Fri, 18 Oct 2019 00:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191017174554.29840-1-hch@lst.de> <20191017174554.29840-14-hch@lst.de>
In-Reply-To: <20191017174554.29840-14-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Oct 2019 09:30:54 +0200
Message-ID: <CAMuHMdWaQ15j7fQ9-8XKgrSwgf96nT=yY+FCPWPxoPC9LGqvbQ@mail.gmail.com>
Subject: Re: [PATCH 13/21] m68k: rename __iounmap and mark it static
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-riscv@lists.infradead.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Thu, Oct 17, 2019 at 7:53 PM Christoph Hellwig <hch@lst.de> wrote:
> m68k uses __iounmap as the name for an internal helper that is only
> used for some CPU types.  Mark it static and give it a better name.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/arch/m68k/mm/kmap.c
> +++ b/arch/m68k/mm/kmap.c
> @@ -52,6 +52,7 @@ static inline void free_io_area(void *addr)
>
>  #define IO_SIZE                (256*1024)
>
> +static void __free_io_area(void *addr, unsigned long size);
>  static struct vm_struct *iolist;
>
>  static struct vm_struct *get_io_area(unsigned long size)
> @@ -90,7 +91,7 @@ static inline void free_io_area(void *addr)
>                 if (tmp->addr == addr) {
>                         *p = tmp->next;
>                         /* remove gap added in get_io_area() */
> -                       __iounmap(tmp->addr, tmp->size - IO_SIZE);
> +                       __free_io_area(tmp->addr, tmp->size - IO_SIZE);
>                         kfree(tmp);
>                         return;
>                 }
> @@ -249,12 +250,13 @@ void iounmap(void __iomem *addr)
>  }
>  EXPORT_SYMBOL(iounmap);
>
> +#ifndef CPU_M68040_OR_M68060_ONLY

Can you please move this block up, instead of adding more #ifdef cluttery?
That would also remove the need for a forward declaration.

>  /*
> - * __iounmap unmaps nearly everything, so be careful
> + * __free_io_area unmaps nearly everything, so be careful
>   * Currently it doesn't free pointer/page tables anymore but this
>   * wasn't used anyway and might be added later.
>   */
> -void __iounmap(void *addr, unsigned long size)
> +static void __free_io_area(void *addr, unsigned long size)
>  {
>         unsigned long virtaddr = (unsigned long)addr;
>         pgd_t *pgd_dir;
> @@ -297,6 +299,7 @@ void __iounmap(void *addr, unsigned long size)
>
>         flush_tlb_all();
>  }
> +#endif /* CPU_M68040_OR_M68060_ONLY */
>
>  /*
>   * Set new cache mode for some kernel address space.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

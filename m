Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067B891F88
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfHSJAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 05:00:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38949 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfHSJAh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 05:00:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id b1so984848otp.6;
        Mon, 19 Aug 2019 02:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmtPnJSRI0zndYON4lQ0lxZkTiNZNjENxpxxDRXsGjM=;
        b=Twp0IvHs1SbWYDIfvY9lRbdliTRa1qImMneYt75ss1CYps6QV50PsHgukHKgigYMX1
         KZ3J/sbnwZC832lbHdqLWAfvDoaU/kWtBqscTiEbVu0o6DdJVP644cin7a/Nfobrcz84
         1vuZlFT9/trwJy7zdA9DE6iLrjnnvcmxwhGCmMCEsvF7xHkhkWv3RO5w0tO1JCGF8Kp4
         J1BRFGTmc29uYYGueEBkK9dVZ8I+1ovhq8ppJh6rcWTT7jmvaGYyT8bRJR1WFdaCRcng
         /k74H2C8dCMRlQQRBZmByt5ez4AfFs0ZYvBiVk7xGbXZq31EbMZsUlLO3wuCUJIZ1Y/P
         KmoA==
X-Gm-Message-State: APjAAAUhPPqIh69LSyYj5i+o13f5SldJXKMkwVYioyQG7wmd18VfWF9T
        HjO6STAyf2Dbstf1AvM1AcsYNSXGoLDQ9R/1aEY=
X-Google-Smtp-Source: APXvYqwhI3T2oGgeZwLOQSfvRhaXT1jrSgi6r47r+Se5hS7KcKzZEqkkqP7EFf8wTbDzFidtX+J78UJ3IrYCTcoWc4g=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr17294497oto.250.1566205235743;
 Mon, 19 Aug 2019 02:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-19-hch@lst.de>
In-Reply-To: <20190817073253.27819-19-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 11:00:24 +0200
Message-ID: <CAMuHMdWjAUMc_G1AUE_dgbrUn3qm4th+jiG3NJwperDVHdcoSw@mail.gmail.com>
Subject: Re: [PATCH 18/26] m68k: rename __iounmap and mark it static
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christoph,

On Sat, Aug 17, 2019 at 9:49 AM Christoph Hellwig <hch@lst.de> wrote:
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

Cant you move this block up, to avoid adding more #ifdef cluttery?
The rest looks good to me.

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

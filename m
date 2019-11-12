Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B9F8B0F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2019 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKLIwJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Nov 2019 03:52:09 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36799 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLIwJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 03:52:09 -0500
Received: by mail-qv1-f68.google.com with SMTP id f12so6061477qvu.3;
        Tue, 12 Nov 2019 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cROzNmdYxisqWoueYc9W+eIG2Mx3qlHP7NfXN3GI/FQ=;
        b=PF/S6iWT4CYos5f/Qxiyrj819yA9DztoVnQngjCM7ST0A6/xHzOKuFza6aEAOEIHFD
         IRs3g/sDkmOZsVUg5BfLLNbhxSMsVVb1DEnttjxKmX81P3vu2Wx0WRs/PKqDolQ/IqMK
         uPtjTNahNUl/KH+yjsZZF+CoOeh+jZqwG7uXGo3nhOFae7Ampy0721WlrVLudKDpbQ6w
         Ne05cDDAK3nINRCW8InLefN68zNgFYrAuL9YQ5NnpKcJktjb30Vy1+p0A29rUFLtn67e
         CyPwRK92ARrt+aagj3u2Ed/rcJMFZLBJNDyZ8A+QOoxqRdIwXIhdl4nE8zBZgMbMWl9y
         KZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cROzNmdYxisqWoueYc9W+eIG2Mx3qlHP7NfXN3GI/FQ=;
        b=YNAf5bi0IwYHZYEY1+2wXQaFQUJkvOzeXvYB3tC7UZaOMLcuX+vd2l1fdxhxQm2XN3
         8wTGx61vLOXuZQqLbQNbJFTiMWR0RbcMozzIiPDhMKycLQ0cgaSB18oz6eIU3HVfQWxA
         98R61PW6tsp/IENRLeAz5Vb56OfIzhCXNFMhzmuKGgADIvkmaAGlPsGLZ8dFtjEIXAH6
         oXt9Aq9Zj9lt2YKMxHc6LrBPKmHMIWPXOcDOqnNAWfLnucMN/7B6v8cf8ad3JRvUvW7M
         bIdFJkcgM5V9xm98crMw3LqJeZRErrRiZxbxjlkCKkMBbpV/pVSTfFAgo8pEQ9PpsVCE
         6sIw==
X-Gm-Message-State: APjAAAUP+caTtJZCypdyRsHqKGjdSEoq3FVSTWVJh1cngQoYJD+tsJ7i
        Wx5X4H0W1ZKcd9fnhneQ/EJSTIDBui8WEiKQGbA=
X-Google-Smtp-Source: APXvYqx6NKc2ScCo7khfKTbduCZ3tXXPnpOsLDXFoJ5p/wlTm7Nj9aXW2BAPakV8QIjz95Uh9EuSyoZxwk73743by2g=
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr27967066qvh.197.1573548727413;
 Tue, 12 Nov 2019 00:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20191029064834.23438-1-hch@lst.de> <20191029064834.23438-20-hch@lst.de>
In-Reply-To: <20191029064834.23438-20-hch@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 12 Nov 2019 16:51:29 +0800
Message-ID: <CAEbi=3c58Pb=Q3BqeTLhEK8OsdTpbD5tAe6VcGOC7JBWbTjetQ@mail.gmail.com>
Subject: Re: [PATCH 19/21] nds32: use generic ioremap
To:     Christoph Hellwig <hch@lst.de>, Nickhu <nickhu@andestech.com>,
        alankao@andestech.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, linux-mtd@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Christoph Hellwig <hch@lst.de> =E6=96=BC 2019=E5=B9=B410=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Use the generic ioremap_prot and iounmap helpers.
>
> Note that the io.h include in pgtable.h had to be removed to not create
> an include loop.  As far as I can tell there was no need for it to
> start with.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/Kconfig               |  1 +
>  arch/nds32/include/asm/io.h      |  3 +-
>  arch/nds32/include/asm/pgtable.h |  4 ++-
>  arch/nds32/mm/Makefile           |  3 +-
>  arch/nds32/mm/ioremap.c          | 62 --------------------------------
>  5 files changed, 6 insertions(+), 67 deletions(-)
>  delete mode 100644 arch/nds32/mm/ioremap.c
>
> diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
> index fbd68329737f..12c06a833b7c 100644
> --- a/arch/nds32/Kconfig
> +++ b/arch/nds32/Kconfig
> @@ -20,6 +20,7 @@ config NDS32
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_IRQ_CHIP
>         select GENERIC_IRQ_SHOW
> +       select GENERIC_IOREMAP
>         select GENERIC_LIB_ASHLDI3
>         select GENERIC_LIB_ASHRDI3
>         select GENERIC_LIB_CMPDI2
> diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
> index fb0e8a24c7af..e57378d04006 100644
> --- a/arch/nds32/include/asm/io.h
> +++ b/arch/nds32/include/asm/io.h
> @@ -6,8 +6,6 @@
>
>  #include <linux/types.h>
>
> -void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
> -extern void iounmap(volatile void __iomem *addr);
>  #define __raw_writeb __raw_writeb
>  static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
>  {
> @@ -80,6 +78,7 @@ static inline u32 __raw_readl(const volatile void __iom=
em *addr)
>  #define writeb(v,c)    ({ __iowmb(); writeb_relaxed((v),(c)); })
>  #define writew(v,c)    ({ __iowmb(); writew_relaxed((v),(c)); })
>  #define writel(v,c)    ({ __iowmb(); writel_relaxed((v),(c)); })
> +
>  #include <asm-generic/io.h>
>
>  #endif /* __ASM_NDS32_IO_H */
> diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pg=
table.h
> index 0588ec99725c..6fbf251cfc26 100644
> --- a/arch/nds32/include/asm/pgtable.h
> +++ b/arch/nds32/include/asm/pgtable.h
> @@ -12,7 +12,6 @@
>  #include <asm/nds32.h>
>  #ifndef __ASSEMBLY__
>  #include <asm/fixmap.h>
> -#include <asm/io.h>
>  #include <nds32_intrinsic.h>
>  #endif
>
> @@ -130,6 +129,9 @@ extern void __pgd_error(const char *file, int line, u=
nsigned long val);
>  #define _PAGE_CACHE            _PAGE_C_MEM_WB
>  #endif
>
> +#define _PAGE_IOREMAP \
> +       (_PAGE_V | _PAGE_M_KRW | _PAGE_D | _PAGE_G | _PAGE_C_DEV)
> +
>  /*
>   * + Level 1 descriptor (PMD)
>   */
> diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
> index bd360e4583b5..897ecaf5cf54 100644
> --- a/arch/nds32/mm/Makefile
> +++ b/arch/nds32/mm/Makefile
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y                          :=3D extable.o tlb.o \
> -                                  fault.o init.o ioremap.o mmap.o \
> +obj-y                          :=3D extable.o tlb.o fault.o init.o mmap.=
o \
>                                     mm-nds32.o cacheflush.o proc.o
>
>  obj-$(CONFIG_ALIGNMENT_TRAP)   +=3D alignment.o
> diff --git a/arch/nds32/mm/ioremap.c b/arch/nds32/mm/ioremap.c
> deleted file mode 100644
> index 690140bb23a2..000000000000
> --- a/arch/nds32/mm/ioremap.c
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (C) 2005-2017 Andes Technology Corporation
> -
> -#include <linux/vmalloc.h>
> -#include <linux/io.h>
> -#include <linux/mm.h>
> -#include <asm/pgtable.h>
> -
> -void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
> -
> -static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size=
,
> -                                     void *caller)
> -{
> -       struct vm_struct *area;
> -       unsigned long addr, offset, last_addr;
> -       pgprot_t prot;
> -
> -       /* Don't allow wraparound or zero size */
> -       last_addr =3D phys_addr + size - 1;
> -       if (!size || last_addr < phys_addr)
> -               return NULL;
> -
> -       /*
> -        * Mappings have to be page-aligned
> -        */
> -       offset =3D phys_addr & ~PAGE_MASK;
> -       phys_addr &=3D PAGE_MASK;
> -       size =3D PAGE_ALIGN(last_addr + 1) - phys_addr;
> -
> -       /*
> -        * Ok, go for it..
> -        */
> -       area =3D get_vm_area_caller(size, VM_IOREMAP, caller);
> -       if (!area)
> -               return NULL;
> -
> -       area->phys_addr =3D phys_addr;
> -       addr =3D (unsigned long)area->addr;
> -       prot =3D __pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D |
> -                       _PAGE_G | _PAGE_C_DEV);
> -       if (ioremap_page_range(addr, addr + size, phys_addr, prot)) {
> -               vunmap((void *)addr);
> -               return NULL;
> -       }
> -       return (__force void __iomem *)(offset + (char *)addr);
> -
> -}
> -
> -void __iomem *ioremap(phys_addr_t phys_addr, size_t size)
> -{
> -       return __ioremap_caller(phys_addr, size,
> -                               __builtin_return_address(0));
> -}
> -
> -EXPORT_SYMBOL(ioremap);
> -
> -void iounmap(volatile void __iomem * addr)
> -{
> -       vunmap((void *)(PAGE_MASK & (unsigned long)addr));
> -}
> -
> -EXPORT_SYMBOL(iounmap);

Acked-by: Greentime Hu <green.hu@gmail.com>
Looks good to me.

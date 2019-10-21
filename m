Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8979CDE5A2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2019 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfJUH6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Oct 2019 03:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfJUH6n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Oct 2019 03:58:43 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77CC5218AC;
        Mon, 21 Oct 2019 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571644721;
        bh=HaNxatOx3Yl+LjuXNZSg9j6rwSnjKUPc8eLVmd61SU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=luHraHozlqKNUHwEUrw+p/CKnNkzg4GhLnRI3IQVw1ZUnmvt4Cwl7ABV+5EzHS34g
         CqVlZgKrjSy7nsjEnaLPBzt8i8/jWykyodKl+iP31wL1BC0A++0dn8emaiIgMxVUqa
         6AeBtKgvcbANkPSenLQVsuD5VltHn5JOl0JQoRvI=
Received: by mail-wr1-f50.google.com with SMTP id e11so3977103wrv.4;
        Mon, 21 Oct 2019 00:58:41 -0700 (PDT)
X-Gm-Message-State: APjAAAV4W1flYsylqq7vFVqeS8VJ1GRc94UTgTHPcKHekPMu1UneTyX2
        fiut8z6q/ojUxrW+GLZU26l8jt0rhpc0sk23yzg=
X-Google-Smtp-Source: APXvYqzvF6HJCASpTMUMf7HweDv3Hno9oEAxiqhI3GBGEOPTWQrWQiETxVnKLeVHbQ3ma/xucSMvECIDZp2EBxJkKe8=
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr17344477wrn.24.1571644719802;
 Mon, 21 Oct 2019 00:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191017174554.29840-1-hch@lst.de> <20191017174554.29840-21-hch@lst.de>
In-Reply-To: <20191017174554.29840-21-hch@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Oct 2019 15:58:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ_VeBfi1uaafgtp+uA2skq-w2px12ig=5QD1O9J+PgbA@mail.gmail.com>
Message-ID: <CAJF2gTQ_VeBfi1uaafgtp+uA2skq-w2px12ig=5QD1O9J+PgbA@mail.gmail.com>
Subject: Re: [PATCH 20/21] csky: remove ioremap_cache
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Fri, Oct 18, 2019 at 1:47 AM Christoph Hellwig <hch@lst.de> wrote:
>
> No driver that can be used on csky uses ioremap_cache, and this
> interface has been deprecated in favor of memremap.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/include/asm/io.h | 2 --
>  arch/csky/mm/ioremap.c     | 7 -------
>  2 files changed, 9 deletions(-)
>
> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> index a4b9fb616faa..f572605d5ad5 100644
> --- a/arch/csky/include/asm/io.h
> +++ b/arch/csky/include/asm/io.h
> @@ -36,13 +36,11 @@
>  /*
>   * I/O memory mapping functions.
>   */
> -extern void __iomem *ioremap_cache(phys_addr_t addr, size_t size);
>  extern void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot);
>  extern void iounmap(void *addr);
>
>  #define ioremap(addr, size)            __ioremap((addr), (size), pgprot_noncached(PAGE_KERNEL))
>  #define ioremap_wc(addr, size)         __ioremap((addr), (size), pgprot_writecombine(PAGE_KERNEL))
> -#define ioremap_cache                  ioremap_cache
>
>  #include <asm-generic/io.h>
>
> diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
> index e13cd3497628..ae78256a56fd 100644
> --- a/arch/csky/mm/ioremap.c
> +++ b/arch/csky/mm/ioremap.c
> @@ -44,13 +44,6 @@ void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
>  }
>  EXPORT_SYMBOL(__ioremap);
>
> -void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
> -{
> -       return __ioremap_caller(phys_addr, size, PAGE_KERNEL,
> -                               __builtin_return_address(0));
> -}
> -EXPORT_SYMBOL(ioremap_cache);
> -
>  void iounmap(void __iomem *addr)
>  {
>         vunmap((void *)((unsigned long)addr & PAGE_MASK));
> --
> 2.20.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

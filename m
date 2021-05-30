Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6878E394EA3
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 02:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhE3A2K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 May 2021 20:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhE3A2K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 May 2021 20:28:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAF7761132;
        Sun, 30 May 2021 00:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622334393;
        bh=WO4AvDQOErMivEJBVOiXhGXr5BkKrXIWDEGphngSgbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kHRhk9G+wUoeLpEV9DQ/UiT1VaYwzO7dFTkRq4nNj8F11uSAi0N7BXIPHj4mKaW+g
         jOPu8D3jOx2k6Xm6vAVks94uG25qw67scVZt1N73qS0f4DYSIlU2iP7Ji2ynxzD85w
         cPp/kQWYDNmms3WPPc4UobJGQsiEImwR2aI1kA6/3r3S2GUdQ4JtvXMz65p+82B4kX
         SBjXbdMzHj0sz0lvLAon1rY+Xk3uxM02qUAHlP0GQtw3w28MK4Qw7j4QZWBXGY/kfX
         ccuJ/qaefyj6e56SP2sH4jy/LpV6Ym358BqbrQxyxcqnj7Zm5JBv9/J5NZCp8QZnHv
         AtP/6kehfDx2A==
Received: by mail-lj1-f171.google.com with SMTP id a4so10075348ljd.5;
        Sat, 29 May 2021 17:26:32 -0700 (PDT)
X-Gm-Message-State: AOAM53110UCqsO9hirfX6G1tP2i/TXm12OQwRwioZfm5P7i7qpu0Sds1
        DiZ1IzCBdQXSx4Jee0DvVGtzLFPQwMJma8dwG/w=
X-Google-Smtp-Source: ABdhPJzAv7KxOF4cW+l6E6gE3uAhvDSqrsRPGJzs6vvDaU7PttVLgVopNfDeoPAKiteBVSoM5AoDZDhtiWO9RVnzXQk=
X-Received: by 2002:a05:651c:2d0:: with SMTP id f16mr3853539ljo.18.1622334391183;
 Sat, 29 May 2021 17:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <1621945234-37878-1-git-send-email-guoren@kernel.org> <mhng-93a12abf-0283-4ec3-a521-89b8d882654f@palmerdabbelt-glaptop>
In-Reply-To: <mhng-93a12abf-0283-4ec3-a521-89b8d882654f@palmerdabbelt-glaptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 May 2021 08:26:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTMYi-fr2kz5PHBtZ17iJdq0gN5UWT+eRV7ODwNfUcqrw@mail.gmail.com>
Message-ID: <CAJF2gTTMYi-fr2kz5PHBtZ17iJdq0gN5UWT+eRV7ODwNfUcqrw@mail.gmail.com>
Subject: Re: [PATCH] arch: Cleanup unused functions
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 30, 2021 at 7:08 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Tue, 25 May 2021 05:20:34 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These functions haven't been used, so just remove them. The patch
> > has been tested with riscv, but I only use grep to check the
> > microblaze's.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/microblaze/include/asm/page.h |  3 ---
> >  arch/riscv/include/asm/page.h      | 10 ----------
> >  2 files changed, 13 deletions(-)
> >
> > diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> > index bf681f2..ce55097 100644
> > --- a/arch/microblaze/include/asm/page.h
> > +++ b/arch/microblaze/include/asm/page.h
> > @@ -35,9 +35,6 @@
> >
> >  #define ARCH_SLAB_MINALIGN   L1_CACHE_BYTES
> >
> > -#define PAGE_UP(addr)        (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> > -#define PAGE_DOWN(addr)      ((addr)&(~((PAGE_SIZE)-1)))
> > -
> >  /*
> >   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
> >   * it is set to the kernel start address (aligned on a page boundary).
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index 6a7761c..a1b888f 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -37,16 +37,6 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > -#define PAGE_UP(addr)        (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> > -#define PAGE_DOWN(addr)      ((addr)&(~((PAGE_SIZE)-1)))
> > -
> > -/* align addr on a size boundary - adjust address up/down if needed */
> > -#define _ALIGN_UP(addr, size)        (((addr)+((size)-1))&(~((size)-1)))
> > -#define _ALIGN_DOWN(addr, size)      ((addr)&(~((size)-1)))
> > -
> > -/* align addr on a size boundary - adjust address up if needed */
> > -#define _ALIGN(addr, size)   _ALIGN_UP(addr, size)
> > -
> >  #define clear_page(pgaddr)                   memset((pgaddr), 0, PAGE_SIZE)
> >  #define copy_page(to, from)                  memcpy((to), (from), PAGE_SIZE)
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> It's generally easier if you split this sort of stuff up, as it'll be
> easier to merge if we don't have to coordinate between the trees.  I'm
> happy to take this, but I'd prefer an Ack from one of the microblaze
> folks first.
Em ... I'll separate it. Thx for reply.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

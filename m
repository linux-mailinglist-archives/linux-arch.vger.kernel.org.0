Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F8390E29
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 04:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhEZCIR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 22:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhEZCIR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 22:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CD2961260;
        Wed, 26 May 2021 02:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621994806;
        bh=yRr75FXBDkkX6XLpZgf/r8ILJmMAe0Rn0jw76SQB5fU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HxqB9QXadza+92feVmfiJr0l8ONPm4BbzOMPBgsjDVHEaJq73542HPp1zGpMa1HgU
         9cAUCVmpj3/FJxdaXrwE3o7Id+LEuVoCaT6jOwAGcOHzJl0/UpfqivPhGNVRpVaLIv
         EvEI9sPIJRY1N2iivViNbS02uvoRV+M1vlW14Y1pavPqAD8BcB0LECLj7tV/hUYUvT
         K2hHNTg6nPy5N+ZpGLqixXKirhUOhVwjyO139vMlCAXGUUkFzSybJwQUxm+GFoGJnD
         e0Jttoe6+ywFvlOx05GKX79atc7ohdY5+PKY7M2IgUvXpF9nZonpR9VDcVg75QxeLU
         XHUkIWlfVUjaQ==
Received: by mail-lj1-f172.google.com with SMTP id v5so40667797ljg.12;
        Tue, 25 May 2021 19:06:46 -0700 (PDT)
X-Gm-Message-State: AOAM532zmY8TBS9qkIzV8DKcDEW+uq0s0h4sCdlsraJObRfdQ7Y+vB9T
        94x9TAvLIwSYAqC2fJQ02nMqxG9o/Q4/aoh8NS4=
X-Google-Smtp-Source: ABdhPJxvzHi5wR2bxJ1FRaG/UA35jIYFHUzKTYzsu/MTRD8c5prpdij+urvuWwGp7gCfRvxKrhFG98Rfggw/X7Q+Y7Y=
X-Received: by 2002:a2e:1416:: with SMTP id u22mr386289ljd.498.1621994804881;
 Tue, 25 May 2021 19:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <1621945234-37878-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1621945234-37878-1-git-send-email-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 26 May 2021 10:06:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTaw3WyFoSyK9O6WOxJwsxphX+xu3C+dSFVH6F6fQa3Ww@mail.gmail.com>
Message-ID: <CAJF2gTTaw3WyFoSyK9O6WOxJwsxphX+xu3C+dSFVH6F6fQa3Ww@mail.gmail.com>
Subject: Re: [PATCH] arch: Cleanup unused functions
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

Could you help add the patch to your next-tree?

Also, please append below:

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anup Patel <anup@brainfault.org>

Thx

On Tue, May 25, 2021 at 8:21 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These functions haven't been used, so just remove them. The patch
> has been tested with riscv, but I only use grep to check the
> microblaze's.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/microblaze/include/asm/page.h |  3 ---
>  arch/riscv/include/asm/page.h      | 10 ----------
>  2 files changed, 13 deletions(-)
>
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index bf681f2..ce55097 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -35,9 +35,6 @@
>
>  #define ARCH_SLAB_MINALIGN     L1_CACHE_BYTES
>
> -#define PAGE_UP(addr)  (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)        ((addr)&(~((PAGE_SIZE)-1)))
> -
>  /*
>   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
>   * it is set to the kernel start address (aligned on a page boundary).
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6a7761c..a1b888f 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -37,16 +37,6 @@
>
>  #ifndef __ASSEMBLY__
>
> -#define PAGE_UP(addr)  (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)        ((addr)&(~((PAGE_SIZE)-1)))
> -
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr, size)  (((addr)+((size)-1))&(~((size)-1)))
> -#define _ALIGN_DOWN(addr, size)        ((addr)&(~((size)-1)))
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr, size)     _ALIGN_UP(addr, size)
> -
>  #define clear_page(pgaddr)                     memset((pgaddr), 0, PAGE_SIZE)
>  #define copy_page(to, from)                    memcpy((to), (from), PAGE_SIZE)
>
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

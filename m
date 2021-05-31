Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486AC395AA3
	for <lists+linux-arch@lfdr.de>; Mon, 31 May 2021 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEaMer (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 May 2021 08:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEaMeq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 May 2021 08:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D81D610C9;
        Mon, 31 May 2021 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622464387;
        bh=0Ao6p/tCN0lLmwFOL3ikaLa3kNQR3rdJ0oGyStE28vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ikpLtgpys9PI219jFN9/zG2VA6HBESrTqKXixKRNifYGrKNzw+9HTW4jScV6coQ9l
         GxCum1F3zUexqoinnBNB3moHoKndL0VgktA6yHCkKyvs16ocIhQvbTkiV52bD9cwPk
         8e2vHK0XgSYaL/qmV6aaaX3SyIkz/IBNV1Bhv1IzzZ0dujtoF5uvaeVpjhgYuuGX2y
         9FfRROisMpKMSVVD6ZMDZsyMQnOddUNrGAFBK8yVyMFgncEbNwEywBtFu+Y2QjBGFo
         n+shdHlioqm6XRi4/OOdEJ8o2SFjiyTcUDa5Fi883xQJJDm8GupqLNBA3M4A9bWpKB
         owiFQRPkFkxhQ==
Received: by mail-lf1-f43.google.com with SMTP id f30so16683203lfj.1;
        Mon, 31 May 2021 05:33:07 -0700 (PDT)
X-Gm-Message-State: AOAM532jLIRZiM7hh0iOxsRgKc734kc55MSW/mPyhPWz48yyo6o6qwOU
        0Z8hdkplpHqX0H40AksPWNN7dsKtjyHJ7qDo5tc=
X-Google-Smtp-Source: ABdhPJxfkfBwOVqzBzMgxibHiDT1eCvcg1+7OdH3J/JTWXYDq1/MYIQ0oSYnpIXJuwWXjFhu1rxoF7vHe+4jY/JSOXk=
X-Received: by 2002:a19:5209:: with SMTP id m9mr3806497lfb.24.1622464385463;
 Mon, 31 May 2021 05:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <1622350408-44875-1-git-send-email-guoren@kernel.org>
 <1622350408-44875-3-git-send-email-guoren@kernel.org> <73bf48c1-6692-795c-ba16-b7baeb11d3b9@monstr.eu>
In-Reply-To: <73bf48c1-6692-795c-ba16-b7baeb11d3b9@monstr.eu>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 31 May 2021 20:32:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ6vVHYpw8WVJZqHjkm3gxNkGev9Cq+AzDcOiueSZTA6w@mail.gmail.com>
Message-ID: <CAJF2gTQ6vVHYpw8WVJZqHjkm3gxNkGev9Cq+AzDcOiueSZTA6w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] microblaze: Cleanup unused functions
To:     Michal Simek <monstr@monstr.eu>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 31, 2021 at 8:25 PM Michal Simek <monstr@monstr.eu> wrote:
>
>
>
> On 5/30/21 6:53 AM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > These functions haven't been used, so just remove them. The patch
> > just uses grep to verify.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Michal Simek <monstr@monstr.eu>
> > ---
> >  arch/microblaze/include/asm/page.h | 3 ---
> >  1 file changed, 3 deletions(-)
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
> >
>
> Ah ok. you have sent v2. Will take this version instead of previous one.
No need, they are the same, Thx.

>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

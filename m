Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EE2D01F8
	for <lists+linux-arch@lfdr.de>; Sun,  6 Dec 2020 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgLFIkS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Dec 2020 03:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgLFIkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2020 03:40:17 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78040C0613D0;
        Sun,  6 Dec 2020 00:39:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so9583734wrs.4;
        Sun, 06 Dec 2020 00:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPQpDYkjbkwCoiD1+juG9zqIYLBLtaHF+LBjNA/5Kdw=;
        b=Ri2vWoYTJ6G4Stx/W9/EYkJ3p9wOMxhUIFWSDuloMlm/SWfoUlIXMT1ryZF7IA2BC0
         NRpm/uvuta153AlhOPDBk5civ/b4qENFWDA+LxuXIrkK2abp18f2TCu8MOyZqjz7zD78
         p0Nx08WryRYzZmN4hHUBQBaRVB214Dt1G3MuZfZh1Ka79Fhu4x+Bd6yILRPeB3OKccVc
         cbJMZ8rv+c5yTpJnBFOIZ2jaOiu6NXHUZjryY3SwDAFvqbY63IzIKGwnhIEQeTYzajho
         95m26ZgpUqeueYDQ4Dd9Qroy/rLlSDEtoN9cea5IEQA02lQT9tNtbWixzw7y4bdDo+/j
         xtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPQpDYkjbkwCoiD1+juG9zqIYLBLtaHF+LBjNA/5Kdw=;
        b=JOfSWb3nMNQWkZ5FcXEwRuAhJXiFxJt0GymsT52icJ2XdYkmEpiMZNXiWz5KNgIVwT
         tYaE+PztlbRo7XfrsToKGBi0/C/bGVTIeunnEJcZnidJOFe92TNeaRrQOqQGtJtuU1Ec
         Xk6eb/8MgznHxLLlbt3HZ+3JpcdJi3XFYDmOmvhdxYLdiayOskbbqZc7YgfhpeSlfT5E
         SNMsIYQxLGSyvvRbBXJR9b2lfXXFVeNDmUNS/ORUQ4CELVZd5yvaDdM+FCBTdWeGk8jq
         WMwEQ59ngk3esB/lVCL8vKpkuUfv7FUm/9BinzET6tFJtBYnT9f2bD+CxaMC6xvAntqS
         K4IQ==
X-Gm-Message-State: AOAM531aulND07+S4ACESdxv3Xw683ne+WKPYjvA1L7zNZboOGrP4fDR
        0x/QNF/PBALb5K1dX7zrcWCikOO5M+ffDilDTSE=
X-Google-Smtp-Source: ABdhPJyBd+OnqrCIklB+ogp6TX5gMOOz3SVeb6dk3Ctp/xkR+4JMMoo9/YpwwJaKMIgo27GNSrnqLI62OArTv+1si3E=
X-Received: by 2002:adf:90f1:: with SMTP id i104mr10248596wri.348.1607243969831;
 Sun, 06 Dec 2020 00:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20201206064624.GA5871@ubuntu> <X8yWxe/9gzosFOam@kroah.com>
In-Reply-To: <X8yWxe/9gzosFOam@kroah.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sun, 6 Dec 2020 17:39:16 +0900
Message-ID: <CAM7-yPSPxTz8CmVfD2vC=P4RW6yBXsYiH+YfKQtd4PzPj=ocvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
To:     gregkh@linuxfoundation.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>, broonie@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, mhiramat@kernel.org,
        jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        Alexander Potapenko <glider@google.com>, orson.zhai@unisoc.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        dushistov@mail.ru,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> This, and the change above this, are not related to this patch so you
> might not want to include them.
>
> Also, why is this patch series even needed?  I don't see a justification
> for it anywhere, only "what" this patch is, not "why".

A little part of codes are trying to find the last zero bit using
for_each_clear_bit.
For example in fs/btrfs/free-space-cache.c' s
steal_from_bitmap_to_front function
which I changed in the 8'th patch.
I think it has some overhead to find the last clear bit (it start to
find from 0 bit to specified index),
so I try to add the find_last_zero_bit function to improve this.

Maybe I have a lack explanation in the message.

Sorry to make noise.

Thanks.
Levi.



On Sun, Dec 6, 2020 at 5:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Dec 06, 2020 at 03:46:24PM +0900, Levi Yun wrote:
> > Inspired find_next_*_bit and find_last_bit, add find_last_zero_bit
> > And add le support about find_last_bit and find_last_zero_bit.
> >
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > ---
> >  lib/find_bit.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/find_bit.c b/lib/find_bit.c
> > index 4a8751010d59..f9dda2bf7fa9 100644
> > --- a/lib/find_bit.c
> > +++ b/lib/find_bit.c
> > @@ -90,7 +90,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >  EXPORT_SYMBOL(find_next_zero_bit);
> >  #endif
> >
> > -#if !defined(find_next_and_bit)
> > +#ifndef find_next_and_bit
> >  unsigned long find_next_and_bit(const unsigned long *addr1,
> >               const unsigned long *addr2, unsigned long size,
> >               unsigned long offset)
> > @@ -141,7 +141,7 @@ unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
> >  {
> >       if (size) {
> >               unsigned long val = BITMAP_LAST_WORD_MASK(size);
> > -             unsigned long idx = (size-1) / BITS_PER_LONG;
> > +             unsigned long idx = (size - 1) / BITS_PER_LONG;
> >
> >               do {
> >                       val &= addr[idx];
>
> This, and the change above this, are not related to this patch so you
> might not want to include them.
>
> Also, why is this patch series even needed?  I don't see a justification
> for it anywhere, only "what" this patch is, not "why".
>
> thanks
>
> greg k-h

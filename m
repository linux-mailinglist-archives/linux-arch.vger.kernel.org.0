Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A223F30B87D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhBBHOu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 02:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhBBHOt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 02:14:49 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83457C06174A;
        Mon,  1 Feb 2021 23:14:09 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id q9so18141866ilo.1;
        Mon, 01 Feb 2021 23:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+rprk54pLD+tPDUDUth98iylk1i9f9VqxJ5r+zi39c=;
        b=Th9dnnelCfdRL7BYukHCwGMUPbVimhNiEEJWsLCr8Q13rAkjxz5K8GqnB1qapqAkGU
         nj06n8frT81N36DIcD858nXiNFRgYM+yIctWtBQ5Fxslvi9RLKfvd+6tURpfxr1JSMG2
         RtT3XmXnl7/Yiy0Gsjk4xBeGJizgyyoU2CzRdURLcv/3cfM98rngr/SxAzVIwRFPFqmM
         taJqz+DKifH3yetB6gYAKRzkC9nVQl6gO1vlBSLkwgPPorEXoq8M6C2ZPKvQe/M8EU8Q
         BHUjsCK6ebAba+SHxu5qrobawj+MFn/UvoyDOEE5DUR8PrY9vBGQSx73F+TRNhJESQlO
         6U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+rprk54pLD+tPDUDUth98iylk1i9f9VqxJ5r+zi39c=;
        b=LLXEMbiBPukveOhcuz98FRFjz0enaSK+l0m8IAAyQk75xfAXJEmjfQcM6ttvYYp2C3
         cPIQKSUUuXz3BIJlwa2yTWzOZqYQ/sUyXPA1FHuvUM6Tz7ShUMD2Unfp8wB071fldE9f
         YRoXiHxnjCGE/kg/VETOrcFOR1+w3j9gf4lN4FB//fcb/PLmlE6E4NFNAkw0wz8U9vFs
         7VGT8Q2vC+nH5UYG7QMYvi3Uv/T8ZhW4VqL/VTSRQzMrnYaH77Q7vbbHgQHpnBiUiW1G
         APRxWwUVX4adOUcGAIxNxlNaPyXhH6VWHv1lKYtMEY+m9oq7Seshpz6oPzWiQ6QiRT/D
         S9Yg==
X-Gm-Message-State: AOAM533synBw8ilcVNhJmphY170RprQNL/2TlctokpJxxKukoxoKJ9xS
        vQ/s0XDOCQjTBBEj+tGr3aV0coDkaK948nWAsTI=
X-Google-Smtp-Source: ABdhPJzBBRVeY2XvzS/PhDUkTY1NGKiWnEwaAxpWkPAguR8twjHyytuvNS0+zU7r9F0yqCcsul4GAOM+Mru+mdzQGQc=
X-Received: by 2002:a92:3646:: with SMTP id d6mr16601311ilf.170.1612250048847;
 Mon, 01 Feb 2021 23:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20210130191719.7085-1-yury.norov@gmail.com> <20210130191719.7085-7-yury.norov@gmail.com>
 <YBgGf8y/K0da5MWz@smile.fi.intel.com>
In-Reply-To: <YBgGf8y/K0da5MWz@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 1 Feb 2021 23:13:58 -0800
Message-ID: <CAAH8bW-rOejgtYFpHQMA-M7MnpPT-8XAZtNOqMMYYxFo7xX8mw@mail.gmail.com>
Subject: Re: [PATCH 6/8] lib: inline _find_next_bit() wrappers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 1, 2021 at 5:47 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Jan 30, 2021 at 11:17:17AM -0800, Yury Norov wrote:
> > lib/find_bit.c declares five single-line wrappers for _find_next_bit().
> > We may turn those wrappers to inline functions. It eliminates unneeded
> > function calls and opens room for compile-time optimizations.
>
> >  tools/include/asm-generic/bitops/find.h | 27 +++++++++---
> >  tools/lib/find_bit.c                    | 52 ++++++++++-------------
>
> In a separated patch, please. I don't think we need to defer this series in
> case if tools lagged (which is usual case in my practice).

Splitting it to kernel and tools parts means either a patch bomb for tools or
doubling the size of the series. Both options look worse than what we have now.

Can you explain more on the lagged tools argument?

> --
> With Best Regards,
> Andy Shevchenko
>
>

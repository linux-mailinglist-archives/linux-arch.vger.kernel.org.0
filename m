Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1ED1E8A41
	for <lists+linux-arch@lfdr.de>; Fri, 29 May 2020 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgE2Vn1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 17:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgE2VnS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 17:43:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3BC03E969;
        Fri, 29 May 2020 14:43:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so1751505plb.3;
        Fri, 29 May 2020 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uT7cHk62jXe3KHtprB25M7PHVHdyFhE/uUPeWrpvv9w=;
        b=QYz1OXxO364y3rZHwVsVIT4cYLNDQSWneyKa8hEdP5PsGSa3G8oBET2klf8IDF28n8
         fLT/4dULrAmN65403MIfm+jFzoRPRZ6iWl3xsoowsk/CY45C3u6o57FEaVa2surQc+GB
         ydDTNsSxfJ6m4BZY/5Y5vcp1sFNLmKl6VSZBICv5zZccQKRWCyGg7M9u+5VlBfDbP4mQ
         9cFvmiRtdzICCCDT/3DtDnAlBAttpXKJK/N5I7dlPNJzSQCuxkldYmQqTY8Nez67VQJG
         c76fJP1UE5lzmsqbm1jApBsP59TYlhmFLWw3MoVDymKM9Vy4U4U0blkEiD4t9Tkd1Z3Y
         2Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uT7cHk62jXe3KHtprB25M7PHVHdyFhE/uUPeWrpvv9w=;
        b=LSu2OJVojZOU8Ou4jUDoBYYKJWjTAE7BJbsjvnnp412PL3vy93V3NQ7t19Qpe+8fWk
         uB+nuFYvL8Tq6oxkPbDxNBHDN/fQLLfsCPK/S85VkHEaIV7Y7QWSbHZNo71wVlTrHAtB
         MBdAyIN9fW20T5Cttzif7fatZvT+NW7lfhAlOElNSJZ8xDmLd8jZZRw8ddduZML7zxi+
         83eqtDaDLref/rrYBDzGzcwPy1edZKuyCCVKNyeB30oLkl6uC1Lnni0DMXCLMEg6ypYw
         zeUnBfJ08YHx/RzTLjCm2NJjQqvhJf5q2k18Djn4DeKD0BZOMv68jtNPu3+Fpx6MluyR
         NUHg==
X-Gm-Message-State: AOAM532+ll2aDxusrWRb0SEgsdrsIvQXPzgdD0wuB5Ufa4yi1nJ4Lnmv
        SypBgm/9GMCi6gBvxDA/GIGERNYVh9pgb+vFz/bqrgplGHa7Mg==
X-Google-Smtp-Source: ABdhPJya8efhSaZCP0xWTsRW0QJwB4vFW1FhvB0+LScwYS3TraNFCcw4uujKetpMjPK60KVltoPzqlZpZOVELoGOlT8=
X-Received: by 2002:a17:902:d68e:: with SMTP id v14mr10323805ply.262.1590788596831;
 Fri, 29 May 2020 14:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
In-Reply-To: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 May 2020 00:42:59 +0300
Message-ID: <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 29, 2020 at 11:07 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> > > On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:

...

> > > Taking the example statement (in my patch) where compilation warning
> > > is getting reported:
> > > return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> > >
> > > 'nbits' is of type 'unsigned long'.
> > > In above, the sanity check is comparing '0' with unsigned value. And
> > > unsigned value can't be less than '0' ever, hence the warning.
> > > But this warning will occur whenever there will be '0' as one of the
> > > 'argument' and an unsigned variable as another 'argument' for GENMASK.

> > Proper fix is to fix GENMASK(), but allowed workaround is to use
> >         (BIT(nbits) - 1)
> > instead.

> When I used BIT macro (earlier), I had faced a problem. I want to tell
> you about that.
>
> Inside functions 'bitmap_set_value' and 'bitmap_get_value' when nbits (or
> clump size) is BITS_PER_LONG, unexpected calculation happens.
>
> Explanation:
> Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
> (BIT(nbits) - 1)
> gives a value of zero and when this zero is ANDed with any value, it
> makes it full zero. This is unexpected and incorrect calculation happening.
>
> What actually happens is in the macro expansion of BIT(64), that is 1
> << 64, the '1' overflows from leftmost bit position (most significant
> bit) and re-enters at the rightmost bit position (least significant
> bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> subtracted from this, the final result becomes 0.
>
> Since this macro is being used in both bitmap_get_value and
> bitmap_set_value functions, it will give unexpected results when nbits or clump
> size is BITS_PER_LONG (32 or 64 depending on arch).

I see, something like
https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L139
should be done.
But yes, let's try to fix GENMASK().

So, if we modify the following

  #define GENMASK_INPUT_CHECK(h, l) \
    (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
    __builtin_constant_p((l) > (h)), (l) > (h), 0)))

to be

  #define GENMASK_INPUT_CHECK(h, l) \
    (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
    __builtin_constant_p((l) > (h)), (l) ? (l) > (h) : 0, 0)))

would it work?

> William also knows about this issue:
> "This is undefined behavior in the C standard (section 6.5.7 in the N1124)"

I think it is about 6.5.7.3  here, 1U << 31 (or 63) is okay.

--
With Best Regards,
Andy Shevchenko

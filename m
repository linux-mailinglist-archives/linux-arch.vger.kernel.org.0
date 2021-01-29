Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210C308F71
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 22:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhA2V3m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 16:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhA2V3d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 16:29:33 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9090EC061573;
        Fri, 29 Jan 2021 13:28:31 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d13so10846413ioy.4;
        Fri, 29 Jan 2021 13:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKpEQgZS1QCYwcoVA/IcLJsT/QZzUi4/M7PsXGgpQfE=;
        b=fMRZFK4ep5zSIRr70ydxpadj/9KtuXo9IlmMEwZ6aSBmmveC0Kz+0vmK1ixQQC/7Dj
         qTJVh5F+GLeCkuf41AJz1lOvFQ2EKeYDkywPzv93VmDy76NGDbC4hM6Jz6JaAv04VqXj
         5mX4Z3nEzvkJuXl4k0bGt1bMZhEByd2J0lAFiApkCUsNEORaDgcXtmoSEf/gJnGryNsm
         M/iRbEHi03TsNCLtiy+nzqn3QJHBqCCkyszrVeY7L+A1akugY+wMl7wNM4ORmgnJxWIB
         Dmhbg/tO6wMnLD80Bfd+NynUkV4ToUW2V5318Ycg8GVEZhEDerA5AWIemBVmvJ2iGmTR
         VG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKpEQgZS1QCYwcoVA/IcLJsT/QZzUi4/M7PsXGgpQfE=;
        b=JNvs1xdOwz4bZTjU8d76FaJTDCuFqt8Ri/M89MObsWr5b7BunU2L4Qxyoff5mM048G
         IqmXrKnmsJgQ5NgSYM3CDNRCv0h9O+oQQo+h0xWbUnyYXAYlhr40mf6PkQaPnVqboAOe
         Ipx0lmEeI/jfJ+vssvJpyeRhnts8PMWGnwmIrmx+s63CSAMOa4OyzxkSShTK+X288fh9
         Sl32rmqRdD7vyjp/Os+SeVCT9RtXMjobAaVDHBoQVOZEwhTZyZy1knyHpbN147Ut/M2M
         1uw1pCNVuOW/PlVV+js9NR46OPM5pMQfo7MnbGVBzi4cYCXOjXazUAOtfCvZXDqwDLhT
         hNHw==
X-Gm-Message-State: AOAM531UCpqNA/eYvLum2TJLXZVWbPbqcx/EPVilcjYL8B9+By2pTHvu
        G0XNaT2QbNMkCY2PDUe+Ehtd8OGBhFWBhSCrmDQ=
X-Google-Smtp-Source: ABdhPJxQHThyPfYaf7dcZ8ePzMFtwOJvGemJiselxNzpqvhf5JHQn1G8eLTOO/AEnjalkFd2AazRdzRyVOSIgCGs158=
X-Received: by 2002:a05:6638:1344:: with SMTP id u4mr5560181jad.86.1611955711081;
 Fri, 29 Jan 2021 13:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20210129204528.2118168-1-yury.norov@gmail.com>
 <20210129204528.2118168-4-yury.norov@gmail.com> <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
In-Reply-To: <CAHp75VcSc=myrcvyBOkaUDguR6aPjJAFFXi2iSvmU21+1664Hw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 29 Jan 2021 13:28:20 -0800
Message-ID: <CAAH8bW_Gt+0bC=S2HtR_B3cH-KGJQQaUQ0z0xn=aZCtBzy43yQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] bits_per_long.h: introduce SMALL_CONST() macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 1:11 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:49 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Many algorithms become simplier if they are passed with relatively small
>
> simpler
>
> > input values. One example is bitmap operations when the whole bitmap fits
> > into one word. To implement such simplifications, linux/bitmap.h declares
> > small_const_nbits() macro.
> >
> > Other subsystems may also benefit from optimizations of this sort, like
> > find_bit API in the following patches. So it looks helpful to generalize
> > the macro and extend it's visibility.
>
> > It should probably go to linux/kernel.h, but doing that creates circular
> > dependencies. So put it in asm-generic/bitsperlong.h.
>
> No, no, please leave kernel.h alone. It's already quite a mess.
>
> And this shouldn't be in the commit message either.
>
> ...
>
> > -       if (small_const_nbits(nbits))
> > +       if (SMALL_CONST(nbits - 1))
>
> Not sure if we need to rename it.

Lower case for generic macro kind of breaking the rules.

Behaviour has changed too. Before it was:
0 < VAL <= 32
Now it's
0 <= VAL < 32
Which is better for generic macro.

So changing the name looks reasonable to me.

> ...
>
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -37,7 +37,7 @@
> >  #define GENMASK(h, l) \
> >         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >
> > -#define BITS_FIRST(nr)         GENMASK(nr), 0)
> > +#define BITS_FIRST(nr)         GENMASK((nr), 0)
>
> How come?!

git send-email wrong_dir/000*
Will resubmit today later.

> ...
>
> > diff --git a/tools/include/asm-generic/bitsperlong.h b/tools/include/asm-generic/bitsperlong.h
> > index 8f2283052333..432d272baf27 100644
> > --- a/tools/include/asm-generic/bitsperlong.h
> > +++ b/tools/include/asm-generic/bitsperlong.h
>
> I think a tools update would be better to have in a separate patch.
>
> --
> With Best Regards,
> Andy Shevchenko

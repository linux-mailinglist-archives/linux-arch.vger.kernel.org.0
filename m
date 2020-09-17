Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1D26E26F
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIQRcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 13:32:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42827 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgIQRb6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Sep 2020 13:31:58 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpUpW-1kqvZm1lvw-00pql1; Thu, 17 Sep 2020 19:29:54 +0200
Received: by mail-lf1-f53.google.com with SMTP id b22so3032151lfs.13;
        Thu, 17 Sep 2020 10:29:54 -0700 (PDT)
X-Gm-Message-State: AOAM532ihZRAecplX3fYbRwKWyjIBw6zinPu3GUYdgLKb6hQTFWLqifG
        l8AGO87mT0NihAFepRdVUQL6Tg44JhuAyyACwv0=
X-Google-Smtp-Source: ABdhPJzwgZONEEbeCNVowNajGNC0I3sxwCqfiLLvbIfHBJmaGq8bHpOEUS4++jrPo6OMAEeRAFD1NnTekokAhv3RdV4=
X-Received: by 2002:a19:81cc:: with SMTP id c195mr8826623lfd.274.1600363793772;
 Thu, 17 Sep 2020 10:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-3-arnd@arndb.de>
 <20200908061528.GB13930@lst.de>
In-Reply-To: <20200908061528.GB13930@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Sep 2020 19:29:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a22EiD-uMZQaBpHQYyy=MJ_7J-ih=6CtgH_9RXT6OOYvg@mail.gmail.com>
Message-ID: <CAK8P3a22EiD-uMZQaBpHQYyy=MJ_7J-ih=6CtgH_9RXT6OOYvg@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of set_fs()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux- <kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EJWme0fl08M+nevYKi7T9EiZ1cAWhKsZe1VYy+NPrU6H5ml9Vwz
 GLx9fgRi4YITtEOu/3V3T/BQ0LEr09olXsPb05aunh5Af6SPz/Ns0MnZnRHzLpQ9nH0LzzY
 yI7FpJl174dLNCapbMPDHWT/sCW7MGdhL1Oi2acKpOJkDMJxhtijd95twilVjneTf4QHzMi
 hxLwrAFEruRgtBmTc0emg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZCU/w1Vq4M0=:/YKfNEkxNxxMqdjwqld7wv
 uca3Oid+Ja4lHi1RV6ga5MwTW9FWgPTTPk7aVNlSAnYk18kdGPy9zth4TUKOy6irdYhC0EisX
 Be3CPJqXTS86bm2Q+KaDVyAqvZkqJQMLCPi90Wbh4Ew+/YDSPpB6CQannD25KEmMYQV8hxGe2
 AcBl5P1rC8nwCVlGHlLfNZOLkE+J2cfcdgjg3Q0W9qn6ydIUN2zVa/gssuWN6+AdcCaoPKq3+
 jFAcf1Q52yN+QpneKl9dN+SP6zgye14kg06QdxQ2Z1ej2VCsxroMpIedFnOdQKhEYb4gbPZ8a
 eSC2xzBbETfYIP+cBC2aHBubzd7gX70H8FeeLaohc0V0cKfI+eEIuXSl2+kjVi2wOY19eaqe0
 GuWmnTftlDPIDw76DFSFLNNYSnAaOivL7GIK5KGklvXYs6HADlShFP/HUa9gzvdbK2EzM+UdH
 mfKKUy4TL6mY7gyT/MDwIMacMYKA4FH1CsRBunDlDugz1zhKYNAM9b9v7//+AjCMTPN/7h/Ts
 9iWrf3SiAg2e1TAf1TkCj0Su/7RE/j1g+azbnMYBB5/ShxZLB3U/2LaTN8YohQInAkR/25LgP
 6PPgxiZ1XaF51UEcoGNVPpiYY1NxJHa4Vkby9P3FqeZmGxRpgWU926Jgzr5bN8tfYZi55T09q
 B1br+XDEMlLoWEPV8XHfOTgZKHgQPaX92iZwsit/sfiENXczp5IrlZ4bo1cWbB1EnQ+kam0/a
 lc0wLgLLCL+tNFV/gi96f7E5gZ5cSLjmSvP//6QzPryEzO5vuF8mLchgzCZXr++FvO8Iu4yxn
 0pFYxWsXVgs6FkTSOcHEKJMcsQxJnlDdrZeXbCyUc9UyNW+BXomb1mGnSsBDzmaastH7e975G
 QM4d8xNS0rX+APIFILySC803mVG2/egPdMLdvjzUZizfFUfLrWdOOHh8eldFwXmNsM6h1Tmml
 9WE6/H+Amgvw2H4ziFY2uUMzvZ/wuVNQxdktvCttznHYcXR+W2/i8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 8, 2020 at 8:15 AM Christoph Hellwig <hch@lst.de> wrote:
>
> > +static void dump_mem(const char *, const char *, unsigned long, unsigned long, bool kernel_mode);
>
> This adds a pointlessly long line.

Fixed.

> And looking at the code I don't see why the argument is even needed.
>
> dump_mem() currently does an unconditional set_fs(KERNEL_DS), so it
> should always use get_kernel_nofault.

I had looked at

        if (!user_mode(regs) || in_interrupt()) {
                dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
                         THREAD_SIZE + (unsigned
long)task_stack_page(tsk), kernel_mode);

which told me that there should be at least some code path ending up in
__die() that has in_interrupt() set but comes from user mode.

In this case, the memory to print would be a user pointer and cannot be
accessed by get_kernel_nofault() (but could be accessed with
"set_fs(KERNEL_DS); __get_user()").

I looked through the history now and the only code path I could
find that would arrive here this way is from bad_mode(), indicating
that there is probably a hardware bug or the contents of *regs are
corrupted.

Russell might have a better explanation for this, but I would assume
now that you are right in that we don't ever need to care about
dumping user space addresses here.

> > +static void dump_instr(const char *lvl, struct pt_regs *regs)
> >  {
> >       unsigned long addr = instruction_pointer(regs);
> >       const int thumb = thumb_mode(regs);
> > @@ -173,10 +169,20 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
> >       for (i = -4; i < 1 + !!thumb; i++) {
> >               unsigned int val, bad;
> >
> > -             if (thumb)
> > -                     bad = get_user(val, &((u16 *)addr)[i]);
> > -             else
> > -                     bad = get_user(val, &((u32 *)addr)[i]);
> > +             if (!user_mode(regs)) {
> > +                     if (thumb) {
> > +                             u16 val16;
> > +                             bad = get_kernel_nofault(val16, &((u16 *)addr)[i]);
> > +                             val = val16;
> > +                     } else {
> > +                             bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
> > +                     }
> > +             } else {
> > +                     if (thumb)
> > +                             bad = get_user(val, &((u16 *)addr)[i]);
> > +                     else
> > +                             bad = get_user(val, &((u32 *)addr)[i]);
> > +             }
>
> When I looked at this earlier I just added a little helper to make
> this a little easier to read.   Here is my patch from an old tree:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/67413030ccb7a64a7eb828e13ff0795f4eadfeb7

I think your version was broken for the in-kernel thumb version
because get_kernel_nofault does not widen the result
from 16 to 32 bits. I tried fixing this in your version, but the
result ended up more complex than my version here, so I
decided to keep what I had.

       Arnd

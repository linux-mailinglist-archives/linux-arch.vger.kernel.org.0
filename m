Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C41431EC
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 20:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgATTDE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 14:03:04 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgATTDE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 14:03:04 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MHGPA-1ipALF2U3E-00DGre; Mon, 20 Jan 2020 20:03:01 +0100
Received: by mail-qt1-f177.google.com with SMTP id v25so614991qto.7;
        Mon, 20 Jan 2020 11:03:01 -0800 (PST)
X-Gm-Message-State: APjAAAU2b19EsYgjPqf3lWEury14h744bF3DovOfFzCgBvQyc5ygBq/O
        pAbY0ppqjuFg5QdSF2GDwlPUaRpz4ILiGD0V6Lc=
X-Google-Smtp-Source: APXvYqz35x39I8DSspW1D7zXoSgFG6f385p7mWbzgBb6GjESNlGfr5iF1XLATEUOO8X7/j+CYWdeJN7g8IvYvApiM0E=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr805093qtr.7.1579546980409;
 Mon, 20 Jan 2020 11:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20200115165749.145649-1-elver@google.com> <CAK8P3a3b=SviUkQw7ZXZF85gS1JO8kzh2HOns5zXoEJGz-+JiQ@mail.gmail.com>
 <CANpmjNOpTYnF3ssqrE_s+=UA-2MpfzzdrXoyaifb3A55_mc0uA@mail.gmail.com>
 <CAK8P3a3WywSsahH2vtZ_EOYTWE44YdN+Pj6G8nt_zrL3sckdwQ@mail.gmail.com>
 <CANpmjNMk2HbuvmN1RaZ=8OV+tx9qZwKyRySONDRQar6RCGM1SA@mail.gmail.com>
 <CAK8P3a066Knr-KC2v4M8Dr1phr0Gbb2KeZZLQ7Ana0fkrgPDPg@mail.gmail.com>
 <CANpmjNO395-atZXu_yEArZqAQ+ib3Ack-miEhA9msJ6_eJsh4g@mail.gmail.com>
 <CANpmjNOH1h=txXnd1aCXTN8THStLTaREcQpzd5QvoXz_3r=8+A@mail.gmail.com>
 <CAK8P3a0p9Y8080T-RR2pp-p2_A0FBae7zB-kSq09sMZ_X7AOhw@mail.gmail.com> <CANpmjNOUTed6FT8X0bUSc1tGBh3jrEJ0DRpQwBfoPF5ah8Wrhw@mail.gmail.com>
In-Reply-To: <CANpmjNOUTed6FT8X0bUSc1tGBh3jrEJ0DRpQwBfoPF5ah8Wrhw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jan 2020 20:02:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a32sVU4umk2FLnWnMGMQxThvMHAKxVM+G4X-hMgpBsXMA@mail.gmail.com>
Message-ID: <CAK8P3a32sVU4umk2FLnWnMGMQxThvMHAKxVM+G4X-hMgpBsXMA@mail.gmail.com>
Subject: Re: [PATCH -rcu] asm-generic, kcsan: Add KCSAN instrumentation for bitops
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Daniel Axtens <dja@axtens.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jR7dToZSz+pkZ+H0k5vLn3WxHAvBzUvp3ljrXIGkzvRot+PDpsg
 jvUS6yMJBrzIa5w8PoqfcIyUxp6R0ukVQsudQ5jcvbSZBzbkYiGpDO368uKbT3GS1zMTax6
 fYr6mXoL9VkOH4vxVc/626eppN3uzhWad2gTfMiDZowwRgFPV25v52+xoRoMQwhXws8s4O6
 XJlqCZts9DbDomGlf0i7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l3QBPowaTZQ=:sRbWnLFf27OK+UK7+9qpof
 kwPt46XaHvZva95NukcvqRN8B+WTktgovYpCxLpjyzoybNq9aSo4NoTE8QmBoUZS1RmHPBN3O
 JxuSWZwOcUWZcqjCmgwlDy5DyqJDaxkaPz/Nkgult+b7uI34ASguRqWm8dqFl7mm5sGqmi611
 HfMxJJUOIFDrrF6j66MWYHe7WJVFbRjATPfrdN+eP9IU85Gt78j+vrpL4onL9FsJqmuu7mEQE
 r6CbmFtYBc61T3+4ZfcoIdi0jxqcjbW6+cTwSwmhNbt5efjoxt1uXj8opXK8L4SDksSoi8HVl
 fAlVXG7rKO05DiAS06MkyjbZe+jGNDYPevAFAOkxSIUrcIthNQaSBtFHhLzQa3Nod0Vgl2lUW
 SMLHW53liptmhdTg0q4H8m5ChB9jWsVBRhvAbs6gvduiR/vq/goOgRKsr4AoDfXMmTwX7Ad6J
 1A8MuGFWykbHCnXp1OpPsG1A7DHwGt0A00wmobx5RbsZs81otdVXhWH1yo+3meC6aMDN9YLNp
 KJswW9VlS/GYIjjv1KsGzn+pPNWxO+tHx8u9hRgZkDaB/F6u65dSDnnWrN7z00XA++XiOaoqW
 XGQKTCYTokGcjDohE/nGDmTVXpP3MSR6tKLgly1p7mly017IANjzQtZPiAJMVpojVW8Kg/YMb
 IA/A6xN+pNXterGSQo/Vm95Qxgq+PH7d68YGnXbRzLOiHhKVsT88gJrQFyI2W26ChyzBIZ4aP
 Tj9K5CbGego3mfwnPMdfSTmATTp0bm3ESuGDdokiE6CCIDgmXHVyh85xewT3AoxxJFP4W8OBd
 H898tlU9G2jc4aHY2LssA65PElWWQ1MfRAObEL+klzX2MphZ4oXhXqeAeJsNCryjxeA8V9z54
 ucpDaNXlOUyuEr5Kn9fg==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 4:11 PM Marco Elver <elver@google.com> wrote:
> On Mon, 20 Jan 2020 at 15:40, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 20, 2020 at 3:23 PM Marco Elver <elver@google.com> wrote:
> > > On Fri, 17 Jan 2020 at 14:14, Marco Elver <elver@google.com> wrote:
> > > > On Fri, 17 Jan 2020 at 13:25, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Wed, Jan 15, 2020 at 9:50 PM Marco Elver <elver@google.com> wrote:
> >
> > > > > If you can't find any, I would prefer having the simpler interface
> > > > > with just one set of annotations.
> > > >
> > > > That's fair enough. I'll prepare a v2 series that first introduces the
> > > > new header, and then applies it to the locations that seem obvious
> > > > candidates for having both checks.
> > >
> > > I've sent a new patch series which introduces instrumented.h:
> > >    http://lkml.kernel.org/r/20200120141927.114373-1-elver@google.com
> >
> > Looks good to me, feel free to add
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > if you are merging this through your own tree or someone else's,
> > or let me know if I should put it into the asm-generic git tree.
>
> Thank you!  It seems there is still some debate around the user-copy
> instrumentation.
>
> The main question we have right now is if we should add pre/post hooks
> for them. Although in the version above I added KCSAN checks after the
> user-copies, it seems maybe we want it before. I personally don't have
> a strong preference, and wanted to err on the side of being more
> conservative.
>
> If I send a v2, and it now turns out we do all the instrumentation
> before the user-copies for KASAN and KCSAN, then we have a bunch of
> empty hooks. However, for KMSAN we need the post-hook, at least for
> copy_from_user. Do you mind a bunch of empty functions to provide
> pre/post hooks for user-copies? Could the post-hooks be generally
> useful for something else?

I'd prefer not to add any empty hooks, let's do that once they
are actually used.

      Arnd

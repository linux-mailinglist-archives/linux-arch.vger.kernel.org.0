Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9113BC0C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgAOJIv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 04:08:51 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgAOJIu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 04:08:50 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M6lUk-1ijOH900TO-008MZ6; Wed, 15 Jan 2020 10:08:49 +0100
Received: by mail-qt1-f172.google.com with SMTP id w30so15100398qtd.12;
        Wed, 15 Jan 2020 01:08:48 -0800 (PST)
X-Gm-Message-State: APjAAAXjrxzruNS+A5ZgrtTH86BYIR9LbnyORbUf9qeBXDPQHGS6fD0w
        0hQCucNkaX9oNICO4WgJwnHxLJ+JNlkbvRct838=
X-Google-Smtp-Source: APXvYqx/ZPFvs8wMmfr0ffdvulPxbba2XG5TuOUCrt171EJtrRJtlrHppjn0oEiOSkVGfedyftsTi0baZQl8aPF8mWA=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr2537307qtr.7.1579079327857;
 Wed, 15 Jan 2020 01:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
 <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 10:08:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com>
Message-ID: <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lWDX0qUWw1RynUkqlI4vtOwaomIawnHND5fiVUmfjP0BXVUQOcn
 qrN386gq8ZpJ+xSc4cmUApdYkhXz9ALxwPDRDtKJ09buEoxsrCWopArUxDIJcQozp7BWesb
 iklMmQ9LURRhJB3sFV7mjIIvnZOcJWyXtl3ERFjR39jGZlnjnPKoE6H6WYESefz6LH9dnF6
 l3WS7ZXIVT7MiwHhKo36g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7UqkOdDo4jc=:upeTfIyguzac+eEvj5vyJZ
 DFBi1xGCepVqi/N9S9MYMCxtay/YTVXMCWdBFkjn8PoLbHtPWVQlJ9rG8Dhhuv+YLTI4KPdpd
 YkYsLgtFqnNiujB2b5btJAyH/26NvV841K6O6JwCfInM3rmHr5nO+QsieFNZkmAtGS7Ssy7/J
 0zswOxsSM90Uzks6+mcq+gTJ7+yJTiI+QhvtQUS60UDn3DBONHo+/UB6vy3X4NrqWsu7xogQM
 acEzd24CvxOWJ1sV6kqdPnlJDEuM+zZu8vsafxCJM0tHq9IXDPX0ABui7zHDpc3vhpnLd+urz
 msHMMC3HI/LVxQZQT/rP1yz4oCpFv7G1rhEHvR7fRGOaDisBhjVZWf8GMASsMTawENgRSTTvw
 inoQdHX0CrPmrFZsBg3XzHLE0Gzr5t7w+hYs8LU0P3NPcfeiJtPyTzeOZIoSZReVxQfM8YA/9
 FDFqe3qIoiBz60v+pvRW1m8vIC6P+PjLAL2rjs1Z7DppzXq8Ct/cSxY1Jb3KSeSCYrMz2xOTz
 juXfHPn0SZHerIs4I3dhHYoct91GmPyXaoDaDYe2JSw5OJ/q/8QbgVjc6pm4DoLm7CSe/k0Ss
 5RGuYjBvsMX9NcyAPhzw6GL2PLmV76bFNhxsOFJnBrqqJFF71buPJnxGxR76WuVETEmmsURZA
 jQ7+VQ2/T5jGFycAQ7eRhsaKk90tyOqhOG+8sBB0jNHyVpHWKgZzsbap5UOoHSYzA2zlZCjiW
 g3lEm8oPY/EcmctNJKBcH8XI3xBrmsd0Yd4ZXA/3Sag0KYHJiqHz3HGiMsIkDe6fi5Czej3QU
 NjNcvgDhSLKCbeXn8K3i6JlGd/RdMa1UDoYnIQTgEwmlEzcSv9RScGlx/RPLfHcmT33838goy
 BUTLc+l8THYtnY+smN3g==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 10:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
> >
> > There are 2 generic varaints of strncpy_from_user() / strnlen_user()
> >  (1). inline version in asm-generic/uaccess.h
>
> I think we should get rid of this entirely. It's just a buggy garbage
> implementation that nobody should ever actually use.
>
> It does just about everything wrong that you *can* do, wrong,
> including doing the NUL-filling termination of standard strncpy() that
> "strncpy_from_user()" doesn't actually do.
>
> So:
>
>  - the asm-generic/uaccess.h __strncpy_from_user() function is just
> horribly wrong

I checked who is actually using it, and the only ones I found
are c6x and rv32-nommu. It shouldn't be hard to move them over
to the generic version.

>  - the generic/uaccess.h version of strncpy_from_user() shouldn't be
> an inline function either, since the only thing it can do inline is
> the bogus one-byte access check that _barely_ makes security work (you
> also need to have a guard page to _actually_ make it work, and I'm not
> atr all convinced that people do).

That would be arc, hexagon, unicore32, and um. Hexagon already has
the same bug in strncpy_from_user and should be converted to the
generic version as you say. For unicore32 the existing asm imlpementation
may be fine, but it's clearly easier to use the generic code than moving
the range check in there.

I don't know what the arch/um implementation needs, but since it's in C,
moving the access_ok() in there is easy enough.

> I would suggest that anybody who uses asm-generic/uaccess.h needs to
> simply use the generic library version.

Or possibly just everybody altogether: the remaining architectures that
have a custom implementation don't seem to be doing any better either.

     Arnd

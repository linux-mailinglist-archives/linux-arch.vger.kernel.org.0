Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256624C1D17
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 21:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiBWUZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 15:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiBWUZg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:25:36 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECAB4D620;
        Wed, 23 Feb 2022 12:25:05 -0800 (PST)
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOV26-1naljC1Dg6-00PswW; Wed, 23 Feb 2022 21:25:04 +0100
Received: by mail-wm1-f50.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so31673wmq.3;
        Wed, 23 Feb 2022 12:25:04 -0800 (PST)
X-Gm-Message-State: AOAM532Hhopo/vBy3TmiOBpaRgXvM2UjODSoa/dPYObvgEusiEOcONLh
        wuyYBgLKkO2YVHKzGEgQ0KZ5cAkClE4MVvr0h+Y=
X-Google-Smtp-Source: ABdhPJxiMN+ZwMju2gd3tky4L0Ize39g39jLHDwhpYR5QTjWUVsZJ5juZJg0Tyw16LN+7AUvGiKmD7ond8lk7c6UsH0=
X-Received: by 2002:a7b:c191:0:b0:37b:b7e3:b930 with SMTP id
 y17-20020a7bc191000000b0037bb7e3b930mr1072095wmi.35.1645647903930; Wed, 23
 Feb 2022 12:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
In-Reply-To: <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Feb 2022 21:24:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
Message-ID: <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakob <jakobkoschel@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Jfe1X4m3h3tLbwktyEGuP94khgBT4Wep+vQx1J8+N3UW/OG0iEt
 vOJrR1p/9DWiu2YmBzYlPQprR4I+LxucIyTfu/EMsf/+vDjstIkoUAk3HsrBrGGiG8vDMRF
 N2wltb7ExuffaVgjrfbngQ5+/dHd1DxiTCyoIPQ/tb8LKZd1ixhx5BP1lCKAA+oOcQEgux2
 4Z4aYDXbpyqGvaM6KZiJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:svdb5o9ahQg=:qV8URQj9Nw2LISLKh2X1FV
 FrMHvXagSGQbEUxGNyv7vzDUryk2IWUGHe2frVBEvFugjiekwEwk1o+JaGGFNpwkeDjCJRbj0
 Qh0KNiRxKcjDqq2ynyURd+w8hvNyLMd7/N3EiuoyjKn5pVSJUU/cNPK7pNs+zngQWofLO6AAa
 biafejziO4yp34dzf48QnrjHRg7wZjxso/Zn8Q4eH7Dt5YCKwHeQupDVL+DVo34Hm4ZwezEkn
 W8ZcqjnI/W3FY5FRvyBvLBVOYLzhoS+0W29uPhW48h5VhmGanVBUbFLNLKjuTczf1DLJkFoHZ
 V9Om8G+xK+NQFRaNlSmRTDVnaRk8pSLe9ebhgqHSCWLqOGTTr/oc9eFKJBfaqBuS9Icyjt5jN
 3hQB9AI+bcS5tqW8m9nu7FPbaxossYeiq97ixmqvNM8lJKmQRZ/Fn69UZcW3R4NIBkwWAUvHm
 I0C3xCAhs+U7Tqb67jkgRkxJJUj+p39cfdflu4k16Tf/d2RZ1Nmf0qKJdLJQjQLcoDgWdJFjZ
 +1NGY5McKOCkcM79aPkz5OVc5ewxOJ7FleW0sIazWJC1zMyf+SCZZ5nRAtm//tuMzAg2WtVbQ
 fsmjJslOtrW0kxbA9VUb1aAmvHE5oy+C3g9p7LEFxOvBFRYFCul6YJJuoKqUIendshO0xMa76
 DPhmi7QEYsKLjDjopVGMtavX+EqSqWdyug0dzs9BTFqY39FrCqiTHNnZXzC0cNip4o1Q=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 8:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Feb 23, 2022 at 10:47 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Arnd - remind me, please.. Was there some other problem than just gcc-4.9?


I'm pretty sure this was the only thing. And not  even because gcc-4.9 didn't
support later standards, but because it caused some false-postivee
warnings like

In file included from ../drivers/usb/core/notify.c:16:0:
../include/linux/notifier.h:117:9: error: initializer element is not constant
  struct blocking_notifier_head name =   \
         ^
../drivers/usb/core/notify.c:21:8: note: in expansion of macro
'BLOCKING_NOTIFIER_HEAD'
 static BLOCKING_NOTIFIER_HEAD(usb_notifier_list);
        ^
../include/linux/notifier.h:117:9: error: (near initialization for
'usb_notifier_list.rwsem.wait_lock')
  struct blocking_notifier_head name =   \
         ^
../drivers/usb/core/notify.c:21:8: note: in expansion of macro
'BLOCKING_NOTIFIER_HEAD'
 static BLOCKING_NOTIFIER_HEAD(usb_notifier_list);
        ^

> Hmm. Interesting. I decided to just try it and see for the compiler I
> have, and changing the gnu89 to gnu99 I get new warnings
> (-Werror=shift-negative-value).

FWIW, I think we can go straight to gnu11 in this case even with gcc-5, no
need to take gnu99 as an intermediate step. I don't know if there is a
practical difference between the two though.

gcc-8 and higher also support --std=gnu18 and --std=gnu2x, which also
work for building the kernel but would break gcc-5/6/7 support

> Very annoying.  Especially since negative values are in many contexts
> actually *safer* than positive ones when used as a mask, because as
> long as the top bit is set in 'int', if the end result is then
> expanded to some wider type, the top bit stays set.
>
> Example:
>
>   unsigned long mask(unsigned long x)
>   { return x & (~0 << 5); }
>
>   unsigned long badmask(unsigned long x)
>   { return x & (~0u << 5); }
>
> One does it properly, the other is buggy.
>
> Now, with an explicit "unsigned long" like this, some clueless
> compiler person  might say "just use "~0ul", but that's completely
> wrong - because quite often the type is *not* this visible, and the
> signed version works *regardless* of type.
>
> So this Werror=shift-negative-value warning seems to be actively
> detrimental, and I'm not seeing the reason for it. Can somebody
> explain the thinking for that stupid warning?
>
> That said, we seem to only have two cases of it in the kernel, at
> least by a x86-64 allmodconfig build. So we could examine the types
> there, or we could just add '-Wno-shift-negative-value".

I looked at the gcc documentation for this flag, and it tells me that
it's default-enabled for std=c99 or higher. Turning it on for --std=gnu89
shows the same warning, so at least it doesn't sound like the actual
behavior changed, only the warning output. clang does not warn
for this code at all, regardless of the --std= flag.

        Arnd

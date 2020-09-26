Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F60B279C94
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 23:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIZVKY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 17:10:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40967 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgIZVKY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 17:10:24 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M7JnA-1kNNuk21PQ-007pcF; Sat, 26 Sep 2020 23:10:22 +0200
Received: by mail-qt1-f170.google.com with SMTP id o21so4785684qtp.2;
        Sat, 26 Sep 2020 14:10:22 -0700 (PDT)
X-Gm-Message-State: AOAM530vJob0lWmjC3JkXaHmXEoUpyapswP3ZNglEVELpK4tdz69O9NM
        y6V0XHeL9PzTfToCyf9rHBmjvcn8n+0/LJhxTgI=
X-Google-Smtp-Source: ABdhPJwDvlcajU+PF+fBlH/TL4sfEgn4CddfjWtp5EuFd2UBtqo7vjS2hC6ft8mwmLl/Kat4R/mEqJDY8LjXNk3pBI0=
X-Received: by 2002:aed:2ce5:: with SMTP id g92mr5933813qtd.204.1601154621203;
 Sat, 26 Sep 2020 14:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de> <20200918132439.1475479-3-arnd@arndb.de>
 <20200919053716.GJ30063@infradead.org>
In-Reply-To: <20200919053716.GJ30063@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Sep 2020 23:10:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a27R1dSWXRJiLwpA-q6KLC8KVy=BXnXqif072kL+JcdPg@mail.gmail.com>
Message-ID: <CAK8P3a27R1dSWXRJiLwpA-q6KLC8KVy=BXnXqif072kL+JcdPg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kexec: remove compat_sys_kexec_load syscall
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:c7FZC9Mxmbxn/z4+QDybPTKnAVTd6LCxoZ9lR50F8qBLlTSBCG+
 wsvxZhWBVd/vS2sSEIS3lzG0Ynr26pBmaW3PIKiRvQNSNhuI5MQzV4r14DOmXB5xciIku/B
 ijyK+BwfBLXgslRt4jDlyikmJWcsQjHZWPRTWHi1Y9cpzOUJFJA6QyAuVDjGSEXSfB17G3z
 VhM6lw6a8lTZS4jPK1GtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SQuYEY75IrY=:OQpUlVra8YrSy11+bVYrhl
 9PO8TT6Qb0ezP2ngJnF2UsJgxNGMNX9OGtCuYWk5au3fHLIoA1BZiIV/zXtP3SpJpuU2GWL9h
 uM0XO6h5dHWmK0OlUNE2rzLLhwyH++QhZzy1PAYG+SS3CrP2/CoRrTnX1rQdqDqizrffVlOwv
 wu8rOv2HgWTQTHUVfHEfK4k1C9cQvRuIPsTqkLNEbwV2ULi0pe9GYx3+nK/IKYEj/Wc+BXktb
 V9QJONX11nB0vs3I0ZvOmzOk/IYldA0WrRmM7dEPVKm3nrYA5LBjBL5GQ7D2hBC7q2BCtlz+k
 qzBDR+DRUTabpy968+215ixdBxHMzO3SoamV2Kur9QZA4NEZPz6+8JO2jHtP2kI7trxv2jsm8
 8UJzDQFzYi4ju79jIlqINucjDQ/oLjLJjOJt7mrkSzD9qieSuWQ7DaWR1tUJEhKkkp+nw7gfh
 27upJOQGgDgbV76BBj6RZ5h1hF6Tbn6o9DbvTPw6c/GzcsA9+J7jYD+BXXbD8ZNxzbOWiVfJX
 bqtGfaY2lqRktBcUyQmQvWNDWEns7HQP5K1Xue0tPFojip2pmYvF+umV84Zeqwmzj99c+PYg6
 oEIFZYkzRgF1Yo1I/fgTxW1iE9r04Eu2xeRuEjDEn+qNtGmYhsMFBcAGt1HI5IbJM2e16iYhj
 vz40CqJ47yTeIMulTILJSuZoJDwJOAsQycbpL1Nr/ke2S362MqNydcBZwaNHxHQeH0UBAzhHR
 5YGFdqfJzFa9xDJAxpfbEGSTaHm0D13rg9A9jCr5PlSbG5v3uYzWS1BQviAC6H4gOwD67x43y
 wF2b5dNxVbpSeJ3iMdxKwJV8gJz+I0iIyY4CrGWtKxgZ3E34zywcbOW3wSG84rnOLWEcuVc
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 7:37 AM Christoph Hellwig <hch@infradead.org> wrote:

> > +             struct compat_kexec_segment __user *cs = (void __user *)segments;
> > +             struct compat_kexec_segment segment;
> > +             int i;
> > +             for (i=0; i< nr_segments; i++) {
>
> Missing empty line after the variable declarations and really strange
> indentation.
>
> > +                     copy_from_user(&segment, &cs[i], sizeof(segment));
>
> Missing return value check.
>
> > +                     if (ret)
> > +                             break;
> > +
> > +                     image->segment[i] = (struct kexec_segment) {
> > +                             .buf   = compat_ptr(segment.buf),
> > +                             .bufsz = segment.bufsz,
> > +                             .mem   = segment.mem,
> > +                             .memsz = segment.memsz,
> > +                     };
> > +             }
>
> I'd split the whole compat handling into a helper, and I'd probably
> use the unsafe_get/put user to optimize it a little more.
>
> > +     } else {
> > +             ret = copy_from_user(image->segment, segments, segment_bytes);
> > +     }
> >       if (ret)
> >               ret = -EFAULT;
>
> Why not just
>
>                 if (copy_from_user(image->segment, segments, segment_bytes))
>                         ret = -EFAULT;
>
> ?

Addressed all of these now, thanks for the suggestions!

I had already fixed the missing error handling after the kbuild bot
pointed that out. The separate function does improve the error
handling.

I ended up not using unsafe_get/put since I find the copy_from_user
based loop more readable and it should lead to smaller object code in
most cases as well. kexec is not performance critical, so readability
seems more important here.

      Arnd

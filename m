Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF236D4B9
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhD1J0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 05:26:53 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhD1J0w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 05:26:52 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOAFl-1lvHoB26UD-00OUoI; Wed, 28 Apr 2021 11:26:02 +0200
Received: by mail-wr1-f49.google.com with SMTP id x7so62217476wrw.10;
        Wed, 28 Apr 2021 02:26:02 -0700 (PDT)
X-Gm-Message-State: AOAM533HU1/LLmBGGP6a1RJetUZzoHYWCP7m4jB6v+bH5VvlSPJI72cr
        +03fKEnflIUTiW/r0htcB6Deh28Fs5GtUbd3AEM=
X-Google-Smtp-Source: ABdhPJwqIEeAs49Ao+vk5t61GKQ1/IZbmkhWZLdVEWOkwYxoYwXqZWYW6kaGHsuUixb/ZxTFjbOagwXoBrU8Ona83SM=
X-Received: by 2002:adf:d223:: with SMTP id k3mr1211581wrh.99.1619601962128;
 Wed, 28 Apr 2021 02:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
 <20210428031807.GA27619@roeck-us.net> <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
In-Reply-To: <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Apr 2021 11:25:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com>
Message-ID: <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
To:     Guo Ren <guoren@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v2RyX7rStH4uWRbq/3VqWyCFTKJgyjFQT1ugf/3GvLy6vI6BHWZ
 3mOb+gAaVf9thL2/d7jCW5vVT7GOQeSIyQS2G7tiMwLcRfdOYsdlv21p1M5oQdz+o5GH731
 6tko/z1P2a6s27uDMSwD0XsaGmxGX0HeHtjUVt8DXHpFdjvMFQiwUccyX4KKw4WBiqELI0D
 uZHMcv5a9pitk+uI9t/uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+csEsx+EhA=:IsAdw5yRb1btdaH8Gdy5cM
 BK0ZMTUYWaXqt1PJeYeMzXjf30DvJphocaqVmwm9rrZwgp+cfE8FaklQ4Stq8qNk/YfWGiqpB
 l00i1BJ1glrq0gMpDHsg3kWQcgwzg0aW7HlRYL1hgjH3VPooFJ1uH2wK90ewF3adBNG/6KwsR
 8pMhDhEo+nrHBP1PF7aext+bWiIXnFhowYamf2niXAMM/rAJqGtS3sdRLMCkkkx9KQGcSM7kH
 hKi2gmE+gprBN6i2+37Utze32og5n7qtQ3USC0L7T2kc0pJLpcSz5U+qLOjiP7ikpNhPfYmU7
 lnfuO2PMCCZQrsfB4gGYtIwuaGDgTtLcxVPiiFuzlB3if+kXIx5Q4coyASmBU6stMKRMLOG1G
 53uAGGopQlWp7lBGfkq8OzbQHvEy8ScDTmRSWe8tdmMKU1SXTpGGnlOeoPiIQ9S1jYKqBjo30
 /72FaKdzwLlJ11vs0o2aB6dZy+a0jfvLoDPA8+KJpAxQ/eZfBu2ssASEOtM8Eq9WLB6r6KNzb
 bxNlluL6DHnVcbrOKIzf98=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 10:30 AM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Apr 28, 2021 at 11:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Apr 21, 2021 at 08:54:15AM +0000, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Using asm-generic/uaccess.h to prevent duplicated code:
> > >  - Add user_addr_max which mentioned in generic uaccess.h
> > >  - Remove custom definitions of KERNEL/USER_DS, get/set_fs,
> > >    uaccess_kerenl
> > >  - Using generic extable.h instead of custom definitions in
> > >    uaccess.h
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > Building csky:tinyconfig ... failed
> > --------------
> > Error log:
> > csky-linux-ld: fs/readdir.o: in function `__put_user_fn':
> > readdir.c:(.text+0x7c): undefined reference to `__put_user_bad'
> > csky-linux-ld: fs/readdir.o: in function `$d':
> > readdir.c:(.text+0x1bc): undefined reference to `__put_user_bad'
> > make[1]: *** [Makefile:1277: vmlinux] Error 1
> > make: *** [Makefile:222: __sub-make] Error 2
> It's a bug, I can't put __put_user_bad in __put_user_fn, and
> __put_user has done that:
>
> /*
>  * These are the main single-value transfer routines.  They automatically
>  * use the right size if we just have the right pointer type.
>  * This version just falls back to copy_{from,to}_user, which should
>  * provide a fast-path for small values.
>  */
> #define __put_user(x, ptr) \
> ({                                                              \
>         __typeof__(*(ptr)) __x = (x);                           \
>         int __pu_err = -EFAULT;                                 \
>         __chk_user_ptr(ptr);                                    \
>         switch (sizeof (*(ptr))) {                              \
>         case 1:                                                 \
>         case 2:                                                 \
>         case 4:                                                 \
>         case 8:                                                 \
>                 __pu_err = __put_user_fn(sizeof (*(ptr)),       \
>                                          ptr, &__x);            \
>                 break;                                          \
>         default:                                                \
>                 __put_user_bad();                               \
>                 break;                                          \
>          }                                                      \
>         __pu_err;                                               \
> })

Actually, please don't use the asm-generic __put_user version based
on copy_to_user, we probably have killed it off long ago.

We might want to come up with a new version of asm-generic/uaccess.h
that actually makes it easier to have a sane per-architecture
implementation of the low-level accessors without set_fs().

I've added Christoph to Cc here, he probably has some ideas
on where we should be heading.

One noteworthy aspect is that almost nothing users the low-level
__get_user()/__put_user() helpers any more outside of architecture
specific code, so we may not need to have separate versions
for much longer.

      Arnd

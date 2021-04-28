Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA25636D7E6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbhD1NEC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 09:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239201AbhD1NEB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 09:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D57F61424;
        Wed, 28 Apr 2021 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619614996;
        bh=5x10FZEStMbAe+tawqHHFF7NImoc5Sn6OTUDQWYTh5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z9rWYGz/EaHMoLppntEhTmoTjIh9V1d1+7bAFEzugp1V7s4SrwoehC3RGBvRdwjqP
         JIQwIKy9L38xy7H7PeQTIdWPeKgcIHXoDr3A5KWYORanfEEMBPe905UpGmbKcedjvR
         4yNPloSFEl0W4qm4UnCUesibqX4XxGUObN8z80xl5ihStoM6AZzDK727tStmuBbNGR
         fIm/kJXQS31MVhKj+V9+j6gzevp0F1vVK3WP7SC38YQvtENhdPi8ka7NkR0SdVrIZx
         FnFUB0em5Ity14/x6TKuKMUHRxmAMKdGPd2Pq/g8xU6MuEdNRyIfkICMAMtFnCZsr2
         I+Jik4FjO9OMA==
Received: by mail-lf1-f54.google.com with SMTP id 4so39199331lfp.11;
        Wed, 28 Apr 2021 06:03:16 -0700 (PDT)
X-Gm-Message-State: AOAM532viWeIVY08ndnrD/k8o9Jklw88ySWTwBKpYlhl443TgayTYXN3
        TdTntz27YPVltAhGPNVpvk7p3yRpDq0v4vhTkS8=
X-Google-Smtp-Source: ABdhPJysrGx377hmE982Hlo44Zh2s2rG8fsWbftSYs92LmF9UbShoKqHY8sjHEBsdwZgcuQ7F5UvDLFM1DgBdAz1JDw=
X-Received: by 2002:a05:6512:308c:: with SMTP id z12mr14481469lfd.24.1619614994734;
 Wed, 28 Apr 2021 06:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
 <20210428031807.GA27619@roeck-us.net> <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
 <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com>
In-Reply-To: <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 28 Apr 2021 21:03:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSPs20OLQfx=FUnbOfcHDMeKY_i7pjS2JkeNyPstBttFQ@mail.gmail.com>
Message-ID: <CAJF2gTSPs20OLQfx=FUnbOfcHDMeKY_i7pjS2JkeNyPstBttFQ@mail.gmail.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Apr 28, 2021 at 10:30 AM Guo Ren <guoren@kernel.org> wrote:
> > On Wed, Apr 28, 2021 at 11:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Wed, Apr 21, 2021 at 08:54:15AM +0000, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Using asm-generic/uaccess.h to prevent duplicated code:
> > > >  - Add user_addr_max which mentioned in generic uaccess.h
> > > >  - Remove custom definitions of KERNEL/USER_DS, get/set_fs,
> > > >    uaccess_kerenl
> > > >  - Using generic extable.h instead of custom definitions in
> > > >    uaccess.h
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Building csky:tinyconfig ... failed
> > > --------------
> > > Error log:
> > > csky-linux-ld: fs/readdir.o: in function `__put_user_fn':
> > > readdir.c:(.text+0x7c): undefined reference to `__put_user_bad'
> > > csky-linux-ld: fs/readdir.o: in function `$d':
> > > readdir.c:(.text+0x1bc): undefined reference to `__put_user_bad'
> > > make[1]: *** [Makefile:1277: vmlinux] Error 1
> > > make: *** [Makefile:222: __sub-make] Error 2
> > It's a bug, I can't put __put_user_bad in __put_user_fn, and
> > __put_user has done that:
> >
> > /*
> >  * These are the main single-value transfer routines.  They automatically
> >  * use the right size if we just have the right pointer type.
> >  * This version just falls back to copy_{from,to}_user, which should
> >  * provide a fast-path for small values.
> >  */
> > #define __put_user(x, ptr) \
> > ({                                                              \
> >         __typeof__(*(ptr)) __x = (x);                           \
> >         int __pu_err = -EFAULT;                                 \
> >         __chk_user_ptr(ptr);                                    \
> >         switch (sizeof (*(ptr))) {                              \
> >         case 1:                                                 \
> >         case 2:                                                 \
> >         case 4:                                                 \
> >         case 8:                                                 \
> >                 __pu_err = __put_user_fn(sizeof (*(ptr)),       \
> >                                          ptr, &__x);            \
> >                 break;                                          \
> >         default:                                                \
> >                 __put_user_bad();                               \
> >                 break;                                          \
> >          }                                                      \
> >         __pu_err;                                               \
> > })
>
> Actually, please don't use the asm-generic __put_user version based
> on copy_to_user, we probably have killed it off long ago.
>
> We might want to come up with a new version of asm-generic/uaccess.h
> that actually makes it easier to have a sane per-architecture
> implementation of the low-level accessors without set_fs().
>
> I've added Christoph to Cc here, he probably has some ideas
> on where we should be heading.
>
> One noteworthy aspect is that almost nothing users the low-level
> __get_user()/__put_user() helpers any more outside of architecture
> specific code, so we may not need to have separate versions
> for much longer.

Thx Arnd, here is my implementation:

#define __put_user_asm_64(x, ptr, err)                  \
do {                                                    \
        int tmp;                                        \
        int errcode;                                    \
                                                        \
        __asm__ __volatile__(                           \
        "     ldw     %3, (%1, 0)     \n"               \
        "1:   stw     %3, (%2, 0)     \n"               \
        "     ldw     %3, (%1, 4)     \n"               \
        "2:   stw     %3, (%2, 4)     \n"               \
        "     br      4f              \n"               \
        "3:   mov     %0, %4          \n"               \
        "     br      4f              \n"               \
        ".section __ex_table, \"a\"   \n"               \
        ".align   2                   \n"               \
        ".long    1b, 3b              \n"               \
        ".long    2b, 3b              \n"               \
        ".previous                    \n"               \
        "4:                           \n"               \
        : "=r"(err), "=r"(x), "=r"(ptr),                \
          "=r"(tmp), "=r"(errcode)                      \
        : "0"(err), "1"(x), "2"(ptr), "3"(0),           \
          "4"(-EFAULT)                                  \
        : "memory");                                    \
} while (0)

static inline int __put_user_fn(size_t size, void __user *ptr, void *x)
{
        int retval = 0;
        u32 tmp;
...
        case 8:
                __put_user_asm_64(x, (u64 *)ptr, retval);
                break;
        }

        return retval;
}
#define __put_user_fn __put_user_fn

#define __get_user_asm_64(x, ptr, err)                  \
do {                                                    \
        int tmp;                                        \
        int errcode;                                    \
                                                        \
        __asm__ __volatile__(                           \
        "1:   ldw     %3, (%2, 0)     \n"               \
        "     stw     %3, (%1, 0)     \n"               \
        "2:   ldw     %3, (%2, 4)     \n"               \
        "     stw     %3, (%1, 4)     \n"               \
        "     br      4f              \n"               \
        "3:   mov     %0, %4          \n"               \
        "     br      4f              \n"               \
        ".section __ex_table, \"a\"   \n"               \
        ".align   2                   \n"               \
        ".long    1b, 3b              \n"               \
        ".long    2b, 3b              \n"               \
        ".previous                    \n"               \
        "4:                           \n"               \
        : "=r"(err), "=r"(x), "=r"(ptr),                \
          "=r"(tmp), "=r"(errcode)                      \
        : "0"(err), "1"(x), "2"(ptr), "3"(0),           \
          "4"(-EFAULT)                                  \
        : "memory");                                    \
} while (0)

static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
{
        int retval;
        u32 tmp;

...
        case 8:
                __get_user_asm_64(x, ptr, retval);
                break;
        }

        return retval;
}
#define __get_user_fn __get_user_fn


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC417323587
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 03:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBXB66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 20:58:58 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:19425 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhBXB65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 20:58:57 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 11O1vhIv021809;
        Wed, 24 Feb 2021 10:57:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11O1vhIv021809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614131863;
        bh=oN7IRg3W9fn8dx2VR7makKAXxb9/wBxnTjP722qMAhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YWBPty69kNzqLAcSjQa1GPIfQfK32pxy29IBm4KOe8RC5Nb7SLeag76l7NMP+p8db
         I+VXHZZHA14rS63qq5ELg7GVb6nx8ZqatFwPTJMFeFudXkyIzzY5vitaXdemFO+1nF
         yfTVWsFvYJtQ4/3mXMKZurd/IMHrLpJpRPny95AWoGLjgR/VJW79AyMl14VqY3JXdJ
         8JFlLUoQsS62/zAuoT7ZPWHBltG/24DfpKBseG6N1LXsacpMWnGxGDkOBOa+ydfMgR
         HCljnx669LZ0Alwb50A1XHmd1P1qUJNk/YBb0JpNjXm0nqmm8UUHJ7AMs3a3xA31ya
         19vDostmEl5PQ==
X-Nifty-SrcIP: [209.85.210.181]
Received: by mail-pf1-f181.google.com with SMTP id w18so256378pfu.9;
        Tue, 23 Feb 2021 17:57:43 -0800 (PST)
X-Gm-Message-State: AOAM53133ncd2P+RhbNk+9HAaIBRh0IXfIr65mxwfbQxYNWyY9KA2Vb+
        NSHtULX3SezH88NicCdvllj+0s4hI9d127n1Ttc=
X-Google-Smtp-Source: ABdhPJxBLzZD/EqFNt8nWh1YRvGLep1V38fK34L+ZqltgGaCRgYaOq/PDzT//qBb8G/NRBK4h6ZlUdtsJ3fr3TbufHs=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr11813294pgi.47.1614131862821;
 Tue, 23 Feb 2021 17:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20210223100619.798698-1-masahiroy@kernel.org> <CAK8P3a1b5Tr8Gt_DcUq9JQj4G6O5ZHf44P2ZdYZRGQY8iPs43Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1b5Tr8Gt_DcUq9JQj4G6O5ZHf44P2ZdYZRGQY8iPs43Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 Feb 2021 10:57:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ3bYfo03i=LBv8S6dyTTAYw17gGht7TR2AWofNn0VP_A@mail.gmail.com>
Message-ID: <CAK7LNAQ3bYfo03i=LBv8S6dyTTAYw17gGht7TR2AWofNn0VP_A@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/ioctl.h: use BUILD_BUG_ON_ZERO() for type check
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 5:04 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Feb 23, 2021 at 11:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> >
> > -#ifdef __CHECKER__
> > -#define _IOC_TYPECHECK(t) (sizeof(t))
> > -#else
> >  /* provoke compile error for invalid uses of size argument */
> > -extern unsigned int __invalid_size_argument_for_IOC;
> > +#undef _IOC_TYPECHECK
> >  #define _IOC_TYPECHECK(t) \
> > -       ((sizeof(t) == sizeof(t[1]) && \
> > -         sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
> > -         sizeof(t) : __invalid_size_argument_for_IOC)
> > -#endif
> > +       BUILD_BUG_ON_ZERO(sizeof(t) != sizeof(t[1]) || \
> > +                         sizeof(t) >= (1 << _IOC_SIZEBITS))
>
> Using BUILD_BUG_ON_ZERO sounds like a good idea
>
> >  #endif /* _ASM_GENERIC_IOCTL_H */
> > diff --git a/include/uapi/asm-generic/ioctl.h b/include/uapi/asm-generic/ioctl.h
> > index a84f4db8a250..d50bd39ec3e3 100644
> > --- a/include/uapi/asm-generic/ioctl.h
> > +++ b/include/uapi/asm-generic/ioctl.h
> > @@ -72,9 +72,8 @@
> >          ((nr)   << _IOC_NRSHIFT) | \
> >          ((size) << _IOC_SIZESHIFT))
> >
> > -#ifndef __KERNEL__
> > -#define _IOC_TYPECHECK(t) (sizeof(t))
> > -#endif
> > +#define _IOC_TYPECHECK(t)      0
> > +#define _IOC_SIZE_WITH_TYPECHECK(t)    (sizeof(t) + _IOC_TYPECHECK(t))
>
> But I think replacing the #ifndef with an #undef in the other file makes it
> harder to understand when reading through it and trying to understand
> what it would do when this gets included from kernel and user space.
>
>         Arnd


My intention is to improve the UAPI/KAPI decoupling
to decrease the task of scripts/headers_install.sh

Ideally, we could export UAPI headers with
almost no modification.

It is true that scripts/unifdef can remove #ifndef __KERNEL__
blocks, but having the kernel-space code in UAPI headers
does not make sense. Otherwise, our initial motivation
"separate them by directory structure" would be lost.

So, I believe redefining _IOC_TYPECHECK is the right direction.
I can add comments if this is not clear.







--
Best Regards
Masahiro Yamada

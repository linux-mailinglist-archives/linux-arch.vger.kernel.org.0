Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB883231C9
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBWUF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 15:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233143AbhBWUFI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Feb 2021 15:05:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3E7864E7A;
        Tue, 23 Feb 2021 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614110667;
        bh=+q89ijMSvNhad5i+4jjP9hqtvpz1FvP2yvByIBe2DdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jQpCCSMtEUZVsQavQZlAwe0JjYbEVa3HagwuJ7x0tQEbkWrk1t8ku4cJxMYWmRCFi
         zEv1ep8RKD0kRxNtNIwP3d9n4DhhQp04JciAHCWWorl5NpHtsgiEXvhd/2omwaPiz9
         c8uvnBnk85Te0nrLuzz/YTf2ndyzUtrSmHzL+GIHDgbwJjKLM8iOelsm24RCXYDCS3
         e9dXqd1hDW+VoqK/xaeiqu0dOw6RuKlJU7Mi8urY7l1479TieEKTH2ccYfkFWhKJ1F
         Mh1IARuquX2ET6tpJGsKQ+bweHlGVwShMADtX7CayKFaaNiIs9mylzGO/FnLIQM+pI
         7ttZTvuOYTajw==
Received: by mail-oo1-f42.google.com with SMTP id p6so1093267oot.2;
        Tue, 23 Feb 2021 12:04:27 -0800 (PST)
X-Gm-Message-State: AOAM533h9TXMd7PXZVkfHu9M68KHeIfQo+swAHK4UiwGxRnE9dkYt2za
        JxDzLIUZKc0cRaOpU4fY9LorGMcT1cub+KYFVnE=
X-Google-Smtp-Source: ABdhPJyLv9KmjT20gbZA2OPNv7p6/gRIqYjkEw3fpRdyfqbW6VuV5ICNgpaiVoozgdmP/JCjH83/5LPx4uygLxHQyXA=
X-Received: by 2002:a4a:870c:: with SMTP id z12mr21019075ooh.15.1614110667037;
 Tue, 23 Feb 2021 12:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20210223100619.798698-1-masahiroy@kernel.org>
In-Reply-To: <20210223100619.798698-1-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 23 Feb 2021 21:04:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1b5Tr8Gt_DcUq9JQj4G6O5ZHf44P2ZdYZRGQY8iPs43Q@mail.gmail.com>
Message-ID: <CAK8P3a1b5Tr8Gt_DcUq9JQj4G6O5ZHf44P2ZdYZRGQY8iPs43Q@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/ioctl.h: use BUILD_BUG_ON_ZERO() for type check
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 23, 2021 at 11:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:

>
> -#ifdef __CHECKER__
> -#define _IOC_TYPECHECK(t) (sizeof(t))
> -#else
>  /* provoke compile error for invalid uses of size argument */
> -extern unsigned int __invalid_size_argument_for_IOC;
> +#undef _IOC_TYPECHECK
>  #define _IOC_TYPECHECK(t) \
> -       ((sizeof(t) == sizeof(t[1]) && \
> -         sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
> -         sizeof(t) : __invalid_size_argument_for_IOC)
> -#endif
> +       BUILD_BUG_ON_ZERO(sizeof(t) != sizeof(t[1]) || \
> +                         sizeof(t) >= (1 << _IOC_SIZEBITS))

Using BUILD_BUG_ON_ZERO sounds like a good idea

>  #endif /* _ASM_GENERIC_IOCTL_H */
> diff --git a/include/uapi/asm-generic/ioctl.h b/include/uapi/asm-generic/ioctl.h
> index a84f4db8a250..d50bd39ec3e3 100644
> --- a/include/uapi/asm-generic/ioctl.h
> +++ b/include/uapi/asm-generic/ioctl.h
> @@ -72,9 +72,8 @@
>          ((nr)   << _IOC_NRSHIFT) | \
>          ((size) << _IOC_SIZESHIFT))
>
> -#ifndef __KERNEL__
> -#define _IOC_TYPECHECK(t) (sizeof(t))
> -#endif
> +#define _IOC_TYPECHECK(t)      0
> +#define _IOC_SIZE_WITH_TYPECHECK(t)    (sizeof(t) + _IOC_TYPECHECK(t))

But I think replacing the #ifndef with an #undef in the other file makes it
harder to understand when reading through it and trying to understand
what it would do when this gets included from kernel and user space.

        Arnd

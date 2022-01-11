Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF7948B0E3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiAKPdu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 10:33:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245121AbiAKPdu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 10:33:50 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwQKp-1mF4TW2esX-00sQ6O; Tue, 11 Jan 2022 16:33:47 +0100
Received: by mail-wm1-f51.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so913789wmb.1;
        Tue, 11 Jan 2022 07:33:47 -0800 (PST)
X-Gm-Message-State: AOAM5302PD/H/LL+Ue9VnmV6tsOAQS6wR6H1gkAhTQflzf2S8jBCBdX/
        TjFu3Kr+PKZUKQiES9tUFYMuAH5ZQ7q/xgW8rZA=
X-Google-Smtp-Source: ABdhPJyFFinYnz2sZBS9mJMA0LPDw6WfY7Va14XdJpsCQCV44OO8uJYaRTfqzAgePL4Snx4fHkOYLxmTt0Ze2tTLQxc=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr2989838wmk.98.1641915227093;
 Tue, 11 Jan 2022 07:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20220111083515.502308-1-hch@lst.de> <20220111083515.502308-5-hch@lst.de>
In-Reply-To: <20220111083515.502308-5-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Jan 2022 16:33:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
Message-ID: <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tx6IPv0ygRrFwEX45u6YGmYZF4q2tKY6A4+hu9TKlEe4uh5NsZa
 QRpuFp+LN4kZi2zmoTXgxqnhWVQYJtpEcjdI7819zEKV7QSqF/1EleKbktsn+kKtfz0h2D0
 tLBfeFGy7Ju2xSluoAuZaQyn/drX0z0lM1dy3iNgwLxVTUjmFpAuZnGhsD8+jj/Lf4d8KEa
 yR/p9izO+KVN844fr1GEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k9mBvFF1K44=:R1UiRCxQjZewR+TumBOQJH
 KHbMrEAVPoyOjTjnVznPLlAeTuUXJCMXPe91vVSV1VPlK+9sFORPHJaE9Oqb5vWsDxiuX/umF
 2eOAOArrgNLa8V2xYqVDDXcexEn44g0mwV6PYp5JTV8WJ86CioJ+4Zf1xDGTIwSFFfIwPcX1l
 Xw60AAonM7sdk6FZ63DylMTYHZdmpD8t22aR0vK2nNI5Lkal88BdvGjWt8JjHI8pJP03ebaXA
 6u3RaakXFV7mu2hpWDNRWKH55q/3CRUFseB8WIpIEKP00a5CfJ4acF4ioav3DECnj3pDk41c9
 kdnovlyq4iCquGzzMa0jieTckQfP7biyZNOboS01neuWhtp6VDdqXbFkfyOzx73482ytgi/WG
 +xa34Xth2dhJMU+Q0p5TKCojpbBB8UteuAf2j1BDMBRytXvmv6dHmq5QzrpgckqY8Xl1orx7I
 K4i8BN3pjYlX9r42OXQrmW0YcrXqE3rlRyir5KN1+rVzLqNgnO5tLAc85E822sS5M+o3L2IxO
 frzlC3Dno3fP62wpk2clzxEWqw0lngxh7kmbhZ+aW6f+eVnFmGr6rkL+uYudCm2n2X21go2Zc
 /Ne6oWu73KoGx4CvZeeWD/0Qkn21H9pYDD9UwU8zm8fHrl6tcA+Iqp/RC5VUeSXlf/6JDKeLS
 IpgJdcZT71vKDGZGhA5srpwjumfNrgJIyzUPUXlqby2b2f9YcNpgT4jQWKlPn/mWBO/I=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 11, 2022 at 9:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The fcntl F_GETLK64/F_SETLK64/F_SETLKW64 are only implemented for the
> 32-bit syscall APIs, but we also need them for compat handling on 64-bit
> builds.  Redefining them is error prone (as shown by the example that
> parisc gets it wrong currently), so we should use the same defines for
> both case.  In theory we could try to hide them from userspace, but
> given that only MIPS actually gets that right, while the asm-generic
> version used by most architectures relies on a Kconfig symbol that can't
> be relied on to be set properly by userspace is a clear indicator to not
> bother.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 98f4ff165b776..43d7c44031be0 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -116,13 +116,11 @@
>  #define F_GETSIG       11      /* for sockets. */
>  #endif
>
> -#ifndef CONFIG_64BIT
>  #ifndef F_GETLK64
>  #define F_GETLK64      12      /*  using 'struct flock64' */
>  #define F_SETLK64      13
>  #define F_SETLKW64     14
>  #endif
> -#endif
>
>  #ifndef F_SETOWN_EX
>  #define F_SETOWN_EX    15

This is a very subtle change to the exported UAPI header contents:
On 64-bit architectures, the three unusable numbers are now always
shown, rather than depending on a user-controlled symbol.

This is probably what we want here for compatibility reasons, but I think
it should be explained in the changelog text, and I'd like Jeff or Bruce
to comment on it as well: the alternative here would be to make the
uapi definition depend on __BITS_PER_LONG==32, which is
technically the right thing to do but more a of a change.

       Arnd

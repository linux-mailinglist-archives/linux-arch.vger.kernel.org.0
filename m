Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205DA35DEB8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbhDMM12 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 08:27:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345548AbhDMM1Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 08:27:16 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrPRB-1lrNHN3EEp-00oUcR; Tue, 13 Apr 2021 14:26:54 +0200
Received: by mail-wr1-f45.google.com with SMTP id p6so9547056wrn.9;
        Tue, 13 Apr 2021 05:26:54 -0700 (PDT)
X-Gm-Message-State: AOAM531RTstzoW4h7X7DkOkmmdQSaYrP2Al/ftLmMhudAKAJCFLXLUcP
        HjMk5ntP6e9qG/JnrR6iaGNd02jZkbV1GYuKFnM=
X-Google-Smtp-Source: ABdhPJwKvFsyDfbyGYss2v7jOXjBzh0mMu283RtmlU14qXGq/cPdHuxJ1FGe8j5NYZ0lo1+YSfN65D73UMNsuNFan5U=
X-Received: by 2002:adf:c70b:: with SMTP id k11mr37437743wrg.165.1618316814410;
 Tue, 13 Apr 2021 05:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
In-Reply-To: <20210413115439.1011560-1-schnelle@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Apr 2021 14:26:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
Message-ID: <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dwhLFRyXtozyRyi1aq+zXpihKoy+XXL8N0nzsGkulGAzdwz913q
 7fTw87231jyO3u6CvzKm9eEf8D9WZFO6cLrezMC4w5U4uhS/tw+fzAlBhhMpxPJTZHjRlto
 49WKb3GeoAXWTThvGsmnA4O4qxcGlJSejpq135ayI/0VpyOlluzSzsrAcWpmKtMwE8Hg3yS
 EXjszpaTTTDdYSir7qfKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QOfJNXzDiqU=:EyA4ORiDC71ZdPS+LwbCIj
 6oCSQ/AlSWHA50t2dJeYhpqgohKBe39xLKPMr86cm06Hq0aoWiYDmDllz8mN2uCZTmnwXmqc+
 9v/98mj08bVQL8oz0k4CTaOWcanM/2seOEXVdvbpUKFXQGpno+7BOLgmPnm1zZld+xrLPa3cw
 y5CJn6eDe/W7dew/+VX3ZF7OD+xg4gE8Mph7EuPS4ojOjA2HCo8KejEInEWIrDswqhxXYi4hd
 Kv4759OF0w1bWpY3Z8eLEi9vd31s9VyjFwtUhPzTvUrY2i8922Ih0gpdvVJrOb8/8zDIxtce8
 /ndK4EpuCqnA9TAOoYtA9LLqO1Egx0NlEiRSyZFVj/6JD2rFI3o+lK2uenwgd5vQqWSQD9Z0/
 WG0ik7PnQ7HJQ9cCCNaQ0Mis7nlJn4WKiahilxVe6KGo7X6SACKT37d8twXOOL/h//TQzEpMf
 xi0w7wSnko4nTT4tDLJ4YMKKlo7TE6uXjomEN6ID2rQMwBYRQfX1EpR3m1qyC/ASPjUeR0svN
 L9t5sOvt1zhgThXGlFaUS0=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 13, 2021 at 1:54 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> When PCI_IOBASE is not defined, it is set to 0 such that it is ignored
> in calls to the readX/writeX primitives. While mathematically obvious
> this triggers clang's -Wnull-pointer-arithmetic warning.

Indeed, this is an annoying warning.

> An additional complication is that PCI_IOBASE is explicitly typed as
> "void __iomem *" which causes the type conversion that converts the
> "unsigned long" port/addr parameters to the appropriate pointer type.
> As non pointer types are used by drivers at the callsite since these are
> dealing with I/O port numbers, changing the parameter type would cause
> further warnings in drivers. Instead use "uintptr_t" for PCI_IOBASE
> 0 and explicitly cast to "void __iomem *" when calling readX/writeX.
>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  include/asm-generic/io.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index c6af40ce03be..8eb00bdef7ad 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -441,7 +441,7 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
>  #endif /* CONFIG_64BIT */
>
>  #ifndef PCI_IOBASE
> -#define PCI_IOBASE ((void __iomem *)0)
> +#define PCI_IOBASE ((uintptr_t)0)
>  #endif
>
>  #ifndef IO_SPACE_LIMIT

Your patch looks wrong in the way it changes the type of one of the definitions,
but not the type of any of the architecture specific ones. It's also
awkward since
'void __iomem *' is really the correct type, while 'uintptr_t' is not!

I think the real underlying problem is that '0' is a particularly bad
default value,
we should not have used this one in asm-generic, or maybe have left it as
mandatory to be defined by an architecture to a sane value. Note that
architectures that don't actually support I/O ports will cause a NULL
pointer dereference when loading a legacy driver, which is exactly what clang
is warning about here. Architectures that to support I/O ports in PCI typically
map them at a fixed location in the virtual address space and should put that
location here, rather than adding the pointer value to the port resources.

What we might do instead here would be move the definition into those
architectures that actually define the base to be at address zero, with a
comment explaining why this is a bad location, and then changing the
inb/outb style helpers to either an empty function or a WARN_ONCE().

On which architectures do you see the problem? How is the I/O port
actually mapped there?

      Arnd

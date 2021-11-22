Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE20F459642
	for <lists+linux-arch@lfdr.de>; Mon, 22 Nov 2021 21:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhKVUwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Nov 2021 15:52:04 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhKVUwE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Nov 2021 15:52:04 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHoAg-1mtAFF3MWs-00Eyqk; Mon, 22 Nov 2021 21:48:55 +0100
Received: by mail-wr1-f42.google.com with SMTP id r8so34958081wra.7;
        Mon, 22 Nov 2021 12:48:55 -0800 (PST)
X-Gm-Message-State: AOAM5322QLzpJOIMMfKJE6El0Bb9FPzt3XvwyDcXVBoVfHOmsDw2KCit
        swaKKKGGXi5gTq6BUD67g7cAhKgpMX9yCXcb5QA=
X-Google-Smtp-Source: ABdhPJwf+d8ctWPtfnfnh90ZtW1kb/NXAtGxWpODV7GJ5lqYNV7ntpKGV2T3UpIDDYaCPfzwOX3Viuecq2sgKQ0oXhg=
X-Received: by 2002:adf:df89:: with SMTP id z9mr80369wrl.336.1637614135426;
 Mon, 22 Nov 2021 12:48:55 -0800 (PST)
MIME-Version: 1.0
References: <YZvIlz7J6vOEY+Xu@yuki>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Nov 2021 21:48:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
Message-ID: <CAK8P3a0x5Bw7=0ng-s+KsUywqJYa0tk9cSWmZhx+cZRBOR87ZA@mail.gmail.com>
Subject: Re: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ibn68auOeHgaiHe1p9lElBs9W6KeLkwY0hvTg1HdiVzCoXKxL2F
 y7NX5WLQmEOVES0gL9rpTrytdQGUneW6z2CJEGBPpqkxAA4T0kn1BgEzXEBnsI4lbpwAaeR
 znmzLBh8jRHjR6qgrjUWAYb0i9AGd3FZd6RBXBBm/+WEl9uDWe4fsQI5jm57T7P7vh7MQ5M
 2Ig1Ip0xi3htxrzXqyofQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0D2V81tFDc=:Oe2YZnOA8AtmukOxMl3WJR
 /4uoAAmxuyoURTJTFdq6jGNjYdtdfAqkouRBMnG0vgkZdT92atfw2Cs0w1IQ1q+U+CQz6MHDq
 lDeUxoz0mh0T6JpdUOh+N+WJk8e3EgvqeUWKMg+9nYpUwJMru2tn3f6RTIZOsa/aqouqBAW81
 c1gS7dxU7P2YCSwOwXtfi60RNtTW1PzaabHpiujifDhIuwF6Y3LF9ROHWFm3KpfgOEZPpTZYc
 iHQqgdv4zZebQXhtY2HXg50TjfyrYBDr3VJRa+9ClIRER5cBnxVXh9gT0/DxKUV5ygrVNjcLR
 oWQQUUf/DTgaNiqpTOvKjgYK2ZWwpIOMXT5kDCwtd/S1Cl/olay2UVVUOyobkF+QIWf0nC/mn
 41ZgxFUX8bNWF5CA0KNtpWjhFDePwClYTfliJvtgFi6fnNSFnCUEh+iRRa7HwORIwrfzu7XUn
 EyVDXrI3B/b/ScwurpNf2Rlndzma8y6iXTQkmWAMmD/t4tPHd2pAyCt68so3HLHVovBvmWLCE
 0x7X8IBJPolpGTGr7kP6P0P03u5OTWtsms6fUGDxl+RSH8bwwbLJYYyyOBetN++iaztp+NxCZ
 tx8scXxEgWacIBzZh2zRUlAR02IpsdbSMrrClNPzTjKHQtlPpVzOm5bFNz4me9IjjfG9JCHfb
 e57iL4mIwAp1N4hmuDDuqagJ4PCMZrEe6mn+9rkd8Nb0GExhpxcm8gD+3P5EzDtO4rPI=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 22, 2021 at 5:43 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> +
> +#include <asm/bitsperlong.h>
> +
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
>   */
> -#include <asm-generic/int-ll64.h>
> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
> +# include <asm-generic/int-l64.h>
> +#else
> +# include <asm-generic/int-ll64.h>
> +#endif

I don't think this is correct on all 64-bit architectures, as far as I
remember the
definition can use either 'long' or 'long long' depending on the user space
toolchain.

Out of the ten supported 64-bit architectures, there are four that already
use asm-generic/int-l64.h conditionally, and six that don't, and I
think at least
some of those are intentional.

I think it would be safer to do this one architecture at a time to make
sure this doesn't regress on those that require the int-ll64.h version.

There should also be a check for __SANE_USERSPACE_TYPES__
to let userspace ask for the ll64 version everywhere.

          Arnd

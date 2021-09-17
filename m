Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7240F432
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhIQIfU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 04:35:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhIQIfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 04:35:19 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mdevh-1n0lBV1czh-00Zedh; Fri, 17 Sep 2021 10:33:56 +0200
Received: by mail-wm1-f54.google.com with SMTP id a194-20020a1c98cb000000b0030b41ac389fso1597493wme.2;
        Fri, 17 Sep 2021 01:33:56 -0700 (PDT)
X-Gm-Message-State: AOAM532CihyxaP8a0PIHctzMTmOaep3QcaMvImpEiwH4pMSMNMuR/HIB
        34qHfFp4ddV+aS5P2KMjx5nSb9TkQQb0z7W1mWI=
X-Google-Smtp-Source: ABdhPJwwvsfz7WCXfI0dPfy+nL3V7GYDJk/Pany8XO5sV2OuVkXrfqBSKXIQ1a7hkm2wdOtgjlhbghes9LMlc1yKhcI=
X-Received: by 2002:a05:600c:190e:: with SMTP id j14mr5992564wmq.35.1631867635890;
 Fri, 17 Sep 2021 01:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn> <20210917035736.3934017-18-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-18-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 10:33:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0HfWmBgp6ZagVALDoeoJsJaU9h9tLKHM0-5GZGtnT-hg@mail.gmail.com>
Message-ID: <CAK8P3a0HfWmBgp6ZagVALDoeoJsJaU9h9tLKHM0-5GZGtnT-hg@mail.gmail.com>
Subject: Re: [PATCH V3 17/22] LoongArch: Add some library functions
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6iKuCkXN+d4sxI8ShPBqXUeFg6GWZS8Apf82OofOzDFHCdmxrMx
 O8ZIkklYW6SosAhVgnjYqivuQvjVyhRYGCPRGRVp3xAQkS/oeBu0HH8HQ0CZNa9GcP824x8
 7ucyhFPHVx5iYCoMFjaANiJh6gF88zsHXJlYgBv9QmP2wj2Hm50ZwAFD/r9MpqyEIUshiwl
 d3tvMNBJ21ccTUYbalyNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jLBELSCQTkU=:0bh6A9bsHGrW7MkIC52hTm
 HEORhLOADIRsw5w6QDcZOmWKrbdSLFOD/fVaBvy4xwTvUyxgT+Pc8Hjm6dnTVPoPEcXeXKA6w
 1iqcs+8SMAvwwGpyhJPUGsPmlUXpOy6H0A3S6v7iUrSgOK+5fgDKUFRhlJkx0ldl7wn+t97Md
 RiPR+ma22a0swKNEBvSRBb3emzzxAMFW8cOkMCj/3vsuLfGJ3K5QMymK/rT4yoVSR12LTn+4F
 aV9q7GNlKrcP3DV/LtU+cYO8RFrl1/wMMRwLR1cEQ8MBBS7+Q3uf0q9qX/hZFNTujfiKWJLta
 VbvqPSjM9V2j+wVbJ09BEeMBR9JpLSM27c8rhzhQcm2vgBwib00+hxIdc4T/6dsyR188gnIWs
 ZKMezJ7X649x3IeFOlv5zoA6gQh636JlT688SWfzvmeNz/E5K2ZcilYpgQWMGT2IqI8i4e+1a
 wHoJg9GGn38GBsNNH9peuboOccp/45sJVoRjfPATQ6Vm2oqJGYuy498abmJnWvMR0UWanpZDA
 3czThDghVShFa6tEqbLtpHUE1n6ouqb9JusStPlE4/eJd6jcfYsqKTz8jWt7lYq2Qb41FFJnX
 ttHzil2Pkn/+Fi/G+Ze77PHqihrfigrs009rABDKbrOWA35CGL5n8KvhKR4LRpNYHChynurnr
 yZy1dbDLWLLPgXPBh/zNkDG+FRke/4NJDs+KHEdIbqrM5jlP1uifgE8jiNxnfMgNdy9xgn+92
 wrOXRf6z9x5/fQ5/uSh7ob5NNAj0WSDJ78Ag3J/d3MDqjqXXij02prmtatCRkoAdaMaXUPbh4
 ypoTgUr28cOSFjIe6kOYEcBZoj9VRatSxraLuKLPA803DYnzNKcVhYw5qVoMAXqNJAdCtgxXt
 tykI+vJ3EalgcanqtXJw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> diff --git a/arch/loongarch/lib/strncpy_user.S b/arch/loongarch/lib/strncpy_user.S
> new file mode 100644
> index 000000000000..b42d81045929
> --- /dev/null
> +++ b/arch/loongarch/lib/strncpy_user.S
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <linux/errno.h>
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +
> +#define _ASM_EXTABLE(from, to)                 \
> +       .section __ex_table, "a";               \
> +       PTR     from, to;                       \
> +       .previous
> +
> +/*
> + * long __strncpy_from_user(char *to, const char *from, long len)
> + *
> + * a0: to
> + * a1: from
> + * a2: len
> + */
> +SYM_FUNC_START(__strncpy_from_user)
> +       move    a3, zero
> +

I just removed most custom __strncpy_from_user/__strnlen_user
implementations from architectures, and I think you should remove
these as well. Your current version probably does not work any more
with v5.15-rc1, and it is neither efficient nor robust.

        Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE26515C06
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiD3Jsb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 05:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiD3Jsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 05:48:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE09C0F;
        Sat, 30 Apr 2022 02:45:06 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MGQaz-1ncodZ2olZ-00Gted; Sat, 30 Apr 2022 11:45:04 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f863469afbso83172827b3.0;
        Sat, 30 Apr 2022 02:45:04 -0700 (PDT)
X-Gm-Message-State: AOAM530iUYq858JtPGGblcVXX5Ie9TtkfOB2XE2FquVb9ztUqEK8vKRk
        x3aBUO+KSDSIGSw5kp5tET5KhBSv8Yuh1Nv8SSY=
X-Google-Smtp-Source: ABdhPJwTzbFqftdDIoA5Sd6JwlpWZVcz7hVs2Iq5zkukdOHjxCIPsQw6a8Mhed6aCAnHqEPyolzMNPuuIbPT6izMdq8=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr3349833ywk.209.1651311903209; Sat, 30
 Apr 2022 02:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn> <20220430090518.3127980-14-chenhuacai@loongson.cn>
In-Reply-To: <20220430090518.3127980-14-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 11:44:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
Message-ID: <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AtFv9yPH+2aDw7L4L92XH9pQylVY5lhFIf5+TZTUeVez43FhtYr
 iYyxQTcFH3qy/SK6vtJjv3sfpKp5bdLe9q8wti6Wh6JC4U/9ZgLE75t4HhJ6Fkh9ChthxUG
 S+loQSu4jnOfqoftvgGj30E9MnyprJbKla9SDnuiStHBskMrZcH31VC/WuWeKigsJTdGFKR
 Tlv3ANEQzHAIVhZTxQBHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MV4G75lL0c4=:dqs3PDrTiOnqrZzgYl3V5j
 /lL7WEjP26hrJ5lDi5jORR/ezFM38PBsIDzhojQ69dr+5+XoGip7NZ3CJAoyQLXy+ojTsQzLE
 MpUiPx2FYzyVisELC62ShFz5HW3c8mqbnDX2Cj3raSnekWHqEfwaFZ97gl3ceG5y4uifKvlZu
 rN824J4lbvMY0CO9YhLmY3VQQjXXJOCEFs8SS3uluOvmMShiL/RVXiuLzGqYibFVBTI4OAJT3
 GFYOPlb4+UKroHOto3jxXhFPYQLCwmMpiD04W1uYXflZLhzFoiPLjz2lOJuhGOrZn2Evzim+N
 m9o2PDwnZyhzQV27VZDKrLNsJlDhIBk6lODlyQW3CR9uLVolfFPuAPGNGoyRUyHQz4WkYtUcD
 D5qR+TvMH//smdcHrPGa4b2O5jKsIXoXAcUCyuORex3WdUqdy16zF5gHMm8LesOeL0z4niKaj
 C9nehMSnxZO+Z+G9fPiAke4mQGYN/cAKSOgu9YKlVbDlz14KRZq7MEua1U3Dpw8c6fwpDh3zg
 hgz0sYAc/nIQyWrFJzyQshey3bmdHv+IKdes57mtRG0o717gRGCM3DovSeBxWZhMr9VyPXmVt
 xN9xWpvTbuSeCGfhk3SAVd69G/OfIuT9qNfmTfS0xS6AQXDh/o4MoKCdHyyGy/dTmHXEfPgc0
 DGMBArcsvDeEVXFr/gu9W2yebtRCpwVzyYYEh/TO25Tlg2ffhvzuOqFxjILUg7X83n0ahR4Ei
 QZ8xMI9GK7Huc3Mho+Zqd136MVPAGgjn78KZVqL4wHWMVbDlFJ6McrBi/Q3YORsmNwb1CwBVx
 FmdNqU0NIQER7rOe/wnTWchHwECjO7YwXEmyfZB1zSfVZRFjok=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds system call support and related uaccess.h for LoongArch.
>
> Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> A: Until the latest glibc release (2.34), statx is only used for 32-bit
>    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
>    bit platforms still use newstat now.
>
> Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> A: The latest glibc release (2.34) has some basic support for clone3 but
>    it isn't complete. E.g., pthread_create() and spawni() have converted
>    to use clone3 but fork() will still use clone. Moreover, some seccomp
>    related applications can still not work perfectly with clone3. E.g.,
>    Chromium sandbox cannot work at all and there is no solution for it,
>    which is more terrible than the fork() story [1].
>
> [1] https://chromium-review.googlesource.com/c/chromium/src/+/2936184

I still think these have to be removed. There is no mainline glibc or musl
port yet, and neither of them should actually be required. Please remove
them here, and modify your libc patches accordingly when you send those
upstream.

       Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134793BC962
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGFKU2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:20:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKU0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:20:26 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5wTt-1m894L0gUl-007YnV for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:17:46 +0200
Received: by mail-wm1-f54.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so1857710wms.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:17:46 -0700 (PDT)
X-Gm-Message-State: AOAM530TsdQRFhY8ankRSRvTjIGpQ9AAcl/G2d7ThAFMESE9OvSbzBFL
        ip5vspZ8a8aXWJdMnyQvonYmpylsGICwzlS/GgA=
X-Google-Smtp-Source: ABdhPJxsyQfwWuR/L9LC3nTtTm1i9UQFhJn/9OrggrIvVreiZFV2V349IfkNDzWxnYV/4yAaR7cs2MSyLxVPE00/0uU=
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr3964283wmi.84.1625566665907;
 Tue, 06 Jul 2021 03:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-14-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-14-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:17:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2sCqqYC8pUPOyp-D48EOWbcryTO4pWFptftciWcWDk3Q@mail.gmail.com>
Message-ID: <CAK8P3a2sCqqYC8pUPOyp-D48EOWbcryTO4pWFptftciWcWDk3Q@mail.gmail.com>
Subject: Re: [PATCH 13/19] LoongArch: Add some library functions
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mb+G3MpPyYU2fkIv5F3+2ljPWinZry+qVNykYrW+Hlz8WwJJ5dR
 qJgWSORTTwjAO0Q7WtNQwW81dLc9ekhpTH1KXDhpdY+v8zQzZi3zHEZ116pPem1PLwnGsAs
 TA/s/3YKDi1kpIXehzotARk+CN3W0mwcCclAwPG5eOW2EAuLLfxayqcB/thROdvhH641KhP
 T35c88EW62o5FmYDFzKyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:egdFRKEBmMM=:yhQTmGU+C5TIhZ2hGenWqx
 J7dtYFcn7ZubILAn6EiMgNBvIkn9Es0HADx5Xqbm99RUWgVzfkQgRvOJkF/1trMeqppAx6WsW
 mrMENudhyXhx1xtGz+NsLjZVnI9rllIK2MMGghfLd/Ca6T7qL2dw+j32v4JcMunuIJM4ysNEE
 lKmn+LV+LPYA8sH7Uai5PyGBq9Fpbj5h2H6Z88eouZkRZKZ7qaGFB2MO6WUz1m5g16ic8UR+d
 gsOOR5i9fpvvbeeBMeJWltM+Sv6ZOB4QdLxBC2Aiqkik0ox+Jzy+KhV+FX6EIH4Kc2/Tv9j+G
 Od1uRi+GEf6OlHW0/K+efY+ycUrp7jKRWacQGOGXfSTqIGNTxmj1dNoiDxYTYbwU2vEMoQUrM
 sobS51n6rUFSEQoA2BTUCBI+Vw1HBBgPdNGaC/Ne9FK8EKrBlmAjxEARaITPjjbhWlwVEwffe
 Bseg0DjwDFSkfmdeOIfymwGjlTH0t+3Q/w8eHxwXfeN1fCwy6rm2tQAD8bUOVBOZ6Q7ydqG6t
 q1LF9w7zJvCSNwvNDSOld+H6k2cGx4WxzzWotuXwTvJpaguaOcGijqArg+s1L/HLgXdgiVL3y
 DgpATr+ZX36jlrt3u7mBbtK6AVuSrDA6om2YSIL2DKN0mDdq1ZjkFLATd7IRrGraRzVhSOgh8
 nhYHUabDI9cDFNPgi1Zl5940TeVOSgQYDXVm9xV+DRPUtIEvYDaLRpjy5JfwmwT/fOuId1UIM
 RI/Uz5MbK5Y+6mPreqW7xbGDhXbDdZ2d557PlahVMMVBqgw3smP67C40/DLZkR6oe0kJog/aV
 xGoxB41oGXkFVBPysUcHYrmonAkooSQsEzePTffQAN+xml2DK4VP/2SIQVxtigCFgOknI8hH/
 172NPJiQZBPNT7z5AAlu1XJr7nnk5GvQ8okyqi9j7EVcOUNHTLsUBvuwH54cfLYhJxWGo1fTq
 eqp811Q7tk3xx4eTQaCPJCfZssb6nD7PhBkhaHn1tOta8HwGVE4dW
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
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

I doubt this is better than the C version in lib/strncpy_from_user.c

> diff --git a/arch/loongarch/lib/strnlen_user.S b/arch/loongarch/lib/strnlen_user.S
> new file mode 100644
> index 000000000000..9288a5ad294e
> --- /dev/null
> +++ b/arch/loongarch/lib/strnlen_user.S
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */

Same here.

Have you done any measurement to show that the asm version actually helps
here? If not, just use the generic version.


       Arnd

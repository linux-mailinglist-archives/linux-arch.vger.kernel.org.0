Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340C755030E
	for <lists+linux-arch@lfdr.de>; Sat, 18 Jun 2022 07:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiFRFkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Jun 2022 01:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiFRFkq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Jun 2022 01:40:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D744924C
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 22:40:43 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McY0J-1nPo3h3U4r-00d0Ja for <linux-arch@vger.kernel.org>; Sat, 18 Jun
 2022 07:40:41 +0200
Received: by mail-yb1-f175.google.com with SMTP id 23so10453936ybe.8
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 22:40:40 -0700 (PDT)
X-Gm-Message-State: AJIora+3bHiLH6LrOe5XwxVjdwnsd5q3FAp4zJ0Cjx8oRIUlYN/hjeD5
        OXKFOgknr+Tdajb+P3qxHyzEyOT9ImmvInJz/oY=
X-Google-Smtp-Source: AGRyM1t6SuU2p8CM6C89gQYl5t8jbEr9F5Jj8jI2u7HI/USqBMY8kYrPxqa/RhT6tgDcAjE06ztkhWtj0hgZTr60hD8=
X-Received: by 2002:a25:26d0:0:b0:668:bc38:2de2 with SMTP id
 m199-20020a2526d0000000b00668bc382de2mr5908198ybm.480.1655530839702; Fri, 17
 Jun 2022 22:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
 <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com> <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Jun 2022 07:40:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wRqLAvywX2zbD0kdt19m2pKazqA2Y6_sNL1L=_4N3vQ@mail.gmail.com>
Message-ID: <CAK8P3a3wRqLAvywX2zbD0kdt19m2pKazqA2Y6_sNL1L=_4N3vQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0/1KaxKv4WT/sXCY1dkG1Q6Ld855ElQzbKnZD4FgsrUiTm8/4Nc
 pOLH48feCaKRjZECfeWDZHy16BVb7zLSbX3eiHnTK1iq4AgJLMuKwA9QbPTPMSETJMvAFTh
 8FecUdxxCQmbH+kJwHhJyGrYAZdK5JBbj82r3C2rlOefIWbHPbJM18Mcb5KjYulejwgQmBP
 1zoN7OmVuCtQCd1sywiQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a0xwtdLUn/o=:pB5NhIpWzSYAfNln5+/rr0
 ltbzP6cccw1yfVra3KQYDl6uGQ7cV8GeR2vJ+J1zgGIM4sZt0NbvU03B+dKPq6GleH0wRWkkk
 aGpgPcsB3SHsRsNK9ozb7P0/JuNXI74pIO6OFZyY/C7hA6p+D0D1lYQqZCDVkQyAEciSJs0IW
 AQ1wU9uM//rCZLso9kW6t4yOAeck9g/E+A9dHiZcwtX3tzS9T9VixbTiS83mXHCcDWlcTMPdE
 4+b9fGI6gfG3e/5LsREVxgLa44Ef2T+2sk/YigH8e8SHRSrSiC9Rn9ywgYX0WCu+ntFTx+rCJ
 XzI6XkaurVLDf2+fOensiG6AK+pwqIPEI0l1vhnETWPwzGeLAah/roXPVfJCVJeFHbVkewYmm
 5ZLqJuya6gPxUm7fmHjsUp7564ZUtccAdDbVD9IIoT3b/GLTJs3ERihejwV53BdrkCJbzNx/z
 zv9E9GNBl29+/9SlSF0nCKrTjpg8VZMIODL/lI2ouN9uOS+x306jsQ7h3kwLO/HWZY8tjUYsd
 ZUxUmUPa9RL1fKgm2ZwrnDj+Y2W7Oom8iJJkRZSAtu3oW0wg8utbASij7h5I9A9vTcxgpCCN7
 3kBKCLKoeqfHRI1S7mL4cQ1PJIeAQTGNks4+Np16+IePDywLjgbvK/PgWVEXmqhDPKjxIk35a
 XZZ7qJtM8XLxsqnqjBv3Ur39CpXBp92AM9bvB9eIEzpJp/w4QDV9GUFRS0u7VIVA6vtEqmYgk
 jZgQotUZqEX3JOsen6x4wvGB73XGUFMjzOCRlg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 18, 2022 at 1:19 AM Guo Ren <guoren@kernel.org> wrote:
>
> > static inline u32 arch_xchg32(u32 *ptr, u32 x) {...}
> > static inline u64 arch_xchg64(u64 *ptr, u64 x) {...}
> >
> > #ifdef CONFIG_64BIT
> > #define xchg(ptr, x) (sizeof(*ptr) == 8) ? \
> >             arch_xchg64((u64*)ptr, (uintptr_t)x)  \
> >             arch_xchg32((u32*)ptr, x)
> > #else
> > #define xchg(ptr, x) arch_xchg32((u32*)ptr, (uintptr_t)x)
> > #endif
>
> The above primitive implies only long & int type args are permitted, right?

The idea is to allow any scalar or pointer type, but not structures or
unions. If we need to deal with those as well, the macro could be extended
accordingly, but I would prefer to limit it as much as possible.

There is already cmpxchg64(), which is used for types that are fixed to
64 bit integers even on 32-bit architectures, but it is rarely used except
to implement the atomic64_t helpers.

80% of the uses of cmpxchg() and xchg() deal with word-sized
quantities like 'unsigned long', or 'void *', but the others are almost
all fixed 32-bit quantities. We could change those to use cmpxchg32()
directly and simplify the cmpxchg() function further to only deal
with word-sized arguments, but I would not do that in the first step.

        Arnd

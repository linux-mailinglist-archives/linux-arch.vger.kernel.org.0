Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94D54FC62
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 19:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383244AbiFQRpk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383233AbiFQRpj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 13:45:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC941631
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 10:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A85B8B82B66
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 17:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A0AC3411C
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 17:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655487935;
        bh=2bLTUGMcqE9XfyJ1xEYibIb9cepOI1zHjzNq7q7v8Pc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U9ziLVoVqnseiG0BkAoizHPLxKMq+DjyU3414W4X5eXM7NWlE471ab4uDT7zic0n9
         +xOxBcgbcDLbsdWlX+GaLLvY1eB3SkjBM3sW3oFXApv6AbmN1sgQaZSD+kL+gC3vb3
         PwVxuE9yqtZJxY3eKqKSLZsPNVtcWcJceSrnHLwvcwJWpjjGzlNg4B9M4xTbIoJRlr
         gk+Kn06CaoZzC1zkFmxz2gZ9OsuxFOGVBp6OgVEFZrl9szlr9Xn0Df7/wW/cMG6dxQ
         j3S7QvYEZ4FQsAWsl44xCc4ItILWq+d7//P6AO7NR7rBwMbRCIDBg6Oh6ExrTwAltP
         pGGDv99PCju/g==
Received: by mail-vk1-f169.google.com with SMTP id 140so2303561vky.10
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 10:45:35 -0700 (PDT)
X-Gm-Message-State: AJIora9q9GqOFVgk7+JMSKCb6MhAIjEgsa0uLqcOxB6e4nS3Je1X6kwb
        sN+97m6h3y+Mj49zS/OuY6stRdZN+7A0mY6e1KY=
X-Google-Smtp-Source: AGRyM1sQtvUSOGyN+sZo81R1iv/izwlld/9w86rG10v7JeX0QW/zLoy4/ygClMaGKuQlHps7rGmxPqiBOyOgeIkOOoQ=
X-Received: by 2002:a1f:2048:0:b0:35e:3d39:addf with SMTP id
 g69-20020a1f2048000000b0035e3d39addfmr5242726vkg.28.1655487934310; Fri, 17
 Jun 2022 10:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn> <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
In-Reply-To: <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 18 Jun 2022 01:45:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
Message-ID: <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 18, 2022 at 12:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jun 17, 2022 at 4:57 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > On NUMA system, the performance of qspinlock is better than generic
> > spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> > per node, 32 cores in total) machine.
> >
>
> The performance increase is nice, but this is only half the story we need here.
>
> I think the more important bit is how you can guarantee that the xchg16()
> implementation is correct and always allows forward progress.
>
> >@@ -123,6 +123,10 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
> >                                                int size)
> > {
> >        switch (size) {
> >+       case 1:
> >+       case 2:
> >+               return __xchg_small((volatile void *)ptr, val, size);
> >+
>
> Do you actually need the size 1 as well?
>
> Generally speaking, I would like to rework the xchg()/cmpxchg() logic
> to only cover the 32-bit and word-sized (possibly 64-bit) case, while
> having separate optional 8-bit and 16-bit functions. I had a patch for
Why not prevent 8-bit and 16-bit xchg()/cmpxchg() directly? eg: move
qspinlock xchg_tail to per arch_xchg_tail.
That means Linux doesn't provide a mixed-size atomic operation primitive.

What does your "separate optional 8-bit and 16-bit functions" mean here?

> this in the past, and can try to dig that out, this may be the time to
> finally do that.
>
> I see that the qspinlock() code actually calls a 'relaxed' version of xchg16(),
> but you only implement the one with the full barrier. Is it possible to
> directly provide a relaxed version that has something less than the
> __WEAK_LLSC_MB?
I am also curious that __WEAK_LLSC_MB is very magic. How does it
prevent preceded accesses from happening after sc for a strong
cmpxchg?

#define __cmpxchg_asm(ld, st, m, old, new)                              \
({                                                                      \
        __typeof(old) __ret;                                            \
                                                                        \
        __asm__ __volatile__(                                           \
        "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
        "       bne     %0, %z3, 2f                     \n"             \
        "       or      $t0, %z4, $zero                 \n"             \
        "       " st "  $t0, %1                         \n"             \
        "       beq     $zero, $t0, 1b                  \n"             \
        "2:                                             \n"             \
        __WEAK_LLSC_MB                                                  \

And its __smp_mb__xxx are just defined as a compiler barrier()?
#define __smp_mb__before_atomic()       barrier()
#define __smp_mb__after_atomic()        barrier()

>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

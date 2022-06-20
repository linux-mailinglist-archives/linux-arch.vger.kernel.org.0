Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E65514D0
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiFTJuR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbiFTJuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 05:50:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A03513E00
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 02:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D687CE1153
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 09:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DBC3411C
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655718609;
        bh=Fr0ix5EjKeIi2iLMs/BddEnbNzT+Ffa1oytTOGedzwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZtLWQaCGxyDeiyzSl067qaTebE7hO3c0CA4rZhDm7N/Jqe6N3Ife2IY5iOTBzNA5B
         T/K85aWEKSMFg2VirBOMTh416Y53TnyQNEesyYktxFIks1njwqhbfbo4JjzH4aeYXD
         69bRlEREj53fp80p76Q0IDl5dn6Gc3wu7E3DMY663Dntt22Hwzh7f7qH800TGcGYjO
         molJfiwtXmNxs1t40w9OYbxPHYqxdbhKyLcTVqM9FBi8DwxEs2qfxuQjKPWN7d60G0
         RIkdQF4VSAiSCaJCu8iubZE4eS6cOM6UEypZ+lURdj3LcMaChNLCm07vlnUDmxN9Xf
         xUT89mDoje6zg==
Received: by mail-lj1-f173.google.com with SMTP id a11so2493276ljb.5
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 02:50:09 -0700 (PDT)
X-Gm-Message-State: AJIora/oojyj+c3xGHhH/AbSfX1Ie4ODoeLmFjsaS9GHkRh2nwWNs8Zb
        ewzCG5rSa5iejGdYLYlLKIQEjUdZ9CXSRZD1p7c=
X-Google-Smtp-Source: AGRyM1u26ZTxYYwp6BW03Vv9IYXi2WFR5VcYdjY22Y8n/MuB9XsnBOuNlJp6bjGBF2txoIIO2DXn7JbMPW1np5BsB8g=
X-Received: by 2002:a05:651c:506:b0:257:c12:b941 with SMTP id
 o6-20020a05651c050600b002570c12b941mr11442398ljp.429.1655718607867; Mon, 20
 Jun 2022 02:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
 <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
 <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
 <CAK8P3a3wRqLAvywX2zbD0kdt19m2pKazqA2Y6_sNL1L=_4N3vQ@mail.gmail.com>
 <CAJF2gTQG0SBninPg7MsCFP=60p8u5KT+HaLNBzgjxM_fTMr+Dg@mail.gmail.com> <CAK8P3a1LgmZDssQoCciZ0YRy3UHWV3yK99UHTCdvahCFBG+u+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1LgmZDssQoCciZ0YRy3UHWV3yK99UHTCdvahCFBG+u+Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 20 Jun 2022 17:49:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6-K_mHSm9CWRB+v2a_Zqy-Z9x3XmQPuF7XT3yiTB=rbw@mail.gmail.com>
Message-ID: <CAAhV-H6-K_mHSm9CWRB+v2a_Zqy-Z9x3XmQPuF7XT3yiTB=rbw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
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

Hi,

On Mon, Jun 20, 2022 at 12:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jun 19, 2022 at 5:48 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Sat, Jun 18, 2022 at 1:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Jun 18, 2022 at 1:19 AM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > > static inline u32 arch_xchg32(u32 *ptr, u32 x) {...}
> > > > > static inline u64 arch_xchg64(u64 *ptr, u64 x) {...}
> > > > >
> > > > > #ifdef CONFIG_64BIT
> > > > > #define xchg(ptr, x) (sizeof(*ptr) == 8) ? \
> > > > >             arch_xchg64((u64*)ptr, (uintptr_t)x)  \
> > > > >             arch_xchg32((u32*)ptr, x)
> > > > > #else
> > > > > #define xchg(ptr, x) arch_xchg32((u32*)ptr, (uintptr_t)x)
> > > > > #endif
> > > >
> > > > The above primitive implies only long & int type args are permitted, right?
> > >
> > > The idea is to allow any scalar or pointer type, but not structures or
> > > unions. If we need to deal with those as well, the macro could be extended
> > > accordingly, but I would prefer to limit it as much as possible.
> > >
> > > There is already cmpxchg64(), which is used for types that are fixed to
> > > 64 bit integers even on 32-bit architectures, but it is rarely used except
> > > to implement the atomic64_t helpers.
> > A lot of 32bit arches couldn't provide cmpxchg64 (like arm's ldrexd/strexd).
>
> Most 32-bit architectures also lack SMP support, so they can fall back to
> the generic version from include/asm-generic/cmpxchg-local.h
>
> > Another question: Do you know why arm32 didn't implement
> > HAVE_CMPXCHG_DOUBLE with ldrexd/strexd?
>
> I think it's just fairly obscure, the slub code appears to be the only
> code that would use it.
>
> > >
> > > 80% of the uses of cmpxchg() and xchg() deal with word-sized
> > > quantities like 'unsigned long', or 'void *', but the others are almost
> > > all fixed 32-bit quantities. We could change those to use cmpxchg32()
> > > directly and simplify the cmpxchg() function further to only deal
> > > with word-sized arguments, but I would not do that in the first step.
> > Don't forget cmpxchg_double for this cleanup, when do you want to
> > restart the work?
>
> I have no specific plans at the moment. If you or someone else likes
> to look into it, I can dig out my old patch though.
>
> The cmpxchg_double() call seems to already fit in, since it is an
> inline function and does not expect arbitrary argument types.
Thank all of you. :)

As Rui and Xuerui said, ll and sc in LoongArch both have implicit full
barriers, so there is no "relaxed" version.

The __WEAK_LLSC_MB in __cmpxchg_small() have nothing to do with ll and
 sc themselves, we need a barrier at the branch target just because
Loongson-3A5000 has a hardware flaw (and will be fixed in
Loongson-3A6000).

qspinlock just needs xchg_small(), but cmpxchg_small() is also useful
for percpu operations. So I plan to split this patch to two: the first
add xchg_small() and cmpxchg_small(), the second enable qspinlock.

Huacai

>
>        Arnd

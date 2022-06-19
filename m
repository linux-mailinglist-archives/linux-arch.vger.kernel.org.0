Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3179550B60
	for <lists+linux-arch@lfdr.de>; Sun, 19 Jun 2022 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiFSPGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jun 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiFSPG1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jun 2022 11:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9D2DF11
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 08:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88D24611A7
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 15:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B7C341C4
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655651178;
        bh=01d4l6tQwv77wOeuBusDbIYSdWLSXvLBD+21bfJ+bSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Clh8jfflpZdHwJBG1EbNhxTOYEnmycZopbt99suJwqdlRc9Qqw6VUvu/NyYFz+byr
         ML3Q5vFmOzU8fTSeQT2/yJePP3axtn4C+G6fmItUjEqUSppbrUJoHGBuWOxrQH+8nI
         2dSDe+JNd5rNC1VoE1XF2KFsuLwkOqNSjqqaRCxX5xlIuGg6XWBudCBJ2B5aRUSoe3
         Uwa/U+sUqkmZ7hSeciWiuorksLmkMoWbwcYtyElbulzWl4OO9hjTlSibGMtS2nhFTc
         UVZ8VkjX1juohKAQwFtW/GyOVO834LRWN4lXbJdNpfbxhoTCET+TyVs1E+75trqwYj
         200R3JGmIN9TA==
Received: by mail-vs1-f44.google.com with SMTP id r4so8379958vsf.10
        for <linux-arch@vger.kernel.org>; Sun, 19 Jun 2022 08:06:17 -0700 (PDT)
X-Gm-Message-State: AJIora8xybPLzO+ajPZAhJnTckOijZMLRS72fJSRklWcEKEdrN+206t3
        GpJOB7wr1d32uMsqSq4330GqCWbPoOW+83pbQ2A=
X-Google-Smtp-Source: AGRyM1vfJlW16JK1GVzGwwUb0oqCQKVGkvgwrmPHPr6cxbiodihnwxW6UgeY3UVUetm5ZcctVZLienjFkZ12ziqIaSE=
X-Received: by 2002:a05:6102:3562:b0:34b:9e99:1bfa with SMTP id
 bh2-20020a056102356200b0034b9e991bfamr7413502vsb.51.1655651176897; Sun, 19
 Jun 2022 08:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
 <bcc38a55-30dc-98a8-cbfc-5a51924b9373@xen0n.name> <CAHirt9goPWs-_EpSpUOY4DWpK1nbaJxM2rSM3oLUqnCh5fVi4Q@mail.gmail.com>
In-Reply-To: <CAHirt9goPWs-_EpSpUOY4DWpK1nbaJxM2rSM3oLUqnCh5fVi4Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 19 Jun 2022 23:06:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQbb_RmF6Hn5E91waamecRZ+B7FRxo_GT23wkc0ydN4ug@mail.gmail.com>
Message-ID: <CAJF2gTQbb_RmF6Hn5E91waamecRZ+B7FRxo_GT23wkc0ydN4ug@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     hev <r@hev.cc>
Cc:     Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
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

On Sun, Jun 19, 2022 at 12:28 PM hev <r@hev.cc> wrote:
>
> Hello,
>
> On Sat, Jun 18, 2022 at 8:59 PM WANG Xuerui <kernel@xen0n.name> wrote:
> >
> > On 6/18/22 01:45, Guo Ren wrote:
> > >
> > >> I see that the qspinlock() code actually calls a 'relaxed' version of xchg16(),
> > >> but you only implement the one with the full barrier. Is it possible to
> > >> directly provide a relaxed version that has something less than the
> > >> __WEAK_LLSC_MB?
> > > I am also curious that __WEAK_LLSC_MB is very magic. How does it
> > > prevent preceded accesses from happening after sc for a strong
> > > cmpxchg?
> > >
> > > #define __cmpxchg_asm(ld, st, m, old, new)                              \
> > > ({                                                                      \
> > >          __typeof(old) __ret;                                            \
> > >                                                                          \
> > >          __asm__ __volatile__(                                           \
> > >          "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
> > >          "       bne     %0, %z3, 2f                     \n"             \
> > >          "       or      $t0, %z4, $zero                 \n"             \
> > >          "       " st "  $t0, %1                         \n"             \
> > >          "       beq     $zero, $t0, 1b                  \n"             \
> > >          "2:                                             \n"             \
> > >          __WEAK_LLSC_MB                                                  \
> > >
> > > And its __smp_mb__xxx are just defined as a compiler barrier()?
> > > #define __smp_mb__before_atomic()       barrier()
> > > #define __smp_mb__after_atomic()        barrier()
> > I know this one. There is only one type of barrier defined in the v1.00
> > of LoongArch, that is the full barrier, but this is going to change.
> > Huacai hinted in the bringup patchset that 3A6000 and later models would
> > have finer-grained barriers. So these indeed could be relaxed in the
> > future, just that Huacai has to wait for their embargo to expire.
> >
>
> IIRC, The Loongson LL/SC behaves differently than others:
>
> Loongson:
> LL: Full barrier + Load exclusive
> SC: Store conditional + Full barrier
How about your "am"#asm_op"_db."?

Full barrier + AMO + Full barrier ?

>
> Others:
> LL: Load exclusive + Acquire barrier
> SC: Release barrier + Store conditional
>
> So we just need to prevent compiler reorder before/after atomic.
> And this is why we need __WEAK_LLSC_MB to prevent runtime reorder for
> loads after LL.
>
> hev



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

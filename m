Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0827C552940
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiFUCL4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFUCLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 22:11:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F911EC49
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 19:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A552B81689
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 02:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2691DC341CD
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2022 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655777511;
        bh=fmMzMCOHZaQipP7nBLylFxbzlckmNGZNgVhG9f2PmRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kY5j8aYB7Jxmu//TTAn9fGcWmEWnwZgKTaZbTtCDr3XDOKuyjyJ4gxmFKktVBvirH
         6BwS/ZBCsgOm1tF42Gc/svTPDwjvNXEwSsKBddE6aAi7xJc/r/7c+IfoEU0eAS/9S/
         Aq+fZyTZQcQ6ATWb98EwQMV0VLBo5HEt3BH3JI4pipiVf8cXvxz7cDp607N2aFS2gQ
         SHNUucJ6NaNU2Ndk0oYzqmMpzXTD8bS7Ne+F4fqCNBqjySdCTIPQJBZv7vlDOE+79u
         zPAP8iqknGQ51CfSuwlTX/bWP3HYig9XV8OQno4dc+OjwFfy6/LhmxySgOnT3P2t2W
         17aMonUBHCE8Q==
Received: by mail-vk1-f178.google.com with SMTP id 15so2327517vko.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2022 19:11:51 -0700 (PDT)
X-Gm-Message-State: AJIora+acYURmuDPd9RlN60Zsc0agG39rzpCd8VMgvHatFMWtG/2ONgb
        Sp+V8NR4LMU41H7pWogt3hrnD64jwJ/i1GgXNZg=
X-Google-Smtp-Source: AGRyM1tg3yeXekdDVU47pnu9kVQqDaHTDdlJQEvdxpMP3qh3epv9SOewfXhKyuHXCLsKmafp1hjpNieh2r0beKxdb4k=
X-Received: by 2002:ac5:c5b7:0:b0:365:1e47:aa26 with SMTP id
 f23-20020ac5c5b7000000b003651e47aa26mr10044128vkl.8.1655777509943; Mon, 20
 Jun 2022 19:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145705.581985-1-chenhuacai@loongson.cn>
 <CAK8P3a2nD_Zxv5X_LB7AbO=kxHQyk3vz09fQZ-TTX4PL0b3g1g@mail.gmail.com>
 <CAJF2gTT_etFg7-N4f=A4LMOYvd3+H505e0xt8NyxK4uPtkuEXg@mail.gmail.com>
 <CAK8P3a078r6zkZYYeV7Qg3AEOvFxgG+eRN9bFE_3DNwHq=_1ZA@mail.gmail.com>
 <CAJF2gTQL+ysc+juQfNVxz1QtXgrLAYe=CyA9L_c3fzd4F8aFxQ@mail.gmail.com>
 <CAK8P3a3wRqLAvywX2zbD0kdt19m2pKazqA2Y6_sNL1L=_4N3vQ@mail.gmail.com>
 <CAJF2gTQG0SBninPg7MsCFP=60p8u5KT+HaLNBzgjxM_fTMr+Dg@mail.gmail.com>
 <CAK8P3a1LgmZDssQoCciZ0YRy3UHWV3yK99UHTCdvahCFBG+u+Q@mail.gmail.com>
 <CAAhV-H6-K_mHSm9CWRB+v2a_Zqy-Z9x3XmQPuF7XT3yiTB=rbw@mail.gmail.com>
 <CAJF2gTS_i5f6At6F9G9WKubnz4mrazzDTJCDC2PA+0mXWZ3pWA@mail.gmail.com> <CAAhV-H51Hd7ZAY55-F+nMc1Wb=q=4G07CT-C+=3=BX1_3hw0Ng@mail.gmail.com>
In-Reply-To: <CAAhV-H51Hd7ZAY55-F+nMc1Wb=q=4G07CT-C+=3=BX1_3hw0Ng@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Jun 2022 10:11:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRjZ=YaAMVgZGCAFWDRGUZ-XT9MAw52LM_VJBsxAYsCEA@mail.gmail.com>
Message-ID: <CAJF2gTRjZ=YaAMVgZGCAFWDRGUZ-XT9MAw52LM_VJBsxAYsCEA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add qspinlock support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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

On Tue, Jun 21, 2022 at 8:59 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi,
>
> On Tue, Jun 21, 2022 at 12:01 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Huacai & Arnd,
> >
> > Please have a look at riscv qspinlock V5:
> > https://lore.kernel.org/linux-riscv/a498a2ff-2503-b25c-53c9-55f5f2480bf6@microchip.com/T/#t
> From my point of view, we can simply drop RISCV_USE_QUEUED_SPINLOCKS,
> unless ticket spinlock is better than qspinlock in the !NUMA case.
RISC-V ISA has a flexible LR/SC forward guarantee definition, which
means some processors still must stay in ticket-lock.

Loongarch should give out the info about how strong your LR/SC forward
guarantee is. If some versions of the processor do strong guarantee,
but some don't. Maybe you should consider the RISC-V style.

>
> Huacai
>
> >
> >
> >
> > On Mon, Jun 20, 2022 at 5:50 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Jun 20, 2022 at 12:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Sun, Jun 19, 2022 at 5:48 PM Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > On Sat, Jun 18, 2022 at 1:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > >
> > > > > > On Sat, Jun 18, 2022 at 1:19 AM Guo Ren <guoren@kernel.org> wrote:
> > > > > > >
> > > > > > > > static inline u32 arch_xchg32(u32 *ptr, u32 x) {...}
> > > > > > > > static inline u64 arch_xchg64(u64 *ptr, u64 x) {...}
> > > > > > > >
> > > > > > > > #ifdef CONFIG_64BIT
> > > > > > > > #define xchg(ptr, x) (sizeof(*ptr) == 8) ? \
> > > > > > > >             arch_xchg64((u64*)ptr, (uintptr_t)x)  \
> > > > > > > >             arch_xchg32((u32*)ptr, x)
> > > > > > > > #else
> > > > > > > > #define xchg(ptr, x) arch_xchg32((u32*)ptr, (uintptr_t)x)
> > > > > > > > #endif
> > > > > > >
> > > > > > > The above primitive implies only long & int type args are permitted, right?
> > > > > >
> > > > > > The idea is to allow any scalar or pointer type, but not structures or
> > > > > > unions. If we need to deal with those as well, the macro could be extended
> > > > > > accordingly, but I would prefer to limit it as much as possible.
> > > > > >
> > > > > > There is already cmpxchg64(), which is used for types that are fixed to
> > > > > > 64 bit integers even on 32-bit architectures, but it is rarely used except
> > > > > > to implement the atomic64_t helpers.
> > > > > A lot of 32bit arches couldn't provide cmpxchg64 (like arm's ldrexd/strexd).
> > > >
> > > > Most 32-bit architectures also lack SMP support, so they can fall back to
> > > > the generic version from include/asm-generic/cmpxchg-local.h
> > > >
> > > > > Another question: Do you know why arm32 didn't implement
> > > > > HAVE_CMPXCHG_DOUBLE with ldrexd/strexd?
> > > >
> > > > I think it's just fairly obscure, the slub code appears to be the only
> > > > code that would use it.
> > > >
> > > > > >
> > > > > > 80% of the uses of cmpxchg() and xchg() deal with word-sized
> > > > > > quantities like 'unsigned long', or 'void *', but the others are almost
> > > > > > all fixed 32-bit quantities. We could change those to use cmpxchg32()
> > > > > > directly and simplify the cmpxchg() function further to only deal
> > > > > > with word-sized arguments, but I would not do that in the first step.
> > > > > Don't forget cmpxchg_double for this cleanup, when do you want to
> > > > > restart the work?
> > > >
> > > > I have no specific plans at the moment. If you or someone else likes
> > > > to look into it, I can dig out my old patch though.
> > > >
> > > > The cmpxchg_double() call seems to already fit in, since it is an
> > > > inline function and does not expect arbitrary argument types.
> > > Thank all of you. :)
> > >
> > > As Rui and Xuerui said, ll and sc in LoongArch both have implicit full
> > > barriers, so there is no "relaxed" version.
> > >
> > > The __WEAK_LLSC_MB in __cmpxchg_small() have nothing to do with ll and
> > >  sc themselves, we need a barrier at the branch target just because
> > > Loongson-3A5000 has a hardware flaw (and will be fixed in
> > > Loongson-3A6000).
> > >
> > > qspinlock just needs xchg_small(), but cmpxchg_small() is also useful
> > > for percpu operations. So I plan to split this patch to two: the first
> > > add xchg_small() and cmpxchg_small(), the second enable qspinlock.
> > >
> > > Huacai
> > >
> > > >
> > > >        Arnd
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

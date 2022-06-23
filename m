Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D79557C70
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiFWNFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 09:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiFWNFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 09:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB07649
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 06:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 815A461D18
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 13:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98EFC341C6
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655989519;
        bh=DjuEmZVwuvchcw2Ixkj0oGseKE4N947dn/w04MZ5f+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sF3A06AzrbI21YYocb7aOBBs99vwo+DCXu5wt+KfK68xP0lxelPy8phhW358jU+Ki
         QIcsShll1vxq4OVnEcidx7lbPal+LyUsNBJnBaTfxbzJfV4GX9zrpdjMUpHfuZX9i/
         YVnCd2LBx26YUtJXs9J/dF7dyZI8Dr5bK4QkY3ymRimtDE4hJsriizSg74BSefYjfV
         KMk6IjSCMXaBl6obUfFrdw5bZ6qFjfcVF/IGyRSM1iYULjwTYrGb4Wah2R84ZfwlKN
         T7zHnj4oXwyrKrfy8k+YNij5ODh5gQQ9mpjYl5qapbk8hoH3R+laHyX0XkgEwSMDdJ
         z43Xr/jOhUDIA==
Received: by mail-lf1-f47.google.com with SMTP id g4so20853318lfv.9
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 06:05:19 -0700 (PDT)
X-Gm-Message-State: AJIora/nK1Thf1BPEUIJF6vM7d6c771qOjmy+ZEBH0X3f4srv6S0ICsj
        hH01r1pnY2M9VsMVi0nRjxluioR3/ajAGaEAZ6Q=
X-Google-Smtp-Source: AGRyM1s9EaN9czol/9QSx9LBAEd1vmwZHvTiwirdpKh+lmDDv2foOokIyEUS2k9XCxvOWvTWqGJ7ROu2MxGo/tUSnek=
X-Received: by 2002:a05:6512:3096:b0:47f:6ef4:89da with SMTP id
 z22-20020a056512309600b0047f6ef489damr5527969lfd.518.1655989517873; Thu, 23
 Jun 2022 06:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com> <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
In-Reply-To: <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Jun 2022 21:05:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com>
Message-ID: <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rui Wang <wangrui@loongson.cn>
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

Hi, Arnd,

On Thu, Jun 23, 2022 at 4:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 23, 2022 at 9:56 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Thu, Jun 23, 2022 at 1:45 PM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > On NUMA system, the performance of qspinlock is better than generic
> > > > spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> > > > per node, 32 cores in total) machine.
>
> You are still missing an explanation here about why this is safe to
> do. Is there are
> architectural guarantee for forward progress, or do you rely on
> specific microarchitectural
> behavior?
In my understanding, "guarantee for forward progress" means to avoid
many ll/sc happening at the same time and no one succeeds.
LoongArch uses "exclusive access (with timeout) of ll" to avoid
simultaneous ll (it also blocks other memory load/store on the same
address), and uses "random delay of sc" to avoid simultaneous sc
(introduced in CPUCFG3, bit 3 and bit 4 [1]). This mechanism can
guarantee forward progress in practice.

[1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg



Huacai

>
> > > Could you base the patch on [1]?
> > >
> > > [1] https://lore.kernel.org/linux-riscv/20220621144920.2945595-2-guoren@kernel.org/raw
> > I found that whether we use qspinlock or tspinlock, we always use
> > qrwlock, so maybe it is better like this?
> >
> > #ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > #include <asm/qspinlock.h>
> > #else
> > #include <asm-generic/tspinlock.h>
> > #endif
> >
> > #include <asm/qrwlock.h>
>
> Yes, that seems better, but I would go one step further and include
> asm-generic/qspinlock.h
> in place of asm/qspinlock.h here: The two architectures that have a
> custom asm/qspinlock.h
> also have a custom asm/spinlock.h, so they have no need to include
> asm-generic/spinlock.h
> either.
>
>         Arnd

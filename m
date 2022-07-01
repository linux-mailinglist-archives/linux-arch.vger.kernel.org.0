Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340C1563363
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiGAMSn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiGAMSm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 08:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8E813D3C;
        Fri,  1 Jul 2022 05:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33FF3617A3;
        Fri,  1 Jul 2022 12:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC63C341D1;
        Fri,  1 Jul 2022 12:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656677918;
        bh=ATb6SEoK7/3cueOFPuy2+EzjO8Bs6Foi31SPRrze/YM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5tbuOgbNhdn9p+zwJef3C9fgG7RTQq6XcrxahqchOEWpk/KUMZMs2PL4+s9sFR2m
         tUZ7/Bbm6+AYwQLs8z/JIPhdInqq5sA/k7u6OBJYVywElrkFVbfvnf5OkOyx5PtFJc
         s8sYyPPllre7rdwtbdjlIMFWgl3qtDwhUR5RD062+rPnV3R0Ak5ON/sL0lok3M5w3X
         AQMoF+E3+TV1d3viqC2yvRfZuwplvnnrbVVsPtTJqhvfoOOfy/akli9vaSDCr9srnW
         i6qadRYs49FZbZA65tBA5jCzfmEEa1QK38szJdo3Ezlf57p/9zjsu2eLHGzC+Oj5P8
         /Yj8E2p6Y8InQ==
Received: by mail-vs1-f52.google.com with SMTP id o13so2174908vsn.4;
        Fri, 01 Jul 2022 05:18:38 -0700 (PDT)
X-Gm-Message-State: AJIora8r+vBGGnMnmOlBvC7oWkngPTPzY3vum7caJFLllpvkPrkE88om
        N5WRJybIhs31TyrxRmBu5bSWSeXjf+Dxs6oqJ+k=
X-Google-Smtp-Source: AGRyM1vG4rVGasPwig/nllJ8Pjq9D/N0FTIQCYol6SI71DxP2L4RuzOCvANFgN6OEOc3sjeKIZovbMRLlZmflK2mHek=
X-Received: by 2002:a05:6102:366f:b0:356:352f:9de2 with SMTP id
 bg15-20020a056102366f00b00356352f9de2mr11203462vsb.2.1656677917449; Fri, 01
 Jul 2022 05:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com> <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
 <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com> <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
 <CAJF2gTTtKiMZJLWBEcRz-4CmNojH0cOgpUYGupLyCXXFjQD_FQ@mail.gmail.com> <CAK8P3a3GiMgEJdBg5QQHHD0bDnpR0XwPkAw7=zT7ETzf6-sCmg@mail.gmail.com>
In-Reply-To: <CAK8P3a3GiMgEJdBg5QQHHD0bDnpR0XwPkAw7=zT7ETzf6-sCmg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 1 Jul 2022 20:18:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQLqN2QnHYyPMx91vraR3cOhf2DOnnC3=5C18ACU32Qaw@mail.gmail.com>
Message-ID: <CAJF2gTQLqN2QnHYyPMx91vraR3cOhf2DOnnC3=5C18ACU32Qaw@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Waiman Long <longman@redhat.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 29, 2022 at 4:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 29, 2022 at 10:24 AM Guo Ren <guoren@kernel.org> wrote:
> > On Wed, Jun 29, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Jun 29, 2022 at 3:34 AM Waiman Long <longman@redhat.com> wrote:
> > >
> > > From looking at the header file dependencies on arm64, I know that
> > > putting jump labels into core infrastructure like the arch_spin_lock()
> > > makes a big mess of indirect includes and measurably slows down
> > > the kernel build.
> > arm64 needn't combo spinlock, it could use pure qspinlock with keeping
> > current header files included.
>
> arm64 has a different problem: there are two separate sets of atomic
> instructions, and the decision between those is similarly done using
> jump labels. I definitely like the ability to choose between qspinlock
> and ticket spinlock on arm64 as well. This can be done as a
> compile-time choice, but both of them still depend on jump labels.
1. xchg use ALTERNATIVE, but cmpxchg to jump labels.
2. arm64 is still using qspinlock when ll/sc, and I think they give
strong enough fwd guarantee with "prfm pstl1strm".
But another question is if ll/sc could give enough strong fwd
guarantee, why arm64 introduce LSE, for code size reduction? Why
instructions fusion technology is not enough?


>
>         Arnd



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

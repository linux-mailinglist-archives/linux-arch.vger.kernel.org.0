Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646C855FA5C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiF2IYU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiF2IYT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 04:24:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9533BBFB;
        Wed, 29 Jun 2022 01:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6E5B8213E;
        Wed, 29 Jun 2022 08:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9C7C341CD;
        Wed, 29 Jun 2022 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656491056;
        bh=Pd/spSg+y88wI0co/eA7QGJBokO/5IsoxHQjfzfNeNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SO6r41zu5WHMzyprs15T8STTIn1h61qoaP6FWzWM7MI+nHRgMR72CY6Rnfo7T6+H9
         dpG47nKcdqumO2iOKZPUwv7rNugQ9GA24SMp3ZmL1VG+UrwRIMM2oU4IxYjhIBbZFZ
         a2uYU8/jIopWKJN/+93ubw97TxMgGJM9dX3HJqA9YMcZXxgLba7DTuHt7YfqrxUAi5
         sWnCjZG7C/yGWXyquaHs8TjsWm8DyhkmCKBw+kHRj8afWwZFF35di58yC/edyFhV0S
         nAUHwMe/l0BBVHnHAmq4ecoGz4snrqX3nckBuyFQXgXe+rcdMVZQy7Z6y0WtVixyO0
         /RzkvCZEr/HXg==
Received: by mail-ua1-f52.google.com with SMTP id p19so5466667uam.4;
        Wed, 29 Jun 2022 01:24:15 -0700 (PDT)
X-Gm-Message-State: AJIora/8v+v0JZe+rBbtJiGHuiQs0X2FriX1Tog6XxylP4IYrMEoKHMw
        nGXntFIDfsBBEdO69POpwLJ36PGZ437GhFmId6s=
X-Google-Smtp-Source: AGRyM1s0lSpAvkZFNGtXOSIIAgmco0eMrVwqMgEgvH2vWSidbf8ha7cbiRkvf3Y/sQ9onF8WNaDUfMl/uj71l3N1hZE=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr598894uao.114.1656491054985; Wed, 29 Jun
 2022 01:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com> <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
 <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com> <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
In-Reply-To: <CAK8P3a2jQ+UQ54=QcpyVt91vXRyZrvUtOygFYOHWTBzse3q3rg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 29 Jun 2022 16:24:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTtKiMZJLWBEcRz-4CmNojH0cOgpUYGupLyCXXFjQD_FQ@mail.gmail.com>
Message-ID: <CAJF2gTTtKiMZJLWBEcRz-4CmNojH0cOgpUYGupLyCXXFjQD_FQ@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jun 29, 2022 at 3:34 AM Waiman Long <longman@redhat.com> wrote:
> > On 6/28/22 21:17, Guo Ren wrote:
> > > On Wed, Jun 29, 2022 at 2:13 AM Waiman Long <longman@redhat.com> wrote:
> > >> On 6/28/22 04:17, guoren@kernel.org wrote:
> > >>
> > >> So the current config setting determines if qspinlock will be used, not
> > >> some boot time parameter that user needs to specify. This patch will
> > >> just add useless code to lock/unlock sites. I don't see any benefit of
> > >> doing that.
> > > This is a startup patch for riscv. next, we could let vendors make choices.
> > > I'm not sure they like cmdline or vendor-specific errata style.
> > >
> > > Eventually, we would let one riscv Image support all machines, some
> > > use ticket-lock, and some use qspinlock.
> >
> > OK. Maybe you can postpone this combo spinlock until there is a good use
> > case for it. Upstream usually don't accept patches that have no good use
> > case yet.
>
> I think the usecase on risc-v is this: there are cases where the qspinlock
> is preferred for performance reasons, but there are also CPU cores on
> which it is not safe to use. risc-v like most modern architectures has a
> strict rule about being able to build kernels that work on all machines,
> so without something like this, it would not be able to use qspinlock at all.
>
> On the other hand, I don't really like the idea of putting the static-key
> wrapper into the asm-generic header. Especially the ticket spinlock
> implementation should be simple and not depend on jump labels.
If CONFIG_ARCH_USE_QUEUED_SPINLOCKS is not enabled, the patch still
will keep the ticket-lock simple without jump labels.

>
> From looking at the header file dependencies on arm64, I know that
> putting jump labels into core infrastructure like the arch_spin_lock()
> makes a big mess of indirect includes and measurably slows down
> the kernel build.
arm64 needn't combo spinlock, it could use pure qspinlock with keeping
current header files included.

>
> I think this can still be done in the riscv asm/spinlock.h header with
> minimal impact on the asm-generic file if the riscv maintainers see
> a significant enough advantage, but I don't want it in the common code.
Yes, it could. I agree with using combo spinlock only with riscv.

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

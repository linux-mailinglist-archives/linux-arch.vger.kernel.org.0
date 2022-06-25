Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259F955A621
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jun 2022 04:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiFYCmS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jun 2022 22:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiFYCmR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2022 22:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527162729
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2022 19:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2B86200F
        for <linux-arch@vger.kernel.org>; Sat, 25 Jun 2022 02:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01B7C385A2
        for <linux-arch@vger.kernel.org>; Sat, 25 Jun 2022 02:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656124935;
        bh=AnBQfuThhAVJbZkoTW5hBrmXxBqzamrtxkqZY+VoMKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pU42mCyobx8DyXMbEVtnikMfTH+MrzAotrTTwDdINJzRjJsN5LCmN4IVhNJvw57nh
         IOwjLMPulX6+jqJGk3fBZSdpY5GoJfVlCBViiMzkHBl5RQ96nLm4p5u5rGH1/ghQTV
         DzrZ3ff0qFNWETLJ/tmqzPPSksNLtyohczvt9xNmJkyTORpaF1lygAbst1XZbDytf+
         T/GLtjt1xX6HHPQ//WAjAZjwd+8zhVQXhOWBgUbHfaruzcJtIDIIJelRyiOHvXeNdW
         fXGsq7Vlh1dSfBD9+YpQfR5M6pEIzEjgT8Ek/dVWONzKTXtnTXuqsc7OswAzDGkYN9
         CRc9NBPJwxJlw==
Received: by mail-ua1-f46.google.com with SMTP id x24so1477733uaf.11
        for <linux-arch@vger.kernel.org>; Fri, 24 Jun 2022 19:42:15 -0700 (PDT)
X-Gm-Message-State: AJIora/mKNCupCTH4UwonZx1KDVsk+TMjkO4MY1n32X04ohUCHS9Y1kp
        8H5gpWAnqwXDpjBEW/5NTW94CxFv1kTjvhA9tmA=
X-Google-Smtp-Source: AGRyM1vuD4sZ4xpomv56mjKtKzQv6er3iMJ6Df1VMnVa3byawpZaEKw+XNAcv6YLzRJ0ul04j5XO+6fI+lSOKXkI4U4=
X-Received: by 2002:a05:6130:90:b0:362:891c:edef with SMTP id
 x16-20020a056130009000b00362891cedefmr995339uaf.106.1656124934634; Fri, 24
 Jun 2022 19:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <20220623044752.2074066-2-chenhuacai@loongson.cn> <CAJF2gTR1ksvWWT1tec1QnOt6rzDucx5qzWO44nA_vHFhqMtG_g@mail.gmail.com>
 <CAAhV-H7p=zr7vjzENLgByqRUsH1mNQb8fFxNBkQu2YsWp1gMWA@mail.gmail.com>
 <CAK8P3a0pKc7=iLcFY028HqJXmGupacm=tV7Wqgx0+bYSqczoog@mail.gmail.com>
 <CAAhV-H6MDm_jDFhcT-QBzJ-fLRc6VKoNbsoJC_BGN66sozdqfA@mail.gmail.com> <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0pyLgFXq5Wrwi9BBgNnZkEdLYXm9dOaOci2ouTnEAqGQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 25 Jun 2022 10:42:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSzUu5-C76LQs7KzV+U+qC5D1D-RVk4fHexHTJXLK6dqQ@mail.gmail.com>
Message-ID: <CAJF2gTSzUu5-C76LQs7KzV+U+qC5D1D-RVk4fHexHTJXLK6dqQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] LoongArch: Add qspinlock support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
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

On Thu, Jun 23, 2022 at 10:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 23, 2022 at 3:05 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Thu, Jun 23, 2022 at 4:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Thu, Jun 23, 2022 at 9:56 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > > On Thu, Jun 23, 2022 at 1:45 PM Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > >
> > > > > > On NUMA system, the performance of qspinlock is better than generic
> > > > > > spinlock. Below is the UnixBench test results on a 8 nodes (4 cores
> > > > > > per node, 32 cores in total) machine.
> > >
> > > You are still missing an explanation here about why this is safe to
> > > do. Is there are
> > > architectural guarantee for forward progress, or do you rely on
> > > specific microarchitectural
> > > behavior?
> > In my understanding, "guarantee for forward progress" means to avoid
> > many ll/sc happening at the same time and no one succeeds.
> > LoongArch uses "exclusive access (with timeout) of ll" to avoid
> > simultaneous ll (it also blocks other memory load/store on the same
> > address), and uses "random delay of sc" to avoid simultaneous sc
> > (introduced in CPUCFG3, bit 3 and bit 4 [1]). This mechanism can
> > guarantee forward progress in practice.
> >
> > [1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg
>
> If there is an architected feature bit for the delay, does that mean that there
> is a chance of CPUs getting released that set this to zero?
>
> In that case, you probably need a boot-time check for this feature bit
> to refuse booting a kernel with qspinlock enabled when it has more than
> one active CPU but does not support the random backoff,
Do you mean we should combine ticket-lock into qspinlock, and let the
machine choose during boot-time?

From Peter's comment, seems the arch is broken without a strong fwd guarantee.
https://lore.kernel.org/linux-riscv/YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net/

I'm not sure qspinlock guys would welcome ticket-lock getting into the
qspinlock data structure (Although ticket-lock is also made by peter).

> and you need
> to make the choice user-visible, so users are able to configure their
> kernels using the ticket spinlock. The ticket lock may also be the best
> choice for smaller configurations such as a single-socket 3A5000 with
> four cores and no NUMA.
>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

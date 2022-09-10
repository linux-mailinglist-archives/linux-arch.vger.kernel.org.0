Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472665B4ADD
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 01:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIJXf4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIJXfz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 19:35:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A4137185;
        Sat, 10 Sep 2022 16:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6070BB80936;
        Sat, 10 Sep 2022 23:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FBCC43143;
        Sat, 10 Sep 2022 23:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662852951;
        bh=Jyry0XnrQIPqshqAkfeJHzTrGEg9eXK2L5XeBnmM7CM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OsfSqYt5l9fd4iMfoFsDotSaKztUTUbh3zc6xN1Sg74aXG1SrUTyOsv5rJ3Gn7F+W
         ugXrsV9/RUnl+gOJfHDYsHODdqipCWQ6u4RbAH0/qozcaEndKW421Er2hfTL35YlGO
         f8wOWSlg4znvqGeFIPm2fGYKMyieXHhMQwJHQkNsZwerkIvENITqoesUEa1Y/Zy7nt
         p8MU0ZKFw8CFZI+QPT8WLErdMPXHNc+mP6HVtxEFLpyC45DUyaSslzXCF1VBPn2M34
         ULdZJK+R4+ZDjYtjGz1tbby/rqv/EooteWgk7CdTcfQg4j05Y852D/HpvYlQVrbHT1
         pcdOsmdEcboTA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-127ba06d03fso13766523fac.3;
        Sat, 10 Sep 2022 16:35:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo2rmuzPgdWw2xpYACndSEZAym2Y5nUlfLr95I/kkH4uEZWMab8z
        wwyAAePyX/je1dQC05KzkQUp7proLErFojdYXug=
X-Google-Smtp-Source: AA6agR7RtqaOODDWYKkxH5TzeX1qOCOc/G9NUqz5ZalFaE3cf1czgLZCSlqReaiO2M/LgeXi3fx7b5MFvk6FSovIaXs=
X-Received: by 2002:a05:6808:2028:b0:344:246d:2bed with SMTP id
 q40-20020a056808202800b00344246d2bedmr6134101oiw.19.1662852950944; Sat, 10
 Sep 2022 16:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
In-Reply-To: <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 11 Sep 2022 07:35:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
Message-ID: <CAJF2gTRnY+vc2nKbqubTZvv+FWVgO3yCK4LcwpeNgx51JuETzw@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 11, 2022 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Sep 10, 2022, at 2:52 PM, Guo Ren wrote:
> > On Thu, Sep 8, 2022 at 3:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Thu, Sep 8, 2022, at 4:25 AM, guoren@kernel.org wrote:
> >> > From: Guo Ren <guoren@linux.alibaba.com>
> >> - When VMAP_STACK is set, make it possible to select non-power-of-two
> >>   stack sizes. Most importantly, 12KB should be a really interesting
> >>   choice as 8KB is probably still not enough for many 64-bit workloads,
> >>   but 16KB is often more than what you need. You probably don't
> >>   want to allow 64BIT/8KB without VMAP_STACK anyway since that just
> >>   makes it really hard to debug, so hiding the option when VMAP_STACK
> >>   is disabled may also be a good idea.
> > I don't want this config to depend on VMAP_STACK. Some D1 chips would
> > run with an 8K stack size and !VMAP_STACK.
>
> That sounds like a really bad idea, why would you want to risk
> using such a small stack without CONFIG_VMAP_STACK?
>
> Are you worried about increased memory usage or something else?
The requirement is from [1], and I think disabling CONFIG_VMAP_STACK
would be the last step after serious testing.

[1] https://www.cnx-software.com/2021/10/25/allwinner-d1s-f133-risc-v-processor-64mb-ddr2/



>
> >  /* thread information allocation */
> > -#ifdef CONFIG_64BIT
> > -#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
> > -#else
> > -#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
> > -#endif
> > +#define THREAD_SIZE_ORDER      CONFIG_THREAD_SIZE_ORDER
> >  #define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
>
> This doesn't actually allow additional THREAD_SIZE values, as you
> still round up to the nearest power of two.
>
> I think all the non-arch code can deal with non-power-of-2
> sizes, so you'd just need
>
> #define THREAD_SIZE round_up(CONFIG_THREAD_SIZE, PAGE_SIZE)
>
> and fix up the risc-v specific code to do the right thing
> as well. I now see that THREAD_SIZE_ORDER is not actually
> used anywhere with CONFIG_VMAP_STACK, so I suppose that
> definition can be skipped, but you still need a THREAD_ALIGN
> definition that is a power of two and at least a page larger
> than THREAD_SIZE.
>
>      Arnd



-- 
Best Regards
 Guo Ren

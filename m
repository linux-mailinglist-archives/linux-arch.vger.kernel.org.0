Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0429B5BF614
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 08:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIUGLq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIUGLp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 02:11:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C1D7F0B5;
        Tue, 20 Sep 2022 23:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE3CB82D37;
        Wed, 21 Sep 2022 06:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBB2C43145;
        Wed, 21 Sep 2022 06:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663740701;
        bh=gH9Ski2xTYL8v4gkhUeBQyCrdw3Fy4fRS2TNCxB/HMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OiIo3nyiup7t5cubl5wo0ulrrg4kIwS5HB4XloEwdGH+mszNwOAl3PzDLZhg62LQi
         bSThkjVBsF9fC8JGxXA6DJjxR2ls74Afg2IsVe1UvwTREhSckaHzXn7gNMSw9GU2OI
         JQu+axS9AGleHtpjFeMotoSKxrIa7pQbbsp31vxtBjAN7S54Biehy/r1jl4uEb/yxM
         GGDN2SISq+cwqgoSsBgLA1FYYdtgqirewNwQh2vkoxT0I0SxKNQZToYuUg8g+m3WED
         0LwGfiVhDniSq6WPFSlKiTGjNeTqWc5x/QtxZO9s1ddWYlUddo1HXhsrbmo4jPpg6d
         PcdatBm1/HVLQ==
Received: by mail-oi1-f170.google.com with SMTP id n124so6760720oih.7;
        Tue, 20 Sep 2022 23:11:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf0+fQIQImB9kR9Fg4i8NZhbN8Aa8BuLg5uKQI5KIaGFeyH+46q4
        rXZeCTMZNB5Y4f7gTt1/ih1X7MiFiJntbLMtBnA=
X-Google-Smtp-Source: AMsMyM6+iL281iADWwJADpMlN3AK4Wsnm5yixhuu8iSUo6zhNyURpR9orru8QFczyFY+Y4K4m4KzqFMleGCsaaCNrYY=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr3236680oiw.112.1663740700715; Tue, 20
 Sep 2022 23:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com> <542a9b2e-016a-4e09-9edb-c268bfae885f@www.fastmail.com>
In-Reply-To: <542a9b2e-016a-4e09-9edb-c268bfae885f@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 14:11:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTXRyPJG924ZMQRaHehcmX0=MdtO0-vtKVzTrgDKH+QMA@mail.gmail.com>
Message-ID: <CAJF2gTTXRyPJG924ZMQRaHehcmX0=MdtO0-vtKVzTrgDKH+QMA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 20, 2022 at 3:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 20, 2022, at 2:46 AM, Guo Ren wrote:
>
> >
> > How about this one: (only THREAD_SIZE, no THREAD_ORDER&SHIFT.)
> >
> > -
> >  /* thread information allocation */
> > -#ifdef CONFIG_64BIT
> > -#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
> > -#else
> > -#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
> > -#endif
> > -#define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
> > +#define THREAD_SIZE            CONFIG_THREAD_SIZE
>
>
> So far looks fine.
>
> >
> >  /*
> >   * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
> > - * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
> > - * assembly.
> > + * checking sp & THREAD_SIZE, which we can do cheaply in the entry assembly.
> >   */
> >  #ifdef CONFIG_VMAP_STACK
> >  #define THREAD_ALIGN            (2 * THREAD_SIZE)
> > @@ -36,7 +24,6 @@
> >  #define THREAD_ALIGN            THREAD_SIZE
> >  #endif
>
> The THREAD_ALIGN does not, this only works for power-of-two numbers of
> THREAD_SIZE,
We double THREAD_SIZE to simplify the detection. See the commit log:

    The overflow detect is performed before any attempt is made to access
    the stack and the principle of stack overflow detection: kernel stacks
    are aligned to double their size, enabling overflow to be detected with
    a single bit test. For example, a 16K stack is aligned to 32K, ensuring
    that bit 14 of the SP must be zero. On an overflow (or underflow), this
    bit is flipped. Thus, overflow (of less than the size of the stack) can
    be detected by testing whether this bit is set.

I would try to optimize the size of VMAP_STACK in another patch.

>
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 426529b84db0..1e35fb3bdae5 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -29,8 +29,8 @@ _restore_kernel_tpsp:
> >
> >  #ifdef CONFIG_VMAP_STACK
> >         addi sp, sp, -(PT_SIZE_ON_STACK)
> > -       srli sp, sp, THREAD_SHIFT
> > -       andi sp, sp, 0x1
> > +       srli sp, sp, PAGE_SHIFT
> > +       andi sp, sp, (THREAD_SIZE >> PAGE_SHIFT)
>
> I think this needs to use THREAD_ALIGN, not THREAD_SIZE.
No, it's BIT[14], when THREAD_SIZE = 16K.

>
>       Arnd



-- 
Best Regards
 Guo Ren

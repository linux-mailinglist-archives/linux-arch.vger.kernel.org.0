Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8A5B4B28
	for <lists+linux-arch@lfdr.de>; Sun, 11 Sep 2022 03:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIKBN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIKBN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 21:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF5DDD9;
        Sat, 10 Sep 2022 18:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9766E60DDB;
        Sun, 11 Sep 2022 01:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0214DC433C1;
        Sun, 11 Sep 2022 01:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662858835;
        bh=MeoerLBAPT9yREBhU9oRAJcpZt/hWhuixo7TStbdTjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvPWlhbtbekWBecfnQ74hnjTB2kcC5KUKgVBnPXCUYV23W7UT5LogKs9HEbKTC5Co
         g3QE/DM67eW4RjCYDw0u6uOOH+50DigwNHFExDOtsmQRZEoSeHVmNjemHKJoZ6b5WC
         mLBB2itN1xC46kD3SbErY/iIaS0O8+1xJOi5wNnEEplOlKuq+Gug1wUVBFUl4WZPaX
         vF5bG3nwwW7j8goNgh7M8KBR4mix3SOc4H5z9VdgDbqhHeNP+8mBeE70OZrnv3Y4XM
         dGYQmXotoRQzmKRiltJjhsPat1aL9dD3B70oOy0Kpg/f2/j/6v5wdl1FQipgmjAB/u
         CXbb2zW56GHxA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11eab59db71so14096191fac.11;
        Sat, 10 Sep 2022 18:13:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo3FbqCjI2/UWTF//kcVOhtNhHntjTTDuN5g83Q7iFyMoOAxFGHe
        x/76QtAtmXCf0xGWg9Z4PqnFJzEb8a+zagiYLNI=
X-Google-Smtp-Source: AA6agR4bcGzrnAq5Tqy6Eqx1fM4d1eSVwcSJsOIm24Kg6cAY2vOjkeUWe5EEaM5Rgubow59jC/8cP9IImnLFMMmOgb0=
X-Received: by 2002:a05:6808:2028:b0:344:246d:2bed with SMTP id
 q40-20020a056808202800b00344246d2bedmr6237639oiw.19.1662858834117; Sat, 10
 Sep 2022 18:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-7-guoren@kernel.org>
 <YxoTdxk772vneG53@linutronix.de> <0ff315c978d24215b00c42df51f51b2d@AcuMS.aculab.com>
In-Reply-To: <0ff315c978d24215b00c42df51f51b2d@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 11 Sep 2022 09:13:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQFwYDtBUpOViYMrWPVKCXJsNwmL9o16jEhpV_v7FjZyA@mail.gmail.com>
Message-ID: <CAJF2gTQFwYDtBUpOViYMrWPVKCXJsNwmL9o16jEhpV_v7FjZyA@mail.gmail.com>
Subject: Re: [PATCH V4 6/8] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
To:     David Laight <David.Laight@aculab.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jszhang@kernel.org" <jszhang@kernel.org>,
        "lazyparser@gmail.com" <lazyparser@gmail.com>,
        "falcon@tinylab.org" <falcon@tinylab.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
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

On Fri, Sep 9, 2022 at 3:30 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Sebastian Andrzej Siewior
> > Sent: 08 September 2022 17:08
> >
> > On 2022-09-07 22:25:04 [-0400], guoren@kernel.org wrote:
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index a07bb3b73b5b..a8a12b4ba1a9 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -433,6 +433,14 @@ config FPU
> > >
> > >       If you don't know what to do here, say Y.
> > >
> > > +config IRQ_STACKS
> > > +   bool "Independent irq stacks"
> > > +   default y
> > > +   select HAVE_IRQ_EXIT_ON_IRQ_STACK
> > > +   help
> > > +     Add independent irq stacks for percpu to prevent kernel stack overflows.
> > > +     We may save some memory footprint by disabling IRQ_STACKS.
> >
> > Do you really think that it is needed to save memory here? Avoiding
> > stack overflows in deep call chains is probably more important than
> > saving ~8KiB per CPU.
Original riscv is !IRQ_STACKS, I just give a config to make it back.
So I would add a CONFIG_EXPERT in the next version.

Actually, I have a similar opinion to you, IRQ_STACKS should be force
enabled. But as a new feature, we should give users a choice - use or
not.

>
> Particularly if a 64bit build is using small stacks.
>
> Without static analysis of actual call chain depth it is
> really difficult to trim the stack size.
>
> I'd bet (a few beers) that the deepest stack use in inside
> the console print code form a printk() (eg warn_on_once)
> in an obscure error path somewhere.
> This won't be hit during any normal testing.
That means stack overflow would be hidden a lot. But we could enable
VMAP_STACK & STACK_LEAK [1].

[1]: https://lore.kernel.org/lkml/20220907014809.919979-1-guoren@kernel.org/

>
> I think that the analysis objtool does is getting close
> to be able to generate the raw data that can be used for
> static stack depth analysis.
> You need the 'CFI' constants for indirect calls and
> some assumptions about depth of recursive calls.
> But apart from that the code to process the raw output
> isn't that complex.
>
> A nice task for someone with some spare time.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Best Regards
 Guo Ren

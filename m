Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087255BC465
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiISIfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiISIfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 04:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEEA15822;
        Mon, 19 Sep 2022 01:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50BB161803;
        Mon, 19 Sep 2022 08:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5DAC433B5;
        Mon, 19 Sep 2022 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663576517;
        bh=NDnqlZhtaXp4aa68lUPaptwqfteRjFznv1jId6XcsS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FwYz92tNSMouuBkIr5MB0ikWNhkT/ojXPVaqBFo9x9Qw3AXpQX6EkpNmq951GANP0
         B3ExHYccC0OeCAXhQJNx/NZEmoIsrh0R7SFhbWr150UmDA5LTSqL6Tt+IJu8SH1OXD
         Yhf7sBYd1MELMeun3wN9cfGTH0sQa5yCwugRti/T36YHMfV5oFbGSWkixlQfDH578O
         h2o+cGoqTG2kyd8EPEB4gcrGSbT8Ogq2c8ldeYoB90/RfqO8UPZV9ozspdXOhhG8zy
         vXQdfurH6njPs1BbzxIxa3r81/RpXmOczYU6+hZiUGYsAceYNwtJJrp9zz2f6WBwCk
         5wufF9xkOWJTA==
Received: by mail-oi1-f182.google.com with SMTP id n83so13770447oif.11;
        Mon, 19 Sep 2022 01:35:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo2+oIwjIlBMnFeETZgBank3gq4LFlkGUBDSHmmj+D+X9JsC+jmN
        aHnBfIoAYHcX9/s+UbqFtiOoUEnfRYZ578L1Yng=
X-Google-Smtp-Source: AA6agR5ITfiPWZ9F9F5lkDqO0GA/3OeLcDmqgx/nf0vJ/sBZgtsKJFlK/BPu0y1OEMjk0otXRqR3awY0W+PQUuOvZvM=
X-Received: by 2002:a05:6808:201f:b0:34f:9fdf:dbbf with SMTP id
 q31-20020a056808201f00b0034f9fdfdbbfmr11418144oiw.19.1663576516813; Mon, 19
 Sep 2022 01:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
In-Reply-To: <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 19 Sep 2022 16:35:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
Message-ID: <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
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
Sorry, I missed this part. I would RESEND v5

>
>      Arnd



-- 
Best Regards
 Guo Ren

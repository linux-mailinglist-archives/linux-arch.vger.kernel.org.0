Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FE5636CD
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiGAPSn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 11:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiGAPSl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 11:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B330543;
        Fri,  1 Jul 2022 08:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A0D7B83076;
        Fri,  1 Jul 2022 15:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11654C341CF;
        Fri,  1 Jul 2022 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656688718;
        bh=XT19J7tfEXlwiUinDfQaGsUAqM2Jh+CfB0vp/2kuJP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PmO0KbcapyN0IF797m1MeyFs2D36zNUM4PWE2tXHGsno8vroSpAu8WJOdR+LqACgD
         qsgxFI3SsTwegRgvL/4Gzqv2MWyiqaCGNP4uGhFoiXXEcIYmNmYFw7r9b6btJ7ysIw
         I0ZyaX1UgsQKV8BpeRJIiCvau/TKfPGl9NpLwSH1M3+uAhTgAVpEv8sr5Hw1zuiVrW
         DIRABCoSFU7EiGAwxu5T68FeHDMo2ezlVZgmB0Ymg7+cu6UAZtuDXHwmE4Js04/p8o
         oLCjVYfkEIa+uuDbrjGdYofuawBP7a6xT3nwVI7EJcjJYJHmGCEMj2wMDIN1cF3NGQ
         Fg3ccan+5REaQ==
Received: by mail-ua1-f47.google.com with SMTP id l27so935956uac.10;
        Fri, 01 Jul 2022 08:18:38 -0700 (PDT)
X-Gm-Message-State: AJIora+U1JSvEKdMYKgUEYm9XbHDm9fRBvoRfUA9X+StLPwd92gdxRRf
        Uk6pxm5miZX/8q+oXilGeAp6MnCwBl+XukEjHFw=
X-Google-Smtp-Source: AGRyM1su4bh/Qc4VULUJCugaye8aZYrrc3pSCAd5DT+9mUsito0CtDyo7cy8TkPrir1gknw2h5ic++3eTmFbXpc9OeA=
X-Received: by 2002:ab0:4384:0:b0:37f:1bac:b425 with SMTP id
 l4-20020ab04384000000b0037f1bacb425mr8408793ual.12.1656688716940; Fri, 01 Jul
 2022 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-2-guoren@kernel.org>
 <8eaf85d4e4d9401ea187366de12e7269@AcuMS.aculab.com>
In-Reply-To: <8eaf85d4e4d9401ea187366de12e7269@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 1 Jul 2022 23:18:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTWO-HxQNME=YN4pvEeFD5fT0dUx9pQhLujMk1V008U5A@mail.gmail.com>
Message-ID: <CAJF2gTTWO-HxQNME=YN4pvEeFD5fT0dUx9pQhLujMk1V008U5A@mail.gmail.com>
Subject: Re: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary atomic_read
To:     David Laight <David.Laight@aculab.com>
Cc:     "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On Wed, Jun 29, 2022 at 4:27 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: guoren@kernel.org
> > Sent: 28 June 2022 09:17
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
> > because the value has been in lock. This patch could prevent
> > arch_spin_value_unlocked contend spin_lock data again.
>
> I'm confused (as usual).
> Isn't atomic_read() pretty much free?
When a cache line is shared with multi-harts, not as free as you think.
Preventing touching contended data is the basic principle.

atomic_read in alpha is heavy, It could be a potential user of ticket-lock.

>
> ..
> > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > index fdfebcb050f4..f1e4fa100f5a 100644
> > --- a/include/asm-generic/spinlock.h
> > +++ b/include/asm-generic/spinlock.h
> > @@ -84,7 +84,9 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> >
> >  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> >  {
> > -     return !arch_spin_is_locked(&lock);
> > +     u32 val = lock.counter;
> > +
> > +     return ((val >> 16) == (val & 0xffff));
>
> That almost certainly needs a READ_ONCE().
>
> The result is also inherently stale.
> So the uses must be pretty limited.
The previous read_once could get 64bit, use the API to check the 32bit
atomic data part.

>
>         David
>
> >  }
> >
> >  #include <asm/qrwlock.h>
> > --
> > 2.36.1
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

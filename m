Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA7565311
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 13:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiGDLKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 07:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiGDLKc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 07:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D9EE20;
        Mon,  4 Jul 2022 04:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D376162A;
        Mon,  4 Jul 2022 11:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0F9C341D2;
        Mon,  4 Jul 2022 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656933030;
        bh=ot6Cywhg5Y74QsAqqjdnA7iQ1+9VGdvh4LvC/i3dOjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qk6g9als6ERJTM7rL3rHUn2jKHchPkmFyKqleAn6liKL9sqGK9Ph+B181hl0DskoP
         WvgZa9xt1DqAjubxp46ywcamgiWVwshg5P1AfVZYBHxrikNXskcynP9S2vviur34es
         8/8qLfVWS8R+9orDIsUaoIwB46UAGJWE/nVDX3t8s5v9PHdn2l36bBpBVw7AfJlVS9
         iaQK/4WPHYqlsBqRS2m0gYWCMWwvvw7A7WHYK6xnJJXF4RNljFxIZPKR6i9Xs2MBzu
         dgsdLgVX1ri7kcTKSuiWafBh7YpiqfYBRYlj+maVC7OTD7uCshAu2KrdbzgHBcN2kq
         YpvHkzDoEHfeQ==
Received: by mail-vs1-f50.google.com with SMTP id 126so8604932vsq.13;
        Mon, 04 Jul 2022 04:10:30 -0700 (PDT)
X-Gm-Message-State: AJIora+ihCuc9vBtRw9iN8ckmKAPXV1FQwZkDJS6S8VqQgfXB5fFNW5B
        +EM85Zt3iA0/7XKIzF7iTZaAUGsQz5d+h+eCEX0=
X-Google-Smtp-Source: AGRyM1uk1FGNC9Dq3XZ8oH9EJNsX2SQ8QRIj2cAQaGvT9ZrDtktfrcKyEyV/z5OXo0zyRjs4k6ePRO+yPt1Kf1zPKR8=
X-Received: by 2002:a05:6102:366f:b0:356:352f:9de2 with SMTP id
 bg15-20020a056102366f00b00356352f9de2mr16599934vsb.2.1656933028989; Mon, 04
 Jul 2022 04:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-2-guoren@kernel.org>
 <YsK4Z9w0tFtgkni8@hirez.programming.kicks-ass.net>
In-Reply-To: <YsK4Z9w0tFtgkni8@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 4 Jul 2022 19:10:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJn7facrxSzU+_ZKhVdXxJEYfGWpP7QqArVUTazw_JHg@mail.gmail.com>
Message-ID: <CAJF2gTTJn7facrxSzU+_ZKhVdXxJEYfGWpP7QqArVUTazw_JHg@mail.gmail.com>
Subject: Re: [PATCH V7 1/5] asm-generic: ticket-lock: Remove unnecessary atomic_read
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 4, 2022 at 5:52 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 28, 2022 at 04:17:03AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Remove unnecessary atomic_read in arch_spin_value_unlocked(lock),
> > because the value has been in lock. This patch could prevent
> > arch_spin_value_unlocked contend spin_lock data again.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  include/asm-generic/spinlock.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
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
> >  }
>
> Wouldn't the right thing be to flip arch_spin_is_locked() and
> arch_spin_value_is_unlocked() ?
Okay, I agree with your patch. Next version, I would take the below code.

>
>
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..63ab4da262f2 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -68,23 +68,25 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>         smp_store_release(ptr, (u16)val + 1);
>  }
>
> -static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> +static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  {
>         u32 val = atomic_read(lock);
>
> -       return ((val >> 16) != (val & 0xffff));
> +       return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>
> -static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
> -       u32 val = atomic_read(lock);
> +       u32 val = lock.counter;
>
> -       return (s16)((val >> 16) - (val & 0xffff)) > 1;
> +       return ((val >> 16) == (val & 0xffff));
>  }
>
> -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -       return !arch_spin_is_locked(&lock);
> +       arch_spinlock_t val = READ_ONCE(*lock);
> +
> +       return !arch_spin_value_unlocked(val);
>  }
>
>  #include <asm/qrwlock.h>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

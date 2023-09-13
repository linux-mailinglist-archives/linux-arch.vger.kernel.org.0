Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D4B79E159
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbjIMIAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbjIMIAp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 04:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 191A1173E
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694591996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qn+Rvi3KEsNuqH89FqpaJB3chCAou0VjBLqNOIj1NKA=;
        b=FFkytSNhn2JsBdJAv1MJzYIIKBcMKXFilXgzR2ZKELcXbDdmNu0qhmimt3WMLryOHFidn+
        Gl0CpkRnDL1zSZKKrUY4z9p2zF7NdYCeuAEXMTuFB3zRusDVgy27VfjtVOO/f2B15hC3X2
        v9h77P5kRX1rHmElz97d/o7+wvwV1/E=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-AeBjluf5NymmvMdy7dVryQ-1; Wed, 13 Sep 2023 03:59:54 -0400
X-MC-Unique: AeBjluf5NymmvMdy7dVryQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-573a7a3c405so6776066eaf.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 00:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591994; x=1695196794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn+Rvi3KEsNuqH89FqpaJB3chCAou0VjBLqNOIj1NKA=;
        b=VJ/nIc9pMZqJf87YkFobCvQi6+IT/zy7/9myOg4dWUQ93aDW1EWZ3jS/ARDK4D0Ky6
         jolqwk4/U7Ihw11t/3bLJUPgc7KviPh0tGacpBievr9Jf9Sfo8F6tbZ1Yt6XsOBHs2XX
         8CoCuAOur1owSMzR7aNQCgrVGbwq6sYCchMmSVgBMKn85D7zloAU4gg4RMmhnogZcyeb
         NvOyVnY7EZwc6sW3Bx36fHK1G9pD1PdSphtqlMh4eCjUpb/jrhAUPZEMAShvcVbzv6Pl
         XT8e4A1lsSVeSyJtINx8BfmlOhhC4FCTiqlXhH57sT5vEah1vDTwx90rJqNuzU0dQsfg
         4fJQ==
X-Gm-Message-State: AOJu0YwgBGuNSMri0aRZx+HOIdIQizsOMkKk289jo6q8EPRtB4LULg65
        I7fsTHVm5AHyA5FZLGdA/Vd713QhTpWnef4MKRD6ftO0LZ/6PM3uaPjEGS1Bjq1xwoaBAFKrGaS
        LNJOMUq3eKBTYqUvmwYsDNw==
X-Received: by 2002:a4a:9002:0:b0:571:28a7:bcca with SMTP id i2-20020a4a9002000000b0057128a7bccamr1816203oog.1.1694591994235;
        Wed, 13 Sep 2023 00:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLkEjNahfHYX7tZYhXT/ZX+4kZcuTHvxRjPc0v0vlixFaqqxwikb4fwJBCpdjiUauIx9LpUg==
X-Received: by 2002:a4a:9002:0:b0:571:28a7:bcca with SMTP id i2-20020a4a9002000000b0057128a7bccamr1816184oog.1.1694591993958;
        Wed, 13 Sep 2023 00:59:53 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id s4-20020a4a5104000000b005658aed310bsm5159994ooa.15.2023.09.13.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:59:53 -0700 (PDT)
Date:   Wed, 13 Sep 2023 04:59:44 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 01/17] asm-generic: ticket-lock: Reuse
 arch_spinlock_t of qspinlock
Message-ID: <ZQFr8E-i8dB5Ofwm@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-2-guoren@kernel.org>
 <5c082cb1fd306cb75abbcaa80229d791260f8756.camel@redhat.com>
 <CAJF2gTSynMnYy+ARhFb0JjbAGjEYrfgsiGa2ZWv4wB3HdheU2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTSynMnYy+ARhFb0JjbAGjEYrfgsiGa2ZWv4wB3HdheU2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 09:55:31AM +0800, Guo Ren wrote:
> On Tue, Sep 12, 2023 at 3:05 AM Leonardo Brás <leobras@redhat.com> wrote:
> >
> > On Sun, 2023-09-10 at 04:28 -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > The arch_spinlock_t of qspinlock has contained the atomic_t val, which
> > > satisfies the ticket-lock requirement. Thus, unify the arch_spinlock_t
> > > into qspinlock_types.h. This is the preparation for the next combo
> > > spinlock.
> > >
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > ---
> > >  include/asm-generic/spinlock.h       | 14 +++++++-------
> > >  include/asm-generic/spinlock_types.h | 12 ++----------
> > >  2 files changed, 9 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > > index 90803a826ba0..4773334ee638 100644
> > > --- a/include/asm-generic/spinlock.h
> > > +++ b/include/asm-generic/spinlock.h
> > > @@ -32,7 +32,7 @@
> > >
> > >  static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> > >  {
> > > -     u32 val = atomic_fetch_add(1<<16, lock);
> > > +     u32 val = atomic_fetch_add(1<<16, &lock->val);
> > >       u16 ticket = val >> 16;
> > >
> > >       if (ticket == (u16)val)
> > > @@ -46,31 +46,31 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> > >        * have no outstanding writes due to the atomic_fetch_add() the extra
> > >        * orderings are free.
> > >        */
> > > -     atomic_cond_read_acquire(lock, ticket == (u16)VAL);
> > > +     atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
> > >       smp_mb();
> > >  }
> > >
> > >  static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> > >  {
> > > -     u32 old = atomic_read(lock);
> > > +     u32 old = atomic_read(&lock->val);
> > >
> > >       if ((old >> 16) != (old & 0xffff))
> > >               return false;
> > >
> > > -     return atomic_try_cmpxchg(lock, &old, old + (1<<16)); /* SC, for RCsc */
> > > +     return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
> > >  }
> > >
> > >  static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> > >  {
> > >       u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> > > -     u32 val = atomic_read(lock);
> > > +     u32 val = atomic_read(&lock->val);
> > >
> > >       smp_store_release(ptr, (u16)val + 1);
> > >  }
> > >
> > >  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> > >  {
> > > -     u32 val = lock.counter;
> > > +     u32 val = lock.val.counter;
> > >
> > >       return ((val >> 16) == (val & 0xffff));
> > >  }
> >
> > This one seems to be different in torvalds/master, but I suppose it's because of
> > the requirement patches I have not merged.
> >
> > > @@ -84,7 +84,7 @@ static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> > >
> > >  static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> > >  {
> > > -     u32 val = atomic_read(lock);
> > > +     u32 val = atomic_read(&lock->val);
> > >
> > >       return (s16)((val >> 16) - (val & 0xffff)) > 1;
> > >  }
> > > diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
> > > index 8962bb730945..f534aa5de394 100644
> > > --- a/include/asm-generic/spinlock_types.h
> > > +++ b/include/asm-generic/spinlock_types.h
> > > @@ -3,15 +3,7 @@
> > >  #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
> > >  #define __ASM_GENERIC_SPINLOCK_TYPES_H
> > >
> > > -#include <linux/types.h>
> > > -typedef atomic_t arch_spinlock_t;
> > > -
> > > -/*
> > > - * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
> > > - * include.
> > > - */
> > > -#include <asm/qrwlock_types.h>
> > > -
> > > -#define __ARCH_SPIN_LOCK_UNLOCKED    ATOMIC_INIT(0)
> > > +#include <asm-generic/qspinlock_types.h>
> > > +#include <asm-generic/qrwlock_types.h>
> > >
> > >  #endif /* __ASM_GENERIC_SPINLOCK_TYPES_H */
> >
> > FWIW, LGTM:
> >
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> >
> >
> > Just a suggestion: In this patch I could see a lot of usage changes to
> > arch_spinlock_t, and only at the end I could see the actual change in the .h
> > file.
>  include/asm-generic/spinlock.h       | 14 +++++++-------
>  include/asm-generic/spinlock_types.h | 12 ++----------
> 
> All are .h files. So, how to use git.orderfile?

Yeap, you are right.

For some reason I got confused about seeing functions before type definition.

But in any way, we can get the same result with:

*types.h
*.h
*.c

Meaning 'spinlock_types.h' will appear before 'spinlock.h'.

After first suggesting this, I also sent a patch providing a default
orderFile for the kernel, and I also added this to the latest version:

https://lore.kernel.org/all/20230913075550.90934-2-leobras@redhat.com/

> 
> >
> > In cases like this, it looks nicer to see the .h file first.
> >
> > I recently found out about this git diff.orderFile option, which helps to
> > achieve exactly this.
> >
> > I use the following git.orderfile, adapted from qemu:
> >
> > ############################################################################
> > #
> > # order file for git, to produce patches which are easier to review
> > # by diffing the important stuff like interface changes first.
> > #
> > # one-off usage:
> > #   git diff -O scripts/git.orderfile ...
> > #
> > # add to git config:
> > #   git config diff.orderFile scripts/git.orderfile
> > #
> >
> > MAINTAINERS
> >
> > # Documentation
> > Documentation/*
> > *.rst
> > *.rst.inc
> >
> > # build system
> > Kbuild
> > Makefile*
> > *.mak
> >
> > # semantic patches
> > *.cocci
> >
> > # headers
> > *.h
> > *.h.inc
> >
> > # code
> > *.c
> > *.c.inc
> >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


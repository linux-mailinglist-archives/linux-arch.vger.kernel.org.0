Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7188B79FD20
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjINHSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 03:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjINHSp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 03:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B40291
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694675874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEyUVXw0mWMHoikQx5FXX/6OXRLTpxgiWnfiglWGV8E=;
        b=M9Nuf+OuEZbsEEiwAef+d9dmar2CI9bEITwpbK5f2C0gMlXqUhGT4D27GEO1fQjYJeZXs8
        sfB27GS7bbK6BKQWIBRCw6cCFZsnnxiw1h5s3Yo4o+6POtl72HjZrVMDLPz3Zj3r9c0mS3
        ndIeTiEUcmRsJxPcSDXy2saGSh1HgfY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-5h0dGi-xNCe93rgB_-OeLA-1; Thu, 14 Sep 2023 03:17:53 -0400
X-MC-Unique: 5h0dGi-xNCe93rgB_-OeLA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9cf208fb5so819101a34.3
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 00:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694675872; x=1695280672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEyUVXw0mWMHoikQx5FXX/6OXRLTpxgiWnfiglWGV8E=;
        b=TSUVlu9B6D7D6vuI+nquK1tyZNdoZtyjsomWzjSmWTswZw2qPvH8PcjDdAwIsMZG+X
         Nsk6Ql+2TZIIribHbqwCopfuLd43KA+zOi4RupjgJb+SmVlx2EsQcihbUmnz/KfURBUZ
         AFpl6JfTZdkxqVTHJJN3LX7vfqgYhxlq+1vF+HeGaB2lgECPYdfqTEUQfD1o3vMK8Vfy
         m/kdiz9b3cd2RaJ8dVW29+p9nRlNtoH/oPt9LzVrLrE9RyJKclKGoEBPC0YEDBvJoTMo
         /SoywHTciL6Ug7bbUF9Q/TwBhRPYX/XzDEPn+1sTcD8sBQ1uyzj8zuhkBQnqrGk7XtvE
         VQ8A==
X-Gm-Message-State: AOJu0YxneQRCP4BmEf5O6QAcxCiOUQzYRLA72YJgf+9QvM+bOG6kWG/E
        lzRguFpJeFAwa4GSn6+bMJWzgiDoQ4+wSwCSh8sCffBDW/joQdmFHgfm0xYpgkUkEYb1uWuCsRq
        fVSyV38eDXzHJ3GrcYUqorw==
X-Received: by 2002:a9d:4b15:0:b0:6b9:ed64:1423 with SMTP id q21-20020a9d4b15000000b006b9ed641423mr5620091otf.2.1694675872309;
        Thu, 14 Sep 2023 00:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOAdtS3UbOt9zvLXyyE0sF8G5QOYDAkMf+vwqDvXVMptC9CKtp58xa3OrQHXJOdPOz3qvAzA==
X-Received: by 2002:a9d:4b15:0:b0:6b9:ed64:1423 with SMTP id q21-20020a9d4b15000000b006b9ed641423mr5620068otf.2.1694675871980;
        Thu, 14 Sep 2023 00:17:51 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id s189-20020a4a51c6000000b0056e67f2f92asm380519ooa.22.2023.09.14.00.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 00:17:51 -0700 (PDT)
Date:   Thu, 14 Sep 2023 04:17:41 -0300
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
Subject: Re: [PATCH V11 06/17] riscv: qspinlock: Introduce combo spinlock
Message-ID: <ZQKzlZ69M4nwqJt_@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-7-guoren@kernel.org>
 <ZP2jL06TYGYVBhTN@gmail.com>
 <ZQIdbbzW79s5tfiI@redhat.com>
 <ZQIgTyJ-DETrK8k3@redhat.com>
 <CAJF2gTQ=K_2km_AUZj1Vg8q2XgWB49-+nxViAa1mSAfppp6dnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQ=K_2km_AUZj1Vg8q2XgWB49-+nxViAa1mSAfppp6dnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 12:49:45PM +0800, Guo Ren wrote:
> On Thu, Sep 14, 2023 at 4:49 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Wed, Sep 13, 2023 at 05:37:01PM -0300, Leonardo Bras wrote:
> > > On Sun, Sep 10, 2023 at 07:06:23AM -0400, Guo Ren wrote:
> > > > On Sun, Sep 10, 2023 at 04:29:00AM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > Combo spinlock could support queued and ticket in one Linux Image and
> > > > > select them during boot time via errata mechanism. Here is the func
> > > > > size (Bytes) comparison table below:
> > > > >
> > > > > TYPE                      : COMBO | TICKET | QUEUED
> > > > > arch_spin_lock            : 106   | 60     | 50
> > > > > arch_spin_unlock  : 54    | 36     | 26
> > > > > arch_spin_trylock : 110   | 72     | 54
> > > > > arch_spin_is_locked       : 48    | 34     | 20
> > > > > arch_spin_is_contended    : 56    | 40     | 24
> > > > > rch_spin_value_unlocked   : 48    | 34     | 24
> > > > >
> > > > > One example of disassemble combo arch_spin_unlock:
> > > > >    0xffffffff8000409c <+14>:    nop                # detour slot
> > > > >    0xffffffff800040a0 <+18>:    fence   rw,w       # queued spinlock start
> > > > >    0xffffffff800040a4 <+22>:    sb      zero,0(a4) # queued spinlock end
> > > > >    0xffffffff800040a8 <+26>:    ld      s0,8(sp)
> > > > >    0xffffffff800040aa <+28>:    addi    sp,sp,16
> > > > >    0xffffffff800040ac <+30>:    ret
> > > > >    0xffffffff800040ae <+32>:    lw      a5,0(a4)   # ticket spinlock start
> > > > >    0xffffffff800040b0 <+34>:    sext.w  a5,a5
> > > > >    0xffffffff800040b2 <+36>:    fence   rw,w
> > > > >    0xffffffff800040b6 <+40>:    addiw   a5,a5,1
> > > > >    0xffffffff800040b8 <+42>:    slli    a5,a5,0x30
> > > > >    0xffffffff800040ba <+44>:    srli    a5,a5,0x30
> > > > >    0xffffffff800040bc <+46>:    sh      a5,0(a4)   # ticket spinlock end
> > > > >    0xffffffff800040c0 <+50>:    ld      s0,8(sp)
> > > > >    0xffffffff800040c2 <+52>:    addi    sp,sp,16
> > > > >    0xffffffff800040c4 <+54>:    ret
> > > > >
> > > > > The qspinlock is smaller and faster than ticket-lock when all are in
> > > > > fast-path, and combo spinlock could provide a compatible Linux Image
> > > > > for different micro-arch design (weak/strict fwd guarantee LR/SC)
> > > > > processors.
> > > > >
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > ---
> > > > >  arch/riscv/Kconfig                |  9 +++-
> > > > >  arch/riscv/include/asm/spinlock.h | 78 ++++++++++++++++++++++++++++++-
> > > > >  arch/riscv/kernel/setup.c         | 14 ++++++
> > > > >  3 files changed, 98 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > index 7f39bfc75744..4bcff2860f48 100644
> > > > > --- a/arch/riscv/Kconfig
> > > > > +++ b/arch/riscv/Kconfig
> > > > > @@ -473,7 +473,7 @@ config NODES_SHIFT
> > > > >
> > > > >  choice
> > > > >   prompt "RISC-V spinlock type"
> > > > > - default RISCV_TICKET_SPINLOCKS
> > > > > + default RISCV_COMBO_SPINLOCKS
> > > > >
> > > > >  config RISCV_TICKET_SPINLOCKS
> > > > >   bool "Using ticket spinlock"
> > > > > @@ -485,6 +485,13 @@ config RISCV_QUEUED_SPINLOCKS
> > > > >   help
> > > > >     Make sure your micro arch LL/SC has a strong forward progress guarantee.
> > > > >     Otherwise, stay at ticket-lock.
> > > > > +
> > > > > +config RISCV_COMBO_SPINLOCKS
> > > > > + bool "Using combo spinlock"
> > > > > + depends on SMP && MMU
> > > > > + select ARCH_USE_QUEUED_SPINLOCKS
> > > > > + help
> > > > > +   Select queued spinlock or ticket-lock via errata.
> > > > >  endchoice
> > > > >
> > > > >  config RISCV_ALTERNATIVE
> > > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > > > index c644a92d4548..8ea0fee80652 100644
> > > > > --- a/arch/riscv/include/asm/spinlock.h
> > > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > > @@ -7,11 +7,85 @@
> > > > >  #define _Q_PENDING_LOOPS (1 << 9)
> > > > >  #endif
> > > > >
> > > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > > +#include <asm-generic/ticket_spinlock.h>
> > > > > +
> > > > > +#undef arch_spin_is_locked
> > > > > +#undef arch_spin_is_contended
> > > > > +#undef arch_spin_value_unlocked
> > > > > +#undef arch_spin_lock
> > > > > +#undef arch_spin_trylock
> > > > > +#undef arch_spin_unlock
> > > > > +
> > > > > +#include <asm-generic/qspinlock.h>
> > > > > +#include <linux/jump_label.h>
> > > > > +
> > > > > +#undef arch_spin_is_locked
> > > > > +#undef arch_spin_is_contended
> > > > > +#undef arch_spin_value_unlocked
> > > > > +#undef arch_spin_lock
> > > > > +#undef arch_spin_trylock
> > > > > +#undef arch_spin_unlock
> > > > Sorry, I forgot __no_arch_spinlock_redefine advice here. I would add it in v12.
> > > > https://lore.kernel.org/linux-riscv/4cc7113a-0e4e-763a-cba2-7963bcd26c7a@redhat.com/
> > > >
> > >
> > > Please check a reply to a previous patch I sent earlier: I think these
> > > #undef can be avoided.
> > >
> > > > > +
> > > > > +DECLARE_STATIC_KEY_TRUE(combo_qspinlock_key);
> > > > > +
> > > > > +static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> > > > > +{
> > > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > > +         queued_spin_lock(lock);
> > > > > + else
> > > > > +         ticket_spin_lock(lock);
> > > > > +}
> > > > > +
> > > > > +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> > > > > +{
> > > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > > +         return queued_spin_trylock(lock);
> > > > > + else
> > > > > +         return ticket_spin_trylock(lock);
> > > > > +}
> > > > > +
> > > > > +static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> > > > > +{
> > > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > > +         queued_spin_unlock(lock);
> > > > > + else
> > > > > +         ticket_spin_unlock(lock);
> > > > > +}
> > > > > +
> > > > > +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> > > > > +{
> > > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > > +         return queued_spin_value_unlocked(lock);
> > > > > + else
> > > > > +         return ticket_spin_value_unlocked(lock);
> > > > > +}
> > > > > +
> > > > > +static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> > > > > +{
> > > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > > +         return queued_spin_is_locked(lock);
> > > > > + else
> > > > > +         return ticket_spin_is_locked(lock);
> > > > > +}
> > > > > +
> > > > > +static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> > > > > +{
> > > > > + if (static_branch_likely(&combo_qspinlock_key))
> > > > > +         return queued_spin_is_contended(lock);
> > > > > + else
> > > > > +         return ticket_spin_is_contended(lock);
> > > > > +}
> > > > > +#else /* CONFIG_RISCV_COMBO_SPINLOCKS */
> > > > > +
> >
> > Also, those functions all reproduce the same behavior, so maybe it would be
> > better to keep that behavior in a macro such as:
> >
> > #define COMBO_SPINLOCK_DECLARE(f)                                       \
> > static __always_inline int arch_spin_ ## f(arch_spinlock_t *lock)       \
> > {                                                                       \
> >         if (static_branch_likely(&combo_qspinlock_key))                 \
> >                 return queued_spin_ ## f(lock);                         \
> >         else                                                            \
> >                 return ticket_spin_ ## f(lock);                         \
> > }
> >
> > COMBO_SPINLOCK_DECLARE(lock)
> > COMBO_SPINLOCK_DECLARE(trylock)
> > COMBO_SPINLOCK_DECLARE(unlock)
> > COMBO_SPINLOCK_DECLARE(value_unlocked)
> > COMBO_SPINLOCK_DECLARE(is_locked)
> > COMBO_SPINLOCK_DECLARE(is_contended)
> >
> > Does that make sense?
> Yeah, thanks. I would try. You improved my macro skills. :)

Glad to be of any help :)

> 
> >
> > Thanks!
> > Leo
> >
> >
> > > > >  #ifdef CONFIG_QUEUED_SPINLOCKS
> > > > >  #include <asm/qspinlock.h>
> > > > > -#include <asm/qrwlock.h>
> > > > >  #else
> > > > > -#include <asm-generic/spinlock.h>
> > > > > +#include <asm-generic/ticket_spinlock.h>
> > > > >  #endif
> > > > >
> > > > > +#endif /* CONFIG_RISCV_COMBO_SPINLOCKS */
> > > > > +
> > > > > +#include <asm/qrwlock.h>
> > > > > +
> > > > >  #endif /* __ASM_RISCV_SPINLOCK_H */
> > > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > > index 32c2e1eb71bd..a447cf360a18 100644
> > > > > --- a/arch/riscv/kernel/setup.c
> > > > > +++ b/arch/riscv/kernel/setup.c
> > > > > @@ -269,6 +269,18 @@ static void __init parse_dtb(void)
> > > > >  #endif
> > > > >  }
> > > > >
> > > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > > +DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
> > > > > +EXPORT_SYMBOL(combo_qspinlock_key);
> > > > > +#endif
> > > > > +
> > > > > +static void __init riscv_spinlock_init(void)
> > > > > +{
> > > > > +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > > + static_branch_disable(&combo_qspinlock_key);
> > > > > +#endif
> > > > > +}
> > > > > +
> > > > >  extern void __init init_rt_signal_env(void);
> > > > >
> > > > >  void __init setup_arch(char **cmdline_p)
> > > > > @@ -317,6 +329,8 @@ void __init setup_arch(char **cmdline_p)
> > > > >       riscv_isa_extension_available(NULL, ZICBOM))
> > > > >           riscv_noncoherent_supported();
> > > > >   riscv_set_dma_cache_alignment();
> > > > > +
> > > > > + riscv_spinlock_init();
> > > > >  }
> > > > >
> > > > >  static int __init topology_init(void)
> > > > > --
> > > > > 2.36.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-riscv mailing list
> > > > > linux-riscv@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > >
> > > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


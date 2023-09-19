Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC2D7A5980
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 07:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjISFol (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 01:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjISFoj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 01:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F57E119
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 22:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695102226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTSOG5vcas4ed4C7wfNOCUDug4O+NGpJ/cBKsC8VzRo=;
        b=BNB08OGrwUXKLxEdeNFfwNr5Oo5HmxocbhktRbflFIc+s3HGVl9HptYTbV1oHLFo7SF0mc
        sWdYj24nbXQMtieY4sFDwMOMyU/2ectzUiU9f8LSxU+IHskKr/UYACYMx1hGgOa27MwW/m
        R/kUkK7bVUvOyu5Mf+dzyIVme6Ado1M=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-MFmK6XrROy-VaDlXU6S1PA-1; Tue, 19 Sep 2023 01:43:45 -0400
X-MC-Unique: MFmK6XrROy-VaDlXU6S1PA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ac97b9577cso7884473b6e.2
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 22:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102224; x=1695707024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTSOG5vcas4ed4C7wfNOCUDug4O+NGpJ/cBKsC8VzRo=;
        b=aTVY+HM2ID6ytnRsWEteRdu8Rd+NRsio+mEpW3tURC0glaHuSUqWVN746VqTwH+DIB
         K6RrFD+ik5TZA4JweQ07cM2cSo4ke9qrZqlAbno6OUibIvRQXZUhC6BSRQ0GVv4Z5gaO
         5NxclMzXNzlsPkScVCYma5UmmKJ5EQkSJ57TdvR0hxQeEnl3z8g+fRNV3HE2Wm3Sonck
         Ia3mQQec/KGbKaIrsNuVK9xMq+woO8YS6I5fcnqfl3B68Zy5kHUEPQCBg+fTrxcKSoKH
         ifObBdKNhbENK0RRoR1muSMiegRl2jHP24RVlm+9yuLo3ChcGQfEAjjZLi81SAfk8ocj
         zSoQ==
X-Gm-Message-State: AOJu0YzR0MIWCg4uNY/P/A3VYNq+JjDXNNu2CsauifObYybsJy7SxjhZ
        Y2+fbM5miJ/gZFBpwBz8xNDukX47JbVjHXgHuVTgk3HTOG+vsJswkVLdXBlqvye3+YpjqDavM4d
        tTCE0j6uKwEk5pi11/sFG0g==
X-Received: by 2002:a05:6808:1909:b0:3a7:146d:85b5 with SMTP id bf9-20020a056808190900b003a7146d85b5mr14206504oib.52.1695102224483;
        Mon, 18 Sep 2023 22:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmMlY/sjwzsYH/gvSbmjrdPliaDABVHiPcpvuJxlJeHOFs0hFsDQUqc0rMQct6bApbkrC7EQ==
X-Received: by 2002:a05:6808:1909:b0:3a7:146d:85b5 with SMTP id bf9-20020a056808190900b003a7146d85b5mr14206489oib.52.1695102224156;
        Mon, 18 Sep 2023 22:43:44 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:677d:42e9:f426:9422:f020])
        by smtp.gmail.com with ESMTPSA id b19-20020aca2213000000b003a724566afdsm1822141oic.20.2023.09.18.22.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:43:43 -0700 (PDT)
Date:   Tue, 19 Sep 2023 02:43:33 -0300
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
Subject: Re: [PATCH V11 11/17] RISC-V: paravirt: pvqspinlock: Add paravirt
 qspinlock skeleton
Message-ID: <ZQk1BauKTEkLq8UY@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-12-guoren@kernel.org>
 <ZQPuvCNq5IAYlMR6@redhat.com>
 <CAJF2gTR-CAw3nGPBfxszEOfOaPBxios3fSKiHXFVTG7LsCc+FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTR-CAw3nGPBfxszEOfOaPBxios3fSKiHXFVTG7LsCc+FQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 17, 2023 at 10:58:18PM +0800, Guo Ren wrote:
> On Fri, Sep 15, 2023 at 1:42 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Sun, Sep 10, 2023 at 04:29:05AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Using static_call to switch between:
> > >   native_queued_spin_lock_slowpath()    __pv_queued_spin_lock_slowpath()
> > >   native_queued_spin_unlock()           __pv_queued_spin_unlock()
> > >
> > > Finish the pv_wait implementation, but pv_kick needs the SBI
> > > definition of the next patches.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/include/asm/Kbuild               |  1 -
> > >  arch/riscv/include/asm/qspinlock.h          | 35 +++++++++++++
> > >  arch/riscv/include/asm/qspinlock_paravirt.h | 29 +++++++++++
> > >  arch/riscv/include/asm/spinlock.h           |  2 +-
> > >  arch/riscv/kernel/qspinlock_paravirt.c      | 57 +++++++++++++++++++++
> > >  arch/riscv/kernel/setup.c                   |  4 ++
> > >  6 files changed, 126 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/qspinlock.h
> > >  create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
> > >  create mode 100644 arch/riscv/kernel/qspinlock_paravirt.c
> > >
> > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> > > index a0dc85e4a754..b89cb3b73c13 100644
> > > --- a/arch/riscv/include/asm/Kbuild
> > > +++ b/arch/riscv/include/asm/Kbuild
> > > @@ -7,6 +7,5 @@ generic-y += parport.h
> > >  generic-y += spinlock_types.h
> > >  generic-y += qrwlock.h
> > >  generic-y += qrwlock_types.h
> > > -generic-y += qspinlock.h
> > >  generic-y += user.h
> > >  generic-y += vmlinux.lds.h
> > > diff --git a/arch/riscv/include/asm/qspinlock.h b/arch/riscv/include/asm/qspinlock.h
> > > new file mode 100644
> > > index 000000000000..7d4f416c908c
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/qspinlock.h
> > > @@ -0,0 +1,35 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c), 2023 Alibaba Cloud
> > > + * Authors:
> > > + *   Guo Ren <guoren@linux.alibaba.com>
> > > + */
> > > +
> > > +#ifndef _ASM_RISCV_QSPINLOCK_H
> > > +#define _ASM_RISCV_QSPINLOCK_H
> > > +
> > > +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> > > +#include <asm/qspinlock_paravirt.h>
> > > +
> > > +/* How long a lock should spin before we consider blocking */
> > > +#define SPIN_THRESHOLD               (1 << 15)
> > > +
> > > +void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> > > +void __pv_init_lock_hash(void);
> > > +void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> > > +
> > > +static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > > +{
> > > +     static_call(pv_queued_spin_lock_slowpath)(lock, val);
> > > +}
> > > +
> > > +#define queued_spin_unlock   queued_spin_unlock
> > > +static inline void queued_spin_unlock(struct qspinlock *lock)
> > > +{
> > > +     static_call(pv_queued_spin_unlock)(lock);
> > > +}
> > > +#endif /* CONFIG_PARAVIRT_SPINLOCKS */
> > > +
> > > +#include <asm-generic/qspinlock.h>
> > > +
> > > +#endif /* _ASM_RISCV_QSPINLOCK_H */
> > > diff --git a/arch/riscv/include/asm/qspinlock_paravirt.h b/arch/riscv/include/asm/qspinlock_paravirt.h
> > > new file mode 100644
> > > index 000000000000..9681e851f69d
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/qspinlock_paravirt.h
> > > @@ -0,0 +1,29 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (c), 2023 Alibaba Cloud
> > > + * Authors:
> > > + *   Guo Ren <guoren@linux.alibaba.com>
> > > + */
> > > +
> > > +#ifndef _ASM_RISCV_QSPINLOCK_PARAVIRT_H
> > > +#define _ASM_RISCV_QSPINLOCK_PARAVIRT_H
> > > +
> > > +void pv_wait(u8 *ptr, u8 val);
> > > +void pv_kick(int cpu);
> > > +
> > > +void dummy_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> > > +void dummy_queued_spin_unlock(struct qspinlock *lock);
> > > +
> > > +DECLARE_STATIC_CALL(pv_queued_spin_lock_slowpath, dummy_queued_spin_lock_slowpath);
> > > +DECLARE_STATIC_CALL(pv_queued_spin_unlock, dummy_queued_spin_unlock);
> > > +
> > > +void __init pv_qspinlock_init(void);
> > > +
> > > +static inline bool pv_is_native_spin_unlock(void)
> > > +{
> > > +     return false;
> > > +}
> > > +
> > > +void __pv_queued_spin_unlock(struct qspinlock *lock);
> > > +
> > > +#endif /* _ASM_RISCV_QSPINLOCK_PARAVIRT_H */
> > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > index 6b38d6616f14..ed4253f491fe 100644
> > > --- a/arch/riscv/include/asm/spinlock.h
> > > +++ b/arch/riscv/include/asm/spinlock.h
> > > @@ -39,7 +39,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
> > >  #undef arch_spin_trylock
> > >  #undef arch_spin_unlock
> > >
> > > -#include <asm-generic/qspinlock.h>
> > > +#include <asm/qspinlock.h>
> > >  #include <linux/jump_label.h>
> > >
> > >  #undef arch_spin_is_locked
> > > diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
> > > new file mode 100644
> > > index 000000000000..85ff5a3ec234
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> > > @@ -0,0 +1,57 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c), 2023 Alibaba Cloud
> > > + * Authors:
> > > + *   Guo Ren <guoren@linux.alibaba.com>
> > > + */
> > > +
> > > +#include <linux/static_call.h>
> > > +#include <asm/qspinlock_paravirt.h>
> > > +#include <asm/sbi.h>
> > > +
> > > +void pv_kick(int cpu)
> > > +{
> > > +     return;
> > > +}
> > > +
> > > +void pv_wait(u8 *ptr, u8 val)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     if (in_nmi())
> > > +             return;
> > > +
> > > +     local_irq_save(flags);
> > > +     if (READ_ONCE(*ptr) != val)
> > > +             goto out;
> > > +
> > > +     /* wait_for_interrupt(); */
> > > +out:
> > > +     local_irq_restore(flags);
> > > +}
> > > +
> > > +static void native_queued_spin_unlock(struct qspinlock *lock)
> > > +{
> > > +     smp_store_release(&lock->locked, 0);
> > > +}
> > > +
> > > +DEFINE_STATIC_CALL(pv_queued_spin_lock_slowpath, native_queued_spin_lock_slowpath);
> > > +EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
> > > +
> > > +DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
> > > +EXPORT_STATIC_CALL(pv_queued_spin_unlock);
> > > +
> > > +void __init pv_qspinlock_init(void)
> > > +{
> > > +     if (num_possible_cpus() == 1)
> > > +             return;
> > > +
> > > +     if(sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)
> >
> > Checks like this seem to be very common on this patchset.
> > For someone not much familiar with this, it can be hard to
> > understand.
> >
> > I mean, on patch 8/17 you introduce those IDs, which look to be
> > incremental ( ID == N includes stuff from ID < N ), but I am not sure as I
> > couln't find much documentation on that.
> It's from sbi spec:
> https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> 
> 0 Berkeley Boot Loader (BBL)
> 1 OpenSBI
> 2 Xvisor
> 3 KVM
> 4 RustSBI
> 5 Diosix
> 6 Coffer
> 7 Xen Project
> 8 PolarFire Hart Software Service

Oh, I see. Thanks for the reference!
Please also include the github link and/or the doc name into the commit 
file for future references :)

> 
> >
> > Then above you test for the id being different than
> > SBI_EXT_BASE_IMPL_ID_KVM, but if they are actually incremental and a new
> > version lands, the new version will also return early because it passes the
> > test.
> >
> > I am no sure if above is right, but it's all I could understand without
> > documentation.
> >
> > Well, my point is: this seems hard to understand & review, so it would be
> > nice to have a macro like this to be used instead:
> >
> > #define sbi_fw_implements_kvm() \
> >         (sbi_get_firmware_id() >= SBI_EXT_BASE_IMPL_ID_KVM)
> No, it's not correct. It must be:
> (sbi_get_firmware_id() == SBI_EXT_BASE_IMPL_ID_KVM)

Looking at the doc you provided, I think to be able to understand it.
The idea is to provide a code for given implementation of SBI, so in those 
tests you check if the SBI implementation being used is KVM, meaning it's a 
KVM guest. Ok, that makes sense now. Thanks!

> 
> >
> > if(!sbi_fw_implements_kvm())
> I'm okay with sbi_fw_implements_kvm().

Thanks! also, thanks again for sharing the doc!

With above suggestions, please feel free to include in next versions:

Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thx
Leo

> 
> >         return;
> >
> > What do you think?
> >
> > Other than that, LGTM.
> >
> > Thanks!
> > Leo
> >
> > > +             return;
> > > +
> > > +     pr_info("PV qspinlocks enabled\n");
> > > +     __pv_init_lock_hash();
> > > +
> > > +     static_call_update(pv_queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
> > > +     static_call_update(pv_queued_spin_unlock, __pv_queued_spin_unlock);
> > > +}
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index c57d15b05160..88690751f2ee 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -321,6 +321,10 @@ static void __init riscv_spinlock_init(void)
> > >  #ifdef CONFIG_QUEUED_SPINLOCKS
> > >       virt_spin_lock_init();
> > >  #endif
> > > +
> > > +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> > > +     pv_qspinlock_init();
> > > +#endif
> > >  }
> > >
> > >  extern void __init init_rt_signal_env(void);
> > > --
> > > 2.36.1
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


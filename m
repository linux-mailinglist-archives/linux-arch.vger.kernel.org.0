Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E07A66EF
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjISOla (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjISOl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 10:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A5BF
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695134442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPChRE0InNHskyWuIlJBmvoJuDPQjn2A/DI8CmLpn1E=;
        b=YFMxWCZ7hAZv2TrbDATkVkNWgyGfFq6WQnFWHkNIwSxrw8bSAnPVD/D2Pw+1AerWHA2IAb
        8ra9K5cJRBcqQIp1iC7yixqeVE7TDnvYGB43DvyNN/oqoK2PAKFkZ9jTOBO4f7YZtMoGsz
        88SIlqFzl1zqh0d6nB6a74RBkoGcXIo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-eM2xhJNPMd6m1q5wqOqhDA-1; Tue, 19 Sep 2023 10:40:41 -0400
X-MC-Unique: eM2xhJNPMd6m1q5wqOqhDA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a6e180e49aso10260249b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 07:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134440; x=1695739240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPChRE0InNHskyWuIlJBmvoJuDPQjn2A/DI8CmLpn1E=;
        b=C3jnacgd3DGUT49D4RQjHYAudUCbETrwzfnjdMwEuJP2VSk0mEw9laYbhVRF9ZWsuU
         5vz+5gPgBe5Oaaa/S4ekXWqMFRbv7fCGdu8wtHi8xnET7KjaajLGG7MZClPQL6MfGtfA
         KRehvXYn7WHZD2SBVbzLrlhZttn+lcRmrKSgWD94Xf2AYdUEH+jQ2aYOprqpD88AHvFv
         dHIPG09QYIMpprDTPPa+tMFxwYXVjH4sREQXR8yyEU6Tf1VRw9H3nTyv7TIr4LYhyTw4
         W2k06ayqfav2Gy45TjRM4RROOsBoKXd/yj8JQCGFvAprSj1n019qb3HTHdN6zgUBEgay
         lJnA==
X-Gm-Message-State: AOJu0Yz1Tt4xAKz6fj/BfoSBzOI9uRoFhWvrstXqaYnK1jueQ1agTDrC
        uX2RrFk7y3ltuhhSKIy7vpR7Ee9Izm5oc7hwJpLVK91xKJdxcWomPrNxXlwjMtSFY7CZDDPI/4p
        I6ps7Uva0sicv7toiBAh8aA==
X-Received: by 2002:a05:6808:d8:b0:3a8:3d5b:aade with SMTP id t24-20020a05680800d800b003a83d5baademr12451210oic.11.1695134440334;
        Tue, 19 Sep 2023 07:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSkvOndFbQ7dpCoHs9RSddftxcV1NJIc765Nd0Lagb/y1SbW2RB5TDPSCAW/F+t9cFXSStFA==
X-Received: by 2002:a05:6808:d8:b0:3a8:3d5b:aade with SMTP id t24-20020a05680800d800b003a83d5baademr12451180oic.11.1695134440062;
        Tue, 19 Sep 2023 07:40:40 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:677d:42e9:f426:9422:f020])
        by smtp.gmail.com with ESMTPSA id a3-20020a544e03000000b003a05ba0ccb2sm5439948oiy.39.2023.09.19.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:40:39 -0700 (PDT)
Date:   Tue, 19 Sep 2023 11:40:30 -0300
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
Subject: Re: [PATCH V11 08/17] riscv: qspinlock: Add virt_spin_lock() support
 for KVM guest
Message-ID: <ZQmy3uCE8gbk7f9z@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-9-guoren@kernel.org>
 <ZQK9-tn2MepXlY1u@redhat.com>
 <CAJF2gTR6USUQc7=TmFx+8HfhKa8whzb9qtNjLKR_FPZzN656Zg@mail.gmail.com>
 <ZQkx75LgsM3-UfaN@redhat.com>
 <CAJF2gTQeMv0-TLgpNpCsH1vbVVvQWOB=wGvZFZqJ5gSWLVCtrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQeMv0-TLgpNpCsH1vbVVvQWOB=wGvZFZqJ5gSWLVCtrw@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 04:04:48PM +0800, Guo Ren wrote:
> On Tue, Sep 19, 2023 at 1:30 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Sun, Sep 17, 2023 at 11:12:31PM +0800, Guo Ren wrote:
> > > On Thu, Sep 14, 2023 at 4:02 PM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > On Sun, Sep 10, 2023 at 04:29:02AM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > Add a static key controlling whether virt_spin_lock() should be
> > > > > called or not. When running on bare metal set the new key to
> > > > > false.
> > > > >
> > > > > The KVM guests fall back to a Test-and-Set spinlock, because fair
> > > > > locks have horrible lock 'holder' preemption issues. The
> > > > > virt_spin_lock_key would shortcut for the
> > > > > queued_spin_lock_slowpath() function that allow virt_spin_lock to
> > > > > hijack it.
> > > > >
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > ---
> > > > >  .../admin-guide/kernel-parameters.txt         |  4 +++
> > > > >  arch/riscv/include/asm/sbi.h                  |  8 +++++
> > > > >  arch/riscv/include/asm/spinlock.h             | 22 ++++++++++++++
> > > > >  arch/riscv/kernel/sbi.c                       |  2 +-
> > > > >  arch/riscv/kernel/setup.c                     | 30 ++++++++++++++++++-
> > > > >  5 files changed, 64 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > index 61cacb8dfd0e..f75bedc50e00 100644
> > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > @@ -3927,6 +3927,10 @@
> > > > >       no_uaccess_flush
> > > > >                       [PPC] Don't flush the L1-D cache after accessing user data.
> > > > >
> > > > > +     no_virt_spin    [RISC-V] Disable virt_spin_lock in KVM guest to use
> > > > > +                     native_queued_spinlock when the nopvspin option is enabled.
> > > > > +                     This would help vcpu=pcpu scenarios.
> > > > > +
> > > > >       novmcoredd      [KNL,KDUMP]
> > > > >                       Disable device dump. Device dump allows drivers to
> > > > >                       append dump data to vmcore so you can collect driver
> > > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > > > > index 501e06e52078..e0233b3d7a5f 100644
> > > > > --- a/arch/riscv/include/asm/sbi.h
> > > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > > @@ -50,6 +50,13 @@ enum sbi_ext_base_fid {
> > > > >       SBI_EXT_BASE_GET_MIMPID,
> > > > >  };
> > > > >
> > > > > +enum sbi_ext_base_impl_id {
> > > > > +     SBI_EXT_BASE_IMPL_ID_BBL = 0,
> > > > > +     SBI_EXT_BASE_IMPL_ID_OPENSBI,
> > > > > +     SBI_EXT_BASE_IMPL_ID_XVISOR,
> > > > > +     SBI_EXT_BASE_IMPL_ID_KVM,
> > > > > +};
> > > > > +
> > > > >  enum sbi_ext_time_fid {
> > > > >       SBI_EXT_TIME_SET_TIMER = 0,
> > > > >  };
> > > > > @@ -269,6 +276,7 @@ int sbi_console_getchar(void);
> > > > >  long sbi_get_mvendorid(void);
> > > > >  long sbi_get_marchid(void);
> > > > >  long sbi_get_mimpid(void);
> > > > > +long sbi_get_firmware_id(void);
> > > > >  void sbi_set_timer(uint64_t stime_value);
> > > > >  void sbi_shutdown(void);
> > > > >  void sbi_send_ipi(unsigned int cpu);
> > > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> > > > > index 8ea0fee80652..6b38d6616f14 100644
> > > > > --- a/arch/riscv/include/asm/spinlock.h
> > > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > > @@ -4,6 +4,28 @@
> > > > >  #define __ASM_RISCV_SPINLOCK_H
> > > > >
> > > > >  #ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > +/*
> > > > > + * The KVM guests fall back to a Test-and-Set spinlock, because fair locks
> > > > > + * have horrible lock 'holder' preemption issues. The virt_spin_lock_key
> > > > > + * would shortcut for the queued_spin_lock_slowpath() function that allow
> > > > > + * virt_spin_lock to hijack it.
> > > > > + */
> > > > > +DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > > +
> > > > > +#define virt_spin_lock virt_spin_lock
> > > > > +static inline bool virt_spin_lock(struct qspinlock *lock)
> > > > > +{
> > > > > +     if (!static_branch_likely(&virt_spin_lock_key))
> > > > > +             return false;
> > > > > +
> > > > > +     do {
> > > > > +             while (atomic_read(&lock->val) != 0)
> > > > > +                     cpu_relax();
> > > > > +     } while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
> > > > > +
> > > > > +     return true;
> > > > > +}
> > > > > +
> > > > >  #define _Q_PENDING_LOOPS     (1 << 9)
> > > > >  #endif
> > > > >
> > > > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > > > index 88eea3a99ee0..cdd45edc8db4 100644
> > > > > --- a/arch/riscv/kernel/sbi.c
> > > > > +++ b/arch/riscv/kernel/sbi.c
> > > > > @@ -555,7 +555,7 @@ static inline long sbi_get_spec_version(void)
> > > > >       return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
> > > > >  }
> > > > >
> > > > > -static inline long sbi_get_firmware_id(void)
> > > > > +long sbi_get_firmware_id(void)
> > > > >  {
> > > > >       return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
> > > > >  }
> > > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > > index 0f084f037651..c57d15b05160 100644
> > > > > --- a/arch/riscv/kernel/setup.c
> > > > > +++ b/arch/riscv/kernel/setup.c
> > > > > @@ -26,6 +26,7 @@
> > > > >  #include <asm/alternative.h>
> > > > >  #include <asm/cacheflush.h>
> > > > >  #include <asm/cpu_ops.h>
> > > > > +#include <asm/cpufeature.h>
> > > > >  #include <asm/early_ioremap.h>
> > > > >  #include <asm/pgtable.h>
> > > > >  #include <asm/setup.h>
> > > > > @@ -283,16 +284,43 @@ DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
> > > > >  EXPORT_SYMBOL(combo_qspinlock_key);
> > > > >  #endif
> > > > >
> > > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > +static bool no_virt_spin_key = false;
> > > >
> > > > I suggest no _key, also there is no need for "= false".
> > > > To be consistent with enable_qspinlock, I also suggest
> > > > adding __ro_after_init:
> > > >
> > > > static bool no_virt_spin __ro_after_init;
> > > okay.
> > >
> > > >
> > > >
> > > >
> > > > > +DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > > +
> > > > > +static int __init no_virt_spin_setup(char *p)
> > > > > +{
> > > > > +     no_virt_spin_key = true;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +early_param("no_virt_spin", no_virt_spin_setup);
> > > > > +
> > > > > +static void __init virt_spin_lock_init(void)
> > > > > +{
> > > > > +     if (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM ||
> > > > > +         no_virt_spin_key)
> > > > > +             static_branch_disable(&virt_spin_lock_key);
> > > > > +     else
> > > > > +             pr_info("Enable virt_spin_lock\n");
> > > > > +}
> > > > > +#endif
> > > > > +
> > > >
> > > > A new virt_no_spin kernel parameter was introduced, but without
> > > > CONFIG_QUEUED_SPINLOCKS it will silently fail.
> > > >
> > > > I would suggest an #else clause here with a function to print an error /
> > > > warning message about no_virt_spin being invalid in this scenario.
> > > > It will probably help future debugging.
> > > If CONFIG_QUEUED_SPINLOCKS=n, no_virt_spin should be quiet. The
> > > no_virt_spin is one path of qspinlock.
> >
> > IIUC having no_virt_spin being passed as parameter to a kernel with
> > CONFIG_QUEUED_SPINLOCKS=n is not supposed to have any warning this
> > parameter is useless.
> >
> > I was just thinking it would be nice to have this warning during debugging,
> > but if it's standard practice then I am ok with this.
> Yes, I think it's okay, e.g.,
> x86: early_param("hv_nopvspin", hv_parse_nopvspin);
> depends on CONFIG_PARAVIRT_SPINLOCKS=y

Okay then, thanks for sharing this info!

> 
> >
> > >
> > > >
> > > >
> > > > >  static void __init riscv_spinlock_init(void)
> > > > >  {
> > > > >  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > > -     if (!enable_qspinlock_key) {
> > > > > +     if (!enable_qspinlock_key &&
> > > > > +         (sbi_get_firmware_id() != SBI_EXT_BASE_IMPL_ID_KVM)) {
> > > > >               static_branch_disable(&combo_qspinlock_key);
> > > > >               pr_info("Ticket spinlock: enabled\n");
> > > > >       } else {
> > > > >               pr_info("Queued spinlock: enabled\n");
> > > > >       }
> > > > >  #endif
> > > > > +
> > > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > > +     virt_spin_lock_init();
> > > > > +#endif
> > > > >  }
> > > > >
> > > > >  extern void __init init_rt_signal_env(void);
> > > > > --
> > > > > 2.36.1
> > > > >
> > > >
> > > > I am probably missing something out, but it looks to me that this patch is
> > > > causing 2 different changes:
> > > > 1 - Enabling no_virt_spin parameter
> > > > 2 - Disabling queued spinlocks for some firmware_id
> > > >
> > > > Wouldn't be better to split those changes in multiple patches?
> > > > Or am I missing the point on why they need to be together?
> >
> > ^ Want your input on this
> Sorry, I missed that. Okay, I would split those changes.

Thanks!
Leo

> 
> >
> > Thanks!
> > Leo
> >
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 


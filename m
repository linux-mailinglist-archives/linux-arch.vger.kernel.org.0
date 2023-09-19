Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172B7A5BE9
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjISIFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 04:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjISIFI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 04:05:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF78114;
        Tue, 19 Sep 2023 01:05:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5055BC433A9;
        Tue, 19 Sep 2023 08:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695110701;
        bh=ux92ZFIl+UVDJmfeDZDd/6odlGPBGL+ovTd2t4eLtJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lt967eWpriERZoqUkW/Trz/9DdKfZ/08NURCoPKW+JEgtWSiZBiMeAQFCv0T/xpu5
         D1+Aj36vehP4jlLQBqNw75o1YqswRCUyrZWDGANMdRsNaC4e/K7noFW/s6fgHhnzai
         4lSlqBSTaTipEw91BMq+rjEBB/u7hqRMI+l+atfqANLJuJEHEbpVIswY6If2GsKsNM
         yenbic+tiGf+kW1nXsWA4rhOY9S+IQ9yeRBFaWsJAH6wjERiQRMqvPPUe/C7bmrV8j
         45zsDyApICwGHxQ2b8s1RJ8wgde+4/+2WpBOsbzMyYCtu0ELsYtldGcuCMUzOhns3b
         dtGnbLddx7svQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso6587791a12.0;
        Tue, 19 Sep 2023 01:05:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzespVpl2PAutBtGlZaK1+exhsCUtWSNAykzy539V+LCPjq/I6g
        y5M9UC2MfornyKyY4fbIOEHgvxHt4xRqZGcdvDI=
X-Google-Smtp-Source: AGHT+IE+uOAYEaFaCDwXGqlFezUzsq7F+4Yo0khTn2b6rhEvE4B+rDXlNvlNiCXQWz/cM9l+b31a6nWamlEya138VQ8=
X-Received: by 2002:aa7:c6ce:0:b0:530:7abf:3a84 with SMTP id
 b14-20020aa7c6ce000000b005307abf3a84mr9414264eds.25.1695110699616; Tue, 19
 Sep 2023 01:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-9-guoren@kernel.org>
 <ZQK9-tn2MepXlY1u@redhat.com> <CAJF2gTR6USUQc7=TmFx+8HfhKa8whzb9qtNjLKR_FPZzN656Zg@mail.gmail.com>
 <ZQkx75LgsM3-UfaN@redhat.com>
In-Reply-To: <ZQkx75LgsM3-UfaN@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Sep 2023 16:04:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQeMv0-TLgpNpCsH1vbVVvQWOB=wGvZFZqJ5gSWLVCtrw@mail.gmail.com>
Message-ID: <CAJF2gTQeMv0-TLgpNpCsH1vbVVvQWOB=wGvZFZqJ5gSWLVCtrw@mail.gmail.com>
Subject: Re: [PATCH V11 08/17] riscv: qspinlock: Add virt_spin_lock() support
 for KVM guest
To:     Leonardo Bras <leobras@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 19, 2023 at 1:30=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Sun, Sep 17, 2023 at 11:12:31PM +0800, Guo Ren wrote:
> > On Thu, Sep 14, 2023 at 4:02=E2=80=AFPM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > On Sun, Sep 10, 2023 at 04:29:02AM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Add a static key controlling whether virt_spin_lock() should be
> > > > called or not. When running on bare metal set the new key to
> > > > false.
> > > >
> > > > The KVM guests fall back to a Test-and-Set spinlock, because fair
> > > > locks have horrible lock 'holder' preemption issues. The
> > > > virt_spin_lock_key would shortcut for the
> > > > queued_spin_lock_slowpath() function that allow virt_spin_lock to
> > > > hijack it.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > ---
> > > >  .../admin-guide/kernel-parameters.txt         |  4 +++
> > > >  arch/riscv/include/asm/sbi.h                  |  8 +++++
> > > >  arch/riscv/include/asm/spinlock.h             | 22 ++++++++++++++
> > > >  arch/riscv/kernel/sbi.c                       |  2 +-
> > > >  arch/riscv/kernel/setup.c                     | 30 +++++++++++++++=
+++-
> > > >  5 files changed, 64 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > > > index 61cacb8dfd0e..f75bedc50e00 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -3927,6 +3927,10 @@
> > > >       no_uaccess_flush
> > > >                       [PPC] Don't flush the L1-D cache after access=
ing user data.
> > > >
> > > > +     no_virt_spin    [RISC-V] Disable virt_spin_lock in KVM guest =
to use
> > > > +                     native_queued_spinlock when the nopvspin opti=
on is enabled.
> > > > +                     This would help vcpu=3Dpcpu scenarios.
> > > > +
> > > >       novmcoredd      [KNL,KDUMP]
> > > >                       Disable device dump. Device dump allows drive=
rs to
> > > >                       append dump data to vmcore so you can collect=
 driver
> > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/=
sbi.h
> > > > index 501e06e52078..e0233b3d7a5f 100644
> > > > --- a/arch/riscv/include/asm/sbi.h
> > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > @@ -50,6 +50,13 @@ enum sbi_ext_base_fid {
> > > >       SBI_EXT_BASE_GET_MIMPID,
> > > >  };
> > > >
> > > > +enum sbi_ext_base_impl_id {
> > > > +     SBI_EXT_BASE_IMPL_ID_BBL =3D 0,
> > > > +     SBI_EXT_BASE_IMPL_ID_OPENSBI,
> > > > +     SBI_EXT_BASE_IMPL_ID_XVISOR,
> > > > +     SBI_EXT_BASE_IMPL_ID_KVM,
> > > > +};
> > > > +
> > > >  enum sbi_ext_time_fid {
> > > >       SBI_EXT_TIME_SET_TIMER =3D 0,
> > > >  };
> > > > @@ -269,6 +276,7 @@ int sbi_console_getchar(void);
> > > >  long sbi_get_mvendorid(void);
> > > >  long sbi_get_marchid(void);
> > > >  long sbi_get_mimpid(void);
> > > > +long sbi_get_firmware_id(void);
> > > >  void sbi_set_timer(uint64_t stime_value);
> > > >  void sbi_shutdown(void);
> > > >  void sbi_send_ipi(unsigned int cpu);
> > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include=
/asm/spinlock.h
> > > > index 8ea0fee80652..6b38d6616f14 100644
> > > > --- a/arch/riscv/include/asm/spinlock.h
> > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > @@ -4,6 +4,28 @@
> > > >  #define __ASM_RISCV_SPINLOCK_H
> > > >
> > > >  #ifdef CONFIG_QUEUED_SPINLOCKS
> > > > +/*
> > > > + * The KVM guests fall back to a Test-and-Set spinlock, because fa=
ir locks
> > > > + * have horrible lock 'holder' preemption issues. The virt_spin_lo=
ck_key
> > > > + * would shortcut for the queued_spin_lock_slowpath() function tha=
t allow
> > > > + * virt_spin_lock to hijack it.
> > > > + */
> > > > +DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > +
> > > > +#define virt_spin_lock virt_spin_lock
> > > > +static inline bool virt_spin_lock(struct qspinlock *lock)
> > > > +{
> > > > +     if (!static_branch_likely(&virt_spin_lock_key))
> > > > +             return false;
> > > > +
> > > > +     do {
> > > > +             while (atomic_read(&lock->val) !=3D 0)
> > > > +                     cpu_relax();
> > > > +     } while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) !=3D 0)=
;
> > > > +
> > > > +     return true;
> > > > +}
> > > > +
> > > >  #define _Q_PENDING_LOOPS     (1 << 9)
> > > >  #endif
> > > >
> > > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > > index 88eea3a99ee0..cdd45edc8db4 100644
> > > > --- a/arch/riscv/kernel/sbi.c
> > > > +++ b/arch/riscv/kernel/sbi.c
> > > > @@ -555,7 +555,7 @@ static inline long sbi_get_spec_version(void)
> > > >       return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
> > > >  }
> > > >
> > > > -static inline long sbi_get_firmware_id(void)
> > > > +long sbi_get_firmware_id(void)
> > > >  {
> > > >       return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
> > > >  }
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index 0f084f037651..c57d15b05160 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -26,6 +26,7 @@
> > > >  #include <asm/alternative.h>
> > > >  #include <asm/cacheflush.h>
> > > >  #include <asm/cpu_ops.h>
> > > > +#include <asm/cpufeature.h>
> > > >  #include <asm/early_ioremap.h>
> > > >  #include <asm/pgtable.h>
> > > >  #include <asm/setup.h>
> > > > @@ -283,16 +284,43 @@ DEFINE_STATIC_KEY_TRUE(combo_qspinlock_key);
> > > >  EXPORT_SYMBOL(combo_qspinlock_key);
> > > >  #endif
> > > >
> > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > +static bool no_virt_spin_key =3D false;
> > >
> > > I suggest no _key, also there is no need for "=3D false".
> > > To be consistent with enable_qspinlock, I also suggest
> > > adding __ro_after_init:
> > >
> > > static bool no_virt_spin __ro_after_init;
> > okay.
> >
> > >
> > >
> > >
> > > > +DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
> > > > +
> > > > +static int __init no_virt_spin_setup(char *p)
> > > > +{
> > > > +     no_virt_spin_key =3D true;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +early_param("no_virt_spin", no_virt_spin_setup);
> > > > +
> > > > +static void __init virt_spin_lock_init(void)
> > > > +{
> > > > +     if (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM ||
> > > > +         no_virt_spin_key)
> > > > +             static_branch_disable(&virt_spin_lock_key);
> > > > +     else
> > > > +             pr_info("Enable virt_spin_lock\n");
> > > > +}
> > > > +#endif
> > > > +
> > >
> > > A new virt_no_spin kernel parameter was introduced, but without
> > > CONFIG_QUEUED_SPINLOCKS it will silently fail.
> > >
> > > I would suggest an #else clause here with a function to print an erro=
r /
> > > warning message about no_virt_spin being invalid in this scenario.
> > > It will probably help future debugging.
> > If CONFIG_QUEUED_SPINLOCKS=3Dn, no_virt_spin should be quiet. The
> > no_virt_spin is one path of qspinlock.
>
> IIUC having no_virt_spin being passed as parameter to a kernel with
> CONFIG_QUEUED_SPINLOCKS=3Dn is not supposed to have any warning this
> parameter is useless.
>
> I was just thinking it would be nice to have this warning during debuggin=
g,
> but if it's standard practice then I am ok with this.
Yes, I think it's okay, e.g.,
x86: early_param("hv_nopvspin", hv_parse_nopvspin);
depends on CONFIG_PARAVIRT_SPINLOCKS=3Dy

>
> >
> > >
> > >
> > > >  static void __init riscv_spinlock_init(void)
> > > >  {
> > > >  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > > -     if (!enable_qspinlock_key) {
> > > > +     if (!enable_qspinlock_key &&
> > > > +         (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)) {
> > > >               static_branch_disable(&combo_qspinlock_key);
> > > >               pr_info("Ticket spinlock: enabled\n");
> > > >       } else {
> > > >               pr_info("Queued spinlock: enabled\n");
> > > >       }
> > > >  #endif
> > > > +
> > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > +     virt_spin_lock_init();
> > > > +#endif
> > > >  }
> > > >
> > > >  extern void __init init_rt_signal_env(void);
> > > > --
> > > > 2.36.1
> > > >
> > >
> > > I am probably missing something out, but it looks to me that this pat=
ch is
> > > causing 2 different changes:
> > > 1 - Enabling no_virt_spin parameter
> > > 2 - Disabling queued spinlocks for some firmware_id
> > >
> > > Wouldn't be better to split those changes in multiple patches?
> > > Or am I missing the point on why they need to be together?
>
> ^ Want your input on this
Sorry, I missed that. Okay, I would split those changes.

>
> Thanks!
> Leo
>
> > >
> > > Thanks!
> > > Leo
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren

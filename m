Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6987A3608
	for <lists+linux-arch@lfdr.de>; Sun, 17 Sep 2023 17:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjIQPHb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Sep 2023 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjIQPHI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Sep 2023 11:07:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9928B6;
        Sun, 17 Sep 2023 08:07:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB9C433AD;
        Sun, 17 Sep 2023 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694963222;
        bh=uPJ5RfMmvHKK1Dw4GtfSI+98f15rrKi1ZGs6Fsv2hGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dgeVYLbhvP0wGfho9LXfIV61SUy6g3IFu2TN0XARzuisadkm2lSUqA/5Hy0IHMU9U
         TH3J6FTnEfr7YP9sImKe6F1AUUfwzBQWRL/YOTNkrYZvFqgMNMcfdr5zvBAzF/rJHJ
         ysiEuOQHAYEVo78g1KnAF7ZMZta3/VGOKEyvCNltBO0wxT/NmCo9GKaBvHsR+9HBnH
         f50ROh9FSot9f04o8KHNe83gfskA0lO7alVKIEleGCLugr6xXyWkGkO7lkgC0ZkV4o
         UlYyuDCLKRFnIjUUrtY1hd4Y6lZuqsZF52CmwEODndVHIg+Y/mZzN39hNlUFwaYnSG
         l2hgbq2TYHDiA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a9cd066db5so485641566b.0;
        Sun, 17 Sep 2023 08:07:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxkqIkpdO/otkIsLXMQKsE0bc19QAzk92uHAzTzP/GIQVZHxvVu
        MqDUIMER9keXdDC15Ah+nokbj2C6PzKcfIxaD30=
X-Google-Smtp-Source: AGHT+IEo06GeZj87fmcUeNBkBoXnXuEAiq0PrBqIKyMwrBO3S6Kp3wzR8JVXpu32F7fYkN9L8OCd75KsrJk3bf+/R10=
X-Received: by 2002:a17:906:20d4:b0:9a9:d5dd:dacd with SMTP id
 c20-20020a17090620d400b009a9d5dddacdmr6117465ejc.26.1694963220748; Sun, 17
 Sep 2023 08:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-14-guoren@kernel.org>
 <ZQP4SXLf00IntVWd@redhat.com>
In-Reply-To: <ZQP4SXLf00IntVWd@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Sep 2023 23:06:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTBwFKjVOovMHB171s+nymL88OANpS3O-uwKBLxto43mA@mail.gmail.com>
Message-ID: <CAJF2gTTBwFKjVOovMHB171s+nymL88OANpS3O-uwKBLxto43mA@mail.gmail.com>
Subject: Re: [PATCH V11 13/17] RISC-V: paravirt: pvqspinlock: Add SBI implementation
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

On Fri, Sep 15, 2023 at 2:23=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Sun, Sep 10, 2023 at 04:29:07AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement pv_kick with SBI implementation, and add SBI_EXT_PVLOCK
> > extension detection.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/sbi.h           | 6 ++++++
> >  arch/riscv/kernel/qspinlock_paravirt.c | 7 ++++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index e0233b3d7a5f..3533f8d4f3e2 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -30,6 +30,7 @@ enum sbi_ext_id {
> >       SBI_EXT_HSM =3D 0x48534D,
> >       SBI_EXT_SRST =3D 0x53525354,
> >       SBI_EXT_PMU =3D 0x504D55,
> > +     SBI_EXT_PVLOCK =3D 0xAB0401,
> >
> >       /* Experimentals extensions must lie within this range */
> >       SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> > @@ -243,6 +244,11 @@ enum sbi_pmu_ctr_type {
> >  /* Flags defined for counter stop function */
> >  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> >
> > +/* SBI PVLOCK (kick cpu out of wfi) */
> > +enum sbi_ext_pvlock_fid {
> > +     SBI_EXT_PVLOCK_KICK_CPU =3D 0,
> > +};
> > +
> >  #define SBI_SPEC_VERSION_DEFAULT     0x1
> >  #define SBI_SPEC_VERSION_MAJOR_SHIFT 24
> >  #define SBI_SPEC_VERSION_MAJOR_MASK  0x7f
> > diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel=
/qspinlock_paravirt.c
> > index a0ad4657f437..571626f350be 100644
> > --- a/arch/riscv/kernel/qspinlock_paravirt.c
> > +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> > @@ -11,6 +11,8 @@
> >
> >  void pv_kick(int cpu)
> >  {
> > +     sbi_ecall(SBI_EXT_PVLOCK, SBI_EXT_PVLOCK_KICK_CPU,
> > +               cpuid_to_hartid_map(cpu), 0, 0, 0, 0, 0);
> >       return;
> >  }
> >
> > @@ -25,7 +27,7 @@ void pv_wait(u8 *ptr, u8 val)
> >       if (READ_ONCE(*ptr) !=3D val)
> >               goto out;
> >
> > -     /* wait_for_interrupt(); */
> > +     wait_for_interrupt();
> >  out:
> >       local_irq_restore(flags);
> >  }
> > @@ -62,6 +64,9 @@ void __init pv_qspinlock_init(void)
> >       if(sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)
> >               return;
> >
> > +     if (!sbi_probe_extension(SBI_EXT_PVLOCK))
> > +             return;
> > +
> >       pr_info("PV qspinlocks enabled\n");
> >       __pv_init_lock_hash();
> >
> > --
> > 2.36.1
> >
>
> IIUC this PVLOCK extension is now a requirement to use pv_qspinlock(), an=
d
> it allows a cpu to use an instruction to wait for interrupt in pv_wait(),
> and kicks it out of this wait using a new sbi_ecall() on pv_kick().
Yes.

>
> Overall it LGTM, but would be nice to have the reference doc in the commi=
t
> msg. I end up inferring some of the inner workings by your implementation=
,
> which is not ideal for reviewing.
I would improve the commit msg in the next version of patch.

>
> If understanding above is right,
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
>
> Thanks!
> Leo
>


--=20
Best Regards
 Guo Ren

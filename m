Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2E7A3603
	for <lists+linux-arch@lfdr.de>; Sun, 17 Sep 2023 17:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjIQPET (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Sep 2023 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbjIQPDt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Sep 2023 11:03:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4113B13E;
        Sun, 17 Sep 2023 08:03:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4387C43391;
        Sun, 17 Sep 2023 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694963023;
        bh=U6gzi/H/haf5kt9PcJpUWoeEHC4CJCR4lpWm4En9f7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S0xWtcZWnba4obYh0068sGQ66IWZl2fmtLZZp1wFW8zqcsewLJ02o6ZqG3rN6PbjO
         2pM1q0qL4IUFA9QBU70CxqrSkEjWGZgXpURffMhww1TyJTczuSxZIWbpERxhpgHIlY
         WKeS+apsTJD6Sybvg8ZzrbRGXy9JyAYiBtTppF9w7mqX7+H0EWzEQm22wd2rd/+Ucw
         aGMMfNb5hpUGbyJhJ9k+/8XamAb4FJYnP1nhEUGtFxnnk6S+DuWa5l5Pg5obCSvJpO
         aKothsGzx8U+7zKcIfROtXAfwfYJRx5LV3eFxsXfBsrhoZilNgXeKvztNlJCOtkSvA
         YWLQ+NJS175wg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so4554794a12.2;
        Sun, 17 Sep 2023 08:03:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTbpgZ7y2TGyAC4GK6i2RPDSRNtIwVK3ocXJ5HDr7HWEatVuRH
        xiZGIfJOZIIrIL1rfR6Do7h6zSCduKQuVzE1iNA=
X-Google-Smtp-Source: AGHT+IGC2NhuzaJiU15MVNfQzo+WjISHQF1PH5bt2TC3OQQ17M0SeWPf6Cv0qt75lmZG9MWNIHP06ql/70uxG80Bm1A=
X-Received: by 2002:a17:906:196:b0:9a1:be5b:f499 with SMTP id
 22-20020a170906019600b009a1be5bf499mr5650894ejb.24.1694963022087; Sun, 17 Sep
 2023 08:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-13-guoren@kernel.org>
 <ZQP0EJc4ClA-iT6J@redhat.com>
In-Reply-To: <ZQP0EJc4ClA-iT6J@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Sep 2023 23:03:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQMNu7PXf3JT-nZt1+jp6osqERUvnvEexjK+Ak=ahxcUA@mail.gmail.com>
Message-ID: <CAJF2gTQMNu7PXf3JT-nZt1+jp6osqERUvnvEexjK+Ak=ahxcUA@mail.gmail.com>
Subject: Re: [PATCH V11 12/17] RISC-V: paravirt: pvqspinlock: Add nopvspin
 kernel parameter
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

On Fri, Sep 15, 2023 at 2:05=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Sun, Sep 10, 2023 at 04:29:06AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Disables the qspinlock slow path using PV optimizations which
> > allow the hypervisor to 'idle' the guest on lock contention.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  2 +-
> >  arch/riscv/kernel/qspinlock_paravirt.c          | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index f75bedc50e00..e74aed631573 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3857,7 +3857,7 @@
> >                       as generic guest with no PV drivers. Currently su=
pport
> >                       XEN HVM, KVM, HYPER_V and VMWARE guest.
> >
> > -     nopvspin        [X86,XEN,KVM]
> > +     nopvspin        [X86,XEN,KVM,RISC-V]
> >                       Disables the qspinlock slow path using PV optimiz=
ations
> >                       which allow the hypervisor to 'idle' the guest on=
 lock
> >                       contention.
> > diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel=
/qspinlock_paravirt.c
> > index 85ff5a3ec234..a0ad4657f437 100644
> > --- a/arch/riscv/kernel/qspinlock_paravirt.c
> > +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> > @@ -41,8 +41,21 @@ EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
> >  DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
> >  EXPORT_STATIC_CALL(pv_queued_spin_unlock);
> >
> > +static bool nopvspin;
>
> It is only used in init, so it makes sense to add __initdata.
>
> static bool nopvspin __initdata;
Okay.

>
> Other than that, LGTM:
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
>
> Thanks!
> Leo
>
> > +static __init int parse_nopvspin(char *arg)
> > +{
> > +       nopvspin =3D true;
> > +       return 0;
> > +}
> > +early_param("nopvspin", parse_nopvspin);
> > +
> >  void __init pv_qspinlock_init(void)
> >  {
> > +     if (nopvspin) {
> > +             pr_info("PV qspinlocks disabled\n");
> > +             return;
> > +     }
> > +
> >       if (num_possible_cpus() =3D=3D 1)
> >               return;
> >
> > --
> > 2.36.1
> >
>


--=20
Best Regards
 Guo Ren

Return-Path: <linux-arch+bounces-4410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F588C5F90
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 06:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4F81F21DB4
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 04:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCE381DF;
	Wed, 15 May 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITF2Lvvg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41115381B9;
	Wed, 15 May 2024 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745742; cv=none; b=oNkri9QXp4S0qIHkZG7gHPinUIk3OObIEN9Xh9dJewf3jCR9iQDInRbaFdawU3ktQjs65yhFAcVbaN/saniSrGcA1Kq/hzMeT6Soh5wD/6Upid6rThvrQaZVU+CEYeTC63BJXbeEL16VpbUB8iE2J0hvsrNJSgGpCs14qGXNgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745742; c=relaxed/simple;
	bh=lT5q3mXPrun9LHTO8RE2O2wpJSl3sK3pCQrgTm+Oq1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5tOJx13YWpObAOVa7IizH+xD4woH7tkurRbH3kY7ZGkBx1V/zaxnlRsY0tz+2f5E2Du6v7AzY4hqfmoWvPK3emeydpTLZ4cDITdoJBEEECpBJ+BzC3iRFXMt23Mq5xhZNHS94oPyAaQLIyl23Is+pCQhXtW1Z3Yp0YaZQC2R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITF2Lvvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BEFC2BD11;
	Wed, 15 May 2024 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715745741;
	bh=lT5q3mXPrun9LHTO8RE2O2wpJSl3sK3pCQrgTm+Oq1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ITF2LvvgH9XNwTQSy8f7O1XroJLfTGlGBL8NQ6g/ORIbTxgfAFJcti4EmDVqzA22s
	 wMxsS7kKTRsYkaSGcjGK7f2OBl2SmiXXRHLJMI3tkj1oLUYJWNi6tjgCZPq13IAxuq
	 TBIQ6yzdC8rzm8q56LP8OeZGK7+B57u+nHsefJeB2z/QH0+uWA4ApXg11E3EK44K4t
	 IL2L9svtUSAHqsZagaWX8dSp1vWQzZMECn2i/L99TruFEKS2z2mra6Qc7MyeTQ83Ni
	 TYbR81NgUIg6zNfti0YUK10VYeYsG/xVSiWsiDTjpQOs9uF1bgJygTgLXIzL0yIVrx
	 ZNx9xtJe2Qw2w==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c0a6415fso117172466b.1;
        Tue, 14 May 2024 21:02:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXJyLXchY864SZZPO5iTEvxuNMJf6kyROMkvh4AKGuJW8rqHZYN40okl0H/kMHlmQlTxLR6+KBak/CaD/RULgwCb5CvsWdblQ0ejTm0KYenJToEqi+ps7tgFFTjnzA6PtIE2sN1HBXKA==
X-Gm-Message-State: AOJu0YwhDvn56lG7Kc9m23+tRhzLAyXRbgrtFvh3/x4KKuINHnPWVBqg
	F+XwmnWH+1301N4sPJQbSWm2OvEnKidm3BqcfImAddkoch3TERQj/ZZZew10CkCl31nEs64e9PW
	wkARaQeRW6pmJNbrP8oOFKP15gC4=
X-Google-Smtp-Source: AGHT+IEx4oHvQwWFrIB1BWq6dR8pw2BNnCNln3c2zUX1RE7casnYGER5I5yWQ5M/BPFrJA67Huk4s2V7VQXi0D/Kyk0=
X-Received: by 2002:a17:906:852:b0:a59:aa0d:6d with SMTP id
 a640c23a62f3a-a5a2d6287b5mr889245266b.62.1715745740285; Tue, 14 May 2024
 21:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514073232.3694867-1-chenhuacai@loongson.cn>
 <CAJF2gTTUmpm+aTQL7gNyLEe57X=v-it3MT5TOCViCOEiEyraBA@mail.gmail.com>
 <CAAhV-H6_KuRhqja=NKcGWQeJfaJfEZZ9pEy+4+_Vov690agrZA@mail.gmail.com> <CAJF2gTRC9-sabTWOyFL+fw8+tFYfyHJo-4ZHS=byB-wzmJM8jQ@mail.gmail.com>
In-Reply-To: <CAJF2gTRC9-sabTWOyFL+fw8+tFYfyHJo-4ZHS=byB-wzmJM8jQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 15 May 2024 12:02:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4icr=9cgD_doqeh2h9+2s3e5V1OeOy-j1oxaZiTW5jBw@mail.gmail.com>
Message-ID: <CAAhV-H4icr=9cgD_doqeh2h9+2s3e5V1OeOy-j1oxaZiTW5jBw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add irq_work support via self IPIs
To: Guo Ren <guoren@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:21=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, May 14, 2024 at 7:14=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Ren,
> >
> > On Tue, May 14, 2024 at 6:11=E2=80=AFPM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > > On Tue, May 14, 2024 at 3:32=E2=80=AFPM Huacai Chen <chenhuacai@loong=
son.cn> wrote:
> > > >
> > > > Add irq_work support for LoongArch via self IPIs. This make it poss=
ible
> > > > to run works in hardware interrupt context, which is a prerequisite=
 for
> > > > NOHZ_FULL.
> > > >
> > > > Implement:
> > > >  - arch_irq_work_raise()
> > > >  - arch_irq_work_has_interrupt()
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  arch/loongarch/include/asm/hardirq.h  |  3 ++-
> > > >  arch/loongarch/include/asm/irq_work.h | 10 ++++++++++
> > > >  arch/loongarch/include/asm/smp.h      |  2 ++
> > > >  arch/loongarch/kernel/paravirt.c      |  6 ++++++
> > > >  arch/loongarch/kernel/smp.c           | 14 ++++++++++++++
> > > >  5 files changed, 34 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/loongarch/include/asm/irq_work.h
> > > >
> > > > diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/=
include/asm/hardirq.h
> > > > index d41138abcf26..1d7feb719515 100644
> > > > --- a/arch/loongarch/include/asm/hardirq.h
> > > > +++ b/arch/loongarch/include/asm/hardirq.h
> > > > @@ -12,11 +12,12 @@
> > > >  extern void ack_bad_irq(unsigned int irq);
> > > >  #define ack_bad_irq ack_bad_irq
> > > >
> > > > -#define NR_IPI 2
> > > > +#define NR_IPI 3
> > > >
> > > >  enum ipi_msg_type {
> > > >         IPI_RESCHEDULE,
> > > >         IPI_CALL_FUNCTION,
> > > > +       IPI_IRQ_WORK,
> > > >  };
> > > >
> > > >  typedef struct {
> > > > diff --git a/arch/loongarch/include/asm/irq_work.h b/arch/loongarch=
/include/asm/irq_work.h
> > > > new file mode 100644
> > > > index 000000000000..d63076e9160d
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/include/asm/irq_work.h
> > > > @@ -0,0 +1,10 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _ASM_LOONGARCH_IRQ_WORK_H
> > > > +#define _ASM_LOONGARCH_IRQ_WORK_H
> > > > +
> > > > +static inline bool arch_irq_work_has_interrupt(void)
> > > > +{
> > > > +       return IS_ENABLED(CONFIG_SMP);
> > > I think it is "return true," or it will cause the warning.
> > No, HZ_FULL depends on SMP, if you force to enable it on UP, the
> > timekeeping will boom.
> > On the other hand, let the function return true will cause build
> > errors, see commit d2f3acde3d52b3b351db09e2e2a5e581 ("riscv: Fix
> > irq_work when SMP is disabled").
> Sorry, I misunderstood.
>
> But it is not a build error. Quote:
Sorry, I misunderstood, too.

Huacai
>
> This was found while bringing up cpufreq on D1. Switching cpufreq
> governors was hanging on irq_work_sync().
>
> /*
>  * Synchronize against the irq_work @entry, ensures the entry is not
>  * currently in use.
>  */
> void irq_work_sync(struct irq_work *work)
> {
>         lockdep_assert_irqs_enabled();
>         might_sleep();
>
>         if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
>             !arch_irq_work_has_interrupt()) {
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work=
),
>                                    TASK_UNINTERRUPTIBLE);
>                 return;
>         }
>
>
> >
> > Huacai
> >
> > >
> > > void __init tick_nohz_init(void)
> > > {
> > >         int cpu, ret;
> > >
> > >         if (!tick_nohz_full_running)
> > >                 return;
> > >
> > >         /*
> > >          * Full dynticks uses IRQ work to drive the tick rescheduling=
 on safe
> > >          * locking contexts. But then we need IRQ work to raise its o=
wn
> > >          * interrupts to avoid circular dependency on the tick.
> > >          */
> > >         if (!arch_irq_work_has_interrupt()) {
> > >                 pr_warn("NO_HZ: Can't run full dynticks because arch
> > > doesn't support IRQ work self-IPIs\n");
> > >                 cpumask_clear(tick_nohz_full_mask);
> > >                 tick_nohz_full_running =3D false;
> > >                 return;
> > >         }
> > >
> > > Others LGTM!
> > >
> > > Reviewed-by: Guo Ren <guoren@kernel.org>
> > >
> > > > +}
> > > > +
> > > > +#endif /* _ASM_LOONGARCH_IRQ_WORK_H */
> > > > diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/incl=
ude/asm/smp.h
> > > > index 278700cfee88..50db503f44e3 100644
> > > > --- a/arch/loongarch/include/asm/smp.h
> > > > +++ b/arch/loongarch/include/asm/smp.h
> > > > @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
> > > >  #define ACTION_BOOT_CPU        0
> > > >  #define ACTION_RESCHEDULE      1
> > > >  #define ACTION_CALL_FUNCTION   2
> > > > +#define ACTION_IRQ_WORK                3
> > > >  #define SMP_BOOT_CPU           BIT(ACTION_BOOT_CPU)
> > > >  #define SMP_RESCHEDULE         BIT(ACTION_RESCHEDULE)
> > > >  #define SMP_CALL_FUNCTION      BIT(ACTION_CALL_FUNCTION)
> > > > +#define SMP_IRQ_WORK           BIT(ACTION_IRQ_WORK)
> > > >
> > > >  struct secondary_data {
> > > >         unsigned long stack;
> > > > diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kern=
el/paravirt.c
> > > > index 1633ed4f692f..4272d2447445 100644
> > > > --- a/arch/loongarch/kernel/paravirt.c
> > > > +++ b/arch/loongarch/kernel/paravirt.c
> > > > @@ -2,6 +2,7 @@
> > > >  #include <linux/export.h>
> > > >  #include <linux/types.h>
> > > >  #include <linux/interrupt.h>
> > > > +#include <linux/irq_work.h>
> > > >  #include <linux/jump_label.h>
> > > >  #include <linux/kvm_para.h>
> > > >  #include <linux/static_call.h>
> > > > @@ -97,6 +98,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, voi=
d *dev)
> > > >                 info->ipi_irqs[IPI_CALL_FUNCTION]++;
> > > >         }
> > > >
> > > > +       if (action & SMP_IRQ_WORK) {
> > > > +               irq_work_run();
> > > > +               info->ipi_irqs[IPI_IRQ_WORK]++;
> > > > +       }
> > > > +
> > > >         return IRQ_HANDLED;
> > > >  }
> > > >
> > > > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/sm=
p.c
> > > > index 0dfe2388ef41..7366de776f6e 100644
> > > > --- a/arch/loongarch/kernel/smp.c
> > > > +++ b/arch/loongarch/kernel/smp.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include <linux/cpumask.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/interrupt.h>
> > > > +#include <linux/irq_work.h>
> > > >  #include <linux/profile.h>
> > > >  #include <linux/seq_file.h>
> > > >  #include <linux/smp.h>
> > > > @@ -70,6 +71,7 @@ static DEFINE_PER_CPU(int, cpu_state);
> > > >  static const char *ipi_types[NR_IPI] __tracepoint_string =3D {
> > > >         [IPI_RESCHEDULE] =3D "Rescheduling interrupts",
> > > >         [IPI_CALL_FUNCTION] =3D "Function call interrupts",
> > > > +       [IPI_IRQ_WORK] =3D "IRQ work interrupts",
> > > >  };
> > > >
> > > >  void show_ipi_list(struct seq_file *p, int prec)
> > > > @@ -217,6 +219,13 @@ void arch_smp_send_reschedule(int cpu)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
> > > >
> > > > +#ifdef CONFIG_IRQ_WORK
> > > > +void arch_irq_work_raise(void)
> > > > +{
> > > > +       mp_ops.send_ipi_single(smp_processor_id(), ACTION_IRQ_WORK)=
;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
> > > >  {
> > > >         unsigned int action;
> > > > @@ -234,6 +243,11 @@ static irqreturn_t loongson_ipi_interrupt(int =
irq, void *dev)
> > > >                 per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]+=
+;
> > > >         }
> > > >
> > > > +       if (action & SMP_IRQ_WORK) {
> > > > +               irq_work_run();
> > > > +               per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
> > > > +       }
> > > > +
> > > >         return IRQ_HANDLED;
> > > >  }
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren
>


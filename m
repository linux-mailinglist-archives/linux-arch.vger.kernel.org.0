Return-Path: <linux-arch+bounces-4409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335608C5F60
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 05:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922F7B215E4
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD5A374FA;
	Wed, 15 May 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw1x/2OO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655EDF60;
	Wed, 15 May 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715743298; cv=none; b=Fmh6NrkR7ABe0MzSBBzB55qvKKQ4KSbgCMJxDTpekIgFWBfdwQSx9yFn8ZNLGDNnicJUJZreJSo3lRqwziKMQzgTwozAwSiOwT+yxvZx/O3bVEB2Hem1TeiFkOB+BQ6EOrH5C6WmT97jmpV1oBDwBMsz4iXLf9nnzw8IYpuGwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715743298; c=relaxed/simple;
	bh=rFnFUCL7M41L3nuPH68BWAh3plDiCVDxcVfrgt2dPUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCfL2X4aVS5mFVDK/azjile5+D/F7w28H3ZuwtNSia9LJ34+zMvIz/sX9JoJh/l9/r0G+FqtrRwd7aOoKIBWaGDgvwL2tM+HdzeY0tilwlWspHq5Sz2pcODmqSHwBuc624BzwP72GbHe+vwttn8P+WY7klSi+BTwnabbwHaEdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw1x/2OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C43FC32781;
	Wed, 15 May 2024 03:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715743298;
	bh=rFnFUCL7M41L3nuPH68BWAh3plDiCVDxcVfrgt2dPUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lw1x/2OOv/3kUmVoTxUuQqtTLlYTEob/FcVvCN5oPqHBvldD65Odc1SAozWN/A5Sf
	 QDIi+vxDjnPxVQx2i3174PBlUE2i5Xo/sPh4fwzq6Uio4RSEW/F2hRHYsvqwkYO+wP
	 xwk0Eh9evWz0MXw8YlwfqkItQGrhcw7F6aXQsj1q/rBC6EsZ4jNcmJPXyNV/L8sqtH
	 Dis+E6EEnfekHXJnQXb7/YSg4EXxaa/dyU+b2Fg7AvQif9qZa2Rng4LRwsJx/doQQH
	 gUUrJ18H+6TebDlJfIF0f/f56xkqH1rKKwlZXfRfKpWKZLeGWc1jABU/cn8CWeMkah
	 fxWLofKbu8/sQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571c2055cb1so271505a12.1;
        Tue, 14 May 2024 20:21:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMt0N7ew5efZ3GZMKbXV//WjEVTGaE6fEtmS3WYlefKpC54pjVm3eOkXZ5QnqckVlkFiqNxyCp2NYwqBC5wFvWy5PYgde1uxNnN0BqP+CewINRcLNyab/ZEXj6cTQ5ck3zSpfXkpOAqA==
X-Gm-Message-State: AOJu0YyvfdN6CXPL1jbS3QVw44yZOdC7HUs/s9MaezwqYOCvFaePe1Tk
	5zYNzYRhGKO9LszkAHP0r/zTgZLkORHVweXDMZ8LrSDINtw8k3axnLB0uXSISg5reIh/J6+2Mad
	jd80EqUcYo2cu8yjOcf/hWJw7De8=
X-Google-Smtp-Source: AGHT+IG6qidphEnCoddn0W/30TZlgMza6phcHT1lB6B+9ZwP27ETTp0Kl80GH4xmHMP0L4Zj2XjEOdBTjmMAphXugKA=
X-Received: by 2002:a50:a448:0:b0:56e:c5a:c7a9 with SMTP id
 4fb4d7f45d1cf-5734d6e0dc1mr10329501a12.41.1715743296835; Tue, 14 May 2024
 20:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514073232.3694867-1-chenhuacai@loongson.cn>
 <CAJF2gTTUmpm+aTQL7gNyLEe57X=v-it3MT5TOCViCOEiEyraBA@mail.gmail.com> <CAAhV-H6_KuRhqja=NKcGWQeJfaJfEZZ9pEy+4+_Vov690agrZA@mail.gmail.com>
In-Reply-To: <CAAhV-H6_KuRhqja=NKcGWQeJfaJfEZZ9pEy+4+_Vov690agrZA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 May 2024 11:21:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRC9-sabTWOyFL+fw8+tFYfyHJo-4ZHS=byB-wzmJM8jQ@mail.gmail.com>
Message-ID: <CAJF2gTRC9-sabTWOyFL+fw8+tFYfyHJo-4ZHS=byB-wzmJM8jQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add irq_work support via self IPIs
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 7:14=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Ren,
>
> On Tue, May 14, 2024 at 6:11=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Tue, May 14, 2024 at 3:32=E2=80=AFPM Huacai Chen <chenhuacai@loongso=
n.cn> wrote:
> > >
> > > Add irq_work support for LoongArch via self IPIs. This make it possib=
le
> > > to run works in hardware interrupt context, which is a prerequisite f=
or
> > > NOHZ_FULL.
> > >
> > > Implement:
> > >  - arch_irq_work_raise()
> > >  - arch_irq_work_has_interrupt()
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/include/asm/hardirq.h  |  3 ++-
> > >  arch/loongarch/include/asm/irq_work.h | 10 ++++++++++
> > >  arch/loongarch/include/asm/smp.h      |  2 ++
> > >  arch/loongarch/kernel/paravirt.c      |  6 ++++++
> > >  arch/loongarch/kernel/smp.c           | 14 ++++++++++++++
> > >  5 files changed, 34 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/loongarch/include/asm/irq_work.h
> > >
> > > diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/in=
clude/asm/hardirq.h
> > > index d41138abcf26..1d7feb719515 100644
> > > --- a/arch/loongarch/include/asm/hardirq.h
> > > +++ b/arch/loongarch/include/asm/hardirq.h
> > > @@ -12,11 +12,12 @@
> > >  extern void ack_bad_irq(unsigned int irq);
> > >  #define ack_bad_irq ack_bad_irq
> > >
> > > -#define NR_IPI 2
> > > +#define NR_IPI 3
> > >
> > >  enum ipi_msg_type {
> > >         IPI_RESCHEDULE,
> > >         IPI_CALL_FUNCTION,
> > > +       IPI_IRQ_WORK,
> > >  };
> > >
> > >  typedef struct {
> > > diff --git a/arch/loongarch/include/asm/irq_work.h b/arch/loongarch/i=
nclude/asm/irq_work.h
> > > new file mode 100644
> > > index 000000000000..d63076e9160d
> > > --- /dev/null
> > > +++ b/arch/loongarch/include/asm/irq_work.h
> > > @@ -0,0 +1,10 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _ASM_LOONGARCH_IRQ_WORK_H
> > > +#define _ASM_LOONGARCH_IRQ_WORK_H
> > > +
> > > +static inline bool arch_irq_work_has_interrupt(void)
> > > +{
> > > +       return IS_ENABLED(CONFIG_SMP);
> > I think it is "return true," or it will cause the warning.
> No, HZ_FULL depends on SMP, if you force to enable it on UP, the
> timekeeping will boom.
> On the other hand, let the function return true will cause build
> errors, see commit d2f3acde3d52b3b351db09e2e2a5e581 ("riscv: Fix
> irq_work when SMP is disabled").
Sorry, I misunderstood.

But it is not a build error. Quote:

This was found while bringing up cpufreq on D1. Switching cpufreq
governors was hanging on irq_work_sync().

/*
 * Synchronize against the irq_work @entry, ensures the entry is not
 * currently in use.
 */
void irq_work_sync(struct irq_work *work)
{
        lockdep_assert_irqs_enabled();
        might_sleep();

        if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
            !arch_irq_work_has_interrupt()) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
                rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
                                   TASK_UNINTERRUPTIBLE);
                return;
        }


>
> Huacai
>
> >
> > void __init tick_nohz_init(void)
> > {
> >         int cpu, ret;
> >
> >         if (!tick_nohz_full_running)
> >                 return;
> >
> >         /*
> >          * Full dynticks uses IRQ work to drive the tick rescheduling o=
n safe
> >          * locking contexts. But then we need IRQ work to raise its own
> >          * interrupts to avoid circular dependency on the tick.
> >          */
> >         if (!arch_irq_work_has_interrupt()) {
> >                 pr_warn("NO_HZ: Can't run full dynticks because arch
> > doesn't support IRQ work self-IPIs\n");
> >                 cpumask_clear(tick_nohz_full_mask);
> >                 tick_nohz_full_running =3D false;
> >                 return;
> >         }
> >
> > Others LGTM!
> >
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> > > +}
> > > +
> > > +#endif /* _ASM_LOONGARCH_IRQ_WORK_H */
> > > diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/includ=
e/asm/smp.h
> > > index 278700cfee88..50db503f44e3 100644
> > > --- a/arch/loongarch/include/asm/smp.h
> > > +++ b/arch/loongarch/include/asm/smp.h
> > > @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
> > >  #define ACTION_BOOT_CPU        0
> > >  #define ACTION_RESCHEDULE      1
> > >  #define ACTION_CALL_FUNCTION   2
> > > +#define ACTION_IRQ_WORK                3
> > >  #define SMP_BOOT_CPU           BIT(ACTION_BOOT_CPU)
> > >  #define SMP_RESCHEDULE         BIT(ACTION_RESCHEDULE)
> > >  #define SMP_CALL_FUNCTION      BIT(ACTION_CALL_FUNCTION)
> > > +#define SMP_IRQ_WORK           BIT(ACTION_IRQ_WORK)
> > >
> > >  struct secondary_data {
> > >         unsigned long stack;
> > > diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel=
/paravirt.c
> > > index 1633ed4f692f..4272d2447445 100644
> > > --- a/arch/loongarch/kernel/paravirt.c
> > > +++ b/arch/loongarch/kernel/paravirt.c
> > > @@ -2,6 +2,7 @@
> > >  #include <linux/export.h>
> > >  #include <linux/types.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/irq_work.h>
> > >  #include <linux/jump_label.h>
> > >  #include <linux/kvm_para.h>
> > >  #include <linux/static_call.h>
> > > @@ -97,6 +98,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void =
*dev)
> > >                 info->ipi_irqs[IPI_CALL_FUNCTION]++;
> > >         }
> > >
> > > +       if (action & SMP_IRQ_WORK) {
> > > +               irq_work_run();
> > > +               info->ipi_irqs[IPI_IRQ_WORK]++;
> > > +       }
> > > +
> > >         return IRQ_HANDLED;
> > >  }
> > >
> > > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.=
c
> > > index 0dfe2388ef41..7366de776f6e 100644
> > > --- a/arch/loongarch/kernel/smp.c
> > > +++ b/arch/loongarch/kernel/smp.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/cpumask.h>
> > >  #include <linux/init.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/irq_work.h>
> > >  #include <linux/profile.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/smp.h>
> > > @@ -70,6 +71,7 @@ static DEFINE_PER_CPU(int, cpu_state);
> > >  static const char *ipi_types[NR_IPI] __tracepoint_string =3D {
> > >         [IPI_RESCHEDULE] =3D "Rescheduling interrupts",
> > >         [IPI_CALL_FUNCTION] =3D "Function call interrupts",
> > > +       [IPI_IRQ_WORK] =3D "IRQ work interrupts",
> > >  };
> > >
> > >  void show_ipi_list(struct seq_file *p, int prec)
> > > @@ -217,6 +219,13 @@ void arch_smp_send_reschedule(int cpu)
> > >  }
> > >  EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
> > >
> > > +#ifdef CONFIG_IRQ_WORK
> > > +void arch_irq_work_raise(void)
> > > +{
> > > +       mp_ops.send_ipi_single(smp_processor_id(), ACTION_IRQ_WORK);
> > > +}
> > > +#endif
> > > +
> > >  static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
> > >  {
> > >         unsigned int action;
> > > @@ -234,6 +243,11 @@ static irqreturn_t loongson_ipi_interrupt(int ir=
q, void *dev)
> > >                 per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
> > >         }
> > >
> > > +       if (action & SMP_IRQ_WORK) {
> > > +               irq_work_run();
> > > +               per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
> > > +       }
> > > +
> > >         return IRQ_HANDLED;
> > >  }
> > >
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren


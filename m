Return-Path: <linux-arch+bounces-4395-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355CF8C51F3
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA11F227E8
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066784DFD;
	Tue, 14 May 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMZAGx6G"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37C6D1A0;
	Tue, 14 May 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685276; cv=none; b=dqkZpFPrZZ0uHoDgxkuLNcsP5Fo2XVHPyOzOtTbjYbcC1sVo+YCBlzMDRj89udjJM1JGENFvEJhH4BAllSPCz+BxMcHQsNXqBJXpsbJGcBSYzNhK46qsTWKtnvabIcm1GGXBcCbROuxikvDjvf0ilJ3DMM4ulAe9ZK4flx5S49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685276; c=relaxed/simple;
	bh=9XxkmLyIRi1szN3CDpSZaXrNIeVj/9yTHBWVjq1kPjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY1vyrS118wvHoEqmk6MyEyU0Frk+1Ph5s0YxAV2urCtAQd6+vJ8FQDWN5t4bO2wWplo4857sc1d+DjGauNjXO7uGMhq35WGXIjQ9sW0SQ4sIy2/IYi6LFFs1kSMdRg1vbT3YpMETia1gjfWA5vDSbFVJCobCEVsA1qdQnYq5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMZAGx6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB657C32786;
	Tue, 14 May 2024 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715685275;
	bh=9XxkmLyIRi1szN3CDpSZaXrNIeVj/9yTHBWVjq1kPjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AMZAGx6GUlv61KpNqVUcw05qNwZuYw5YUJn93p+JyTdLCF/PHhN0VXfq4Nt4TjojQ
	 bQnL1H4OOF2Gj/bvMCgZyutRwjU17ZSkJMpyap1nV5SV0jGxGo36OnPYbMkzSMrGBn
	 pr8Ko56yYOLbFHlUH60HOK+zXcRkPStyKItCqRF/5jVdARTHs1sQHU+IHD3iFfrDhP
	 K42ajT1ODyAFpphtI91ZtqNZLhbDRluT1Rpn0ZW83WMCEo165IvQK2nPeuOLNJsmGG
	 RCWu2PBoLJybeB5jjbXiZDehfV36Xwl8qNJt/jPX0kO8fhwHlFarA8+qMKdNVjuKt2
	 37S+zaUyM6cLQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5a1054cf61so8039366b.1;
        Tue, 14 May 2024 04:14:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5ydonZiirfRzpQ0HSUSQxBiDzqPl7IvOrFE6EyWvzwnr4l6xWh4L1uIRiC2UIKAEMM76W/MKdRVQY4VkPg/yHACBoE0Chnj4roIz7kIqT/vk4tme0EqEIBZtrzBziYcY2x/e2533DHA==
X-Gm-Message-State: AOJu0YzUUF1F4rfOZRklGsXkK286TpvWLHqChCV5xuAxNUE+BNy5bhta
	/HiB3YH6W7LvDKMYFpTTdtn8mNh/+xVrE8tI2kDi8IJ0h/FWzSJTaaW3uB9XVxfegG6eD1+yS3F
	69WW3hZHs9xjXNCHAWNA6z36igAk=
X-Google-Smtp-Source: AGHT+IH2VCgR/UUkYLp+NF/Kd3OrGeVSqSVWU9TjjuJFPwvDkcw6Q7cAlqQusFgD/lUbovPM4btmG4LpMlp8n2h8T/k=
X-Received: by 2002:a17:906:314e:b0:a59:a7b7:2b90 with SMTP id
 a640c23a62f3a-a5a2d5750f2mr1127557866b.30.1715685274243; Tue, 14 May 2024
 04:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514073232.3694867-1-chenhuacai@loongson.cn> <CAJF2gTTUmpm+aTQL7gNyLEe57X=v-it3MT5TOCViCOEiEyraBA@mail.gmail.com>
In-Reply-To: <CAJF2gTTUmpm+aTQL7gNyLEe57X=v-it3MT5TOCViCOEiEyraBA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 May 2024 19:14:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6_KuRhqja=NKcGWQeJfaJfEZZ9pEy+4+_Vov690agrZA@mail.gmail.com>
Message-ID: <CAAhV-H6_KuRhqja=NKcGWQeJfaJfEZZ9pEy+4+_Vov690agrZA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add irq_work support via self IPIs
To: Guo Ren <guoren@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ren,

On Tue, May 14, 2024 at 6:11=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, May 14, 2024 at 3:32=E2=80=AFPM Huacai Chen <chenhuacai@loongson.=
cn> wrote:
> >
> > Add irq_work support for LoongArch via self IPIs. This make it possible
> > to run works in hardware interrupt context, which is a prerequisite for
> > NOHZ_FULL.
> >
> > Implement:
> >  - arch_irq_work_raise()
> >  - arch_irq_work_has_interrupt()
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/hardirq.h  |  3 ++-
> >  arch/loongarch/include/asm/irq_work.h | 10 ++++++++++
> >  arch/loongarch/include/asm/smp.h      |  2 ++
> >  arch/loongarch/kernel/paravirt.c      |  6 ++++++
> >  arch/loongarch/kernel/smp.c           | 14 ++++++++++++++
> >  5 files changed, 34 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/loongarch/include/asm/irq_work.h
> >
> > diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/incl=
ude/asm/hardirq.h
> > index d41138abcf26..1d7feb719515 100644
> > --- a/arch/loongarch/include/asm/hardirq.h
> > +++ b/arch/loongarch/include/asm/hardirq.h
> > @@ -12,11 +12,12 @@
> >  extern void ack_bad_irq(unsigned int irq);
> >  #define ack_bad_irq ack_bad_irq
> >
> > -#define NR_IPI 2
> > +#define NR_IPI 3
> >
> >  enum ipi_msg_type {
> >         IPI_RESCHEDULE,
> >         IPI_CALL_FUNCTION,
> > +       IPI_IRQ_WORK,
> >  };
> >
> >  typedef struct {
> > diff --git a/arch/loongarch/include/asm/irq_work.h b/arch/loongarch/inc=
lude/asm/irq_work.h
> > new file mode 100644
> > index 000000000000..d63076e9160d
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/irq_work.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_LOONGARCH_IRQ_WORK_H
> > +#define _ASM_LOONGARCH_IRQ_WORK_H
> > +
> > +static inline bool arch_irq_work_has_interrupt(void)
> > +{
> > +       return IS_ENABLED(CONFIG_SMP);
> I think it is "return true," or it will cause the warning.
No, HZ_FULL depends on SMP, if you force to enable it on UP, the
timekeeping will boom.
On the other hand, let the function return true will cause build
errors, see commit d2f3acde3d52b3b351db09e2e2a5e581 ("riscv: Fix
irq_work when SMP is disabled").

Huacai

>
> void __init tick_nohz_init(void)
> {
>         int cpu, ret;
>
>         if (!tick_nohz_full_running)
>                 return;
>
>         /*
>          * Full dynticks uses IRQ work to drive the tick rescheduling on =
safe
>          * locking contexts. But then we need IRQ work to raise its own
>          * interrupts to avoid circular dependency on the tick.
>          */
>         if (!arch_irq_work_has_interrupt()) {
>                 pr_warn("NO_HZ: Can't run full dynticks because arch
> doesn't support IRQ work self-IPIs\n");
>                 cpumask_clear(tick_nohz_full_mask);
>                 tick_nohz_full_running =3D false;
>                 return;
>         }
>
> Others LGTM!
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
> > +}
> > +
> > +#endif /* _ASM_LOONGARCH_IRQ_WORK_H */
> > diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/=
asm/smp.h
> > index 278700cfee88..50db503f44e3 100644
> > --- a/arch/loongarch/include/asm/smp.h
> > +++ b/arch/loongarch/include/asm/smp.h
> > @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
> >  #define ACTION_BOOT_CPU        0
> >  #define ACTION_RESCHEDULE      1
> >  #define ACTION_CALL_FUNCTION   2
> > +#define ACTION_IRQ_WORK                3
> >  #define SMP_BOOT_CPU           BIT(ACTION_BOOT_CPU)
> >  #define SMP_RESCHEDULE         BIT(ACTION_RESCHEDULE)
> >  #define SMP_CALL_FUNCTION      BIT(ACTION_CALL_FUNCTION)
> > +#define SMP_IRQ_WORK           BIT(ACTION_IRQ_WORK)
> >
> >  struct secondary_data {
> >         unsigned long stack;
> > diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/p=
aravirt.c
> > index 1633ed4f692f..4272d2447445 100644
> > --- a/arch/loongarch/kernel/paravirt.c
> > +++ b/arch/loongarch/kernel/paravirt.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/export.h>
> >  #include <linux/types.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/irq_work.h>
> >  #include <linux/jump_label.h>
> >  #include <linux/kvm_para.h>
> >  #include <linux/static_call.h>
> > @@ -97,6 +98,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *d=
ev)
> >                 info->ipi_irqs[IPI_CALL_FUNCTION]++;
> >         }
> >
> > +       if (action & SMP_IRQ_WORK) {
> > +               irq_work_run();
> > +               info->ipi_irqs[IPI_IRQ_WORK]++;
> > +       }
> > +
> >         return IRQ_HANDLED;
> >  }
> >
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index 0dfe2388ef41..7366de776f6e 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/irq_work.h>
> >  #include <linux/profile.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/smp.h>
> > @@ -70,6 +71,7 @@ static DEFINE_PER_CPU(int, cpu_state);
> >  static const char *ipi_types[NR_IPI] __tracepoint_string =3D {
> >         [IPI_RESCHEDULE] =3D "Rescheduling interrupts",
> >         [IPI_CALL_FUNCTION] =3D "Function call interrupts",
> > +       [IPI_IRQ_WORK] =3D "IRQ work interrupts",
> >  };
> >
> >  void show_ipi_list(struct seq_file *p, int prec)
> > @@ -217,6 +219,13 @@ void arch_smp_send_reschedule(int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
> >
> > +#ifdef CONFIG_IRQ_WORK
> > +void arch_irq_work_raise(void)
> > +{
> > +       mp_ops.send_ipi_single(smp_processor_id(), ACTION_IRQ_WORK);
> > +}
> > +#endif
> > +
> >  static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
> >  {
> >         unsigned int action;
> > @@ -234,6 +243,11 @@ static irqreturn_t loongson_ipi_interrupt(int irq,=
 void *dev)
> >                 per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
> >         }
> >
> > +       if (action & SMP_IRQ_WORK) {
> > +               irq_work_run();
> > +               per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
> > +       }
> > +
> >         return IRQ_HANDLED;
> >  }
> >
> > --
> > 2.43.0
> >
>
>
> --
> Best Regards
>  Guo Ren


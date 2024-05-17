Return-Path: <linux-arch+bounces-4456-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EF8C8188
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48C11C2101D
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD7175AD;
	Fri, 17 May 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0uNjCjU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEA17BA7;
	Fri, 17 May 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931476; cv=none; b=sQz/e/Fh8xrTS6MP/TmcYGmfGkgm022Kf4WjvAfGqqYCY6n50fuoIMjyMaDmrqKsvOIXuiO7qJR5UHmmy0l9x/TkYptwcb0FGzGQFwfaweLmzO2khGAk5W8esU7xQtsrsMoyzJNy3XTs/xzr733wNo/NIT1e7PbTx/XLoP5gEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931476; c=relaxed/simple;
	bh=8xcNtpQ4LncrDhuJ25hPt9wZoKOTAtIcM5tusY56NBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7LQNwk/GNxIXyfv0r5WDI5XCIp1F9CujD76aeQYYi6RXwUEy7BKwSMQntoAiX1Z6BafbhKb+agHpO0hdURbn2ElBidiXhx1E7bifGdL3QV4BBfB3FETt1N4YgrS4Yfecp8qrkUzHBBYLCY6Z9w3gUo35DvCNCaGMjDrMDkIii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0uNjCjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5596EC4AF08;
	Fri, 17 May 2024 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715931476;
	bh=8xcNtpQ4LncrDhuJ25hPt9wZoKOTAtIcM5tusY56NBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h0uNjCjUMQZ0IGVvEutrQZXHC8PUdgFQOzZfnfNpqMqz68oqSFKm+tbxK/mpKycnp
	 2PIN6cQuhJ1a4pkGfOQr+hzy2q60boSlztx2/If64o2f1AJgjvC2IEbtms4/6/P4nY
	 jVK/k0lkqvLQvpDc6YAfHIvvF5K5gmjneF5Ze65N8Y5XF2OFEVGVgyw+evlPKBgj/c
	 zSvLPVe+ibiymz7dfxjOulhdEG1Ae9ViqsazJLYrctkWnCKC5Bk8B8fltq+8UWEjzW
	 hDYhOV+jMWb85P0lujplI/JZpyPQKoGETIQME7mLTy0KnXSCkiArijjK5wv5t79zav
	 0MiBaPg73FEfg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so4781702a12.0;
        Fri, 17 May 2024 00:37:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6CNEbYFfYbq/37FiX0Hn5/4FaOhJHFid/OEtSNfcSCFyMQcHepa4HSac1iBSKeLtjxlvNuuFFwnrm1V8eBDtMQThLD6U7eHwZhFlgu6i13kQNvOhLGfi8ROXfRzA8w6jJzK3+vu0M/Q==
X-Gm-Message-State: AOJu0Yyq9y+A4g0DG1cZkx3kKO6o9TEr1XIpRlCTq5malfnNpWjqKoUc
	Uuky4/6X78UjDCF3/acVyQZp13ucbSggXMh+1N0C8X/EYzqx7oWHY0vBQT7ORgg+pAzkIcvk8yf
	EWM0GGLi02CJ1sbGfyxaRt/Suctw=
X-Google-Smtp-Source: AGHT+IH5CDy2pFzhrWDy8JnRPH0xH9ZvJn2OFnXyG5cHREPIhLuFsbVMyAcWMPeXmWHTFIbzI/kFufimilUa+7FnJDU=
X-Received: by 2002:a17:906:a99:b0:a59:aa68:99a0 with SMTP id
 a640c23a62f3a-a5a2d5819bbmr1385056966b.18.1715931474805; Fri, 17 May 2024
 00:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514073232.3694867-1-chenhuacai@loongson.cn> <b1182755-ec71-2add-ad69-72da85cdbb19@loongson.cn>
In-Reply-To: <b1182755-ec71-2add-ad69-72da85cdbb19@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 17 May 2024 15:37:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5=jEODTiPK3zE1Rkw=RQEMfebH8j1hsJ7RoXJvjW2OyQ@mail.gmail.com>
Message-ID: <CAAhV-H5=jEODTiPK3zE1Rkw=RQEMfebH8j1hsJ7RoXJvjW2OyQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add irq_work support via self IPIs
To: maobibo <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 8:23=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/5/14 =E4=B8=8B=E5=8D=883:32, Huacai Chen wrote:
> > Add irq_work support for LoongArch via self IPIs. This make it possible
> > to run works in hardware interrupt context, which is a prerequisite for
> > NOHZ_FULL.
> >
> > Implement:
> >   - arch_irq_work_raise()
> >   - arch_irq_work_has_interrupt()
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/hardirq.h  |  3 ++-
> >   arch/loongarch/include/asm/irq_work.h | 10 ++++++++++
> >   arch/loongarch/include/asm/smp.h      |  2 ++
> >   arch/loongarch/kernel/paravirt.c      |  6 ++++++
> >   arch/loongarch/kernel/smp.c           | 14 ++++++++++++++
> >   5 files changed, 34 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/loongarch/include/asm/irq_work.h
> >
> > diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/incl=
ude/asm/hardirq.h
> > index d41138abcf26..1d7feb719515 100644
> > --- a/arch/loongarch/include/asm/hardirq.h
> > +++ b/arch/loongarch/include/asm/hardirq.h
> > @@ -12,11 +12,12 @@
> >   extern void ack_bad_irq(unsigned int irq);
> >   #define ack_bad_irq ack_bad_irq
> >
> > -#define NR_IPI       2
> > +#define NR_IPI       3
> >
> >   enum ipi_msg_type {
> >       IPI_RESCHEDULE,
> >       IPI_CALL_FUNCTION,
> > +     IPI_IRQ_WORK,
> >   };
> >
> >   typedef struct {
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
> > +     return IS_ENABLED(CONFIG_SMP);
> > +}
> > +
> > +#endif /* _ASM_LOONGARCH_IRQ_WORK_H */
> > diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/=
asm/smp.h
> > index 278700cfee88..50db503f44e3 100644
> > --- a/arch/loongarch/include/asm/smp.h
> > +++ b/arch/loongarch/include/asm/smp.h
> > @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
> >   #define ACTION_BOOT_CPU     0
> >   #define ACTION_RESCHEDULE   1
> >   #define ACTION_CALL_FUNCTION        2
> > +#define ACTION_IRQ_WORK              3
> >   #define SMP_BOOT_CPU                BIT(ACTION_BOOT_CPU)
> >   #define SMP_RESCHEDULE              BIT(ACTION_RESCHEDULE)
> >   #define SMP_CALL_FUNCTION   BIT(ACTION_CALL_FUNCTION)
> > +#define SMP_IRQ_WORK         BIT(ACTION_IRQ_WORK)
> >
> >   struct secondary_data {
> >       unsigned long stack;
> > diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/p=
aravirt.c
> > index 1633ed4f692f..4272d2447445 100644
> > --- a/arch/loongarch/kernel/paravirt.c
> > +++ b/arch/loongarch/kernel/paravirt.c
> > @@ -2,6 +2,7 @@
> >   #include <linux/export.h>
> >   #include <linux/types.h>
> >   #include <linux/interrupt.h>
> > +#include <linux/irq_work.h>
> >   #include <linux/jump_label.h>
> >   #include <linux/kvm_para.h>
> >   #include <linux/static_call.h>
> > @@ -97,6 +98,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *d=
ev)
> >               info->ipi_irqs[IPI_CALL_FUNCTION]++;
> >       }
> >
> > +     if (action & SMP_IRQ_WORK) {
> > +             irq_work_run();
> > +             info->ipi_irqs[IPI_IRQ_WORK]++;
> > +     }
> > +
> Would you mind adding common api so that pv ipi handler and hw ipi
> handler can call it both? The coming avec MSI interrupt driver has the
> same requirement for ipi.
We can refactor it after AVEC upstream, if needed.

Huacai

>
> void do_ipi_demux(unsigned int action)
> {
>          irq_cpustat_t *info;
>
>          info =3D this_cpu_ptr(&irq_stat);
>          if (action & SMP_RESCHEDULE) {
>                  scheduler_ipi();
>                  info->ipi_irqs[IPI_RESCHEDULE]++;
>          }
>
>          if (action & SMP_CALL_FUNCTION) {
>                  generic_smp_call_function_interrupt();
>                  info->ipi_irqs[IPI_CALL_FUNCTION]++;
>          }
>
>         if (action & SMP_IRQ_WORK) {
>                 irq_work_run();
>                 info->ipi_irqs[IPI_IRQ_WORK]++;
> }
>
> Regards
> Bibo Mao
> >       return IRQ_HANDLED;
> >   }
> >
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index 0dfe2388ef41..7366de776f6e 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/cpumask.h>
> >   #include <linux/init.h>
> >   #include <linux/interrupt.h>
> > +#include <linux/irq_work.h>
> >   #include <linux/profile.h>
> >   #include <linux/seq_file.h>
> >   #include <linux/smp.h>
> > @@ -70,6 +71,7 @@ static DEFINE_PER_CPU(int, cpu_state);
> >   static const char *ipi_types[NR_IPI] __tracepoint_string =3D {
> >       [IPI_RESCHEDULE] =3D "Rescheduling interrupts",
> >       [IPI_CALL_FUNCTION] =3D "Function call interrupts",
> > +     [IPI_IRQ_WORK] =3D "IRQ work interrupts",
> >   };
> >
> >   void show_ipi_list(struct seq_file *p, int prec)
> > @@ -217,6 +219,13 @@ void arch_smp_send_reschedule(int cpu)
> >   }
> >   EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
> >
> > +#ifdef CONFIG_IRQ_WORK
> > +void arch_irq_work_raise(void)
> > +{
> > +     mp_ops.send_ipi_single(smp_processor_id(), ACTION_IRQ_WORK);
> > +}
> > +#endif
> > +
> >   static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
> >   {
> >       unsigned int action;
> > @@ -234,6 +243,11 @@ static irqreturn_t loongson_ipi_interrupt(int irq,=
 void *dev)
> >               per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
> >       }
> >
> > +     if (action & SMP_IRQ_WORK) {
> > +             irq_work_run();
> > +             per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
> > +     }
> > +
> >       return IRQ_HANDLED;
> >   }
> >
> >
>
>


Return-Path: <linux-arch+bounces-4393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B2C8C4F45
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9391C20CA9
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527C13E021;
	Tue, 14 May 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwnlICT/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B666B5E;
	Tue, 14 May 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681510; cv=none; b=Kbb4Sr2T5m8S1/Y6K7UgEhIIPRu5g8ldlBY/KMjVj54Nz0OeDYF49lu5q0qlE8GN5HLLMSfT8O2ZxuRdmeLS4sZGBzPOhTRI28RwaxwKI+xjAUPGsfu6GmeLnkaWS5xMvejya+9uDA1TVfWdsi0IgXea7XXCdJn63+gQaIfe7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681510; c=relaxed/simple;
	bh=uKQmHevj9qgPxSEUKRxkpZkuCmA3D/KeuYFmxfhUbEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQSbp99hEzpgKGhlZw1ivsyJBUCI1FG/h5fJJ5FRh8VSy6cLQuL6Q03l3L0AtAWNor2Qf4rN2j830MffnNNb25/wEt9hLbVivxyJuKU+jStvoyGVwZk6wCiiD5d2ArDbGE+XcWbSBq9cwzNQKggpLEeO76hJudGEEmBIKowsDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwnlICT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3FCC2BD10;
	Tue, 14 May 2024 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715681509;
	bh=uKQmHevj9qgPxSEUKRxkpZkuCmA3D/KeuYFmxfhUbEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BwnlICT/+bN+Wr7PMITNaw/PGTvG98iAfF3073CDGjWzTxFnguKCoUtA8eTXz2KOM
	 ENuMlXWyQygcaI/ixhkb6+WCFSt/hm7kH10vPV3yxjvvo/FpOXCG0dYynC3ijkdypp
	 yxEpPGyAB1dg7ysEYIFwJlUK+I9MuUU7Owkr/8xSOEN+s8hMjCKttNonPQ70mKxVNm
	 V50X2FosDN1QtiR5KwKHARb/QMQkjrQttsNfw6xa2ix+KDmzF33ioTz10Ui1H5G5BI
	 tgaB3UGffX9PDbQ1cJ/7W27NkWTWIFAYeGKxD8FSEqkPGAS1hWQhslibLfpNopX2qf
	 Y0YspErr7AQBg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a9d66a51so1255312466b.2;
        Tue, 14 May 2024 03:11:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkJepZTmvoy8psnJNVwAXkR7OQ8P9WfLEOKyurYO1XJnOS8e/cQ3jpn7lJ1v9T8riNGzrZjYk6DZ29wzRGWix13egAgW9gE/j7T42ivGPoHfMpJL6wL3oxyCICZWqN37LYIIfBWKcFlA==
X-Gm-Message-State: AOJu0YxNPe3OZQuT0pXsN5XNkAtScejXhH7rnozi3WDxuvp7t8/rI/Ce
	zK8jCog7llDsFBARio76k/gPZ5hZBZIhGKaMeebSr2Fwa+YkaGeNZ8llDdd9AS8ZEqRu0UBsQAl
	Ni4l4unhWUqYVvP4HM3IfwxLDHdg=
X-Google-Smtp-Source: AGHT+IG2SJLZeJv9E723RPMYkjAggoAqnNUcuBjZL5KPzQ7ueRWKLf2UEtaPgF8M+K9KWHrfkkwXldPNn9gLjNl+WUk=
X-Received: by 2002:a50:a40c:0:b0:56d:c928:ad76 with SMTP id
 4fb4d7f45d1cf-5734d67e8d0mr8314326a12.26.1715681508279; Tue, 14 May 2024
 03:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514073232.3694867-1-chenhuacai@loongson.cn>
In-Reply-To: <20240514073232.3694867-1-chenhuacai@loongson.cn>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 14 May 2024 18:11:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTUmpm+aTQL7gNyLEe57X=v-it3MT5TOCViCOEiEyraBA@mail.gmail.com>
Message-ID: <CAJF2gTTUmpm+aTQL7gNyLEe57X=v-it3MT5TOCViCOEiEyraBA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add irq_work support via self IPIs
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:32=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Add irq_work support for LoongArch via self IPIs. This make it possible
> to run works in hardware interrupt context, which is a prerequisite for
> NOHZ_FULL.
>
> Implement:
>  - arch_irq_work_raise()
>  - arch_irq_work_has_interrupt()
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/hardirq.h  |  3 ++-
>  arch/loongarch/include/asm/irq_work.h | 10 ++++++++++
>  arch/loongarch/include/asm/smp.h      |  2 ++
>  arch/loongarch/kernel/paravirt.c      |  6 ++++++
>  arch/loongarch/kernel/smp.c           | 14 ++++++++++++++
>  5 files changed, 34 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/include/asm/irq_work.h
>
> diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/includ=
e/asm/hardirq.h
> index d41138abcf26..1d7feb719515 100644
> --- a/arch/loongarch/include/asm/hardirq.h
> +++ b/arch/loongarch/include/asm/hardirq.h
> @@ -12,11 +12,12 @@
>  extern void ack_bad_irq(unsigned int irq);
>  #define ack_bad_irq ack_bad_irq
>
> -#define NR_IPI 2
> +#define NR_IPI 3
>
>  enum ipi_msg_type {
>         IPI_RESCHEDULE,
>         IPI_CALL_FUNCTION,
> +       IPI_IRQ_WORK,
>  };
>
>  typedef struct {
> diff --git a/arch/loongarch/include/asm/irq_work.h b/arch/loongarch/inclu=
de/asm/irq_work.h
> new file mode 100644
> index 000000000000..d63076e9160d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/irq_work.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_LOONGARCH_IRQ_WORK_H
> +#define _ASM_LOONGARCH_IRQ_WORK_H
> +
> +static inline bool arch_irq_work_has_interrupt(void)
> +{
> +       return IS_ENABLED(CONFIG_SMP);
I think it is "return true," or it will cause the warning.

void __init tick_nohz_init(void)
{
        int cpu, ret;

        if (!tick_nohz_full_running)
                return;

        /*
         * Full dynticks uses IRQ work to drive the tick rescheduling on sa=
fe
         * locking contexts. But then we need IRQ work to raise its own
         * interrupts to avoid circular dependency on the tick.
         */
        if (!arch_irq_work_has_interrupt()) {
                pr_warn("NO_HZ: Can't run full dynticks because arch
doesn't support IRQ work self-IPIs\n");
                cpumask_clear(tick_nohz_full_mask);
                tick_nohz_full_running =3D false;
                return;
        }

Others LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

> +}
> +
> +#endif /* _ASM_LOONGARCH_IRQ_WORK_H */
> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/as=
m/smp.h
> index 278700cfee88..50db503f44e3 100644
> --- a/arch/loongarch/include/asm/smp.h
> +++ b/arch/loongarch/include/asm/smp.h
> @@ -69,9 +69,11 @@ extern int __cpu_logical_map[NR_CPUS];
>  #define ACTION_BOOT_CPU        0
>  #define ACTION_RESCHEDULE      1
>  #define ACTION_CALL_FUNCTION   2
> +#define ACTION_IRQ_WORK                3
>  #define SMP_BOOT_CPU           BIT(ACTION_BOOT_CPU)
>  #define SMP_RESCHEDULE         BIT(ACTION_RESCHEDULE)
>  #define SMP_CALL_FUNCTION      BIT(ACTION_CALL_FUNCTION)
> +#define SMP_IRQ_WORK           BIT(ACTION_IRQ_WORK)
>
>  struct secondary_data {
>         unsigned long stack;
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/par=
avirt.c
> index 1633ed4f692f..4272d2447445 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -2,6 +2,7 @@
>  #include <linux/export.h>
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq_work.h>
>  #include <linux/jump_label.h>
>  #include <linux/kvm_para.h>
>  #include <linux/static_call.h>
> @@ -97,6 +98,11 @@ static irqreturn_t pv_ipi_interrupt(int irq, void *dev=
)
>                 info->ipi_irqs[IPI_CALL_FUNCTION]++;
>         }
>
> +       if (action & SMP_IRQ_WORK) {
> +               irq_work_run();
> +               info->ipi_irqs[IPI_IRQ_WORK]++;
> +       }
> +
>         return IRQ_HANDLED;
>  }
>
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index 0dfe2388ef41..7366de776f6e 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -13,6 +13,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq_work.h>
>  #include <linux/profile.h>
>  #include <linux/seq_file.h>
>  #include <linux/smp.h>
> @@ -70,6 +71,7 @@ static DEFINE_PER_CPU(int, cpu_state);
>  static const char *ipi_types[NR_IPI] __tracepoint_string =3D {
>         [IPI_RESCHEDULE] =3D "Rescheduling interrupts",
>         [IPI_CALL_FUNCTION] =3D "Function call interrupts",
> +       [IPI_IRQ_WORK] =3D "IRQ work interrupts",
>  };
>
>  void show_ipi_list(struct seq_file *p, int prec)
> @@ -217,6 +219,13 @@ void arch_smp_send_reschedule(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
>
> +#ifdef CONFIG_IRQ_WORK
> +void arch_irq_work_raise(void)
> +{
> +       mp_ops.send_ipi_single(smp_processor_id(), ACTION_IRQ_WORK);
> +}
> +#endif
> +
>  static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
>  {
>         unsigned int action;
> @@ -234,6 +243,11 @@ static irqreturn_t loongson_ipi_interrupt(int irq, v=
oid *dev)
>                 per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
>         }
>
> +       if (action & SMP_IRQ_WORK) {
> +               irq_work_run();
> +               per_cpu(irq_stat, cpu).ipi_irqs[IPI_IRQ_WORK]++;
> +       }
> +
>         return IRQ_HANDLED;
>  }
>
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren


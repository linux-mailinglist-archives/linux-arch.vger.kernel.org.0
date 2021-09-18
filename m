Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6884104B1
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhIRHYd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 03:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIRHYc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 03:24:32 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F831C061574;
        Sat, 18 Sep 2021 00:23:09 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id t200so4603517vkt.0;
        Sat, 18 Sep 2021 00:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJsSrAwWhlsa4DGBFOs0h4d6FtyaUOuEZliDLkcdxh8=;
        b=Pgv1nGguzHCSVuwqumEkVRZVgJtK/RIv1yTLpNHD2vMciWt2O9RJ2D0z0TQrcwbNl4
         KtwVre9j8gbz0Cadij2psVnViTcvjBaoMPt3RDkqgufeYgLGcG59qSIebbQUMwgZVRzC
         JTE+yQy6fQfLArLKWngoDZ2l98IwjJwGpRXtzlaJWSHFpJsd7FhOp4Il9rSeUIwQDGii
         bXP6Ia66qPzrX85PZt6xcM5I9W5vRgLod89o/5K4QNKqM7WV2IYrpmf2pl1SrUJwcXwN
         xIPlcqR0zpqhEgZaeF4p9RHL7xgNOhJv0e5+UXcFRDfW7gjgtOafQb4VlXL/e5/Wy85H
         D+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJsSrAwWhlsa4DGBFOs0h4d6FtyaUOuEZliDLkcdxh8=;
        b=cLTrwbZU59o2IPkhx5K6y8hMb2Ji4nEJ6j2BQTrPnK+kQqTqW5NJHr1OciOJPj3ziD
         EPUhDi7VpPRG0+7EV31sxZ6dRrJHg0C8c3s7m4Ayr2AJGBTVcxuRDP67P2oajDbq2vMz
         Xu19jU/sV1pqp/rUDJjYHeTXMkquIh3zsmno5YBjSp18nas/MyIK/t2ZuAtjkWTbtiLq
         eVz+S4ZFh2GO0IvCkzFE9tFzzjOWev9AEhlWV1Y4uF/q/awnIQMeYxl5FPVKLVFO8TwY
         alp2pd/EIEcgr/dATk6fGtQL7QKJKuc4vvSAkHOfkId9RATFynTkVdw5Dp3gjbA12ljN
         UUhw==
X-Gm-Message-State: AOAM532YIn1VUhh3YW5yPjEP1OIq3CdG1DSwOfsQDRGEcqB03tuSoOp3
        LOL5sT2k3/c44WJuc4w9PZHy4esnAhVDAE2KPGA=
X-Google-Smtp-Source: ABdhPJz8kzfDXfUg5s+UGhyNC9f4aIPy1Tu+4KVbD72w8T6of9b1In0UX2NsGnCsGYa5CfsfhCWWRL8m/WrPJ5SSpYo=
X-Received: by 2002:a1f:b2d6:: with SMTP id b205mr5053277vkf.11.1631949788458;
 Sat, 18 Sep 2021 00:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-21-chenhuacai@loongson.cn> <CAK8P3a0N=SA-E7ChrMrA5Gv6TDMzJ4_QNUN5OzpJWgzyJwcboA@mail.gmail.com>
In-Reply-To: <CAK8P3a0N=SA-E7ChrMrA5Gv6TDMzJ4_QNUN5OzpJWgzyJwcboA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 18 Sep 2021 15:22:57 +0800
Message-ID: <CAAhV-H4C2ZDO4P_Xy8ic_wjmT7PHNCDfrKKQRZw-A4tgr6Y=aw@mail.gmail.com>
Subject: Re: [PATCH V3 20/22] LoongArch: Add multi-processor (SMP) support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Sep 17, 2021 at 5:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > +
> > +struct task_struct;
> > +
> > +struct plat_smp_ops {
> > +       void (*send_ipi_single)(int cpu, unsigned int action);
> > +       void (*send_ipi_mask)(const struct cpumask *mask, unsigned int action);
> > +       void (*smp_setup)(void);
> > +       void (*prepare_cpus)(unsigned int max_cpus);
> > +       int (*boot_secondary)(int cpu, struct task_struct *idle);
> > +       void (*init_secondary)(void);
> > +       void (*smp_finish)(void);
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +       int (*cpu_disable)(void);
> > +       void (*cpu_die)(unsigned int cpu);
> > +#endif
> > +};
>
>
> Do you foresee having more than one implementation of these in the
> near future? If not, I would suggest leaving out the extra indirection
> and just using direct function calls.
OK, let me rethink this, if it is still needed, I will tell you why.

>
> > +#ifdef CONFIG_SMP
> > +
> > +static inline void plat_smp_setup(void)
> > +{
> > +       extern const struct plat_smp_ops *mp_ops;       /* private */
> > +
> > +       mp_ops->smp_setup();
> > +}
> > +
> > +#else /* !CONFIG_SMP */
> > +
> > +static inline void plat_smp_setup(void) { }
> > +
> > +#endif /* !CONFIG_SMP */
>
> You could even go further and do what arch/arm64 has, making
> SMP support unconditional. This obviously depends on hardware
> roadmaps, but if all harfdware you support has multiple cores,
> then non-SMP mode just adds complexity.
As mentioned in another patch, we do have some MCU hardware (no FP, no
SMP, and even no MMU).

>
> > +
> > +#define MAX_CPUS 64
>
> You CONFIG_NR_CPUS allows up to 256. I think you need to
> adjust one of the numbers to match the other, or remove this
> definition and just use CONFIG_NR_CPUS directly.
Legacy IPI method only supports at most 64 CPUs (limited by the MMIO
register space). Maybe we can remove the whole legacy method support,
then we can remove MAX_CPUS, too.
>
> > +
> > +static volatile void *ipi_set_regs[MAX_CPUS];
> > +static volatile void *ipi_clear_regs[MAX_CPUS];
> > +static volatile void *ipi_status_regs[MAX_CPUS];
> > +static volatile void *ipi_en_regs[MAX_CPUS];
> > +static volatile void *ipi_mailbox_buf[MAX_CPUS];
>
> Why are these 'volatile'? If they are MMIO registers, they
> should be __iomem, and accessed using readl()/writel()
>  etc
Yes, they are MMIO registers and __iomem is needed.

Huacai
>
>        Arnd

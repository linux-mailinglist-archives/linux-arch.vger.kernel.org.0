Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531E43EB266
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhHMIPF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhHMIPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Aug 2021 04:15:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE814C061756
        for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2021 01:14:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id i7so12194118iow.1
        for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2021 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3LSF36mlejtzTdyaHMLV+sXuC+PZZC3E672znDFvCo=;
        b=Sq58kSgDS2Oihd/bvRns0d7h1qJpQNWQSCI5nUBs0FfzvoLKe40rJk8uHWa3v15+8A
         SmVmd54zX+2nGmxFJkgtlSRGgxibvo73oJ8ozd2a5n9XX3tfBW+0hii0QUqsIXhHC5TF
         iIhD6N6AzyudW0LXOx9ehEFV1zP06t3VGQci5D41yJU74v4B4p1PerkwscZaVaV/sHb+
         MNdorlvbfOI2FBFn8yuccT921h1J/cf3Jza9CBNKHq9I+1CapQn7DauHx5PVD7e829Eo
         9zFwz0G/sRV4Xw9EjbsdbXDwT1k3ibmaq6x9vCvWfMVRI+5R8iMusE6DlWTcQEwnJDoY
         oTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3LSF36mlejtzTdyaHMLV+sXuC+PZZC3E672znDFvCo=;
        b=nX/6zGy8ac34bq1xfAhwBKNl01wX2/i3FMY8oXkyaou0pZ1LMWcuAeEVKI2QSKxq6+
         gx70EY3O0gaEhSKcNZ/1dhdzD/ELDubxysFE/hsU8IoOeNMQ5g6h1Gxss1HFZvwYOrRv
         ska3SBC/JcvfTrvH5TvCTU8DGztd6ZUJik9AMvCO+yqP4a2QxuJx7lgxQ3Pa94dMIUUW
         Hvp2759eGVeBHtso0op3oHC2Kj3KUJ+F5SHTBcqRwXUt6WJdywKrm/3VeW10dsDMwk1w
         BahKc0lAsbcKyk0gBtu91vxYSlTZaym1or59F3tUjgVEuTzNeE5SQL/qOdwczPu957B+
         0wOg==
X-Gm-Message-State: AOAM530SJTxyrVCzo10Ta9AUAb5kz+98oxpR4nl4wq9Wa1E4wyu4nlS+
        VT2D2lDvWT5rjx19KXAb0cEZOtk4Hbui0HF/K6RDJiYsoE4=
X-Google-Smtp-Source: ABdhPJxf/JLxf9nKH4i2LmbfzGLbxBogkI7hZzk8MGQ8pLXjTAEsQezkJOxDS6EcJC6tmArMNbBPYeWTMRTV4bhLHDc=
X-Received: by 2002:a05:6602:1210:: with SMTP id y16mr1090804iot.159.1628842478164;
 Fri, 13 Aug 2021 01:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com> <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
In-Reply-To: <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 13 Aug 2021 16:14:26 +0800
Message-ID: <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Aug 13, 2021 at 3:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 13, 2021 at 5:30 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Thu, Aug 12, 2021 at 8:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > +#ifdef CONFIG_VA_BITS_40
> > > > > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits))
> > > > > > +#endif
> > > > > > +#ifdef CONFIG_VA_BITS_48
> > > > > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 48)?48:cpu_vabits))
> > > > > > +#endif
> > > > >
> > > > > Why would the CPU have fewer VA bits than the page table layout allows?
> > > > PAGESIZE is configurable, so the range a PGD can cover is various, and
> > > > VA40/VA48 is not exactly 40bit/48bit, but 40bit/48bit in maximum.
> > >
> > > Do you mean the page size is not a compile-time constant in this case?
> > >
> > > What are the combinations you can support? Is this a per-task setting
> > > or detected at boot time?
> > Page size is a compile-time configuration. Maybe you or maybe me get
> > lost here.:)
> > What I want to do here:
> > 1, I want to provide VA40 and VA48 for user-space.
> > 2, CPU's VA bits may be 32, 36, 40, 48 or other values (so we need
> > (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits)) or something similar).
> > 3, The range a PGD can cover depends on PAGE SIZE (so it cannot
> > exactly equals to 40/48).
>
> I still don't see what is special about 40 and 48. From what I can tell,
> you have two constraints: the maximum address space size for
> the kernel configuration based on the page size and number of
> page table levels, and the capabilities of the CPU as described
> in the CPUCFG1 register.
>
> What is the point of introducing an arbitrary third compile-time
> limit here rather than calculating it from the page page size?
So your problem is why we should provide two configurations VA40 and
VA48? This is derived from MIPS of course, but I found that RISC-V and
ARM64 also provide VA BITS configuration.

Huacai
>
> > > I would suggest you don't plan to ever add LPX32 in this case, it
> > > has never really caught on for any of the architectures that support
> > > it other than mips, and even there I don't think it is used much
> > > any more.
> > >
> > > It's certainly easier to have fewer ABI options.
> > LPX32 is just a placeholder now, and maybe a placeholder for ever. :)
>
> Ok, fair enough.
>
>
>        Arnd

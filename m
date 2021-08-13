Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896D23EAEF4
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 05:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhHMDbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbhHMDbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 23:31:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDEC061756
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 20:30:57 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q16so9076014ioj.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrF9u2JubjW1zz5CS8guGYv8XWbUNIxLYVXnijVvW0g=;
        b=BxFLwBhdTfgOc3V3OZ7HJ+mIX/0DYHyzumf3ePvh2C0OyqNyikx3gI7cqxeT3OOuz5
         UJ4KMUwTB70a9RqE7y4hXO+U4vdRyRNyFcfO9FMLXAwwWDIGhHDcoscZzfVUAT3FFNk/
         I3cTU2nBTZkEJmAV0pqtg35EszfGDVUkhcNu8CwHVbQkksgUpldhAn48HbXWFdPNZREB
         zV59YXZ3rVqrwDXYIdapWFv8mfls9RtVG2M2OOdCcKdwNUdXzBYNTdmr0k0I9as36MoH
         ZZX1wjFqaZWIF5Fq/fN0XICEUdy3MrkkRhA1JDSch42h6k6iP06aw2BROTE0etCv5N6f
         ngJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrF9u2JubjW1zz5CS8guGYv8XWbUNIxLYVXnijVvW0g=;
        b=CEQviEfTcSbRp5dnENMto3oLm4hC855oEcVoaRRpDcvNhQ5iiGpm0GpodaHc9w26v6
         /ExWEQHQXbfNVnZzxiqBCa2OmN5jzjL5y0gk/DEBtUEg/or73yP/rSeUc+DXvCSOAOsT
         iG8dsnIpMmOZm8n8yot2R0HJWOlwJLR32f3zHHBx/8FgzzTQCJa3HBPjqJhp4RxTe+bS
         Vd4uvY5G90bUiPbC0sqT2E1uzBJkujOkQVX7Y98zu6dzbWFtHKx/yo1oalfOGiSJYqRA
         ingOY+hIykK9Zjee6+AMUNK3GLneJcZGXrpfOkB0YJ/WAhMqq1ctLKgpIJqBmRl7+DnU
         909A==
X-Gm-Message-State: AOAM531XhXUV04yf/7IFzHYvveB0ZJWqPMeJm+Eo7YR8xWzuKkWnLSUx
        QIAPjfMfLwOxfksGWz8OcOLdq6VHVMl6DSHGGTU=
X-Google-Smtp-Source: ABdhPJxPwulQUSqJGRnIDn0mQ/NH4ljoapL/+gjlFEGvcTAQiy8+c/7xXljkk/Ee/Fy6kL4PcjT8pchmXJaRouUJhko=
X-Received: by 2002:a05:6638:14d:: with SMTP id y13mr223293jao.78.1628825456488;
 Thu, 12 Aug 2021 20:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com> <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 13 Aug 2021 11:30:44 +0800
Message-ID: <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
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

On Thu, Aug 12, 2021 at 8:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 12, 2021 at 1:05 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > +
> > > > +static inline void check_bugs(void)
> > > > +{
> > > > +       unsigned int cpu = smp_processor_id();
> > > > +
> > > > +       cpu_data[cpu].udelay_val = loops_per_jiffy;
> > > > +}
> > >
> > > This needs a comment to explain what bug you are working around.
> > OK, there is "no bug" at present, just set the CPU0's udelay_val here.
>
> Can you do this elsewhere?
>
> I think the normal place would be somewhere around calibrate_delay(),
> which has various options.
>
> If the CPU has a well-defined hardware timer, you should not need to
> know any loops_per_jiffy value but simply wait for the correct number
> of cycles in delay()
OK, this seems need to be reworked.

>
> > > Can you send a cleanup patch for this? I think we should get rid of the
> > > isa_dma_bridge_buggy variable for architectures that do not have a VIA
> > > VP2 style ISA bridge.
> > We doesn't need ISA, but isa_dma_bridge_buggy is needed in drivers/pci/pci.c
>
> Ah right, of course. We should clean that up one day so architectures
> don't have to
> define this, I don't think anything but x86 can actually set it to a value other
> than zero.
>
> > > > +#ifdef CONFIG_64BIT
> > > > +#define TASK_SIZE32    0x80000000UL
> > >
> > > Why is the task size for compat tasks limited to 2GB? Shouldn't these
> > > be able to use the full 32-bit address space?
> > Because we use 2:2 to split user/kernel space.
>
> Usually in compat mode, the user process can access all 4GB though, regardless
> of what native 32-bit tasks can do.
>
> Is there a limitation on loongarch that prevents you from doing this?
Emm, we can define COMPAT32 to 4GB now.

>
> > > > +#ifdef CONFIG_VA_BITS_40
> > > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits))
> > > > +#endif
> > > > +#ifdef CONFIG_VA_BITS_48
> > > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 48)?48:cpu_vabits))
> > > > +#endif
> > >
> > > Why would the CPU have fewer VA bits than the page table layout allows?
> > PAGESIZE is configurable, so the range a PGD can cover is various, and
> > VA40/VA48 is not exactly 40bit/48bit, but 40bit/48bit in maximum.
>
> Do you mean the page size is not a compile-time constant in this case?
>
> What are the combinations you can support? Is this a per-task setting
> or detected at boot time?
Page size is a compile-time configuration. Maybe you or maybe me get
lost here.:)
What I want to do here:
1, I want to provide VA40 and VA48 for user-space.
2, CPU's VA bits may be 32, 36, 40, 48 or other values (so we need
(0x1UL << ((cpu_vabits > 40)?40:cpu_vabits)) or something similar).
3, The range a PGD can cover depends on PAGE SIZE (so it cannot
exactly equals to 40/48).

>
>
> > > > +/*
> > > > + * Subprogram calling convention
> > > > + */
> > > > +#define _LOONGARCH_SIM_ABILP32         1
> > > > +#define _LOONGARCH_SIM_ABILPX32                2
> > > > +#define _LOONGARCH_SIM_ABILP64         3
> > >
> > > What is the difference between ILP32 and ILPX32 here?
> > >
> > > What is the ILP64 support for, do you support both the regular LP64 and ILP64
> > > with 64-bit 'int'?
> > ABILP is ABI-LP, not AB-ILP. :). LP32 is native 32bit ABI, LP64 is
> > native 64bit ABI, and LPX32 something like MIPS N32/X86 X32 (not exist
> > in the near future).
>
> I would suggest you don't plan to ever add LPX32 in this case, it
> has never really caught on for any of the architectures that support
> it other than mips, and even there I don't think it is used much
> any more.
>
> It's certainly easier to have fewer ABI options.
LPX32 is just a placeholder now, and maybe a placeholder for ever. :)

Huacai
>
>         Arnd

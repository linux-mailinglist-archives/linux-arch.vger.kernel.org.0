Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236DE3EA4D8
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhHLMqb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 08:46:31 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhHLMqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 08:46:31 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxmBi-1n2OdW48zO-00zCea for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021
 14:46:05 +0200
Received: by mail-wr1-f42.google.com with SMTP id b13so8160176wrs.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:46:04 -0700 (PDT)
X-Gm-Message-State: AOAM531/ka18kRKWiViDYuntHaUaMs+49r4V+a58QRUoFpurZHfbQa0F
        03wE41z7mMCNzXYalxtqEzDtFJMPkrEOfgVh6XI=
X-Google-Smtp-Source: ABdhPJzwtG/dlK+kXvUBRjBcpvNT5ecTGgff7CiTNaIGPPgG52L0CrXTnkwHHG8Y8vEzJMX1zSebADcbtQ8j3jDrQhw=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr3987820wrr.286.1628772364687;
 Thu, 12 Aug 2021 05:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Aug 2021 14:45:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
Message-ID: <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
X-Provags-ID: V03:K1:ifVJnFNw93GMEu9q1IFJ1FPF+K2BlxVjbCaWMbXitPAjeyONhka
 KvtZTSElEldXiLxEK3pymFFBEkLh8i0x3raWEY24Gllodh+VEIlnL+FI5E2Ze0HjhQnXLBL
 OUW5VhEzyz/TSPWvhtMS3q6o1Yf5bC00NtC9MCDYLBuaXnZ0pAm0KBKjK2qppracjaw0VMq
 DkbhGFXWJJZwG/sq0zXVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pksis8HpSUk=:pkAjNKRuP73Kpm9g6DJIdI
 gJvWpk7JMNwNBjayYXI3Cz5tZWAJSncgZZr3bXST1lNpH5vhQjRH1ZBiKTP5f42zkUbY8tazt
 ujF0t/wySZuVqn2fXKad14Xk9FNWIVzimPcgAB7n1euhwjaJQnOzfvJyAKlTAfq/brRwFlCQK
 kNIByz/I2Pag4cgqG3FpqJvtK79POFA/y7Sza/EmSit2jEUkSTwJCfMrjbN6nov0OOuOWxSzG
 46gyXdigMIt/jmqJ9P0vXBvqaPo59C4rLsrTpVA08/LcKwuGrW6d9E2Q5V85BC120+PczR3/4
 gW6bId8ZS3iyIcCMvLb+cd/WM1L0F4FtknBh5imIaZwSFof6Q4RLjK+sm4UlO5fVjhmMxN5dG
 LoeS+oIEwhSWwZasoZ+mYZGdzMzt681ASHaCp3HTFHNXfw+4EXH87vMYiy+6+BBGY+cOcu3e3
 akdI5Bx5hyzRcEPtnFEq3OMYObb9UU66IwqjYWI/MrMjLxNCdP09wFCqhv6s2Yoew0YAvguPC
 XTJ3Yfc2OwBdWi3fmBXLih1RiwW+c9MLlnpsH1S8a3BvMj6JxvSbo6rfwW84i8B6aCocTATMf
 7OVp7X4Ie2thSa523H3y8CvbIliR8kzpWKlP2lIm3Aaq0ACyLhL/UC8a+xrR4Hu49POT8GzDd
 l4PJuiYOA9IA1b+6fkQkWwne+GCAHdrwYrKjfr85s5H82Pa/S8LAvghdt+OsBNZ0j8Kvd9qXZ
 HSztj6vY6yyvfUlu9xPezyWle5Dx3uoLXJE8NhqEhslBTdDoa9q09trvd7LGilkaXT1iEtnSn
 5qmWrGhe+v4EYBJnIwpwseFZa6KkZzK4YD/fs6xEqtKr9EOEm3c8t+302i1ARPdvysxvL1AlS
 m9utSMjNe03msyC40zrmY7xBm9FoXUM7pAfrcVw6Rd0Q/4zgKgDn39heJXBMFqoviJDNFooDT
 F89xFMdgMe1uqgRUYuLry4LPG7qKhfv2F85MQYqH2RRKVRZvOYImr
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 12, 2021 at 1:05 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > +
> > > +static inline void check_bugs(void)
> > > +{
> > > +       unsigned int cpu = smp_processor_id();
> > > +
> > > +       cpu_data[cpu].udelay_val = loops_per_jiffy;
> > > +}
> >
> > This needs a comment to explain what bug you are working around.
> OK, there is "no bug" at present, just set the CPU0's udelay_val here.

Can you do this elsewhere?

I think the normal place would be somewhere around calibrate_delay(),
which has various options.

If the CPU has a well-defined hardware timer, you should not need to
know any loops_per_jiffy value but simply wait for the correct number
of cycles in delay()

> > Can you send a cleanup patch for this? I think we should get rid of the
> > isa_dma_bridge_buggy variable for architectures that do not have a VIA
> > VP2 style ISA bridge.
> We doesn't need ISA, but isa_dma_bridge_buggy is needed in drivers/pci/pci.c

Ah right, of course. We should clean that up one day so architectures
don't have to
define this, I don't think anything but x86 can actually set it to a value other
than zero.

> > > +#ifdef CONFIG_64BIT
> > > +#define TASK_SIZE32    0x80000000UL
> >
> > Why is the task size for compat tasks limited to 2GB? Shouldn't these
> > be able to use the full 32-bit address space?
> Because we use 2:2 to split user/kernel space.

Usually in compat mode, the user process can access all 4GB though, regardless
of what native 32-bit tasks can do.

Is there a limitation on loongarch that prevents you from doing this?

> > > +#ifdef CONFIG_VA_BITS_40
> > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits))
> > > +#endif
> > > +#ifdef CONFIG_VA_BITS_48
> > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 48)?48:cpu_vabits))
> > > +#endif
> >
> > Why would the CPU have fewer VA bits than the page table layout allows?
> PAGESIZE is configurable, so the range a PGD can cover is various, and
> VA40/VA48 is not exactly 40bit/48bit, but 40bit/48bit in maximum.

Do you mean the page size is not a compile-time constant in this case?

What are the combinations you can support? Is this a per-task setting
or detected at boot time?


> > > +/*
> > > + * Subprogram calling convention
> > > + */
> > > +#define _LOONGARCH_SIM_ABILP32         1
> > > +#define _LOONGARCH_SIM_ABILPX32                2
> > > +#define _LOONGARCH_SIM_ABILP64         3
> >
> > What is the difference between ILP32 and ILPX32 here?
> >
> > What is the ILP64 support for, do you support both the regular LP64 and ILP64
> > with 64-bit 'int'?
> ABILP is ABI-LP, not AB-ILP. :). LP32 is native 32bit ABI, LP64 is
> native 64bit ABI, and LPX32 something like MIPS N32/X86 X32 (not exist
> in the near future).

I would suggest you don't plan to ever add LPX32 in this case, it
has never really caught on for any of the architectures that support
it other than mips, and even there I don't think it is used much
any more.

It's certainly easier to have fewer ABI options.

        Arnd

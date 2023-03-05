Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB06AAF72
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCEMTO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 07:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCEMTN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 07:19:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC05E07F;
        Sun,  5 Mar 2023 04:19:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79DD60A54;
        Sun,  5 Mar 2023 12:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18100C433A0;
        Sun,  5 Mar 2023 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678018751;
        bh=eaCWuGYM9w2VikIC3ptHBvXxP1mOVgZ4wreQHD81Uxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sibKS33VbRqkU21P3oHklXd8gYnm0+bd2m5OWXY1IiKAZzvXD9Ocgk1VQAC0SVAZO
         zesHPuha5GAInx110yVLuYJnQ3hE0aeu1IfaPuV5y+MEJxnNYFo5fJqVDKjdit6PtY
         fWb8K7uy2NrAa766LzELwt+RPpBELMVEJcqyC3AhV72X2A1SNh3FqD2pf6v5D0Di0Z
         HjcqALi/rUzkx6wNZy7+pRb88SHV05JssascfrqBrpV5hYVB4X09YhXKCG8tSiHf5R
         dLQ43zT+C/6cYjFSF2k3VBh5aMWDElHAQsWAL+0LiqaeKON8QmxzuID5z3I29u6dz0
         79oPHPiLzvIzQ==
Received: by mail-ed1-f50.google.com with SMTP id i34so27749000eda.7;
        Sun, 05 Mar 2023 04:19:11 -0800 (PST)
X-Gm-Message-State: AO0yUKW1w1+2nl68bdpfzQNQ3S99h8eHGI746fbRGuCIa1n7otvLUhvD
        ANmS/Fc5exP3IjGQsRah0SopO/ywCWf38k2vTg0=
X-Google-Smtp-Source: AK7set9HpSqnBuNpG80A12biEE3obOYDBysgdv7zsSl6uIn/ixbsWEZFTSp5H3jXGZIX4xtaGv3ccl3ST0qpDr2RNu8=
X-Received: by 2002:a17:906:d041:b0:87b:da7a:f202 with SMTP id
 bo1-20020a170906d04100b0087bda7af202mr3308431ejb.1.1678018749262; Sun, 05 Mar
 2023 04:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20230305052818.4030447-1-chenhuacai@loongson.cn> <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
In-Reply-To: <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 5 Mar 2023 20:18:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
Message-ID: <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Provide kernel fpu functions
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sun, Mar 5, 2023 at 1:53=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wrot=
e:
>
> On 3/5/23 13:28, Huacai Chen wrote:
> > Provide kernel_fpu_begin()/kernel_fpu_end() to let the kernel use fpu
> > itself. They can be used by AMDGPU graphic driver for DCN.
>
> Grammar nit: "itself" is wrongly placed. "allow the kernel itself to use
> FPU" could be better.
>
> Also the expected usage is way broader than a single driver's single
> component. It's useful for a wide array of operations that will benefit
> from SIMD acceleration support that'll hopefully appear later. For now
> I'd suggest at least adding a single "e.g." after "used by" to signify
> this, if you're not rewording the sentence.
OK, I will update it.

>
> >
> > Reported-by: Xuerui Wang <kernel@xen0n.name>
> Thanks, but I prefer my name spelled in the native word order ;-)
OK, I will correct it.

> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/fpu.h |  3 +++
> >   arch/loongarch/kernel/Makefile   |  2 +-
> >   arch/loongarch/kernel/kfpu.c     | 41 +++++++++++++++++++++++++++++++=
+
> >   3 files changed, 45 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/loongarch/kernel/kfpu.c
> >
> > diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/=
asm/fpu.h
> > index 358b254d9c1d..192f8e35d912 100644
> > --- a/arch/loongarch/include/asm/fpu.h
> > +++ b/arch/loongarch/include/asm/fpu.h
> > @@ -21,6 +21,9 @@
> >
> >   struct sigcontext;
> >
> > +extern void kernel_fpu_begin(void);
> > +extern void kernel_fpu_end(void);
> > +
> >   extern void _init_fpu(unsigned int);
> >   extern void _save_fp(struct loongarch_fpu *);
> >   extern void _restore_fp(struct loongarch_fpu *);
> > diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Mak=
efile
> > index 78d4e3384305..9a72d91cd104 100644
> > --- a/arch/loongarch/kernel/Makefile
> > +++ b/arch/loongarch/kernel/Makefile
> > @@ -13,7 +13,7 @@ obj-y               +=3D head.o cpu-probe.o cacheinfo=
.o env.o setup.o entry.o genex.o \
> >   obj-$(CONFIG_ACPI)          +=3D acpi.o
> >   obj-$(CONFIG_EFI)           +=3D efi.o
> >
> > -obj-$(CONFIG_CPU_HAS_FPU)    +=3D fpu.o
> > +obj-$(CONFIG_CPU_HAS_FPU)    +=3D fpu.o kfpu.o
> >
> >   obj-$(CONFIG_ARCH_STRICT_ALIGN)     +=3D unaligned.o
> >
> > diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.=
c
> > new file mode 100644
> > index 000000000000..cd2a18fecdcc
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/kfpu.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/init.h>
> > +#include <asm/fpu.h>
> > +#include <asm/smp.h>
> > +
> > +static DEFINE_PER_CPU(bool, in_kernel_fpu);
> > +
> > +void kernel_fpu_begin(void)
> > +{
> > +     if(this_cpu_read(in_kernel_fpu))
> > +             return;
> Could be a conditional WARN_ON_ONCE like in arch/x86?
> > +
> > +     preempt_disable();
> > +     this_cpu_write(in_kernel_fpu, true);
> > +
> > +     if (!is_fpu_owner())
> > +             enable_fpu();
> > +     else
> > +             _save_fp(&current->thread.fpu);
> > +}
> > +EXPORT_SYMBOL_GPL(kernel_fpu_begin);
>
> Might be good to provide some explanation in the commit message as to
> why the pair of helpers should be GPL-only. Do they touch state buried
> deep enough to make any downstream user a "derivative work"? Or are the
> annotation inspired by arch/x86?
Yes, just inspired by arch/x86, and I don't think these symbols should
be used by non-GPL modules.

Huacai
>
> I think this kinda needs more thought, because similar operations like
> arm's kernel_neon_{begin,end}, powerpc's enable_kernel_{fp,vsx,altivec}
> or s390's __kernel_fpu_{begin,end} are not made GPL-only. Making these
> helpers GPL-only precludes any non-GPL module to make use of SIMD on
> LoongArch, which may or may not be what you want. This can have
> commercial consequences so I can only leave the decision to you.
> (Although IMO the semantics are encapsulated and high-level enough to
> not warrant GPL-only marks, but it may well be the case that you have
> thought of something else but didn't mention here.)
>
> > +
> > +void kernel_fpu_end(void)
> > +{
> > +     if(!this_cpu_read(in_kernel_fpu))
> > +             return;
> > +
> > +     if (!is_fpu_owner())
> > +             disable_fpu();
> > +     else
> > +             _restore_fp(&current->thread.fpu);
> > +
> > +     this_cpu_write(in_kernel_fpu, false);
> > +     preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(kernel_fpu_end);
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>

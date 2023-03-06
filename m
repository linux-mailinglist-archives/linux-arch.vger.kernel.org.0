Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F066ABFD4
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 13:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCFMtg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 07:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFMte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 07:49:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF312265A0;
        Mon,  6 Mar 2023 04:49:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 670A0B80E01;
        Mon,  6 Mar 2023 12:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF60C4339E;
        Mon,  6 Mar 2023 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678106971;
        bh=ZVAeDaw8Bjw0ZWq26G0vbEl1cHK0g7tJ4/XCL+s6YhM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GySefDdZikQqjE8E0Dv0GxgvaN8nPi/ZcIPhgYsnV5EsRx2JaE4PjBp6C7Mx8ow+l
         +5mFHhTwcOSn/zjn61JLDk5O4Xw+bbFsRAT+CMnNvVBohTLJpTVZAIIjRQ7/aadzrq
         6UpCWgrMkmA8z4IEKeKwr6shWTtfCw2aZZ1xoqfjaR0iHNsbG3Ji6UiruXwNkY3Vl2
         VbHgnzC+kf85qIYK041etERwYUCV4RFX/+4gmsO061z5DzhdCWQnhlMeTo4rRqCgqe
         fWBFYeMopZai+ASP/EInA4mENKZiVZDaa6MywcUTgAPiBmShI+N+syzkwhLUtlKNrS
         80OKs7PBk/fiA==
Received: by mail-ed1-f50.google.com with SMTP id k10so14124360edk.13;
        Mon, 06 Mar 2023 04:49:30 -0800 (PST)
X-Gm-Message-State: AO0yUKUyHcpIzxqQfcRuGj4mDmelMOSa3PIuUDfrwTTfASenDhzKoqjh
        C7WIf6UpI2Mvnvi4k5PubW1kbon+R3FflpS+TuQ=
X-Google-Smtp-Source: AK7set/68S6FBEZWrciQcx1rE28acaJnul7BjG0QtBvr7bA1iHQjNFZ6QOhdb5LQlNVacW9xtPkUEBbG+F4OOR2wer8=
X-Received: by 2002:a17:906:2a55:b0:8b2:fa6d:45e3 with SMTP id
 k21-20020a1709062a5500b008b2fa6d45e3mr4626371eje.1.1678106969196; Mon, 06 Mar
 2023 04:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20230306095934.609589-1-chenhuacai@loongson.cn> <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
In-Reply-To: <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 6 Mar 2023 20:49:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6_-iVAK6-MmfJq12JBzD6nyYNOiObEbzu8yzew3raAvg@mail.gmail.com>
Message-ID: <CAAhV-H6_-iVAK6-MmfJq12JBzD6nyYNOiObEbzu8yzew3raAvg@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Provide kernel fpu functions
To:     maobibo <maobibo@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 6, 2023 at 8:03=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote:
>
>
>
> =E5=9C=A8 2023/3/6 17:59, Huacai Chen =E5=86=99=E9=81=93:
> > Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> > to use fpu. They can be used by some other kernel components, e.g., the
> > AMDGPU graphic driver for DCN.
> Since kernel is compiled with -msoft-float, I guess hw fpu will not be
> used in kernel by present:). However it is deserved to try.
> >
> > Reported-by: WANG Xuerui <kernel@xen0n.name>
> > Tested-by: WANG Xuerui <kernel@xen0n.name>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> > V2: Use non-GPL exports and update commit messages.
> > V3: Add spaces for coding style.
> >
> >  arch/loongarch/include/asm/fpu.h |  3 +++
> >  arch/loongarch/kernel/Makefile   |  2 +-
> >  arch/loongarch/kernel/kfpu.c     | 41 ++++++++++++++++++++++++++++++++
> >  3 files changed, 45 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/loongarch/kernel/kfpu.c
> >
> > diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/=
asm/fpu.h
> > index 358b254d9c1d..192f8e35d912 100644
> > --- a/arch/loongarch/include/asm/fpu.h
> > +++ b/arch/loongarch/include/asm/fpu.h
> > @@ -21,6 +21,9 @@
> >
> >  struct sigcontext;
> >
> > +extern void kernel_fpu_begin(void);
> > +extern void kernel_fpu_end(void);
> > +
> >  extern void _init_fpu(unsigned int);
> >  extern void _save_fp(struct loongarch_fpu *);
> >  extern void _restore_fp(struct loongarch_fpu *);
> > diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Mak=
efile
> > index 78d4e3384305..9a72d91cd104 100644
> > --- a/arch/loongarch/kernel/Makefile
> > +++ b/arch/loongarch/kernel/Makefile
> > @@ -13,7 +13,7 @@ obj-y               +=3D head.o cpu-probe.o cacheinfo=
.o env.o setup.o entry.o genex.o \
> >  obj-$(CONFIG_ACPI)           +=3D acpi.o
> >  obj-$(CONFIG_EFI)            +=3D efi.o
> >
> > -obj-$(CONFIG_CPU_HAS_FPU)    +=3D fpu.o
> > +obj-$(CONFIG_CPU_HAS_FPU)    +=3D fpu.o kfpu.o
> >
> >  obj-$(CONFIG_ARCH_STRICT_ALIGN)      +=3D unaligned.o
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
> > + * Copyright (C) 2023 Loongson Technology Corporation Limited
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
> > +     if (this_cpu_read(in_kernel_fpu))
> > +             return;
> > +
> > +     preempt_disable();
> > +     this_cpu_write(in_kernel_fpu, true);
> > +
> > +     if (!is_fpu_owner())
> > +             enable_fpu();
> > +     else
> > +             _save_fp(&current->thread.fpu);
> Do we need initialize fcsr rather than using random fcsr value
> of other processes? There may be fpu exception enabled by
> other tasks.
Emm, I think initialize fcsr to 0 is better here.

Huacai
>
> Regards
> Bibo,mao
> > +}
> > +EXPORT_SYMBOL(kernel_fpu_begin);
> > +
> > +void kernel_fpu_end(void)
> > +{
> > +     if (!this_cpu_read(in_kernel_fpu))
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
> > +EXPORT_SYMBOL(kernel_fpu_end);
>
>

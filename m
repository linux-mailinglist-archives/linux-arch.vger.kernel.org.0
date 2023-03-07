Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA86AD437
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 02:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCGBpS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 20:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCGBpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 20:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A96BC1C;
        Mon,  6 Mar 2023 17:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 136E6611B1;
        Tue,  7 Mar 2023 01:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD8BC433A1;
        Tue,  7 Mar 2023 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678153496;
        bh=gwlXOz8qJASElChYdPCQZzH+nKUjLYyMtvDaP1l7Ghw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H6oke7/ZDH/8qFMbBbjxbF1qaBufik18VklEMB4yjaFCCOCbun++pgdaXoRcc8dRC
         wPVAk467daTvmkqkG27Bz40eOtmr/FYiX3yYNQydSxDcDmQmWalu39HLWVbmZTgivn
         kMeTci1w8IKDMuiWYiL16hUXjS99srLuc3nJSfXHRE1TLYuo/oEEP8A+cPxmHIBhS4
         4rjocjGzJ3ljyK/AltLKR6ACpzTOPCpyNZlFOlAl86RQvCGDgb3RTqGicrTdfpH0Bb
         uzRjEx51+e1vua2wEXvPkZfmRjZK7fISjZ0HWRavws6hR99HLnRTYXx+9yc5vSLQi4
         mWUW1YagpM0Pw==
Received: by mail-ed1-f48.google.com with SMTP id cw28so46542054edb.5;
        Mon, 06 Mar 2023 17:44:56 -0800 (PST)
X-Gm-Message-State: AO0yUKWJNJljoDm1Z6nkVOGQuQA3JK5cgyZ40YVQjX18xCSHMPgVf25b
        /NoDkocQJyZvpdhiKuQnAo+seLuuVriZTQOy+FI=
X-Google-Smtp-Source: AK7set8r29SFzGS3jZGz6F+O8XGoNM6a59kPeax72qiPaCpjBe3Z1SeETwiJke+fXwXKGwhLeq9EtDlw4zkwPH6YMYI=
X-Received: by 2002:a17:906:f47:b0:8b0:e909:9136 with SMTP id
 h7-20020a1709060f4700b008b0e9099136mr6411282ejj.1.1678153494634; Mon, 06 Mar
 2023 17:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20230306095934.609589-1-chenhuacai@loongson.cn> <93bf992f70a8400b875a7e70e0cb5234@AcuMS.aculab.com>
In-Reply-To: <93bf992f70a8400b875a7e70e0cb5234@AcuMS.aculab.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 7 Mar 2023 09:44:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H43CKsukRrcD8ZrDH0EA6q7Vo9hJPdXiipdtkaUdxHYFw@mail.gmail.com>
Message-ID: <CAAhV-H43CKsukRrcD8ZrDH0EA6q7Vo9hJPdXiipdtkaUdxHYFw@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Provide kernel fpu functions
To:     David Laight <David.Laight@aculab.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
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

Hi, David,

On Tue, Mar 7, 2023 at 1:17=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Huacai Chen
> > Sent: 06 March 2023 10:00
> >
> > Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
> > to use fpu. They can be used by some other kernel components, e.g., the
> > AMDGPU graphic driver for DCN.
> >
> ...
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
>
> Isn't this check entirely broken?
> It absolutely needs to be inside the preempt_disable().
Yes, you are right, this check should be after preempt_disable().

> If there are nested requests then fpu use is disabled by the first
> kernel_fpu_end() call.
This check should be changed to WARN_ON() as x86 does since nested
requests are unexpected use cases.

>
> > +
> > +     preempt_disable();
> > +     this_cpu_write(in_kernel_fpu, true);
> > +
> > +     if (!is_fpu_owner())
> > +             enable_fpu();
> > +     else
> > +             _save_fp(&current->thread.fpu);
> > +}
>
> More interestingly, unless the kernel is doing the kind of
> 'lazy fpu switch' that x86 used to do (not sure it still does in Linux)
> where the fpu registers can contain values for a different process
> isn't it actually enough for kernel_fpu_begin() to just be:
>
>         preempt_disable();
>         if (current->fpu_regs_live)
I think this condition is the same as is_fpu_owner(). Moreover,
LoongArch doesn't allow fpu-disabled exception occured in kernel, so
we should make sure fpu is enabled at kernel_fpu_begin().

>                 __save_fp(current);
>         preempt_enable();
>
> and for kernel_fpu_end() to basically be a nop.
>
> Then rely on the 'return to user' path to pick up the
> live fpu registers from the save area.
>
> After all, you pretty much don't want to load the fpu regs
> every time a process wakes up and goes back to sleep without
> returning to user.
I think this is not a common case, so it isn't worthy to modify many
files to optimize for now.

Huacai
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>

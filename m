Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979993BE1E6
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 06:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGGE1T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhGGE1P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 00:27:15 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626BC061764
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 21:24:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j12so1045295ils.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcz1KE85DRTg9giGX6svt8//ShX/EsJdsR3u9ngaUEA=;
        b=eT0tamgsqeYTV7E609QjMlhRTaed3nbozdvlkXseWhUpRVm2B7/QJ4m1Eo95fT4ePT
         HV1YJm4kVnRpFBo2hN3z8q6Gv2Wxb9rcIqTGjNFBLR3FsMpVAmB77G4XyluREG8QS5AE
         iskiHO3/sFX1mohR4pYrRhxtnOScSKV0YwBiRrzbdwDL1XoBMS02CJ/g0vaKoBi1zvLO
         xE6XPKiI8AzkLEPfXP8jPZltXY5u1/7j3SbP1RNFQW+Vk/DJiUKzyct1gsfAYBHtTBZi
         ZAjFldAXOkoByibIzTjVjfY6JLwWrR0NE59ciwHoSGqW6PABs2lKywtJEOmX3ttavt6g
         JcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcz1KE85DRTg9giGX6svt8//ShX/EsJdsR3u9ngaUEA=;
        b=EhiUzTshDmkG/BcN56zq8d8/t6nlfSb3LJKB87XCy9PzP82cZSXjDgt6BOhKOSnVNI
         +AIgfUmNnvnHC2PNYzAP+NFzPcqsFfLeAEc6P2sUIisbCjeNndKeV/RxGPP+3i1dfcvG
         7DRzbGq1LEfIPWkEg1FSfTKTPNnGqV6WQTGXbl1whVT6mh9Wvo8U8nXwIHvOXUkX0QvX
         hw7dN5qxW6UHZ+sDWN/dMGtM73GN8r1olJrWS8qZ3OzFxRhynI0JEFhrEnz7bXOeTxKs
         x/ZZm7FFYgZHC4rGC744dFQhF7YmSrBWZTN1IHWJGJos3yiyhXce5xxyVf+oLfPzvY1h
         Nmlg==
X-Gm-Message-State: AOAM533UM/+28sOrWDK+C+XZ3FR3dPr+Qdwvgg1fVGrdpqJPrldoYh9U
        oLK8JYdXGvx7B/g5ld43niQisPxt7spSnWQMo57cgawj
X-Google-Smtp-Source: ABdhPJy8PTimnuXzbnOOZH/BMF//YA2b0uEFDoo7UIuebpWHSogubbmnKiciqMAGvU2MqCvtodOf0ymhKu+O4KBNG08=
X-Received: by 2002:a05:6e02:1074:: with SMTP id q20mr774167ilj.137.1625631872682;
 Tue, 06 Jul 2021 21:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 12:24:21 +0800
Message-ID: <CAAhV-H6q8Cz0bGBZo6dUESwk1wfa75TL6YH+YS1kQe9UzHB=Tg@mail.gmail.com>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
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

On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > diff --git a/arch/loongarch/include/asm/seccomp.h b/arch/loongarch/include/asm/seccomp.h
> > new file mode 100644
> > index 000000000000..220c885f5478
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/seccomp.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_SECCOMP_H
> > +#define __ASM_SECCOMP_H
> > +
> > +#include <linux/unistd.h>
> > +
> > +#include <asm-generic/seccomp.h>
> > +
> > +#endif /* __ASM_SECCOMP_H */
>
> I would expect this file to not be needed.
>
> > diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
> > new file mode 100644
> > index 000000000000..b760aa0a3bc6
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/uaccess.h
> > @@ -0,0 +1,453 @@
> > + * The fs value determines whether argument validity checking should be
> > + * performed or not.  If get_fs() == USER_DS, checking is performed, with
> > + * get_fs() == KERNEL_DS, checking is bypassed.
> > + *
> > + * For historical reasons, these macros are grossly misnamed.
> > + */
>
> You removed set_fs()/get_fs(), which is good, but you forgot to remove
> the comment.
OK, thanks.

>
> > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> > new file mode 100644
> > index 000000000000..6c194d740ed0
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#define __ARCH_WANT_NEW_STAT
>
> Why do you need newstat? I think now that we have statx and the libc
> emulation code on top of it, there is probably no need to support both
> on the kernel side.
>
> > +#define __ARCH_WANT_SYS_CLONE
> > +#define __ARCH_WANT_SYS_CLONE3
>
> Similarly, if you have clone3, you should not need clone.
>
> > +#define __ARCH_WANT_SET_GET_RLIMIT
>
> And here for prlimit64
Is newstat()/clone()/setrlimit() completely unacceptable in a new
arch? If not, I want to keep it here for compatibility, because there
are some existing distros.

>
>
> > +void *sys_call_table[__NR_syscalls] = {
> > +       [0 ... __NR_syscalls - 1] = sys_ni_syscall,
> > +#include <asm/unistd.h>
> > +       __SYSCALL(__NR_clone, __sys_clone)
> > +       __SYSCALL(__NR_clone3, __sys_clone3)
> > +};
>
> I would suggest expressing this as
>
> #defined sys_clone3 __sys_clone3
>
> instead of overriding the other entries.
OK, thanks.

Huacai
>
>           Arnd

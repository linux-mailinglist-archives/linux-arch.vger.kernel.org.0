Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2641E3BCB33
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhGFLBN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbhGFLBM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:01:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69336619D4
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569114;
        bh=HPPt1Em5oYLcEt8CxrluPTLqH77qcHF5mqnyiQTyehk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nnljzY2LCOi/Fd1JQ4iWlVVuJaiOqY5NsSR6sSSOgwtYtmRzA4o5AaDjBu3myaQdH
         PL2glztKCjiN/zOklYM9hofym0gQQagFhMzghlN+EpQs6WKBaJ6G1Ire0F84Ds50uw
         S1x3epHVcB2H/HHai3QxDl7rJ6lSvQlrtLQRjOxG8qj4JJOK6AzOnM1VVZkOWDT/zW
         wInrzZNx3a5v4p+V1HajeV8oalzM1a7Z/DUrBwarXAPIaAIgEOgoGHmOaPaXBtxjft
         VO++s8hizusJW3IidLm3pYGjdxkXmpSxClSGLcwF2a0dSTPcD/TcULd3kvI0Kb0Lch
         dPUAkDXeBSAPw==
Received: by mail-wm1-f49.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so1941681wmq.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:58:34 -0700 (PDT)
X-Gm-Message-State: AOAM530W+cFBiTbIV1HmVfgbMw3fI4ul2cz5zaW5Ut/K8AUmkHSK2aux
        Z5iXAbMAJKrUFeAfVsqaTit112SyVeLMSysBrCE=
X-Google-Smtp-Source: ABdhPJzVigLh1CiFXo5+2pnz3+1eMiM3+lakhbLUlJV6WSMiow8O2iZlBNZ08qFDosPIiTaFks+JS1PA/0dZo4/19Nc=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4154453wmb.142.1625569112989;
 Tue, 06 Jul 2021 03:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:58:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0cN=U+RaGhCUDHf0JNisGQXukC5q8Eoe09nhj3pUdXxA@mail.gmail.com>
Message-ID: <CAK8P3a0cN=U+RaGhCUDHf0JNisGQXukC5q8Eoe09nhj3pUdXxA@mail.gmail.com>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> diff --git a/arch/loongarch/include/asm/seccomp.h b/arch/loongarch/include/asm/seccomp.h
> new file mode 100644
> index 000000000000..220c885f5478
> --- /dev/null
> +++ b/arch/loongarch/include/asm/seccomp.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_SECCOMP_H
> +#define __ASM_SECCOMP_H
> +
> +#include <linux/unistd.h>
> +
> +#include <asm-generic/seccomp.h>
> +
> +#endif /* __ASM_SECCOMP_H */

I would expect this file to not be needed.

> diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
> new file mode 100644
> index 000000000000..b760aa0a3bc6
> --- /dev/null
> +++ b/arch/loongarch/include/asm/uaccess.h
> @@ -0,0 +1,453 @@
> + * The fs value determines whether argument validity checking should be
> + * performed or not.  If get_fs() == USER_DS, checking is performed, with
> + * get_fs() == KERNEL_DS, checking is bypassed.
> + *
> + * For historical reasons, these macros are grossly misnamed.
> + */

You removed set_fs()/get_fs(), which is good, but you forgot to remove
the comment.

> diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> new file mode 100644
> index 000000000000..6c194d740ed0
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/unistd.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#define __ARCH_WANT_NEW_STAT

Why do you need newstat? I think now that we have statx and the libc
emulation code on top of it, there is probably no need to support both
on the kernel side.

> +#define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_SYS_CLONE3

Similarly, if you have clone3, you should not need clone.

> +#define __ARCH_WANT_SET_GET_RLIMIT

And here for prlimit64

> +void *sys_call_table[__NR_syscalls] = {
> +       [0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#include <asm/unistd.h>
> +       __SYSCALL(__NR_clone, __sys_clone)
> +       __SYSCALL(__NR_clone3, __sys_clone3)
> +};

I would suggest expressing this as

#defined sys_clone3 __sys_clone3

instead of overriding the other entries.

          Arnd

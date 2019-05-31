Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C2030A54
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEaIck (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:32:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46086 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:32:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so10334793qtz.13;
        Fri, 31 May 2019 01:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igjuJGXMsnGZDhorJwfUv0+nOH3lmOMpPh5Fkg034nY=;
        b=uQzHWqI/4n7WQG8Knyd+6VFA9p/5C2AoVmmzMD3u/8Bsbt1DRPul91CW4nlDvBUOOJ
         D9NoAfnBj9XykWe7CYVyo/eyaqWW6tyKl9hYNKXSIiAS3KS1gSnW4+AnEuJ5RIA0ED1I
         /Zu8YLd457x8YKugDUghld9yALZW3fZ9e6ygQBsU6wLuj76tqZCyldWIBIcR3zxVRo/r
         j75DKKmtuQcHC9huDYCxJDaT4xC3zUvN9mFOOobFuFZ7ykz3OPJ7sECgZgEr2NV5GG/n
         lYX6WAcJhzmnwYlBG/yFhIBXeui3m78mpObwmGqftm3a0bpI93787Fd0o6RlF2hy3xR6
         8r5A==
X-Gm-Message-State: APjAAAWHbibYO0xBA6Y8g2dRbg4BM0anSwitaigTcRspFY+MepoIRyKe
        YmGeOpdh2IIS/kP0VbnjY3aLf00WyhoQmGr23rs=
X-Google-Smtp-Source: APXvYqz9UY+8/pkIhfjqDnPdgHg65ZqG2L3gJyCnwOw2GV9Dc8VpZX9nAZNc7+rmbc0MPEHfPZRNJe3CE7OZS8hHUVo=
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr7572827qve.176.1559291558659;
 Fri, 31 May 2019 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-17-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-17-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:32:22 +0200
Message-ID: <CAK8P3a0gKJX0fAdizNoO3r-UzAoN0Nf=gkMmw++wuryjHy3-8w@mail.gmail.com>
Subject: Re: [PATCH v6 16/19] arm: Add support for generic vDSO
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
> new file mode 100644
> index 000000000000..eeeb319840ba
> --- /dev/null
> +++ b/arch/arm/include/asm/vdso/gettimeofday.h
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 ARM Limited
> + */
> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
> +#define __ASM_VDSO_GETTIMEOFDAY_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/barrier.h>
> +#include <asm/cp15.h>
> +#include <asm/unistd.h>
> +#include <uapi/linux/time.h>
> +
> +#ifndef CONFIG_AEABI
> +#error This code depends on AEABI system call conventions
> +#endif

Instead of an #error here, I would use a Kconfig conditional and make it

'select HAVE_GENERIC_VDSO if AEABI'

> diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
> index 89ca89f12d23..05581140fd12 100644
> --- a/arch/arm/vdso/vdso.lds.S
> +++ b/arch/arm/vdso/vdso.lds.S
> @@ -82,6 +82,8 @@ VERSION
>         global:
>                 __vdso_clock_gettime;
>                 __vdso_gettimeofday;
> +               __vdso_clock_getres;
> +               __vdso_clock_gettime64;
>         local: *;
>         };

Why are you adding __vdso_clock_getres here? I would probably
leave the addition of the new entry point(s) for a separate patch
at the end, adding __vdso_clock_gettime64 to all 32-bit ABIs
at once, since while that part is a trivial change, it's also user
visible and deserves its own changelog text.

     Arnd

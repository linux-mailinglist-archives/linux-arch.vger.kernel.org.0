Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2F113E62
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 10:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfLEJmw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 5 Dec 2019 04:42:52 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40982 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJmw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 04:42:52 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so944168ywc.8;
        Thu, 05 Dec 2019 01:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kEo6iDTk72UPkuZt6wUZlPDmPtU2DQIfzehH/YGLNyo=;
        b=GHepMebT9XToFw9eC1u3ojJY7qk38u5TOQWVeNCZcWFrIdZgCI1ZVPFZaqF0egLlOC
         Ht5QRBBy5443ObKm8hgNMkbggolpX3boR/MoQox5B6oAsu9fDA2RZSl9KPLalqRnDSRK
         TOWFr9nEAUQLwt7P6QVnFUdDjJIVH8qW67q7xnmqKQPTYbqWrFw//TGKfsu0PmN7Q/12
         WZ49ouvW3Dj++2VKlbTQ4NbHr24X1vLdm77yUODybu7thZSfwcefsR9ad5p4fu41y4aI
         QbggRwjWaKQiTKEDRzZ7WRI+eZFrU7JcgeTNspB1wckXs9tJJ5y88gXWz1niiR/zoioC
         iVLw==
X-Gm-Message-State: APjAAAVy16xwBZ2dRWfdEQ4C9QP+fkd26uZPISEQEMZeultQo2cDDp5s
        GeGuBVofwaDRuvQ3T73nHbbDLh/Zd1sNaJrN78c=
X-Google-Smtp-Source: APXvYqz4kznUSQvdv/ngOv0iEdQ0ZJNgjOnxMQ0UYbg7Gk6Wjsf6QyUquiKhub2bpXPNcu8NSv/BsISxF1Rp+Tl01Fc=
X-Received: by 2002:a81:98c6:: with SMTP id p189mr5176776ywg.443.1575538971148;
 Thu, 05 Dec 2019 01:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com> <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com> <20191204161641.GA28130@roeck-us.net>
 <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
In-Reply-To: <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Thu, 5 Dec 2019 10:42:40 +0100
Message-ID: <CAAdtpL71ED3zbkHMqtd1XFQwToOctWJpy2WPqahxHR81fKdTkg@mail.gmail.com>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing crash)
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 4, 2019 at 6:23 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 12/4/19 4:16 PM, Guenter Roeck wrote:
[...]
> --->8---
>
> Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Date:   Wed Dec 4 16:58:55 2019 +0000
>
>     arm: Fix __arch_get_hw_counter() access to CNTVCT
>
>     __arch_get_hw_counter() should check clock_mode to see if it can access
>     CNTVCT. With the conversion to unified vDSO this check has been left out.
>
>     This causes on imx v6 and v7 (imx_v6_v7_defconfig) and other platforms to
>     hang at boot during the execution of the init process as per below:
>
>     [   19.976852] Run /sbin/init as init process
>     [   20.044931] Kernel panic - not syncing: Attempted to kill init!
>     exitcode=0x00000004
>
>     Fix the problem verifying that clock_mode is set coherently before
>     accessing CNTVCT.
>
>     Cc: Russell King <linux@armlinux.org.uk>
>     Reported-by: Guenter Roeck <linux@roeck-us.net>
>     Investigated-by: Arnd Bergmann <arnd@arndb.de>

There are only 2 "Investigated-by" vs 7k+ "Suggested-by"... Is there a
real difference?

>     Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> diff --git a/arch/arm/include/asm/vdso/gettimeofday.h
> b/arch/arm/include/asm/vdso/gettimeofday.h
> index 5b879ae7afc1..0ad2429c324f 100644
> --- a/arch/arm/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm/include/asm/vdso/gettimeofday.h
> @@ -75,6 +75,9 @@ static __always_inline u64 __arch_get_hw_counter(int clock_mode)
>  #ifdef CONFIG_ARM_ARCH_TIMER
>         u64 cycle_now;
>
> +       if (!clock_mode)
> +               return -EINVAL;
> +

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>         isb();
>         cycle_now = read_sysreg(CNTVCT);
>
>

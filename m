Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994D81135D5
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 20:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfLDTjf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 14:39:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40323 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDTjf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 14:39:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so330962pfh.7;
        Wed, 04 Dec 2019 11:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJWeLkLuqn4L5JEDRR7KjBHbe7AW4CyLEe/hVRYrZI4=;
        b=BLs9BMtpT9xJCfPWS4k/zMk0BzS1Hu5U5A1qoNQ6Rwu7MPivoVOHLX+Yrp98dWcMWL
         vjBL8r/v7FNUJAxd/NxyjrqsB8cp/7ytqpDIPXGMW2gQZJ6lU3auztlbE8Xmsx1tptDI
         8ybMxX9qhvGsGmgpfqX0688XkR5KDWtBdXKOSraV4yc8L0DtIBuZfKyrOXx9+0RdqKqe
         y7Jkq7s4PCQTo6b9Pr+wnf2zLz4LYS+Qlk6ROd4UPj5f2kqC4qV460HYiVzzgwq8OPKs
         2LxJdKo1q/d5ID7gKaaj7BuhT0H+S3TPwaAwcc1CMkO+DGTyKLbLLzw8TBkhd4PyV2Jb
         891A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJWeLkLuqn4L5JEDRR7KjBHbe7AW4CyLEe/hVRYrZI4=;
        b=U+MFPruBG3mhye/T8ZKYEa12ZkJ0GS4ZXLRTXNzw4R2aryV8RkHmRIdetsU/L/50fk
         BGx4LPk8TQCnvbwduB6+d1yrqX+h/o5IxNZ3+Npf9qjUG1MtFTbUw3Fo/cdW/jlu4AXn
         6HJ2MKH+lksNwaT00Fd9wxXyOgZAgwyM4RLUXOhxlJQhav/3rqfCrFdZd8Ku47kjstPe
         hwwxWsPAA2DSwzdhVYKiJY+Vy34+RQprAHuCPDahKB2sXZN/1khJXxUSve3s0UY7hO7x
         fm8hXh3A34O3Ts/gIIYodLzSBoPexMxlQC0F6fYJApbLXa/BWd+VuHxb0lIM0R/R5Rp/
         2h+g==
X-Gm-Message-State: APjAAAWQ2qINfEEr4L22EbYz7K1ssF6xy6VPlnhvxY0KPb7TKxEYNd9B
        5xSMbnqf+IFEC/140QA8ADQ=
X-Google-Smtp-Source: APXvYqwd/ffPkow4NUdKx5Nq3OfOi5xz1CSYUUhtNrYnvK2aV6fHYyHDFSFKVGGN99BM3e/y76XrJA==
X-Received: by 2002:a63:115c:: with SMTP id 28mr5235205pgr.6.1575488373928;
        Wed, 04 Dec 2019 11:39:33 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12sm2527704pfd.58.2019.12.04.11.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 11:39:32 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:39:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
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
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing
 crash)
Message-ID: <20191204193931.GA16809@roeck-us.net>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
 <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
 <20191204161641.GA28130@roeck-us.net>
 <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 04, 2019 at 05:15:26PM +0000, Vincenzo Frascino wrote:
> Hi Guenter,
> 
> On 12/4/19 4:16 PM, Guenter Roeck wrote:
> > On Wed, Dec 04, 2019 at 01:58:25PM +0000, Vincenzo Frascino wrote:
> >> Hi Guenter,
> >>
> >> On 12/4/19 1:51 PM, Guenter Roeck wrote:
> >>> On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
> >>>> The arm vDSO library requires some adaptations to use to take advantage
> >>>> of the newly introduced generic vDSO library.
> >>>>
> >>>> Introduce the following changes:
> >>>>  - Modification vdso.c to be compliant with the common vdso datapage
> >>>>  - Use of lib/vdso for gettimeofday
> >>>>  - Implementation of elf note
> >>>>
> >>>> Cc: Russell King <linux@armlinux.org.uk>
> >>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >>>
> >>> This patch causes a crash with qemu's mcimx6ul-evk emulation while running
> >>> imx_v6_v7_defconfig.
> >>>
> >>
> >> Thank you for reporting this. Could you please provide some details on how I can
> >> reproduce the scenario you are describing?
> >>
> > - Build imx_v6_v7_defconfig
> > - Get root file system or initrd, for example from
> >   https://github.com/groeck/linux-build-test/tree/master/rootfs/arm
> > - Run image. Example, with initrd:
> > 	qemu-system-arm -M mcimx6ul-evk -kernel arch/arm/boot/zImage \
> > 		-no-reboot -initrd rootfs-armv7a.cpio \
> > 		-m 256 -display none -serial null \
> > 		--append 'rdinit=/sbin/init earlycon=ec_imx6q,mmio,0x21e8000,115200n8 console=ttymxc1,115200'
> > 		-dtb arch/arm/boot/dts/imx6ul-14x14-evk.dtb \
> > 		-nographic -monitor null -serial stdio
> > 
> > qemu has to be v3.1 or later to support the machine.
> > 
> 
> Thanks for this. Could you please try the patch below the scissors? Seems fixing
> the issue for me.
> 
> > Hope this helps,
> > Guenter
> > 
> 
> -- 
> Regards,
> Vincenzo
> 
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
>     Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
WFM.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

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
>         isb();
>         cycle_now = read_sysreg(CNTVCT);
> 
> 

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC736BF65
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhD0GpA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 02:45:00 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46381 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0Go7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Apr 2021 02:44:59 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4272660007;
        Tue, 27 Apr 2021 06:44:11 +0000 (UTC)
Subject: Re: [PATCH v8] RISC-V: enable XIP
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, vitaly.wool@konsulko.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
References: <CAM4kBBJChiqkarKwn3roe+BLotsGDptfmYKKDxE45AnFZNUoPw@mail.gmail.com>
 <mhng-08bcf932-3a06-43cf-b0b0-9614d09aa17d@palmerdabbelt-glaptop>
 <CA+G9fYv4y+n6PoYf1jOPZbjPxY7rTi+Ajc89zsNzTS0_uL+RJw@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <3b6ff653-f29f-3230-201d-8ca756346792@ghiti.fr>
Date:   Tue, 27 Apr 2021 02:44:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYv4y+n6PoYf1jOPZbjPxY7rTi+Ajc89zsNzTS0_uL+RJw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 4/26/21 à 12:46 PM, Naresh Kamboju a écrit :
> my two cents,
> 
> The riscv build failed on Linux -next 20210426 tag kernel due to
> below warnings / errors.
> Following builds failed.
>   - riscv (tinyconfig) with gcc-8
>   - riscv (allnoconfig) with gcc-8
>   - riscv (tinyconfig) with gcc-9
>   - riscv (allnoconfig) with gcc-9
>   - riscv (tinyconfig) with gcc-10
>   - riscv (allnoconfig) with gcc-10
> 
>>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>>> index 30e4af0fd50c..2ddf654c72bb 100644
>>>>> --- a/arch/riscv/kernel/setup.c
>>>>> +++ b/arch/riscv/kernel/setup.c
>>>>> @@ -50,7 +50,11 @@ struct screen_info screen_info __section(".data") = {
>>>>>    * This is used before the kernel initializes the BSS so it can't be in the
>>>>>    * BSS.
>>>>>    */
>>>>> -atomic_t hart_lottery __section(".sdata");
>>>>> +atomic_t hart_lottery __section(".sdata")
>>>>> +#ifdef CONFIG_XIP_KERNEL
>>>>> += ATOMIC_INIT(0xC001BEEF)
>>>>> +#endif
>>>>> +;
>>>>>   unsigned long boot_cpu_hartid;
>>>>>   static DEFINE_PER_CPU(struct cpu, cpu_devices);
>>>>>
>>>>> @@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
>>>>>   #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>>>>>        unflatten_and_copy_device_tree();
>>>>>   #else
>>>>> -     if (early_init_dt_verify(__va(dtb_early_pa)))
>>>>> +     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> 
> arch/riscv/kernel/setup.c: In function 'setup_arch':
> arch/riscv/kernel/setup.c:284:32: error: implicit declaration of
> function 'XIP_FIXUP' [-Werror=implicit-function-declaration]
>    if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>                                  ^~~~~~~~~
> arch/riscv/include/asm/page.h:112:62: note: in definition of macro
> 'linear_mapping_pa_to_va'
>   #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) +
> va_pa_offset))
>                                                                ^
> arch/riscv/include/asm/page.h:156:27: note: in expansion of macro
> '__pa_to_va_nodebug'
>   #define __va(x)  ((void *)__pa_to_va_nodebug((phys_addr_t)(x)))
>                             ^~~~~~~~~~~~~~~~~~
> arch/riscv/kernel/setup.c:284:27: note: in expansion of macro '__va'
>    if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>                             ^~~~
> cc1: some warnings being treated as errors
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> 
> steps to reproduce:
> ---------------------------
> # TuxMake is a command line tool and Python library that provides
> # portable and repeatable Linux kernel builds across a variety of
> # architectures, toolchains, kernel configurations, and make targets.
> #
> # TuxMake supports the concept of runtimes.
> # See https://docs.tuxmake.org/runtimes/, for that to work it requires
> # that you install podman or docker on your system.
> #
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> 
> 
> tuxmake --runtime podman --target-arch riscv --toolchain gcc-8
> --kconfig allnoconfig
>


Thank you Naresh for the report, I will fix that today.

Thanks again,

Alex

> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

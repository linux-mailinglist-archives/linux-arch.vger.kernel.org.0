Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74520374F73
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 08:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhEFGj3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 02:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhEFGj3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 May 2021 02:39:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C88C061574
        for <linux-arch@vger.kernel.org>; Wed,  5 May 2021 23:38:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gj14so2804293pjb.5
        for <linux-arch@vger.kernel.org>; Wed, 05 May 2021 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4pB76DI3Wkv2k+3Ah6E6o80wVVbTYgSMN4+zljmic/s=;
        b=F3VwvTrhJqDf7jP0FJSLtwO120b7Mf8vKLXOH2MJocvZQJMphG+bHlfFJe8MPPcKHO
         YXhVQS6DfmJyJMCgM5LZnWZHyG3tQt73DRmd3ICxYECMLEo/MYOVZKOhyVCKR5CmgVac
         9BR3mf5u2IkbAbcbOvELUusMbfM/jhczAPgMkHd2w/aGpc0p8K0Vuxj3LWqwo2iX8jGI
         MsxPvwddQr+NARZBgN3sZbiYBaLwj3bT3PgPVbSg76PuRiKfStkZqyepZPwhBo/42lIC
         0hYWSeF4bbbeFe5P4gvik60dLfaeaauTh5PqFNC4gy2nxGwOHNtgJO0V2wLUTmC+shqQ
         pD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4pB76DI3Wkv2k+3Ah6E6o80wVVbTYgSMN4+zljmic/s=;
        b=oGJonjvaV3TilbFI8RDWOrbpnOgksyo8vnGnKPGT1b1bRO/UEZGAijy7IY/wtra+KD
         veyOa/iGxBC9T1nDaCq8d7oS+DWCjOwN2pK8Qyuu27a2oQeWav56BLT2oqzKKvfoQI2r
         U1X0MUCSMFcJO94ZoWLnJbUQ1aDuyQscsYN801/Vo1L415M2jRmuXz8nvDOz5mKb6tWP
         4THxkLdPshYOGIZVycyefA6PJAWjDaK/+bYB4sKUGwLr24JdC5j8vDUFvq0qGtrq23yt
         8+ANhgfq0Kjnkp+s4b1g1MsgqnYqVv6M2qIB9mPvBb1SdTutAH24rODKSRXbDtrmxD/M
         L6rQ==
X-Gm-Message-State: AOAM531RNASxX3Dv7hkmrkA4I9FXXMnsDBrAsI1XDvjWM9xqRapkqzSz
        pU3uHv7bU3JZ68NJA6yQEyhghg==
X-Google-Smtp-Source: ABdhPJwjlJoVmo+6a8XDUXjGWJK6yuc+LZUn/I5j2bvw1wuEzN68RA3bmZmY0Echj2/a31sOJGD7bg==
X-Received: by 2002:a17:902:7081:b029:ed:5f:20af with SMTP id z1-20020a1709027081b02900ed005f20afmr3082620plk.60.1620283110274;
        Wed, 05 May 2021 23:38:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n129sm1143567pfn.54.2021.05.05.23.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:38:29 -0700 (PDT)
Date:   Wed, 05 May 2021 23:38:29 -0700 (PDT)
X-Google-Original-Date: Wed, 05 May 2021 23:38:26 PDT (-0700)
Subject:     Re: [PATCH v8] RISC-V: enable XIP
In-Reply-To: <CA+G9fYv4y+n6PoYf1jOPZbjPxY7rTi+Ajc89zsNzTS0_uL+RJw@mail.gmail.com>
CC:     alex@ghiti.fr, vitaly.wool@konsulko.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, lkft-triage@lists.linaro.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     naresh.kamboju@linaro.org
Message-ID: <mhng-1125f9ca-cd05-4183-8c0e-e33922bc9add@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 26 Apr 2021 09:46:16 PDT (-0700), naresh.kamboju@linaro.org wrote:
> my two cents,
>
> The riscv build failed on Linux -next 20210426 tag kernel due to
> below warnings / errors.
> Following builds failed.
>  - riscv (tinyconfig) with gcc-8
>  - riscv (allnoconfig) with gcc-8
>  - riscv (tinyconfig) with gcc-9
>  - riscv (allnoconfig) with gcc-9
>  - riscv (tinyconfig) with gcc-10
>  - riscv (allnoconfig) with gcc-10
>
>> >> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> >> > index 30e4af0fd50c..2ddf654c72bb 100644
>> >> > --- a/arch/riscv/kernel/setup.c
>> >> > +++ b/arch/riscv/kernel/setup.c
>> >> > @@ -50,7 +50,11 @@ struct screen_info screen_info __section(".data") = {
>> >> >   * This is used before the kernel initializes the BSS so it can't be in the
>> >> >   * BSS.
>> >> >   */
>> >> > -atomic_t hart_lottery __section(".sdata");
>> >> > +atomic_t hart_lottery __section(".sdata")
>> >> > +#ifdef CONFIG_XIP_KERNEL
>> >> > += ATOMIC_INIT(0xC001BEEF)
>> >> > +#endif
>> >> > +;
>> >> >  unsigned long boot_cpu_hartid;
>> >> >  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>> >> >
>> >> > @@ -254,7 +258,7 @@ void __init setup_arch(char **cmdline_p)
>> >> >  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>> >> >       unflatten_and_copy_device_tree();
>> >> >  #else
>> >> > -     if (early_init_dt_verify(__va(dtb_early_pa)))
>> >> > +     if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>
> arch/riscv/kernel/setup.c: In function 'setup_arch':
> arch/riscv/kernel/setup.c:284:32: error: implicit declaration of
> function 'XIP_FIXUP' [-Werror=implicit-function-declaration]
>   if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>                                 ^~~~~~~~~
> arch/riscv/include/asm/page.h:112:62: note: in definition of macro
> 'linear_mapping_pa_to_va'
>  #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) +
> va_pa_offset))
>                                                               ^
> arch/riscv/include/asm/page.h:156:27: note: in expansion of macro
> '__pa_to_va_nodebug'
>  #define __va(x)  ((void *)__pa_to_va_nodebug((phys_addr_t)(x)))
>                            ^~~~~~~~~~~~~~~~~~
> arch/riscv/kernel/setup.c:284:27: note: in expansion of macro '__va'
>   if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>                            ^~~~
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

Sorry, I didn't notice this as it went by but I think I've already fixed 
this one up.

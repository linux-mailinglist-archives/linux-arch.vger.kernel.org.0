Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FAB3BC953
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFKTM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:19:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhGFKTM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:19:12 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRmo8-1ld5gJ0myY-00TGxF for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:16:33 +0200
Received: by mail-wm1-f41.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so1855308wms.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:16:33 -0700 (PDT)
X-Gm-Message-State: AOAM5306Lv7/glWco1SOVrt7Yh41jy7iNrngqEKVZBZFnHIiOBJ7rqjQ
        PpDNZWjBdVPowjI5hV18WPTQDpaLybv0MSQzJhY=
X-Google-Smtp-Source: ABdhPJzr2bbY5RlZNCjPvhqFRulrOt1TZ7phlkpxnqOiCbdYNAposFqiMCXIlQTDozUNjTBrneQDsBmJHx1Uf0jHyaI=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr3907933wmh.120.1625566592842;
 Tue, 06 Jul 2021 03:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-6-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-6-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:16:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
Message-ID: <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
Subject: Re: [PATCH 05/19] LoongArch: Add boot and setup routines
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
X-Provags-ID: V03:K1:gWnb1ntVk2l4lzxx+xWy/KJjbLojZHkUePhDa7nMziirVNwptii
 Y6gOFY6sPMThjFXIXGDwRQhRzqq5j6331yWekS1zebVB3TLBD3B9V8uS2RIiBXMNNSs8Wlw
 0gaun/t/qRv/azfw/bFKSfuFEdTFtzeF46SDUNn2vL+t3+Rciuxrjmd6d6fA2xwC9azRu25
 ptk5NA7+5uW92zodxeWOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jWpuymmyNX8=:L4Dt1AqLNy/L6+dL8MdgRD
 YjCBT+0554va/4bGGj5fc6eTKwE+RkISa52o+zxVNFs8DrhnIL1GTy2JL1YuV4h70V2l8a/aH
 CDcbVo8d/bgqgM4YvUu0s+Tzruljic/m7cYadD8m7DmbtSIPMSChktON9OVUaOzdLwFho7G4e
 xRCBHBzo1yVkZ/FW8yDqK2crhn6mnefIMaNu0v5uNRKHZocPwJXv6Kh+dUeefe6onTarT7GHz
 HdIg1dYeAB7/s/EtQYYeT78LfGCCZFGM1AlPMKwyBNK4lXCm00FdhLBXR2cUZOeVmI/lL2Omg
 X+L+glnyDVfPWvAqdOCSDHR/n/HxCS/L/CagEPOiSB45qlF3rMYiLnHhljs2Nci3htSQu8L+c
 cxOOM9ffN4rHwGR0m9SR4Ai2PE/byPDw2yPdjhT7SQr71dwnHWNf/pVF4cJpLLvmNVlhGpefL
 tt2stLQd6PopdQVeEukU+6/Ys4NCzR1U7NnQvm2+1klZRSfLliq7cELnEQHELdgrWGHmi+3Le
 ZdN187/R8Znsy7vVai/sspiSFawLIrId0K4ywZXTS6ExJ1d5CIKhWFEHL4LAktnfId2gLvgFy
 wq/rtHatOgJv9GEEQW1Dgvce7WQbcMCdqDu3PGzRri0z9JAtVauSet18jN0FGeKGC0use7+7F
 I5RyMIMmxomnKbJ9hXssC2VQRLwFRQMLaw+u3OKBT4z79uDCzBQPSWtSRW3A5rcOc7RVipH22
 ADRDP4xTwL/jixsOzxVIrSxpBLBuwX1D49vistBbzXphUpiuO52AtSpOfpHVZOwjlAn6QXzIG
 o7VwNW7jxH58Wwx+o+lYQDit0hUX8Yeb2W05njWv6K8hmzr4Rs/B7rYgE0dASc9bC5L5ZGSFl
 j5StLuF9PSjdmq1PTN4Ga1I5zE+FPIOTkWizXA2fDDwNrrKphzfiMvVGXIwE5ZdWtOy/gGyNb
 zZLlda4cC94XK71fxmy5edZbGDjaeMasOmaF7V4cMxDRpoo12djcw
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +
> +#ifdef CONFIG_64BIT
> +       /* Guess if the sign extension was forgotten by bootloader */
> +       if (start < CAC_BASE)
> +               start = (int)start;
> +#endif
> +       initrd_start = start;
> +       initrd_end += start;
> +       return 0;
> +}
> +early_param("rd_start", rd_start_early);
> +
> +static int __init rd_size_early(char *p)
> +{
> +       initrd_end += memparse(p, &p);
> +       return 0;
> +}
> +early_param("rd_size", rd_size_early);

The early parameters should not be used for this, I'm fairly sure the UEFI
boot protocol already has ways to communicate all necessary information.

> +
> +#ifdef CONFIG_ACPI
> +       init_initrd();
> +#endif

Why is the initrd support tied to ACPI? Can you actually boot without ACPI?

> +#if defined(CONFIG_VT)
> +#if defined(CONFIG_VGA_CONSOLE)
> +       conswitchp = &vga_con;
> +#elif defined(CONFIG_DUMMY_CONSOLE)
> +       conswitchp = &dummy_con;
> +#endif
> +#endif

The VGA console seems rather outdated. If you have UEFI, why not use
the provided framebuffer for the console?

> +u64 cpu_clock_freq;
> +EXPORT_SYMBOL(cpu_clock_freq);
> +u64 const_clock_freq;
> +EXPORT_SYMBOL(const_clock_freq);

You should generally not rely on the CPU clock frequency being fixed
like this, as this breaks down as soon as you add a drivers/cpufreq/ driver.

What code uses these?

> +void __init time_init(void)
> +{
> +       if (!cpu_has_cpucfg)
> +               const_clock_freq = cpu_clock_freq;
> +       else
> +               const_clock_freq = calc_const_freq();
> +
> +       init_timeval = drdtime() - csr_readq(LOONGARCH_CSR_CNTC);
> +
> +       constant_clockevent_init();
> +       constant_clocksource_init();
> +}

Clocksource and clockevents drivers should be located in drivers/clocksource
and reviewed by its maintainers.

         Arnd

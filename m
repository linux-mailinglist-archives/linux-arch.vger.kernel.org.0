Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E719C3BCB07
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhGFK6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhGFK6j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 06:58:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF35C619CD
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625568960;
        bh=Uak+xie8FDU1H+A0lNKbOKrOXp89Q/VpGhUa2lOZVJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a8HuKISQkxcB5uQ3XrOdfD/TwxQkSpq30jqzymVH4XqLmtbRFoIvSHesG0ZSiEjcj
         60CJjXumrKrQLMY2P9DDCjDuogGucSTg1WC6LJ9HqM9MBf1Kez6+dCvIEFzexFnhke
         poLyyX6IZsNpNpnKUrgOUiffKw7EunqZ7jszhQiUKe7oC66Jvz2kiJc5F8+Aga2rGY
         km5nNEZLmiTsmEoMWtWrHSt/41GCSqd2CWzinXa6OQJtttjObqrrFfh3EPE/6ZODH1
         PCUTxM8m+HL2tB+3xHcsIPIbHqQ0ZNDqViPzOmSV7y59HMv6koNf+EQPaeHJx3Hx05
         0wIdOzUAhNXNQ==
Received: by mail-wm1-f43.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so1930634wms.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:56:00 -0700 (PDT)
X-Gm-Message-State: AOAM531n4M7KTiUG/zm7BTtqZMRjwrTKlNbSrr/9KIItVMU3JahL7ehY
        u2zsCk4M0UbRC8zIrVxleQbIzcpLhD2jweupwQE=
X-Google-Smtp-Source: ABdhPJy44bLn25NDyALwSyQF0sAIYQeHrr6aEa+JDP2AOz6XJW5wwSM6A6QMkYvdX0yZAopUBtRpnJbjJH/UJrMnoOI=
X-Received: by 2002:a05:600c:4896:: with SMTP id j22mr1192609wmp.43.1625568959396;
 Tue, 06 Jul 2021 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-6-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-6-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:55:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1A5yDPfLWXeo98Oz1MUayETZO9aR80zE1T3h4C7ZxBXg@mail.gmail.com>
Message-ID: <CAK8P3a1A5yDPfLWXeo98Oz1MUayETZO9aR80zE1T3h4C7ZxBXg@mail.gmail.com>
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

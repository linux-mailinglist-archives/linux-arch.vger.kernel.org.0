Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38DB3D7499
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhG0Lxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhG0Lxa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 07:53:30 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683C4C061757
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 04:53:29 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z3so11768599ile.12
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFQVbsUF6EIimG2/4GNB3iVOoIHc4+Ng0KYWa/FzcS0=;
        b=dwUWGtiOyzDOkdzjfWTYlYt94g1W0F0ldaNoJzgPYe3XhYJXJjYE4nSCnRXF0SP3UZ
         xxrwhX0+/aV12saD8M3cWxPQfsShfcGxa9tIvpyCHHtmU3vHKdSX9iI/xSVMVqYQ36dy
         3MF9d/IHyAmUsrY8tz6BIMeWJIPozWSSiE+Y7VLUSqA8faeqMAQzLXhI3rTfHZ0Nspik
         iJAK59WVQN2p55c9yRdnii1r9hGVqHf6bN/pKyMGABXKUXVtVDoohFJF+9ZmwY0X+YGn
         jszPuvQ31rE8Yhw2bitkigTnB+kqlHN3KYXOyIrbBtKBsv3WDMkMIETPRngAx/98YOnV
         e+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFQVbsUF6EIimG2/4GNB3iVOoIHc4+Ng0KYWa/FzcS0=;
        b=eBSmFFIsOpc1txKUgOxeqkIQK23WqPOgzSrNwPWsgZgjlI1f4o+BAUNv+tnTkSnhEy
         YQu9gf0aiGdYTdxnLwAJgOhMORDOdBO6jHPOyZD7RsWh+aqXI4TDIxoHcIAIvO954J37
         AuXcooAGg3T785HlrjaTh202iUcX1uNmV6nbvR/03A7x0gtUk8dIYgQEDTHVpRkN3aPK
         Hwi9t02lRON4DHR6vQKo/r8F9dIoP6sZ+We/XiLyXHAOfHhbkKM31Av0Qk+RkXbsVTQC
         DX3dUAjLy1bqBBHyiwb7aIXpRmHCJgzpa1NmQCpygDHkXeIVOqROoUdRWuHFIyWod22o
         Wu/Q==
X-Gm-Message-State: AOAM530LL2KFCNFFvH8PzN3h+DOuXFUzwIol/2G17SvnPTHfSSqbwBAD
        PVWY+da2HdSOS2M1M7vbVPrw3L3P/cwzvm97rnOag7YC3aA=
X-Google-Smtp-Source: ABdhPJxJIRI3aw5JcZptWoCuy1CX+LaEgN16X1OO5wnbec1ldO7h2aUMDDoguTeUeu3jVknCrcUtFUg6SzsFg8jYeXw=
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id m13mr16156623ilh.137.1627386808922;
 Tue, 27 Jul 2021 04:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 27 Jul 2021 19:53:18 +0800
Message-ID: <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
Subject: Re: [PATCH 05/19] LoongArch: Add boot and setup routines
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

On Tue, Jul 6, 2021 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > +
> > +#ifdef CONFIG_64BIT
> > +       /* Guess if the sign extension was forgotten by bootloader */
> > +       if (start < CAC_BASE)
> > +               start = (int)start;
> > +#endif
> > +       initrd_start = start;
> > +       initrd_end += start;
> > +       return 0;
> > +}
> > +early_param("rd_start", rd_start_early);
> > +
> > +static int __init rd_size_early(char *p)
> > +{
> > +       initrd_end += memparse(p, &p);
> > +       return 0;
> > +}
> > +early_param("rd_size", rd_size_early);
>
> The early parameters should not be used for this, I'm fairly sure the UEFI
> boot protocol already has ways to communicate all necessary information.
We use grub to boot the Linux kernel. We found X86 uses private data
structures (seems not UEFI-specific) to pass initrd information from
grub to kernel. Some archs use fdt, and other archs use cmdline with
"initrd=start,size" (init/do_mounts_initrd.c). So, I think use cmdline
is not unacceptable, but we do can remove the the rd_start/rd_size
parsing code here.

>
> > +
> > +#ifdef CONFIG_ACPI
> > +       init_initrd();
> > +#endif
>
> Why is the initrd support tied to ACPI? Can you actually boot without ACPI?
>
> > +#if defined(CONFIG_VT)
> > +#if defined(CONFIG_VGA_CONSOLE)
> > +       conswitchp = &vga_con;
> > +#elif defined(CONFIG_DUMMY_CONSOLE)
> > +       conswitchp = &dummy_con;
> > +#endif
> > +#endif
>
> The VGA console seems rather outdated. If you have UEFI, why not use
> the provided framebuffer for the console?
OK, we will remove this.

>
> > +u64 cpu_clock_freq;
> > +EXPORT_SYMBOL(cpu_clock_freq);
> > +u64 const_clock_freq;
> > +EXPORT_SYMBOL(const_clock_freq);
>
> You should generally not rely on the CPU clock frequency being fixed
> like this, as this breaks down as soon as you add a drivers/cpufreq/ driver.
>
> What code uses these?
cpu_clock_freq is a const which records the "standard frequency", it
is just used to display the frequency now. In future when cpufreq
added, cpu_clock_freq will be used to calculate the target frequency.

Huacai
>
> > +void __init time_init(void)
> > +{
> > +       if (!cpu_has_cpucfg)
> > +               const_clock_freq = cpu_clock_freq;
> > +       else
> > +               const_clock_freq = calc_const_freq();
> > +
> > +       init_timeval = drdtime() - csr_readq(LOONGARCH_CSR_CNTC);
> > +
> > +       constant_clockevent_init();
> > +       constant_clocksource_init();
> > +}
>
> Clocksource and clockevents drivers should be located in drivers/clocksource
> and reviewed by its maintainers.
>
>          Arnd

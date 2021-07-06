Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285163BC965
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhGFKUw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:20:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKUw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:20:52 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDQqk-1lrKDa2Dzy-00AXla for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 12:18:12 +0200
Received: by mail-wm1-f54.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1303645wmh.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:18:12 -0700 (PDT)
X-Gm-Message-State: AOAM533QVXF8urQnd8IvVNCVRzdiXi0YSk9hujXvxQfSQ1mPcLMCKw3/
        KP6FjxAkZnoCm5Wa6ZQD2ospdjzqV0OIZHvpQcs=
X-Google-Smtp-Source: ABdhPJyajd3pZWSIUUyt0K/ZfOS8tTwR1+lfvBr1Mxxy0fi9pY3uLUOgj/OC+APfWsjnTG5yKCizfhccr/Np4QHkBRk=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr3968165wmb.142.1625566692239;
 Tue, 06 Jul 2021 03:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-18-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-18-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:17:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Do4NModPfJkZTbOqgXedVjJfqwWMyK0FjFAv2v6RjhQ@mail.gmail.com>
Message-ID: <CAK8P3a3Do4NModPfJkZTbOqgXedVjJfqwWMyK0FjFAv2v6RjhQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] LoongArch: Add multi-processor (SMP) support
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
X-Provags-ID: V03:K1:4PybfqygAlvFOpGQv5FHwMpf12YE5HrVKZmZdptIjPl2PsSUBDy
 kSbl9LONqmvqNueTmyCIgkhD8RVtQhAdLratWrH4/PNVsravyvtiNVYhjE5gXBMIqUkUB8Z
 dLAmQwxbOWa/61aoqmZNewaKXCo98Ef/jEAgQ67huvqefySNEjRLlJx/SQ52IMFoQ17wIFD
 1PWXQBo3/LDvwYyIj5jWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4ijKHfIspEA=:QO53gO6Vm0dofysygBUDIy
 1ZkH1VloK8n5OvkLDj22HNCgriMDT4zG0EPRU7WaanW6gCgDuZue8NpPaedbgMPE2qYeUirTL
 gu0sN0nzAYFSQum5bkDDUlHYaLNQP0PBQShe34Ly8SVtF60qBMGPWGJMQy3NutefzqnjwZwkX
 n8ASf+Lib0UW0IWyoAqIWljPOcmxgeo/01NH2NEVTA+YtqEK1AOR0T8mzftlihqeC7BuWG6Mf
 dNnV7YG7/5rY/nrXvK3Ovc5lHoFRSzuQ4GiajSc/bcKXhQtkW0AqQcRIhLM/TBC1akcxPHLF8
 O2a1+NaSVodzSAd+bsIBgItKl6rL8aMBSTgEsBtYz39GT7FEgdsRdtwQV/FQe9/WZD0g1FVWs
 GMkj68RKidJRKPXQrWPyZvG4vnz3G/uDreQyqRLCtNqWqSA9Fa7bdtI6EgeCEGf/N3EbFQ6zW
 32TrdYLLt5Uc5UG+7abuvWrxEzk235U/T5wrP2LOd7eumcO7kSMVm2KJPP5TLhAQ+ViYwjQom
 eezxbi+vu81JNMYyYpI4tiBwxSmsZ11tFwU9FQhyDOmbSrWyWE1Jed/dXzTFcXIvCbHf6ysrD
 NPwG8AuixVU+Ggiqe7l9UlJY/TG7sm9pjEtHqW1z+664NBUwBQSfrSt1i26oWuGTLlvMH5f8U
 zhQgx98hI0dBusk8Rl1MTDbqWfqQ4nYh9E1IYoS9l3GO8oCs00oVbhMe69KVTRxt0eZwlo0Ph
 7Jrq1Ax5p0EkFB7FCPpFr1PF/kzWvCPV133oap/4eKxh/MLn+oxWuMdd6AGZZyf+WrkseGFWi
 8FbebZAOf09uAfMfLHfsClmGSeb79RyxGBGMxsLaR6GdcjFLA+8CwLrKs4ssP30JayQJ+xHts
 bPJX+XcydUfjj3nDO723q5NVJy/1j0BSD9RyO/cN14aMz5mAhIseLlGOoTmXXFxhpRQHGFIrJ
 OgJXz+YF0esR4N2wjXkuJGmmfogVtlmJxSYOJRQT8WQTElaisXY1v
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +const struct plat_smp_ops loongson3_smp_ops = {
> +       .send_ipi_single = loongson3_send_ipi_single,
> +       .send_ipi_mask = loongson3_send_ipi_mask,
> +       .smp_setup = loongson3_smp_setup,
> +       .prepare_cpus = loongson3_prepare_cpus,
> +       .boot_secondary = loongson3_boot_secondary,
> +       .init_secondary = loongson3_init_secondary,
> +       .smp_finish = loongson3_smp_finish,
> +#ifdef CONFIG_HOTPLUG_CPU
> +       .cpu_disable = loongson3_cpu_disable,
> +       .cpu_die = loongson3_cpu_die,
> +#endif
> +};

I would hope that these functions can be used across platforms without
an abstraction
layer in-between. Are these not all part of the either the CPU
architecture definition or
the firmware interface?

Do you even expect to see non-SMP systems deployed widely enough that
SMP support
must be optional? On arch/arm64 we ended up always building SMP support into
the kernel because practically everyone wants it.


      Arnd

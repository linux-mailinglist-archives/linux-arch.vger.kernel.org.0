Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD740F568
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbhIQJ6o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 05:58:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIQJ6n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 05:58:43 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Ml6Zo-1nANHI2Xsa-00lUCu; Fri, 17 Sep 2021 11:57:20 +0200
Received: by mail-wm1-f46.google.com with SMTP id s24so6855946wmh.4;
        Fri, 17 Sep 2021 02:57:20 -0700 (PDT)
X-Gm-Message-State: AOAM5324p9PJ0BzLOY684l8kK2aHOlLNEQBN+T70dauRKTiZ+UYBUwk7
        0fkFuY2PlgeoJkmPmuSr/JtaRfvrMz+uER4mDoY=
X-Google-Smtp-Source: ABdhPJzyBSn5fd+1jNXROdABAdgBwflJnaUMN+smVMYhmymQpYzFP7i1jCUpju6EsMwBumKlxY5QJJaPaJvt4hjtt98=
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr14162849wmp.173.1631872640107;
 Fri, 17 Sep 2021 02:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn> <20210917035736.3934017-21-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-21-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 11:57:04 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0N=SA-E7ChrMrA5Gv6TDMzJ4_QNUN5OzpJWgzyJwcboA@mail.gmail.com>
Message-ID: <CAK8P3a0N=SA-E7ChrMrA5Gv6TDMzJ4_QNUN5OzpJWgzyJwcboA@mail.gmail.com>
Subject: Re: [PATCH V3 20/22] LoongArch: Add multi-processor (SMP) support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kC1QUHCCsGGorUz97L4KK/8Lk7l9US/yxko6T91cxhmCcUhDdQb
 GxvJ5YchEeqKmNqw5uQl2cpl0VSeiHAW7i+khcPA+z9XqBLN4XU2gWouuu2lGkG+lsHF6hb
 6GBY/MHhjKocEolyBgxoeppfaxazz3vUiKdcPhCgI3BFEmKGVO2BuJZhSFJhjgfTadhzngZ
 GjhsemX4qPEu0G2UHxofg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NJtuMmF6raQ=:uAQd3w1+EClqPavyx4ZS3X
 QE4AArTLVhJiLM95b66zKwhZWOAPnF711W96JJMmt2iHnTZcX1RNKQpJ9TtKNUAUcx0o8l4K6
 8Gu+1CCloKMv4voaNZxqTYIVyGqplAAd6HkpCxO81WacTf2hSWMSs4qBkRP7F/BO71+RZeXYZ
 AWdMBVhxakDmnCikcZApKnsN9d/JRFBKmi66T/LtpQBHq4+hHB3e5m6BegoWpOlfLGiszZV0A
 bt4/16el2NUwGwrQqgPd/2gXyEP7v2Y6mWqBxuyX2DSIMhPaYyWCAErQLhFTwPrPQ1rTMrBO8
 paRwh3JE9h/dI0XkIOZ7wvVikvjmCaQuJ/A9sAKL/8dOZeZ2S1pEaxoPu9mptGTDWJ7OxztIr
 FpcBDtoaDwhf0EIAFnJeAQFEmzf2K13BStb/2+a18t3y3YJqGr4ag3axbLsXo7HjnOkWq6Meg
 DC6cmRWb7vpUaGMrEFzryJSnAVNd9LiRaOx1BA9oJ7A26eQPYoWFnr+JwSX8ssjk+rYT81HMp
 d+66Vh4mkkf5xXrmX/10jMK0cJTYj75KUPzp4insEE6HDj0uwKxrxCG/sDqRqMXS3BBVXOWpA
 oxbf1UE5fcfqLZFKQmj7Td4ztNbG7JmqFuzMkaQc2oFlryjhYxUDadv8wXsfRqaZjmkOtpwi2
 RQ2T7123/0Rk5pyoe9Vxpg2gPhmhYlTlq0ZnA+ZH8Q60nGzCWM5n7DRl2EuKQyg/llviwrQsM
 H46qKmUAF7PrP9J+wBwjNZZu3weExb/rILC3MGAqRrG026mQBmST2+ZF9msCLp64BSdzLVAXz
 bb6snS5o4nyNX4kHkxoq2g0iB5jCBL8viyQcxyWqdmv+bpV+GY21gWBHWDa2lmd7bmBweu9xr
 cXIkHvutMtbEc2n4vOrw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +
> +struct task_struct;
> +
> +struct plat_smp_ops {
> +       void (*send_ipi_single)(int cpu, unsigned int action);
> +       void (*send_ipi_mask)(const struct cpumask *mask, unsigned int action);
> +       void (*smp_setup)(void);
> +       void (*prepare_cpus)(unsigned int max_cpus);
> +       int (*boot_secondary)(int cpu, struct task_struct *idle);
> +       void (*init_secondary)(void);
> +       void (*smp_finish)(void);
> +#ifdef CONFIG_HOTPLUG_CPU
> +       int (*cpu_disable)(void);
> +       void (*cpu_die)(unsigned int cpu);
> +#endif
> +};


Do you foresee having more than one implementation of these in the
near future? If not, I would suggest leaving out the extra indirection
and just using direct function calls.

> +#ifdef CONFIG_SMP
> +
> +static inline void plat_smp_setup(void)
> +{
> +       extern const struct plat_smp_ops *mp_ops;       /* private */
> +
> +       mp_ops->smp_setup();
> +}
> +
> +#else /* !CONFIG_SMP */
> +
> +static inline void plat_smp_setup(void) { }
> +
> +#endif /* !CONFIG_SMP */

You could even go further and do what arch/arm64 has, making
SMP support unconditional. This obviously depends on hardware
roadmaps, but if all harfdware you support has multiple cores,
then non-SMP mode just adds complexity.

> +
> +#define MAX_CPUS 64

You CONFIG_NR_CPUS allows up to 256. I think you need to
adjust one of the numbers to match the other, or remove this
definition and just use CONFIG_NR_CPUS directly.

> +
> +static volatile void *ipi_set_regs[MAX_CPUS];
> +static volatile void *ipi_clear_regs[MAX_CPUS];
> +static volatile void *ipi_status_regs[MAX_CPUS];
> +static volatile void *ipi_en_regs[MAX_CPUS];
> +static volatile void *ipi_mailbox_buf[MAX_CPUS];

Why are these 'volatile'? If they are MMIO registers, they
should be __iomem, and accessed using readl()/writel()
 etc

       Arnd

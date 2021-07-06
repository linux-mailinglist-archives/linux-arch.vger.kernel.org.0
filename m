Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60AF3BCB59
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhGFLGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhGFLGA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B28C61A2D
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569402;
        bh=ud7aIy2xW6L/GOYeoo39u49rPYI3dll7lq+wQ+ciOe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BQbuUdnDgQtcLJXpPJc4sZanYppBNtQwa2DxmyPrJdXN2XzivPmqBQUZDkxYMEoSE
         VJmmxKgZjcKuKeyjAJ6QKNtw0Sud1XK83e4+nz6+fqeoHmq+8NvPcTV3ZwkBzmLQB0
         y1S8Sr0aH5KFsN83/3OoxVkhHvmdMPHTEshJvZ8dCTDqnSkFaM2VXkYnnD1Td8i/ec
         A7jg/8awWL67P01rjt3SOcVi8F4fVXLd5K3Lrvj28NAuXCBx3+Yxr5/oqaZ4BjcC4t
         tboReKLgRk3Krh1rYdgrb4i179fgJ/mg+BWOrKzN8+nZK9lzrKUmkkmx+Pa6ObfMLE
         M+tgf9R4agl7Q==
Received: by mail-wm1-f47.google.com with SMTP id a5-20020a7bc1c50000b02901e3bbe0939bso1972766wmj.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:03:22 -0700 (PDT)
X-Gm-Message-State: AOAM533eibFknDOHqHvTkTxMpxp+h4btNc0u07Cjn425nFHUF+t3tZiy
        lUvKwefgDJhYi8zepS8NXzMFfczCCwpc2t11Mjc=
X-Google-Smtp-Source: ABdhPJwl55C2KALILVSU+EPcVRmd3GczOpWAh6wKG3mCaKFhiYZaS2IoO4Lm3jf8lCB6OkVaR85eGcqaEqFoxDApb5k=
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr4046217wmp.75.1625569401122;
 Tue, 06 Jul 2021 04:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-18-chenhuacai@loongson.cn> <CAK8P3a3Do4NModPfJkZTbOqgXedVjJfqwWMyK0FjFAv2v6RjhQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3Do4NModPfJkZTbOqgXedVjJfqwWMyK0FjFAv2v6RjhQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 13:03:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ssHnPAt8jnRgqk3aXJeyt4+dZQxKDy=8RrL9BNRAsmg@mail.gmail.com>
Message-ID: <CAK8P3a0ssHnPAt8jnRgqk3aXJeyt4+dZQxKDy=8RrL9BNRAsmg@mail.gmail.com>
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
an abstraction layer in-between. Are these not all part of the either the
CPU architecture definition or the firmware interface?

Do you even expect to see non-SMP systems deployed widely enough that
SMP support must be optional? On arch/arm64 we ended up always
building SMP support into the kernel because practically everyone wants it.

      Arnd

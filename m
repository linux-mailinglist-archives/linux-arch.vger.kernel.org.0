Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029893BC964
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGFKUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:20:45 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKUo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:20:44 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWitM-1lgxHQ28IC-00X3xG for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 12:18:04 +0200
Received: by mail-wm1-f50.google.com with SMTP id i2-20020a05600c3542b02902058529ea07so1864982wmq.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:18:04 -0700 (PDT)
X-Gm-Message-State: AOAM531NTL/z7NzZj0bJlPpQrqFxUXYrSfYAcMTOeekuc3dLt9OJcKVX
        lVvQN8Gn7odagGzFs3Z0E0xLM5o5l2maZqaio6E=
X-Google-Smtp-Source: ABdhPJxm72cGmh6jc23Nycy3FJ/CroWom8GKhZxUqM17TgAGUPDQhAykJt1S/kPxZmvttPW1pf/KwgfIOcx9s7qAlEk=
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr3838282wmp.75.1625566684243;
 Tue, 06 Jul 2021 03:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-17-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-17-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:17:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a10NN4mZYtzEEiYv8jqPZbMH-LH406cZV6M4HXhr-Z9yQ@mail.gmail.com>
Message-ID: <CAK8P3a10NN4mZYtzEEiYv8jqPZbMH-LH406cZV6M4HXhr-Z9yQ@mail.gmail.com>
Subject: Re: [PATCH 16/19] LoongArch: Add VDSO and VSYSCALL support
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
X-Provags-ID: V03:K1:yoB4P7JXurDnEO0nxxoaYpSDqYGRSGAL7DwttQEmeXy945+kHzP
 FgolYWoIl6Xu9SehG9vxw3Z0Mit1RAfTDTkDnWXUkAmMppw+jylTKFnp3CYgD+z76P8gelF
 WmgQ1cxi8NJ5M+31QaZRfbWL88WSPgGliRGOrLiJoj5E2brnV2mlHCsIQbr88i7cDO8zOy5
 zTcnApaqjmMrKlPa50QKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o4bcS1F/7Ew=:HANQxmLBy4clWiTI5HeDCQ
 jMnNF45HRfimJ1V8wMgqBuAPJbCzUJqRGz7yZbR6JcQ1/cEylx+WCPC4n8TDT3KIL2A7PRnrw
 21DlaNB7LKF/cJVVzRHzKu8cuVivLNGpi7oot7QRBqC30pMR3BDb5kG91d609H6nHuVAfLVXj
 imXJt94+nIYV4ItZKBOFdBc8LbPF92Hv012h4Yf3TsOq59OYkMLd3rOAUMvrDX12anfwhQoiS
 LquW93MLPDlHieSsj69zZF7NBlf0Qx5kbrJVLR/VP3JIGuKPRoPDgG+2t8yJ90q/vB0TCKoDt
 WI0gdibe5fTd+bchds7klM51MEqI5ZRXHzz4deTandxoH011lPPHROeLIrxP3PbCf9UKaLec2
 jhYvbqWzEcHikZdaK2R/jb8biUErGgwK/VNztby4tnTgf/CJ0rZROxgkeR0ePqyG7FDuT/w9z
 DJ4zW012TTLtSLHX8pXfTgYZYaM4bPWaABprIoRJpYqT65shS4VTpK7Za6FpdL/M62MqfqHWY
 Q8VmogZtlri4jBTNzdRW2fHPp0C6Sr0/lr0cZWXRjyWz9PVzY3JaiL/iFPFxtmzLZQpHHRwXZ
 HyLxMObdukPCzLAhWG50pe9yq8qkwKxcIP4OZsQYnUHDeKMDqkfqz+A1gh8VZtEBiLK2szuXl
 OzC3xFOUyd0HaAwUUf2WZFrecqwfOVaQYtOqQXe0k+IwXjgLERLySKSp2Ii39AUBad+kslwKf
 s0I6s5vXnthqa8IPiCkSwCAuAX4QJo+/KFdBFnRrqS4+I9o29Sox5HRkXVUJ1RSf5/jIiVWd9
 a5Z4K8L8J9+8e8LnD992tVtBTOzh1BpWcV5Qkd7PHP/1i95ewuQzi2VfGyag7V0+XfdAdz7BZ
 pvfV4jO0dFiWSZne5f46D+dqOqLdE3sGvspLizcWkA3AV9elj3KmuygIhYPcmKIjcv/pz0RFi
 ziwt1zK4tDmcTpY/t+/mms55ZBwQf9DeaYt6NTl9J9cwdxC3aqpCT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds VDSO and VSYSCALL support (gettimeofday and its friends)
> for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/vdso.h             |  50 +++
>  arch/loongarch/include/asm/vdso/clocksource.h |   8 +
>  .../loongarch/include/asm/vdso/gettimeofday.h | 101 ++++++
>  arch/loongarch/include/asm/vdso/processor.h   |  14 +
>  arch/loongarch/include/asm/vdso/vdso.h        |  42 +++
>  arch/loongarch/include/asm/vdso/vsyscall.h    |  27 ++
>  arch/loongarch/kernel/vdso.c                  | 132 ++++++++
>  arch/loongarch/vdso/Makefile                  |  97 ++++++
>  arch/loongarch/vdso/elf.S                     |  15 +
>  arch/loongarch/vdso/genvdso.c                 | 311 ++++++++++++++++++
>  arch/loongarch/vdso/genvdso.h                 | 122 +++++++
>  arch/loongarch/vdso/sigreturn.S               |  24 ++
>  arch/loongarch/vdso/vdso.lds.S                |  65 ++++
>  arch/loongarch/vdso/vgettimeofday.c           |  26 ++

I fear you may have copied the wrong one here, the MIPS implementation seems
more complex than the rv64 or arm64 versions, and you should not need that
complexity.

Can you try removing the genvdso.c  file completely? To be honest I don't
see why this is needed here, so I may be missing something, but the other
ones don't have it either.


       Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA803BC955
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhGFKTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:19:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhGFKTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:19:33 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4R4i-1l0jat3u4c-011No0 for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:16:53 +0200
Received: by mail-wr1-f51.google.com with SMTP id n9so8080074wrs.13
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:16:53 -0700 (PDT)
X-Gm-Message-State: AOAM533QtW69bBp7B1Bb3ij5s2VudIfseREryHeVtOtEg9qeSPho2h4Y
        SbFMqlUuSn5yeQXANixwxwAh6GIWtr02V4UPrzo=
X-Google-Smtp-Source: ABdhPJzCZ9BQQBkkhOgIWxGXMsAPQmyYAmShe5QZqlTYR78mJSvZotsx8gVt1OBC5r33B1h0jXyf2e11c46JWY3rJgw=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr21752503wrq.105.1625566613672;
 Tue, 06 Jul 2021 03:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-8-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-8-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:16:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
Message-ID: <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
Subject: Re: [PATCH 07/19] LoongArch: Add process management
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
X-Provags-ID: V03:K1:gZuqFrfg7tAbJBM8cW4Tu3bdcnmg3dmpfk43siHH5pcP7ZHaCqY
 1wT5NuoI6vpR5Aa9vhc1LYHdWl/bgppOPokBlBTAjfLMQH+zxC+CYZBkHca94P77iWMFRKT
 mJP71u5f38K52Fb5vr18UjcxDs9A+ENSOGqd4dlroJKkxDMGXlng7OXF8+QuYQ0D3dzpCxn
 8OHFGySeckh4+apXiNGLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ob0UfSq7gWc=:Ub5r2iKa0szDMa6NIlYl6j
 PHbhxmP1TQrImLhRCBRzHvjXE0KU7CFwfW699aN4UHruqyW9nokpDln5+563PnBjLv7iDJsBU
 ZwImUkgX3CbCHH3mZ3QxdCjK7lbHFm33GMCKNR2iFEJ273WL2i87gKFOasruOkFD1KyuUIHWy
 EQAOcwa6xpTO9qdiUZepvWKCNdx/SO0zsbi8p2+CgKo7iti9L+EGEDnOEuhrNXqiqWDsMz8CZ
 MykxAhtuNONupNGPDCkzufT3RpSqe+XJ8e43Bg97BIEoIcJUecW/uRN4kqi1fp5nFy4A5zwB8
 65ZxOQZ7/zSRsyuFjAFitssNhjV7A94XGmI43Db11q5Q1Uo6soedo5j7nxIs1ItP6uk3286LE
 6pce8MWX1RGfSR3UxVWLyxY408hXYiQcerjbr4C7EU38QxZBf7oQDf/mAO384f/XLACCHIjOY
 05Vhtuo1Djucgqu/01twZduVzn2murWWalG8OL30ytGewJv35ZDUBZ0I+R1iXzWdWL7dfqxba
 4+dtNJ8P+47KvdY4CulUQ7YYC1YVp5C/HekWz1ayTge1DIJqhU5OOtwzeWhxN2FuhCuYNGfBM
 adEbVZkL7XDxkkgrWycaa0ZtthZvTSPzIPsiU38AB6OlG0ELNsQCSrmO4gP1YMJi7/O2QccWC
 e08czwJ9Lrn4fKzJg/tKomsTsINFY1wxwiujaU3+LCuM3oV1ITwwk0sw31CNdyNM6Z0zla9DX
 2xyHPrPRVhOly3w19WzJRQEKcxOOfRr3ZXHSge4BjNz7X3raIXk1IETiFsXSshMymrHI9m2VP
 pl4d9vdXUBaIEiKM2deldCmjW9g+ZTSYdHZLkEJLtGF5Cv1ik/4r2VG01BzZl6j9bEQdgh1Mi
 rlxIytUgyXWTx2Q07p+plpHuTwukiGkacV1nY1ZAvd9MfhTAOeBu9q7x9vmPDW1BaQwK2nMKt
 0PXtpRdUDtGimHgsgMWUMEtHZv6KXZcpLXGJDWfT/XBzgQOyNWW+6
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +void arch_cpu_idle(void)
> +{
> +       local_irq_enable();
> +       __arch_cpu_idle();
> +}

This looks racy: What happens if an interrupt is pending and hits before
entering __arch_cpu_idle()?

Usually CPU idle instructions are designed to be called with interrupts disabled
and wait until an interrupt happens, including one that was already pending.

           Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78075277D1
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbiEONZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 09:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiEONZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 09:25:34 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645E1929D;
        Sun, 15 May 2022 06:25:33 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id v139so13011707vsv.0;
        Sun, 15 May 2022 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEQ4uQyIrqUxfixlrCUIQCyENasylTQx3DCNFgEzZbs=;
        b=GjLvnXv67BY1hrvOe0O7sOXBKXA37ceu1dmsGi7atgSmsP0tPjPu0CZ1ZCqvDBahl1
         zRRIel3THcW23fO4Nmd8hqwIlLLC5uNU+gDPdegxp2v5k/FkMieoGWiEXIWZc5zvX4l1
         mp/ydkkHsbQXwsT32dCaOssJvD+ML7bUrWMR69tSrXWlSmjpdXnnicdppx3mJKDqQqSJ
         ldprC5mFc89B/g9GAmu9ernCAXGzD+exRAlioDGLedE1naiib+ZhAc6pO78DVbpdLAz/
         nGhdKQ2YIiquoxCmWdMX+dTNmBMkdUXumO0BxRWI4KtuC1JtSZVlS0obdaRzg+sgkbil
         trOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEQ4uQyIrqUxfixlrCUIQCyENasylTQx3DCNFgEzZbs=;
        b=IsGgpqbdylEDZsweDawnl/fqQ8dgRTW5hMrhkJ/M5GcYxj7JnkxjNoGQBKkRUHDtWP
         LXKHOsYU6lYEFzu3FWA7vgfvzZtf9ZFuhvR0phC15yEGTfB/UWeWLa8P1aUCVlkLW2Qq
         S3rtbeUUXRSnE6+V9Mg1E8wTrHbro7bPqGYOMQwuRn0bxulfAyM/2SVIrgVsJr0HuVma
         Y68DboMMZdxeHB+QkRTZ0ywCWJctmnCgBbBL9wZ2z2lOM1Mjx8rjEN/CVQRXdheo1RMa
         3d3YJ2exZPWfnyPlF3tAE7AAO+o+WuDto5Wdt6LCKnvyKq4crhAgVVvWC2XCVmqtELyX
         iEzw==
X-Gm-Message-State: AOAM530DRNnWheNEf4WOKz//wvwBiNl/pGvYo2M9w4kjbYZNj7v3u8JM
        oHzlIGUnOalAeeLKiitRgxcRRih2AbkvUuGWZU4=
X-Google-Smtp-Source: ABdhPJzrzrupl0KDjMwirRl7viHPPm/PzhWUIr9Uk/MXdievk5rxZpz8H17DTt+ry/kvkagnscVDaxUwUHi8W2pr+rU=
X-Received: by 2002:a67:2e91:0:b0:32c:df82:9ad3 with SMTP id
 u139-20020a672e91000000b0032cdf829ad3mr4942680vsu.40.1652621132597; Sun, 15
 May 2022 06:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-12-chenhuacai@loongson.cn> <8c6b0c27-26e3-6668-06b2-57dd27f77496@xen0n.name>
In-Reply-To: <8c6b0c27-26e3-6668-06b2-57dd27f77496@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 21:25:21 +0800
Message-ID: <CAAhV-H6DVs0n0OAUvErAXuiVTRODn_Cjr06bmXOObWfgMqoJew@mail.gmail.com>
Subject: Re: [PATCH V10 11/22] LoongArch: Add process management
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sun, May 15, 2022 at 5:20 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add process management support for LoongArch, including: thread info
> > definition, context switch and process tracing.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/fpu.h         | 129 +++++++
> >   arch/loongarch/include/asm/idle.h        |   9 +
> >   arch/loongarch/include/asm/mmu.h         |  16 +
> >   arch/loongarch/include/asm/mmu_context.h | 152 ++++++++
> >   arch/loongarch/include/asm/processor.h   | 209 +++++++++++
> >   arch/loongarch/include/asm/ptrace.h      | 152 ++++++++
> >   arch/loongarch/include/asm/switch_to.h   |  37 ++
> >   arch/loongarch/include/asm/thread_info.h | 106 ++++++
> >   arch/loongarch/include/uapi/asm/ptrace.h |  52 +++
> >   arch/loongarch/kernel/fpu.S              | 264 ++++++++++++++
> >   arch/loongarch/kernel/idle.c             |  16 +
> >   arch/loongarch/kernel/process.c          | 260 ++++++++++++++
> >   arch/loongarch/kernel/ptrace.c           | 431 +++++++++++++++++++++++
> >   arch/loongarch/kernel/switch.S           |  35 ++
> >   14 files changed, 1868 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/fpu.h
> >   create mode 100644 arch/loongarch/include/asm/idle.h
> >   create mode 100644 arch/loongarch/include/asm/mmu.h
> >   create mode 100644 arch/loongarch/include/asm/mmu_context.h
> >   create mode 100644 arch/loongarch/include/asm/processor.h
> >   create mode 100644 arch/loongarch/include/asm/ptrace.h
> >   create mode 100644 arch/loongarch/include/asm/switch_to.h
> >   create mode 100644 arch/loongarch/include/asm/thread_info.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/ptrace.h
> >   create mode 100644 arch/loongarch/kernel/fpu.S
> >   create mode 100644 arch/loongarch/kernel/idle.c
> >   create mode 100644 arch/loongarch/kernel/process.c
> >   create mode 100644 arch/loongarch/kernel/ptrace.c
> >   create mode 100644 arch/loongarch/kernel/switch.S
>
> The context handling code already saw use in released version of strace
> [1] [2], so it appears appropriate to consider the user-space additions
> to be in a reasonably good shape already.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
Thanks for your review.

Huacai
>
> [1]: https://github.com/strace/strace/pull/205
> [2]: https://github.com/strace/strace/pull/207
>

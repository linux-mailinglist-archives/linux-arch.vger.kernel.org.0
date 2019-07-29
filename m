Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9ED789C4
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfG2KpT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 06:45:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43973 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbfG2KpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 06:45:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so61250859wru.10
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1uRSJMzSbMgXzpr1bE0yMIan7guz+Q50RZKdFg1L8ZI=;
        b=diz5DNBBaMllCaVOjSe4ntiMRXjGrExzxzEV3+6ALGTP/jo/n40TIvljHrUEHDdvKL
         nTX2oAuyB5VwH42cCVv422oaQws43evrSKM9YuAB02ypPww1oQT3Fb48KB9+NlxBZFdI
         cd8OtZdiyMbMEE7nZ9jtdYvV43ZAa0rUWymXd6Q1YrOYs5LRnWTNSCjQDOP0xxLmNwkf
         TXDot5acyae9LCCtq/YpFP0UVfclbkQw6+KdsJR7hBE1C+r0LMaFnETD77odiNu2t0ar
         OD84NIlWi3jTeczZgwUUw+luNrVj84Q9dsuMJgNtz2BoK2bzZoujK0na9fK6mn79JQML
         CBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1uRSJMzSbMgXzpr1bE0yMIan7guz+Q50RZKdFg1L8ZI=;
        b=BHDpeKhZdoHLGyqqKx01EVWZV6DZIJ14fGg1vyJ/Hc5kk9XOtRQS59BG65Cp+xRZJI
         GOVcTu3otvPnrjnMlZokJTLKLdg1uDd2NYF8ZppxSX/9QCfY1TdPmkCtBOoxe5OBqALF
         FpSKJQUzVc5bFhyOiWkpYxcxVM47v1FypCF8H+2ippW9dQpdKdSJOD4p7W9Kl85Bi504
         aNfSuhQ7lwQfjG3HJat83deQ2ke6DUzJoFA9yQOLZuMrIBO20E79Rh+yxlMwuTAP8s7Y
         GdT1Qp+B1jJ/zpmcboIBYEB1gTjJlh3x+opp+tWP7tHXtaRE0woxeJUjreug6EWqzOK9
         7qSw==
X-Gm-Message-State: APjAAAUxBN+iiT3lbBPMfZrFF2UHpQlz6+trN6n2//Odaanm5bnejb/Y
        XXtkDuidxJG+mWEBTg5jP98m5CkdssgUgScytkCTYA==
X-Google-Smtp-Source: APXvYqzxC8+U80dOcY3+0v4Gp3m8PnzizbVMbtGH045kogWUKhP/nD0Ks5xosy/Uu4eSBfLEYhftB+1kajaEKc1bUMg=
X-Received: by 2002:a5d:6b07:: with SMTP id v7mr10084364wrw.169.1564397117096;
 Mon, 29 Jul 2019 03:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190729095521.1916-1-ard.biesheuvel@linaro.org> <CAK8P3a1=6nW0d+LOp__tMepYwGCc5f+e6qb1D3wUtp6_79Yd-A@mail.gmail.com>
In-Reply-To: <CAK8P3a1=6nW0d+LOp__tMepYwGCc5f+e6qb1D3wUtp6_79Yd-A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 29 Jul 2019 13:45:05 +0300
Message-ID: <CAKv+Gu_8nNd-td5F9u0dgH7x1kF+r8sCL432MvzmxqNZqqW-gA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: make simd.h a mandatory include/asm header
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Jul 2019 at 13:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 29, 2019 at 11:55 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > The generic aegis128 software crypto driver recently gained support
> > for using SIMD intrinsics to increase performance, for which it
> > uncondionally #include's the <asm/simd.h> header. Unfortunately,
> > this header does not exist on many architectures, resulting in
> > build failures.
> >
> > Since asm-generic already has a version of simd.h, let's make it
> > a mandatory header so that it gets instantiated on all architectures
> > that don't provide their own version.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Looks good to me, if you want this to go through the crypto tree,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>

Thanks.

> I noticed that this is the first such entry here, and went looking for
> other candidates:
>
> $ git grep -h generic-y arch/*/include/asm/Kbuild  | sort | uniq -c  |
> sort -nr | head -n 30
>      24 generic-y += mm-arch-hooks.h
>      23 generic-y += trace_clock.h
>      22 generic-y += preempt.h
>      21 generic-y += mcs_spinlock.h
>      21 generic-y += irq_work.h
>      21 generic-y += irq_regs.h
>      21 generic-y += emergency-restart.h
>      20 generic-y += mmiowb.h
>      19 generic-y += local.h
>      18 generic-y += word-at-a-time.h
>      18 generic-y += kvm_para.h
>      18 generic-y += exec.h
>      18 generic-y += div64.h
>      18 generic-y += compat.h
>      17 generic-y += xor.h
>      17 generic-y += percpu.h
>      17 generic-y += local64.h
>      17 generic-y += device.h
>      16 generic-y += kdebug.h
>      15 generic-y += dma-mapping.h
>      14 generic-y += vga.h
>      14 generic-y += topology.h
>      14 generic-y += kmap_types.h
>      14 generic-y += hw_irq.h
>      13 generic-y += serial.h
>      13 generic-y += kprobes.h
>      13 generic-y += fb.h
>      13 generic-y += extable.h
>      13 generic-y += current.h
>      12 generic-y += sections.h
>
> It looks like there are a number of these that could be handled the
> same way. Should we do that for the asm-generic tree afterwards?
>

I guess it depends whether any dependencies on those headers exist in
code that is truly generic. If they are only needed by some common
infrastructure that cannot be enabled for a certain architecture
anyway, I don't think making it a mandatory header is appropriate.

So I think the question is whether the first column and the number of
per-arch instances of that header add up to 25 (disregarding the
exception for arch/um for now)

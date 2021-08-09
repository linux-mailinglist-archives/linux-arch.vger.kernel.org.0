Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF33E4502
	for <lists+linux-arch@lfdr.de>; Mon,  9 Aug 2021 13:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhHILiN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Aug 2021 07:38:13 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:33702 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbhHILiM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2021 07:38:12 -0400
Received: by mail-ua1-f45.google.com with SMTP id x21so2867146uau.0
        for <linux-arch@vger.kernel.org>; Mon, 09 Aug 2021 04:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lxScpYZQF2str6UYsqSugtR0htuZjdUYznhsnhT1Fo=;
        b=fnQSlCIPMQ9OMXxwuZEWskrqQU+qapcrUHta+eLGqogpk9gXV5Oh8pV4n8GjMGEfjj
         CnTtu6rHmC/NdrMqKyqQpMJZjKJTcZe/IxKdUlE3B4elwpChEwhzw7l3MuX/8OdX8AMC
         1LvVXzn6AbX6MTLHrVh473XeKgGQWQgaZqlmVYxzcTSIuvVWzS0Mpdd7IdDENf5vHzyZ
         neBkAH48pJ/qUd/74bvvK/K94BjZ18twyb3zkSL4ujqbMy7DrTNA1hBoQVlFpGoHu2TZ
         pjvuTqeho7GKOK1rrtkcLTsVQCI6p2/aCERmDJNeLwt3VPa3R5qvY+RygJDIXdhEeckm
         qicQ==
X-Gm-Message-State: AOAM530BlFmLN/dW4rbisRo+LlffeejfTGrib9nofCa9W0QW7EkATwj+
        HD9aLUDjrvxpKBOuwZ/Ff9duuiIL42A4CFG5IcM=
X-Google-Smtp-Source: ABdhPJyH2XL+Scdh6S6BdvvBwmi8TPtVtCZlHORGErIQxoJ3Pm68Rd59l/dVfylnbFYWdkchZl+5hLU3Iz/+LpIkJbA=
X-Received: by 2002:ab0:1d05:: with SMTP id j5mr329134uak.2.1628509071959;
 Mon, 09 Aug 2021 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210728114822.1243-1-wangrui@loongson.cn>
In-Reply-To: <20210728114822.1243-1-wangrui@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 13:37:40 +0200
Message-ID: <CAMuHMdVO9yrdJEvjYZ4i08RwLsjgG2J=bJ+tWwbBMCRNQ1PHLg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/5] locking/atomic: Implement atomic_fetch_and_or
To:     Rui Wang <wangrui@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>, hev <r@hev.cc>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rui,

On Wed, Jul 28, 2021 at 1:50 PM Rui Wang <wangrui@loongson.cn> wrote:
> From: wangrui <wangrui@loongson.cn>
>
> This patch introduce a new atomic primitive 'and_or', It may be have three
> types of implemeations:
>
>  * The generic implementation is based on arch_cmpxchg.
>  * The hardware supports atomic 'and_or' of single instruction.
>  * The hardware supports LL/SC style atomic operations:
>
>    1:  ll  v1, mem
>        and t1, v1, arg1
>        or  t1, t1, arg2
>        sc  t1, mem
>        beq t1, 0, 1b
>
> Now that all the architectures have implemented it.
>
> Signed-by-off: Rui Wang <wangrui@loongson.cn>
> Signed-by-off: hev <r@hev.cc>

> --- a/arch/m68k/include/asm/atomic.h
> +++ b/arch/m68k/include/asm/atomic.h
> @@ -67,6 +67,22 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)         \
>         return tmp;                                                     \
>  }
>
> +#define ATOMIC_FETCH_OP2(op, c_op1, c_op2, asm_op1, asm_op2)           \
> +static inline int arch_atomic_fetch_##op(int i, int j, atomic_t *v)    \
> +{                                                                      \
> +       int t, tmp;                                                     \
> +                                                                       \
> +       __asm__ __volatile__(                                           \
> +                       "1:     movel %2,%1\n"                          \
> +                       "       " #asm_op1 "l %3,%1\n"                  \
> +                       "       " #asm_op2 "l %4,%1\n"                  \
> +                       "       casl %2,%1,%0\n"                        \
> +                       "       jne 1b"                                 \
> +                       : "+m" (*v), "=&d" (t), "=&d" (tmp)             \
> +                       : "g" (i), "g" (j), "2" (arch_atomic_read(v))); \

"di" (i), "di" (j)

cfr. "[PATCH v2] m68k: Fix asm register constraints for atomic ops"
https://lore.kernel.org/linux-m68k/20210809112903.3898660-1-geert@linux-m68k.org/

> +       return tmp;                                                     \
> +}
> +
>  #else
>
>  #define ATOMIC_OP_RETURN(op, c_op, asm_op)                             \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

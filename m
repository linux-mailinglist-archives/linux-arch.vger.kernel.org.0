Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486F355758C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiFWIdu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 04:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWIdr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 04:33:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7E13F8A;
        Thu, 23 Jun 2022 01:33:46 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MORN0-1oJEda2liA-00PwU7; Thu, 23 Jun 2022 10:33:44 +0200
Received: by mail-yb1-f177.google.com with SMTP id 23so34569416ybe.8;
        Thu, 23 Jun 2022 01:33:44 -0700 (PDT)
X-Gm-Message-State: AJIora9yHFTN7923r6JSeJlM2Z6Np+jeeCOJcXAP3QIKRj6MlriEi7Cr
        Ru6Dgrq4V720635n0uZ6Dpp4TWH4YipGZ29N3/E=
X-Google-Smtp-Source: AGRyM1vpjNUL/cDQCAr6IDE7zemhTcO8DLjRIsD3hMydd57CzdT1bmHPuTtCl+as80/GyaFbtaHiOikuetXsjsJdvX4=
X-Received: by 2002:a25:d792:0:b0:669:2e6e:208e with SMTP id
 o140-20020a25d792000000b006692e6e208emr8179490ybg.452.1655973223374; Thu, 23
 Jun 2022 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220621144920.2945595-1-guoren@kernel.org> <20220621144920.2945595-2-guoren@kernel.org>
In-Reply-To: <20220621144920.2945595-2-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 10:33:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com>
Message-ID: <CAK8P3a2rnz9mQqhN6-e0CGUUv9rntRELFdxt_weiD7FxH7fkfQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] asm-generic: spinlock: Move qspinlock &
 ticket-lock into generic spinlock.h
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>, Rui Wang <r@hev.cc>,
        Stafford Horne <shorne@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:C580wb4YURZM/E3PsM9I4ixOvma9jHd9L4ezyUoqtQcqWRAnLHJ
 BugBcEUsBF+A/L/1o8JF1o4nkn4ir7hurViTrb6qagOJ2l2b8zAT7dQJEbmQOMpn0SO6sGL
 vKdGQTWTOyoO4tE4pnitcSkxSlcIBPGDyTQnWsVs7Z1a8vMqg3DF4gdfIxgXvKxzetEMnMx
 YCHeBc4IaOqPvNXYnGsfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FJXonaS8Pls=:UwNb83m5zTgE7b7iW/45ul
 4xvzGs3A0LIG10vu1BrHVgZv420w1+JWW6Gdn4l+DFaTjdiO7mjfdlhLSkll9yWH3aUvSwdP7
 87sci12D7cPMgPwFM/T8ZPcWcSLoxH7QwEHObOQzamRiMQ6J+0Jnmwh19MuugKAt1g0oxg6dx
 N1AYO3L7STBLflOkf77mJnXn7n3z/KZu7cndtv7xcYNndzWsr+MatHPxZJPZfQEz8fGN2WNJE
 Zi+6NdkJOKQSINoOu0ETo0MBKLvY2Tdw5f+8jdJxbY2hs1TpkI/bAoJWXMuWaDAKMgd+E5bCj
 xojnUVPR2ZfJv/EAkbPyqNcMph1Z+P8e3Q0jM92lPsnqIEZrPQ5/NWlLflD2V3mySY479POWJ
 1ioUVcflAhtZhHb/CBLzFae9T1yXrrzEe5ttgCSEOirTxUldIEpQcB08QM4wcF/E04CQVCobA
 6dMWh0zTTAX/w+WMnXGOthdxztThmTlaKwc7Jxr4f7Raf55vBKz/6UfL0pSN/El3eiuUNuLqX
 vwv9DDzlsM3W5GGUYyU93JTM0mijcArwVnCLrHCwFffRutR89/Em9pUPUP7lK/xrjWuoj9tq7
 m5vL66UWRk8lDDRX5UAsLvIbxH7qe0/zVWrL9dpn6yllIDxUrIdc3JD3kGoutJMHst5ghP7Fd
 tEJtf0VQ0mq43b6r1qzuhCIMjH0oRIuVAqTbrA27F4jQU/QVaJVKM91qmhqd9Hi8GdUHXRmwH
 jaevmgJcK0ALZKaLOFlyeC5CoSGAfGo3ibDmyiesU97vAHr+NDRBjUcEJ34CWeOb5HlftjsL2
 OIvaeOF34fEm9pMI30QLaMK92yVUcsk8gjfYVJ9jQavJDwJgzne56oe/n8QIfYX5YnDou86VC
 Bnwb4VGeFe9hDVgTPKbA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 21, 2022 at 4:49 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Separate ticket-lock into tspinlock.h and let generic spinlock support
> qspinlock or ticket-lock selected by CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> config.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/spinlock.h        | 90 ++------------------------
>  include/asm-generic/spinlock_types.h  | 14 ++--
>  include/asm-generic/tspinlock.h       | 92 +++++++++++++++++++++++++++
>  include/asm-generic/tspinlock_types.h | 17 +++++

Unless someone has a very good argument for the "tspinlock" name, I would
prefer naming the new file ticket_spinlock.h. While the 'qspinlock' name has
an established meaning already, this is not the case for 'tspinlock', and
the longer name would be less confusing in my opinion.

> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
>  #include <asm/qrwlock.h>
> +#else
> +#include <asm-generic/tspinlock.h>
> +#endif

As Huacai Chen suggested in the other thread, the asm/qrwlock.h include should
be outside of the #ifdef here.

> diff --git a/include/asm-generic/spinlock_types.h b/include/asm-generic/spinlock_types.h
> index 8962bb730945..9875c1d058b3 100644
> --- a/include/asm-generic/spinlock_types.h
> +++ b/include/asm-generic/spinlock_types.h
> @@ -3,15 +3,11 @@
>  #ifndef __ASM_GENERIC_SPINLOCK_TYPES_H
>  #define __ASM_GENERIC_SPINLOCK_TYPES_H
>
> -#include <linux/types.h>
> -typedef atomic_t arch_spinlock_t;
> -
> -/*
> - * qrwlock_types depends on arch_spinlock_t, so we must typedef that before the
> - * include.
> - */
> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> +#include <asm-generic/qspinlock_types.h>
>  #include <asm/qrwlock_types.h>
> -
> -#define __ARCH_SPIN_LOCK_UNLOCKED      ATOMIC_INIT(0)
> +#else
> +#include <asm-generic/tspinlock_types.h>
> +#endif

I don't think this file warrants the extra indirection, since both
versions have only a
few lines. Just put it all into one file, and change the files that include
asm-generic/qspinlock_types.h to use asm-generic/spinlock_types.h instead.

      Arnd

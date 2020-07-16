Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC62221BB
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGPLyP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 07:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgGPLyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 07:54:15 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CCAC061755;
        Thu, 16 Jul 2020 04:54:14 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f5so2723581ybq.2;
        Thu, 16 Jul 2020 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaJ0JMrTJYBmtKLAQldY6IvzjG2m4qpjYZEkAKQSgqM=;
        b=HY8rGe6E/1bvzRaeOAhIQFlnYDdoki/hEKRbJXCmnrCTUA88xVwaUpEHEROkmqQKa1
         81B5KORwMDCEWKpqppcfOlgKgxoHDOKND7nsS3p09iy3d01hkA81/TYlPqd6iFLA8Xks
         fwXasf6a2WUuqmsUYhdQwcb+3MBFDu7Sj97TQbsn3APMlTkNKhChBkaNP1itx7QufR07
         YEFNVz9aJtlzPNDxnnsajGnBzL9xhvSNoKnWiRMNAHYu615fcIRxmgrK9rivSr4zcMFe
         +tbAsf94e/cEjm0b8eu+oCD7UdwVGDqh4txY59emU6ZZLlt1V325qVQnJBFbFZKt70GK
         YGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaJ0JMrTJYBmtKLAQldY6IvzjG2m4qpjYZEkAKQSgqM=;
        b=TaEkwUBw1QHgwtnjHM6p770g7MVJn1jPJZZYjJJetru+X212pFey578rERmJ3aQAqx
         yd7/BRDLHKYSxY+mVEuowtMHkq1xRV8BP0M4iXfLClifBb9S5tRvBqoTvuZPEq0L2C2P
         wkhgW/jEtlM5iucMmiJSEeIvDjYQiJbxEcl9f3mVbRRNTbiBk7AaEkWtGjLaO1BCYbpb
         iDS6Tcwrsqt2mGGHnkmAdygozbNLxrZf2p1ZOnH2c8AzjfksOMtfSiJ1ai1Y78LKQZUq
         BMqzH1vtjAnUKa1hjAg4ay2KDAu593chPpplWKZT2fOPyLB9QYCf1um6yxYOgrvNDv1n
         EnOA==
X-Gm-Message-State: AOAM532BqESPoHc+yKj53cmIeVlMmJDnR+Z95/YWzuLmhDRrQzl5eNMZ
        ylfN6QWN0CBFGvXXxdPoPDKTULjsRuzpiZ8EG9CAxmvizqXNHA==
X-Google-Smtp-Source: ABdhPJxPLyNS9fybE1aGkB//ZprwoWXRMw2Vz2zlOMnoscqvTRR6LdUXVLw5wQcx8l5jsrf4TiWG2oRkzFT2PWF6pyU=
X-Received: by 2002:a25:2d6f:: with SMTP id s47mr5449999ybe.1.1594900452811;
 Thu, 16 Jul 2020 04:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200716112816.7356-1-will@kernel.org>
In-Reply-To: <20200716112816.7356-1-will@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Thu, 16 Jul 2020 13:54:01 +0200
Message-ID: <CANBLGcxme3=+G3tsd_4ckMFPfaECZ1HzsnKy=LybEhyje_9Wdw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/mmiowb: Allow mmiowb_set_pending() when preemptible()
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        Guo Ren <guoren@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 16 Jul 2020 at 13:28, Will Deacon <will@kernel.org> wrote:
>
> Although mmiowb() is concerned only with serialising MMIO writes occuring
> in contexts where a spinlock is held, the call to mmiowb_set_pending()
> from the MMIO write accessors can occur in preemptible contexts, such
> as during driver probe() functions where ordering between CPUs is not
> usually a concern, assuming that the task migration path provides the
> necessary ordering guarantees.
>
> Unfortunately, the default implementation of mmiowb_set_pending() is not
> preempt-safe, as it makes use of a a per-cpu variable to track its
> internal state. This has been reported to generate the following splat
> on riscv:
>
>  | BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>  | caller is regmap_mmio_write32le+0x1c/0x46
>  | CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
>  | Call Trace:
>  |  walk_stackframe+0x0/0x7a
>  |  dump_stack+0x6e/0x88
>  |  regmap_mmio_write32le+0x18/0x46
>  |  check_preemption_disabled+0xa4/0xaa
>  |  regmap_mmio_write32le+0x18/0x46
>  |  regmap_mmio_write+0x26/0x44
>  |  regmap_write+0x28/0x48
>  |  sifive_gpio_probe+0xc0/0x1da
>
> Although it's possible to fix the driver in this case, other splats have
> been seen from other drivers, including the infamous 8250 UART, and so
> it's better to address this problem in the mmiowb core itself.
>
> Fix mmiowb_set_pending() by using the raw_cpu_ptr() to get at the mmiowb
> state and then only updating the 'mmiowb_pending' field if we are not
> preemptible (i.e. we have a non-zero nesting count).
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Palmer Dabbelt <palmer@dabbelt.com>

Nice. This fixes the problems I saw both in Qemu and on the HiFive Unleashed.

Btw. I was the one who originally stumbled upon this problem and send
the mail to linux-riscv that Palmer CC'ed you on, so I think this
ought to be
Reported-by: Emil Renner Berthing <kernel@esmil.dk>

In any case you can add
Tested-by: Emil Renner Berthing <kernel@esmil.dk>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> I can queue this in the arm64 tree as a fix, as I already have some other
> fixes targetting -rc6.
>
>  include/asm-generic/mmiowb.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> index 9439ff037b2d..5698fca3bf56 100644
> --- a/include/asm-generic/mmiowb.h
> +++ b/include/asm-generic/mmiowb.h
> @@ -27,7 +27,7 @@
>  #include <asm/smp.h>
>
>  DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> -#define __mmiowb_state()       this_cpu_ptr(&__mmiowb_state)
> +#define __mmiowb_state()       raw_cpu_ptr(&__mmiowb_state)
>  #else
>  #define __mmiowb_state()       arch_mmiowb_state()
>  #endif /* arch_mmiowb_state */
> @@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
>  static inline void mmiowb_set_pending(void)
>  {
>         struct mmiowb_state *ms = __mmiowb_state();
> -       ms->mmiowb_pending = ms->nesting_count;
> +
> +       if (likely(ms->nesting_count))
> +               ms->mmiowb_pending = ms->nesting_count;
>  }
>
>  static inline void mmiowb_spin_lock(void)
> --
> 2.27.0.389.gc38d7665816-goog
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

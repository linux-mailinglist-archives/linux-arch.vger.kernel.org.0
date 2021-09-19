Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD7410D03
	for <lists+linux-arch@lfdr.de>; Sun, 19 Sep 2021 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhISTP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 15:15:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51280 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhISTP0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 15:15:26 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4919920B6C5D;
        Sun, 19 Sep 2021 12:14:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4919920B6C5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632078841;
        bh=8vDM8D+5m8xPvdc2yp643jfDPpfQqKCVaC1Iss96USQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E++GjQEuD8h86PIj0eFgMLPpGHo+gv/gwOx/P7NfLnQbdgY0bSOUHjJmuVz2mHiR8
         pJrOCSAQkUIbMVEi9FSrp4IFoK4OGDyZfoaOTKb7WUwu7FT5yf7xMeIpTp0A0RjQbo
         VjBgxZQW3vwvDYnyb1hxag48GspctDRc9PPbi1K8=
Received: by mail-pl1-f172.google.com with SMTP id l6so4846552plh.9;
        Sun, 19 Sep 2021 12:14:01 -0700 (PDT)
X-Gm-Message-State: AOAM532pSjV2cviUpGb7jX9L8uZj/7rKhEKo1EyzMhrmR76k16fyFtEH
        cnRFC4WrnqvS5Iz0qi//ECdXKjGvPm+TqAQI+90=
X-Google-Smtp-Source: ABdhPJwRxYzolnPsQJGaMuUvcKEJKkThU0IWA7kfqOzABVrfLg+jvZZTXQGJo0AcuHRn8asmnl9VkyPd1aOz75MQLPc=
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr3531940pjb.112.1632078840771;
 Sun, 19 Sep 2021 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
 <mhng-22e6331c-16e1-40cc-b431-4990fda46ecf@palmerdabbelt-glaptop>
 <CAJF2gTTJ8M5FpL4=PDnPQgrrPaLxVhsZCTO2rXqaOm6MEn=gnA@mail.gmail.com> <9a8137149a164a13a7a04d72b133ad3b@AcuMS.aculab.com>
In-Reply-To: <9a8137149a164a13a7a04d72b133ad3b@AcuMS.aculab.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sun, 19 Sep 2021 21:13:24 +0200
X-Gmail-Original-Message-ID: <CAFnufp2M_9_TRxoXbRK0bggPXyTgffYnA4moez=uWDNNb=aT8w@mail.gmail.com>
Message-ID: <CAFnufp2M_9_TRxoXbRK0bggPXyTgffYnA4moez=uWDNNb=aT8w@mail.gmail.com>
Subject: Re: [PATCH] riscv: use the generic string routines
To:     David Laight <David.Laight@aculab.com>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13, 2021 at 1:35 PM David Laight <David.Laight@aculab.com> wrote:
>
> > > These ended up getting rejected by Linus, so I'm going to hold off on
> > > this for now.  If they're really out of lib/ then I'll take the C
> > > routines in arch/riscv, but either way it's an issue for the next
> > > release.
> > Agree, we should take the C routine in arch/riscv for common
> > implementation. If any vendor what custom implementation they could
> > use the alternative framework in errata for string operations.
>
> I though the asm ones were significantly faster because
> they were less affected by read latency.
>
> (But they were horribly broken for misaligned transfers.)
>

I can get the same exact performance (and a very similar machine code)
in C with this on top of the C memset implementation:

--- a/arch/riscv/lib/string.c
+++ b/arch/riscv/lib/string.c
@@ -112,9 +112,12 @@ EXPORT_SYMBOL(__memmove);
 void *memmove(void *dest, const void *src, size_t count) __weak
__alias(__memmove);
 EXPORT_SYMBOL(memmove);

+#define BATCH 4
+
 void *__memset(void *s, int c, size_t count)
 {
  union types dest = { .as_u8 = s };
+ int i;

  if (count >= MIN_THRESHOLD) {
  unsigned long cu = (unsigned long)c;
@@ -138,8 +141,12 @@ void *__memset(void *s, int c, size_t count)
  }

  /* Copy using the largest size allowed */
- for (; count >= BYTES_LONG; count -= BYTES_LONG)
- *dest.as_ulong++ = cu;
+ for (; count >= BYTES_LONG * BATCH; count -= BYTES_LONG * BATCH) {
+#pragma GCC unroll 4
+     for (i = 0; i < BATCH; i++)
+         dest.as_ulong[i] = cu;
+     dest.as_ulong += BATCH;
+ }
  }

On the BeagleV the memset speed with the different batch size are:

1 (stock): 267 Mb/s
2: 272 Mb/s
4: 276 Mb/s
8: 276 Mb/s

The problem with biggest batch size is that it will fallback to a
single byte copy if the buffers are too small.

Regards,
-- 
per aspera ad upstream

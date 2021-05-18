Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24284387CA4
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 17:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350274AbhERPnb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 11:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350273AbhERPna (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 11:43:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6CCB6117A;
        Tue, 18 May 2021 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621352532;
        bh=6/AZpMiQsWIzehSS0pf9F1Zsz6DBuPBxPZHPFBj/4IQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBATrxKUo+9lJRDkt+z44QyPpRbXGotCZKr7AmmONwoFikB5osIBfIBVRceLC+s/H
         SnW6BZd5EWBLhwSeaBwmfz9S9R8szJaAPokYGPoP0Sg3PvdU8nUbhobryrwFPpHPjj
         WDSdsEjeVms2eWWsQhljQoKhKdJJHTNo+d+VuzQHT+eYfpnRA63htHOOF6C8X3qOXW
         zYp59xGkk5LpZ3cB4qalJMDfXTkHjIURbL0mO/WL4hQJ8zQ21Mp4TI1PG9RaxcLTJQ
         88Vbl26D+hVKhJoZAT00KFXyQSCrnezmlZH8yEIZbeUgB+85RWqyMFt+TuDRB0nYHE
         FLRjzLcNwCCEg==
Received: by mail-wr1-f44.google.com with SMTP id z17so10720406wrq.7;
        Tue, 18 May 2021 08:42:12 -0700 (PDT)
X-Gm-Message-State: AOAM533T1vQOgqjSit4dvrHcbMwWDUiMrpxij7qU0lIMnorKE9t+uj7d
        bEpjVjtl9TYFCjCMjvPBiTTuOHmP24v8205+YRw=
X-Google-Smtp-Source: ABdhPJyqM7bHu1qcSQI74/RObeZl1HWDfzmYNgspCaVb1ZNRDA2D4kfkWRWH7fq0f6j61Y5yW03ZTIhOATwfLihnHPY=
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr7805910wrx.99.1621352531347;
 Tue, 18 May 2021 08:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com> <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
 <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
In-Reply-To: <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 17:41:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com>
Message-ID: <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 4:56 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, May 18, 2021 at 12:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > I wonder if the kernel should do the same, or whether there are still cases
> > > where memcpy() isn't compiled optimally.  armv6/7 used to be one such case, but
> > > it was fixed in gcc 6.
> >
> > It would have to be memmove(), not memcpy() in this case, right?
>
> No, it would simply be something like
>
>   #define __get_unaligned_t(type, ptr) \
>         ({ type __val; memcpy(&__val, ptr, sizeof(type)); __val; })
>
>   #define get_unaligned(ptr) \
>         __get_unaligned_t(typeof(*(ptr)), ptr)
>
> but honestly, the likelihood that the compiler generates something
> horrible (possibly because of KASAN etc) is uncomfortably high.
>
> I'd prefer the __packed thing. We don't actually use -O3, and it's
> considered a bad idea, and the gcc bug is as such less likely than
> just  the above generating unacceptable code (we have several cases
> where "bad code generation" ends up being an actual bug, since we
> depend on inlining and depend on some code sequences not generating
> calls etc).

I think the important question is whether we know that the bug that Eric
pointed to can only happen with -O3, or whether it is something in
gcc-10.1 that got triggered by -O3 -msse on x86-64 but could equally
well get triggered on some other architecture without -O3 or
vector instructions enabled.

From the gcc fix at
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=9fa5b473b5b8e289b
it looks like this code path is entered when compiling with
-ftree-loop-vectorize, which is documented as

'-ftree-loop-vectorize'
     Perform loop vectorization on trees.  This flag is enabled by
     default at '-O3' and by '-ftree-vectorize', '-fprofile-use', and
     '-fauto-profile'.

-ftree-vectorize is set in arch/arm/lib/xor-neon.c
-O3 is set for the lz4 and zstd compression helpers and for wireguard.

To be on the safe side, we could pass -fno-tree-loop-vectorize along
with -O3 on the affected gcc versions, or use a bigger hammer
(not use -O3 at all, always set -fno-tree-loop-vectorize, ...).

        Arnd

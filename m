Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E643881B3
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 22:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351951AbhERUx5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 16:53:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241378AbhERUxy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 16:53:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E701261369;
        Tue, 18 May 2021 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621371155;
        bh=YlMi/y1ocUW8FCBYYgYe9EQZBo6QiWLJNh5f/j+pP0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OLkXv26WRHCFwP9ZdDJc/27YfDoAVhIBcnSIKC+rjNsOgVFXIkoWKfcDNwr3Fuwiu
         FMWuLnxquY14Wo7eqgnPX3svft1esnEYWXViA2TDt5Eqgm1aCMjK02QamFKdUQYqYc
         EUsApt5yKyYtIESaVa1iQ0k17SyqcsKte9kDWMhLufib+7iHzUo5s8BdzOysPGjLdG
         EO4BePVHXLG5V4yaAa5hTIc1ROTNW0zomq3qna8+C5jUnCe6h1lmAWFsnS67CWA1/a
         VT+yr7OrTgR+UbaTfdWVl3plamW5qoNPsJLYMPWOPpNJjc0cY1crMdWW/0/hfrVK+/
         CLOnbPqsFDhzw==
Received: by mail-wr1-f47.google.com with SMTP id x8so11662574wrq.9;
        Tue, 18 May 2021 13:52:35 -0700 (PDT)
X-Gm-Message-State: AOAM531Cf/Cp/t5vT61rO1SWK2xRAvjlYk7d9fxDYKLh2JunckO8hjXh
        6F/Bb1XMvpUY6VFR4eBXzDfRD0gF1/2/p0zZK1o=
X-Google-Smtp-Source: ABdhPJxil0NvKEv6VrVk2cq755gNemDrX2zp1yGDNAS6XdSetBpoojcm3BTi60gUywyeb4P0aQGylNMfelDFfmGQxqk=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr9728575wrz.105.1621371154421;
 Tue, 18 May 2021 13:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com> <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
 <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
 <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com> <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
In-Reply-To: <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 22:51:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0QMjP-i7aw_CBRHPu7ffzX0p_vYF_SRtpd_iB8HW5TqQ@mail.gmail.com>
Message-ID: <CAK8P3a0QMjP-i7aw_CBRHPu7ffzX0p_vYF_SRtpd_iB8HW5TqQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
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
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Nobuhiro Iwamatsu <iwamatsu@debian.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 6:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 18, 2021 at 5:42 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Of the other cases, that xor-neon.c case actually makes sense. For
> that file, it literally exists _only_ to get a vectorized version of
> the trivial xor_8regs loop. It's one of the (very very few) cases of
> vectorization we actually want. And in that case, we might even want
> to make things easier - and more explicit - for the compiler by making
> the xor_8regs loops use "restrict" pointers.
>
> That neon case actually wants and needs that tree-vectorization to
> DTRT. But maybe it doesn't need the actual _loop_ vectorization? The
> xor_8regs code is literally using hand-unrolled loops already, exactly
> to make it as simple as possible for the compiler (but the lack of
> "restrict" pointers means that it's not all that simple after all, and
> I assume the compiler generates conditionals for the NEON case?

Right, I think there is an ongoing debate over how to best handle this
one in clang, since that does not do any vectorization for this file
unless the pointers are marked "restrict". As far as I remember, there
are some callers that want to do the xor in place though, which
means restrict is wrong.

> lz4 is questionable - yes, upstream lh4 seems to use -O3 (good), but
> it also very much uses unaligned accesses, which is where the gcc bug
> hits. I doubt that it really needs or wants the loop vectorization.

I ran some limited speed tests with the lz4 sources that come with Ubuntu,
using gcc-10.3 on an AMD Zen1 Threadripper with 10GB of /dev/urandom
input.
This package patches the sources to use -O2 and no vectorization,
which turns out to be the fastest combination for my stupid test as well.

The results are barely above noise, but it appears that  -O2
-ftree-loop-vectorize
makes it slightly slower than just -O2, while -O3 is even slower than
that regardless of -fno-tree-loop-vectorize/-ftree-loop-vectorize.

I see that Nobuhiro Iwamatsu (Cc'd) changed the Debian lz4 package to
use -O2, but I don't see an explanation for it. I also see that the lz4 sources
force -O2 on ppc64 because -O3 causes a 30% slowdown from vectorization.
The kernel version is missing the bit that does this.

> zstd looks very similar to lz4.

> End result: at a minimum, I'd suggest using
> "-fno-tree-loop-vectorize", although somebody should check that NEON
> case.

> And I still think that using O3 for anything halfway complicated
> should be considered odd and need some strong numbers to enable.

Agreed. I think there is a fairly strong case for just using -O2 on lz4
and backport that to stable.
Searching for lz4 bugs with -O3 also finds several reports including
one that I sent myself:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65709
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69702

I see that user space zstd is built with -O3 in Debian, but it the changelog
also lists "Improved : better speed on clang and gcc -O2, thanks to Eric
Biggers", so maybe Eric has some useful ideas on whether we should
just use -O2 for the in-kernel version.

        Arnd

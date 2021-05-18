Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4603388223
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhERVcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 17:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236729AbhERVcc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 17:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90A876124C;
        Tue, 18 May 2021 21:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621373474;
        bh=d0+hSpHTltY5juyqwHwyL+G+xHCIlY0BOiHIqPiFSTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3IkDYf5WzG84qZdrk493mElmsqetEgx7UtrgyRD92P25kMU/2NnsR1jUS/IdYBj1
         KpHfDimRF4fXrFQ75vN7kAoaJxW4DtlpllTLXKjN74Jpdfzywy0nuBMQU4uNjPLvzq
         YcCKMH0JQ/3Yj+KZUonoDZ7j2+U6eZbzWHXYcHSkRoTnTwDSQ7iepxk8u6YzIuknPW
         nBT2zx6uFojpxjdgasR5X+VLrmXSALrJceUxQ1Qi8sZNBiFNgek49YbyWhFHhYoGLM
         Sr6kLztyMyuHVPK+zmrSMFT6aM6wrdbq9TagKSMB9QL/nSAfL+JlINx3IkVwMWq/xO
         KG87Ke2bRZjyQ==
Date:   Tue, 18 May 2021 14:31:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
Message-ID: <YKQyICQuyJZsl+/j@gmail.com>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com>
 <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
 <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
 <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com>
 <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
 <CAK8P3a0QMjP-i7aw_CBRHPu7ffzX0p_vYF_SRtpd_iB8HW5TqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0QMjP-i7aw_CBRHPu7ffzX0p_vYF_SRtpd_iB8HW5TqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:51:23PM +0200, Arnd Bergmann wrote:
> 
> > zstd looks very similar to lz4.
> 
> > End result: at a minimum, I'd suggest using
> > "-fno-tree-loop-vectorize", although somebody should check that NEON
> > case.
> 
> > And I still think that using O3 for anything halfway complicated
> > should be considered odd and need some strong numbers to enable.
> 
> Agreed. I think there is a fairly strong case for just using -O2 on lz4
> and backport that to stable.
> Searching for lz4 bugs with -O3 also finds several reports including
> one that I sent myself:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65709
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69702
> 
> I see that user space zstd is built with -O3 in Debian, but it the changelog
> also lists "Improved : better speed on clang and gcc -O2, thanks to Eric
> Biggers", so maybe Eric has some useful ideas on whether we should
> just use -O2 for the in-kernel version.
> 

In my opinion, -O2 is a good default even for compression code.  I generally
don't see any benefit from -O3 in compression code I've written.

That being said, -O2 is what I usually use during development.  Other people
could write code that relies on -O3 to be optimized well.

The Makefiles for lz4 and zstd use -O3 by default, which is a little concerning.
I do expect that they're still well-written enough to do well with -O2 too, but
it would require doing benchmarks to tell for sure.  (As Arnd noted, it happens
that I did do such benchmarks on zstd about 5 years ago, and I found an issue
where some functions weren't marked inline when they should be, causing them to
be inlined at -O3 but not at -O2.  That got fixed.)

- Eric

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0951D38734E
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 09:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhERH20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 03:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240235AbhERH2X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 03:28:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE75161353;
        Tue, 18 May 2021 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621322826;
        bh=tr42CgFCvzDLTaED1GLg2sfLJpu7z95Hx0uB17IraIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vFuTpSZlyekcp66+1xXP7UZO1BN2bgkvFtUPcj1zJCS149c+Zvi5hPquocBVIojB2
         Z7exeBYrhumkzjJUSvEpKFGW4FaqBqZSq7xU7M8ZbBXk0ZQ5jVfmLPFTh3D4RbZM9j
         lrUhs82y4HlTvmFkV/mBBanL9tIfDdHW4GCSJAjCwx8xBjvD/9MzWbWnE1oIuT7iX5
         gYhCI1yVOzSCg5K38ilmDg450rgYNeNMsjsLC6gOgw0amIXTpygFFnPllY+Yc4M1UR
         B2od90rmhi/bP2cvywv26nLYI1niEqFU+sMFU1it04NiboiejydzFTKGEQcZqqBYpS
         U/cWQ9vRIoLtg==
Received: by mail-wr1-f49.google.com with SMTP id a4so9011174wrr.2;
        Tue, 18 May 2021 00:27:05 -0700 (PDT)
X-Gm-Message-State: AOAM533uYGieda+TwW6tF4wz8TdYChzHQDjVJR2354nb6NmMyl4ketaJ
        8Bg2PHoUUjerVtW3qhap3NailXosaBVZsQYTYjQ=
X-Google-Smtp-Source: ABdhPJw7JTt4IAZe/TChTanjbi1ijbilhjNGsF3uk1EUqanoDrTYb4AVMmBaFkHaFRFYOWXro9yDE/Lwgvl9R0Actyg=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr5094533wrz.105.1621322824578;
 Tue, 18 May 2021 00:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com>
In-Reply-To: <YKLlyQnR+3uW4ETD@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 09:25:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
Message-ID: <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Mon, May 17, 2021 at 11:53 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, May 14, 2021 at 12:00:55PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > As found by Vineet Gupta and Linus Torvalds, gcc has somewhat unexpected
> > behavior when faced with overlapping unaligned pointers. The kernel's
> > unaligned/access-ok.h header technically invokes undefined behavior
> > that happens to usually work on the architectures using it, but if the
> > compiler optimizes code based on the assumption that undefined behavior
> > doesn't happen, it can create output that actually causes data corruption.
> >
> > A related problem was previously found on 32-bit ARMv7, where most
> > instructions can be used on unaligned data, but 64-bit ldrd/strd causes
> > an exception. The workaround was to always use the unaligned/le_struct.h
> > helper instead of unaligned/access-ok.h, in commit 1cce91dfc8f7 ("ARM:
> > 8715/1: add a private asm/unaligned.h").
> >
> > The same solution should work on all other architectures as well, so
> > remove the access-ok.h variant and use the other one unconditionally on
> > all architectures, picking either the big-endian or little-endian version.
>
> FYI, gcc 10 had a bug where it miscompiled code that uses "packed structs" to
> copy between overlapping unaligned pointers
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94994).

Thank you for pointing this out

> I'm not sure whether the kernel will run into that or not, and gcc has since
> fixed it.  But it's worth mentioning, especially since the issue mentioned in
> this commit sounds very similar (overlapping unaligned pointers), and both
> involved implementations of DEFLATE decompression.

I tried reproducing this on the kernel deflate code with the kernel.org gcc-10.1
and gcc-10.3 crosstool versions but couldn't quite get there with Vineet's
preprocessed source https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363

Trying with both the original get_unaligned() version in there and the
packed-struct
variant, I get the same output from gcc-10.1 and gcc-10.3 when I compile those
myself for arc hs4x , but it's rather different from the output that Vineet got
and I don't know how to spot whether the problem exists in any of those
versions.

> Anyway, partly due to the above, in userspace I now only use memcpy() to
> implement {get,put}_unaligned_*, since these days it seems to be compiled
> optimally and have the least amount of problems.
>
> I wonder if the kernel should do the same, or whether there are still cases
> where memcpy() isn't compiled optimally.  armv6/7 used to be one such case, but
> it was fixed in gcc 6.

It would have to be memmove(), not memcpy() in this case, right?
My feeling is that if gcc-4.9 and gcc-5 produce correct but slightly slower
code, we can live with that, unlike the possibility of gcc-10.{1,2} producing
incorrect code.

Since the new asm/unaligned.h has a single implementation across all
architectures, we could probably fall back to a memmove based version for
the compilers affected by the 94994 bug,  but I'd first need to have a better
way to test regarding whether given combination of asm/unaligned.h and
compiler version runs into this bug.

I have checked your reproducer and confirmed that it does affect x86_64
gcc-10.1 -O3 with my proposed version of asm-generic/unaligned.h, but
does not trigger on any other version (4.9 though 9.3, 10.3 or 11.1), and not
on -O2 or "-O3 -mno-sse" builds or on arm64, but that doesn't necessarily
mean it's safe on these.

        Arnd

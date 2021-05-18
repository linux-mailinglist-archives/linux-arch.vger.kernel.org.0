Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6266387F63
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhERSRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 14:17:43 -0400
Received: from mail.zx2c4.com ([104.131.123.232]:58458 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhERSRl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 14:17:41 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 14:17:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1621361380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rS8izsTLYXgTg5EMvpq46Wwtz/UgRyB75Drw18GbEc=;
        b=ordstdKxuroSvOenGkA5+S0n5Eaelw4XVAjEk8UkZ+3isrXKa/wmD2IPj5r0Kfvq1zfUvP
        CY+6i6WC3N7rlrm8aZt38e2edfNAMTLd+AO8SdHBhlEwi2KfGNHs1D7pQQWn5EZk5/Ft6s
        3IM/CNVZLwMM7ldWaZFwTTdsthAFBJk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dd3e8623 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 18 May 2021 18:09:40 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id g38so14466582ybi.12;
        Tue, 18 May 2021 11:09:40 -0700 (PDT)
X-Gm-Message-State: AOAM533Fu+hAseTLmikalDAeO39oFaAUX/oBSRZs40DjskHEVMYuQuNd
        E+jEl+sU9jL/f36vhSipVszbjC+cFV2t6fZ0QrM=
X-Google-Smtp-Source: ABdhPJzjL1VkURyiOt9hWVcfIhsJ4Fpd+evfXoJrwAsTV/P9d+CfD5cJgWw4InGE4VmuxwkJA2Pvdq6MOW/JGmXtt8w=
X-Received: by 2002:a25:be09:: with SMTP id h9mr9533216ybk.239.1621361379012;
 Tue, 18 May 2021 11:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <20210514100106.3404011-8-arnd@kernel.org>
 <YKLlyQnR+3uW4ETD@gmail.com> <CAK8P3a0iqe5V6uvaW+Eo0qiwzvyUVavVEfZGwXh4s8ad+0RdCg@mail.gmail.com>
 <CAHk-=wjjo+F8HVkq3eLg+=7hjZPF5mkA4JbgAU8FGE_oAw2MEg@mail.gmail.com>
 <CAK8P3a3hbts4k+rrfnE8Z78ezCaME0UVgwqkdLW5NOps2YHUQQ@mail.gmail.com> <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
In-Reply-To: <CAHk-=wjuoGyxDhAF8SsrTkN0-YfCx7E6jUN3ikC_tn2AKWTTsA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 May 2021 20:09:27 +0200
X-Gmail-Original-Message-ID: <CAHmME9otB5Wwxp7H8bR_i2uH2esEMvoBMC8uEXBMH9p0q1s6Bw@mail.gmail.com>
Message-ID: <CAHmME9otB5Wwxp7H8bR_i2uH2esEMvoBMC8uEXBMH9p0q1s6Bw@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
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
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Tue, May 18, 2021 at 6:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I'm actually surprised wireguard would use -O3. Yes, performance is
> important. But for wireguard, correctness is certainly important too.
> Maybe Jason isn't aware of just how bad gcc -O3 has historically been?
> Jason? How big of a deal is that -O3 for wireguard wrt the normal -O2?
> There are known buggy gcc versions that aren't ancient.

My impression has always been that O3 might sometimes generate slower
code, but not that it generates buggy code so commonly. Thanks for
letting me know.

I have a habit of compulsively run IDA Pro after making changes (brain
damage from too many years as a "security person" or something), to
see what the compiler did, and I've just been doing that with O3 since
the beginning of the project, so that's what I wound up optimizing
for. Or sometimes I'll work little things out in Godbolt's compiler
explorer. It's not like it matters much most of the time, but
sometimes I enjoy the golf. Anyway, I've never noticed it producing
any clearly wrong code compared to O2. But I'm obviously not testing
on all compilers or on all architectures. So if you think there's
danger lurking somewhere, it seems reasonable to change that to O2.

Comparing gcc 11's output between O2 and O3, it looks like the primary
difference is that the constant propagation is much less aggressive
with O2, and less inlining in general also means that some stores and
loads to local variables across static function calls aren't being
coalesced. A few null checks are removed too, where the compiler can
prove them away.

So while I've never seen issues with that code under O3, I don't see a
super compelling speed up anywhere either, but rather a bunch of
places that may or may not be theoretically faster or slower on some
system, maybe. I can queue up a patch for the next wireguard series I
send to Dave.

Jason

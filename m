Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC49C34652
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfFDMMe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 08:12:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42353 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfFDMMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 08:12:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so13350417qtk.9;
        Tue, 04 Jun 2019 05:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+e5fjRWyUfLgL9OYMwlIZ20PAP5dcbx1HkuQ94d/d4=;
        b=qvfwSLSFXqYIWDV00LYwR4/E5V+wKLRGbQJi02vCC00vE+IVsjHyJb2y/NFhMrFoeR
         5z2RwbpdlTWVWxF+lXDUH+WFduqXygb8v3Q01lYW67dBj/04oVKcLA+6R8SD2thHTNL1
         B1X5+cBPNFLqGBTCXj0OTTIvU2868dGWeKNA9AukUm+XyInKzPMTbOQMWKQevxQLbQI1
         l69IcCKJ6nw8mMbXAt+Ixjd7zLqbX/FN6omex7Xn3e/ecLO6D9hqHFIXqULcOr5nV2wk
         GxFvqBD8i7mY/tHE/dFI9FRx21mYPb1aStXlEMBJxJB9sIrRCbKEXe6gwjewWI+u8O8K
         thdg==
X-Gm-Message-State: APjAAAXaQJDA6FTNyTViTKYGiioRD2UZUpr1np/USUpIObkSFqBAIhAZ
        aM04+uS4pe6mGdlXmOdiCaRBrHB7KVEZtsOBfkM=
X-Google-Smtp-Source: APXvYqwSfz7cbuyCa6Bus+YKHBZiY4Bkrj2BkzX6U2Y1NapOb+JxqSpgu6ZjrsyPagQKMEJ9lTV9O3R1/mJPh6++Fnw=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr7929200qtd.7.1559650352510;
 Tue, 04 Jun 2019 05:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com> <d96667d5-e43b-d33a-fbd0-5acfb4904316@arm.com>
In-Reply-To: <d96667d5-e43b-d33a-fbd0-5acfb4904316@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jun 2019 14:12:16 +0200
Message-ID: <CAK8P3a3nxd7F5zLyD1SVarKjjKC0qvMEN8wP6R7zHY9HKdoe0w@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 4, 2019 at 2:05 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> On 31/05/2019 09:46, Arnd Bergmann wrote:
> > On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> > One open question I touched in my review is whether we want to
> > have a vdso version of clock_getres() in all architectures or not.
> > I'd prefer to leave it out because there is very little advantage to
> > it over the system call (the results don't change at runtime and
> > can easily be cached by libc if performance ever matters), and
> > it takes up a small amount of memory for the implementation.
> >
>
> I thought about it and I ended up with what proposed in this patchset mainly for
> symmetry across all the architectures since in the end they use the same common
> code.
>
> It seems also that there is some performance impact (i.e.):
>
> clock-getres-monotonic:    libc(system call): 296 nsec/call
> clock-getres-monotonic:    libc(vdso): 5 nsec/call
>
>
> I agree with you though when you say that caching it in the libc is a
> possibility to overcome the performance impact.

It's clear that the vdso version is much faster, my point was that
I could not think of any use case that cared about it being fast.

If there is a good reason for it, I also don't mind adding a
clock_getres_time64() vdso version everywhere.

> > We shouldn't just need it for consistency because all callers
> > would require implementing a fallback to the system call
> > anyway, to deal with old kernels.
> >
>
> A way to address this issue would be to use versioning, which seems supported in
> the vdso library (i.e. arch/x86/entry/vdso/vdso32/vdso32.lds.S).
>
> For example for x86 (vdso32) we would have something like:
>
> VERSION
> {
>         LINUX_5.3 (being optimistic here :) ) {
>         global:
>                 __vdso_clock_getres;
>                 __vdso_clock_gettime64;
>         };
>         LINUX_2.6 {
>         global:
>                 __vdso_clock_gettime;
>                 __vdso_gettimeofday;
>                 __vdso_time;
>         };
>
>         LINUX_2.5 {
>         global:
>                 __kernel_vsyscall;
>                 __kernel_sigreturn;
>                 __kernel_rt_sigreturn;
>         local: *;
>         };
> }
>
> What do you think? Would this be a viable solution?

I actually never understood the point of symbol versioning
in the vdso. What does that gain us? Note that there are
no conflicting symbol names between the versions, and
that nothing enforces the kernel headers to match the
symbol version used when linking.

      Arnd

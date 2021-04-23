Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7E369C22
	for <lists+linux-arch@lfdr.de>; Fri, 23 Apr 2021 23:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhDWVlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Apr 2021 17:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhDWVlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2021 17:41:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7682C061574
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 14:40:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o16so57175947ljp.3
        for <linux-arch@vger.kernel.org>; Fri, 23 Apr 2021 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJ6obPNuaoAMJc5yblq26EgDuZF/UgaCteghiSQhtwg=;
        b=tVa1BJCAn3R28pxmpQ7JX8jc/tUhsvgGVicr4x5vEnO018euGtHOpzyfguqOumzkgS
         uX0BYkshtOVAu3AMgLvm+ru8iz1PEcUA7vgvhf+XWrxdTUR3pnFxQweqTZeVU/MwKH2B
         r5VIeP3z9ptUYu6Z4WXqBh/BvTPnZXS+iND38zFIYi4451cDvqWfo4U1ZidkL2i9TVfG
         gaXjG0Y7kg7lH3NXuEzBMfgTxrJgKcLRwKkY2WrunfSEmaDHdcuxwPR6qFnV0MpSYHZo
         /LH1ZDtP4rnxW6uMahBlIrFibr6DDHG7n3edTm6S7LZdpDJJx1wSEyWDkzPtdFtLFZxW
         9e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJ6obPNuaoAMJc5yblq26EgDuZF/UgaCteghiSQhtwg=;
        b=hUB0Petg3tG+CZjQKMMVZZX0/dk0MhyatefQ4NKTey5tPV9nIoIBDpm6j9EV5JM9PR
         aTbhfWTNCHrR1kjLaC9LjplIORz164NIIg/QzTPcUqy0xh6iBsPCRaEwrMBgH+iCL99Z
         eDbxh9/IR70wm2p5zvsbFcXAKB6ksCoB+s4x+6JjS85jqbXXoAEuyt+9bkNiSkOC8Zxe
         q/dXEgwRkwy2GzpXwQoO+1Q8E336rTJ1Xdeip/ub9BK/ZRt6UaBqrTt+6zAxrTIWhXzz
         BkcmhNhvpFw3FcFOAWxIZqRd//Ap0kjTWYsHGHK7EPdvlqC+Vgsv+1h6hafSIspXy9v5
         MLXg==
X-Gm-Message-State: AOAM530uA4+p0paDQBeHvsgmsWkXYiYArtM8DyrVbgkL78buQZsCU4oc
        Bf+60IFITQ7k0Z17cBzTKR0vQoAatqsJN8CDssSnog==
X-Google-Smtp-Source: ABdhPJzDZrMV+6o9YKBR534oj8zfifIpn0sCWHZYKg9PI2bx3RKYePRtKiRRMfRnNH6qqkZZCH6UHjVYvpy6yNg2Dnw=
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr4082635ljd.341.1619214039013;
 Fri, 23 Apr 2021 14:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com>
 <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <025b01d7386f$78deed80$6a9cc880$@codeaurora.org>
In-Reply-To: <025b01d7386f$78deed80$6a9cc880$@codeaurora.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 23 Apr 2021 14:40:27 -0700
Message-ID: <CAKwvOdnyowwDnHXPyJc8-KZg9vKy8zFn7hErazVT30+sPO8TyA@mail.gmail.com>
Subject: Re: ARCH=hexagon unsupported?
To:     Brian Cain <bcain@codeaurora.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 23, 2021 at 11:35 AM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: Arnd Bergmann <arnd@kernel.org>
> > Sent: Friday, April 23, 2021 4:37 AM
> > To: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: open list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>;
> > clang-built-linux <clang-built-linux@googlegroups.com>; Brian Cain
> > <bcain@codeaurora.org>; linux-arch <linux-arch@vger.kernel.org>; Guenter
> > Roeck <linux@roeck-us.net>
> > Subject: Re: ARCH=hexagon unsupported?
> >
> > On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang Built Linux
> > <clang-built-linux@googlegroups.com> wrote:
> > >
> > > Arnd,
> > > No one can build ARCH=hexagon and
> > > https://github.com/ClangBuiltLinux/linux/issues/759 has been open for
> > > 2 years.
> > >
> > > Trying to build
> > > $ ARCH=hexagon CROSS_COMPILE=hexagon-linux-gnu make LLVM=1
> > LLVM_IAS=1
> > > -j71
> > >
> > > shows numerous issues, the latest of which commit 8320514c91bea
> > > ("hexagon: switch to ->regset_get()") has a very obvious typo which
> > > misspells the `struct` keyword and has been in the tree for almost 1
> > > year.
> >
> > Thank you for looking into it.
> >
> > > Why is arch/hexagon/ in the tree if no one can build it?
> >
> > Removing it sounds reasonable to me, it's been broken for too long, and we
> > did the same thing for unicore32 that was in the same situation where the
> > gcc port was too old to build the kernel and the clang port never quite work
> > in mainline.
> >
> > Guenter also brought up the issue a year ago, and nothing happened.
> > I see Brian still occasionally sends an Ack to a patch that gets merged through
> > another tree, but he has not send any patches or pull requests himself after
> > taking over maintainership from Richard Kuo in 2019, and the four hexagon
> > pull requests after 2014 only contained build fixes from developers that don't
> > have access to the hardware (Randy Dunlap, Viresh Kumar, Mike Frysinger
> > and me).
>
> Nick, Arnd,
>
> I can appreciate your frustration, I can see that I have let the community down here.  I would like to keep hexagon in-tree and I am committed to making the changes necessary to do so.

I'm very happy to hear that.

> I have a patch under internal review to address the cited build issues and libgcc/compiler-rt content.

We'd be first in line to help build test such a patch. Please consider
cc'ing myself and clang-built-linux@googlegroups.com when such a patch
is available externally.  Further, we have the CI ready and waiting to
add new architectures, even if it's just build testing. That would
have caught regressions like 8320514c91bea; we were down to 1 build
failure with https://github.com/ClangBuiltLinux/linux/issues/759 last
I looked which was preventing us from adding Hexagon to any CI, but we
must now dig ourselves out of a slightly deeper hole now.

Is this patch something you suspect will take quite some time to work
through internal review?

> In addition, my team has been focusing on developing QEMU system mode support that would mitigate some of the need for having hardware access.  We have landed support for userspace hexagon-linux in upstream QEMU.

That's also great to hear. QEMU is a critical part of our CI for boot
testing; if there's more info on timelines or what's involved with
booting a hexagon kernel in QEMU, we'd be very happy to know how or
when that's available.

> My team and I want to make hexagon's open source footprint larger, not smaller.  I realize that not being a good steward of the hexagon kernel has not helped, and we will do what we can to fix it.

A worthwhile and appreciated sentiment. I believe you.

Hexagon could be an interesting case for LLVM support in general for
the Linux kernel; a case where each target or driver need not
necessarily have a GCC backend to be acceptable.  But barring anyone
from being able to actually build it (let alone run it), it's not
that; it's less than that. It's dead code that bit rots further and
burdens maintainers who are maintaining something that's already
broken. I'm not sure who derives any benefit.

I think it's in everyone's best interest to see Linux support more
targets than fewer, and 2020 has been a hard year, but I'm curious how
long something has to be broken before folks say "enough." Please
let's support this properly or recognize the situation for what it is.
-- 
Thanks,
~Nick Desaulniers

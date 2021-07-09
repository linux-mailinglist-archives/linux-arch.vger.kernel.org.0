Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980503C2100
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jul 2021 10:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhGIIrs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jul 2021 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhGIIrq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2021 04:47:46 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EBC0613DD
        for <linux-arch@vger.kernel.org>; Fri,  9 Jul 2021 01:45:03 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id o8so9470966ilf.12
        for <linux-arch@vger.kernel.org>; Fri, 09 Jul 2021 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQcrFZfGoEUKQRvfZb5BdVn66QI0fqMmpjL918kSXsw=;
        b=QxfURs+1MDuCE3UfAZAiAgWcuOdHlsVu4n8PoAHbV6yxbI/BMuM5Bt8IawIhqi66kT
         ya+EIC7jQ2lcbubpmL6c7HO4CWQqkk/AuYqGxiU/qOS5IzGXf0MpbL6YJa17cfv1Hk+k
         efHwtexNZb9lL8sUtTTnEX3Hh14xAhFDmvj/jmjnkA31x54ea0ooN/KlPAXH8FUWeaMB
         O8QxywwcOnHDjL53oYZBL55akMefY7KEeKlHq6xqK1P9j3ElVyN6b7zdJRcVspm7sZk2
         D6Od9nckCg2XzCuRIkEfPVLElnMNv9PWbdBmonNPz9fzIfG9qUPEd/p4YHsHWer6ZjQc
         REFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQcrFZfGoEUKQRvfZb5BdVn66QI0fqMmpjL918kSXsw=;
        b=MudFXJhsdJxsn80tY+vu8UmcEdr5M4hOt8nn3nfNVFnspnVeDURx33bwcvMzWE4vsX
         6iK7JsSIsIpVePu5PnuJ5jNduawVKb5QozWzAUfwGo+oJ0M6FfY9qj81oEeYjDi931VI
         i3swa8oCDFEkfbARWf8914o2y51K86ItLw3FqyOTaFypJwi4PrwbPIjvTKc2oBualRVc
         YruRwDgu3xtyCivsf4p5abnOllJhtx9upMi22Y2453MIxUbyjazxCl81u0qL6BUbAiPt
         8f8R9/FJAMYRswEz9zK3zFBaO9VrAWsmkNwPEzP3Yw31Y9S6XShVKu8xWLyw9KxIWShy
         J/LA==
X-Gm-Message-State: AOAM530YWpROF/HM+z0G2o00hJX5MtiidiOUHDLkAlpGUtHNs026lo47
        vkKOgRnn06bf5DYDrN7shFsWbb/neDiEbfnLy5EnrN+QuTfE92xj
X-Google-Smtp-Source: ABdhPJzSQFhUkGkDP1dkZqtL5iXKL9TLgQIPIsuk5bl+TIT/zxXoyLXELP3KzZhPf6rhPLZMhY/6V7JeUx+RLaY394o=
X-Received: by 2002:a92:6509:: with SMTP id z9mr25976829ilb.184.1625820303248;
 Fri, 09 Jul 2021 01:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
 <CAAhV-H6q8Cz0bGBZo6dUESwk1wfa75TL6YH+YS1kQe9UzHB=Tg@mail.gmail.com> <CAK8P3a3E2a1PQ5+pD3sDs4vbQiwx3Z9vAQOG7akd645B86AYHg@mail.gmail.com>
In-Reply-To: <CAK8P3a3E2a1PQ5+pD3sDs4vbQiwx3Z9vAQOG7akd645B86AYHg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 9 Jul 2021 16:44:51 +0800
Message-ID: <CAAhV-H5RKGPz2OJbb58vJ8GBMjZnEnnFEfbFRKqmmP1eJ+GHYQ@mail.gmail.com>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Wed, Jul 7, 2021 at 2:44 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 7, 2021 at 6:24 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> > > > new file mode 100644
> > > > index 000000000000..6c194d740ed0
> > > > --- /dev/null
> > > > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > > > @@ -0,0 +1,7 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > +#define __ARCH_WANT_NEW_STAT
> > >
> > > Why do you need newstat? I think now that we have statx and the libc
> > > emulation code on top of it, there is probably no need to support both
> > > on the kernel side.
> > >
> > > > +#define __ARCH_WANT_SYS_CLONE
> > > > +#define __ARCH_WANT_SYS_CLONE3
> > >
> > > Similarly, if you have clone3, you should not need clone.
> > >
> > > > +#define __ARCH_WANT_SET_GET_RLIMIT
> > >
> > > And here for prlimit64
> >
> > Is newstat()/clone()/setrlimit() completely unacceptable in a new
> > arch? If not, I want to keep it here for compatibility, because there
> > are some existing distros.
>
> I'd say they should go. None of these are normally called directly by
> applications, so if you just update the C library to redirect the user
> level interfaces to the new system calls, I expect no major problems
> here as long as you update libc along with the kernel in the existing
> distros.
> Any application using seccomp to allow only the old system calls
> may need a small update, but it would need that anyway to work
> with future libc implementations.
>
> Generally speaking there should be no expectation that the
> system call interface is stable until the port is upstream. Note that
> you will face a similar problem with the libc port, which may also
> change its interface from what you are using internally.
I found that the latest glibc is not ready for clone3, the last
patchset [1] still breaks something, so I think we should keep clone.
For newstat, I found that the latest glibc only use statx for 32bit
kernel, while 64bit kernel still use newstat.

So, it seems that we can only remove __ARCH_WANT_SET_GET_RLIMIT.

[1] https://patchwork.sourceware.org/project/glibc/patch/20210601145516.3553627-2-hjl.tools@gmail.com/

Huacai
>
>        Arnd

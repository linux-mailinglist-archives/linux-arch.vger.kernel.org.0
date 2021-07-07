Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2153BE358
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhGGHDW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 03:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGHDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 03:03:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA44C061574
        for <linux-arch@vger.kernel.org>; Wed,  7 Jul 2021 00:00:42 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id o8so1286507ilf.12
        for <linux-arch@vger.kernel.org>; Wed, 07 Jul 2021 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mpTLJzPwrt1pWZbQLdLXK5Oe5hgFV4L0J4qUsVqnFI=;
        b=NievUoylqlG5lTwOQdpCPXre00MIHKNGrUsMgvaKaiXSrJexiVaBKBHlMdb6HDHIoN
         UXBib/jcZYOTpooquiakNjWtAdSDUMie2ETRvqlSOJ7cTjX5LuEIQ6gz2GEWhxCcZUfb
         CXDcF68Vdgr43UoMpCSQJ0NiBcl58In4ehICx+aFeRRM8iWdP61Nb/Z3PTJhKenJtjrc
         hKbXkgOor3FfzrBsDDabJuK7YP7UhWEcJriglsT/4L3+mAyPEXSxicAvSd0MkFmlFEl/
         xVr9WGR3r1DeRszsY9fTKZZEXipEPGQR48/SkdiNvfVwC9xWtvbM9A3Q3eRvKtJF/uiS
         B+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mpTLJzPwrt1pWZbQLdLXK5Oe5hgFV4L0J4qUsVqnFI=;
        b=UeFJ77Jq0k9RVearZM5OYdoODKScNLf+RrVI6/XuwJnQqKlyp6q78XxC/yh8dX/orn
         G4GgY1/SrejuCh7HTdS1bHEpf/ta5Y1WQ1mOBV8GifWbuPd5SKmkifEg72AB/Udl/5cz
         xdUUekedGwXLZ7LqKtamOgVtOJUfHVAwuAo5KsbqIN8mvK2QmLrgc8P+ZVcQSDKwYHbD
         NzG1GR/iUhrqLDze7vmQ5B7TcZLcesk3+hK6mWs6og8LOW+jzwI+A6hhAMaM0LT1o33f
         h8239DsgM86CI4ZOLp9h8e00Nq+SpsttI+dW3dlITRhobHGF9UYap1giTHXWbJg/QZe8
         0Qwg==
X-Gm-Message-State: AOAM533mXKRWUCMs8wrVk+z/WZUCeuftnC9WqBSXw5nFCbVbs53VvIQw
        S3jCAXHjOhSOHr+HqrmCHCSmnro5b39tee8VSes=
X-Google-Smtp-Source: ABdhPJxC4gJdMgnMrUR7LvINYtg5PJq+geSPmUVbY2xAeJFcKbFnM2BnaVyhtTRo4byxHEzEQDoKLSfilrMQ2qAdO2w=
X-Received: by 2002:a92:a00e:: with SMTP id e14mr17350998ili.126.1625641241504;
 Wed, 07 Jul 2021 00:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
 <CAAhV-H6q8Cz0bGBZo6dUESwk1wfa75TL6YH+YS1kQe9UzHB=Tg@mail.gmail.com> <CAK8P3a3E2a1PQ5+pD3sDs4vbQiwx3Z9vAQOG7akd645B86AYHg@mail.gmail.com>
In-Reply-To: <CAK8P3a3E2a1PQ5+pD3sDs4vbQiwx3Z9vAQOG7akd645B86AYHg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 7 Jul 2021 15:00:29 +0800
Message-ID: <CAAhV-H5Q3iQ38-WPsxk-XPitNJfGje9=O07g4KQycPJ0ikB6Lw@mail.gmail.com>
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
OK, I know, thanks.

Huacai
>
>        Arnd

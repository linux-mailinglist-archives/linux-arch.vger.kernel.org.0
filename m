Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A68312E8D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhBHKGi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 05:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhBHKAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2021 05:00:09 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA1C061356
        for <linux-arch@vger.kernel.org>; Mon,  8 Feb 2021 01:52:06 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id g84so1199492oib.0
        for <linux-arch@vger.kernel.org>; Mon, 08 Feb 2021 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpKxIqmOlqMl7mzttLPN+VwSDt9L8MOcCkjs1vmLiI8=;
        b=KLWyl72HIYL2VlsjKIxcvR6IOlc+aubrFGsX9wWWy0WDBsiZ1VMg+20IlOl94PPdZ+
         o6+qaT9T4WQgu1ZEiu6krhGInALOWGoXbbOEk/uKrqK7ZJaTBQqcT1A8vNukNFBFHJ9o
         +tNbz7F66EdYEBgQSmE9tsKGQ8sFKS27AgtGtgXcUoebezGouiSRDqzl+aTD3P5Vxex3
         MmxHqPipuBolGjxf2D/c1AVNuUOkjEG9htTpHYoDZ8h50cvmSHFy0RW92aBhxNxsYXCH
         WK57NVHpMxgUvF+ur160GTFQwvC1V50krRh9qIHxrL0K9toDKyns8kQwr2peqjxfLqFl
         SO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpKxIqmOlqMl7mzttLPN+VwSDt9L8MOcCkjs1vmLiI8=;
        b=o3XgH1F1pa/O+QCYmG1hrAEl9gAhL0HUoK9Ty/uFUpvReOhIv91Pvf5+GWBGK4hB3v
         MHtXGtsQH1/TfE9Osy1KHr0F59gfeO/Drtd4NkeroNikiwJ26mDtdSrVxxfXrZa8U4sN
         HpdmikFwwM4JwS7nNEKFz4qg1Wm9UNb/RJMillPWyS9j6ZSFwEZwv7Gjb9cVLTqQQBdq
         JxltqodOSpeSDHi9SqBOCnokgjT/JrX3We5BsTco4dBNMDVTkUDjVhgS3fe2GtEutVbc
         nAwaj/9e+h3ODJwsGppolTrFtq9BGo6s5hAr5PY4DZ8jNyutJfVPwSjoH+CQ+CG9oGaS
         UfrA==
X-Gm-Message-State: AOAM532MxZmeMrmK85h3Pyui084QwHIqqGLO/n6e1R861pM49et7jlqD
        Rqmyxc7dJfGqlFfTCWlALWY/eUipj1efCaqHn0AaRg==
X-Google-Smtp-Source: ABdhPJzqX48E1X2LlNnRaBS/1DHj27pVaPPRP4oqqLOwu8qC/WvaUZEVaueH0eqpwRGMp6njk+uirSLd+7a9aQtkLQQ=
X-Received: by 2002:aca:c505:: with SMTP id v5mr30902oif.172.1612777925613;
 Mon, 08 Feb 2021 01:52:05 -0800 (PST)
MIME-Version: 1.0
References: <YCB4Sgk5g5B2Nu09@arch-chirva.localdomain> <YCCFGc97d2U5yUS7@arch-chirva.localdomain>
 <YCCIgMHkzh/xT4ex@arch-chirva.localdomain>
In-Reply-To: <YCCIgMHkzh/xT4ex@arch-chirva.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Mon, 8 Feb 2021 10:51:54 +0100
Message-ID: <CANpmjNO9B8KivLB8OnOFzK+M7wf=BGayfJy2+Dr2r2obk_s-fw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFBST0JMRU06IDUuMTEuMC1yYzcgZmFpbHMgdG8gY29tcGlsZSB3aXRoIGVycm9yOg==?=
        =?UTF-8?B?IOKAmC1taW5kaXJlY3QtYnJhbmNo4oCZIGFuZCDigJgtZmNmLXByb3RlY3Rpb27igJkgYXJlIG5vdCBj?=
        =?UTF-8?B?b21wYXRpYmxl?=
To:     Stuart Little <achirvasub@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, nborisov@suse.com,
        Borislav Petkov <bp@suse.de>, seth.forshee@canonical.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 8 Feb 2021 at 01:40, Stuart Little <achirvasub@gmail.com> wrote:
>
> And for good measure: reverting that commit
>
> 20bf2b378729c4a0366a53e2018a0b70ace94bcd
>
> flagged by the bisect right on top of the current tree compiles fine.
>
> On Sun, Feb 07, 2021 at 07:26:01PM -0500, Stuart Little wrote:
> > The result of the bisect on the issue reported in the previous message:
> >
> > --- cut ---
> >
> > 20bf2b378729c4a0366a53e2018a0b70ace94bcd is the first bad commit
> > commit 20bf2b378729c4a0366a53e2018a0b70ace94bcd
> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > Date:   Thu Jan 28 15:52:19 2021 -0600
> >
> >     x86/build: Disable CET instrumentation in the kernel
> >
> >     With retpolines disabled, some configurations of GCC, and specifica=
lly
> >     the GCC versions 9 and 10 in Ubuntu will add Intel CET instrumentat=
ion
> >     to the kernel by default. That breaks certain tracing scenarios by
> >     adding a superfluous ENDBR64 instruction before the fentry call, fo=
r
> >     functions which can be called indirectly.
> >
> >     CET instrumentation isn't currently necessary in the kernel, as CET=
 is
> >     only supported in user space. Disable it unconditionally and move i=
t
> >     into the x86's Makefile as CET/CFI... enablement should be a per-ar=
ch
> >     decision anyway.
> >
> >      [ bp: Massage and extend commit message. ]
> >
> >     Fixes: 29be86d7f9cb ("kbuild: add -fcf-protection=3Dnone when using=
 retpoline flags")
> >     Reported-by: Nikolay Borisov <nborisov@suse.com>
> >     Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >     Signed-off-by: Borislav Petkov <bp@suse.de>
> >     Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> >     Tested-by: Nikolay Borisov <nborisov@suse.com>
> >     Cc: <stable@vger.kernel.org>
> >     Cc: Seth Forshee <seth.forshee@canonical.com>
> >     Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >     Link: https://lkml.kernel.org/r/20210128215219.6kct3h2eiustncws@tre=
ble
> >
> >  Makefile          | 6 ------
> >  arch/x86/Makefile | 3 +++
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > --- end ---
> >
> > On Sun, Feb 07, 2021 at 06:31:22PM -0500, Stuart Little wrote:
> > > I am trying to compile on an x86_64 host for a 32-bit system; my conf=
ig is at
> > >
> > > https://termbin.com/v8jl
> > >
> > > I am getting numerous errors of the form
> > >
> > > ./include/linux/kasan-checks.h:17:1: error: =E2=80=98-mindirect-branc=
h=E2=80=99 and =E2=80=98-fcf-protection=E2=80=99 are not compatible

This is an empty static inline function...

> > > and
> > >
> > > ./include/linux/kcsan-checks.h:143:6: error: =E2=80=98-mindirect-bran=
ch=E2=80=99 and =E2=80=98-fcf-protection=E2=80=99 are not compatible

... and so is this. I think these have very little to do with the
problem that you reported. My guess is they show up because these are
included very early.

> > > and
> > >
> > > ./arch/x86/include/asm/arch_hweight.h:16:1: error: =E2=80=98-mindirec=
t-branch=E2=80=99 and =E2=80=98-fcf-protection=E2=80=99 are not compatible
> > >
> > > (those include files indicated whom I should add to this list; apolog=
ies if this reaches you in error).
> > >
> > > The full log of the build is at
> > >
> > > https://termbin.com/wbgs

The commonality between all these errors is that they originate from
compiling arch/x86/entry/vdso/vdso32/vclock_gettime.c.

Is the build system adding special flags for vdso? In which case, it's
probably just GCC complaining about every function definition (static
inline or otherwise) for that TU if (for whatever reason) it's
delaying the flag compatibility check until it inspects function
attributes.

And indeed, I can see:

  RETPOLINE_VDSO_CFLAGS_GCC :=3D -mindirect-branch=3Dthunk-inline
-mindirect-branch-register

And taking any test source with even an empty function definition:

  > gcc -mindirect-branch=3Dthunk-inline -fcf-protection test.c
  > test.c: In function =E2=80=98main=E2=80=99:
  > test.c:6:1: error: =E2=80=98-mindirect-branch=E2=80=99 and =E2=80=98-fc=
f-protection=E2=80=99 are
not compatible

> > > 5.11.0-rc6 built fine last week on this same setup.

Thanks,
-- Marco

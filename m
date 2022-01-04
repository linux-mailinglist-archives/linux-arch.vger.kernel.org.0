Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7D4846F3
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 18:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiADR0E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 12:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiADR0D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 12:26:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33505C061784
        for <linux-arch@vger.kernel.org>; Tue,  4 Jan 2022 09:26:03 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u13so83085103lff.12
        for <linux-arch@vger.kernel.org>; Tue, 04 Jan 2022 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WI7lB1h5wzR1I5amS3/J/XjMPBvz/P5sBCVcxmVEb6g=;
        b=OMiXrp20A1P+UWBlFyhfOkxCnq+sBHc6yZlhZnVZ7OVEOwVMMYK1ivGWdCIWQTWRip
         SPK2nhJjpXO5iVLF37PSpqBhEHrvkSfDM2pxQvdU/WNrLW365k+hFye1+D6eU/c/IXXo
         LOdMAILQQRfWDCR08GV8mnK7FmQL9geS33pEfWPecFozzwtNBooirRkMKCSaaGHOl51m
         riB0Eka+KFABS3v+nmXQHX+/P9eIJFTpfOZdTs304aLI1ivvjExWMVIhc235t9SdQxin
         PVgOih4W3xqoqysFob1zl+u7bsCqAaI1G3qswq6r/InvYOBigCwA2COhE+TUwaojfOAq
         S9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WI7lB1h5wzR1I5amS3/J/XjMPBvz/P5sBCVcxmVEb6g=;
        b=MR525PTDa70QLRPoAvxDSIP2HAA5S73xkyzCgyW9+/q6IiyzA4LLjH4EmObBxn/un2
         dql4YRyGSVYiopOxntoafBAdco2Ii0kzZIfxqJZ7Yv0nyYQ0d/72XFRhRaBWkwTRRMsL
         STDQSK8Snou5prTIbTNR79hcvmRH6Zqhe5AVaplvo6S3ib4hxDuNhq4gOcH1FAS+HU9C
         XSwL7+UEBIdrqjJ2J/Gb5CgrIJiA/QQs4BefQYLrzjQpiwKXyx12zxwH+7R6JcKaVqbN
         eKtsG89TZlFMkKLalZKuLRT9UHZWmzqr0wi/0QcCj1rDyrsUrw0qnbEV4PG3IND9bmkr
         9QfQ==
X-Gm-Message-State: AOAM532ZAC3W8cFIyPXir+F1VjFe2uMAaRw2yGel8/oJTxSUw1KFWiFu
        SaPNTf3wo28fPsV2PfCFvnvAI9ythrrbUkqFrVDJnA==
X-Google-Smtp-Source: ABdhPJw8CT9FUQyCSpw151cYtBBTzAW6DKyeI4S1JIsi2Z3jQSPb/+4uOHm3HO73slTwxuU1Z1CZppFcgoHYgkIhIRk=
X-Received: by 2002:a05:6512:32c5:: with SMTP id f5mr41463073lfg.550.1641317160619;
 Tue, 04 Jan 2022 09:26:00 -0800 (PST)
MIME-Version: 1.0
References: <YdIfz+LMewetSaEB@gmail.com> <YdM4Z5a+SWV53yol@archlinux-ax161> <YdQlwnDs2N9a5Reh@gmail.com>
In-Reply-To: <YdQlwnDs2N9a5Reh@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 4 Jan 2022 09:25:48 -0800
Message-ID: <CAKwvOdmCgBKiikP2Ja4PfJmVEnzNPGYe19MNd++a5D-asCBG2w@mail.gmail.com>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree -v1:
 Eliminate the Linux kernel's "Dependency Hell"
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev,
        ashimida <ashimida@linux.alibaba.com>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 4, 2022 at 2:47 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Nathan Chancellor <nathan@kernel.org> wrote:
>
> > Hi Ingo,
> >
> > On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> > I took the series for a spin with clang and GCC on arm64 and x86_64 and
> > I found a few warnings/errors.
>
> Thank you!
>
> > 1. Position of certain attributes
> >
> > In some commits, you move the cacheline_aligned attributes from after
> > the closing brace on structures to before the struct keyword, which
> > causes clang to warn (and error with CONFIG_WERROR):
> >
> > In file included from arch/arm64/kernel/asm-offsets.c:9:
> > In file included from arch/arm64/kernel/../../../kernel/sched/per_task_=
area_struct.h:33:
> > In file included from ./include/linux/perf_event_api.h:17:
> > In file included from ./include/linux/perf_event_types.h:41:
> > In file included from ./include/linux/ftrace.h:18:
> > In file included from ./arch/arm64/include/asm/ftrace.h:53:
> > In file included from ./include/linux/compat.h:11:
> > ./include/linux/fs_types.h:997:1: error: attribute '__aligned__' is ign=
ored, place it after "struct" to apply attribute to type declaration [-Werr=
or,-Wignored-attributes]
> > ____cacheline_aligned
> > ^
> > ./include/linux/cache.h:41:46: note: expanded from macro '____cacheline=
_aligned'
> > #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTE=
S)))
>
> Yeah, so this is a *really* stupid warning from Clang.
>
> Putting the attribute after 'struct' risks the hard to track down bugs wh=
en
> a <linux/cache.h> inclusion is missing, which scenario I pointed out in
> this commit:
>
>     headers/deps: dcache: Move the ____cacheline_aligned attribute to the=
 head of the definition
>
>     When changing <linux/dcache.h> I removed the <linux/spinlock_api.h> h=
eader,
>     which caused a couple of hundred of mysterious, somewhat obscure link=
 time errors:
>
>       ld: net/sctp/tsnmap.o:(.bss+0x0): multiple definition of `____cache=
line_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>       ld: net/sctp/tsnmap.o:(.bss+0x40): multiple definition of `____cach=
eline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>       ld: net/sctp/debug.o:(.bss+0x0): multiple definition of `____cachel=
ine_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>       ld: net/sctp/debug.o:(.bss+0x40): multiple definition of `____cache=
line_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>
>     After a bit of head-scratching, what happened is that 'struct dentry_=
operations'
>     has the ____cacheline_aligned attribute at the tail of the type defin=
ition -
>     which turned into a local variable definition when <linux/cache.h> wa=
s not
>     included - which <linux/spinlock_api.h> includes into <linux/dcache.h=
> indirectly.
>
>     There were no compile time errors, only link time errors.
>
>     Move the attribute to the head of the definition, in which case
>     a missing <linux/cache.h> inclusion creates an immediate build failur=
e:
>
>       In file included from ./include/linux/fs.h:9,
>                        from ./include/linux/fsverity.h:14,
>                        from fs/verity/fsverity_private.h:18,
>                        from fs/verity/read_metadata.c:8:
>       ./include/linux/dcache.h:132:22: error: expected =E2=80=98;=E2=80=
=99 before =E2=80=98struct=E2=80=99
>         132 | ____cacheline_aligned
>             |                      ^
>             |                      ;
>         133 | struct dentry_operations {
>             | ~~~~~~
>
>     No change in functionality.
>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
> Can this Clang warning be disabled?

Clang is warning that the attribute will be ignored because of that
positioning. If you disable the warning, code will probably stop
working as intended.  This warning has at least been helping us make
the kernel coding style more consistent.

This made me think of d5b421fe02827 ("docs: Explain the desired
position of function attributes"), where we adding some text to
Documentation/process/coding-style.rst about the positioning of
__attribute__'s in function signatures, but I guess this case is data.
We probably should add something to the coding style about attributes
on data, too.

The C standards body is also working on standardizing attributes; at
the least I expect some of these things to be ironed out more soon.

>
> > 2. Error with CONFIG_SHADOW_CALL_STACK
>
> So this feature depends on Clang:
>
>  # Supported by clang >=3D 7.0
>  config CC_HAVE_SHADOW_CALL_STACK
>          def_bool $(cc-option, -fsanitize=3Dshadow-call-stack -ffixed-x18=
)
>
> No way to activate it under my GCC cross-build toolchain, right?
>
> But ... I hacked the build mode on with GCC using this patch:

Dan Li is working on a GCC patch. If you're up for building GCC from source=
:
https://gcc.gnu.org/pipermail/gcc-patches/2021-December/586204.html

--

This is a really cool series Ingo.  I'm sure Arnd has seen it by now,
but Arnd has been thinking about this area a lot, too.  I haven't but
I have played with running "include what you use" on the kernel
sources; Kconfig being the biggest impediment to that approach.

To me, I'm most nervous about "backsliding;" let's say this work
lands, at some point probably years in the future, I assume without
any form of automation that we might find ourselves at a similar point
of header dependencies getting all tangled again.

What are your thoughts on where/how/what we could automate to try to
help developers in the future keep their header dependencies simpler?
(Sorry if this was already answered in the cover letter)

It would be really useful if you were planning a talk at something
like plumbers how you go about making these changes.  I really hope
once others understand your workflow that we might help with some form
of automation.  Nice work!
--
Thanks,
~Nick Desaulniers

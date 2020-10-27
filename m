Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C30929C9F9
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 21:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1826052AbgJ0UPb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 16:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505120AbgJ0UPb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 16:15:31 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8EC222D9;
        Tue, 27 Oct 2020 20:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603829729;
        bh=k99urQCr5bqqGQYEIYyO+VH8YrhpcEKq73v6441UE7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IWaX040EfBp7TebZkcfbUksBN8XtVdYgnEVHmZaYAY02WQ2XsCLrDZSnMY8NTwLfw
         29Xj2XIoDU5At1lafmVHCvyXrNl5TJ8neeDVQZCTKdJ3shSzeNCaRpQscn7uS4g8a/
         icj/n6/unORecRU2RUNh1YeVkNIyT1p6hQerClQY=
Received: by mail-ot1-f52.google.com with SMTP id h62so2283860oth.9;
        Tue, 27 Oct 2020 13:15:29 -0700 (PDT)
X-Gm-Message-State: AOAM532Za5nymo6Lt8EjiNntzXmEKH1pn7eF1kbC0bCgA55rk5EfuA0s
        vu8Rl/9gZMV5J/DFfuMlj5khXpqUAKyrC1Q+psg=
X-Google-Smtp-Source: ABdhPJz7OiekGW/gRYpC7hC2i5PrYMFhEwtbtysJSgICs5C8iOPhqCdhUlX41my68uZsg6m0UncvoboW4ZUHXG8A8cs=
X-Received: by 2002:a9d:2daa:: with SMTP id g39mr2896564otb.77.1603829728869;
 Tue, 27 Oct 2020 13:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com> <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
In-Reply-To: <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Oct 2020 21:15:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
Message-ID: <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel-toolchains@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Oct 2020 at 21:12, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Oct 27, 2020 at 12:25 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Nick,
> >
> > CC Josh
> >
> > On Mon, Oct 26, 2020 at 6:49 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > > > > placement"), which is another red herring.
> > > > > > >
> > > > > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > > > > causing the warning.
> > >
> > > When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> > > missing from someone's KBUILD_CFLAGS.
> > > But I don't see anything curious in kernel/bpf/Makefile, unless
> > > cc-disable-warning is somehow broken.
> >
> > I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
> > with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).
> >
> > Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
> > is generated.  Removing the __no_fgcse tag fixes that.
>
> That's weird.  I feel pretty strongly that unless we're working around
> a well understood compiler bug with a comment that links to a
> submitted bug report, turning off rando compiler optimizations is a
> terrible hack for which one must proceed straight to jail; do not pass
> go; do not collect $200.  But maybe I'd feel differently for this case
> given the context of the change that added it.  (Ard mentions
> retpolines+orc+objtool; can someone share the relevant SHA if you have
> it handy so I don't have to go digging?)

commit 3193c0836f203a91bef96d88c64cccf0be090d9c
Author: Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Wed Jul 17 20:36:45 2019 -0500

    bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()

has

Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")

and mentions objtool and CONFIG_RETPOLINE.

>  (I feel the same about there
> being an empty asm(); statement in the definition of asm_volatile_goto
> for compiler-gcc.h).  Might be time to "fix the compiler."
>
> (It sounds like Arvind is both in agreement with my sentiment, and has
> the root cause).
>

I agree that the __no_fgcse hack is terrible. Does Clang support the
following pragmas?

#pragma GCC push_options
#pragma GCC optimize ("-fno-gcse")
#pragma GCC pop_options

?

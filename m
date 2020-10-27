Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8471029C903
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 20:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830098AbgJ0TdO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 15:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1830096AbgJ0TdO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 15:33:14 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C572225E;
        Tue, 27 Oct 2020 19:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603827193;
        bh=cCb5ESWzvqpee6cBNzRlKMh6WeU754Njt36C7Aon99s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZLHgLc3Iue0tuLATFozFOGfw9hlJ0tAXtjAg7MF3L+yYfGPdQW+4h9/f8c4vD2dx2
         jZ1lgcNiNpgGeeL89MxyFD9LCu3+9gEdTR+kYVgChq4ibYKtbg1YmFvud40f1f/3yT
         S0/I9M+EAAioEch6DOeWJePWxeFXgGmuCEApSIxY=
Received: by mail-ot1-f54.google.com with SMTP id f37so2171299otf.12;
        Tue, 27 Oct 2020 12:33:12 -0700 (PDT)
X-Gm-Message-State: AOAM531L44NT5Ik5VB3d3k2lTz1rxLeJkV6CbgfLCD+3mge9Qzh1J7hl
        s1BUIPcir/QC4BiTg4zPAXHRFFrBFu8w62RIkX0=
X-Google-Smtp-Source: ABdhPJyO9dPFPb+DrY1jmAF00Ds1IAUz8xorYqPzgbAbP0o7lDRtFnbxP3NF/zJSEYQXMObYwBvuX2dosCc8hqrh0M4=
X-Received: by 2002:a9d:2daa:: with SMTP id g39mr2760143otb.77.1603827192042;
 Tue, 27 Oct 2020 12:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com> <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
In-Reply-To: <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Oct 2020 20:33:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEw+6Srqd5w9oxpik3VUbehapx_TcHLDCbmHZBSdY768Q@mail.gmail.com>
Message-ID: <CAMj1kXEw+6Srqd5w9oxpik3VUbehapx_TcHLDCbmHZBSdY768Q@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Oct 2020 at 20:25, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Nick,
>
> CC Josh
>
> On Mon, Oct 26, 2020 at 6:49 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Fri, Aug 21, 2020 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
> > > > > > > > In preparation for warning on orphan sections, discard
> > > > > > > > unwanted non-zero-sized generated sections, and enforce other
> > > > > > > > expected-to-be-zero-sized sections (since discarding them might hide
> > > > > > > > problems with them suddenly gaining unexpected entries).
> > > > > > > >
> > > > > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > > >
> > > > > > > This is now commit be2881824ae9eb92 ("arm64/build: Assert for unwanted
> > > > > > > sections") in v5.10-rc1, and is causing the following error with
> > > > > > > renesas_defconfig[1]:
> > > > > > >
> > > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > > > > > > `kernel/bpf/core.o' being placed in section `.eh_frame'
> > > > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > > > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > > > > > >
> > > > > > > I cannot reproduce this with the standard arm64 defconfig.
> > > > > > >
> > > > > > > I bisected the error to the aforementioned commit, but understand this
> > > > > > > is not the real reason.  If I revert this commit, I still get:
> > > > > > >
> > > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.got.plt' from
> > > > > > > `arch/arm64/kernel/head.o' being placed in section `.got.plt'
> > > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.plt' from
> > > > > > > `arch/arm64/kernel/head.o' being placed in section `.plt'
> > > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
> > > > > > > `arch/arm64/kernel/head.o' being placed in section `.data.rel.ro'
> > > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > > > > > > `kernel/bpf/core.o' being placed in section `.eh_frame'
> > > > > > >
> > > > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > > > placement"), which is another red herring.
> > > > > >
> > > > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > > > causing the warning.
> >
> > When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> > missing from someone's KBUILD_CFLAGS.
> > But I don't see anything curious in kernel/bpf/Makefile, unless
> > cc-disable-warning is somehow broken.
>
> I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
> with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).
>
> Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
> is generated.  Removing the __no_fgcse tag fixes that.
>


Given that it was added for issues related to retpolines, ORC and
objtool, it should be safe to make that annotation x86-only.

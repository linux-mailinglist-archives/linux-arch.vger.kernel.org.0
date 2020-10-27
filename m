Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8169E29A6F5
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 09:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509493AbgJ0Ivf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 04:51:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39000 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509488AbgJ0Ivf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 04:51:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id u127so521821oib.6;
        Tue, 27 Oct 2020 01:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuQazVJddiiMcHpJSWJ6P15wkN0uJ4Rr3unxje95N5k=;
        b=TnBULGUOLWENKlxwQUv664xtnuu/tIWVynH1dGeC3cYzW5ge8r/xYJD9YH1D66GrKB
         Tntlol2KG+3jUOa23+MVVRiZjTYoXr04E9zJQhfS7nAMzliCbcGqBjwIONmDgSyM4Nma
         vZ4u2yO9Ve2LmIZKj/oGhW0wafC8a7cYY0aurMVojF29Ou3XwykxJ9hcai0QNnIc4ONr
         RpuGj0k0lvuVcn+ZLJOqmN6hMaHrZMNpGJZXAaRmuH2W6B9e3qn73a/+ilq/NeDt2JcE
         hBXsqYV76q8bLvTlbswDzt5UN1CNLP0DCca7jGyDPqjSQBYD5f7jkCrDJGF9xGxl1lpL
         uSQQ==
X-Gm-Message-State: AOAM533yQx2IFXa6r/hvOjx9hX3ELOEiLcUmy+gENX4rolcqJU4PxXOi
        VbhtnFynjLRFmndsLBLcyL72I7PAKyIsWjY6BrE=
X-Google-Smtp-Source: ABdhPJySfGkbbKGp0kdsGkoJSUHyBdUu4Vk5rkDPOdc2rZmaJaJzvBeFtHoAEvLtFV2WfesebZxh5ZOmpbeFGptGWx0=
X-Received: by 2002:aca:f40c:: with SMTP id s12mr663393oih.153.1603788692533;
 Tue, 27 Oct 2020 01:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com> <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
In-Reply-To: <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 09:51:21 +0100
Message-ID: <CAMuHMdWXB+DB4gZoU6g8a0aw3hEdE_FSv9MEJF0M8X63WThkcA@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ard,

On Mon, Oct 26, 2020 at 6:43 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Aug 21, 2020 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
> > > > > > In preparation for warning on orphan sections, discard
> > > > > > unwanted non-zero-sized generated sections, and enforce other
> > > > > > expected-to-be-zero-sized sections (since discarding them might hide
> > > > > > problems with them suddenly gaining unexpected entries).
> > > > > >
> > > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > >
> > > > > This is now commit be2881824ae9eb92 ("arm64/build: Assert for unwanted
> > > > > sections") in v5.10-rc1, and is causing the following error with
> > > > > renesas_defconfig[1]:
> > > > >
> > > > >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > > > > `kernel/bpf/core.o' being placed in section `.eh_frame'
> > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > > > >
> > > > > I cannot reproduce this with the standard arm64 defconfig.
> > > > >
> > > > > I bisected the error to the aforementioned commit, but understand this
> > > > > is not the real reason.  If I revert this commit, I still get:
> > > > >
> > > > >     aarch64-linux-gnu-ld: warning: orphan section `.got.plt' from
> > > > > `arch/arm64/kernel/head.o' being placed in section `.got.plt'
> > > > >     aarch64-linux-gnu-ld: warning: orphan section `.plt' from
> > > > > `arch/arm64/kernel/head.o' being placed in section `.plt'
> > > > >     aarch64-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
> > > > > `arch/arm64/kernel/head.o' being placed in section `.data.rel.ro'
> > > > >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > > > > `kernel/bpf/core.o' being placed in section `.eh_frame'
> > > > >
> > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > placement"), which is another red herring.
> > > >
> > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > causing the warning.
> > > > If I compile core.c with "-g" added, like arm64 defconfig does, the
> > > > eh_frame section is no longer emitted.
> > > >
> > > > Hence setting CONFIG_DEBUG_INFO=y, cfr. arm64 defconfig, the warning
> > > > is gone, but I'm back to the the "Unexpected GOT/PLT entries" below...
> > > >
> > > > > Note that even on plain be2881824ae9eb92, I get:
> > > > >
> > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > > > >
> > > > > The parent commit obviously doesn't show that (but probably still has
> > > > > the problem).
> > >
> > > Reverting both
> > > b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section placement")
> > > be2881824ae9eb92 ("arm64/build: Assert for unwanted sections")
> > > seems to solve my problems, without any ill effects?
> > >
> >
> > I cannot reproduce the issue here with my distro GCC+binutils (Debian 8.3.0)
> >
> > The presence of .data.rel.ro and .got.plt sections suggests that the
> > toolchain is using -fpie and/or -z relro to build shared objects
> > rather than a fully linked bare metal binary.
> >
> > Which toolchain are you using? Does adding -fno-pie to the compiler
>
> gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04)  from Ubuntu 20.04LTS.
>
> > command line and/or adding -z norelro to the linker command line make
> > any difference?
>
> I'll give that a try later...

Adding -fno-pie to KBUILD_AFLAGS and KBUILD_CFLAGS doesn't
make a difference.

Same for adding -z norelno to the final link command:

    aarch64-linux-gnu-ld: warning: -z norelno ignored
    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
`kernel/bpf/core.o' being placed in section `.eh_frame'
    aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
    aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

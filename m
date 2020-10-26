Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F331B2991B0
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784672AbgJZQCK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 12:02:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40191 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773890AbgJZQBh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 12:01:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id f97so8452527otb.7;
        Mon, 26 Oct 2020 09:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asUJBtXsqUx3cRgU1NNSgl2otnJ/rjwe37VOtYFH0nY=;
        b=WyuQhwHY0btZowk4UvP2KtA00bvttBpF6ZCVn2YlBFAZGx/aVnuYQlzEYejda8I/tw
         /UMvlHtz0S4Ccx8f9J0iYSJMCeJgjYQ7FyhO33HARqMO338327lkHnCjluPAnlnInYl7
         fsHMv2rIewlaMw7C4QEAiFGeJCwPCq4GHhOO/iRZnSjCx1ZtVWccOhXJ0pfx6G83UG39
         WkAR/TuSS2c5J3CoM6cjztr0ZyPOgw12FVXSDpz1D2f6YBbyXPiVRXavNBDTglxYDyKw
         ocGPhCXBysJD1IawsPlcNpzB4+s8tq0vSfHyEJ/Viyy4Uq5vgXvI1xsj4nDb4QSUcG33
         6tVg==
X-Gm-Message-State: AOAM533ww+RT/DBROtZHoIsZcbjqxcNOm0NP1M/AhXwlkIvKGHF4Nklr
        lJCxwIuYmKBbuJJDcAm6sxD+uwuUShKORexkxjc=
X-Google-Smtp-Source: ABdhPJxPI+usSlZbZdx1IIlBwkjAFNrQaHoxsJAFSYYUxD2jVsGeXmh3ZzBEHoa089xtWunX1BF5lEiWHp0IZeVW1xM=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr11342816oti.107.1603728095846;
 Mon, 26 Oct 2020 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Oct 2020 17:01:24 +0100
Message-ID: <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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

On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Aug 21, 2020 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
> > > In preparation for warning on orphan sections, discard
> > > unwanted non-zero-sized generated sections, and enforce other
> > > expected-to-be-zero-sized sections (since discarding them might hide
> > > problems with them suddenly gaining unexpected entries).
> > >
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > This is now commit be2881824ae9eb92 ("arm64/build: Assert for unwanted
> > sections") in v5.10-rc1, and is causing the following error with
> > renesas_defconfig[1]:
> >
> >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > `kernel/bpf/core.o' being placed in section `.eh_frame'
> >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> >
> > I cannot reproduce this with the standard arm64 defconfig.
> >
> > I bisected the error to the aforementioned commit, but understand this
> > is not the real reason.  If I revert this commit, I still get:
> >
> >     aarch64-linux-gnu-ld: warning: orphan section `.got.plt' from
> > `arch/arm64/kernel/head.o' being placed in section `.got.plt'
> >     aarch64-linux-gnu-ld: warning: orphan section `.plt' from
> > `arch/arm64/kernel/head.o' being placed in section `.plt'
> >     aarch64-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
> > `arch/arm64/kernel/head.o' being placed in section `.data.rel.ro'
> >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > `kernel/bpf/core.o' being placed in section `.eh_frame'
> >
> > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > placement"), which is another red herring.
>
> kernel/bpf/core.o is the only file containing an eh_frame section,
> causing the warning.
> If I compile core.c with "-g" added, like arm64 defconfig does, the
> eh_frame section is no longer emitted.
>
> Hence setting CONFIG_DEBUG_INFO=y, cfr. arm64 defconfig, the warning
> is gone, but I'm back to the the "Unexpected GOT/PLT entries" below...
>
> > Note that even on plain be2881824ae9eb92, I get:
> >
> >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> >
> > The parent commit obviously doesn't show that (but probably still has
> > the problem).

Reverting both
b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section placement")
be2881824ae9eb92 ("arm64/build: Assert for unwanted sections")
seems to solve my problems, without any ill effects?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

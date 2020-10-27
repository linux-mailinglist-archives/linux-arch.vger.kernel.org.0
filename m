Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3459B29C8CD
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 20:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372118AbgJ0TZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 15:25:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35829 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371994AbgJ0TZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 15:25:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id n11so2177331ota.2;
        Tue, 27 Oct 2020 12:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAXcDu1i1flhyWT9SP7kPy0qFQN/al6f7WHErrrSgPg=;
        b=rcEDJP/LP0s6ReH2dyIErjyTHQEVDop33QaD877pbPDmYIngX4QeZLsdJ6NMjDi5dF
         0z52TfweQj3Tt2GLdZiF5rI4+sKQl6uVcyZMRIRq1j5g3Tb6UtE+QJOh5V21cvoHw9q6
         M39+WbHVIqmGP72pYglhIUeLqLOZBq3lL8RezCl4E+Hz1Qz27B/ExhpaCP6glX1dIW0z
         f2wDHo8xVGC6O8wTVl8ArZiiZC+/c6jix5n3hAMAqoZNzGIR5EapEeu6UZQRfbFMPhiv
         u8kxSBYh9Z6fXiHyixJVcb5ZvkzzVYaWKu4xLbfUUQiiS9zZMUWwMDB23+f1y5W6uiks
         xhqg==
X-Gm-Message-State: AOAM530Pa4xzAoiQNimF3wkxLy+pYBquYxffGW/j17Q2kmIi+1YNdHA6
        ackNelP6QhTM/1K+FEeKWvZQ0hOli0ZiQlPsStQ=
X-Google-Smtp-Source: ABdhPJxDecA7oJhI/l0ZaZdHgxYjcsQhAWqZZjjEeQpW1C/kYJFjHqOee8TQfeQ6nUaYzVFHLFetviirAiyCz5aX/yI=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr2427991oti.107.1603826738174;
 Tue, 27 Oct 2020 12:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com> <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
In-Reply-To: <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 20:25:26 +0100
Message-ID: <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

Hi Nick,

CC Josh

On Mon, Oct 26, 2020 at 6:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Fri, Aug 21, 2020 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
> > > > > > > In preparation for warning on orphan sections, discard
> > > > > > > unwanted non-zero-sized generated sections, and enforce other
> > > > > > > expected-to-be-zero-sized sections (since discarding them might hide
> > > > > > > problems with them suddenly gaining unexpected entries).
> > > > > > >
> > > > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > > >
> > > > > > This is now commit be2881824ae9eb92 ("arm64/build: Assert for unwanted
> > > > > > sections") in v5.10-rc1, and is causing the following error with
> > > > > > renesas_defconfig[1]:
> > > > > >
> > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > > > > > `kernel/bpf/core.o' being placed in section `.eh_frame'
> > > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
> > > > > >
> > > > > > I cannot reproduce this with the standard arm64 defconfig.
> > > > > >
> > > > > > I bisected the error to the aforementioned commit, but understand this
> > > > > > is not the real reason.  If I revert this commit, I still get:
> > > > > >
> > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.got.plt' from
> > > > > > `arch/arm64/kernel/head.o' being placed in section `.got.plt'
> > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.plt' from
> > > > > > `arch/arm64/kernel/head.o' being placed in section `.plt'
> > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
> > > > > > `arch/arm64/kernel/head.o' being placed in section `.data.rel.ro'
> > > > > >     aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
> > > > > > `kernel/bpf/core.o' being placed in section `.eh_frame'
> > > > > >
> > > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > > placement"), which is another red herring.
> > > > >
> > > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > > causing the warning.
>
> When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> missing from someone's KBUILD_CFLAGS.
> But I don't see anything curious in kernel/bpf/Makefile, unless
> cc-disable-warning is somehow broken.

I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).

Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
is generated.  Removing the __no_fgcse tag fixes that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

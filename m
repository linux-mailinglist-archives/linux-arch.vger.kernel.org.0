Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716DA298CDF
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775120AbgJZM3h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 08:29:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46782 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775119AbgJZM3g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 08:29:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id j21so2690120ota.13;
        Mon, 26 Oct 2020 05:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0trfHgi8OBfd5iB69j5LL8jeOJ1Nb/421IvjhePhaus=;
        b=P+zlDX8Hgk/S9xxcgd506ahxBtu8rxysyBTc4iPdrjvaUKbAIYNXAzklq2sAXHfcdT
         4zOl+sJ2I4EsX+ysfwgaFtIp72UAzGYVSLOPvF+7rEaf7n2sNg49vN9xroPjX9W7ix/w
         WE4/Am7rq952ISK+5wgv41hBKbfGPpC12JbSi0QdtNGx3Z24DWvMShNR6iLwpMmIld/V
         Cl3vz8QU7l24bWJe5h+7EEnnfzMMNiE2I3HTK173CU7NJkOwH2R7GA/Cp9j8Ft8XvQ3O
         NS6eW1NQBUzx0XKvJy/3hq0kCaG9seTK3IeK/3Rzb0LxjhtrTxyU0xRs1LlbIkzZmDnW
         y5xg==
X-Gm-Message-State: AOAM531eY9L/FwrZLkaV9J3oHAKbC/BsZQCvHwKqpupJ1LbS0AUInOks
        1iPCyBSNeiZM0MrFucyCj7d0TsG3BsDmzzs2Luw=
X-Google-Smtp-Source: ABdhPJyBweNoUQCltnRnsquxLRWEfPnJGEis2BPFL9CWHQhByaLq9YhLr+yqM3AxsL8UQGje3+jKX3bZuCidiISTg8s=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr13055312otc.145.1603715374142;
 Mon, 26 Oct 2020 05:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org> <20200821194310.3089815-14-keescook@chromium.org>
In-Reply-To: <20200821194310.3089815-14-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Oct 2020 13:29:22 +0100
Message-ID: <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
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

Hi Kees,

On Fri, Aug 21, 2020 at 9:56 PM Kees Cook <keescook@chromium.org> wrote:
> In preparation for warning on orphan sections, discard
> unwanted non-zero-sized generated sections, and enforce other
> expected-to-be-zero-sized sections (since discarding them might hide
> problems with them suddenly gaining unexpected entries).
>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

This is now commit be2881824ae9eb92 ("arm64/build: Assert for unwanted
sections") in v5.10-rc1, and is causing the following error with
renesas_defconfig[1]:

    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
`kernel/bpf/core.o' being placed in section `.eh_frame'
    aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
    aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!

I cannot reproduce this with the standard arm64 defconfig.

I bisected the error to the aforementioned commit, but understand this
is not the real reason.  If I revert this commit, I still get:

    aarch64-linux-gnu-ld: warning: orphan section `.got.plt' from
`arch/arm64/kernel/head.o' being placed in section `.got.plt'
    aarch64-linux-gnu-ld: warning: orphan section `.plt' from
`arch/arm64/kernel/head.o' being placed in section `.plt'
    aarch64-linux-gnu-ld: warning: orphan section `.data.rel.ro' from
`arch/arm64/kernel/head.o' being placed in section `.data.rel.ro'
    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
`kernel/bpf/core.o' being placed in section `.eh_frame'

I.e. including the ".eh_frame" warning. I have tried bisecting that
warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
placement"), which is another red herring.

Note that even on plain be2881824ae9eb92, I get:

    aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
    aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!

The parent commit obviously doesn't show that (but probably still has
the problem).

Do you have a clue!

Thanks!

> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -121,6 +121,14 @@ SECTIONS
>                 *(.got)                 /* Global offset table          */
>         }
>
> +       /*
> +        * Make sure that the .got.plt is either completely empty or it
> +        * contains only the lazy dispatch entries.
> +        */
> +       .got.plt : { *(.got.plt) }
> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> +              "Unexpected GOT/PLT entries detected!")
> +
>         . = ALIGN(SEGMENT_ALIGN);
>         _etext = .;                     /* End of text section */
>
> @@ -243,6 +251,18 @@ SECTIONS
>         ELF_DETAILS
>
>         HEAD_SYMBOLS
> +
> +       /*
> +        * Sections that should stay zero sized, which is safer to
> +        * explicitly check instead of blindly discarding.
> +        */
> +       .plt : {
> +               *(.plt) *(.plt.*) *(.iplt) *(.igot)
> +       }
> +       ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
> +
> +       .data.rel.ro : { *(.data.rel.ro) }
> +       ASSERT(SIZEOF(.data.rel.ro) == 0, "Unexpected RELRO detected!")
>  }
>
>  #include "image-vars.h"

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=topic/renesas-defconfig

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

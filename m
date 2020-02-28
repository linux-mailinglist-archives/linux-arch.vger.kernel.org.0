Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093D017315D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 07:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgB1Gvg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Feb 2020 01:51:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46491 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgB1Gvg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 01:51:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id j7so1617157wrp.13;
        Thu, 27 Feb 2020 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=avF1EF6lpJLVVsTfVWBjTe/8KtvDZSIsmNvBiNuGKMg=;
        b=THDt18G/FXoJ1iM+KNQB/v0hI6yvWK8bMDHDcfQSKeziHQIqYblvqJmEftpLKrhco2
         SFveE9Xs3bCIREUxBls+XpZ5opNASmRCLv3D66hN1WEbzNxO90PCG4cSn+mVp+I8scI7
         76mmSNwWiM+r92MlP+IZooSJ68GqKRUU2EDFk3sGPFzTdUcFLgdjFTp/wJQycrbHQfbs
         U7iwR6po+Ej26juHt0u7x5m8iNe+0c+7Vrq61sMfAtTT3Ig+HMKFng3edsIIBv6W5Bm7
         eRP0damzsRhWhiMonIWppR7VoRP6tfA6gyqPyfWwtTUofME3qfkNfJnrFUpozKjdx9Mn
         7nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=avF1EF6lpJLVVsTfVWBjTe/8KtvDZSIsmNvBiNuGKMg=;
        b=bCIjAWXKFWlJ4vOyUQ7rtR6/DtO1OTtVWpdn/R+ghfVTbTvBXpSZM4jN5cC0+GDwYS
         SsxwzF7jgQaUHmvpwmzVHEKvctBY8IOL5oiN/jcmJbyC6Gr9++NS4PPU2PFX9gHsobIX
         jm9hTAtbOzyRSVNgNv1pXLZ0FlIAykhgKFjyDiw4TBQoOdQURyeqGL7jly6ieC3exlWF
         OSr6ZHysrLMsGnGvamwLAvC6JQj57+0cJxcRjvJtBwlOoH3a+c6uTI7hDVT7x5RNomiy
         sdH/R4e5WxCtS4pS33T+6s9CdACbJnnXj3iMThW7zSjF3M+wpExfetC3L+qsg9lotpH0
         kE6w==
X-Gm-Message-State: APjAAAXCFehncvGBD+ELltBEcnry1sTV+HBCdHVrZJKUIsMkgJfs40kq
        SPG05RhV2tjQOFPMglQ2/dKgmrXuoColPkEJrmg=
X-Google-Smtp-Source: APXvYqwvp4piUvF/SYce0tbofShEvKkPpBAb2O8nmlEOvn8MBRHMN7izLp5juCXAuFJGAECrBbht8pmjEp8qcymSoVM=
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr3205209wrv.197.1582872693018;
 Thu, 27 Feb 2020 22:51:33 -0800 (PST)
MIME-Version: 1.0
References: <20200228002244.15240-1-keescook@chromium.org>
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 28 Feb 2020 07:51:21 +0100
Message-ID: <CA+icZUVRnjOWKZynAGDniXD_H9KRccONmeKHs25DPPU1c8ZcGg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable orphan section warning
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi!
>
> A recent bug was solved for builds linked with ld.lld, and tracking
> it down took way longer than it needed to (a year). Ultimately, it
> boiled down to differences between ld.bfd and ld.lld's handling of
> orphan sections. Similarly, the recent FGKASLR series brough up orphan
> section handling too[2]. In both cases, it would have been nice if the
> linker was running with --orphan-handling=warn so that surprise sections
> wouldn't silently get mapped into the kernel image at locations up to
> the whim of the linker's orphan handling logic. Instead, all desired
> sections should be explicitly identified in the linker script (to be
> either kept or discarded) with any orphans throwing a warning. The
> powerpc architecture actually already does this, so this series seeks
> to extend this coverage to x86, arm64, and arm.
>
> This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> landed), and has a minor conflict[4] with the ARM tree (related to
> the earlier mentioned bug). As it uses refactorings in the asm-generic
> linker script, and makes changes to kbuild, I think the cleanest place
> for this series to land would also be through -tip. Once again (like
> my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> this can go all together with the least disruption. Splitting it up by
> architecture seems needlessly difficult.
>
> Thanks!
>
> -Kees
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/282
> [2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/
> [3] https://lore.kernel.org/lkml/158264960194.28353.10560165361470246192.tip-bot2@tip-bot2/
> [4] https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8959/1
>

Hi Kees,

is this an updated version of what you have in your
kees/linux.git#linker/orphans/x86-arm Git branch?

Especially, I saw a difference in [2] and "[PATCH 4/9] x86/boot: Warn
on orphan section placement"

[ arch/x86/boot/compressed/Makefile ]

+KBUILD_LDFLAGS += --no-ld-generated-unwind-info

Can you comment on why this KBUILD_LDFLAGS was added/needed?

I like when people offer their work in a Git branch.
Do you plan to do that?

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm
[2] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=linker/orphans/x86-arm&id=e43aa77956c40b9b6db0b37b3780423aa2e661ad



> H.J. Lu (1):
>   Add RUNTIME_DISCARD_EXIT to generic DISCARDS
>
> Kees Cook (8):
>   scripts/link-vmlinux.sh: Delay orphan handling warnings until final
>     link
>   vmlinux.lds.h: Add .gnu.version* to DISCARDS
>   x86/build: Warn on orphan section placement
>   x86/boot: Warn on orphan section placement
>   arm64/build: Use common DISCARDS in linker script
>   arm64/build: Warn on orphan section placement
>   arm/build: Warn on orphan section placement
>   arm/boot: Warn on orphan section placement
>
>  arch/arm/Makefile                             |  4 ++++
>  arch/arm/boot/compressed/Makefile             |  2 ++
>  arch/arm/boot/compressed/vmlinux.lds.S        | 17 ++++++--------
>  .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
>  arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
>  arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
>  arch/arm64/Makefile                           |  4 ++++
>  arch/arm64/kernel/vmlinux.lds.S               | 13 +++++------
>  arch/x86/Makefile                             |  4 ++++
>  arch/x86/boot/compressed/Makefile             |  3 ++-
>  arch/x86/boot/compressed/vmlinux.lds.S        | 13 +++++++++++
>  arch/x86/kernel/vmlinux.lds.S                 |  7 ++++++
>  include/asm-generic/vmlinux.lds.h             | 11 ++++++++--
>  scripts/link-vmlinux.sh                       |  6 +++++
>  14 files changed, 85 insertions(+), 31 deletions(-)
>  rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)
>
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200228002244.15240-1-keescook%40chromium.org.

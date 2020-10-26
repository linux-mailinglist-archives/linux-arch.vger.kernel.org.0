Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C331299446
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780091AbgJZRtI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 13:49:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40866 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780074AbgJZRtI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2020 13:49:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id j5so5089937plk.7
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2020 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1/6VKuaxtnOQSh9u+GNtF0PEm0CXIxJ72v1J6ceCSU=;
        b=NDuAWgRkWwi1znQBu90iZu25Zkc7g4j7Dy4U6gZntjNVYEVVAArppw0Wi1Vm6zNmEZ
         dKlOldrTTTzdi0GigaEr83YkpSyOFsCGQ8Jnq7tSOC/wz/HQKn6tqEg+1ZD18p9NYKXT
         g90cqjJ6/HYh67A7UVrq9VnosfDXBI90TNp5kJ6RZb5Rv300x9WQuLOpKmY2fesnahm3
         jKAxyT2+vhK2JHEFYnJslrnhS76v03weyNqpNa3l+h37oBNdtWxWs3PUpHnvO6UhFPUf
         sKAZp4V8UksMOrhiVishvBVNK2P7wPd8IwSlPqJ4tNPDxV+wzb8/JODamjtTG7D2SYp+
         ShyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1/6VKuaxtnOQSh9u+GNtF0PEm0CXIxJ72v1J6ceCSU=;
        b=ueZaDKxsDXhNkv34UGiP8AB4cBsTopCSDeVXKDBQIe8qj8ZsCvduaPmOKaqyCaMiC2
         XDRaoH89uln/Rp1pY9udXoF1ahpGQ0mYooAt12MABVHcKhEoeOqK86xrhW5/g1aD/UOm
         AVZqkbuptkKyo+8iop/HNs2FZz8hpKWwzoUyJ7x1Da646/wTfaogs510bM8svfrIPWYw
         8nM815oiFkvFlPjSnD8uCYPqSH3Tj8Qt7IejM4uQ9Cxx0+jcn8QGXeQBGfANm93OqSiL
         ErWrc4jdRsDPLh7xWnxKfojWbRXHalfnm0xYa9v89LZGySkL/zp3lX5bdzoQZ5eU/Cwl
         ZEHA==
X-Gm-Message-State: AOAM530b68DYvztiOvVSFxuqIArwmLZUk3SgFwPwmAboU3JI1GWb8fa7
        HUXj4Luq/8mZ03vqxsKbGkNWE3oNY2u5BFLT7XAYww==
X-Google-Smtp-Source: ABdhPJwbU95UOraJNRLRxfcaOZqsVbX1K/+sURxS8YjWZQVyb3dxswgNTH7cDc7s5V04mdXJpLT2yCrlbxZl6xZ8hd4=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr21709795pjj.101.1603734545479;
 Mon, 26 Oct 2020 10:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com> <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
In-Reply-To: <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Oct 2020 10:48:54 -0700
Message-ID: <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Ard,
>
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

When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
missing from someone's KBUILD_CFLAGS.
But I don't see anything curious in kernel/bpf/Makefile, unless
cc-disable-warning is somehow broken.

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

This patch just got picked up into the for-next branch of the arm64
tree; it enables `-z norelro` regardless of configs.
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=3b92fa7485eba16b05166fddf38ab42f2ff6ab95
If you apply that, that should help you test `-z norelro` quickly.

-- 
Thanks,
~Nick Desaulniers

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D8929AAA0
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897119AbgJ0LaB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 07:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438783AbgJ0LaB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 07:30:01 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51B7622282;
        Tue, 27 Oct 2020 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603798200;
        bh=Zy6p8+sSge22tZ6Ol0fxyz4pPaYBH0Xpzov0a0c9eFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Go1yw0v4tO3ujDXhN6SjKClRzHWR3408QisVWd3P49ylQM4I9od5kXgRGVbYw1V7G
         /urQQRSeFPehVotDxDlU43CVV5AJICHFidlu9A1CEG/DvWBAzds2pF245XGLJu+kb8
         20marS7FYLHZsCEb1tE3W1qHazkIdURXunYBcp98=
Received: by mail-ot1-f43.google.com with SMTP id f97so788300otb.7;
        Tue, 27 Oct 2020 04:30:00 -0700 (PDT)
X-Gm-Message-State: AOAM530c1L9f9bs8OJ1PBCDeRzZhgQjYShEnnL4OZrYJGII0MARSMS3i
        vBbXbK3Eb26Gz/lGTchUrt/NqS+4n1EOWLrsExs=
X-Google-Smtp-Source: ABdhPJzcO33QxnNVR8ajnwxw/fuii7m9ICXAa8DAYMSKPU9fUAM1R84xqZc6zJa/xCm/MsAJCEbkvBNXLKgY5Oonol0=
X-Received: by 2002:a05:6830:4028:: with SMTP id i8mr1085883ots.90.1603798199464;
 Tue, 27 Oct 2020 04:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <20201027100844.GA1514990@myrica> <CAMuHMdVkLXmJEiV-uwOqKnfGQZX65tMFMTjs0O8q5BJsAhCGzg@mail.gmail.com>
In-Reply-To: <CAMuHMdVkLXmJEiV-uwOqKnfGQZX65tMFMTjs0O8q5BJsAhCGzg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Oct 2020 12:29:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEdgOkH6VFa5_J6yqaJheToHUSM8jYXyGfA9JS5xwyLGQ@mail.gmail.com>
Message-ID: <CAMj1kXEdgOkH6VFa5_J6yqaJheToHUSM8jYXyGfA9JS5xwyLGQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Collingbourne <pcc@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Oct 2020 at 11:20, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Jean-Philippe,
>
> On Tue, Oct 27, 2020 at 11:09 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> > On Mon, Oct 26, 2020 at 06:38:46PM +0100, Ard Biesheuvel wrote:
> > > > > > Note that even on plain be2881824ae9eb92, I get:
> > > > > >
> > > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
> > > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linkage=
s detected!
> > > > > >
> > > > > > The parent commit obviously doesn't show that (but probably sti=
ll has
> > > > > > the problem).
> > > >
> > > > Reverting both
> > > > b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section placement")
> > > > be2881824ae9eb92 ("arm64/build: Assert for unwanted sections")
> > > > seems to solve my problems, without any ill effects?
> > > >
> > >
> > > I cannot reproduce the issue here with my distro GCC+binutils (Debian=
 8.3.0)
> >
> > I have the same problem with one of my debug configs and Linux v5.10-rc=
1,
> > and can reproduce with the Debian 8.3.0 toolchain, by using the arm64
> > defconfig and disabling CONFIG_MODULES:
> >
> > ld -EL -maarch64elf --no-undefined -X -z norelro -shared -Bsymbolic -z =
notext --no-apply-dynamic-relocs --fix-cortex-a53-843419 --orphan-handling=
=3Dwarn --build-id=3Dsha1 --strip-debug -o .tmp_vmlinux.kallsyms1 -T ./arch=
/arm64/kernel/vmlinux.lds --whole-archive arch/arm64/kernel/head.o init/bui=
lt-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a certs/built-=
in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a crypto/=
built-in.a block/built-in.a arch/arm64/lib/built-in.a lib/built-in.a driver=
s/built-in.a sound/built-in.a net/built-in.a virt/built-in.a --no-whole-arc=
hive --start-group arch/arm64/lib/lib.a lib/lib.a ./drivers/firmware/efi/li=
bstub/lib.a --end-group
> > ld: Unexpected GOT/PLT entries detected!
> > ld: Unexpected run-time procedure linkages detected!
> >
> > Adding -fno-pie to this command doesn't fix the problem.
> >
> > Note that when cross-building with a GCC 10.2 and binutils 2.35.1 I als=
o
> > get several "aarch64-linux-gnu-ld: warning: -z norelro ignored" in
> > addition to the error, but I don't get that warning with the 8.3.0
> > toolchain.
>
> Thanks, my config (renesas_defconfig) also had CONFIG_MODULES disabled.
> Enabling that fixes the link error due to unexpected entries, but the
> .eh_frame orphan section warning is still there.
>

Looks like this is caused by the VFIO driver doing nasty things with
symbol_get(), resulting in weak symbol references being emitted. Since
taking the address of a weak symbol can yield NULL, the only way for
the linker to accommodate this is to use GOT indirection for the
direct symbol reference, so that the GOT entry can be set to NULL if
the reference is not satisfied at link time.

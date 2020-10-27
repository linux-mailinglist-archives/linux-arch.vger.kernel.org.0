Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1D329A96C
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 11:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897932AbgJ0KU2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 27 Oct 2020 06:20:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41437 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897922AbgJ0KU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 06:20:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id k65so730158oih.8;
        Tue, 27 Oct 2020 03:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0U7EsdK27CwbcUqJCGedR1nNrqKkk5RW5FI4v5npXo=;
        b=E2T2Mn6JpaQq29BPpUCVSSqk2rIWupY+ARah58gduPZgTRXhQe1O4gA8uBoFSUGiR2
         leOxnuANyMAnvPjpaJUiSrf+z3kY5tvYDuBDAUY5EdfAoDgaEfdTrCv8nqy7jas8XZb/
         TFbjDPE3JRtYYvThbV+3EKYK+NyYblTIJTJwLOSFGXtD8Vr7aVvapWSqQYlC2CP+qNVQ
         0cAC+sNHxph8pP12uWTecOvBfrdAzBoQ1ONsul+uUmYdvDNHOIGkFZf7CaWQFy2Deq7j
         IXigVkN9O6ZAm5mvbbckO/NfOJM57a1au0vJ5lA4/322ARjQXkUWTuXBw1KSilQTnNGl
         6fqw==
X-Gm-Message-State: AOAM5331TZlcYxc5muTzVBdqB/PMSA3PDhkjbmrVNgIe+uLi1fSyu9RQ
        KvuMMce2y5FVKWJSYomUe7SAurvLwoUHcEMuzLU=
X-Google-Smtp-Source: ABdhPJw4HQ61g6rVXqyTtbb78Rn47UEHJe9bDdBu8AbiaNpB6oIm6efRk6qrhEp2sIBryvI8UpkznvmJCNtaaKlBHI0=
X-Received: by 2002:aca:f40c:: with SMTP id s12mr858558oih.153.1603794026088;
 Tue, 27 Oct 2020 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com> <20201027100844.GA1514990@myrica>
In-Reply-To: <20201027100844.GA1514990@myrica>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Oct 2020 11:20:14 +0100
Message-ID: <CAMuHMdVkLXmJEiV-uwOqKnfGQZX65tMFMTjs0O8q5BJsAhCGzg@mail.gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Jean-Philippe,

On Tue, Oct 27, 2020 at 11:09 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
> On Mon, Oct 26, 2020 at 06:38:46PM +0100, Ard Biesheuvel wrote:
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
>
> I have the same problem with one of my debug configs and Linux v5.10-rc1,
> and can reproduce with the Debian 8.3.0 toolchain, by using the arm64
> defconfig and disabling CONFIG_MODULES:
>
> ld -EL -maarch64elf --no-undefined -X -z norelro -shared -Bsymbolic -z notext --no-apply-dynamic-relocs --fix-cortex-a53-843419 --orphan-handling=warn --build-id=sha1 --strip-debug -o .tmp_vmlinux.kallsyms1 -T ./arch/arm64/kernel/vmlinux.lds --whole-archive arch/arm64/kernel/head.o init/built-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a crypto/built-in.a block/built-in.a arch/arm64/lib/built-in.a lib/built-in.a drivers/built-in.a sound/built-in.a net/built-in.a virt/built-in.a --no-whole-archive --start-group arch/arm64/lib/lib.a lib/lib.a ./drivers/firmware/efi/libstub/lib.a --end-group
> ld: Unexpected GOT/PLT entries detected!
> ld: Unexpected run-time procedure linkages detected!
>
> Adding -fno-pie to this command doesn't fix the problem.
>
> Note that when cross-building with a GCC 10.2 and binutils 2.35.1 I also
> get several "aarch64-linux-gnu-ld: warning: -z norelro ignored" in
> addition to the error, but I don't get that warning with the 8.3.0
> toolchain.

Thanks, my config (renesas_defconfig) also had CONFIG_MODULES disabled.
Enabling that fixes the link error due to unexpected entries, but the
.eh_frame orphan section warning is still there.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

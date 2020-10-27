Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6429C734
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827839AbgJ0S2b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 14:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368159AbgJ0N5M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Oct 2020 09:57:12 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AD622202;
        Tue, 27 Oct 2020 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603807031;
        bh=Je4E4gBZXJ/sNG3nkwMJYrrW22bVdH6Xn8mBW9GPR0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KLVSIVYkUl4JFTHyh96u/EyqcEVqSzMBUbM+heapteOHQ10nN33tM40L7PCmapCOx
         idwp0uR2F5FAPooIT4ggfbzjDK0O6wBao3r3cTsSiffxh+332HDYugVYWAa4bSwPB4
         rxzsmXYcdz2yIQrlnSn9pUiUbo5QpfB/7ba5ap4M=
Received: by mail-oi1-f175.google.com with SMTP id k27so1331894oij.11;
        Tue, 27 Oct 2020 06:57:11 -0700 (PDT)
X-Gm-Message-State: AOAM5304WnlUy2yJFerOfNgMBO/4I88SsiropKYH7efujjKlkO4nPFeP
        GAniHvpPyr/bOhZwRDtXangpWAbpo+uddRmt+sk=
X-Google-Smtp-Source: ABdhPJyiUWLq2d/0S8bA/eHVjQIbuiLhP0Thprvi01iowhEASIUbVWXITMqLiKgZq9NGJTdjwcNDrI111NZJBdbyYtQ=
X-Received: by 2002:aca:2310:: with SMTP id e16mr1479442oie.47.1603807030355;
 Tue, 27 Oct 2020 06:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-14-keescook@chromium.org> <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <20201027100844.GA1514990@myrica> <CAMuHMdVkLXmJEiV-uwOqKnfGQZX65tMFMTjs0O8q5BJsAhCGzg@mail.gmail.com>
 <CAMj1kXEdgOkH6VFa5_J6yqaJheToHUSM8jYXyGfA9JS5xwyLGQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEdgOkH6VFa5_J6yqaJheToHUSM8jYXyGfA9JS5xwyLGQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Oct 2020 14:56:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEWJ8ZqerzVheWwT8zVT6MUivO+McyuF7tjHywWHyGnnQ@mail.gmail.com>
Message-ID: <CAMj1kXEWJ8ZqerzVheWwT8zVT6MUivO+McyuF7tjHywWHyGnnQ@mail.gmail.com>
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

On Tue, 27 Oct 2020 at 12:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 27 Oct 2020 at 11:20, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> >
> > Hi Jean-Philippe,
> >
> > On Tue, Oct 27, 2020 at 11:09 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > > On Mon, Oct 26, 2020 at 06:38:46PM +0100, Ard Biesheuvel wrote:
> > > > > > > Note that even on plain be2881824ae9eb92, I get:
> > > > > > >
> > > > > > >     aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected=
!
> > > > > > >     aarch64-linux-gnu-ld: Unexpected run-time procedure linka=
ges detected!
> > > > > > >
> > > > > > > The parent commit obviously doesn't show that (but probably s=
till has
> > > > > > > the problem).
> > > > >
> > > > > Reverting both
> > > > > b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section placement"=
)
> > > > > be2881824ae9eb92 ("arm64/build: Assert for unwanted sections")
> > > > > seems to solve my problems, without any ill effects?
> > > > >
> > > >
> > > > I cannot reproduce the issue here with my distro GCC+binutils (Debi=
an 8.3.0)
> > >
> > > I have the same problem with one of my debug configs and Linux v5.10-=
rc1,
> > > and can reproduce with the Debian 8.3.0 toolchain, by using the arm64
> > > defconfig and disabling CONFIG_MODULES:
> > >
> > > ld -EL -maarch64elf --no-undefined -X -z norelro -shared -Bsymbolic -=
z notext --no-apply-dynamic-relocs --fix-cortex-a53-843419 --orphan-handlin=
g=3Dwarn --build-id=3Dsha1 --strip-debug -o .tmp_vmlinux.kallsyms1 -T ./arc=
h/arm64/kernel/vmlinux.lds --whole-archive arch/arm64/kernel/head.o init/bu=
ilt-in.a usr/built-in.a arch/arm64/built-in.a kernel/built-in.a certs/built=
-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a crypto=
/built-in.a block/built-in.a arch/arm64/lib/built-in.a lib/built-in.a drive=
rs/built-in.a sound/built-in.a net/built-in.a virt/built-in.a --no-whole-ar=
chive --start-group arch/arm64/lib/lib.a lib/lib.a ./drivers/firmware/efi/l=
ibstub/lib.a --end-group
> > > ld: Unexpected GOT/PLT entries detected!
> > > ld: Unexpected run-time procedure linkages detected!
> > >
> > > Adding -fno-pie to this command doesn't fix the problem.
> > >
> > > Note that when cross-building with a GCC 10.2 and binutils 2.35.1 I a=
lso
> > > get several "aarch64-linux-gnu-ld: warning: -z norelro ignored" in
> > > addition to the error, but I don't get that warning with the 8.3.0
> > > toolchain.
> >
> > Thanks, my config (renesas_defconfig) also had CONFIG_MODULES disabled.
> > Enabling that fixes the link error due to unexpected entries, but the
> > .eh_frame orphan section warning is still there.
> >
>
> Looks like this is caused by the VFIO driver doing nasty things with
> symbol_get(), resulting in weak symbol references being emitted. Since
> taking the address of a weak symbol can yield NULL, the only way for
> the linker to accommodate this is to use GOT indirection for the
> direct symbol reference, so that the GOT entry can be set to NULL if
> the reference is not satisfied at link time.

This seems to do the trick for me.

diff --git a/include/linux/module.h b/include/linux/module.h
index 7ccdf87f376f..6264617bab4d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -740,7 +740,7 @@ static inline bool within_module(unsigned long
addr, const struct module *mod)
 }

 /* Get/put a kernel symbol (calls should be symmetric) */
-#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); }=
)
+#define symbol_get(x) ({ extern typeof(x) x
__attribute__((weak,visibility("hidden"))); &(x); })
 #define symbol_put(x) do { } while (0)
 #define symbol_put_addr(x) do { } while (0)

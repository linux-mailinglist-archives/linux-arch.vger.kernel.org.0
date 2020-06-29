Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037B320E551
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgF2Vfk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgF2Skr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:47 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 764FD23EB4;
        Mon, 29 Jun 2020 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443295;
        bh=qBdL3tlBX+scLgBAFOGB5TLlWji+GPtg13a4shdBzo0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CqbNccPLqUPqB9hiyKYsfFMqH3nDDzIujQlexZjYfgmKPuDRzFqITwjtLc4SEaPIT
         NX7+dkrumDzJth6HVgXUB7tIDxo+mOubkRrfP1ERFvFBgCZFiSuWvu5Ekl28nVWyl3
         BT+iYJ8vFGrLyBjgUdifq4hbovppZjc7Z52B/uGQ=
Received: by mail-oi1-f176.google.com with SMTP id e4so6522842oib.1;
        Mon, 29 Jun 2020 08:08:15 -0700 (PDT)
X-Gm-Message-State: AOAM5300557Le6CeZWQf0nLdoir8lOGrRYPQOS2xzVsy9qYXMKVLFCeD
        W52XoAHDZ4guK0byG5tbY6Ka9j0v6UaCx2W0CPE=
X-Google-Smtp-Source: ABdhPJwTia/C2SAyWRf7uRxGpRTQZVHRS1vjtLhx+E/b1Dt+tcSaaYv2NWdpuTJRHdljFla/pOrxnXThmPE1qfnRksI=
X-Received: by 2002:aca:b241:: with SMTP id b62mr11815740oif.47.1593443294721;
 Mon, 29 Jun 2020 08:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-6-keescook@chromium.org> <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
 <202006290806.3BDE2A8@keescook>
In-Reply-To: <202006290806.3BDE2A8@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 29 Jun 2020 17:08:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHij8M5_kvh6EDaFa8ksbDBxqdaWGtR=-QnXhF7YosK6g@mail.gmail.com>
Message-ID: <CAMj1kXHij8M5_kvh6EDaFa8ksbDBxqdaWGtR=-QnXhF7YosK6g@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] ctype: Work around Clang -mbranch-protection=none
 bug
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Jun 2020 at 17:06, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 29, 2020 at 10:15:47AM +0200, Ard Biesheuvel wrote:
> > On Mon, 29 Jun 2020 at 08:18, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > In preparation for building efi/libstub with -mbranch-protection=none
> > > (EFI does not support branch protection features[1]), add no-op code
> > > to work around a Clang bug that emits an unwanted .note.gnu.property
> > > section for object files without code[2].
> > >
> > > [1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
> > > [2] https://bugs.llvm.org/show_bug.cgi?id=46480
> > >
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > Cc: clang-built-linux@googlegroups.com
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  lib/ctype.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/lib/ctype.c b/lib/ctype.c
> > > index c819fe269eb2..21245ed57d90 100644
> > > --- a/lib/ctype.c
> > > +++ b/lib/ctype.c
> > > @@ -36,3 +36,13 @@ _L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,     /* 224-239 */
> > >  _L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};      /* 240-255 */
> > >
> > >  EXPORT_SYMBOL(_ctype);
> > > +
> > > +/*
> > > + * Clang will generate .note.gnu.property sections for object files
> > > + * without code, even in the presence of -mbranch-protection=none.
> > > + * To work around this, define an unused static function.
> > > + * https://bugs.llvm.org/show_bug.cgi?id=46480
> > > + */
> > > +#ifdef CONFIG_CC_IS_CLANG
> > > +void __maybe_unused __clang_needs_code_here(void) { }
> > > +#endif
> > > --
> > > 2.25.1
> > >
> >
> > I take it we don't need this horrible hack if we build the EFI stub
> > with branch protections and filter out the .note.gnu.property section
> > explicitly?
> >
> > Sorry to backpedal, but that is probably a better approach after all,
> > given that the instructions don't hurt, and we will hopefully be able
> > to arm them once UEFI (as well as PE/COFF) gets around to describing
> > this in a way that both the firmware and the OS can consume.
>
> How does this look?
>
>
> commit 051ef0b75a386c3fe2f216d16246468147a48c5b
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Jun 23 18:02:56 2020 -0700
>
>     efi/libstub: Disable -mbranch-protection
>
>     In preparation for adding --orphan-handling=warn to more architectures,
>     disable -mbranch-protection, as EFI does not yet support it[1].  This was
>     noticed due to it producing unwanted .note.gnu.property sections (prefixed
>     with .init due to the objcopy build step).
>
>     However, we must also work around a bug in Clang where the section is
>     still emitted for code-less object files[2], so also remove the section
>     during the objcopy.
>
>     [1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
>     [2] https://bugs.llvm.org/show_bug.cgi?id=46480
>
>     Cc: Ard Biesheuvel <ardb@kernel.org>
>     Cc: Arvind Sankar <nivedita@alum.mit.edu>
>     Cc: Atish Patra <atish.patra@wdc.com>
>     Cc: linux-efi@vger.kernel.org
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 75daaf20374e..f9f1922f8f28 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -18,7 +18,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ \
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
>  cflags-$(CONFIG_ARM64)         := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> -                                  -fpie $(DISABLE_STACKLEAK_PLUGIN)
> +                                  -fpie $(DISABLE_STACKLEAK_PLUGIN) \
> +                                  $(call cc-option,-mbranch-protection=none)
>  cflags-$(CONFIG_ARM)           := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic \
>                                    $(call cc-option,-mno-single-pic-base)
> @@ -66,6 +67,12 @@ lib-$(CONFIG_X86)            += x86-stub.o
>  CFLAGS_arm32-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
> +# Even when -mbranch-protection=none is set, Clang will generate a
> +# .note.gnu.property for code-less object files (like lib/ctype.c),
> +# so work around this by explicitly removing the unwanted section.
> +# https://bugs.llvm.org/show_bug.cgi?id=46480
> +STUBCOPY_FLAGS-y               += --remove-section=.note.gnu.property
> +
>  #
>  # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
>  # .bss section, so the .bss section of the EFI stub needs to be included in the
>


Looks fine

Acked-by: Ard Biesheuvel <ardb@kernel.org>

if you want to keep it with the set, or I can take it as a EFI fix.

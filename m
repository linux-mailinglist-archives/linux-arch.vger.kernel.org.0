Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC820E4A0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgF2V1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42231C031C6F
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 11:03:03 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so3363888pfq.11
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcOa7nLCMvwvBvn+lXefiaEhY1cnw7datfi9VffahTk=;
        b=r13LcPYkVT0QvwJZmwPVtSiSE821D8z+loelig4JyhWpIr2GDIKdMpwQEoIwTQy2oH
         TmbsgQgAdaNwDNSMupvVB0Q5lBpVn0GlcrJ/QltbLA7O4hd371LAsV7U/bNWwKh3fjjJ
         Emnx6ima91VS1Q/Coc13JQiR6B7PeqtzMdSDveDWWXo/TbrU5lZ5CmGyIrdrbcZWayMf
         y5tlvmSbbV4sJ7OYjoxYDJRYvf+h2fgbUczNYJDoheq4vWjGcQK+JZouEgO6tEIKjP0J
         qf5p0fOOrT1TcBV7dXPpqhhkYuiuUNN8qlWdn2JY+3bmJ/GIeRZAVv+AqO4ojiijs4Uj
         JfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcOa7nLCMvwvBvn+lXefiaEhY1cnw7datfi9VffahTk=;
        b=YedIzqSR47t7fAbzq+/SKbVcm60DMB6/2xDT+y62g6ZBr4ez0r/mN/1irl6+gfIpgK
         HDWKbFRiaBiJPN6QABh5gnMlgiKacseCautm/XOhMWIMoYM4T8n1iJ8owkfvA30s9ona
         jFKAigU4eO4ppfDjO3KLqv9sjlT8kOnWklMsHxZ7YxZOk6qFFauEQQSGXjVedaIRuxUX
         rstRjkhVV7s8MxQZHaz6nldDGaSx6Y+qlrYkEiy5KG3CobNp8JH+YTcR/AuCFoHYBJMM
         trPCAdFDGYlmKWzzBpL9SUspMIqTGVw72HV+XcuNMAt8hftHDNSxZ+cherknhLvU28f/
         nXBQ==
X-Gm-Message-State: AOAM531Xl15+cmbVc891KlGR0fxQP/bH0awzTaOlrw78J4IZJrLhwv+w
        gwfGMH8fkKDstvYTB2MFuYdVlx8zRl3IPj451y3piA==
X-Google-Smtp-Source: ABdhPJz9+i4D45iNpvDJAjy8t0TCOs03y2uc7EK1ApuKtEPPpmNHtDv8UmtRzYb/Tg4Esq7LtMnkj4tJsm1tUYBKEnc=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr15661788pfu.169.1593453782335;
 Mon, 29 Jun 2020 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-6-keescook@chromium.org> <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
 <202006290806.3BDE2A8@keescook>
In-Reply-To: <202006290806.3BDE2A8@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 11:02:51 -0700
Message-ID: <CAKwvOd=DMfmvfiEX7KDPLs75SbNz+LAGSwC3V_=LgGH3kjtE=g@mail.gmail.com>
Subject: Re: [PATCH v4 05/17] ctype: Work around Clang -mbranch-protection=none
 bug
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 8:06 AM Kees Cook <keescook@chromium.org> wrote:
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

This is definitely better than the empty function.  Though a patch is
posted for fixing this in LLVM. Assuming that lands before this, we
might not actually need this workaround?

arch/arm64/Kconfig
1625 config ARM64_BTI_KERNEL
...
1633   # https://reviews.llvm.org/rGb8ae3fdfa579dbf366b1bb1cbfdbf8c51db7fa55
1634   depends on !CC_IS_CLANG || CLANG_VERSION >= 100001

So if Daniel's patch lands AND is backported into the clang 10.0.1
release, then we might not need to carry this workaround?  Either way,

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +
>  #
>  # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
>  # .bss section, so the .bss section of the EFI stub needs to be included in the
>
> --
> Kees Cook

-- 
Thanks,
~Nick Desaulniers

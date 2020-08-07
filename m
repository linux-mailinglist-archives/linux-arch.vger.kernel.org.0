Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817823F3AD
	for <lists+linux-arch@lfdr.de>; Fri,  7 Aug 2020 22:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGUVB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Aug 2020 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGUVB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2020 16:21:01 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB045C061756;
        Fri,  7 Aug 2020 13:21:00 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o22so2233734qtt.13;
        Fri, 07 Aug 2020 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B7Fctmg3cVLvQt7Pqxb1gnXBcCgs6NDZ66tmQ5JI0zg=;
        b=M6Snqi+5vU8MfS8JcxyXJ40DbOeNxstioyDIQ7RipbYSbN7JQ3Zh8YKulYvpWIfWMG
         eUMR1fQ+G6brVpm3EcSR81uT1VEg6XoL0pSdXn7PToQ63fvzZRxpWr3J6buyDNMuckpG
         4Z5Ya2CnVn4fwpk7BFvYU91TRFyq9H8Thqax+U+MjxCQvmHtoD/2PZSEZcgCzNmuIf4t
         NnYgkjSYnqyQdRf/hbeSE358rBIHUE5LW0OvBTxreq4sKC88qCa34IlIHFrdpswidJ5/
         WKci7ur3XnSKEEqXlCjTetdOmz8QPZzvjlK8a/y87yuY09ekPaVnHTsgldHwqdiuyOqL
         PwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=B7Fctmg3cVLvQt7Pqxb1gnXBcCgs6NDZ66tmQ5JI0zg=;
        b=U8/hQL0wJVnRjYlu/1cCOnaDb2OLPOzCQ4maTGlE5ax0KKQBhdlB1eSPPc8k9FzUDY
         gDYplOBwb+p1M8tJL1c8m9CxMCuFYKWbo/sTmcoxhxSKeJVnBkrQXZBwFFPYvsMKL1+5
         byp62lEo9GB+nK9hwUDzTdpwfO+WIg/7kBVlx4dEhml0TL6C0G84C2pcxq+TDWBq0K1z
         u62++guuKNfLHALFNBqRll54wMdHd21Z1Tv5szjphTbOPBFHvpKeIp05ODEZHXfRG4V0
         G7yRwFVuJ96aKGyh0py03sklLeGWAJCZqF211gQb/YW1JHaPd9ykh9FIEtibJAHxXc8L
         I4gQ==
X-Gm-Message-State: AOAM530ZjET0FG0x8BiKmsW4q4RVz0RcIFpt6bnSl1xsTRBc6vrpT1NV
        0cEOOfJFiex/uUFZ8woP8l4=
X-Google-Smtp-Source: ABdhPJz/CW6PITmuhsKbBKT0FOoGWxKkovtopmDyC0lleFL8M8TfAO19eUhslQAEOHtMAH1StV6FdA==
X-Received: by 2002:ac8:7152:: with SMTP id h18mr15653535qtp.44.1596831659768;
        Fri, 07 Aug 2020 13:20:59 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y26sm8158811qto.75.2020.08.07.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:20:59 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 7 Aug 2020 16:20:56 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 06/36] x86/boot: Remove run-time relocations from
 head_{32,64}.S
Message-ID: <20200807202056.GA1454138@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-7-keescook@chromium.org>
 <CAKwvOd=mY5=SWjGKA_KpvKnOPmJky_qMcyBYeFhskx6J=aJmNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=mY5=SWjGKA_KpvKnOPmJky_qMcyBYeFhskx6J=aJmNA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 07, 2020 at 11:12:29AM -0700, Nick Desaulniers wrote:
> On Fri, Jul 31, 2020 at 4:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > From: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > The BFD linker generates run-time relocations for z_input_len and
> > z_output_len, even though they are absolute symbols.
> >
> > This is fixed for binutils-2.35 [1]. Work around this for earlier
> > versions by defining two variables input_len and output_len in addition
> > to the symbols, and use them via position-independent references.
> >
> > This eliminates the last two run-time relocations in the head code and
> > allows us to drop the -z noreloc-overflow flag to the linker.
> >
> > Move the -pie and --no-dynamic-linker LDFLAGS to LDFLAGS_vmlinux instead
> > of KBUILD_LDFLAGS. There shouldn't be anything else getting linked, but
> > this is the more logical location for these flags, and modversions might
> > call the linker if an EXPORT_SYMBOL is left over accidentally in one of
> > the decompressors.
> >
> > [1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754
> >
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > Reviewed-by: Fangrui Song <maskray@google.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/boot/compressed/Makefile  | 12 ++----------
> >  arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
> >  arch/x86/boot/compressed/head_64.S |  4 ++--
> >  arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
> >  4 files changed, 18 insertions(+), 21 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 489fea16bcfb..7db0102a573d 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -51,16 +51,8 @@ UBSAN_SANITIZE :=n
> >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > -ifeq ($(CONFIG_X86_32),y)
> > -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> > -else
> > -# To build 64-bit compressed kernel as PIE, we disable relocation
> > -# overflow check to avoid relocation overflow error with a new linker
> > -# command-line option, -z noreloc-overflow.
> > -KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> > -       && echo "-z noreloc-overflow -pie --no-dynamic-linker")
> > -endif
> > -LDFLAGS_vmlinux := -T
> > +LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> 
> Oh, do these still need ld-option?  bfd and lld both support these
> flags. (Though in their --help, they mention single hyphen and double
> hyphen respectively.  Also, if we don't build this as PIE because the
> linker doesn't support the option, we probably want to fail the build?
> 

The check for pie doesn't, it's dropped in the next patch and pie is
used unconditionally.

no-dynamic-linker still needs the check as it was only supported from
binutils-2.26.

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D14207BD8
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406135AbgFXS5x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405469AbgFXS5x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:57:53 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C6E20885;
        Wed, 24 Jun 2020 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593025072;
        bh=1q8ObYC1d3xeQvTv85PYxr6jPgZILDb6CEH1WVxbD1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ure8PVgT6k9gjmIefiqObzVAEOez615ezDzC+o5R21oW4ht7pcoR4nr3sD2QVr9Zm
         sNR1DI5Tsim86pEAXN8E5ewBiZtD5fzfsgyJNVv5KxnnzUCfgvv8yFXYpK5oj/7BFS
         PkyQPQCG13fciljs/3nXNlEeWZYd3j+AwqDUhA8A=
Received: by mail-ot1-f47.google.com with SMTP id t6so2921743otk.9;
        Wed, 24 Jun 2020 11:57:52 -0700 (PDT)
X-Gm-Message-State: AOAM530yu8Q9pZkMSIMQmN1aD2+naTLWi46OuS0GZr6T7SYjqqJDL2zo
        VuJsB9IGnV3aH94OcyGHOF/HJi/pWJk6VC3d/8g=
X-Google-Smtp-Source: ABdhPJwnicjOZZNzxsEV7447Hc2eD0SiEbqezDL1exyj3Xj6RtxCd11bwPQmeP1XwCm8ZE+DXKq8uMQmp4fSgOIo/Dk=
X-Received: by 2002:a9d:688:: with SMTP id 8mr3612674otx.108.1593025071500;
 Wed, 24 Jun 2020 11:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200624033142.cinvg6rbg252j46d@google.com> <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck> <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <202006240820.A3468F4@keescook> <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
 <202006240844.7BE48D2B5@keescook> <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
 <20200624162919.GH25945@arm.com> <CAMj1kXE1zWCjVt8iS4fv2gQHzrTF6=Ggd16nm+4TNWAG3zSWAQ@mail.gmail.com>
 <20200624171613.GJ25945@arm.com> <CAMj1kXG+Xh=a1exFXuRJ9EYbT+0xnC=votGGX1dmzBgZgEaC-w@mail.gmail.com>
In-Reply-To: <CAMj1kXG+Xh=a1exFXuRJ9EYbT+0xnC=votGGX1dmzBgZgEaC-w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Jun 2020 20:57:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFabTkfxMDT8zz1xbOpkuWQ2=1c37T3NeB0wvuCt4Op1A@mail.gmail.com>
Message-ID: <CAMj1kXFabTkfxMDT8zz1xbOpkuWQ2=1c37T3NeB0wvuCt4Op1A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Fangrui Song <maskray@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        X86 ML <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 at 20:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 24 Jun 2020 at 19:16, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 06:40:48PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 24 Jun 2020 at 18:29, Dave Martin <Dave.Martin@arm.com> wrote:
> > > >
> > > > On Wed, Jun 24, 2020 at 05:48:41PM +0200, Ard Biesheuvel wrote:
> > > > > On Wed, 24 Jun 2020 at 17:45, Kees Cook <keescook@chromium.org> wrote:
> > > > > >
> > > > > > On Wed, Jun 24, 2020 at 05:31:06PM +0200, Ard Biesheuvel wrote:
> > > > > > > On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > > > > > > > > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > > > > > > > > stub, given that it runs under the control of the firmware, with its
> > > > > > > > > memory mappings and PAC configuration etc.
> > > > > > > >
> > > > > > > > Is BTI being ignored when the firmware runs?
> > > > > > >
> > > > > > > Given that it requires the 'guarded' attribute to be set in the page
> > > > > > > tables, and the fact that the UEFI spec does not require it for
> > > > > > > executables that it invokes, nor describes any means of annotating
> > > > > > > such executables as having been built with BTI annotations, I think we
> > > > > > > can safely assume that the EFI stub will execute with BTI disabled in
> > > > > > > the foreseeable future.
> > > > > >
> > > > > > yaaaaaay. *sigh* How long until EFI catches up?
> > > > > >
> > > > > > That said, BTI shouldn't _hurt_, right? If EFI ever decides to enable
> > > > > > it, we'll be ready?
> > > > > >
> > > > >
> > > > > Sure. Although I anticipate that we'll need to set some flag in the
> > > > > PE/COFF header to enable it, and so any BTI opcodes we emit without
> > > > > that will never take effect in practice.
> > > >
> > > > In the meantime, it is possible to build all the in-tree parts of EFI
> > > > for BTI, and just turn it off for out-of-tree EFI binaries?
> > > >
> > >
> > > Not sure I understand the question. What do you mean by out-of-tree
> > > EFI binaries? And how would the firmware (which is out of tree itself,
> > > and is in charge of the page tables, vector table, timer interrupt etc
> > > when the EFI stub executes) distinguish such binaries from the EFI
> > > stub?
> >
> > I'm not an EFI expert, but I'm guessing that you configure EFI with
> > certain compiler flags and build it.
>
> 'EFI' is not something you build. It is a specification that describes
> how a conformant firmware implementation interfaces with a conformant
> OS.
>
> Sorry to be pedantic, but that is really quite relevant. By adhering
> to the EFI spec rigorously, we no longer have to care about who
> implements the opposite side, and how.
>
> So yes, of course there are ways to build the opposite side with BTI
> enabled, in a way that all its constituent pieces keep working as
> expected. A typical EDK2 based implementation of EFI consists of
> 50-100 individual PE/COFF executables that all get loaded, relocated
> and started like ordinary user space programs.
>
> What we cannot do, though, is invent our own Linux specific way of
> decorating the kernel's PE/COFF header with an annotation that
> instructs a Linux specific EFI loader when to enable the GP bit for
> the .text pages.
>
> > Possibly some standalone EFI
> > executables are built out of the same tree and shipped with the
> > firmware from the same build, but I'm speculating.  If not, we can just
> > run all EFI executables with BTI off.
> >
> > > > If there's no easy way to do this though, I guess we should wait for /
> > > > push for a PE/COFF flag to describe this properly.
> > > >
> > >
> > > Yeah good point. I will take this to the forum.
> >
> > In the interim, we could set the GP bit in EFI's page tables for the
> > executable code from the firmware image if we want this protection, but
> > turn it off in pages mapping the executable code of EFI executables.
> > This is better than nothing.
> >
>
> We need to distinguish between the EFI stub and the EFI runtime services here.
>
> The EFI stub consists of kernel code that executes in the context of
> the firmware, at which point the loader has no control whatsoever over
> page tables, vector tables, etc. This is the stage where the loading
> and starting of PE/COFF images takes place. If we want to enable BTI
> for code running in this context, we need PE/COFF annotations, as
> discussed above.
>
> The EFI runtime services are firmware code that gets invoked by the OS
> at runtime. Whether or not such code is emitted with BTI annotations
> is a separate matter (but should also be taken to the forum
> nonetheless), and does not need any changes at the PE/COFF level.
> However, for this code, I'd like the sandboxing to be much more
> rigorous than it is today, to the point where the security it provides

...  the security *bti* provides ...

> doesn't even matter deeply to the OS itself. (I had some patches a
> while ago that reused the KPTI infrastructure to unmap the entire
> kernel while EFI runtime services are in progress. There was also an
> intern in the team that implemented something similar on top of KVM)

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31238207B6D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405812AbgFXSXR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 14:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405469AbgFXSXR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 14:23:17 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1A0207FC;
        Wed, 24 Jun 2020 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593022996;
        bh=ZF4PxoE2gxKJKGHg1jFJn1yz5MUXPaZ030E8kTj+DE4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bRtaoBxn1ZeKTiqgV++Nwoq7bTRDmjNRHfzGTMcHitS7vaxi4jjIenOaMdghJ0Lfz
         ifGlOYXyH8iHLUFM2rkvjpZsNxIbGgCiPqBnt/jE24sR8KMwcA/fP8VK+Pi+grXNI6
         mwvMNKzv00Vqqm6/UINgackm2GJyjAIMDl3YyC9o=
Received: by mail-ot1-f45.google.com with SMTP id 64so2838975oti.5;
        Wed, 24 Jun 2020 11:23:16 -0700 (PDT)
X-Gm-Message-State: AOAM530qVi7Xh97QvdMbB7klJEjxUxbq/Sbvx6YhL8z9pHMucAtd+AL3
        kI/lO+qUUwIrVqWxf0rHFTnjW9weIp1atNh3FN8=
X-Google-Smtp-Source: ABdhPJxn7sr9vg60DZs4/+nAKlWtVbggaKDrpGd7my5E+G25Lg0OQZbdJNnMqX44+SEMXoLbkHm+gWRhenYUuATy0hE=
X-Received: by 2002:a4a:b34b:: with SMTP id n11mr24365561ooo.41.1593022995076;
 Wed, 24 Jun 2020 11:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200624033142.cinvg6rbg252j46d@google.com> <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck> <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <202006240820.A3468F4@keescook> <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
 <202006240844.7BE48D2B5@keescook> <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
 <20200624162919.GH25945@arm.com> <CAMj1kXE1zWCjVt8iS4fv2gQHzrTF6=Ggd16nm+4TNWAG3zSWAQ@mail.gmail.com>
 <20200624171613.GJ25945@arm.com>
In-Reply-To: <20200624171613.GJ25945@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Jun 2020 20:23:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+Xh=a1exFXuRJ9EYbT+0xnC=votGGX1dmzBgZgEaC-w@mail.gmail.com>
Message-ID: <CAMj1kXG+Xh=a1exFXuRJ9EYbT+0xnC=votGGX1dmzBgZgEaC-w@mail.gmail.com>
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

On Wed, 24 Jun 2020 at 19:16, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, Jun 24, 2020 at 06:40:48PM +0200, Ard Biesheuvel wrote:
> > On Wed, 24 Jun 2020 at 18:29, Dave Martin <Dave.Martin@arm.com> wrote:
> > >
> > > On Wed, Jun 24, 2020 at 05:48:41PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 24 Jun 2020 at 17:45, Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Wed, Jun 24, 2020 at 05:31:06PM +0200, Ard Biesheuvel wrote:
> > > > > > On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > > > > > > > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > > > > > > > stub, given that it runs under the control of the firmware, with its
> > > > > > > > memory mappings and PAC configuration etc.
> > > > > > >
> > > > > > > Is BTI being ignored when the firmware runs?
> > > > > >
> > > > > > Given that it requires the 'guarded' attribute to be set in the page
> > > > > > tables, and the fact that the UEFI spec does not require it for
> > > > > > executables that it invokes, nor describes any means of annotating
> > > > > > such executables as having been built with BTI annotations, I think we
> > > > > > can safely assume that the EFI stub will execute with BTI disabled in
> > > > > > the foreseeable future.
> > > > >
> > > > > yaaaaaay. *sigh* How long until EFI catches up?
> > > > >
> > > > > That said, BTI shouldn't _hurt_, right? If EFI ever decides to enable
> > > > > it, we'll be ready?
> > > > >
> > > >
> > > > Sure. Although I anticipate that we'll need to set some flag in the
> > > > PE/COFF header to enable it, and so any BTI opcodes we emit without
> > > > that will never take effect in practice.
> > >
> > > In the meantime, it is possible to build all the in-tree parts of EFI
> > > for BTI, and just turn it off for out-of-tree EFI binaries?
> > >
> >
> > Not sure I understand the question. What do you mean by out-of-tree
> > EFI binaries? And how would the firmware (which is out of tree itself,
> > and is in charge of the page tables, vector table, timer interrupt etc
> > when the EFI stub executes) distinguish such binaries from the EFI
> > stub?
>
> I'm not an EFI expert, but I'm guessing that you configure EFI with
> certain compiler flags and build it.

'EFI' is not something you build. It is a specification that describes
how a conformant firmware implementation interfaces with a conformant
OS.

Sorry to be pedantic, but that is really quite relevant. By adhering
to the EFI spec rigorously, we no longer have to care about who
implements the opposite side, and how.

So yes, of course there are ways to build the opposite side with BTI
enabled, in a way that all its constituent pieces keep working as
expected. A typical EDK2 based implementation of EFI consists of
50-100 individual PE/COFF executables that all get loaded, relocated
and started like ordinary user space programs.

What we cannot do, though, is invent our own Linux specific way of
decorating the kernel's PE/COFF header with an annotation that
instructs a Linux specific EFI loader when to enable the GP bit for
the .text pages.

> Possibly some standalone EFI
> executables are built out of the same tree and shipped with the
> firmware from the same build, but I'm speculating.  If not, we can just
> run all EFI executables with BTI off.
>
> > > If there's no easy way to do this though, I guess we should wait for /
> > > push for a PE/COFF flag to describe this properly.
> > >
> >
> > Yeah good point. I will take this to the forum.
>
> In the interim, we could set the GP bit in EFI's page tables for the
> executable code from the firmware image if we want this protection, but
> turn it off in pages mapping the executable code of EFI executables.
> This is better than nothing.
>

We need to distinguish between the EFI stub and the EFI runtime services here.

The EFI stub consists of kernel code that executes in the context of
the firmware, at which point the loader has no control whatsoever over
page tables, vector tables, etc. This is the stage where the loading
and starting of PE/COFF images takes place. If we want to enable BTI
for code running in this context, we need PE/COFF annotations, as
discussed above.

The EFI runtime services are firmware code that gets invoked by the OS
at runtime. Whether or not such code is emitted with BTI annotations
is a separate matter (but should also be taken to the forum
nonetheless), and does not need any changes at the PE/COFF level.
However, for this code, I'd like the sandboxing to be much more
rigorous than it is today, to the point where the security it provides
doesn't even matter deeply to the OS itself. (I had some patches a
while ago that reused the KPTI infrastructure to unmap the entire
kernel while EFI runtime services are in progress. There was also an
intern in the team that implemented something similar on top of KVM)

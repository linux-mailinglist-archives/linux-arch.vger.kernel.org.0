Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3B207954
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbgFXQlB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 12:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404160AbgFXQlB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 12:41:01 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876E620899;
        Wed, 24 Jun 2020 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593016860;
        bh=uvjYsXkxFUGkhiFTCWXt307TvMmTMTKMKbqCMztuBls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bZztcT5WZ5MWC+ENbrUuPlioKE8O69UkCFRfGBeqlJTX3EqNO3n8zbzUkG2tfbd7l
         Kk3R7Efk7d6uJ43rzh0HLhfKa41sehWsbY6fJ5h/uZ8zqj99vlgOGvkQopY6v/rWCv
         cXQgJ1FpRA7WmN9YaTBpWM6GygRlILWvZMyCZqyA=
Received: by mail-oi1-f181.google.com with SMTP id x202so2364920oix.11;
        Wed, 24 Jun 2020 09:41:00 -0700 (PDT)
X-Gm-Message-State: AOAM532xcTdTOuecIR3ScaGbj6IsNUcHCKOVaqcPNA3q95N/w7zubqEd
        tO2Vu7Gxj/+oJlYQY9sqi7IPDN1F0idcVgZWmEE=
X-Google-Smtp-Source: ABdhPJyiNUJDNwC86vdpWulA3iT8f/D6K0b5Na/cqZCLSt9K49BUN6iDAZ8XtMicFhbdB0vwidSCBWPLhDa7Wo4++f4=
X-Received: by 2002:aca:b241:: with SMTP id b62mr19900869oif.47.1593016859864;
 Wed, 24 Jun 2020 09:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org> <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook> <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <202006240820.A3468F4@keescook> <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
 <202006240844.7BE48D2B5@keescook> <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
 <20200624162919.GH25945@arm.com>
In-Reply-To: <20200624162919.GH25945@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Jun 2020 18:40:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE1zWCjVt8iS4fv2gQHzrTF6=Ggd16nm+4TNWAG3zSWAQ@mail.gmail.com>
Message-ID: <CAMj1kXE1zWCjVt8iS4fv2gQHzrTF6=Ggd16nm+4TNWAG3zSWAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 at 18:29, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, Jun 24, 2020 at 05:48:41PM +0200, Ard Biesheuvel wrote:
> > On Wed, 24 Jun 2020 at 17:45, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Jun 24, 2020 at 05:31:06PM +0200, Ard Biesheuvel wrote:
> > > > On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > > > > > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > > > > > stub, given that it runs under the control of the firmware, with its
> > > > > > memory mappings and PAC configuration etc.
> > > > >
> > > > > Is BTI being ignored when the firmware runs?
> > > >
> > > > Given that it requires the 'guarded' attribute to be set in the page
> > > > tables, and the fact that the UEFI spec does not require it for
> > > > executables that it invokes, nor describes any means of annotating
> > > > such executables as having been built with BTI annotations, I think we
> > > > can safely assume that the EFI stub will execute with BTI disabled in
> > > > the foreseeable future.
> > >
> > > yaaaaaay. *sigh* How long until EFI catches up?
> > >
> > > That said, BTI shouldn't _hurt_, right? If EFI ever decides to enable
> > > it, we'll be ready?
> > >
> >
> > Sure. Although I anticipate that we'll need to set some flag in the
> > PE/COFF header to enable it, and so any BTI opcodes we emit without
> > that will never take effect in practice.
>
> In the meantime, it is possible to build all the in-tree parts of EFI
> for BTI, and just turn it off for out-of-tree EFI binaries?
>

Not sure I understand the question. What do you mean by out-of-tree
EFI binaries? And how would the firmware (which is out of tree itself,
and is in charge of the page tables, vector table, timer interrupt etc
when the EFI stub executes) distinguish such binaries from the EFI
stub?


> If there's no easy way to do this though, I guess we should wait for /
> push for a PE/COFF flag to describe this properly.
>

Yeah good point. I will take this to the forum.

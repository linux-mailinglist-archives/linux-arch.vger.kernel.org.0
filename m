Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483E2BBDD8
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgKUHfq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Nov 2020 02:35:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgKUHfp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 21 Nov 2020 02:35:45 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A43012224A;
        Sat, 21 Nov 2020 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605944144;
        bh=JIOyIP3Z1qYK7PEjNX1ygOHQ10RRXlMdlRpxuOVqaF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBoERCzx0bOfs1Spi/qI4Jr4R9gR8nafDvLzNl5y954yhL+AaVOlArn46YJkANI7T
         7abJYj5XFHRgl30rA/lbg/rqlMovYayapPUq/NdCriwpLmDqbHGPoFB/SLz/cLTFne
         1lltJvXcAoTRU2aCkyn4SJsnZCZs0Biim543HgXo=
Received: by mail-oi1-f177.google.com with SMTP id c80so13347823oib.2;
        Fri, 20 Nov 2020 23:35:44 -0800 (PST)
X-Gm-Message-State: AOAM533XGJRslAI2T+3QpkpO+RvNRSTokXUTYapch7qFcAvRgtNw5gjL
        pF3r1REgFKT6pLRKz68m5wAup7lQ0Now8fP87ps=
X-Google-Smtp-Source: ABdhPJx40jOdwbcNKyqzBINwkmCmwPpkhWi97MwgNpvEdbPfdyMgPT4NA53Xt6JomdsOtV9RsBYuyUMJZVUA9Le699M=
X-Received: by 2002:aca:d4d5:: with SMTP id l204mr7701517oig.174.1605944144026;
 Fri, 20 Nov 2020 23:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com>
 <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
 <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com>
 <CAMj1kXEoPEd6GzjL1XuxTPwitbR03BiBEXpAGtUytMj-h=vCkg@mail.gmail.com> <CAKwvOdmk1D0dLDOHEWX=jHpUxUT2JbwgnF62Qv3Rv=coNPadHg@mail.gmail.com>
In-Reply-To: <CAKwvOdmk1D0dLDOHEWX=jHpUxUT2JbwgnF62Qv3Rv=coNPadHg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 21 Nov 2020 08:35:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTtXqssica=ADMOrA+7mhBQv=nGBsR-XR0+LAKk_-dWA@mail.gmail.com>
Message-ID: <CAMj1kXHTtXqssica=ADMOrA+7mhBQv=nGBsR-XR0+LAKk_-dWA@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 21 Nov 2020 at 00:53, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Nov 20, 2020 at 3:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 20 Nov 2020 at 21:19, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Nov 20, 2020 at 2:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > >
> > > > > Thanks for continuing to drive this series Sami.  For the series,
> > > > >
> > > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > >
> > > > > I did virtualized boot tests with the series applied to aarch64
> > > > > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
> > > > > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
> > > > > please drop my tested by tag from the modified patches and I'll help
> > > > > re-test.  Some minor feedback on the Kconfig change, but I'll post it
> > > > > off of that patch.
> > > > >
> > > >
> > > > When you say 'virtualized" do you mean QEMU on x86? Or actual
> > > > virtualization on an AArch64 KVM host?
> > >
> > > aarch64 guest on x86_64 host.  If you have additional configurations
> > > that are important to you, additional testing help would be
> > > appreciated.
> > >
> >
> > Could you run this on an actual phone? Or does Android already ship
> > with this stuff?
>
> By `this`, if you mean "the LTO series", it has been shipping on
> Android phones for years now, I think it's even required in the latest
> release.
>
> If you mean "the LTO series + mainline" on a phone, well there's the
> android-mainline of https://android.googlesource.com/kernel/common/,
> in which this series was recently removed in order to facilitate
> rebasing Android's patches on ToT-mainline until getting the series
> landed upstream.  Bit of a chicken and the egg problem there.
>
> If you mean "the LTO series + mainline + KVM" on a phone; I don't know
> the precise state of aarch64 KVM and Android (Will or Marc would
> know).  We did experiment recently with RockPI's for aach64 KVM, IIRC;
> I think Android is tricky as it still requires A64+A32/T32 chipsets,
> Alistair would know more.  Might be interesting to boot a virtualized
> (or paravirtualized?) guest built with LTO in a host built with LTO
> for sure, but I don't know if we have tried that yet (I think we did
> try LTO guests of android kernels, but I think they were on the stock
> RockPI host BSP image IIRC).
>

I don't think testing under KVM gives us more confidence or coverage
than testing on bare metal. I was just pointing out that 'virtualized'
is misleading, and if you test things under QEMU/x86 + TCG, it is
better to be clear about this, and refer to it as 'under emulation'.

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7608B2BBA31
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 00:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgKTXap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 18:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKTXap (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Nov 2020 18:30:45 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E21D92240B;
        Fri, 20 Nov 2020 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605915044;
        bh=pAOPOCc79X5vSW6IJcHVGfCdHUlnqpSzr+lv+zQxwCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RZzdH79P6J5urfJDjwQdKxx5LnTEOmSru+Pngr2whnPMGGF/5iys8b3oGoRp3fiC2
         B9zPEK+hV1YvwzBAM2H5HZymjsteXPWwOamkRpmbJpb2YTeAXwp7dY7auSdWBrz/F2
         /N80r04AHKKCoaM6D2sPwvKPyEcCtIgwahDH+KeA=
Received: by mail-oi1-f171.google.com with SMTP id a130so4261361oif.7;
        Fri, 20 Nov 2020 15:30:43 -0800 (PST)
X-Gm-Message-State: AOAM533pXk4s93Kp6xS5SPeBjmQHE6F7HrGLtTmGW9MvJrhvPJEB/PXB
        Igq2Kgez7AHQx295Eujy15HDa2XxY6dtvlnIMBk=
X-Google-Smtp-Source: ABdhPJydXVeIwFrz87ExsApybJ0EuK40nIe6165egNvLnhUN+I4Xd9fvkCEU5QPaIxetxiAiYULX8LNHUT5DTI1cr7A=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr8196235oib.33.1605915043305;
 Fri, 20 Nov 2020 15:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com>
 <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com> <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 21 Nov 2020 00:30:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEoPEd6GzjL1XuxTPwitbR03BiBEXpAGtUytMj-h=vCkg@mail.gmail.com>
Message-ID: <CAMj1kXEoPEd6GzjL1XuxTPwitbR03BiBEXpAGtUytMj-h=vCkg@mail.gmail.com>
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

On Fri, 20 Nov 2020 at 21:19, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Nov 20, 2020 at 2:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Thanks for continuing to drive this series Sami.  For the series,
> > >
> > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > > I did virtualized boot tests with the series applied to aarch64
> > > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
> > > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
> > > please drop my tested by tag from the modified patches and I'll help
> > > re-test.  Some minor feedback on the Kconfig change, but I'll post it
> > > off of that patch.
> > >
> >
> > When you say 'virtualized" do you mean QEMU on x86? Or actual
> > virtualization on an AArch64 KVM host?
>
> aarch64 guest on x86_64 host.  If you have additional configurations
> that are important to you, additional testing help would be
> appreciated.
>

Could you run this on an actual phone? Or does Android already ship
with this stuff?


> >
> > The distinction is important here, given the potential impact of LTO
> > on things that QEMU simply does not model when it runs in TCG mode on
> > a foreign host architecture.
>
> --
> Thanks,
> ~Nick Desaulniers

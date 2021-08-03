Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177413DEDB3
	for <lists+linux-arch@lfdr.de>; Tue,  3 Aug 2021 14:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhHCMPv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Aug 2021 08:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhHCMPt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Aug 2021 08:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B875160F56;
        Tue,  3 Aug 2021 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627992938;
        bh=YFyNorBzvHKd2LCdkw4zsM+gAMFMoZIoTqWAAptOfkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J4vot0vAmpIzv0uaEowWDkSGSknUbFG2w0ls6kn5sjZyCbGTHTXgcxzCDuA+/DRfn
         s3YvkZ+d4b/xyx3I4Ky5pOJC8c4gon3eKy84lrQJRTRwwWV3/LGIwU+m5yumygPvjm
         X6wlzVEY2QguuhaJCRmb/ATxyutApfmj+fMkdBs2ANSw9IzKEnn0tpS8QC09+kQj91
         4WO/E05vUbAdhpe5vJ1IHu7wSEs7tAhspeZz2RZqzTBACbgqbOGiRio8lb1y2yV2Cc
         NrGYvszcFaG4Wvpe0qhVYxOQB/gdnc78HprwXKly/XXbanIBswJBWR711f0SQ/R0Mi
         q3X4QTrD5sYgQ==
Received: by mail-wr1-f52.google.com with SMTP id p5so25102293wro.7;
        Tue, 03 Aug 2021 05:15:38 -0700 (PDT)
X-Gm-Message-State: AOAM5301wUk4NkN88MBRUUwQhUyH3WXltxrl95d8JVTsNKqwVwSq35CM
        1GaC1eZpnL+KKyXnEnPcltJj3tUM34o03hnRNkg=
X-Google-Smtp-Source: ABdhPJxAL8VftAhgCQ+bSLKaGZHOswlreW4hRX79bjyzo5amawkDoDYbsyb2ih3hosWG3M6soO1UgGXpHIPbXlBIBik=
X-Received: by 2002:adf:e107:: with SMTP id t7mr22741611wrz.165.1627992937364;
 Tue, 03 Aug 2021 05:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
In-Reply-To: <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 3 Aug 2021 14:15:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
Message-ID: <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     John Garry <john.garry@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 3, 2021 at 1:23 PM John Garry <john.garry@huawei.com> wrote:
> > so I'm just not building those drivers any more, and not
> > defining the inb()/outb() helpers either, causing a build failure when I'm
> > missing an option.
> >
> > However it sounds like you are interested in a third option here, which
> > brings us to:
> >
> > LEGACY_PCI: any PCI driver that uses inb()/outb() or is only available
> >      on old-style PCI but not PCIe hardware without a bridge.
> >      To be disabled for most architectures and possibly distros but can
> >      be enabled for kernels that want to use those devices, as long as
> >      CONFIG_HAS_IOPORT is set by the architecture.
> >
> > HAS_IOPORT: not a legacy PCI device, but can only be built on
> >      architectures that define inb()/outb(). To be disabled for s390
> >      and any other machine that has no useful definition of those
> >      functions.
>
> That seems reasonable. And asm-generic io.h should be ifdef'ed by
> HAS_IOPORT. In your patch you had it under CONFIG_IOPORT - was that
> intentional?

No, that was a typo. Thanks for pointing this out.

> On another point, I noticed SCSI driver AHA152x depends on ISA, but is
> not an isa driver - however it does use port IO. Would such dependencies
> need to be changed to depend on HAS_IOPORT?

I'm not sure what you mean here. As far as I can tell, AHA152x is an ISA
driver in the sense that it is a driver for ISA add-on cards. However, it
is not a 'struct isa_driver' in the sense that AHA1542 is, AHA152x  is even
older and uses the linux-2.4 style initialization using a module_init()
function that does the probing.

> I did notice that arm32 support CONFIG_ISA - not sure why.

This is for some of the earlier machines we support:
mach-footbridge has some on-board ISA components, while
SA1100, PXA25x and S3C2410 each have at least one machine
with a PC/104 connector using ISA signaling for add-on cards.

There are also a couple of platforms with PCMCIA or CF slots
using the same ISA style I/O signals, but those have separate
drivers.

> > HARDCODED_IOPORT: (or another name you might think of,) Used by
> >     drivers that unconditionally do inb()/outb() without checking the
> >     validity of the address using firmware or other methods first.
> >     depends on HAS_IOPORT and possibly architecture specific
> >     settings.
>
> Yeah, that sounds the same as what I was thinking. Maybe IOPORT_NATIVE
> could work as a name. I would think that only x86/ia64 would define it.
> A concern though is that someone could argue that is a functional
> dependency, rather than just a build dependency.

You can have those on a number of platforms, such as early
PowerPC CHRP or pSeries systems, a number of MIPS workstations
including recent Loongson machines, and many Alpha platforms.

Maybe the name should reflect that these all use PC-style ISA/LPC
port numbers without the ISA connectors.

       Arnd

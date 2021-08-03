Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2E3DEA6E
	for <lists+linux-arch@lfdr.de>; Tue,  3 Aug 2021 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhHCKHF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Aug 2021 06:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235311AbhHCKGl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Aug 2021 06:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FEB161037;
        Tue,  3 Aug 2021 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627985190;
        bh=amKFWwxpJKw04QvdgzwXcqsqQ+F/NFHyOuqZIXDbk1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjEoXzfxmIrUj6YEyI/1nn/bFs2XN+/1xIOKmEHh0ZliMJ5miWSi+KFFZIRV3i7G2
         FBrJg3xGZEemgh0lmKXUutXASdMU7DRx9DckTewzZjBLWp8lRLMRMUSKGKuqcCKO+l
         ywlbG/UOew23gdqMNVJAxev4x7DpcgrR/mzQCI5/+dKHpgKqkUE+Na3I3u+kLYkjtX
         i7/fC/yZfwtjd0GzE8BnThUGq2RudTGu5crO5cEWqVvtHEJtMfwwbOno3XDsozhmOW
         KL5VuuEoYMgqxbSYgNBVZlbXHbiix9eK5dS/jUIJeg3C+Rwmm3iFECfc3wGbsjWa+I
         jwqXueqQa3flg==
Received: by mail-wr1-f44.google.com with SMTP id h14so24656967wrx.10;
        Tue, 03 Aug 2021 03:06:29 -0700 (PDT)
X-Gm-Message-State: AOAM531A7mScJe+/xPVmNxqueEODpJTRthL+CSgYUTN+tombAV3UEeDh
        3I1G4HQ9haAkq3D/ZZwCdieaWY7b7spDR1L2NkY=
X-Google-Smtp-Source: ABdhPJzwT+J+VFXSnW3+4tMTTqosPNaK30l2tA5qRE27wNMPCM24C2S98cstSFdgN7ZgaXO1ODqphFr5sTVPXXlD+B8=
X-Received: by 2002:adf:e107:: with SMTP id t7mr22121083wrz.165.1627985188658;
 Tue, 03 Aug 2021 03:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com> <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
In-Reply-To: <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 3 Aug 2021 12:06:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
Message-ID: <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
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

On Tue, Aug 3, 2021 at 11:46 AM John Garry <john.garry@huawei.com> wrote:
> On 05/07/2021 11:06, Arnd Bergmann wrote:

> >
> > Linus, if you like this approach, then I can work on splitting it up into
> > meaningful patches and submit it for a future release. I think the
> > CONFIG_LEGACY_PCI option has value on its own, but the others
> > do introduce some churn.
> >
> > Full patch (120KB): https://pastebin.com/yaFSmAuY
> >
>
> Hi Arnd,
>
> I am not sure if anything is happening here.

No, I'm not currently working on this, though I have it applied to
my randconfig tree.

> Anyway, one thing I mentioned earlier was that we could solve the
> problem of drivers accessing unmapped IO ports and crashing systems on
> archs which define PCI_IOBASE by building them under some "native port
> IO support" flag.

Right, that was part of the goal here.

> One example of such a driver was F71805F sensor. You put that under
> HAS_IOPORT, which would be available for all archs, I think. But I could
> not see where config LEGACY_PCI is introduced. Could we further refine
> that config to not build for such archs as arm64?
>
> BTW, I think that the PPC dependency was added there to stop building
> for power for that same reason, so hopefully we get rid of that.

Good point. It seems that I actually never added the LEGACY_PCI option
to my patch, so I'm just not building those drivers any more, and not
defining the inb()/outb() helpers either, causing a build failure when I'm
missing an option.

However it sounds like you are interested in a third option here, which
brings us to:

LEGACY_PCI: any PCI driver that uses inb()/outb() or is only available
    on old-style PCI but not PCIe hardware without a bridge.
    To be disabled for most architectures and possibly distros but can
    be enabled for kernels that want to use those devices, as long as
    CONFIG_HAS_IOPORT is set by the architecture.

HAS_IOPORT: not a legacy PCI device, but can only be built on
    architectures that define inb()/outb(). To be disabled for s390
    and any other machine that has no useful definition of those
    functions.

HARDCODED_IOPORT: (or another name you might think of,) Used by
   drivers that unconditionally do inb()/outb() without checking the
   validity of the address using firmware or other methods first.
   depends on HAS_IOPORT and possibly architecture specific
   settings.

        Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B43565B0
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbhDGHqd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 03:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240787AbhDGHqa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 03:46:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 506F26139B;
        Wed,  7 Apr 2021 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617781581;
        bh=xFlb8XuCVKFs7yVEDsdkMeg3jdfQxp2CndWAV0U162E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORVDJjqJEXVocI7AShlkTTGMHVgJqicsVwmudrbkIDeG4Fh8LOtzm931wbly02wsZ
         VaozEwnhlPONZTjFGAIbLCDedC4ilE3zRir+XMVUrLqkVDFt+lpApFHdoy+9e3MRay
         cIviO2Gbnx3GEKnikUyoqftydQXuqtgxgNjBPZOo=
Date:   Wed, 7 Apr 2021 09:46:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 00/20] kbuild: unify the install.sh script usage
Message-ID: <YG1jSj7BiDscHBhz@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 09:18:11AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> Thanks for your series!
> 
> On Wed, Apr 7, 2021 at 7:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Almost every architecture has copied the "install.sh" script that
> > originally came with i386, and modified it in very tiny ways.  This
> > patch series unifies all of these scripts into one single script to
> > allow people to understand how to correctly install a kernel, and fixes
> > up some issues regarding trying to install a kernel to a path with
> > spaces in it.
> >
> > Note that not all architectures actually seem to have any type of way to
> > install a kernel, they must rely on external scripts or tools which
> > feels odd as everything should be included here in the main repository.
> > I'll work on trying to figure out the missing architecture issues
> > afterward.
> 
> I'll bite ;-)
> 
> Does anyone actually use these scripts (outside of x86)?

I think so, if not then what do they use?

Ok, I'll answer that, Before this week, I used my own script, a horrible
hack I've drug along for years:
	https://github.com/gregkh/gregkh-linux/blob/master/scripts/install

but for almost everyone else, they just use /sbin/installkernel that is
provided by their distro.  But this feels really odd given that we
should include the logic to install the kernel in the kernel source
itself, otherwise everyone has to rely on an external package that no
one knows where it is.

> I assume the architectures that have them, only have them because they
> were copied from x86 while doing the initial ports ("oh, a file I don't
> have to modify at all.").
> But installing the kernel can be very platform-specific.
> Do you need the vmlinux, vmlinux.gz, Image, zImage, uImage, ...?
> With separate or appended DTB?

That seems handled already by the arch/ARCH/boot/Makefile logic today,
so I do not think we need to change that.

> Even on x86, the script will bail out with "Cannot find LILO." if you're
> using Grub.

The last change in this series tries to "soften" that language so that
isn't really an issue anymore.

I want to turn this into something that everyone can use, so we do not
have to rely on distro-specific or other external programs, as trying to
explain how to install a kernel to someone new to kernel development is
a real pain.

> Anyway, having less of them is good.

Agreed, thanks for the review :)

greg k-h

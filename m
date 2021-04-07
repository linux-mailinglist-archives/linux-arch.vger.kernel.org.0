Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE0356610
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhDGIHn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 04:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhDGIHm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 04:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A359561222;
        Wed,  7 Apr 2021 08:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617782852;
        bh=Roc1pgXNiDFIxi3O+PozBhZj0RIUUb4b0E+76uwfL+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/ZOIOuxBLriRB2gjvcoIn/zscjIlzFfL7/xqXUwGYF2cb3/hdlSfpAIsgT/rxO92
         0Ksu+szp80r5k586GtP9bXqJfy3n37LDwrlz5+NNj1J454phfDTLcFpwMlCwZEVfC8
         fV5cGIhEj62KjrmV93OMnQosMjI90IHLASV3vBKc=
Date:   Wed, 7 Apr 2021 10:07:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 00/20] kbuild: unify the install.sh script usage
Message-ID: <YG1oQRc1ayGEI+4G@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
 <YG1jSj7BiDscHBhz@kroah.com>
 <20210407080229.GF1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407080229.GF1463@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 09:02:29AM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Apr 07, 2021 at 09:46:18AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 07, 2021 at 09:18:11AM +0200, Geert Uytterhoeven wrote:
> > > Hi Greg,
> > > 
> > > Thanks for your series!
> > > 
> > > On Wed, Apr 7, 2021 at 7:34 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > Almost every architecture has copied the "install.sh" script that
> > > > originally came with i386, and modified it in very tiny ways.  This
> > > > patch series unifies all of these scripts into one single script to
> > > > allow people to understand how to correctly install a kernel, and fixes
> > > > up some issues regarding trying to install a kernel to a path with
> > > > spaces in it.
> > > >
> > > > Note that not all architectures actually seem to have any type of way to
> > > > install a kernel, they must rely on external scripts or tools which
> > > > feels odd as everything should be included here in the main repository.
> > > > I'll work on trying to figure out the missing architecture issues
> > > > afterward.
> > > 
> > > I'll bite ;-)
> > > 
> > > Does anyone actually use these scripts (outside of x86)?
> 
> Yes, every time I build a kernel. My kernel build system involves
> typing "kbuild <flags> <dirname> <machines...>" and the kernel gets
> built in ../build/<dirname>. When the build completes, it gets
> installed into ~/systems/<dirname>, tar'd up, and copied to the
> destination machines, unpacked, installed as appropriate, and
> the machine rebooted if requested.
> 
> The installation step is done via the ~/bin/installkernel script.

So you don't use install.sh at all except to invoke your local script.

> > > I assume the architectures that have them, only have them because they
> > > were copied from x86 while doing the initial ports ("oh, a file I don't
> > > have to modify at all.").
> > > But installing the kernel can be very platform-specific.
> > > Do you need the vmlinux, vmlinux.gz, Image, zImage, uImage, ...?
> > > With separate or appended DTB?
> 
> My scripts deal with all that.
> 
> However, I haven't been able to review the changes that are being
> made because I have no visibility of the common "scripts" version.
> Provided it offers exactly the same functionality as the arm32
> version, I'm happy. If it doesn't, it may cause a regression, and
> I will be reporting that.

It should be identical, if I got something wrong please let me know.

thanks,

greg k-h

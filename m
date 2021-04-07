Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690263565FF
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhDGIDk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbhDGIDO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 04:03:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6CC06174A;
        Wed,  7 Apr 2021 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FtILCfoLF0UZixMuOcOcD/m4x0f7qbhL078nTs2OvLw=; b=EHgAM7D64tJ5H2T06ysAWOqVK
        ninH/ePokltqElSHFbDu9UwzCvmp7Zh4jCgUfj7Ygaycln8L/EXZ53vln1bjKFjPXOZv2YKawkXYD
        rs9/n1F8stzy1PiyMOc2+4W/5x3LiOJPRTxkbEgAOPIk9jUgALEtuAtfNHywGmPzHSkkOn/8/V9I0
        WL13yhvt++ZgV2V6a0n6acN6RDqsWDWoxaUwP+1jvTV9t148y+t4D0XKhPZNAYj9W7ayVl0STnke6
        nodUqLpZxCKUnqyY9bCBzcnCREbt37ECXEh7ktE08QgdzpCvJtEY/BOTvfC1V6bgVRlGPv5gxNYBR
        Ep4xwzCmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52176)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lU395-00083f-Sl; Wed, 07 Apr 2021 09:02:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lU38v-0001or-Cw; Wed, 07 Apr 2021 09:02:29 +0100
Date:   Wed, 7 Apr 2021 09:02:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20210407080229.GF1463@shell.armlinux.org.uk>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
 <YG1jSj7BiDscHBhz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1jSj7BiDscHBhz@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 09:46:18AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 07, 2021 at 09:18:11AM +0200, Geert Uytterhoeven wrote:
> > Hi Greg,
> > 
> > Thanks for your series!
> > 
> > On Wed, Apr 7, 2021 at 7:34 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > Almost every architecture has copied the "install.sh" script that
> > > originally came with i386, and modified it in very tiny ways.  This
> > > patch series unifies all of these scripts into one single script to
> > > allow people to understand how to correctly install a kernel, and fixes
> > > up some issues regarding trying to install a kernel to a path with
> > > spaces in it.
> > >
> > > Note that not all architectures actually seem to have any type of way to
> > > install a kernel, they must rely on external scripts or tools which
> > > feels odd as everything should be included here in the main repository.
> > > I'll work on trying to figure out the missing architecture issues
> > > afterward.
> > 
> > I'll bite ;-)
> > 
> > Does anyone actually use these scripts (outside of x86)?

Yes, every time I build a kernel. My kernel build system involves
typing "kbuild <flags> <dirname> <machines...>" and the kernel gets
built in ../build/<dirname>. When the build completes, it gets
installed into ~/systems/<dirname>, tar'd up, and copied to the
destination machines, unpacked, installed as appropriate, and
the machine rebooted if requested.

The installation step is done via the ~/bin/installkernel script.

> > I assume the architectures that have them, only have them because they
> > were copied from x86 while doing the initial ports ("oh, a file I don't
> > have to modify at all.").
> > But installing the kernel can be very platform-specific.
> > Do you need the vmlinux, vmlinux.gz, Image, zImage, uImage, ...?
> > With separate or appended DTB?

My scripts deal with all that.

However, I haven't been able to review the changes that are being
made because I have no visibility of the common "scripts" version.
Provided it offers exactly the same functionality as the arm32
version, I'm happy. If it doesn't, it may cause a regression, and
I will be reporting that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

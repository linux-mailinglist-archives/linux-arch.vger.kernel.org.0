Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B501735FA17
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351098AbhDNRv3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 13:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351076AbhDNRv3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 13:51:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEFD06121E;
        Wed, 14 Apr 2021 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618422667;
        bh=L91rvimOeNnMBAtgfvMuBl6PMf48osTpkcfJfYNf/Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bv2bVc7Gww8cnl36F7mCL0FIsBbV7kyaEA4yN0zHeaZpLhkI18bnDMmBt/1kHBVDs
         Y38NL4scoLwrcgzAoWLF/iW4/xpg4EcH3894Yj6C3jkM6uxESyk+HFU+mWju6aX+Ue
         ndRXQh7l+5zR0fibHPNVAB0BB7J/PVW0l/fJPNuo=
Date:   Wed, 14 Apr 2021 19:51:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 15/20] kbuild: parisc: use common install script
Message-ID: <YHcriObDPauSbfYd@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-16-gregkh@linuxfoundation.org>
 <CAK7LNATkQfwqr9-G5KwGmWDeG81Wn0eb3ZVxopJjxCq18S28=Q@mail.gmail.com>
 <5e16a94b-7383-3ec5-949f-f4c5d2c812f5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e16a94b-7383-3ec5-949f-f4c5d2c812f5@gmx.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 14, 2021 at 06:30:59PM +0200, Helge Deller wrote:
> On 4/7/21 1:23 PM, Masahiro Yamada wrote:
> > On Wed, Apr 7, 2021 at 2:34 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > The common scripts/install.sh script will now work for parisc, all that
> > > is needed is to add the compressed image type to it.  So add that file
> > > type check, and then we can remove the two different copies of the
> > > parisc install.sh script that were only different by one line and have
> > > the arch call the common install script.
> > > 
> > > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > > Cc: Helge Deller <deller@gmx.de>
> > > Cc: linux-parisc@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >   arch/parisc/Makefile        |  4 +--
> > >   arch/parisc/boot/Makefile   |  2 +-
> > >   arch/parisc/boot/install.sh | 65 ------------------------------------
> > >   arch/parisc/install.sh      | 66 -------------------------------------
> > >   scripts/install.sh          |  1 +
> > >   5 files changed, 4 insertions(+), 134 deletions(-)
> > >   delete mode 100644 arch/parisc/boot/install.sh
> > >   delete mode 100644 arch/parisc/install.sh
> > > 
> > > diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> > > index 7d9f71aa829a..296d8ab8e2aa 100644
> > > --- a/arch/parisc/Makefile
> > > +++ b/arch/parisc/Makefile
> > > @@ -164,10 +164,10 @@ vmlinuz: vmlinux
> > >   endif
> > > 
> > >   install:
> > > -       $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> > > +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh \
> > >                          $(KERNELRELEASE) vmlinux System.map "$(INSTALL_PATH)"
> > >   zinstall:
> > > -       $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> > > +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh \
> > >                          $(KERNELRELEASE) vmlinuz System.map "$(INSTALL_PATH)"
> > > 
> > >   CLEAN_FILES    += lifimage
> > > diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
> > > index 61f44142cfe1..ad2611929aee 100644
> > > --- a/arch/parisc/boot/Makefile
> > > +++ b/arch/parisc/boot/Makefile
> > > @@ -17,5 +17,5 @@ $(obj)/compressed/vmlinux: FORCE
> > >          $(Q)$(MAKE) $(build)=$(obj)/compressed $@
> > > 
> > >   install: $(CONFIGURE) $(obj)/bzImage
> > > -       sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
> > > +       sh -x  $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/bzImage \
> > >                System.map "$(INSTALL_PATH)"
> > 
> > 
> > 
> > As far as I understood, there is no way to invoke this 'install' target
> > in arch/parisc/boot/Makefile since everything is done
> > by arch/parisc/Makefile.
> > 
> > Can we remove this 'install' rule entirely?
> 
> Yes, I think it can go in arch/parisc/boot/Makefile.

It's already there today, so I'll delete the rule from
arch/parisc/Makefile in my next round.

thanks,

greg k-h

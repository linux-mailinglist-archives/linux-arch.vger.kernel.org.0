Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39E349A4F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCYTcm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 15:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhCYTcW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 15:32:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43EF861A39;
        Thu, 25 Mar 2021 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616700742;
        bh=wPQ5Sea1VKNbkcHcSE2wOkcPab+jTWd/uy3MX0n6t8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhPz13AMwoqBiPYoRSp+sOrqs8xLR1phPnSElfXaT3SrbfZRHiaZgO6D7YxgFZFFB
         oYa7bMFovpREENQs5jwQgUYDLkzu2gcrVCPDsaBy6SzeQvaW1qrofhoLHr6Wq6E1CS
         KMdfhVDAoQwH/bhQKHL6qSPnxH+MpGsDZdurCpwfuSeXSV6DGHtZ9Fdftq9PoXLTtS
         VR152Oo7hAfi8Zdxu/F1l7A4k8xXQKOqYBWtJAYNCqivBoeVVWU4ZgtKVn4Gt+lrBU
         bmmEoQwh5ps8MzGegpOwIpYOQNtaD7Lg+t46gFEMs2T6iX+7F6kF2hWshOdydJPQ3n
         9ZQrmixlOTDcA==
Date:   Thu, 25 Mar 2021 19:32:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com,
        robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/7] cmdline: Gives architectures opportunity to use
 generically defined boot cmdline manipulation
Message-ID: <20210325193216.GC16123@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <2eb6fad3470256fff5c9f33cd876f344abb1628b.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303175747.GD19713@willie-the-truck>
 <8db81511-3f28-4ef1-5e66-188cf7cafad1@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8db81511-3f28-4ef1-5e66-188cf7cafad1@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 25, 2021 at 12:18:38PM +0100, Christophe Leroy wrote:
> 
> 
> Le 03/03/2021 à 18:57, Will Deacon a écrit :
> > On Tue, Mar 02, 2021 at 05:25:22PM +0000, Christophe Leroy wrote:
> > > Most architectures have similar boot command line manipulation
> > > options. This patchs adds the definition in init/Kconfig, gated by
> > > CONFIG_HAVE_CMDLINE that the architectures can select to use them.
> > > 
> > > In order to use this, a few architectures will have to change their
> > > CONFIG options:
> > > - riscv has to replace CMDLINE_FALLBACK by CMDLINE_FROM_BOOTLOADER
> > > - architectures using CONFIG_CMDLINE_OVERRIDE or
> > > CONFIG_CMDLINE_OVERWRITE have to replace them by CONFIG_CMDLINE_FORCE.
> > > 
> > > Architectures also have to define CONFIG_DEFAULT_CMDLINE.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >   init/Kconfig | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 56 insertions(+)
> > > 
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 22946fe5ded9..a0f2ad9467df 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -117,6 +117,62 @@ config INIT_ENV_ARG_LIMIT
> > >   	  Maximum of each of the number of arguments and environment
> > >   	  variables passed to init from the kernel command line.
> > > +config HAVE_CMDLINE
> > > +	bool
> > > +
> > > +config CMDLINE_BOOL
> > > +	bool "Default bootloader kernel arguments"
> > > +	depends on HAVE_CMDLINE
> > > +	help
> > > +	  On some platforms, there is currently no way for the boot loader to
> > > +	  pass arguments to the kernel. For these platforms, you can supply
> > > +	  some command-line options at build time by entering them here.  In
> > > +	  most cases you will need to specify the root device here.
> > 
> > Why is this needed as well as CMDLINE_FROM_BOOTLOADER? IIUC, the latter
> > will use CONFIG_CMDLINE if it fails to get anything from the bootloader,
> > which sounds like the same scenario.
> > 
> > > +config CMDLINE
> > > +	string "Initial kernel command string"
> > 
> > s/Initial/Default
> > 
> > which is then consistent with the rest of the text here.
> > 
> > > +	depends on CMDLINE_BOOL
> > 
> > Ah, so this is a bit different and I don't think lines-up with the
> > CMDLINE_BOOL help text.
> > 
> > > +	default DEFAULT_CMDLINE
> > > +	help
> > > +	  On some platforms, there is currently no way for the boot loader to
> > > +	  pass arguments to the kernel. For these platforms, you can supply
> > > +	  some command-line options at build time by entering them here.  In
> > > +	  most cases you will need to specify the root device here.
> > 
> > (same stale text)
> > 
> > > +choice
> > > +	prompt "Kernel command line type" if CMDLINE != ""
> > > +	default CMDLINE_FROM_BOOTLOADER
> > > +	help
> > > +	  Selects the way you want to use the default kernel arguments.
> > 
> > How about:
> > 
> > "Determines how the default kernel arguments are combined with any
> >   arguments passed by the bootloader"
> > 
> > > +config CMDLINE_FROM_BOOTLOADER
> > > +	bool "Use bootloader kernel arguments if available"
> > > +	help
> > > +	  Uses the command-line options passed by the boot loader. If
> > > +	  the boot loader doesn't provide any, the default kernel command
> > > +	  string provided in CMDLINE will be used.
> > > +
> > > +config CMDLINE_EXTEND
> > 
> > Can we rename this to CMDLINE_APPEND, please? There is code in the tree
> > which disagrees about what CMDLINE_EXTEND means, so that will need be
> > to be updated to be consistent (e.g. the EFI stub parsing order). Having
> > the generic option with a different name means we won't accidentally end
> > up with the same inconsistent behaviours.
> 
> Argh, yes. Seems like the problem is even larger than that IIUC:
> 
> - For ARM it means to append the bootloader arguments to the CONFIG_CMDLINE
> - For Powerpc it means to append the CONFIG_CMDLINE to the bootloader arguments
> - For SH  it means to append the CONFIG_CMDLINE to the bootloader arguments
> - For EFI it means to append the bootloader arguments to the CONFIG_CMDLINE
> - For OF it means to append the CONFIG_CMDLINE to the bootloader arguments
> 
> So what happens on ARM for instance when it selects CONFIG_OF for instance ?

I think ARM gets different behaviour depending on whether it uses ATAGs or
FDT.

> Or should we consider that EXTEND means APPEND or PREPEND, no matter which ?
> Because EXTEND is for instance used for:
> 
> 	config INITRAMFS_FORCE
> 		bool "Ignore the initramfs passed by the bootloader"
> 		depends on CMDLINE_EXTEND || CMDLINE_FORCE

Oh man, I didn't spot that one :(

I think I would make the generic options explicit: either APPEND or PREPEND.
Then architectures which choose to define CMDLINE_EXTEND in their Kconfigs
can select the generic option that matches their behaviour.

INITRAMFS_FORCE sounds like it should depend on APPEND (assuming that means
CONFIG_CMDLINE is appended to the bootloader arguments).

Will

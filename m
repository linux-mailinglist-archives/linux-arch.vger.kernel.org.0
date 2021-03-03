Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7632C866
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 02:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhCDAtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 19:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381444AbhCCR6p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Mar 2021 12:58:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E84F664EF3;
        Wed,  3 Mar 2021 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614794273;
        bh=XiWtpvFdZtLasbYDnPMoaZrCEvuZWPwRJJFIHcVSAgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUNo++Truj2opgcatZeFPggIi0sEc4hm48HzynYHr4Tb1dQSG/rMPpJCFh1F7mP1A
         jm1WGw3A90IbuKwhndDReALRE/vt2Fi9mL8L80RYG3xwBoT3eo527n/A94oWV9yBi6
         CyZDO2YLDH50+Xh678C08XKF/KCebqKndgOZXxH1XMasvkgX0xfXrZqsfXaL0ZeX85
         JzsvLXbmZwus5a9gzm2whJem5b08bJvZZO8+pk5OnzthZojefUFQFlZgfxhomvISFJ
         tar+2wSsspQ8x3Jo5d85R99ALZZTaE4wc4w80RPvPPP7ox9yW2R6BjVysoHHwjMhAu
         LqpIZrYE5Lj9g==
Date:   Wed, 3 Mar 2021 17:57:47 +0000
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
Message-ID: <20210303175747.GD19713@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <2eb6fad3470256fff5c9f33cd876f344abb1628b.1614705851.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb6fad3470256fff5c9f33cd876f344abb1628b.1614705851.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 05:25:22PM +0000, Christophe Leroy wrote:
> Most architectures have similar boot command line manipulation
> options. This patchs adds the definition in init/Kconfig, gated by
> CONFIG_HAVE_CMDLINE that the architectures can select to use them.
> 
> In order to use this, a few architectures will have to change their
> CONFIG options:
> - riscv has to replace CMDLINE_FALLBACK by CMDLINE_FROM_BOOTLOADER
> - architectures using CONFIG_CMDLINE_OVERRIDE or
> CONFIG_CMDLINE_OVERWRITE have to replace them by CONFIG_CMDLINE_FORCE.
> 
> Architectures also have to define CONFIG_DEFAULT_CMDLINE.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  init/Kconfig | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 22946fe5ded9..a0f2ad9467df 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -117,6 +117,62 @@ config INIT_ENV_ARG_LIMIT
>  	  Maximum of each of the number of arguments and environment
>  	  variables passed to init from the kernel command line.
>  
> +config HAVE_CMDLINE
> +	bool
> +
> +config CMDLINE_BOOL
> +	bool "Default bootloader kernel arguments"
> +	depends on HAVE_CMDLINE
> +	help
> +	  On some platforms, there is currently no way for the boot loader to
> +	  pass arguments to the kernel. For these platforms, you can supply
> +	  some command-line options at build time by entering them here.  In
> +	  most cases you will need to specify the root device here.

Why is this needed as well as CMDLINE_FROM_BOOTLOADER? IIUC, the latter
will use CONFIG_CMDLINE if it fails to get anything from the bootloader,
which sounds like the same scenario.

> +config CMDLINE
> +	string "Initial kernel command string"

s/Initial/Default

which is then consistent with the rest of the text here.

> +	depends on CMDLINE_BOOL

Ah, so this is a bit different and I don't think lines-up with the
CMDLINE_BOOL help text.

> +	default DEFAULT_CMDLINE
> +	help
> +	  On some platforms, there is currently no way for the boot loader to
> +	  pass arguments to the kernel. For these platforms, you can supply
> +	  some command-line options at build time by entering them here.  In
> +	  most cases you will need to specify the root device here.

(same stale text)

> +choice
> +	prompt "Kernel command line type" if CMDLINE != ""
> +	default CMDLINE_FROM_BOOTLOADER
> +	help
> +	  Selects the way you want to use the default kernel arguments.

How about:

"Determines how the default kernel arguments are combined with any
 arguments passed by the bootloader"

> +config CMDLINE_FROM_BOOTLOADER
> +	bool "Use bootloader kernel arguments if available"
> +	help
> +	  Uses the command-line options passed by the boot loader. If
> +	  the boot loader doesn't provide any, the default kernel command
> +	  string provided in CMDLINE will be used.
> +
> +config CMDLINE_EXTEND

Can we rename this to CMDLINE_APPEND, please? There is code in the tree
which disagrees about what CMDLINE_EXTEND means, so that will need be
to be updated to be consistent (e.g. the EFI stub parsing order). Having
the generic option with a different name means we won't accidentally end
up with the same inconsistent behaviours.

> +	bool "Extend bootloader kernel arguments"

"Append to the bootloader kernel arguments"

> +	help
> +	  The default kernel command string will be appended to the
> +	  command-line arguments provided during boot.

s/provided during boot/provided by the bootloader/

> +
> +config CMDLINE_PREPEND
> +	bool "Prepend bootloader kernel arguments"

"Prepend to the bootloader kernel arguments"

> +	help
> +	  The default kernel command string will be prepend to the
> +	  command-line arguments provided during boot.

s/prepend/prepended/
s/provided during boot/provided by the bootloader/

> +
> +config CMDLINE_FORCE
> +	bool "Always use the default kernel command string"
> +	help
> +	  Always use the default kernel command string, even if the boot
> +	  loader passes other arguments to the kernel.
> +	  This is useful if you cannot or don't want to change the
> +	  command-line options your boot loader passes to the kernel.

I find the "This is useful if ..." sentence really confusing, perhaps just
remove it? I'd then tweak it to be:

  "Always use the default kernel command string, ignoring any arguments
   provided by the bootloader."

Will

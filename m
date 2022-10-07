Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563805F74AB
	for <lists+linux-arch@lfdr.de>; Fri,  7 Oct 2022 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJGHZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGHZt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 03:25:49 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15843F33E
        for <linux-arch@vger.kernel.org>; Fri,  7 Oct 2022 00:25:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id F37365803B5;
        Fri,  7 Oct 2022 03:25:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 03:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665127544; x=1665131144; bh=5yp7cK8z2w
        ckgRIwODaMRZ0O+A2ylXEpQNqfgEmK8D0=; b=nG0o8ehnmGGnzYvpEcgVqTrlLN
        LysbWx+IuHhBSGWZ56Sk0h/i9FrSJ0rVoF78qEDjn7kow4p/f2vzSGDS/scisLfh
        5vDhgctfw0yC5gQrkMwNc3Ec0HuLIg0OldeX/sfZuasVGPf9rmmjmIsh6ZXijH5d
        QUg1ofT/BIcSGmUoMx+u5NPgDa53Y7eLnF+b9gAaZ2xCkszoHLrmTH3kgjTu1vsO
        CDBUUm3Xeza47jChwUgelWm5BKIcwQzvO9KWxWH0j+iE8HQnaYcBeQqf2egaR5AY
        9OArJraHbpu8vilnqKhktd4a42Df7P89Nr0nAqVNSj91GC8Vb9NExKlCwLEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665127544; x=1665131144; bh=5yp7cK8z2wckgRIwODaMRZ0O+A2y
        lXEpQNqfgEmK8D0=; b=Y4ITtPibT0YvK8l7dq80g8lOXWBuU0RLZO8jJ0MDfm2b
        LmWJ1x3Ltis6/VdKU1j0yUKaD4ozrNyPL28NVUPguinajqGkU48zWp12SWMKw3UG
        rGBl+MucV9dfP4QcFJQZPsQ69Czsu0m1w3fZv29USkdwD/stOPLD7srgM5QAT/qw
        60zVFYRYF8S+XCgbfeopQth93pur1YelxPVmI08EUYMUx7sxdBNSfdUVvchl0asd
        1RCUGCSrY0LI1XINOzmSlNCVgdmabBHpIfwyziL6Ne5zjwAttJhNVXRfzt8NFvF1
        uKM7inF/UbaroGdVOUuiZo0wZzymLgizjr58totTMA==
X-ME-Sender: <xms:eNQ_Y2ejT0GekyS8WBmRwD41vD_4ZXJAIoS79iAi1S1kOrSdtBQgTQ>
    <xme:eNQ_YwM5oZh0eL96ZYaUnSF1vu6m1MqykUNRjn7518CcuZMWtTr7-UxZyZ7z7PQec
    7mFG_u395LDFekLRjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefg
    udfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eNQ_Y3hQAvYe7gvRCJFsuKRO-oAe_IrDW8S73kL5_c24X2A3L7QZKg>
    <xmx:eNQ_Yz9_y1aj1YLY1ySiw1ZfKgsBXv2xO2tta3EQRq8qqVGN_LE9Jw>
    <xmx:eNQ_YyuMT_VtigLLGbiPVJR5zSGvvBOU4CxsgSVZrL0oeHE3J7QeqQ>
    <xmx:eNQ_Y40E7HeEMVCg8QkeTc8cg1sMjZpJxFSX6D3-siyHhbBl5O90HQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D4C7B60086; Fri,  7 Oct 2022 03:25:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <2dca08bc-f743-4b97-adc0-3ebb13775178@app.fastmail.com>
In-Reply-To: <20221007034426.21713-1-palmer@rivosinc.com>
References: <20221007034426.21713-1-palmer@rivosinc.com>
Date:   Fri, 07 Oct 2022 09:25:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] arch, drivers: Add HAVE_IOREMAP_CACHE
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 7, 2022, at 5:44 AM, Palmer Dabbelt wrote:
> ioremap_cache() isn't recommended for portable drivers, but there's a
> handful of uses of it within the kernel.  This adds a HAVE_IOREMAP_CACHE
> Kconfig, which is enabled for the ports that have implemented it and
> added as a driver dependency when ioremap_cache() is uncoditionally
> called (a handful of drivers have arch-specific ifdefs already, those I
> left alone).
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> ---
>
> Not sure what to do about splitting this up, it touches a lot of trees
> but it seems saner to do this atomicly.  I've just included linux-arch
> for now, just to try and keep from blasting everyone.

Do you need this in 6.1? If not, I'm happy to just pick it up in
the asm-generic tree for 6.2.

> Another option
> here would be to add some sort of ioremap_cache() fallback, but I'm
> assuming that has not been done to discourage more use of
> ioremap_cache() in drivers.

I think we had a fallback in the past, or at least discussed it, but
since it's really incompatible with the uncached map, we probably don't
want that.

> I'm also not sure all these ports should have ioremap_cache(), but I
> figured it'd be easier to just enumerate what's there rather than trying
> to change the ports.  Preventing the drivers from compiling also seems
> like a pretty heavy hammer, as it seems like some of these could have
> their ioremap_cache() dependency removed pretty easily, but again I
> figured it'd be better to start small.

Agreed, makes sense.

> This has barely been tested, just a defconfig build on x86.  That's very
> much insufficient, but with this touching so many ports I figure it's
> better to let the autobuilders have at that.

Taking a look at the individual instances here, we don't have to
address them in the same patch.

> diff --git a/arch/Kconfig b/arch/Kconfig
> index f330410da63a..2b282fabde13 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -188,6 +188,9 @@ config USER_RETURN_NOTIFIER
>  	  Provide a kernel-internal notification when a cpu is about to
>  	  switch to user mode.
> 
> +config HAVE_IOREMAP_CACHE
> +	def_bool n
> +

This could use a help text that discourages adding it in more
places.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4c466acdc70d..c552fc97aad2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -223,6 +223,7 @@ config PPC
>  	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
>  	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && 
> HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
>  	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
> +	select HAVE_IOREMAP_CACHE
>  	select HAVE_IOREMAP_PROT
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KERNEL_GZIP

ioremap_cache() is used internally in powerpc, but not in any drivers
used on this architecture. As expected, all three uses are a bit odd,
and they all have missing __iomem annotations and don't use readl()
etc for accessing the cached areas. The crashdump code should clearly
use memremap(), no idea what the others are doing at all, probably
converting to memremap() would make them clearer.

> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 5f220e903e5a..bd9426cfc13b 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -37,6 +37,7 @@ config SUPERH
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_HW_BREAKPOINT
> +	select HAVE_IOREMAP_CACHE if MMU
>  	select HAVE_IOREMAP_PROT if MMU && !X2TLB
>  	select HAVE_KERNEL_BZIP2
>  	select HAVE_KERNEL_GZIP
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 12ac277282ba..edfa5127322c 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -42,6 +42,7 @@ config XTENSA
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS if GCC_VERSION >= 120000
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
> +	select HAVE_IOREMAP_CACHE
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_PCI
>  	select HAVE_PERF_EVENTS

I don't see any callers, so we could just drop the implementation
here entirely.

> diff --git a/drivers/firmware/meson/Kconfig 
> b/drivers/firmware/meson/Kconfig
> index f2fdd3756648..612ca9ad3256 100644
> --- a/drivers/firmware/meson/Kconfig
> +++ b/drivers/firmware/meson/Kconfig
> @@ -7,5 +7,6 @@ config MESON_SM
>  	depends on ARCH_MESON || COMPILE_TEST
>  	default y
>  	depends on ARM64_4K_PAGES
> +	depends on HAVE_IOREMAP_CACHE
>  	help
>  	  Say y here to enable the Amlogic secure monitor driver

This should use memremap()

> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index 79cb981ececc..e6b55cab5a4a 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -114,7 +114,7 @@ config MTD_SST25L
> 
>  config MTD_BCM47XXSFLASH
>  	tristate "Support for serial flash on BCMA bus"
> -	depends on BCMA_SFLASH && (MIPS || ARM)
> +	depends on BCMA_SFLASH && (MIPS || ARM) && HAVE_IOREMAP_CACHE
>  	help
>  	  BCMA bus can have various flash memories attached, they are
>  	  registered by bcma as platform devices. This enables driver for

From a code comment, I can see that ioremap_cache() is only used
on MIPS, and I'm fairly sure it's wrong both in theory and in practice
on Arm, so we could put it in an #ifdef. I wonder if on this specifc
mips chip, _page_cachable_default does not actually create a cached mapping
and that ioremap_cache() just creates a regular uncached mapping. ;-)

> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> index e098ae937ce8..e40d3277dcf6 100644
> --- a/drivers/mtd/maps/Kconfig
> +++ b/drivers/mtd/maps/Kconfig
> @@ -183,7 +183,7 @@ config MTD_SBC_GXX
> 
>  config MTD_PXA2XX
>  	tristate "CFI Flash device mapped on Intel XScale PXA2xx based boards"
> -	depends on (PXA25x || PXA27x) && MTD_CFI_INTELEXT
> +	depends on (PXA25x || PXA27x) && MTD_CFI_INTELEXT && HAVE_IOREMAP_CACHE
>  	help
>  	  This provides a driver for the NOR flash attached to a PXA2xx chip.
> 

We only have one machine remaining that uses the cached mtd mapping,
and this mainly hangs around for qemu use, so we could decide to just
drop all of the related code from drivers/mtd and always use the uncached
map, which would probably make all other users a bit faster by getting
rid of indirect functions and mutexes in the fast path. Otherwise
converting to memremap() would improve the code and avoid some casts.

     Arnd

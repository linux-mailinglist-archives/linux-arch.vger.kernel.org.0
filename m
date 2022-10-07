Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB25F79C8
	for <lists+linux-arch@lfdr.de>; Fri,  7 Oct 2022 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJGOjP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Oct 2022 10:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJGOjO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Oct 2022 10:39:14 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692DBFBCF2
        for <linux-arch@vger.kernel.org>; Fri,  7 Oct 2022 07:39:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e129so4813907pgc.9
        for <linux-arch@vger.kernel.org>; Fri, 07 Oct 2022 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRiGSXMjRSh71ZJo8tv1uwXWwcVVkdtkRZMiHgVacHA=;
        b=tL2XGQ2uyzhaIu9bECK7A0zMSFXB0SwPt8jsMliW/WKVXZSfjFpLeAe09Nds2TOw/g
         1bKOkH0n1MIS6lLdPx4jZ4IqBk/rOoilzJ4IBQCp0xFDJThhet6HDwlYC5zsRtrlqgfY
         fiUOsDs5KCAEMPDgu4XpdAygckPn+c6H1JJreUc8QXJpMWEcgKSpmDj7fjLIa5NI3N/W
         GpYh2TcLfsbk/UxmqhNH54voZfwk7Zd/dPiPBvkYnWJGs9GzWczl8gOaG99h4GKftgOz
         +tV6kCteeAMp0eF2E8yDuSv9OUDG6kX5OcDWO35J9oaZektz6HJYgYQan3PkHc2LjJVv
         005A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRiGSXMjRSh71ZJo8tv1uwXWwcVVkdtkRZMiHgVacHA=;
        b=3+gFULmEMfyIpUw81Ob02wu/VsdSLNJz2cUXGzDgQSumI5zQBX/BmNAbafszplG6yX
         VKH4MzcN5dRUzNhJtB/UjODdSSHf2lISxkMnHNKulmCqKomTunJZxn0yoEr+MERYkvdk
         nhoaMirPkNMSXSRe+jlmnFcrzoTINOhzxHkmvhVWoAQ7n5JyfExw2bmevMUe6Y5j0Ba3
         eR0etbberbOPRqCs22lNnmMsirmtpsvgmDFpKbaH1tai7uJxvtc2l/SWBgYlGkI5oGV2
         MBBzrR7Fqb2zVYkGup/6qy7Ww1Ed8Z1VbhC9+zLfuA7GQibS/vAXqSp6hus6rzX8GGov
         /F6Q==
X-Gm-Message-State: ACrzQf1RTcaLg9brOOFjTZSSNVI7c4BtRG6tFZ6/rtFfHKm/XPwkV2pe
        3mG94qFp/LB7XzZJiNwihGDB+g==
X-Google-Smtp-Source: AMsMyM5NQ9vQ8qaXqS0wqSCyixM7NyWeQUC1mNQGrSOn0vuOb2ohTcNQWz2zppOqfy2rfu6Iyr0caQ==
X-Received: by 2002:a63:da13:0:b0:438:e3cb:7a8c with SMTP id c19-20020a63da13000000b00438e3cb7a8cmr4905756pgh.31.1665153552749;
        Fri, 07 Oct 2022 07:39:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q39-20020a17090a1b2a00b00205f5ff3e3bsm4741639pjq.10.2022.10.07.07.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:39:11 -0700 (PDT)
Date:   Fri, 07 Oct 2022 07:39:11 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Oct 2022 07:39:10 PDT (-0700)
Subject:     Re: [PATCH] arch, drivers: Add HAVE_IOREMAP_CACHE
In-Reply-To: <2dca08bc-f743-4b97-adc0-3ebb13775178@app.fastmail.com>
CC:     Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-613f89fc-0bee-4de1-aa02-d0c931337c1e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 07 Oct 2022 00:25:23 PDT (-0700), Arnd Bergmann wrote:
> On Fri, Oct 7, 2022, at 5:44 AM, Palmer Dabbelt wrote:
>> ioremap_cache() isn't recommended for portable drivers, but there's a
>> handful of uses of it within the kernel.  This adds a HAVE_IOREMAP_CACHE
>> Kconfig, which is enabled for the ports that have implemented it and
>> added as a driver dependency when ioremap_cache() is uncoditionally
>> called (a handful of drivers have arch-specific ifdefs already, those I
>> left alone).
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> ---
>>
>> Not sure what to do about splitting this up, it touches a lot of trees
>> but it seems saner to do this atomicly.  I've just included linux-arch
>> for now, just to try and keep from blasting everyone.
>
> Do you need this in 6.1? If not, I'm happy to just pick it up in
> the asm-generic tree for 6.2.

I'm in no rush, 6.2 seems fine to me.  There was one patch set for 
RISC-V that implements ioremap_cache(), but I think we can just toss 
that implementation and things will still be OK.

>> Another option
>> here would be to add some sort of ioremap_cache() fallback, but I'm
>> assuming that has not been done to discourage more use of
>> ioremap_cache() in drivers.
>
> I think we had a fallback in the past, or at least discussed it, but
> since it's really incompatible with the uncached map, we probably don't
> want that.
>
>> I'm also not sure all these ports should have ioremap_cache(), but I
>> figured it'd be easier to just enumerate what's there rather than trying
>> to change the ports.  Preventing the drivers from compiling also seems
>> like a pretty heavy hammer, as it seems like some of these could have
>> their ioremap_cache() dependency removed pretty easily, but again I
>> figured it'd be better to start small.
>
> Agreed, makes sense.
>
>> This has barely been tested, just a defconfig build on x86.  That's very
>> much insufficient, but with this touching so many ports I figure it's
>> better to let the autobuilders have at that.
>
> Taking a look at the individual instances here, we don't have to
> address them in the same patch.

It definately seems clunky to just touch everything, but there's going 
to be a bit of work around getting something like this bisection-clean: 
we need all the arch selects in before we can start adding the driver 
depends, otherwise we'll lose drivers for a bit.  From below it sounds 
like it's worth just re-spinning this as a more cleanup focused series, 
I'll go do that and with any luck it'll be sane.

>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index f330410da63a..2b282fabde13 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -188,6 +188,9 @@ config USER_RETURN_NOTIFIER
>>  	  Provide a kernel-internal notification when a cpu is about to
>>  	  switch to user mode.
>>
>> +config HAVE_IOREMAP_CACHE
>> +	def_bool n
>> +
>
> This could use a help text that discourages adding it in more
> places.

OK.  This morning when I went back to my work tree I'd also realized I 
left the doc patch uncommitted.

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 4d2baac0311c..031263fd3708 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -427,7 +427,8 @@ It should also not be used for actual RAM, as the returned pointer is an
 ``__iomem`` token. memremap() can be used for mapping normal RAM that is outside
 of the linear kernel memory area to a regular pointer.

-Portable drivers should avoid the use of ioremap_cache().
+Portable drivers should avoid the use of ioremap_cache().  Drivers that use
+ioremap_cache() must depend on ``CONFIG_HAVE_IOREMAP_CACHE``.

 Architecture example
 --------------------

I'll also go ahead and add something like

diff --git a/arch/Kconfig b/arch/Kconfig
index 2b282fabde13..22ae994e8cd1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -188,6 +188,9 @@ config USER_RETURN_NOTIFIER
 	  Provide a kernel-internal notification when a cpu is about to
 	  switch to user mode.

+# Not recommended for new ports, as the semantics of ioremap_cache() differ
+# between architectures and thus any portable use of it is likely wrong.
+# ioremap_cache() has long been deprecated in favor of memremap().
 config HAVE_IOREMAP_CACHE
 	def_bool n

The changed patches are over at palmer/arch-have_ioremap_cache-v1-fixed.

>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 4c466acdc70d..c552fc97aad2 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -223,6 +223,7 @@ config PPC
>>  	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
>>  	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS &&
>> HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
>>  	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
>> +	select HAVE_IOREMAP_CACHE
>>  	select HAVE_IOREMAP_PROT
>>  	select HAVE_IRQ_TIME_ACCOUNTING
>>  	select HAVE_KERNEL_GZIP
>
> ioremap_cache() is used internally in powerpc, but not in any drivers
> used on this architecture. As expected, all three uses are a bit odd,
> and they all have missing __iomem annotations and don't use readl()
> etc for accessing the cached areas. The crashdump code should clearly
> use memremap(), no idea what the others are doing at all, probably
> converting to memremap() would make them clearer.

OK, I was on the fence about cleaning these up.

>> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>> index 5f220e903e5a..bd9426cfc13b 100644
>> --- a/arch/sh/Kconfig
>> +++ b/arch/sh/Kconfig
>> @@ -37,6 +37,7 @@ config SUPERH
>>  	select HAVE_FUNCTION_TRACER
>>  	select HAVE_FTRACE_MCOUNT_RECORD
>>  	select HAVE_HW_BREAKPOINT
>> +	select HAVE_IOREMAP_CACHE if MMU
>>  	select HAVE_IOREMAP_PROT if MMU && !X2TLB
>>  	select HAVE_KERNEL_BZIP2
>>  	select HAVE_KERNEL_GZIP
>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>> index 12ac277282ba..edfa5127322c 100644
>> --- a/arch/xtensa/Kconfig
>> +++ b/arch/xtensa/Kconfig
>> @@ -42,6 +42,7 @@ config XTENSA
>>  	select HAVE_FUNCTION_TRACER
>>  	select HAVE_GCC_PLUGINS if GCC_VERSION >= 120000
>>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>> +	select HAVE_IOREMAP_CACHE
>>  	select HAVE_IRQ_TIME_ACCOUNTING
>>  	select HAVE_PCI
>>  	select HAVE_PERF_EVENTS
>
> I don't see any callers, so we could just drop the implementation
> here entirely.

Makes sense to me.

>> diff --git a/drivers/firmware/meson/Kconfig
>> b/drivers/firmware/meson/Kconfig
>> index f2fdd3756648..612ca9ad3256 100644
>> --- a/drivers/firmware/meson/Kconfig
>> +++ b/drivers/firmware/meson/Kconfig
>> @@ -7,5 +7,6 @@ config MESON_SM
>>  	depends on ARCH_MESON || COMPILE_TEST
>>  	default y
>>  	depends on ARM64_4K_PAGES
>> +	depends on HAVE_IOREMAP_CACHE
>>  	help
>>  	  Say y here to enable the Amlogic secure monitor driver
>
> This should use memremap()
>
>> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
>> index 79cb981ececc..e6b55cab5a4a 100644
>> --- a/drivers/mtd/devices/Kconfig
>> +++ b/drivers/mtd/devices/Kconfig
>> @@ -114,7 +114,7 @@ config MTD_SST25L
>>
>>  config MTD_BCM47XXSFLASH
>>  	tristate "Support for serial flash on BCMA bus"
>> -	depends on BCMA_SFLASH && (MIPS || ARM)
>> +	depends on BCMA_SFLASH && (MIPS || ARM) && HAVE_IOREMAP_CACHE
>>  	help
>>  	  BCMA bus can have various flash memories attached, they are
>>  	  registered by bcma as platform devices. This enables driver for
>
> From a code comment, I can see that ioremap_cache() is only used
> on MIPS, and I'm fairly sure it's wrong both in theory and in practice
> on Arm, so we could put it in an #ifdef. I wonder if on this specifc
> mips chip, _page_cachable_default does not actually create a cached mapping
> and that ioremap_cache() just creates a regular uncached mapping. ;-)
>
>> diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
>> index e098ae937ce8..e40d3277dcf6 100644
>> --- a/drivers/mtd/maps/Kconfig
>> +++ b/drivers/mtd/maps/Kconfig
>> @@ -183,7 +183,7 @@ config MTD_SBC_GXX
>>
>>  config MTD_PXA2XX
>>  	tristate "CFI Flash device mapped on Intel XScale PXA2xx based boards"
>> -	depends on (PXA25x || PXA27x) && MTD_CFI_INTELEXT
>> +	depends on (PXA25x || PXA27x) && MTD_CFI_INTELEXT && HAVE_IOREMAP_CACHE
>>  	help
>>  	  This provides a driver for the NOR flash attached to a PXA2xx chip.
>>
>
> We only have one machine remaining that uses the cached mtd mapping,
> and this mainly hangs around for qemu use, so we could decide to just
> drop all of the related code from drivers/mtd and always use the uncached
> map, which would probably make all other users a bit faster by getting
> rid of indirect functions and mutexes in the fast path. Otherwise
> converting to memremap() would improve the code and avoid some casts.

OK, so for all these driver bits I'm happy to go sort that out.  It 
might take a bit, but I'm in no particular rush.  I can just take a shot 
at all those?  It's early enough in the 6.2 cycle that it seems 
reasonable to just take a shot at doing this right...

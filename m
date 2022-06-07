Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BC53FED6
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiFGMeG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiFGMeE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 08:34:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE10B0A42;
        Tue,  7 Jun 2022 05:34:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHVCQ55dqz4xD5;
        Tue,  7 Jun 2022 22:33:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1654605238;
        bh=xsqLotJgLRyhHSsJOogHV2acGAb2fC5jAOSFmHOIGA8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CyKzGazU3+2K8KiXkFolMw7JQl3fOZLWg6z5Qa5Pu4HecLtJDYCw5wZXMKOpJGtNH
         ls59IpcNb+xkojsRvHCc4fWQ+jCa6EIATKhLPnYyeuNIQ3bM/kCbodmjHfgOjgkZkS
         4h1lW8cbZe+o+0DbG3jBJCA91u30ggP5RKfw27leNpg5nQnN6glbcE5esgg3QrVgMC
         F6vtgSRCeacrQYA+phjt3HatLp44B4mYcMY4ThklAxFfrqM77MDq/rb5P0zDTt02T0
         PGQo6ASa5inpNApELNIR+n6jSj0aWCgLFiNBXcmQyCK7Xw/Luq/s+wYpHBJDE3Ehpr
         xujYS3Qf+FLTQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi@vger.kernel.org,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH 6/6] arch/*/: remove CONFIG_VIRT_TO_BUS
In-Reply-To: <20220606084109.4108188-7-arnd@kernel.org>
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-7-arnd@kernel.org>
Date:   Tue, 07 Jun 2022 22:33:49 +1000
Message-ID: <87y1y8tzyq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index be68c1f02b79..48e1aa0536b6 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -277,7 +277,6 @@ config PPC
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
> -	select VIRT_TO_BUS			if !PPC64
>  	#
>  	# Please keep this list sorted alphabetically.
>  	#

> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index c5a5f7c9b231..73fcd5cdb662 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -985,8 +985,6 @@ static inline void * bus_to_virt(unsigned long address)
>  }
>  #define bus_to_virt bus_to_virt
>  
> -#define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)
> -
>  #endif /* CONFIG_PPC32 */
  
Seems that's not used by any drivers, so fine to remove.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

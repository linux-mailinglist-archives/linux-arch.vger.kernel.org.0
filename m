Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B036F4737
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjEBPai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjEBPai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 11:30:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B9197;
        Tue,  2 May 2023 08:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FAA661947;
        Tue,  2 May 2023 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D3FC433EF;
        Tue,  2 May 2023 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683041432;
        bh=oOAFn1iw+VvOdPt870Z4/mUcqKg5x0WNhxwZ+XrKuhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FNTxB/0hXeVVhLW2dD5Dk+1hNcyjBdeS129PxOXvlmvYOZoD/D1TkPMMgEXMKv1aa
         eXsQ2S4cYnSdJkG1TVfatugGxRB/Xm+xyIyBQujRbVFHW9g9fqK+LMfka25Zm7f8LG
         2IZky9g1kYeiYMbhdwqVPWu/n4kD4cm/U9zwYXDRqPmN3k0DyS58uz59216UMTjveF
         Cs4jDM3uwbi3PPjHOdr53EFLO5rG7u2YKUG5USbP5TrFstlkgVkEgv0sQFBKOc7OC7
         ZtSJG6nPX5mHb60bmUeDKTmE7Z90Y4gLhubF/zfphv9Uey/iG4j1Dutw5bup8zemoX
         elOJVLFssnLrQ==
Date:   Tue, 2 May 2023 10:30:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v3 21/38] parport: PC style parport depends on HAS_IOPORT
Message-ID: <20230502153030.GA688533@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-22-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The wording of this subject line is a bit ambiguous and doesn't quite
say what the patch does.

It reads like a statement of fact, i.e., "this is the current state,"
but I think the patch actually *adds* a HAS_IOPORT dependency like
many of the other patches.

I guess it also *removes* a HAS_IOMEM dependency; I didn't investigate
to figure out why that is or whether it's even related (I guess it is,
but I don't know how).

On Tue, Mar 14, 2023 at 01:11:59PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As PC style parport uses these functions we need to
> handle this dependency.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/parport/Kconfig | 4 ++--
>  include/linux/parport.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
> index 5561362224e2..5c471c73629f 100644
> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
>  
>  menuconfig PARPORT
>  	tristate "Parallel port support"
> -	depends on HAS_IOMEM
>  	help
>  	  If you want to use devices connected to your machine's parallel port
>  	  (the connector at the computer with 25 holes), e.g. printer, ZIP
> @@ -42,7 +41,8 @@ if PARPORT
>  
>  config PARPORT_PC
>  	tristate "PC-style hardware"
> -	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
> +	depends on ARCH_MIGHT_HAVE_PC_PARPORT
> +	depends on HAS_IOPORT
>  	help
>  	  You should say Y here if you have a PC-style parallel port. All
>  	  IBM PC compatible computers and some Alphas have PC-style
> diff --git a/include/linux/parport.h b/include/linux/parport.h
> index a0bc9e0267b7..fff39bc30629 100644
> --- a/include/linux/parport.h
> +++ b/include/linux/parport.h
> @@ -514,7 +514,7 @@ extern int parport_device_proc_register(struct pardevice *device);
>  extern int parport_device_proc_unregister(struct pardevice *device);
>  
>  /* If PC hardware is the only type supported, we can optimise a bit.  */
> -#if !defined(CONFIG_PARPORT_NOT_PC)
> +#if !defined(CONFIG_PARPORT_NOT_PC) && defined(CONFIG_PARPORT_PC)
>  
>  #include <linux/parport_pc.h>
>  #define parport_write_data(p,x)            parport_pc_write_data(p,x)
> -- 
> 2.37.2
> 

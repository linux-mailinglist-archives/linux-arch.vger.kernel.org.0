Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59E51925C
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiECXll (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 May 2022 19:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiECXlk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2022 19:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D0E42EC0;
        Tue,  3 May 2022 16:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D7EC617EB;
        Tue,  3 May 2022 23:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A049EC385A4;
        Tue,  3 May 2022 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651621085;
        bh=TddFjYfs0IlmmoRmRJhIId5AulGG33VI0BNiobU2CvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lEN+VqFrouY3qh8AlZeGsjaIYP0MaQQQlhpXsVSepSP9KdbbBSuXXKMiHLEGcG9YZ
         kiZVWt1yUF8om4fV1V8DpcIuYczrnTa/4b9S4l4qMfx98ZdlWVXUqC6Md/EEiGLSJY
         KmL5Ho4NK6WdEIEFfRJiIl3SDFAzZC0xxXGbt8FVF3D878jtS1HJvdkr9mIHxvzsiO
         Gbcpz/nIeL/ouVLq+qNZZfmm9k/mgKWcedPUj+SqRF/VWCcngli20fhii3vDanQdh+
         iJ3Gfe6PQzcXpbh6gCpOYr8U+0Xlwh/BOSR0C+nOsyPy5wsLVcd7sem18wia46moP9
         dB5xoO03WTSFQ==
Date:   Tue, 3 May 2022 18:38:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
Message-ID: <20220503233802.GA420374@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-44-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:41PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. PCMCIA devices are either LEGACY_PCI devices
> which implies HAS_IOPORT or require HAS_IOPORT.
> 
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pcmcia/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index 2ce261cfff8e..32b5cd324c58 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -5,7 +5,7 @@
>  
>  menuconfig PCCARD
>  	tristate "PCCard (PCMCIA/CardBus) support"
> -	depends on !UML
> +	depends on HAS_IOPORT

I don't know much about PC Card.  Is there a requirement that these
devices must use I/O port space?  If so, can you include a spec
reference in the commit log?

I do see the PC Card spec, r8.1, sec 5.5.4.2.2 says:

  All CardBus PC Card adapters must support either memory-mapped I/O
  or both memory-mapped I/O and I/O space. The selection will depend
  largely on the system architecture the adapter is intended to be
  used in. The requirement to also support memory-mapped I/O, if I/O
  space is supported, is driven by the potential emergence of
  memory-mapped I/O only cards. Supporting both modes may also
  position the adapter to be sold into multiple system architectures.

which sounds like I/O space is optional.

>  	help
>  	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
>  	  computer.  These are credit-card size devices such as network cards,
> -- 
> 2.32.0
> 

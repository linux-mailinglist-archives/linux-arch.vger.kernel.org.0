Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52751ACAC
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbiEDS1p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354887AbiEDS1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 14:27:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91854AFB15;
        Wed,  4 May 2022 10:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0347B827A5;
        Wed,  4 May 2022 17:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1608DC385A5;
        Wed,  4 May 2022 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651686834;
        bh=x5TXQ+sKJh3OswfwKy0D7SzXvH/NMceOTIx8sfvn320=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iAiBwBhUh80Dg3UBLI0jKfK4RQZblD6MpdL376pwD1D1ybuKumCqc1kA08OJLFyif
         gZbnFMdx/ndkfIFRgpDTH/AVOEgSMT2BRT/v+bwGRYayTm+heJ2+ofNVyvfzCvOivI
         AYzgV2vbMTiTF2Cu3/OT0/6R1nzyKtTfCXcov9qt67ec7I0VJknBN62SplXUAH3Y44
         Ohi7zQZlCz9uGVJUTFwKwDMoZH54juVWofvM9M4q3LQLUkXa/YaaWE23jJ7kXYhfxi
         HAxf9g8AHmL/XlVNlHSJ0/tNxWkMc2lLkPCHAmhjqgmlU5xFYizq9TnXPUAOb4Dsfg
         YqxvciUTkxJfw==
Date:   Wed, 4 May 2022 12:53:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC v2 02/39] ACPI: add dependency on HAS_IOPORT
Message-ID: <20220504175352.GA456913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-3-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:00PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. As ACPI always uses I/O port access we simply depend
> on HAS_IOPORT.

CONFIG_ACPI depends on ARCH_SUPPORTS_ACPI, which is only set by arm64,
ia64, and x86, all of which support I/O port access.  So does this
actually solve a problem?  I wouldn't think you'd be able to build
ACPI on s390 even without this patch.

"ACPI always uses I/O port access" is a pretty broad brush, and it
would be useful to know specifically what the dependencies are.

Many ACPI hardware accesses use acpi_hw_read()/acpi_hw_write(), which
use either MMIO or I/O port accesses depending on what the firmware
told us.

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/acpi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1e34f846508f..8ad0d168004c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -5,6 +5,7 @@
>  
>  config ARCH_SUPPORTS_ACPI
>  	bool
> +	depends on HAS_IOPORT
>  
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
> -- 
> 2.32.0
> 

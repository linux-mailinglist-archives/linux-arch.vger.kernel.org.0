Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70764713BB8
	for <lists+linux-arch@lfdr.de>; Sun, 28 May 2023 20:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE1Sit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 May 2023 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE1Sis (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 May 2023 14:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D179FAD;
        Sun, 28 May 2023 11:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63B4D612EC;
        Sun, 28 May 2023 18:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DC3C433D2;
        Sun, 28 May 2023 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685299126;
        bh=Y1Ww4qK5/r9zCYcpnBGZ7qwWpTsyIaM5eqr/Ya7W1bc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJuYBjuwADkZUZcrXaFx4CRaeAD6xhtrpw1PZ+GeSEpuK/psXVyzPtuQ9GtoLS9jD
         RKgGlFl+97e7XSsDmZJHaB9v9wOsrtZ51GNecdzmHTLjGlkluYGC7UI4d32bq+f3+n
         UTGBeVe6xKQpYuYdokECSGmPKK5BT8E93pF7irQUyRUB/AukwdgT4pAXdmevMazHCF
         Nk7O0Bsj8xExFifOdJsuGZncW4osMkoOfqw5sS83jDvOH9jCy0tdh0RmyurQkjpjob
         y649HJDRb1qbEa4CAiA7C86wE8vY9gA2nUuOCT6eXaC/vlQeVHYwRui/TZ3/W9H1LV
         hmIsFTpWMovEg==
Date:   Sun, 28 May 2023 19:55:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 14/44] iio: ad7606: Kconfig: add HAS_IOPORT
 dependencies
Message-ID: <20230528195503.4dbeb358@jic23-huawei>
In-Reply-To: <20230522105049.1467313-15-schnelle@linux.ibm.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
        <20230522105049.1467313-15-schnelle@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 22 May 2023 12:50:19 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

I already picked this up for the IIO tree already as I don't think there are
any dependencies.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index eb2b09ef5d5b..53098aca06ea 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -145,7 +145,7 @@ config AD7606
>  
>  config AD7606_IFACE_PARALLEL
>  	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOPORT
>  	select AD7606
>  	help
>  	  Say yes here to build parallel interface support for Analog Devices:


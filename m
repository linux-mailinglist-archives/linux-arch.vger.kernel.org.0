Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E6A70A8D4
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjETPYQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 May 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETPYQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 May 2023 11:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ACC102;
        Sat, 20 May 2023 08:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017956120B;
        Sat, 20 May 2023 15:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0CCC433D2;
        Sat, 20 May 2023 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684596254;
        bh=Bum+y+qoUTFlmhaqk+6tU1ywQwBuUMOil2M7NiUvHUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nCbM7WHfq1IMDuPTH0L5XCGjOae8OWwAUSgSb8T9Mb5d04buIjpsG2I5VGl9/cfds
         t70ClJPMEV6b79/A4XoKyUNgiJDoC2+gDXvDTr1U0Iy8ipUHAX7wvTlunphumRrlS+
         X7ZlAksr2wiyRQAujhPgOLGNijjTbkhsEeUevDe64LBIY91UjZ7TafxBjTuA2Z0e9w
         uK776HzHZbbjfZvOTs0+Gb2h6PsqOtnE+0Q50J4xpv+0OArvkFVSmDtUCCeAdPtaEf
         aleyyUutqXi3EhWOXd8MZTrS4+OTmE5af9jCuGyT5KO+jKqsBjTs79K3jDuaj+q328
         U5ERO7eMfLw8w==
Date:   Sat, 20 May 2023 16:40:21 +0100
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
Subject: Re: [PATCH v4 12/41] iio: ad7606: Kconfig: add HAS_IOPORT
 dependencies
Message-ID: <20230520164021.4298161a@jic23-huawei>
In-Reply-To: <20230516110038.2413224-13-schnelle@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
        <20230516110038.2413224-13-schnelle@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 16 May 2023 13:00:08 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a first look at it.

Thanks

Jonathan

> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
> 
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


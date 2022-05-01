Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F70516559
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348432AbiEAQqa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349805AbiEAQq3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 12:46:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D51DA54;
        Sun,  1 May 2022 09:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1663FB80E31;
        Sun,  1 May 2022 16:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D715C385A9;
        Sun,  1 May 2022 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651423380;
        bh=5iiuM2YB632xp1B0gLh45BZ+N3/79eXgk2RK6BlzzpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n0xTwkLoSb0AzWyaHXJeEggDmse8eeQyuVoUUEoaMLokua+cGHyXPZVHr8tx1i2lS
         FzOtbckl1b7cHziE/jUc6dPSKOG0SdfaPU1De3W2JFZoqhID6DaeTr668IUy285MAx
         jpDSZjUAb6qco7qdSUfDVv4Qj/sQptdSKSKF4Jj4jJeyFzYaYVLHrF9vUtRbMaD8Cn
         lfGtKKjJr7IlXp3iokWRv1lnx0nsjYZfElfYOlX0OzmkmRoG9OFDnBQgyJIAVxEnX4
         ELTkZUzTW79i53uBjGSQcsOX5tuQDYaJ54nf6Yu8ZPllkWMgzCzltDekLsDWKgwL3g
         FuMq/yjxFIjnA==
Date:   Sun, 1 May 2022 17:51:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [RFC v2 13/39] iio: adc: Kconfig: add HAS_IOPORT dependencies
Message-ID: <20220501175115.2520a946@jic23-huawei>
In-Reply-To: <20220429135108.2781579-23-schnelle@linux.ibm.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
        <20220429135108.2781579-23-schnelle@linux.ibm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 29 Apr 2022 15:50:20 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Hi.

Please call out specific driver as that'll increase chance
of relevant people noticing (there are quite a lot of ADC drivers!)

e.g.
iio: adc: ad7606: ....

Anyhow, looks fine to me

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,


> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 71ab0a06aa82..c99843307e4f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -130,7 +130,7 @@ config AD7606
>  
>  config AD7606_IFACE_PARALLEL
>  	tristate "Analog Devices AD7606 ADC driver with parallel interface support"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOPORT
>  	select AD7606
>  	help
>  	  Say yes here to build parallel interface support for Analog Devices:


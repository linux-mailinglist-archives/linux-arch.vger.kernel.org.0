Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033FA6B9504
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjCNM5z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjCNM5h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:57:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87AE15542;
        Tue, 14 Mar 2023 05:53:02 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D864E1C000B;
        Tue, 14 Mar 2023 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678798325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkuaXd86klfX5z5UBkkpcJQxbSjcGacKOadUv840wU0=;
        b=GLHReGkFiwl8ZclCScYGYcgHFF1aQqYZ497lEAln7rYtb4CUkp7z3wlXmzRm6eSFZkycCS
        7anQTtpYnx0wO3U4k421K3uAplgifxxwiNXC+YuEvG4HAy7zDeKxxslIf9dovi9DIPH4fP
        J6FNwuzyEQsZrIY4wfkTbM8mo7gWh+Yev7IWNH3xp4oRQIo1odhNxIYxuA0ZfXCYSOh/kn
        1Li47k7SXaojwKX3xHx6eUAXPB9yfC0xxsteYcnUrlR70ZRSasHJDxjLJlkjtVGW40zKV9
        UNPDcUCitcHOiqUQtppBZ1x70VqNFCae4MPPXnaUjEB22JH/ilqsWWfe4HT0+Q==
Date:   Tue, 14 Mar 2023 13:52:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 28/38] rtc: add HAS_IOPORT dependencies
Message-ID: <202303141252027ef5511a@mail.local>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-29-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-29-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On 14/03/2023 13:12:06+0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/rtc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 5a71579af0a1..20aa77bf0a9f 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
>  config RTC_DRV_CMOS
>  	tristate "PC-style 'CMOS'"
>  	depends on X86 || ARM || PPC || MIPS || SPARC64
> +	depends on HAS_IOPORT

Did you check that this will not break platforms that doesn't have RTC_PORT defined?

>  	default y if X86
>  	select RTC_MC146818_LIB
>  	help
> @@ -976,6 +977,7 @@ config RTC_DRV_CMOS
>  config RTC_DRV_ALPHA
>  	bool "Alpha PC-style CMOS"
>  	depends on ALPHA
> +	depends on HAS_IOPORT
>  	select RTC_MC146818_LIB
>  	default y
>  	help
> @@ -1193,7 +1195,7 @@ config RTC_DRV_MSM6242
>  
>  config RTC_DRV_BQ4802
>  	tristate "TI BQ4802"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && HAS_IOPORT
>  	help
>  	  If you say Y here you will get support for the TI
>  	  BQ4802 RTC chip.
> -- 
> 2.37.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

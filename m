Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3487352ADE4
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiEQWPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 May 2022 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2022 18:15:09 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AF396A5;
        Tue, 17 May 2022 15:15:08 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D66F100006;
        Tue, 17 May 2022 22:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652825707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JjH2s+XnUZEsXjcYOLzSvl6ZNThviCEVc61/n52xQc=;
        b=eA8eNHlXjV5vGVMPA6To+ieNXYlkdCwriqFYaa5SORfbCKHNDdeSdBeodpV/X4Fl7owmXe
        es/tABfnIXYTFpw+TovGh4Q7UlrKq//xc5JzoD88srolhTw4uF8BTeU/6/SI40qxr7qgZW
        O1wDFJ4yy2KrOtPrQ80yikxBHz7GXZWJtCWPQNoDMgvitXGn8YZ24C3FgbJQLQ6NaGm+S6
        BGI8INMoAb4tivhqtyctogtgbzmjUPrir5gl5JXoZlg34M+jqnFNSLtxoOisJRUpQpWmSK
        tOO/hxRNQ96/KU/7AHIXBJPuMcngLMxKF49dpA8ukctdWmHwX/0juUY0RfP1Qg==
Date:   Wed, 18 May 2022 00:15:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>
Subject: Re: [RFC v2 29/39] rtc: add HAS_IOPORT dependencies
Message-ID: <YoQeagVSRyaeA+vd@mail.local>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-52-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-52-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 29/04/2022 15:50:49+0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 

I'm fine taking that this cycle if there are no dependencies. Should I?

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/rtc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 41c65b4d2baf..e1bb11a225b2 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -951,6 +951,7 @@ comment "Platform RTC drivers"
>  config RTC_DRV_CMOS
>  	tristate "PC-style 'CMOS'"
>  	depends on X86 || ARM || PPC || MIPS || SPARC64
> +	depends on HAS_IOPORT
>  	default y if X86
>  	select RTC_MC146818_LIB
>  	help
> @@ -971,6 +972,7 @@ config RTC_DRV_CMOS
>  config RTC_DRV_ALPHA
>  	bool "Alpha PC-style CMOS"
>  	depends on ALPHA
> +	depends on HAS_IOPORT
>  	select RTC_MC146818_LIB
>  	default y
>  	help
> @@ -1188,7 +1190,7 @@ config RTC_DRV_MSM6242
>  
>  config RTC_DRV_BQ4802
>  	tristate "TI BQ4802"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && HAS_IOPORT
>  	help
>  	  If you say Y here you will get support for the TI
>  	  BQ4802 RTC chip.
> -- 
> 2.32.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

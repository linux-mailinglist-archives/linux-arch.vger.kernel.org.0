Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421C653A4E0
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352231AbiFAMZj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiFAMZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:25:38 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D6073B2BF;
        Wed,  1 Jun 2022 05:25:37 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BEB9A92009C; Wed,  1 Jun 2022 14:25:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B798692009B;
        Wed,  1 Jun 2022 13:25:35 +0100 (BST)
Date:   Wed, 1 Jun 2022 13:25:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>
Subject: Re: [RFC v2 29/39] rtc: add HAS_IOPORT dependencies
In-Reply-To: <20220429135108.2781579-52-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2206011258540.51604@angie.orcam.me.uk>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com> <20220429135108.2781579-52-schnelle@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 29 Apr 2022, Niklas Schnelle wrote:

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 41c65b4d2baf..e1bb11a225b2 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -951,6 +951,7 @@ comment "Platform RTC drivers"
>  config RTC_DRV_CMOS
>  	tristate "PC-style 'CMOS'"
>  	depends on X86 || ARM || PPC || MIPS || SPARC64
> +	depends on HAS_IOPORT

 Umm, I missed this one previously and this is wrong.  We use this driver 
for the DECstation machines (CONFIG_MIPS/CONFIG_MACH_DECSTATION) and those 
do not use (nor indeed have) port I/O as they are TURBOchannel systems and 
they only have a single (memory) address space.  Consequently their DS1287 
chip is memory-mapped (in a linear fashion actually, i.e. there's no 
visible address/data register and individual locations are accessible with 
single CPU instructions), cf. arch/mips/include/asm/mach-dec/mc146818rtc.h 
(that probably ought to be converted to `readb'/`writeb' one day).

 So this has to be sorted differently, perhaps by just:

+	depends on HAS_IOPORT || MACH_DECSTATION

 Note that other machines handled by the MIPS port do use port I/O, cf. 
arch/mips/include/asm/mach-*/mc146818rtc.h.

  Maciej

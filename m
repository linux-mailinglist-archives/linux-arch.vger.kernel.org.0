Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2370BF38
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjEVNJf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEVNJe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 09:09:34 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F549E;
        Mon, 22 May 2023 06:09:32 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 147F092009C; Mon, 22 May 2023 15:09:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1093692009B;
        Mon, 22 May 2023 14:09:31 +0100 (BST)
Date:   Mon, 22 May 2023 14:09:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
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
Subject: Re: [PATCH v5 30/44] rtc: add HAS_IOPORT dependencies
In-Reply-To: <20230522105049.1467313-31-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2305221314480.27887@angie.orcam.me.uk>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com> <20230522105049.1467313-31-schnelle@linux.ibm.com>
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

On Mon, 22 May 2023, Niklas Schnelle wrote:

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 753872408615..a38a919b3f15 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
>  config RTC_DRV_CMOS
>  	tristate "PC-style 'CMOS'"
>  	depends on X86 || ARM || PPC || MIPS || SPARC64
> +	depends on HAS_IOPORT || MACH_DECSTATION
>  	default y if X86
>  	select RTC_MC146818_LIB
>  	help

 For the DECstation part:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

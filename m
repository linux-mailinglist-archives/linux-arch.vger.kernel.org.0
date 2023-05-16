Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9227052D1
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjEPPvk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjEPPv1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 11:51:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01D43DC46;
        Tue, 16 May 2023 08:50:26 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4E89C9200B3; Tue, 16 May 2023 17:49:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4702E92009B;
        Tue, 16 May 2023 16:49:51 +0100 (BST)
Date:   Tue, 16 May 2023 16:49:51 +0100 (BST)
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
Subject: Re: [PATCH v4 28/41] rtc: add HAS_IOPORT dependencies
In-Reply-To: <20230516110038.2413224-29-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2305161641510.50034@angie.orcam.me.uk>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com> <20230516110038.2413224-29-schnelle@linux.ibm.com>
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

On Tue, 16 May 2023, Niklas Schnelle wrote:

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 753872408615..9ae082b14c44 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
>  config RTC_DRV_CMOS
>  	tristate "PC-style 'CMOS'"
>  	depends on X86 || ARM || PPC || MIPS || SPARC64
> +	depends on HAS_IOPORT

 NAK, this hasn't addressed my input for v2.  Arnd also followed up with 
similar observations with v3.

  Maciej

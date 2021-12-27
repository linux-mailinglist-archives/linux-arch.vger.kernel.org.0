Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB93480451
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 20:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhL0TK3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 14:10:29 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:52646 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhL0TK2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 14:10:28 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Dec 2021 14:10:27 EST
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 7083B2013F8;
        Mon, 27 Dec 2021 19:01:29 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 83A9C80E7C; Mon, 27 Dec 2021 19:41:15 +0100 (CET)
Date:   Mon, 27 Dec 2021 19:41:15 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: Re: [RFC 18/32] pcmcia: Kconfig: add HAS_IOPORT dependencies
Message-ID: <YcoIyy7uQakUp4sd@owl.dominikbrodowski.net>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-19-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-19-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Am Mon, Dec 27, 2021 at 05:43:03PM +0100 schrieb Niklas Schnelle:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. PCMCIA devices are either LEGACY_PCI devices
> which implies HAS_IOPORT or require HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik

> ---
>  drivers/pcmcia/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index d13b8d1a780a..3d05bdf1f9cb 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -5,7 +5,7 @@
>  
>  menuconfig PCCARD
>  	tristate "PCCard (PCMCIA/CardBus) support"
> -	depends on !UML
> +	depends on LEGACY_PCI || HAS_IOPORT
>  	help
>  	  Say Y here if you want to attach PCMCIA- or PC-cards to your Linux
>  	  computer.  These are credit-card size devices such as network cards,
> -- 
> 2.32.0
> 

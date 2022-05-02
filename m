Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9996C516D28
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384117AbiEBJSb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 05:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiEBJSa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 05:18:30 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50E8036B50;
        Mon,  2 May 2022 02:15:01 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 776CE92009C; Mon,  2 May 2022 11:15:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 712B392009B;
        Mon,  2 May 2022 10:15:00 +0100 (BST)
Date:   Mon, 2 May 2022 10:15:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [RFC v2 34/39] tty: serial: add HAS_IOPORT dependencies
In-Reply-To: <20220429135108.2781579-63-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2205020341140.64520@angie.orcam.me.uk>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com> <20220429135108.2781579-63-schnelle@linux.ibm.com>
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

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
[...]
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index cd93ea6eed65..e216bf745e78 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -6,7 +6,7 @@
>  
>  config SERIAL_8250
>  	tristate "8250/16550 and compatible serial support"
> -	depends on !S390
> +	depends on HAS_IOPORT
>  	select SERIAL_CORE
>  	select SERIAL_MCTRL_GPIO if GPIOLIB
>  	help

 Similarly here some 8250-compatible platform or PCI/e serial port devices 
use MMIO, e.g.:

serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 20, base_baud = 230400) is a 16550A

or:

0001:01:00.0: ttyS0 at MMIO 0x600c080401000 (irq = 40, base_baud = 15625000) is a 16C950/954

so this has to be sorted out within the driver rather than by disabling it 
altogether.  Possibly with a suitable conditional wired to HAS_IOPORT in 
`set_io_from_upio' in drivers/tty/serial/8250/8250_port.c.

  Maciej

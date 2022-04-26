Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1F250FDE2
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244693AbiDZNAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiDZM77 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 08:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893D1CFD2;
        Tue, 26 Apr 2022 05:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8257C618A2;
        Tue, 26 Apr 2022 12:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208EEC385B0;
        Tue, 26 Apr 2022 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650977808;
        bh=UfH5FqGLFyIRO6b9m1nN9+5yl/RCZ1naUPX8xPSqemk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQNS36CWw+o4eYdUcb+97ZQ++Kh/yv1HS5nZTZ4d9v4OZLTco21fxuoSf/apqrfMJ
         PPH/Ww2Ik73E9CiWFrWteDBUI6EtcTbwNsy/0iSyzTDYPh4r0PZUbDCGZ04Sp7Gc+t
         Yv75lQNO5kuTcKwGk3LBb/kZldsFLbKYPGftpj3Q=
Date:   Tue, 26 Apr 2022 14:56:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-api@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 06/10] serial: General support for multipoint addresses
Message-ID: <YmfsDng2Z04PT3GS@kroah.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
 <20220426122448.38997-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426122448.38997-7-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 03:24:44PM +0300, Ilpo Järvinen wrote:
> Add generic support for serial multipoint addressing. Two new ioctls
> are added. TIOCSADDR is used to indicate the destination/receive
> address. TIOCGADDR returns the current address in use. The driver
> should implement set_addr and get_addr to support addressing mode.
> 
> Adjust ADDRB clearing to happen only if driver does not provide
> set_addr (=the driver doesn't support address mode).
> 
> This change is necessary for supporting devices with RS485 multipoint
> addressing [*]. A following patch in the patch series adds support for
> Synopsys Designware UART capable for 9th bit addressing mode. In this
> mode, 9th bit is used to indicate an address (byte) within the
> communication line. The 9th bit addressing mode is selected using ADDRB
> introduced by the previous patch.
> 
> Transmit addresses / receiver filter are specified by setting the flags
> SER_ADDR_DEST and/or SER_ADDR_RECV. When the user supplies the transmit
> address, in the 9bit addressing mode it is sent out immediately with
> the 9th bit set to 1. After that, the subsequent normal data bytes are
> sent with 9th bit as 0 and they are intended to the device with the
> given address. It is up to receiver to enforce the filter using
> SER_ADDR_RECV. When userspace has supplied the receive address, the
> driver is expected to handle the matching of the address and only data
> with that address is forwarded to the user. Both SER_ADDR_DEST and
> SER_ADDR_RECV can be given at the same time in a single call if the
> addresses are the same.
> 
> The user can clear the receive filter with SER_ADDR_RECV_CLEAR.
> 
> [*] Technically, RS485 is just an electronic spec and does not itself
> specify the 9th bit addressing mode but 9th bit seems at least
> "semi-standard" way to do addressing with RS485.
> 
> Cc: linux-api@vger.kernel.org
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../driver-api/serial/serial-rs485.rst        | 23 ++++++-
>  arch/alpha/include/uapi/asm/ioctls.h          |  3 +
>  arch/mips/include/uapi/asm/ioctls.h           |  3 +
>  arch/parisc/include/uapi/asm/ioctls.h         |  3 +
>  arch/powerpc/include/uapi/asm/ioctls.h        |  3 +
>  arch/sh/include/uapi/asm/ioctls.h             |  3 +
>  arch/sparc/include/uapi/asm/ioctls.h          |  3 +
>  arch/xtensa/include/uapi/asm/ioctls.h         |  3 +
>  drivers/tty/serial/8250/8250_core.c           |  2 +
>  drivers/tty/serial/serial_core.c              | 62 ++++++++++++++++++-
>  drivers/tty/tty_io.c                          |  2 +
>  include/linux/serial_core.h                   |  6 ++
>  include/uapi/asm-generic/ioctls.h             |  3 +
>  include/uapi/linux/serial.h                   |  8 +++
>  14 files changed, 125 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
> index 6bc824f948f9..2f45f007fa5b 100644
> --- a/Documentation/driver-api/serial/serial-rs485.rst
> +++ b/Documentation/driver-api/serial/serial-rs485.rst
> @@ -95,7 +95,28 @@ RS485 Serial Communications
>  		/* Error handling. See errno. */
>  	}
>  
> -5. References
> +5. Multipoint Addressing
> +========================
> +
> +   The Linux kernel provides serial_addr structure to handle addressing within
> +   multipoint serial communications line such as RS485. 9th bit addressiong mode
> +   is enabled by adding ADDRB flag in termios c_cflag.
> +
> +   Serial core calls device specific set/get_addr in response to TIOCSADDR and
> +   TIOCGADDR ioctls with a pointer to serial_addr. Destination and receive
> +   address can be specified using serial_addr flags field. Receive address may
> +   also be cleared using flags. Once an address is set, the communication
> +   can occur only with the particular device and other peers are filtered out.
> +   It is left up to the receiver side to enforce the filtering.
> +
> +   Address flags:
> +	- SER_ADDR_RECV: Receive (filter) address.
> +	- SER_ADDR_RECV_CLEAR: Clear receive filter (only for TIOCSADDR).
> +	- SER_ADDR_DEST: Destination address.
> +
> +   Note: not all devices supporting RS485 support multipoint addressing.
> +
> +6. References
>  =============
>  
>   [1]	include/uapi/linux/serial.h
> diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
> index 971311605288..500cab3e1d6b 100644
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -125,4 +125,7 @@
>  #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
>  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  #endif /* _ASM_ALPHA_IOCTLS_H */
> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
> index 16aa8a766aec..3859dc46857e 100644
> --- a/arch/mips/include/uapi/asm/ioctls.h
> +++ b/arch/mips/include/uapi/asm/ioctls.h
> @@ -96,6 +96,9 @@
>  #define TIOCGISO7816	_IOR('T', 0x42, struct serial_iso7816)
>  #define TIOCSISO7816	_IOWR('T', 0x43, struct serial_iso7816)
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  /* I hope the range from 0x5480 on is free ... */
>  #define TIOCSCTTY	0x5480		/* become controlling tty */
>  #define TIOCGSOFTCAR	0x5481
> diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
> index 82d1148c6379..62337743db64 100644
> --- a/arch/parisc/include/uapi/asm/ioctls.h
> +++ b/arch/parisc/include/uapi/asm/ioctls.h
> @@ -86,6 +86,9 @@
>  #define TIOCSTOP	0x5462
>  #define TIOCSLTC	0x5462
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  /* Used for packet mode */
>  #define TIOCPKT_DATA		 0
>  #define TIOCPKT_FLUSHREAD	 1
> diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
> index 2c145da3b774..84fd69ac366a 100644
> --- a/arch/powerpc/include/uapi/asm/ioctls.h
> +++ b/arch/powerpc/include/uapi/asm/ioctls.h
> @@ -120,4 +120,7 @@
>  #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
>  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  #endif	/* _ASM_POWERPC_IOCTLS_H */
> diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
> index 11866d4f60e1..f82966b7dba2 100644
> --- a/arch/sh/include/uapi/asm/ioctls.h
> +++ b/arch/sh/include/uapi/asm/ioctls.h
> @@ -113,4 +113,7 @@
>  #define TIOCMIWAIT	_IO('T', 92) /* 0x545C */	/* wait for a change on serial input line(s) */
>  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  #endif /* __ASM_SH_IOCTLS_H */
> diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
> index 7fd2f5873c9e..e44624c67c79 100644
> --- a/arch/sparc/include/uapi/asm/ioctls.h
> +++ b/arch/sparc/include/uapi/asm/ioctls.h
> @@ -125,6 +125,9 @@
>  #define TIOCMIWAIT	0x545C /* Wait for change on serial input line(s) */
>  #define TIOCGICOUNT	0x545D /* Read serial port inline interrupt counts */
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  /* Kernel definitions */
>  
>  /* Used for packet mode */
> diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
> index 6d4a87296c95..759ca9377f2a 100644
> --- a/arch/xtensa/include/uapi/asm/ioctls.h
> +++ b/arch/xtensa/include/uapi/asm/ioctls.h
> @@ -127,4 +127,7 @@
>  #define TIOCMIWAIT	_IO('T', 92) /* wait for a change on serial input line(s) */
>  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  #endif /* _XTENSA_IOCTLS_H */
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 01d30f6ed8fb..f67bc3b76f65 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1008,6 +1008,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  		uart->port.rs485	= up->port.rs485;
>  		uart->rs485_start_tx	= up->rs485_start_tx;
>  		uart->rs485_stop_tx	= up->rs485_stop_tx;
> +		uart->port.set_addr	= up->port.set_addr;
> +		uart->port.get_addr	= up->port.get_addr;
>  		uart->dma		= up->dma;
>  
>  		/* Take tx_loadsz from fifosize if it wasn't set separately */
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 0f397e67eeb0..5762987bf176 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1397,6 +1397,56 @@ static int uart_set_iso7816_config(struct uart_port *port,
>  	return 0;
>  }
>  
> +static int uart_set_addr(struct uart_port *port,
> +			 struct serial_addr __user *serial_addr_user)
> +{
> +	struct serial_addr addr;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!port->set_addr)
> +		return -ENOTTY;
> +
> +	if (copy_from_user(&addr, serial_addr_user, sizeof(*serial_addr_user)))
> +		return -EFAULT;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	ret = port->set_addr(port, &addr);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user(serial_addr_user, &addr, sizeof(addr)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int uart_get_addr(struct uart_port *port,
> +			 struct serial_addr __user *serial_addr_user)
> +{
> +	struct serial_addr addr;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!port->get_addr)
> +		return -ENOTTY;
> +
> +	if (copy_from_user(&addr, serial_addr_user, sizeof(*serial_addr_user)))
> +		return -EFAULT;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	ret = port->get_addr(port, &addr);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +	if (ret)
> +		return ret;
> +
> +	if (copy_to_user(serial_addr_user, &addr, sizeof(addr)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  /*
>   * Called via sys_ioctl.  We can use spin_lock_irq() here.
>   */
> @@ -1474,6 +1524,15 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  	case TIOCGISO7816:
>  		ret = uart_get_iso7816_config(state->uart_port, uarg);
>  		break;
> +
> +	case TIOCSADDR:
> +		ret = uart_set_addr(uport, uarg);
> +		break;
> +
> +	case TIOCGADDR:
> +		ret = uart_get_addr(uport, uarg);
> +		break;
> +
>  	default:
>  		if (uport->ops->ioctl)
>  			ret = uport->ops->ioctl(uport, cmd, arg);
> @@ -1540,7 +1599,8 @@ static void uart_set_termios(struct tty_struct *tty,
>  		goto out;
>  	}
>  
> -	tty->termios.c_cflag &= ~ADDRB;
> +	if (!uport->set_addr)
> +		tty->termios.c_cflag &= ~ADDRB;
>  
>  	uart_change_speed(tty, state, old_termios);
>  	/* reload cflag from termios; port driver may have overridden flags */
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 8fec1d8648f5..ef22b95e9c79 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2885,6 +2885,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
>  	case TIOCSERGETLSR:
>  	case TIOCGRS485:
>  	case TIOCSRS485:
> +	case TIOCSADDR:
> +	case TIOCGADDR:
>  #ifdef TIOCGETP
>  	case TIOCGETP:
>  	case TIOCSETP:
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index cbd5070bc87f..2dd4c4d01c59 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -135,6 +135,12 @@ struct uart_port {
>  						struct serial_rs485 *rs485);
>  	int			(*iso7816_config)(struct uart_port *,
>  						  struct serial_iso7816 *iso7816);
> +
> +	int			(*set_addr)(struct uart_port *p,
> +					    struct serial_addr *addr);
> +	int			(*get_addr)(struct uart_port *p,
> +					    struct serial_addr *addr);
> +
>  	unsigned int		irq;			/* irq number */
>  	unsigned long		irqflags;		/* irq flags  */
>  	unsigned int		uartclk;		/* base uart clock */
> diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
> index cdc9f4ca8c27..689743366091 100644
> --- a/include/uapi/asm-generic/ioctls.h
> +++ b/include/uapi/asm-generic/ioctls.h
> @@ -106,6 +106,9 @@
>  # define FIOQSIZE	0x5460
>  #endif
>  
> +#define TIOCSADDR	_IOWR('T', 0x63, struct serial_addr)
> +#define TIOCGADDR	_IOWR('T', 0x64, struct serial_addr)
> +
>  /* Used for packet mode */
>  #define TIOCPKT_DATA		 0
>  #define TIOCPKT_FLUSHREAD	 1
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index fa6b16e5fdd8..8cb785ea7087 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -149,4 +149,12 @@ struct serial_iso7816 {
>  	__u32	reserved[5];
>  };
>  
> +struct serial_addr {
> +	__u32	flags;
> +#define SER_ADDR_RECV			(1 << 0)
> +#define SER_ADDR_RECV_CLEAR		(1 << 1)
> +#define SER_ADDR_DEST			(1 << 2)

You never check for invalid flags being sent to the kernel, which means
this api can never change in the future to add new flags :(

And what about struct serial_rs485?  Shouldn't that be used here
instead?  Why do we need a new ioctl and structure?

thanks,

greg k-h

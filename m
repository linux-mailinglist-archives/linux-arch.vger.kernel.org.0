Return-Path: <linux-arch+bounces-7788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084619938C2
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 23:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3931C23049
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9C1DE4CB;
	Mon,  7 Oct 2024 21:09:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6371DCB06;
	Mon,  7 Oct 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335365; cv=none; b=t7YyuMfdRYiJXQcp9AC2z+1v5s4LzwxhglPknI4Mv/mbEo2ClHS53PhRs2i/qzgz0q9YX3TVTw0EGdFVe7SqPvj3Dpo1xB9IeS0BzSFlby82UQ9nchXddySIDq3qzmrqP1CcdoSrgSwDnCd1JN1eKZeEc6bOG1EH7o0iuLiU4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335365; c=relaxed/simple;
	bh=eLspYNW3wOsgz3KGMO3599QZ8Ze+l27EzYkbHmBSdGE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PjzliIgVVBApFPF33RQJUrx4siGFBGYLfb0e1Sl3UIdnzWXpB9iOozRKNkpVq9qW0i5MZkeo3tX3UGX/HfJWWFAIF5dPD484QjdNp9rlSJPtARgaVTyAil4J9KHKOLYqUQF9b1rcxToXBiv7VmfISw1TOv4XMoZsb2jiK6HhoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B37EC92009C; Mon,  7 Oct 2024 23:09:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A591592009B;
	Mon,  7 Oct 2024 22:09:15 +0100 (BST)
Date: Mon, 7 Oct 2024 22:09:15 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Maxime Ripard <mripard@kernel.org>, 
    Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
    Gerd Hoffmann <kraxel@redhat.com>, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, 
    linux-hexagon@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
    dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
    spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
    linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, 
    Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v6 4/5] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <20241007-b4-has_ioport-v6-4-03f7240da6e5@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2410072109130.30973@angie.orcam.me.uk>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com> <20241007-b4-has_ioport-v6-4-03f7240da6e5@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 7 Oct 2024, Niklas Schnelle wrote:

> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 6709b6a5f3011db38acc58dc7223158fe4fcf72e..6a638feb44e443a1998980dd037748f227ec1bc8 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
[...]
>  	iobase = pci_resource_start(dev, 0);
>  	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
>  }
>  
> -
>  static int
>  pci_sunix_setup(struct serial_private *priv,
>  		const struct pciserial_board *board,

 Gratuitous change here.

> diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial/8250/8250_pcilib.c
> index ea906d721b2c3eac15c9e8d62cc6fa56c3ef6150..fc1882d7515b5814ff1240ffdbe1009ab908ad6b 100644
> --- a/drivers/tty/serial/8250/8250_pcilib.c
> +++ b/drivers/tty/serial/8250/8250_pcilib.c
> @@ -28,6 +28,10 @@ int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
>  		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
>  		port->port.regshift = regshift;
>  	} else {
> +		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> +			pr_err("Serial port %lx requires I/O port support\n", port->port.iobase);
> +			return -EINVAL;
> +		}
>  		port->port.iotype = UPIO_PORT;
>  		port->port.iobase = pci_resource_start(dev, bar) + offset;
>  		port->port.mapbase = 0;

 Can we please flatten this conditional and get rid of the negation, and 
also use `pci_err' for clear identification (`port->port.iobase' may not 
even have been set to anything meaningful if this triggers)?  I.e.:

		/* ... */
	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
		/* ... */
	} else {
		pci_err(dev, "serial port requires I/O port support\n");
		return -EINVAL;
	}

I'd also say "port I/O" (by analogy to "memory-mapped I/O") rather than 
"I/O port", but I can imagine it might be debatable.

> +static __always_inline bool is_upf_fourport(struct uart_port *port)
> +{
> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> +		return false;
> +
> +	return port->flags & UPF_FOURPORT;
> +}

 Can we perhaps avoid adding this helper and then tweaking code throughout 
by having:

#ifdef CONFIG_SERIAL_8250_FOURPORT
#define UPF_FOURPORT		((__force upf_t) ASYNC_FOURPORT       /* 1  */ )
#else
#define UPF_FOURPORT		0
#endif

in include/linux/serial_core.h instead?  I can see the flag is reused by 
drivers/tty/serial/sunsu.c, but from a glance over it seems rubbish to me 
and such a change won't hurt the driver anyway.

> @@ -1174,7 +1201,7 @@ static void autoconfig(struct uart_8250_port *up)
>  		 */
>  		scratch = serial_in(up, UART_IER);
>  		serial_out(up, UART_IER, 0);
> -#ifdef __i386__
> +#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
>  		outb(0xff, 0x080);
>  #endif
>  		/*
> @@ -1183,7 +1210,7 @@ static void autoconfig(struct uart_8250_port *up)
>  		 */
>  		scratch2 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
>  		serial_out(up, UART_IER, UART_IER_ALL_INTR);
> -#ifdef __i386__
> +#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
>  		outb(0, 0x080);
>  #endif
>  		scratch3 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;

 Nah, i386 does have machine OUTB instructions, it has the port I/O 
address space in the ISA, so these two changes make no sense to me.  

 Though this #ifdef should likely be converted to CONFIG_X86_32 via a 
separate change.

> @@ -1306,12 +1333,12 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  {
>  	struct uart_port *port = &up->port;
>  	unsigned char save_mcr, save_ier;
> +	unsigned long irqs;
>  	unsigned char save_ICP = 0;
>  	unsigned int ICP = 0;
> -	unsigned long irqs;
>  	int irq;

 Gratuitous change here (also breaking the reverse Christmas tree order).

 Thanks for making the clean-ups we discussed.

  Maciej


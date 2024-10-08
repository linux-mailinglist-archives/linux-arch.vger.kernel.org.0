Return-Path: <linux-arch+bounces-7818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5131799427C
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C2D1C21AF8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8E1C1AB1;
	Tue,  8 Oct 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHo4fQUn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EB42AB1;
	Tue,  8 Oct 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375417; cv=none; b=TW+GIueYyEjvtgnEkSCIEx20Fbu1w2/NFwSVoP401avJy+56r/fqHjcD1ipzN31sbpae1CVjaS3FAAD9WBigF26pRBvcUTOqy+SXece5ER1tb1EYIaK38hlVCKWJIzMojdyNQ1vDXbMcJL8WReIlFe3BhAQCnX/k+VsLIC1IFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375417; c=relaxed/simple;
	bh=5q8CuvYmRN2mTkCNyu36VRINnt4vc3iLD6wxwxK1Q28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnvqPAFQNR9XAdBYkI+7D6vWCjcb/b7InlZl+MqGqvzDIsDPeXkHAKgovAqesmWlo3ydaK5RyyCpa2oUKmjasupnJsao+fhO/Q8hugNFaLTq/EymDYr8bvydAhrTrH4zL8nXAQmtf2AT6xGIDsvHVSrmOnFuNBe/pZ4oT44GT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHo4fQUn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4987rMsl004958;
	Tue, 8 Oct 2024 08:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	voeEqfxsFd+/77zpL5D+y4gMqcRDIhp51epNuVuJ7ZY=; b=sHo4fQUndC+aATfq
	x6FtjA95IrCiTWSM6Yr7QeMxglakVe5pbc2Lny9bHH3w2g60v/FUJFod3LKkW2t3
	N9Pi7SjUPHgcQWGBIf4w2QGfe4makFe056rO1xayTZCnOlROqwylWhMPwFioQyHW
	KGuC4s5rETTg2OY0uX29prBMNt5LcxufaLfNaAx8+FfqefBKIJORu1HCscCuGS+9
	fkOyY0qB6TGhps22fVYWALcULALv0kGbxz3ffFjMzsQvjkesCv/Ad5QJbE4DuBg1
	04ZUnfmws0Y/Zv/r7uv2uJiWCjDAKB3VId3NfJpujjWTcwpOZKbDD7B/x1jktc6G
	VelTPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4250r104aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 08:16:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4988GW4P030718;
	Tue, 8 Oct 2024 08:16:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4250r104a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 08:16:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4985aeJf011598;
	Tue, 8 Oct 2024 08:16:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xk6ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 08:16:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4988GUNT36765958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 08:16:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94E565805E;
	Tue,  8 Oct 2024 08:16:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782595805A;
	Tue,  8 Oct 2024 08:16:26 +0000 (GMT)
Received: from oc-fedora.boeblingen.de.ibm.com (unknown [9.152.212.119])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 08:16:26 +0000 (GMT)
Message-ID: <46d81b40dda20ada3b5847353a866172b419c811.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/5] tty: serial: handle HAS_IOPORT dependencies
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Brian Cain <bcain@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Patrik Jakobsson
 <patrik.r.jakobsson@gmail.com>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Date: Tue, 08 Oct 2024 10:16:25 +0200
In-Reply-To: <alpine.DEB.2.21.2410072109130.30973@angie.orcam.me.uk>
References: <20241007-b4-has_ioport-v6-0-03f7240da6e5@linux.ibm.com>
	 <20241007-b4-has_ioport-v6-4-03f7240da6e5@linux.ibm.com>
	 <alpine.DEB.2.21.2410072109130.30973@angie.orcam.me.uk>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lJvN_sQ-aLNDSuNh0LDS6vl7xXhIFy-h
X-Proofpoint-ORIG-GUID: 7DRb96EpW2B3fOngjvAD841iHZjNSk_4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_05,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080050

On Mon, 2024-10-07 at 22:09 +0100, Maciej W. Rozycki wrote:
> On Mon, 7 Oct 2024, Niklas Schnelle wrote:
>=20
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
> > index 6709b6a5f3011db38acc58dc7223158fe4fcf72e..6a638feb44e443a1998980d=
d037748f227ec1bc8 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> [...]
> >  	iobase =3D pci_resource_start(dev, 0);
> >  	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
> >  }
> > =20
> > -
> >  static int
> >  pci_sunix_setup(struct serial_private *priv,
> >  		const struct pciserial_board *board,
>=20
>  Gratuitous change here.
>=20
> > diff --git a/drivers/tty/serial/8250/8250_pcilib.c b/drivers/tty/serial=
/8250/8250_pcilib.c
> > index ea906d721b2c3eac15c9e8d62cc6fa56c3ef6150..fc1882d7515b5814ff1240f=
fdbe1009ab908ad6b 100644
> > --- a/drivers/tty/serial/8250/8250_pcilib.c
> > +++ b/drivers/tty/serial/8250/8250_pcilib.c
> > @@ -28,6 +28,10 @@ int serial8250_pci_setup_port(struct pci_dev *dev, s=
truct uart_8250_port *port,
> >  		port->port.membase =3D pcim_iomap_table(dev)[bar] + offset;
> >  		port->port.regshift =3D regshift;
> >  	} else {
> > +		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> > +			pr_err("Serial port %lx requires I/O port support\n", port->port.io=
base);
> > +			return -EINVAL;
> > +		}
> >  		port->port.iotype =3D UPIO_PORT;
> >  		port->port.iobase =3D pci_resource_start(dev, bar) + offset;
> >  		port->port.mapbase =3D 0;
>=20
>  Can we please flatten this conditional and get rid of the negation, and=
=20
> also use `pci_err' for clear identification (`port->port.iobase' may not=
=20
> even have been set to anything meaningful if this triggers)?  I.e.:
>=20
> 		/* ... */
> 	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
> 		/* ... */
> 	} else {
> 		pci_err(dev, "serial port requires I/O port support\n");
> 		return -EINVAL;
> 	}
>=20
> I'd also say "port I/O" (by analogy to "memory-mapped I/O") rather than=20
> "I/O port", but I can imagine it might be debatable.

Agree this looks better, will change it.

>=20
> > +static __always_inline bool is_upf_fourport(struct uart_port *port)
> > +{
> > +	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> > +		return false;
> > +
> > +	return port->flags & UPF_FOURPORT;
> > +}
>=20
>  Can we perhaps avoid adding this helper and then tweaking code throughou=
t=20
> by having:
>=20
> #ifdef CONFIG_SERIAL_8250_FOURPORT
> #define UPF_FOURPORT		((__force upf_t) ASYNC_FOURPORT       /* 1  */ )
> #else
> #define UPF_FOURPORT		0
> #endif
>=20
> in include/linux/serial_core.h instead?  I can see the flag is reused by=
=20
> drivers/tty/serial/sunsu.c, but from a glance over it seems rubbish to me=
=20
> and such a change won't hurt the driver anyway.

I'll look at this, do you think this is okay regarding matching the
user-space definitions in include/uapi/linux/tty_flags.h?

>=20
> > @@ -1174,7 +1201,7 @@ static void autoconfig(struct uart_8250_port *up)
> >  		 */
> >  		scratch =3D serial_in(up, UART_IER);
> >  		serial_out(up, UART_IER, 0);
> > -#ifdef __i386__
> > +#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
> >  		outb(0xff, 0x080);
> >  #endif
> >  		/*
> > @@ -1183,7 +1210,7 @@ static void autoconfig(struct uart_8250_port *up)
> >  		 */
> >  		scratch2 =3D serial_in(up, UART_IER) & UART_IER_ALL_INTR;
> >  		serial_out(up, UART_IER, UART_IER_ALL_INTR);
> > -#ifdef __i386__
> > +#if defined(__i386__) && defined(CONFIG_HAS_IOPORT)
> >  		outb(0, 0x080);
> >  #endif
> >  		scratch3 =3D serial_in(up, UART_IER) & UART_IER_ALL_INTR;
>=20
>  Nah, i386 does have machine OUTB instructions, it has the port I/O=20
> address space in the ISA, so these two changes make no sense to me. =20
>=20
>  Though this #ifdef should likely be converted to CONFIG_X86_32 via a=20
> separate change.

This is needed for Usermode Linux (UM) which sets __i386__ but also
doesn't have CONFIG_HAS_IOPORT. This was spotted by the kernel test bot
here: https://lore.kernel.org/all/202410031712.BwfGjrQY-lkp@intel.com/

>=20
> > @@ -1306,12 +1333,12 @@ static void autoconfig_irq(struct uart_8250_por=
t *up)
> >  {
> >  	struct uart_port *port =3D &up->port;
> >  	unsigned char save_mcr, save_ier;
> > +	unsigned long irqs;
> >  	unsigned char save_ICP =3D 0;
> >  	unsigned int ICP =3D 0;
> > -	unsigned long irqs;
> >  	int irq;
>=20
>  Gratuitous change here (also breaking the reverse Christmas tree order).
>=20
>  Thanks for making the clean-ups we discussed.
>=20
>   Maciej

WIll drop this hunk


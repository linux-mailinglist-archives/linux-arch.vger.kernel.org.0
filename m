Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE69706862
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjEQMls (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjEQMlr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 08:41:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD2E1FFC;
        Wed, 17 May 2023 05:41:44 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HCbwaF024412;
        Wed, 17 May 2023 12:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4rXcL78Aoz/KapA9CBe6JT5xgTLh3UB8VZsi6jbe2vk=;
 b=PeQ43KQpY/fXHVrfkPEJKsNtmWgii0t8W5lLK20JaS6tz0zPhS3gxzOqQCyEYSHKuDSQ
 TJSTWFm8Mi8WengGXr6IUWQu7hNfKqR6OVa4efbXXiBgIZApI7rQDZFaKaqV4cdLf844
 O1iAWsMajp9iEb/VGDkA+x5uzKW17Lsda2tpZGy2hzY9Ih1eODn8wBhsk0Qat7r6WxUs
 ElPjKnyiEcDzW3yrnlLTRxeXOeiMHgEV4PM/T76ncJDEXsd0l6RWQqbP5TGk7vhqrv6a
 /py1GUOR+WfrtVByeS7VZML8hsNcMQEwURCly4umDUy/p/G0YxJY0CBRM+zNJ2TvXv8D tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmxvprjrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:41:27 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HCdaAG004493;
        Wed, 17 May 2023 12:41:26 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmxvprjpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:41:26 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H2pWu0013154;
        Wed, 17 May 2023 12:41:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qj264st55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:41:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34HCfLAn4915808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 12:41:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC5B52004E;
        Wed, 17 May 2023 12:41:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB77120040;
        Wed, 17 May 2023 12:41:20 +0000 (GMT)
Received: from [9.171.70.117] (unknown [9.171.70.117])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 12:41:20 +0000 (GMT)
Message-ID: <db6db5d49e236548c26fbaa2e16462463814d7ff.camel@linux.ibm.com>
Subject: Re: [PATCH v4 38/41] video: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-fbdev@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Date:   Wed, 17 May 2023 14:41:20 +0200
In-Reply-To: <87ba918b-214b-a58a-ecc4-17b0bd00e8f8@suse.de>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-39-schnelle@linux.ibm.com>
         <87ba918b-214b-a58a-ecc4-17b0bd00e8f8@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fv8AV45wpM57H2AdwCW3pQ7xuCLTXciP
X-Proofpoint-ORIG-GUID: qlt7I83N3LVQYDYq29k-Jl55JLicOqNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 19:21 +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 16.05.23 um 13:00 schrieb Niklas Schnelle:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them and guard inline code in headers.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
> >        per-subsystem patches may be applied independently
> >=20
> >   drivers/video/console/Kconfig |  1 +
> >   drivers/video/fbdev/Kconfig   | 21 +++++++++++----------
> >   include/video/vga.h           |  8 ++++++++
>=20
> Those are 3 different things. It might be preferable to not handle them=
=20
> under the video/ umbrella.
>=20
> >   3 files changed, 20 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kcon=
fig
> > index 22cea5082ac4..64974eaa3ac5 100644
> > --- a/drivers/video/console/Kconfig
> > +++ b/drivers/video/console/Kconfig
> > @@ -10,6 +10,7 @@ config VGA_CONSOLE
> >   	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPER=
H && \
> >   		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> >   		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390 && !UML
> > +	depends on HAS_IOPORT
> >   	select APERTURE_HELPERS if (DRM || FB || VFIO_PCI_CORE)
> >   	default y
> >   	help
> > diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> > index 96e91570cdd3..a56c57dd839b 100644
> > --- a/drivers/video/fbdev/Kconfig
> > +++ b/drivers/video/fbdev/Kconfig
> > @@ -335,7 +335,7 @@ config FB_IMX
> >  =20
> >   config FB_CYBER2000
> >   	tristate "CyberPro 2000/2010/5000 support"
> > -	depends on FB && PCI && (BROKEN || !SPARC64)
> > +	depends on FB && PCI && HAS_IOPORT && (BROKEN || !SPARC64)
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -429,6 +429,7 @@ config FB_FM2
> >   config FB_ARC
> >   	tristate "Arc Monochrome LCD board support"
> >   	depends on FB && (X86 || COMPILE_TEST)
> > +	depends on HAS_IOPORT
> >   	select FB_SYS_FILLRECT
> >   	select FB_SYS_COPYAREA
> >   	select FB_SYS_IMAGEBLIT
> > @@ -1332,7 +1333,7 @@ config FB_ATY_BACKLIGHT
> >  =20
> >   config FB_S3
> >   	tristate "S3 Trio/Virge support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -1393,7 +1394,7 @@ config FB_SAVAGE_ACCEL
> >  =20
> >   config FB_SIS
> >   	tristate "SiS/XGI display support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -1424,7 +1425,7 @@ config FB_SIS_315
> >  =20
> >   config FB_VIA
> >   	tristate "VIA UniChrome (Pro) and Chrome9 display support"
> > -	depends on FB && PCI && GPIOLIB && I2C && (X86 || COMPILE_TEST)
> > +	depends on FB && PCI && GPIOLIB && I2C && HAS_IOPORT && (X86 || COMPI=
LE_TEST)
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -1463,7 +1464,7 @@ endif
> >  =20
> >   config FB_NEOMAGIC
> >   	tristate "NeoMagic display support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_MODE_HELPERS
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> > @@ -1493,7 +1494,7 @@ config FB_KYRO
> >  =20
> >   config FB_3DFX
> >   	tristate "3Dfx Banshee/Voodoo3/Voodoo5 display support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_IMAGEBLIT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> > @@ -1543,7 +1544,7 @@ config FB_VOODOO1
> >  =20
> >   config FB_VT8623
> >   	tristate "VIA VT8623 support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -1558,7 +1559,7 @@ config FB_VT8623
> >  =20
> >   config FB_TRIDENT
> >   	tristate "Trident/CyberXXX/CyberBlade support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -1581,7 +1582,7 @@ config FB_TRIDENT
> >  =20
> >   config FB_ARK
> >   	tristate "ARK 2000PV support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > @@ -2195,7 +2196,7 @@ config FB_SSD1307
> >  =20
> >   config FB_SM712
> >   	tristate "Silicon Motion SM712 framebuffer support"
> > -	depends on FB && PCI
> > +	depends on FB && PCI && HAS_IOPORT
> >   	select FB_CFB_FILLRECT
> >   	select FB_CFB_COPYAREA
> >   	select FB_CFB_IMAGEBLIT
> > diff --git a/include/video/vga.h b/include/video/vga.h
> > index 947c0abd04ef..f4b806b85c86 100644
> > --- a/include/video/vga.h
> > +++ b/include/video/vga.h
> > @@ -203,18 +203,26 @@ extern int restore_vga(struct vgastate *state);
> >  =20
> >   static inline unsigned char vga_io_r (unsigned short port)
> >   {
> > +#ifdef CONFIG_HAS_IOPORT
> >   	return inb_p(port);
> > +#else
> > +	return 0xff;
> > +#endif
> >   }
> >  =20
> >   static inline void vga_io_w (unsigned short port, unsigned char val)
> >   {
> > +#ifdef CONFIG_HAS_IOPORT
> >   	outb_p(val, port);
> > +#endif
> >   }
> >  =20
> >   static inline void vga_io_w_fast (unsigned short port, unsigned char =
reg,
> >   				  unsigned char val)
> >   {
> > +#ifdef CONFIG_HAS_IOPORT
> >   	outw(VGA_OUT16VAL (val, reg), port);
> > +#endif
> >   }
>=20
> It feels wrong that these helpers silently do nothing. I'd enclose them=
=20
> in CONFIG_HAS_IOPORT entirely. The drivers that use them unconditionally=
=20
> would then fail to build.
>=20
> Best regards
> Thomas

Ok yeah, I was looking at the call sites like vga_w_fast() that use
either an HAS_IOPORT dependent function or a writew() based one and so
if I #ifdef the regbase !=3D NULL check we could end up with a NULL
derference but I guess that is kind of what we want since clearly
something is wrong if the driver tries to do I/O port access despite it
not being available.

Thanks,
Niklas

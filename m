Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714170978E
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjESMuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjESMuJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 08:50:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD53E4D;
        Fri, 19 May 2023 05:50:03 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCcFW3002513;
        Fri, 19 May 2023 12:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kpbDefN8oMoTU2dBleqFgTcr9qcSBJPLyED+f+RE3+c=;
 b=nadr45iu1wc7R4guCZkW6l+wT/BL/xl95zSXQVhgrYOfAdahfAZpDetROjxdzJwwLcVb
 5lFB7U04K+9qAIihJxslDGmT6T/VX5qaT6Co+YNon07nmZCUEGOfGACMU22zikrPP59n
 9oQg14iKp1q1WQXP8hC+ROve1fyrWMtsXOZh75HuKwq3QMlpI9Hc4ZeIH+u/K/4OYlyQ
 q/OOezBpESAV15VkuWk6N8i7i244UU//kc95FTkj/cNoR/pN/8vIM8WPLMPr0gaeHOub
 PTSsF3n9+OquB3QjqF8d+NUeMLWV0AO8HciWQIR2yGpnOg+qhKNKnwxh+83Xj9XWJkIV vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp91srqdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:46:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34JCceUK004225;
        Fri, 19 May 2023 12:46:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp91srqcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:46:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34JAZNfO005832;
        Fri, 19 May 2023 12:46:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdu5k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:46:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JCkcRf66191658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 12:46:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF35620049;
        Fri, 19 May 2023 12:46:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08B6320043;
        Fri, 19 May 2023 12:46:37 +0000 (GMT)
Received: from [9.171.0.172] (unknown [9.171.0.172])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 12:46:36 +0000 (GMT)
Message-ID: <14413c00b3fb8cc2e10a10292ac5c07346b29a10.camel@linux.ibm.com>
Subject: Re: [PATCH v4 02/41] ata: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
Date:   Fri, 19 May 2023 14:46:36 +0200
In-Reply-To: <33d99147-74c9-d62a-7591-a569e11a401d@kernel.org>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-3-schnelle@linux.ibm.com>
         <da77a377-4a9e-be8d-7b14-aeb270b7183e@kernel.org>
         <33d99147-74c9-d62a-7591-a569e11a401d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DHZ5Pvar63J5MkEIJpobxyyK3F1h_wIH
X-Proofpoint-GUID: cYtE3xKwjO7mSvgoYElVipOQO5IwnjA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 22:23 +0900, Damien Le Moal wrote:
> On 5/16/23 22:18, Damien Le Moal wrote:
> > On 5/16/23 19:59, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and frie=
nds
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> > >=20
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >=20
---8<---
> > > +++ b/drivers/ata/libata-sff.c
> > > @@ -3031,6 +3031,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
> > > =20
> > >  #ifdef CONFIG_PCI
> > > =20
> > > +#ifdef CONFIG_HAS_IOPORT
> > >  /**
> > >   *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simpl=
ex
> > >   *	@pdev: PCI device
> > > @@ -3056,6 +3057,7 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev =
*pdev)
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
> > > +#endif /* CONFIG_HAS_IOPORT */
> >=20
> > ...you move the #ifdef CONFIG_HAS_IOPORT inside the function as the fir=
st line
> > and have the #endif right before the last "return 0;" (so the function =
only does
> > return 0 for the !CONFIG_HAS_IOPORT case).
> >=20
> > > =20
> > >  static void ata_bmdma_nodma(struct ata_host *host, const char *reaso=
n)
> > >  {
> > > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > > index 311cd93377c7..90002d4a785b 100644
> > > --- a/include/linux/libata.h
> > > +++ b/include/linux/libata.h
> > > @@ -2012,7 +2012,9 @@ extern int ata_bmdma_port_start(struct ata_port=
 *ap);
> > >  extern int ata_bmdma_port_start32(struct ata_port *ap);
> > > =20
> > >  #ifdef CONFIG_PCI
> > > +#ifdef CONFIG_HAS_IOPORT
> > >  extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
> > > +#endif /* CONFIG_HAS_IOPORT */
> >=20
> > And then you do not need these #ifdef/endif here. Overall, a lot less o=
f #ifdef
> > which I personally really dislike to see in .c files :)
>=20
> Actually, thinking more about this, the function should probably be:
>=20
> int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
> {
> #ifdef CONFIG_HAS_IOPORT
> 	unsigned long bmdma =3D pci_resource_start(pdev, 4);
> 	u8 simplex;
>=20
> 	if (bmdma =3D=3D 0)
> 		return -ENOENT;
>=20
> 	simplex =3D inb(bmdma + 0x02);
> 	outb(simplex & 0x60, bmdma + 0x02);
> 	simplex =3D inb(bmdma + 0x02);
> 	if (simplex & 0x80)
> 		return -EOPNOTSUPP;
> 	return 0;
> #else
> 	return -ENOENT;
> #endif
> }
>=20
> And then no other "#ifdef CONFIG_HAS_IOPORT" needed.
>=20
>=20

Ok I went with this for v5. It's a bit of a matter of taste. For the
video subsystem I just went the other direction #ifdeffingthe whole
helper and its callsites much as I had here. They were all in headers
and prefixed with "vga_io.." though. Either way I'm fine with either
and will go with the subsystem maintainer's preference.

Thanks,
Niklas

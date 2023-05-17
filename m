Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ED57062E3
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEQIak (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 04:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEQIaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 04:30:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021961AD;
        Wed, 17 May 2023 01:29:41 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H83Taj019707;
        Wed, 17 May 2023 08:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K8dSz1VSi5KMNCqzv/v+CmqKEFda7USjYbIoW8+RWPA=;
 b=G5Vcbl6pu9JnasKr/Jrp74k8RVew2jKLXpRFaNj8+rJ56I74hMXe4txWQUL8hmRHGnru
 yeLw7LA3HUZopq9MrknBXL3fjJTmC59B+ArS7DxJ119+SDO+6xzrV83QlJFUZ5lgTX09
 PdD8GmeC0yIA+Ihgew3oPSpXm7I3kkxG+lsF0VP2zmZ+Fgbqxjj2DhpAPLM0iUqtdS92
 A7ezSR1VEybji1cZFDxt1Mt8TBfCiBPJjLiopTlg8WSFSggsjEUBRmq7sogePqATp70H
 ELrHDlcWUOxUBNxDmlWUQkDBD9UVROZOJBKxjbCDYKeCq339JNaHiTdP7YyJJ2Ng+HL3 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmu33gymm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:29:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H8QrEG003309;
        Wed, 17 May 2023 08:29:27 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmu33gym2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:29:27 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1LASE022307;
        Wed, 17 May 2023 08:29:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qj1tdsq7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:29:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H8TMmV13763118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 08:29:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A464520040;
        Wed, 17 May 2023 08:29:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9039C20043;
        Wed, 17 May 2023 08:29:21 +0000 (GMT)
Received: from [9.179.22.107] (unknown [9.179.22.107])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 08:29:21 +0000 (GMT)
Message-ID: <33f6bd2277d2bdc5c5455c2987f479c3b2cd554d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Date:   Wed, 17 May 2023 10:29:21 +0200
In-Reply-To: <23936929-80e4-4599-827a-d09b4960f3ab@rowland.harvard.edu>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-36-schnelle@linux.ibm.com>
         <2023051643-overtime-unbridle-7cdd@gregkh>
         <4e291030-99d9-4b8b-9389-9b8f2560b8e8@app.fastmail.com>
         <23936929-80e4-4599-827a-d09b4960f3ab@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cNeghrB-Fl803ZHecJIADJe8FW4yGHtE
X-Proofpoint-GUID: DDn3Pa_fTkGb6tUVcF-u7Wwj4JwyIvzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=441
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 15:51 -0400, Alan Stern wrote:
> On Tue, May 16, 2023 at 06:44:34PM +0200, Arnd Bergmann wrote:
> > On Tue, May 16, 2023, at 18:29, Greg Kroah-Hartman wrote:
> > > On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:
> >=20
> > > >  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
> > > >  /* Support PCI only */
> > > >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> > > >  {
> > > > -	return inl(uhci->io_addr + reg);
> > > > +	return UHCI_IN(inl(uhci->io_addr + reg));
> > > >  }
> > > > =20
> > > >  static inline void uhci_writel(const struct uhci_hcd *uhci, u32 va=
l, int reg)
> > > >  {
> > > > -	outl(val, uhci->io_addr + reg);
> > > > +	UHCI_OUT(outl(val, uhci->io_addr + reg));
> > >=20
> > > I'm confused now.
> > >=20
> > > So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.
> > >=20
> > > But if it isn't, then these are just no-ops that do nothing?  So then
> > > the driver will fail to work?  Why have these stubs at all?
> > >=20
> > > Why not just not build the driver at all if this option is not enable=
d?

The driver supports multiple access methods in several functions
similar to the following:

static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int re=
g)
{
	if (uhci_has_pci_registers(uhci))
		UHCI_OUT(outl(val, uhci->io_addr + reg));
	else if (uhci_is_aspeed(uhci))
		writel(val, uhci->regs + uhci_aspeed_reg(reg));
#ifdef CONFIG_USB_UHCI_BIG_ENDIAN_MMIO
	else if (uhci_big_endian_mmio(uhci))
		writel_be(val, uhci->regs + reg);
#endif
	else
		writel(val, uhci->regs + reg);
}

Instead of adding more #ifdefs Alan Stern suggested to just stub out
both uhci_has_pci_registers() and the access itself. So with a half way
optimizing compiler this shouldn't even leave no-ops in the binary.


>=20
> > That said, there is a minor problem with the empty definition
> >=20
> > +#define UHCI_OUT(x)
> >=20
> > I think this should be "do { } while (0)" to avoid warnings
> > about empty if/else blocks.
>=20
> I'm sure Niklas wouldn't mind making such a change.  But do we really=20
> get such warnings?  Does the compiler really think that this kind of=20
> (macro-expanded) code:
>=20
> 	if (uhci_has_pci_registers(uhci))
> 		;
> 	else if (uhci_is_aspeed(uhci))
> 		writel(val, uhci->regs + uhci_aspeed_reg(reg));
>=20
> deserves a warning?  I write stuff like that fairly often; it's a good=
=20
> way to showcase a high-probability do-nothing pathway at the start of a=
=20
> series of conditional cases.  And I haven't noticed any complaints from=
=20
> the compiler.
>=20
> Alan Stern

I changed it to "do {} while (0)" for v5 but agree I haven't seen
warnings for this either. Still doesn't hurt.

Thanks,
Niklas

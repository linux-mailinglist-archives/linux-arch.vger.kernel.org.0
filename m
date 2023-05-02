Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2D6F455D
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjEBNnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjEBNmw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 09:42:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D056A53;
        Tue,  2 May 2023 06:42:19 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342Dd5mD007993;
        Tue, 2 May 2023 13:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iFaCTqGqZoIlS2U6AthjISaQLDuN0XAiJI4clbfAzlE=;
 b=l8hYwA+trtcflDmakAhIsZFuk9aqqnBPrEWz8W1ep2AW92SdO3gD0J1z4TXLlAjLZBcY
 8QXFM2eUV5ZHF7+uSQz+hjI2e3f5EiYVHuVk0QV+tiAyqjCqpwMnCZUqqcsisnYcj2Rf
 6J3j6MeSY94yJ16JD6nn2MsiNDARTCtfvgWJf7DA4HvgK2FPM5WXPsnUVUVuUxjK7Rqq
 uWUMHRbNlt/n0W0SzA+0pR93Wy0TJVglY/FY4mXItDk/sADLlMccgtvqTs7a8uRTfYHv
 PkFreOvXw984+0XwQNL43pVTv75DUwolXuXeli0hu6af3vVsJOSUuQmodnIWjQHuTKj1 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb36uh3y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:41:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 342DdT5Y009271;
        Tue, 2 May 2023 13:41:06 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb36uh3rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:41:05 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3428snLY031369;
        Tue, 2 May 2023 13:40:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3q8tv6sb2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:40:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342Dendi20316836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 13:40:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 073562004B;
        Tue,  2 May 2023 13:40:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 374F620049;
        Tue,  2 May 2023 13:40:48 +0000 (GMT)
Received: from [9.171.18.35] (unknown [9.171.18.35])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 13:40:48 +0000 (GMT)
Message-ID: <e9fb74a702bb304757fea84a978704de62df666d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 21/38] parport: PC style parport depends on HAS_IOPORT
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 02 May 2023 15:40:47 +0200
In-Reply-To: <e2ce3f02-988c-423d-a1c1-2796ab95026c@app.fastmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-22-schnelle@linux.ibm.com>
         <e2ce3f02-988c-423d-a1c1-2796ab95026c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HD0fEbiuVhUrxQBye-iKHLFIye-5M8Ii
X-Proofpoint-GUID: seYpEKnBqUk9_qmLztdg5NtiD5KP2qO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=297 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-03-14 at 15:12 +0100, Arnd Bergmann wrote:
> > On Tue, Mar 14, 2023, at 13:11, Niklas Schnelle wrote:
> > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and fr=
iends
> > > > not being declared. As PC style parport uses these functions we nee=
d to
> > > > handle this dependency.
> > > >=20
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >=20
> > > >=20
> > > >  menuconfig PARPORT
> > > >  	tristate "Parallel port support"
> > > > -	depends on HAS_IOMEM
> >=20
> > I would leave this dependency, or maybe make it 'HAS_IOMEM || HAS_IOPOR=
T'.
> > at least the parport_atari driver uses MMIO instead of PIO.
> >=20
> > > >  	help
> > > >  	  If you want to use devices connected to your machine's parallel=
 port
> > > >  	  (the connector at the computer with 25 holes), e.g. printer, ZI=
P
> > > > @@ -42,7 +41,8 @@ if PARPORT
> > > >=20
> > > >  config PARPORT_PC
> > > >  	tristate "PC-style hardware"
> > > > -	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
> > > > +	depends on ARCH_MIGHT_HAVE_PC_PARPORT
> > > > +	depends on HAS_IOPORT
> > > >  	help
> > > >  	  You should say Y here if you have a PC-style parallel port. All
> > > >  	  IBM PC compatible computers and some Alphas have PC-style
> >=20
> > This would revert 66bcd06099bb ("parport_pc: Also enable driver for
> > PCI systems"), so I think this is wrong. You can drop the !S390
> > by adding HAS_IOPORT as a dependency, but the other line should still
> > be=20
> >=20
> >        depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI
> >    =20
> >=20
> >     Arnd

Ok changed for v4. Just saw that commit even nicely references our lack
of I/O ports :-)


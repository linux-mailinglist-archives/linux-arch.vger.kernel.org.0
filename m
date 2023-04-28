Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3D6F1971
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbjD1N2V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjD1N2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:28:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED51FC6;
        Fri, 28 Apr 2023 06:28:18 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SDRo3g031091;
        Fri, 28 Apr 2023 13:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xN0N0nEHYTHT3aHanWrFgcKMgv5F9/5r+uCyl997wVM=;
 b=gtfUzQjHeGoahNZusOotn+oYePQ/6Yp6wALmL7YC4wogQS6O0iXvKPzB9Ab2Un+COeZZ
 BxMpcnpcelqWnll/kEI09c1HJ064RRFtsx3f79cTWMl3POoz8Nlh3FXHC1cdZxkwrHOV
 fuj8m4t4J1TEKSsqHvkSLlBTAcyaM0cZ6GojsqeGF7hB/0u4Qd2lT/KMKCrhGOMfBcGi
 mX8WZGcAdDsRyp6F2Nj8TGzfsUpmX2H99G3NUdfkaJMBgxAorinWv2Att9PAFITsX4as
 xQh67oGf3HVSwSmmXFw+bPfJXkZMKYi2U+aPKoHnoTxaUfN6gVkQIG2BUq3o98PIq1ic MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8dqp2j48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:28:04 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SDS3IQ032296;
        Fri, 28 Apr 2023 13:28:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8dqp2j25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:28:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33S48dt3012258;
        Fri, 28 Apr 2023 13:28:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3q47773kdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 13:28:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SDRv0Y23331358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 13:27:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF04C2004B;
        Fri, 28 Apr 2023 13:27:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D78432004D;
        Fri, 28 Apr 2023 13:27:56 +0000 (GMT)
Received: from [9.171.55.26] (unknown [9.171.55.26])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 13:27:56 +0000 (GMT)
Message-ID: <017df2d4fa3f2ed5f08106ba39bec3f0db382a8f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 05/38] counter: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-iio@vger.kernel.org
Date:   Fri, 28 Apr 2023 15:27:56 +0200
In-Reply-To: <ZBBrl4v9L8Zw+AsN@fedora>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-6-schnelle@linux.ibm.com> <ZBBrl4v9L8Zw+AsN@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aItC10cNzchiV006qSd16xw7jSl83UXj
X-Proofpoint-GUID: llGHDROBe3Rt--RgnPvEdP9U5ngfr7nj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304280107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-03-14 at 08:41 -0400, William Breathitt Gray wrote:
> On Tue, Mar 14, 2023 at 01:11:43PM +0100, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/counter/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > index b5ba8fb02cf7..1cae5097217e 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -15,6 +15,7 @@ if COUNTER
> >  config 104_QUAD_8
> >  	tristate "ACCES 104-QUAD-8 driver"
> >  	depends on (PC104 && X86) || COMPILE_TEST
> > +	depends on HAS_IOPORT
> >  	select ISA_BUS_API
> >  	help
> >  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
> > --=20
> > 2.37.2
>=20
> Is HAS_IOPORT needed because this driver uses devm_ioport_map()? The
> inb()/outb() functions and such are not used in this driver, so would it
> suffice to depend on HAS_IOPORT_MAP instead?
>=20
> William Breathitt Gray

Yes, good catch HAS_IOPORT_MAP indeed seems to be enough. Will be
changed in v4. Thankfully the Kconfig change to add HAS_IOPORT has
already landed in Linus' tree so for the future these per subsystem
patches can be merged independently.

Thanks,
Niklas

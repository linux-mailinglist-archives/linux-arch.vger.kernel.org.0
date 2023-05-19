Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23470988E
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjESNkx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjESNkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 09:40:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C751EE73;
        Fri, 19 May 2023 06:40:28 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDWiNT007742;
        Fri, 19 May 2023 13:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PQZV6WbfIzLwO7RQAeytOdXrS1u3pDh3o9MWQx8ku1U=;
 b=gA9Rfn03DA8yBJ33AIed+LeDuIzFzPVVv9r8kUyE6KaadebmvfsHXYzXVPnOMDUmeEOK
 pwIqZWGlXE/MaOMZHSC46aKoMemb4BMUU6xvEG5c5EJT47fsFVgJrUYDQWbrcCoZkl+j
 1MiQaNeWM/pkhatxze96qF2osm9QhR37SK+KXn2YqL+qe90sKy+7LXYQINDbWTi+8bKr
 3NQ8Dvujbfg41qmlrZ9svjbfwB/+AkjzR1vgbfMxxYGzJgFXqtLbOjM2Om07NE8gKdo7
 W/EOWHJgutTvqWZqUG5bwXyhsjNXsjEVBuYFz0z48dupc9eZgebLnMv3BMzZl8HUM3QE Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp9tm8v08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:40:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34JDExb2007307;
        Fri, 19 May 2023 13:40:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp9tm8ucr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:40:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCaGmr001696;
        Fri, 19 May 2023 13:40:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264u6kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:40:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JDdwRE56623362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:39:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D36A20043;
        Fri, 19 May 2023 13:39:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77DBF20040;
        Fri, 19 May 2023 13:39:57 +0000 (GMT)
Received: from [9.171.0.172] (unknown [9.171.0.172])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 13:39:57 +0000 (GMT)
Message-ID: <abc02dc2af7563ae26bf0d0ddd927d9b4a21dda3.camel@linux.ibm.com>
Subject: Re: [PATCH v4 05/41] counter: add HAS_IOPORT dependencies
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
Date:   Fri, 19 May 2023 15:39:57 +0200
In-Reply-To: <231dcebc57c2e43ba65d007b60d3d446d9ed71c8.camel@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-6-schnelle@linux.ibm.com> <ZGbQYzXK8InMqkxu@fedora>
         <6f4d672ba7136f2b01ea9ee69687b16168eddb8d.camel@linux.ibm.com>
         <231dcebc57c2e43ba65d007b60d3d446d9ed71c8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j8msTN56Z494fexI_vO3fR9R23Kldjpb
X-Proofpoint-GUID: McC3meHO21U0BBl93HgOh0g2SsyrdTsg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 mlxlogscore=744 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2023-05-19 at 15:38 +0200, Niklas Schnelle wrote:
> On Fri, 2023-05-19 at 15:17 +0200, Niklas Schnelle wrote:
> > On Thu, 2023-05-18 at 21:26 -0400, William Breathitt Gray wrote:
> > > On Tue, May 16, 2023 at 01:00:01PM +0200, Niklas Schnelle wrote:
> > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and fr=
iends
> > > > not being declared. We thus need to add HAS_IOPORT as dependency fo=
r
> > > > those drivers using them.
> > > >=20
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > >=20
> > > Hi Niklas,
> > >=20
> > > The change itself is fine, but please update the description to refle=
ct
> > > that this is adding a depends on HAS_IOPORT_MAP rather than HAS_IOPOR=
T,
> > > along with the reason why it's needed (i.e. devm_ioport_map() is used=
).
> > >=20
> > > Thanks,
> > >=20
> > > William Breathitt Gray
> > >=20
> > >=20
> >=20
> > Right, this clearly needs adjustment. I went with the following commit
> > message for v5:
> >=20
> > "counter: add HAS_IOPORT_MAP dependency
> >=20
> > The 104_QUAD_8 counter driver uses devm_ioport_map() without depending
> > on HAS_IOPORT_MAP. This causes compilation to fail on platforms such as
> > s390 which do not support I/O port mapping. Add the missing
> > HAS_IOPORT_MAP dependency to fix this."
> >=20
>=20
> Just noticed this isn't entirely correct. As devm_ioport_map() has an
> empty stub for HAS_IOPORT_MAP=3Dn this doesn't lead to a compile error it
> just doesn't work. Will reword to "This causes the driver to not be
> useable on platforms ..."

s/useable/usable/

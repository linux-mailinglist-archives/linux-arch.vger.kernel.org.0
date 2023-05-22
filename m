Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86170BA45
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEVKmk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjEVKmj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 06:42:39 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BE1B3;
        Mon, 22 May 2023 03:42:37 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9cOEB010154;
        Mon, 22 May 2023 10:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oAtcR3CjUqUoLFIujCSD3j+neQkPVsD2jlqdXWw8s2o=;
 b=Y7QHsYYh2ESn04M12mL1SyRfdaxlo5dlcn5VT6ul4Cc6wsUs5I75sksygIGiFqWX4Ba/
 N0nUyT2bg9A5r3UdIbSCZdHZNO81EEwM0hJ56/nJBff/r+KQzlF/eOkQjGttTwqbFccn
 A6N6lQeMYvvSfaxyFWFwQQFAiJImRmgkY/Te1XPCJxEe6S5InprnKwbmhKhgu+JrnFqt
 8e9JyIjw6ujKvCv7LHpbDRH+pw0uqpcifezDQPiHWlu4ZmCIqmHMc6lCW83efbKVFx1S
 mNZsMJ3VT2uvn6X2bCHO3zPARcBPhPbUNr3baSCBUr4Pj6VcZgPxgkrIfNI9H2280dls bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqee6t7c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:42:22 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MAahkO010615;
        Mon, 22 May 2023 10:42:21 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqee6t7b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:42:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9r4b4023774;
        Mon, 22 May 2023 10:42:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qppa4rrw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 10:42:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MAgGMh7930206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 10:42:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BF712004D;
        Mon, 22 May 2023 10:42:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6632720040;
        Mon, 22 May 2023 10:42:15 +0000 (GMT)
Received: from [9.171.23.45] (unknown [9.171.23.45])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 10:42:15 +0000 (GMT)
Message-ID: <cb6aa00b1901abb572e69e218a5500f2cd1561ce.camel@linux.ibm.com>
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
Date:   Mon, 22 May 2023 12:42:15 +0200
In-Reply-To: <ZGeF1K0Yxu9lTgN2@fedora>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-6-schnelle@linux.ibm.com> <ZGbQYzXK8InMqkxu@fedora>
         <6f4d672ba7136f2b01ea9ee69687b16168eddb8d.camel@linux.ibm.com>
         <231dcebc57c2e43ba65d007b60d3d446d9ed71c8.camel@linux.ibm.com>
         <abc02dc2af7563ae26bf0d0ddd927d9b4a21dda3.camel@linux.ibm.com>
         <ZGeF1K0Yxu9lTgN2@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cA0g1KbNT_1V-Wdsk-GcXzW4oULP6J5E
X-Proofpoint-ORIG-GUID: 8B6fhOHNamOcgpya-zvAw4kmkSBF0QJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=607 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2023-05-19 at 10:21 -0400, William Breathitt Gray wrote:
> On Fri, May 19, 2023 at 03:39:57PM +0200, Niklas Schnelle wrote:
> > On Fri, 2023-05-19 at 15:38 +0200, Niklas Schnelle wrote:
> > > On Fri, 2023-05-19 at 15:17 +0200, Niklas Schnelle wrote:
> > > > On Thu, 2023-05-18 at 21:26 -0400, William Breathitt Gray wrote:
> > > > > On Tue, May 16, 2023 at 01:00:01PM +0200, Niklas Schnelle wrote:
> > > > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() an=
d friends
> > > > > > not being declared. We thus need to add HAS_IOPORT as dependenc=
y for
> > > > > > those drivers using them.
> > > > > >=20
> > > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > >=20
> > > > > Hi Niklas,
> > > > >=20
> > > > > The change itself is fine, but please update the description to r=
eflect
> > > > > that this is adding a depends on HAS_IOPORT_MAP rather than HAS_I=
OPORT,
> > > > > along with the reason why it's needed (i.e. devm_ioport_map() is =
used).
> > > > >=20
> > > > > Thanks,
> > > > >=20
> > > > > William Breathitt Gray
> > > > >=20
> > > > >=20
> > > >=20
> > > > Right, this clearly needs adjustment. I went with the following com=
mit
> > > > message for v5:
> > > >=20
> > > > "counter: add HAS_IOPORT_MAP dependency
> > > >=20
> > > > The 104_QUAD_8 counter driver uses devm_ioport_map() without depend=
ing
> > > > on HAS_IOPORT_MAP. This causes compilation to fail on platforms suc=
h as
> > > > s390 which do not support I/O port mapping. Add the missing
> > > > HAS_IOPORT_MAP dependency to fix this."
> > > >=20
> > >=20
> > > Just noticed this isn't entirely correct. As devm_ioport_map() has an
> > > empty stub for HAS_IOPORT_MAP=3Dn this doesn't lead to a compile erro=
r it
> > > just doesn't work. Will reword to "This causes the driver to not be
> > > useable on platforms ..."
> >=20
> > s/useable/usable/
>=20
> 104_QUAD_8 has an explicit dependency on PC104 and X86, so I don't think
> it would ever be used outside of x86 platforms. Does it still make sense
> to have the HAS_IOPORT_MAP dependency in this case?
>=20
> William Breathitt Gray

Well, yes and no, you're right that it doesn't really cause compile
issues despite the "|| COMPILE_TEST" albeit the code could never work.
Still, I'd add the dependency. At the very least it serves as
documentation and maybe in the future someone will want to remove those
empty stubs for HAS_IOPORT_MAP=3Dn.

Thanks
Niklas

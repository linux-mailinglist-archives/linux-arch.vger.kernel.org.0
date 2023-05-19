Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461770987D
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjESNjN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 09:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjESNjM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 09:39:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECD3A1;
        Fri, 19 May 2023 06:39:11 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JDZbYj026667;
        Fri, 19 May 2023 13:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vlNLOkW4P+c82kerqENApZz5QxGt2G9NEz5f6M+SyW8=;
 b=NCbTUo5qCanzpCXd0iXxPPBvA06ivvQQUeV0gCLsS3fRyv7wdnotexygLXl1naJ1Hm9z
 0+qPmJyvO9wJJ0bM9OtgW9pwAhrrE/VvAg2WpccAY0ikLZhL+HLFi9w7OoJbAwCUzGzb
 E4PxlvTHz1vfZVRILDyT2y2bqDw2zBnW1bjTQhjU9sIhpwKSfu01xCLOqhK7OZkDAjch
 PUYziiJeVAWnQQxhnYnfkuOtPA2wOmHA2qqfCzeOoNym0NzLNy/nQY/X4F5+xIfIpA9j
 soVNlsnbzLkck0QzvjaODOHB+RhklvbomoujEeVOZRk542zgf7WviHqD8anSGTFW6CgM rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp9xvrg13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:38:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34JDaBEi030349;
        Fri, 19 May 2023 13:38:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp9xvrfsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:38:52 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34J9cHSj011943;
        Fri, 19 May 2023 13:38:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264u6k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 13:38:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JDcTQF58786224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 13:38:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AE8020040;
        Fri, 19 May 2023 13:38:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 289E520043;
        Fri, 19 May 2023 13:38:28 +0000 (GMT)
Received: from [9.171.0.172] (unknown [9.171.0.172])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 13:38:28 +0000 (GMT)
Message-ID: <231dcebc57c2e43ba65d007b60d3d446d9ed71c8.camel@linux.ibm.com>
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
Date:   Fri, 19 May 2023 15:38:27 +0200
In-Reply-To: <6f4d672ba7136f2b01ea9ee69687b16168eddb8d.camel@linux.ibm.com>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-6-schnelle@linux.ibm.com> <ZGbQYzXK8InMqkxu@fedora>
         <6f4d672ba7136f2b01ea9ee69687b16168eddb8d.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wOWasz6S_H3UHQen9j8mB-Z-AaNmuAb_
X-Proofpoint-GUID: pxNf_b8ibloziTlfxmAUajBCK9IqLZ0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_09,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=735 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2023-05-19 at 15:17 +0200, Niklas Schnelle wrote:
> On Thu, 2023-05-18 at 21:26 -0400, William Breathitt Gray wrote:
> > On Tue, May 16, 2023 at 01:00:01PM +0200, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and frie=
nds
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> > >=20
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >=20
> > Hi Niklas,
> >=20
> > The change itself is fine, but please update the description to reflect
> > that this is adding a depends on HAS_IOPORT_MAP rather than HAS_IOPORT,
> > along with the reason why it's needed (i.e. devm_ioport_map() is used).
> >=20
> > Thanks,
> >=20
> > William Breathitt Gray
> >=20
> >=20
>=20
> Right, this clearly needs adjustment. I went with the following commit
> message for v5:
>=20
> "counter: add HAS_IOPORT_MAP dependency
>=20
> The 104_QUAD_8 counter driver uses devm_ioport_map() without depending
> on HAS_IOPORT_MAP. This causes compilation to fail on platforms such as
> s390 which do not support I/O port mapping. Add the missing
> HAS_IOPORT_MAP dependency to fix this."
>=20

Just noticed this isn't entirely correct. As devm_ioport_map() has an
empty stub for HAS_IOPORT_MAP=3Dn this doesn't lead to a compile error it
just doesn't work. Will reword to "This causes the driver to not be
useable on platforms ..."

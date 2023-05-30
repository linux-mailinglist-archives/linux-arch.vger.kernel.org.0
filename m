Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCA7159FE
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 11:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjE3JYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjE3JYG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 05:24:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218D19C;
        Tue, 30 May 2023 02:23:03 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U889RE007028;
        Tue, 30 May 2023 09:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3+SrpC5lFpvawrlepV8oQTbVM0CH6Hg4sbjzDYaAw18=;
 b=cq9tA98om+I5mv5zaxmDTIudlC0YH5EKdjwmSgYU3jf5MAyd/ovscVasl2OWLLDv4ri0
 kYK7L8jh9PMDtDZ8WV1ubYMYmZkUGpzQ0CfFssaaWhY9C00EDlr/Y4ZZFabAbg7XSj/k
 mXxbdZPbHQAXbv3ABRn9QUy0hbtRYoMpupoGtgZSiJKofTDJKPzuhslj4ITfHAbYCnhL
 JR8wl9ApVat5d6wG4NXuwfDc75ukml8E1oxlJRzncVoRY9syjBadHUiUouPgrFTiQkJF
 JxJvhRQf5CKaUTqgaIvldODaWa+XW2vy1vSsqbYakKz4gk1U0czQZgQvBRnpDCuKvKcB ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwc8rud6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 09:21:14 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34U9BrFG031693;
        Tue, 30 May 2023 09:21:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwc8rud5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 09:21:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U4nTbh029752;
        Tue, 30 May 2023 09:21:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e1cuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 09:21:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34U9L7Pc33685888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 09:21:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26BCD20043;
        Tue, 30 May 2023 09:21:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7B8A20040;
        Tue, 30 May 2023 09:21:06 +0000 (GMT)
Received: from [9.152.212.237] (unknown [9.152.212.237])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 09:21:06 +0000 (GMT)
Message-ID: <3c08f8877ec4ff8689415cf720efc0e355f3c3cb.camel@linux.ibm.com>
Subject: Re: [PATCH v5 14/44] iio: ad7606: Kconfig: add HAS_IOPORT
 dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
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
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-iio@vger.kernel.org
Date:   Tue, 30 May 2023 11:21:06 +0200
In-Reply-To: <20230528195503.4dbeb358@jic23-huawei>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
         <20230522105049.1467313-15-schnelle@linux.ibm.com>
         <20230528195503.4dbeb358@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sGKL0EtCJUOjTcZob_MvNWUVpKS7aZ8M
X-Proofpoint-GUID: L09UMELiLHybn3jpoFkCvYCmDqn0LIof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_06,2023-05-29_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxlogscore=756 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 2023-05-28 at 19:55 +0100, Jonathan Cameron wrote:
> On Mon, 22 May 2023 12:50:19 +0200
> Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>=20
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> I already picked this up for the IIO tree already as I don't think there =
are
> any dependencies.
>=20
> Jonathan
>=20
>=20

Yes thanks, I only resent it as part of this series such that applying
the series on a current -rc directly does not break the last commit. In
the future I'll sent remaining patches per-subsystem and based on
linux-next so I won't have to resent those patches that have already
been applied.

Thanks,
Niklas

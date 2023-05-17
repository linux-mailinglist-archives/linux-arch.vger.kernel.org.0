Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEF706296
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjEQIQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjEQIQf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 04:16:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FB310F5;
        Wed, 17 May 2023 01:16:32 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H8ERBC031684;
        Wed, 17 May 2023 08:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jHcbHnfbdQuR5BTOBdCcxq2BsjGW6EBNkLy7fTHbr1A=;
 b=teD9uN0fuaXrGlwoqn89b50+4cbTWRXaSxaXFqo5GQ6F/teEw6QjCIHNky6Vf5cWajUY
 NZugmN908Db9yDWU1bBz/Mjw7TgUEQLH7P/Ym4zOE5GJlM5y+A4oVnBi/7zbTK7J8Crb
 eNd9gL95tkNz96QIxxAY74FOX8gbloftMKYznpZCUxInF3YN5Zvm2+54VSHt6+WDIB8/
 mjgKS8YHhV0haG28ngn5nVRUln7v3XGwE00mFznibbtAd2L+Wh225hE0MGwa/U0L8GY6
 9MZiInFJPoEcT9wvoPEXrCUObKL1mgYkp3oeI07qXQiNsKRXGwoLhF3dII+DII7tRV3D Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmtep1us0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:16:01 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H8FrWj004373;
        Wed, 17 May 2023 08:16:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qmtep1ur4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:16:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1npnG015870;
        Wed, 17 May 2023 08:15:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264t2fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 08:15:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34H8Ft4U18088450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 08:15:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA6FE2004E;
        Wed, 17 May 2023 08:15:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD38A2004B;
        Wed, 17 May 2023 08:15:53 +0000 (GMT)
Received: from [9.179.22.107] (unknown [9.179.22.107])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 17 May 2023 08:15:53 +0000 (GMT)
Message-ID: <b7100dd4296db4bc115a675c49b736d35ad41d9e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 28/41] rtc: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
        linux-rtc@vger.kernel.org
Date:   Wed, 17 May 2023 10:15:53 +0200
In-Reply-To: <alpine.DEB.2.21.2305161641510.50034@angie.orcam.me.uk>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
         <20230516110038.2413224-29-schnelle@linux.ibm.com>
         <alpine.DEB.2.21.2305161641510.50034@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _hYOEqK4GWaQut6GjWpvex8F7dQL1WFh
X-Proofpoint-GUID: O1K-IW9MNrzalpcuyf78kt9FXfxuCyJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=826 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-05-16 at 16:49 +0100, Maciej W. Rozycki wrote:
> On Tue, 16 May 2023, Niklas Schnelle wrote:
>=20
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 753872408615..9ae082b14c44 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
> >  config RTC_DRV_CMOS
> >  	tristate "PC-style 'CMOS'"
> >  	depends on X86 || ARM || PPC || MIPS || SPARC64
> > +	depends on HAS_IOPORT
>=20
>  NAK, this hasn't addressed my input for v2.  Arnd also followed up with=
=20
> similar observations with v3.
>=20
>   Maciej

Ah sorry about that, I had marked the mail as TODO but going over it
missed the proposed fix. Changed this to "depends on HAS_IOPORT ||
ARCH_DECSTATION" for v5.

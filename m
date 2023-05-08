Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5826FB3F6
	for <lists+linux-arch@lfdr.de>; Mon,  8 May 2023 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjEHPj3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 May 2023 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjEHPj2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 May 2023 11:39:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C665AB;
        Mon,  8 May 2023 08:39:27 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348FSUPJ031602;
        Mon, 8 May 2023 15:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5EqBMa4gR0QbDtx8JIBT/ijJxpZC9W9h/jf+aACfoa4=;
 b=HXOweJalFLJ4p/2scyuwFnXGFrpQEvBA7T6Gsd9hfUeos76y5GXZQw8oCKrQiuz/xwKX
 np+fXcPiDgeJT+qelxypHduJq5MixQd8QUvM5R9099iXmNJ17c9kNFndWZF9Bc6M0HT8
 UQ+bqdZRFYxwJyb4eAk+CB1XYqGREZ5DLRrfbaB7gjUpaMMsRFIW8p2Vpj9EnHNW2REO
 FCsOCZcKNlpbI+kHqMAwNx35oZ5VGwPpU0n1eWxiSECsjt8QV4Zy63wObK+hVQT4cdL2
 Xh6P24GpDB+B0ydbGM4qn4arxXHkvELvBR7edtlhTQpgXbC5ItCfWEJ2DqSmMAMtHhZd Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qf3rmgq84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:38:56 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 348FT9ce001343;
        Mon, 8 May 2023 15:37:39 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qf3rmgk1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:37:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3483Rkbm001141;
        Mon, 8 May 2023 15:36:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qdeh6gywq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:36:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 348FaW1Q44826890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 May 2023 15:36:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8E720043;
        Mon,  8 May 2023 15:36:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8473220040;
        Mon,  8 May 2023 15:36:31 +0000 (GMT)
Received: from [9.171.75.120] (unknown [9.171.75.120])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  8 May 2023 15:36:31 +0000 (GMT)
Message-ID: <aa68b4afdca34bf3bfd2439b03e6f9bcfad94903.camel@linux.ibm.com>
Subject: Re: [PATCH v3 28/38] rtc: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
Date:   Mon, 08 May 2023 17:36:31 +0200
In-Reply-To: <202303141252027ef5511a@mail.local>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-29-schnelle@linux.ibm.com>
         <202303141252027ef5511a@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HRugoYqyIQPXXC-tvn11OSwiaFsesSiz
X-Proofpoint-ORIG-GUID: o20aFgLcvaCJXNwI7RQ5eYI4YmrObTiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=846 adultscore=0 phishscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2023-03-14 at 13:52 +0100, Alexandre Belloni wrote:
> Hello,
>=20
> On 14/03/2023 13:12:06+0100, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/rtc/Kconfig | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 5a71579af0a1..20aa77bf0a9f 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
> >  config RTC_DRV_CMOS
> >  	tristate "PC-style 'CMOS'"
> >  	depends on X86 || ARM || PPC || MIPS || SPARC64
> > +	depends on HAS_IOPORT
>=20
> Did you check that this will not break platforms that doesn't have RTC_PO=
RT defined?
> >=20

From what I can tell the CMOS_READ() macro this driver relies on uses
some form of inb() style I/O port access in all its definitions. So my
understanding is that this device is always accessed via I/O ports even
if the variants differ slightly and would make no sense on a platform
without any way of accessing I/O ports which is what lack of HAS_IOPORT
means. From what I can see even without RTC_PORT being defined the
CMOS_READ is still used. Hope that answers your question?

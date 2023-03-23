Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E551D6C68A9
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 13:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCWMn0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjCWMnV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 08:43:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DA29155;
        Thu, 23 Mar 2023 05:43:19 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NAje8b007776;
        Thu, 23 Mar 2023 12:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tuNKUZojerTn1bhSdxusIxZNGrSU5CH43HCACIz8URQ=;
 b=FInZGXOYg/XEcnd1VhWmVTrVdfGiW7LqeRaEy+e71CA1WMsnStkGv8Rm8YSAnfg93O99
 qdCXEDeYspXVYL9lgHvCc96MGJ8CNY/4qOyGsIk6U4eEjTQDLFbTcVNRVBc4HLR2v1mE
 4m69SXiUTI0P2rDin3j3kY/YedUimiDrlzIZLEOPrDW2ISkx4em3jwGVZwmEDxg9KFUZ
 DBVNytGC5y6tYqoHVGflCzdeZZMRlHjjjCWoPCDB5bYR6qr8l0EgmG7WRhrWuWBHyIjb
 QG49DSh9LOjTYjJWQcCo99WtT8EZLCZGpXUVVkpvUj7gDAs7VxtFHiPLG0Dw+6IiTHuq MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgk22e4vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:42:58 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NBuY2a005246;
        Thu, 23 Mar 2023 12:42:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgk22e4uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:42:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NAFJi1017094;
        Thu, 23 Mar 2023 12:42:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6fbj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:42:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NCgqlR24642082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 12:42:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62F62004D;
        Thu, 23 Mar 2023 12:42:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 800EC20040;
        Thu, 23 Mar 2023 12:42:51 +0000 (GMT)
Received: from [9.171.87.16] (unknown [9.171.87.16])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 12:42:51 +0000 (GMT)
Message-ID: <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
Subject: Re: [PATCH v3 15/38] leds: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
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
        linux-leds@vger.kernel.org
Date:   Thu, 23 Mar 2023 13:42:51 +0100
In-Reply-To: <20230316161442.GV9667@google.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-16-schnelle@linux.ibm.com>
         <20230316161442.GV9667@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f8YjC6l8VFrCUnBpp9LLREtXx9Yu7-Tu
X-Proofpoint-GUID: RG3Rr7zNt7wvgtHtzGEBAkrMMONzN-nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=658 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230094
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
> On Tue, 14 Mar 2023, Niklas Schnelle wrote:
>=20
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/leds/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Applied, thanks

Sorry should have maybe been more clear, without patch 1 of this series
this won't work as the HAS_IOPORT config option is new and will be
missing otherwise. There's currently two options of merging this,
either all at once or first only patch 1 and then the additional
patches per subsystem until finally the last patch can remove
inb()/outb() and friends when HAS_IOPORT is unset.

Thanks,
Niklas

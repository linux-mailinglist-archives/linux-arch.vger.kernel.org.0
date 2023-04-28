Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC56F1AD8
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 16:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjD1Oup (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjD1Oum (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 10:50:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E118C1731;
        Fri, 28 Apr 2023 07:50:41 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SElEQq020668;
        Fri, 28 Apr 2023 14:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ij5/pIPsABSx+nguVBG26XMhfbmd0DRI5am3Q4oKajU=;
 b=EVlLcDXqdsTuQtgAUooBcZqqQq8p0zfV5razL0KWjrrd3yNEnWltPlJWrETVNuaEtw8A
 zaSHK7vsq++FNZPHCWkyLtZCEGjkMdcvfKViYynIijYq4MpeJgymMQEGh5Ar8ybczYiP
 0+6kNjAnuoL2irocjyI98qQNwexEyeAxRENYzQGGyolybPhNUQI7iOZ/2KZuVdLU7AW6
 6flYO+aXGJPkfJnNL0rh3Adga6G6Ni+YmaR4ELMQFv0NpAlllMd4zhuQrQK0tdhBdVQ7
 iBCO8YWyfC5Y0hMyIfFGfJmi9hFMVf4REVzJi5PV0cjDrkijHjHp9oHLFsp4wVe2q8k2 ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8fwu0kum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:50:29 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SEjcj7013601;
        Fri, 28 Apr 2023 14:50:28 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8fwu0kth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:50:28 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33S4ajFE025502;
        Fri, 28 Apr 2023 14:50:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3q46ug2yn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:50:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SEoN6146137850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 14:50:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E306720043;
        Fri, 28 Apr 2023 14:50:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E85F20040;
        Fri, 28 Apr 2023 14:50:23 +0000 (GMT)
Received: from [9.171.55.26] (unknown [9.171.55.26])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 14:50:23 +0000 (GMT)
Message-ID: <e6cfe32c126661fc9e14352815885fca7ff8df7c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 13/38] Input: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-input@vger.kernel.org
Date:   Fri, 28 Apr 2023 16:50:22 +0200
In-Reply-To: <CAMuHMdUbaFhb3HURhSfrkDyq_cz6z=S3TtTr0-5f6svho9MftQ@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-14-schnelle@linux.ibm.com>
         <CAMuHMdUbaFhb3HURhSfrkDyq_cz6z=S3TtTr0-5f6svho9MftQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fPNP2HiphX2x8CgvPAxB6m6_PP401XiS
X-Proofpoint-ORIG-GUID: olGzK3-JJcjqId6YoW5EPRRjno8PuvF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=782
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2023-03-15 at 09:22 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
>=20
> On Tue, Mar 14, 2023 at 1:12=E2=80=AFPM Niklas Schnelle <schnelle@linux.i=
bm.com> wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Thanks for your patch!
>=20
> > --- a/drivers/input/serio/Kconfig
> > +++ b/drivers/input/serio/Kconfig
> > @@ -75,6 +75,7 @@ config SERIO_Q40KBD
> >  config SERIO_PARKBD
> >         tristate "Parallel port keyboard adapter"
> >         depends on PARPORT
> > +       depends on HAS_IOPORT
> >         help
> >           Say Y here if you built a simple parallel port adapter to att=
ach
> >           an additional AT keyboard, XT keyboard or PS/2 mouse.
>=20
> This driver seems to use only the parport and serio APIs, so it might
> work on systems without HAS_IOPORT.  Dunno for sure.
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20

Thanks, yes you're right this driver compiles fine without inb()/outb()
etc. I removed the dependency, not sure if it used to have a dependency
or this was a mixup but it's corrected for v4.

Thanks,
Niklas

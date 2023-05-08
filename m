Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4666FB5BD
	for <lists+linux-arch@lfdr.de>; Mon,  8 May 2023 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjEHRJc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 May 2023 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHRJb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 May 2023 13:09:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CBE124;
        Mon,  8 May 2023 10:09:29 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348H75oL001685;
        Mon, 8 May 2023 17:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gFaCuvY2vx4m7h1LG179ezcPRiWk5KC5ku27Zp3HRVY=;
 b=a/2NEKLiGFYdH7WALohtocwoSCKLgQtoutdl7BXYPOmg2wLZJ/R0lHjGLTyScs3YhDU6
 vTg5MNcenvatQzATWuWVFqH7qJWU70zuD5izLDuIBwgAHIM7DrsXXSBD8H8qVdhWE+XX
 dkAaKTCGuMgSST5RklnYPZ6lnw2ISKl7Ckhs/I8aqFv1Hs4ODmNfBeezajF7l2s04qV7
 7O2p8+cjd3SzRReCQPQdWBiVZa9NIdJPd0Qt55q7PHYps7Y0x/aArAKWfXUDPnosfki6
 ahbL/Kz5dKhdUYlxiLvJQV57g6wQj614g/IWsZ3tIsXjn/vrk2oXG4Vd21JvJrO225xL /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qf4wegenv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 17:09:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 348H7YZh003716;
        Mon, 8 May 2023 17:09:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qf4wegemh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 17:09:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 348BHJph001139;
        Mon, 8 May 2023 17:09:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qde5fh1d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 17:09:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 348H95H343909530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 May 2023 17:09:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 397742005A;
        Mon,  8 May 2023 17:09:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BA8520043;
        Mon,  8 May 2023 17:09:04 +0000 (GMT)
Received: from [9.171.75.120] (unknown [9.171.75.120])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  8 May 2023 17:09:04 +0000 (GMT)
Message-ID: <767b9b0f53ef1a8411c9eeff87ceb14182c05204.camel@linux.ibm.com>
Subject: Re: [PATCH v3 35/38] video: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-fbdev@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Mon, 08 May 2023 19:09:04 +0200
In-Reply-To: <ZBx5aLo5h546BzBt@intel.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-36-schnelle@linux.ibm.com>
         <CAMuHMdW4f8GJ-kFDPg6Ao=g3ZAXq79u9nUZ_dW1LonHu+vxk8Q@mail.gmail.com>
         <ZBGbxDWEhqr8hhgU@intel.com>
         <917b95c9af1b80843b8a361d1b7fa337a25105e7.camel@linux.ibm.com>
         <ZBx5aLo5h546BzBt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VIyPrQTqfWglaxUow7cylDCznu_INqJ2
X-Proofpoint-ORIG-GUID: rPgNboSmJ8jIziVWBJ4TQzQzTThTbCU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=562 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305080115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-03-23 at 18:08 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> On Thu, Mar 23, 2023 at 03:17:38PM +0100, Niklas Schnelle wrote:
> > On Wed, 2023-03-15 at 12:19 +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Wed, Mar 15, 2023 at 09:16:50AM +0100, Geert Uytterhoeven wrote:
> > > > Hi Niklas,
> > > >=20
> > > > On Tue, Mar 14, 2023 at 1:13=E2=80=AFPM Niklas Schnelle <schnelle@l=
inux.ibm.com> wrote:
> > > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and =
friends
> > > > > not being declared. We thus need to add HAS_IOPORT as dependency =
for
> > > > > those drivers using them and guard inline code in headers.
> > > > >=20
> > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > >=20
> > > > Thanks for your patch!
> > > >=20
> > > > > --- a/drivers/video/fbdev/Kconfig
> > > > > +++ b/drivers/video/fbdev/Kconfig
> > > >=20
> > > > > @@ -1284,7 +1285,7 @@ config FB_ATY128_BACKLIGHT
> > > > >=20
> > > > >  config FB_ATY
> > > > >         tristate "ATI Mach64 display support" if PCI || ATARI
> > > > > -       depends on FB && !SPARC32
> > > > > +       depends on FB && HAS_IOPORT && !SPARC32
> > > >=20
> > > > On Atari, this works without ATARI_ROM_ISA, hence it must not depen=
d
> > > > on HAS_IOPORT.
> > > > The only call to inb() is inside a section protected by #ifdef
> > > > CONFIG_PCI. So:
> > >=20
> > > That piece of code is a nop anyway. We immediately overwrite
> > > clk_wr_offset with a hardcoded selection after the register reads.
> > > So if you nuke that nop code then no IOPORT dependency required
> > > at all.
> > >=20
> >=20
> > I agree this "looks" like a nop but are we sure the inb() doesn't have
> > side effects?=C2=A0
>=20
> Yes. It's just trying to check which PLL dividers/etc. are currently
> used. In VGA mode it gets it from a the GENMO and in non-VGA mode from
> CLOCK_CNTL. And then it says "screw that" and just uses index 3 instead.
>=20

Ok, I've added a patch to remove this part of the code and with that
the driver actually builds on s390 (no HAS_IOPORT) so I also removed
the HAS_IOPORT dependency. Both will be in my v4.

Thanks,
Niklas



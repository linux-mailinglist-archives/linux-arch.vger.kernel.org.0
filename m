Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DB6C6C5C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCWPeN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjCWPeI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 11:34:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567C78A5C;
        Thu, 23 Mar 2023 08:34:02 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NF0lff005788;
        Thu, 23 Mar 2023 15:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BTtXcATo5dnx2ElslfMl2Fvz3YupFjhxz+ZfS4V4dto=;
 b=pwa7XL26/OLCfIOCLh2lqHVeIn0DgprwHFhc/KprJ3i9pm2eXMHEGdQCyooF+3lIbpuU
 gpdtuHwWQsPct7MvKIfRbGpcERO17yT3MKhfpfNdyyaHsryL2S9XvOFKioIrmAinB3cB
 De7dDv9Lk/69NiZd4gh0wuUKg+BojKPr5v8t3S/4amvoCGLtidU6R5YSowlUQRtYF/yb
 RwI9Du0G/hhrGkq1py93dmiQ8Q+MLFKL8606lqNuWqRWssUXPUb49+/g9TsGSJ6qkIUr
 NueP6Y9wfBPgDOEI5lAH20oKzZrja1OQ38vATuLcUovI69R2/CEfNRW+CabzhWyyiYTH Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgkxv1j6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 15:33:43 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NEZChx017863;
        Thu, 23 Mar 2023 15:33:42 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pgkxv1j5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 15:33:42 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MNj4Zv019849;
        Thu, 23 Mar 2023 15:33:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6ecsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 15:33:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NFXcdI22741618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 15:33:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC9920049;
        Thu, 23 Mar 2023 15:33:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D29E320043;
        Thu, 23 Mar 2023 15:33:36 +0000 (GMT)
Received: from [9.171.87.16] (unknown [9.171.87.16])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 15:33:36 +0000 (GMT)
Message-ID: <f2e0e4d90f3008e40d81c50c8235b151ddc4705c.camel@linux.ibm.com>
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
Date:   Thu, 23 Mar 2023 16:33:36 +0100
In-Reply-To: <20230323145328.GM2673958@google.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-16-schnelle@linux.ibm.com>
         <20230316161442.GV9667@google.com>
         <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
         <20230323145328.GM2673958@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J98rJR5jh4RdW7XV1Je1935mhgWjf2_t
X-Proofpoint-ORIG-GUID: ZmqKbStd77jEso64iNZCDwfxW9uSRC38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=927 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230113
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2023-03-23 at 14:53 +0000, Lee Jones wrote:
> On Thu, 23 Mar 2023, Niklas Schnelle wrote:
>=20
> > On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
> > > On Tue, 14 Mar 2023, Niklas Schnelle wrote:
> > >=20
> > > > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and fr=
iends
> > > > not being declared. We thus need to add HAS_IOPORT as dependency fo=
r
> > > > those drivers using them.
> > > >=20
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >  drivers/leds/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > Applied, thanks
> >=20
> > Sorry should have maybe been more clear, without patch 1 of this series
> > this won't work as the HAS_IOPORT config option is new and will be
> > missing otherwise. There's currently two options of merging this,
> > either all at once or first only patch 1 and then the additional
> > patches per subsystem until finally the last patch can remove
> > inb()/outb() and friends when HAS_IOPORT is unset.
>=20
> You only sent me this patch.
>=20
> If there are in-set dependencies, you need to send everyone the whole
> set so that we can organise a suitable merge strategy between us.
>=20
> I'll revert the patch for now.
>=20
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

I know this isn't ideal and I'm sorry for the confusion, extra work and
churn. As far as I know sadly it's not possible to Cc everyone for such
treewide series because the recipient list will hit the limits
supported by some systems and mails get dropped which sucks even more.
Maybe this can be solved in the future though, Konstantin Ryabitsev
actually reached out because I mentioned that I tried using b4 prep /
b4 send but couldn't exactly because it only supports a global
recipient list.

Thanks,
Niklas

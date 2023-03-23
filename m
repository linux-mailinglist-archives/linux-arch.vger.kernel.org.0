Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3149C6C6BE7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 16:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjCWPIz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCWPIx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 11:08:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345B2BF28;
        Thu, 23 Mar 2023 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NDNmK8023067;
        Thu, 23 Mar 2023 15:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wDvL7TkIXxi7Ib7WQESegrvyTGEvXb+Y2MGvOjakvmU=;
 b=ROmvp/U5uPL0e3mk6elcHuYd/kQwY5zXUzxEnPMTGvNw3Yb1y2wBq0c6Azy1OXQ7F4Sp
 kIO+FtOAjqbrKVNomy8DGQJpdlBhtZ6JTJPaRJfxhgAXhCqiYd5siu6WzPDBsn8IVm2z
 /A8MYv3HqaH3FI0UgB848Nk42jdwg4oGjrN8OJyiHKGXKMSwkBLn3imtNheW/Kn9Bk17
 VezkzfEclRCb4VfrlaEckZWnS8oo3ITz4Wte8Lk8aJ81GokO06wkMSrxPPwS6dIZleUh
 FjVJiwaJzNC1UZuSSJy9wpG44l6ddrB0i6izBXwnwDCPh31RXCv7xXX1YGZl4vonZiM3 PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77rqkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 15:06:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NEmfmG015453;
        Thu, 23 Mar 2023 15:05:59 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77rqht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 15:05:59 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32N0bGBP026836;
        Thu, 23 Mar 2023 15:05:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6eaf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 15:05:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32NF5r2n20841090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 15:05:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71F4A20043;
        Thu, 23 Mar 2023 15:05:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECD9920040;
        Thu, 23 Mar 2023 15:05:51 +0000 (GMT)
Received: from [9.171.87.16] (unknown [9.171.87.16])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Mar 2023 15:05:51 +0000 (GMT)
Message-ID: <1429678a9994885a93fad0b1294fde6d71e692b1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/38] drm: handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        spice-devel@lists.freedesktop.org,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Date:   Thu, 23 Mar 2023 16:05:51 +0100
In-Reply-To: <87fsa65iwm.fsf@intel.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-8-schnelle@linux.ibm.com> <87fsa65iwm.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9KGZYhuGeX5zUa1ihT1_kUAWTs-_yW21
X-Proofpoint-ORIG-GUID: 88Jszr8Quo_Pkgpglb-268xZ1KQ-BYx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1011 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxlogscore=920
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230111
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2023-03-15 at 13:54 +0200, Jani Nikula wrote:
> On Tue, 14 Mar 2023, Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them. In the bochs driver there is optional MMIO
> > support detected at runtime, warn if this isn't taken when
> > HAS_IOPORT is not defined.
>=20
> Not that I care a whole lot, but there should really only be one warning
> or even failure to probe at bochs_hw_init() for !bochs->mmio &&
> !IS_ENABLED(CONFIG_HAS_IOPORT), not warnings all over the place.
>=20
> Moreover, the config macro is CONFIG_HAS_IOPORT instead of HAS_IOPORT
> that you check for below.
>=20
> BR,
> Jani.
>=20

Good Find! Yes the #ifdefs need CONFIG_HAS_IOPORT I even had it
correctly for cirrus in the same patch. For v4 I remove the separate
warnings and instead went with the below:

@@ -229,6 +242,10 @@ static int bochs_hw_init(struct drm_device *dev)
                        return -ENOMEM;
                }
        } else {
+               if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
+                       DRM_ERROR("I/O ports are not supported\n");
+                       return -EIO;
+               }
                ioaddr =3D VBE_DISPI_IOPORT_INDEX;
                iosize =3D 2;
                if (!request_region(ioaddr, iosize, "bochs-drm")) {


Thanks,
Niklas


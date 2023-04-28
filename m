Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF77C6F1AAD
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjD1OpO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjD1OpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 10:45:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965B46BB;
        Fri, 28 Apr 2023 07:45:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SEZfak002849;
        Fri, 28 Apr 2023 14:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bWdQD3LqkH6qu6+vND77KayVLTWo2mL3i9gljvMTrH4=;
 b=qcIEQhD55bBGUTK/bZTdG0QdHxYFIGs3TRNOSHn4gOkh0oUSIxxT5YQHezS5qmbhZI7y
 r9UVleqcVhGBNAz751yEuyBAdGhHcdNDUSv65otJaZiF9I6PxUFCl+b5jVO/l8iQuLRC
 PdikO5PSzRzNU5JK245nCsx3rmXhbZfsRgkyBrr8WXEr/pv3Sh2pw9sLtcKygvMLgfVk
 Jty+oCbNG2jdLisEfrRzbFuAhAEQ9kq5h8IjagN23dymvScMvezEPSWMI+1NcnwKo4IE
 CFA/DkKnLnKyz2b6tbVwCNdhHrvUY12V3GhO7+lFE5f7IN79TPbYy/dmC5mXFK/EaGse 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8fvcgpfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:44:54 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SEgU7P012171;
        Fri, 28 Apr 2023 14:43:35 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q8fvcgkm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:43:35 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33SC6kCx013595;
        Fri, 28 Apr 2023 14:41:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3q47772ykm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 14:41:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33SEfPYm2622036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 14:41:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC52F2004B;
        Fri, 28 Apr 2023 14:41:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D69DB20043;
        Fri, 28 Apr 2023 14:41:24 +0000 (GMT)
Received: from [9.171.55.26] (unknown [9.171.55.26])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Apr 2023 14:41:24 +0000 (GMT)
Message-ID: <9a0feb128bc3b26ca444367ce4ee44e80aa9f469.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/38] gpio: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
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
        linux-gpio@vger.kernel.org
Date:   Fri, 28 Apr 2023 16:41:24 +0200
In-Reply-To: <CACRpkdbS1U8_qakdWV0YZq3bhr1NvFuL0Umv3QsXD0wYu7Hd9A@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
         <20230314121216.413434-10-schnelle@linux.ibm.com>
         <CACRpkdbS1U8_qakdWV0YZq3bhr1NvFuL0Umv3QsXD0wYu7Hd9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SHXZ4IlH0V4Ypv-hAr4Jt82f9UHskpBQ
X-Proofpoint-ORIG-GUID: POsiq4k905P5VL3Ha4rX0PZ9uotS258b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=691 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2023-03-15 at 09:42 +0100, Linus Walleij wrote:
> Hi Niklas,
>=20
> thanks for your patch!
>=20
> On Tue, Mar 14, 2023 at 1:12=E2=80=AFPM Niklas Schnelle <schnelle@linux.i=
bm.com> wrote:
> >=20
> > In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friend=
s
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> >=20
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >  drivers/gpio/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> > index 13be729710f2..5a874e67fc13 100644
> > --- a/drivers/gpio/Kconfig
> > +++ b/drivers/gpio/Kconfig
> > @@ -688,7 +688,7 @@ config GPIO_VISCONTI
> >=20
> >  config GPIO_VX855
> >         tristate "VIA VX855/VX875 GPIO"
> > -       depends on (X86 || COMPILE_TEST) && PCI
> > +       depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
>=20
> But is this the right fix? Further down in the Kconfig we have:
>=20
> menu "Port-mapped I/O GPIO drivers"
>         depends on X86 # Unconditional I/O space access
>=20
> config GPIO_I8255
>         tristate
>         select GPIO_REGMAP
>=20
> (...)
>=20
> Isn't the right fix to:
>=20
> 1) Move this Kconfig entry (VX855) down under the Port-mapped /O drivers,
>    and then:
>=20
> 2) Make the whole submenu for port-mapped IO drivers depend on
>    X86 && HAS_IOPORT
>=20
> Yours,
> Linus Walleij

Makes sense I changed it to the above approach for v4. One thing this
makes me wonder is if then one should change the X86 dependency to at
least X86 || COMPILE_TEST or even remove it and rely on HAS_IOPORT. The
comment there at least suggests that it is there only for the I/O space
access.

Thanks,
Niklas


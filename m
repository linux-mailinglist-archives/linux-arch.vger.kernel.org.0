Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA54808FE
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 13:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhL1MN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 07:13:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhL1MN5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 07:13:57 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BS9BuTQ011359;
        Tue, 28 Dec 2021 12:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6YiJWbyPo3eml2lb6VdyBxDoM31BEH4Zr65ZmbYOztQ=;
 b=XLsSJfsKrasgEGvNZTMx76zFIckeVdVz6UvUDVOjVH3FW1w0Lu+Sd/E+qKHStLzjQ5cP
 1LKipEK/Xv0PrEYUrJU7CvvalZslMjK6r6RovxltjO/G5cXOJADPZP4rGcp7eK2hW0ju
 Xv2mQizgO0loIcwUuUubQnqqRCY55vA8v7zQ7iWbE45AAcE4k/zBbRgOUllAuwmGliXI
 V35qyLSlT1vZ7QumYwPPC59Zth9btULTw59m3AKjymQSrZM81jsSpBXQdTVK6++QNTnm
 h8r5IhwnewMOcsFIETw/ROb6GYeWAlZwR3Z9XalIfnQ2J1td5h3Y7ZgummNyPKUrT6Og zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7yqykd21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 12:13:24 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSC2c6s019738;
        Tue, 28 Dec 2021 12:13:24 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d7yqykd0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 12:13:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSCD9c9007392;
        Tue, 28 Dec 2021 12:13:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3d5tx9g852-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 12:13:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSCDITf40108312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 12:13:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A7B9A4065;
        Tue, 28 Dec 2021 12:13:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D9CDA405B;
        Tue, 28 Dec 2021 12:13:17 +0000 (GMT)
Received: from sig-9-145-12-118.uk.ibm.com (unknown [9.145.12.118])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 12:13:17 +0000 (GMT)
Message-ID: <fcb7c5e1f6dec7906fa29908a7478fa67c5bb255.camel@linux.ibm.com>
Subject: Re: [RFC 10/32] i2c: Kconfig: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>
Date:   Tue, 28 Dec 2021 13:13:17 +0100
In-Reply-To: <CAMuHMdXcfGhVjB2pNB=ct8dExLeh-cY+Vmb0NWpZ2T0bfa8VdA@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-11-schnelle@linux.ibm.com>
         <CAMuHMdXcfGhVjB2pNB=ct8dExLeh-cY+Vmb0NWpZ2T0bfa8VdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X7kMOSP-gmAj1d7v00_W4PIe2kQ4Mzri
X-Proofpoint-ORIG-GUID: vIJKj4Y2dO77NX5hMsgCHl6NPC6on-Bj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_07,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112280055
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-28 at 11:21 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Mon, Dec 27, 2021 at 5:49 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to add HAS_IOPORT as dependency for
> > those drivers using them.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -828,6 +828,7 @@ config I2C_NPCM7XX
> > 
> >  config I2C_OCORES
> >         tristate "OpenCores I2C Controller"
> > +       depends on HAS_IOPORT
> 
> While drivers/i2c/busses/i2c-ocores.c does use {in,out}(), I doubt this
> is used to access legacy I/O space.

Hmm, it does use i2c->iobase for inb()/outb() but i2c->base for
ioreadXY()/iowriteXY(). And as it gets i2c->iobase from
platform_get_resource(pdev, IORESOURCE_IO, 0) I'd think that is an I/O
resource/space. It does look like some kind of fallback path though,
the IORESOURCE_IO is only looked at if accessing an IORESOURCE_MEM
fails so maybe that should instead be ifdeffed.

> 
> >         help
> >           If you say yes to this option, support will be included for the
> >           OpenCores I2C controller. For details see
> > @@ -1227,6 +1228,7 @@ config I2C_CP2615
> >  config I2C_PARPORT
> >         tristate "Parallel port adapter"
> >         depends on PARPORT
> > +       depends on HAS_IOPORT
> 
> Same as PRINTER: shouldn't this work with all parport drivers?

Agree, will drop.

> 
> >         select I2C_ALGOBIT
> >         select I2C_SMBUS
> >         help
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds


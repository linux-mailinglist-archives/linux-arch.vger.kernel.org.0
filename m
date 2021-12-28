Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9214809E2
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 15:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhL1OW1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 09:22:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62654 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhL1OW0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Dec 2021 09:22:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSAW5Kc028170;
        Tue, 28 Dec 2021 14:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=eNCu8PrzoVmd7S/KWx61kIt2610NWYlYhWV7rsGqAIA=;
 b=WP20ymaETSDkkFNFLDkqXeK9RvURca6pKfQReAq3Ra2mklBv5h5yFqiE9lZ30QGVFc+t
 WgBqgEAjoMBEg90mF2nVFQ1ljSCOh7GZjRotStA6NIoejviolHuyooa7xB1DsGOhMDv8
 l0OtwlhtjEuDTURwJMv5urNa03x6abxsShbRwlBWpyajOtE2ViFTfqpvs1gVqd9E9Nr6
 646c0zCpxkj3TclVBkZvNuHscyEFFKD2MIcsyAtGsSiQ0TYhgkhI3b5Kk2BSGKkNTJNr
 CrkaLGHLAuT6HUoGd4d0ByHzhZRt6XKDBTlvi/Er9pU3zUJM1oawxMwgrcCibFpgho/b 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d80wrvdnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 14:21:44 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSE5rtT014411;
        Tue, 28 Dec 2021 14:21:43 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d80wrvdn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 14:21:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSEIKH4010077;
        Tue, 28 Dec 2021 14:21:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3d5txarv7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 14:21:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSELdCJ29360408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 14:21:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C30A404D;
        Tue, 28 Dec 2021 14:21:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07CEA4055;
        Tue, 28 Dec 2021 14:21:37 +0000 (GMT)
Received: from sig-9-145-12-118.uk.ibm.com (unknown [9.145.12.118])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Dec 2021 14:21:37 +0000 (GMT)
Message-ID: <be37a17428ebe8216967a42ec1efdfd11e880bce.camel@linux.ibm.com>
Subject: Re: [RFC 04/32] parport: PC style parport depends on HAS_IOPORT
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
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org
Date:   Tue, 28 Dec 2021 15:21:37 +0100
In-Reply-To: <CAMuHMdVBXBXSE8bQFNqxkbCASZKq25evHGXHjC6u7f3ktW4dpQ@mail.gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-5-schnelle@linux.ibm.com>
         <CAMuHMdVBXBXSE8bQFNqxkbCASZKq25evHGXHjC6u7f3ktW4dpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eb_JujKcPZ239_FuBk5A7qfrG2ffJQ3x
X-Proofpoint-GUID: rDZ3nOS8lc2qxFaCZGQI6OjnDA7RiSTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_08,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=823
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112280062
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 2021-12-28 at 11:14 +0100, Geert Uytterhoeven wrote:
> Hi Niklas,
> 
> On Mon, Dec 27, 2021 at 5:48 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. As PC style parport uses these functions we need to
> > handle this dependency for HAS_IOPORT.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/parport/Kconfig
> > +++ b/drivers/parport/Kconfig
> > @@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
> > 
> >  menuconfig PARPORT
> >         tristate "Parallel port support"
> > -       depends on HAS_IOMEM
> 
> Why drop this?
> Don't all other parport drivers depend on it?

Seeing as the only platforms where HAS_IOMEM can even be unset are s390
and um you're probably right. Let's keep this.

> 
> >         help
> >           If you want to use devices connected to your machine's parallel port
> >           (the connector at the computer with 25 holes), e.g. printer, ZIP
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


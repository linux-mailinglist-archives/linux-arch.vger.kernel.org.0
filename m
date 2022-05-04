Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1249051A2D8
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351597AbiEDPDa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiEDPD1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 11:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE81A816;
        Wed,  4 May 2022 07:59:51 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244EoVHF011423;
        Wed, 4 May 2022 14:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7GPkhD6ejF79+x0aVVJzyr7brhgG0+/pPCooXUjO+wM=;
 b=H3nI89bJQpqDXuFYzAn5J+mFEC/ZDQjC5MfZ0zIkWGp8fmL09o9d3N36Js5yIcAcMxBM
 6trunGjhZ2aTUbJvbyjo0IvTOUJuUpVBJQe8wYAjRRvue2ZppCJ1rrJTubNc+pZOdYLo
 VO4tE9VHFxGb/qBkszbCySNA6ZCT4AVndvn4sF7F629bJsamkowwgoWVRRWnWSSbg92h
 PCRE/W45ObFh13YxdbYsrakR9Q15a0+kj8QKtKjV8TiEY4D6DKJp7ul9Viwfe+OHkFmw
 yxq5xywmFgvyaSBUdR2nVm8pG6zXmnRz9h8KIFjJYc9EjPPxBJHkE966mhUKpwA89xH7 WA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fuukv876f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 14:59:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 244EqWQc013865;
        Wed, 4 May 2022 14:59:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3frvcj5uat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 14:59:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 244ExZ7G44499236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 14:59:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6ED142042;
        Wed,  4 May 2022 14:59:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AAB742041;
        Wed,  4 May 2022 14:59:34 +0000 (GMT)
Received: from sig-9-145-49-14.uk.ibm.com (unknown [9.145.49.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 May 2022 14:59:34 +0000 (GMT)
Message-ID: <5707aafecdd95c1e3bb12980adb52c62827f9dfc.camel@linux.ibm.com>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Date:   Wed, 04 May 2022 16:59:34 +0200
In-Reply-To: <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
References: <20220429135108.2781579-44-schnelle@linux.ibm.com>
         <20220503233802.GA420374@bhelgaas>
         <CAK8P3a02vidd7u5Kp6UJj=9tj_hFGL24SmzuNpDGu1GOa1w9+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hjSJhBQyQf8ZUYl7FJVX4SPjh9SLLxB5
X-Proofpoint-ORIG-GUID: hjSJhBQyQf8ZUYl7FJVX4SPjh9SLLxB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-05-04 at 12:33 +0200, Arnd Bergmann wrote:
> On Wed, May 4, 2022 at 1:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 29, 2022 at 03:50:41PM +0200, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. PCMCIA devices are either LEGACY_PCI devices
> > > which implies HAS_IOPORT or require HAS_IOPORT.
> > > 
> > > Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >  drivers/pcmcia/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> > > index 2ce261cfff8e..32b5cd324c58 100644
> > > --- a/drivers/pcmcia/Kconfig
> > > +++ b/drivers/pcmcia/Kconfig
> > > @@ -5,7 +5,7 @@
> > > 
> > >  menuconfig PCCARD
> > >       tristate "PCCard (PCMCIA/CardBus) support"
> > > -     depends on !UML
> > > +     depends on HAS_IOPORT
> > 
> > I don't know much about PC Card.  Is there a requirement that these
> > devices must use I/O port space?  If so, can you include a spec
> > reference in the commit log?
> 
> I think for PCMCIA devices, the dependency makes sense because
> all device drivers for PCMCIA devices need I/O ports.
> 
> For cardbus, we can go either way, I don't see any reference to
> I/O ports in yenta_socket.c or the pccard core, so it would build
> fine with or without I/O ports.
> 
> > I do see the PC Card spec, r8.1, sec 5.5.4.2.2 says:
> > 
> >   All CardBus PC Card adapters must support either memory-mapped I/O
> >   or both memory-mapped I/O and I/O space. The selection will depend
> >   largely on the system architecture the adapter is intended to be
> >   used in. The requirement to also support memory-mapped I/O, if I/O
> >   space is supported, is driven by the potential emergence of
> >   memory-mapped I/O only cards. Supporting both modes may also
> >   position the adapter to be sold into multiple system architectures.
> > 
> > which sounds like I/O space is optional.
> 
> An earlier version of the patch series had a separate
> CONFIG_LEGACY_PCI that required CONFIG_HAS_IOPORT
> here, which I think made this clearer:
> 
> Almost all architectures that support CONFIG_PCI also provide
> HAS_IOPORT today (at least at compile time, if not at runtime),
> with s390 as a notable exception. Any machines that have legacy
> PCI device support will also have I/O ports because a lot of
> legacy PCI cards used it, and any machine with a pc-card slot
> should also support legacy PCI devices.
> 
> If we get new architectures without I/O space in the future, they
> would certainly not care about supporting old cardbus devices.
> 
>         Arnd

I tested removing the HAS_IOPORT dependency on PCCARD thus ungating
PCMCIA and CARDBUS. This then requires about 30 additional HAS_IOPORT
dependencies to build my s390 allyesconfig.

The only exceptions I found that depends on PCMCIA and isn't otherwise
dependend on ISA or a specific platform are USB_SL811_CS and
PCMCIA_RAYCS (Aviator/Raytheon 2.4GHz wireless).

As for CARDBUS the only "depends on CARDBUS" is in
drivers/net/ethernet/dec/tulip/Kconfig. Now I tested with allyesconfig
which also sets CONFIG_TULIP_MMIO and with that the drivers there did
compile. I guess one should then have "select TULIP_MMIO if
!HAS_IOPORT" in the config NET_TULIP.

So not sure, it seems unlikely we're going to see any new
PCMCIA/CardBus device drivers added and that's a lot of churn for
compile testing so few drivers but in theory it looks like it is
possible to have non-I/O port PCMCIA/CardBus.

Thanks,
Niklas


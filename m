Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7B51D8A4
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392292AbiEFNU0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392303AbiEFNUZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 09:20:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD3163BEA;
        Fri,  6 May 2022 06:16:41 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246CvoBq027748;
        Fri, 6 May 2022 13:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xscNj3LKneLSbobsh3Ku1jl1vBQ8kIYhyMEEDDClgkk=;
 b=oBJQd8ZmQELQLadl/nTQ3LRaxIO/aB6J2HboQ8BtrRYXRlcTMjQ42tG86DF5+sRI/Us2
 6yu8YnHriU0eFlcupkHKrl5OxO6l9qZQOtyx5XnV8n6fWIF5tm+4Xe6HLE0FVlZwA4u6
 kFoAKCVEO22F/gM0owTO4fXUMywSG4eelo40bGXyRJwUwJP8fgeMEf2giutmEehQ3ILo
 VMW19KhYJUNwWTFL+36LFCX1mTzjraYcsur9KBqO1jctjg9DQeNWddzlAAqMquqYAopw
 YD8BUDGUByovfvkdobmUJ/1Kk4HpVfdE5WguUCW42hdJhdEFoqQmDOfvveZrLJzKpLro VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw451rbr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 13:15:25 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246DFOoT003453;
        Fri, 6 May 2022 13:15:24 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw451rbpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 13:15:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246D7fbj009330;
        Fri, 6 May 2022 13:15:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fwh3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 13:15:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246DFIxB41288002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 13:15:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9686A4C04A;
        Fri,  6 May 2022 13:15:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4FBB4C044;
        Fri,  6 May 2022 13:15:16 +0000 (GMT)
Received: from sig-9-145-46-59.uk.ibm.com (unknown [9.145.46.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 13:15:16 +0000 (GMT)
Message-ID: <1424b9289049d0ad8b5c37a4e23ef70f0ef0f83d.camel@linux.ibm.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>
Date:   Fri, 06 May 2022 15:15:16 +0200
In-Reply-To: <CAK8P3a0EMK0gHOmb-jvtfVLb1dun72kYUMKpb11T_GgXiuR9Mw@mail.gmail.com>
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
         <20220505161028.GA492600@bhelgaas>
         <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
         <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk>
         <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
         <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
         <CAK8P3a0EMK0gHOmb-jvtfVLb1dun72kYUMKpb11T_GgXiuR9Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -L36l-JGRIpdeUlE9r-XG_S8uzvQEAie
X-Proofpoint-GUID: C-8WDwnxsOa89z3OSfQYEbBf2zCP5zSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=852 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-05-06 at 14:53 +0200, Arnd Bergmann wrote:
> On Fri, May 6, 2022 at 2:27 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > On Fri, 6 May 2022, Arnd Bergmann wrote:
> > 
> > > >  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> > > > pattern put on the bus/in the TLP in the address phase.  So what is there
> > > > inherent to the s390 architecture that prevents that different bit pattern
> > > > from being used?
> > > 
> > > The hardware design for PCI on s390 is very different from any other
> > > architecture, and more abstract. Rather than implementing MMIO register
> > > access as pointer dereference, this is a separate CPU instruction that
> > > takes a device/bar plus offset as arguments rather than a pointer, and
> > > Linux encodes this back into a fake __iomem token.
> > 
> >  OK, that seems to me like a reasonable and quite a clean design (on the
> > hardware side).
> > 
> >  So what happens if the instruction is given an I/O rather than memory BAR
> > as the relevant argument?  Is the address space indicator bit (bit #0)
> > simply ignored or what?
> 
> Not sure. My best guess is that it would actually work as you'd expect,
> but is deliberately left out of the architecture specification so they don't
> have to to validate the correctness.  Note that only a small number of
> PCIe cards are actually supported by IBM, and I think the firmware
> only passes devices to the OS if they are whitelisted.
> 
>         Arnd

Yes, though in Linux we do try hard to work with whatever is plugged
in. We did benefit from this in the past working with a new NIC from a
different vendor with 0 additional changes. Also you can use vfio-pci
to pass-through arbitrary PCI devices to a QEMU emulating s390x.


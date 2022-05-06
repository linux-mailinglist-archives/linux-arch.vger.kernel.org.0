Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83951D84F
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380389AbiEFNBH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiEFNBE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 09:01:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ACE22BC4;
        Fri,  6 May 2022 05:57:21 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246CrMBf016762;
        Fri, 6 May 2022 12:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=i5+k77lUjCqEK3UnGdBp+j1ZK2ZiBqwNF9P/xBcssx8=;
 b=hdLVXCn614jWnu9BOgShS4X0SwKBt54/I/X6D8YoCUUCdptAKLuW2vQKQPouwJDU0702
 gaXq8F4SAg0nUYZfHIOHDRduz8HOWGuZJ1nDNYXzfZsSe3c4FYGZ8Yx6pavoXYCO+Wyr
 ubxbrakugGGGlmV9rsX3bbRh+ArWENvmlzNtbwLXBUjhGeJQBqKP5w67IUEX1oA9kaVF
 Z+BSKz58HXkui5VCTh43pp+MTZAmhvtA64Xi6b8l1ZURcy8QMUElDNsN5hCrggaICKv1
 XLkCPjcgR3sqm/gxeiKl9BBi/VFthi7xfaEIP1vR/+G0xAmOV+84VmjIvNmZxzPlNDmy pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw42yr125-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:56:02 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246CsZT8025820;
        Fri, 6 May 2022 12:56:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw42yr11d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:56:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246Cqo5L016411;
        Fri, 6 May 2022 12:55:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fvg611ab7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:55:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246CttUK45678914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 12:55:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EEBD4C044;
        Fri,  6 May 2022 12:55:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CDAD4C040;
        Fri,  6 May 2022 12:55:53 +0000 (GMT)
Received: from sig-9-145-46-59.uk.ibm.com (unknown [9.145.46.59])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 12:55:53 +0000 (GMT)
Message-ID: <2eba36c5dbfb0f92cd567237170fd235b7aa5e9c.camel@linux.ibm.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Arnd Bergmann <arnd@kernel.org>
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
Date:   Fri, 06 May 2022 14:55:52 +0200
In-Reply-To: <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
         <20220505161028.GA492600@bhelgaas>
         <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
         <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk>
         <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
         <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LO5Fs2ZH5CDHRPnWqqh_0XjI6H68Lnqc
X-Proofpoint-ORIG-GUID: moBRmecBSWCp7t42P_FpLJy7x8sPqg2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=993 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-05-06 at 13:27 +0100, Maciej W. Rozycki wrote:
> On Fri, 6 May 2022, Arnd Bergmann wrote:
> 
> > >  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> > > pattern put on the bus/in the TLP in the address phase.  So what is there
> > > inherent to the s390 architecture that prevents that different bit pattern
> > > from being used?
> > 
> > The hardware design for PCI on s390 is very different from any other
> > architecture, and more abstract. Rather than implementing MMIO register
> > access as pointer dereference, this is a separate CPU instruction that
> > takes a device/bar plus offset as arguments rather than a pointer, and
> > Linux encodes this back into a fake __iomem token.
> 
>  OK, that seems to me like a reasonable and quite a clean design (on the 
> hardware side).
> 
>  So what happens if the instruction is given an I/O rather than memory BAR 
> as the relevant argument?  Is the address space indicator bit (bit #0) 
> simply ignored or what?

See my answer to Arnd for some more background but there simply isn't a
way to formulate an I/O access. In the old style PCI instructions the
BAR number and the function handle are put in a register before the
access. BAR number 15 is used to access config space. If there is no
BAR for that number the instruction fails with a non-zero CC.

> 
> > >  But that has nothing to do with the presence or absence of any specific
> > > processor instructions.  It's just a limitation of bus glue.  So I guess
> > > it's just that all PCI/PCIe glue logic implementations for s390 have such
> > > a limitation, right?
> > 
> > There are separate instructions for PCI memory and config space, but
> > no instructions for I/O space, or for non-PCI MMIO that it could be mapped
> > into.
> 
>  The PCI configuration space was retrofitted into x86 systems (and is 
> accessed in an awkward manner with them), but with a new design such a 
> clean approach is most welcome IMHO.  Thank you for your explanation.
> 
>   Maciej

Well our design is a retrofit too considering s390x is a direct
decendent of IBM System/360 which one could argue to have been the
first ISA. But yes as PCI support was only added with PCIe and with a
machine level hypervisor already in place we do get shielded a lot from
the gritty details.


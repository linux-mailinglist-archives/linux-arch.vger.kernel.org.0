Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2B51D81E
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392148AbiEFMtK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 08:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392132AbiEFMtJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 08:49:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6F6B7D2;
        Fri,  6 May 2022 05:45:25 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246CMvCJ017710;
        Fri, 6 May 2022 12:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=J7I3iBXxV8Z1vr0f0ee5d83OYFPlyGPJ3t86KJAK5og=;
 b=a+27yxjQlIlvY+o7rUFP54VO5tTHsDGp8dwAiXZ56/zPPArGGAJBRVhaoNpZHmJTYGCT
 6o52YBfjV/6zZRmbR5my/gYLeeritzodIh1DLipssx8c6i6eFhYS3JKQD2EpPcy9rSjx
 0QgSTdjX1qGn9nUNpkTs/C+rgb0ILKyerdVO9aofpxXsz5WH1mw1ghH6I01WNTuxKw3y
 fWGDgstZwQ8AOEB876CgShDaiMpBwNNbKFAETz4TWaiGXeCfsmvVf+viXrj+w2R+uOkV
 z6/V3+P7uT5o6M+bwnFe7JjDAXVhPXD/H/NDwqoqsOyLzCZSsYegNs/hWwH13yOGWgkH oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw3mprd4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:43:06 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 246CgdYg005869;
        Fri, 6 May 2022 12:43:05 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw3mprd3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:43:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 246CblB5028764;
        Fri, 6 May 2022 12:43:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3fuyn7a1ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 12:43:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 246Ch1jP49873194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 12:43:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBA31A4053;
        Fri,  6 May 2022 12:43:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F5CA4040;
        Fri,  6 May 2022 12:42:59 +0000 (GMT)
Received: from sig-9-145-46-59.uk.ibm.com (unknown [9.145.46.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 12:42:59 +0000 (GMT)
Message-ID: <48b81eb280d949e9321eb304d0ee36abb0075709.camel@linux.ibm.com>
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
Date:   Fri, 06 May 2022 14:42:58 +0200
In-Reply-To: <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
         <20220505161028.GA492600@bhelgaas>
         <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
         <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk>
         <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gOwZPZ2fjiFdDkZpJhuCBJIjnnIu-PuZ
X-Proofpoint-ORIG-GUID: iES7GOmcIZaSIEyxg01Yx8qsHLACB5lz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_04,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On Fri, 2022-05-06 at 13:33 +0200, Arnd Bergmann wrote:
> On Fri, May 6, 2022 at 12:20 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > On Thu, 5 May 2022, Arnd Bergmann wrote:
> >  I think I'm missing something here.  IIUC we're talking about a PCI/PCIe
> > bus used with s390 hardware, right?
> > 
> >  (It has to be PCI/PCIe, because other than x86/IA-64 host buses there are
> > only PCI/PCIe and EISA/ISA buses out there that define I/O access cycles
> > and EISA/ISA have long been obsoleted except perhaps from some niche use.)
> > 
> >  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> > pattern put on the bus/in the TLP in the address phase.  So what is there
> > inherent to the s390 architecture that prevents that different bit pattern
> > from being used?
> 
> The hardware design for PCI on s390 is very different from any other
> architecture, and more abstract. Rather than implementing MMIO register
> access as pointer dereference, this is a separate CPU instruction that
> takes a device/bar plus offset as arguments rather than a pointer, and
> Linux encodes this back into a fake __iomem token.

Correct, we have since gained new PCI load/store instructions that
actually do take a virtual address that gets address translated to a
"physical address" for the PCI BARs. The "physical address" we get from
the platform (again via special instructions). I put "physical address"
in quotes because while they are conceptually physical addresses and
they are translated to by MMU translation tables, accessing their
virtual mapping with any instruction other then the special PCI
load/store instructions will cause addressing exceptions. So we still
don't have real MMIO but something that looks a lot more like MMIO than
we used to.

> 
> >  If anything, I could imagine the same limitation as with current POWER9
> > implementations, that is whatever glue is used to wire PCI/PCIe to the
> > rest of the system does not implement a way to use said bit pattern (which
> > has nothing to do with the POWER9 processor instruction set).
> > 
> >  But that has nothing to do with the presence or absence of any specific
> > processor instructions.  It's just a limitation of bus glue.  So I guess
> > it's just that all PCI/PCIe glue logic implementations for s390 have such
> > a limitation, right?
> 
> There are separate instructions for PCI memory and config space, but
> no instructions for I/O space, or for non-PCI MMIO that it could be mapped
> into.
> 
>        Arnd

The config space is still accessed with the old style PCI load/store
instructions via a special extra BAR.

But yes overall on s390x we can only access PCI(e) devices via special
instructions not via real MMIO and also the OS has no direct access to
the registers of the PHB which are only accessible to firmware. 

Maybe as a bit of further background it's also important to note that
on s390x all Operating Systems run inside a hypervisor. On the lowest
level any OS can run this is a non-paging machine level hypervisor. For
PCI that means that we always have a kind of pass-through access though
without paging and hardware support for the memory partitioning this is
of course relatively simple.


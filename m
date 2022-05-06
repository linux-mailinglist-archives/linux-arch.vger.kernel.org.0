Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0951D4D1
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiEFJoz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 05:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390728AbiEFJof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 05:44:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE120180;
        Fri,  6 May 2022 02:40:52 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2469Oct9034343;
        Fri, 6 May 2022 09:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ATADAeU7AzydfhIN4/8/97TK5dyqxtus7XYokE/Psd4=;
 b=Jcy81Rkmal8Ld6yZwfu+2ng9HRucfxxxvmTh1NcKgDURoKFNvKpcm1ZHWAW9Ir4VsKXR
 pd2y9S2Hvk8+LLCXqCCGIlcAHnksaOG7x62nNIk7f9u5OsqdJlmnp7qjrs5zh8BXekJW
 UxLN/+RAJYjcDJLpHGe/XPvOzrvx5TmFwBMZ5C22DhmJMbWejrrQcvD8oXjVn2NCDlpv
 QlIXdMIK26thZIaJjEsL3zoyAVmuJWopg/ichRaLmBnr8LBayjLn4CEljPGJtUz3/LBw
 0D355aTEY3BPvr5wc49SyvN85iKKd7lM1rKR9YtXX8gl85JhRC5yd6ytJiuTYFSjc6G8 Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw11588x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:39:01 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2469Sb2s010674;
        Fri, 6 May 2022 09:39:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fw11588w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:39:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2469WYqv027902;
        Fri, 6 May 2022 09:38:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3fvg61135h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 09:38:57 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2469ctnm44892610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 May 2022 09:38:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 015EA42042;
        Fri,  6 May 2022 09:38:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30EBB42041;
        Fri,  6 May 2022 09:38:53 +0000 (GMT)
Received: from sig-9-145-46-59.uk.ibm.com (unknown [9.145.46.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 May 2022 09:38:53 +0000 (GMT)
Message-ID: <157602011a72061dd31f92bd699e8c1f9a81c988.camel@linux.ibm.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Date:   Fri, 06 May 2022 11:38:52 +0200
In-Reply-To: <20220505195342.GA509942@bhelgaas>
References: <20220505195342.GA509942@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Izd-B44nIbHN-ZNsHTvoLMo3Drr04sYh
X-Proofpoint-ORIG-GUID: VHp-W17L3sYL52T90zfXFVsNVoEuLE10
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_03,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=748 clxscore=1011 impostorscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205060052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2022-05-05 at 14:53 -0500, Bjorn Helgaas wrote:
> On Thu, May 05, 2022 at 07:39:42PM +0200, Arnd Bergmann wrote:
> > On Thu, May 5, 2022 at 6:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, May 04, 2022 at 11:31:28PM +0200, Arnd Bergmann wrote:
> > > > The main goal is to avoid c), which is what happens on s390, but
> > > > can also happen elsewhere. Catching b) would be nice as well,
> > > > but is much harder to do from generic code as you'd need an
> > > > architecture specific inline asm statement to insert a ex_table
> > > > fixup, or a runtime conditional on each access.
> > > 
> > > Or s390 could implement its own inb().
> > > 
> > > I'm hearing that generic powerpc kernels have to run both on machines
> > > that have I/O port space and those that don't.  That makes me think
> > > s390 could do something similar.
> > 
> > No, this is actually the current situation, and it makes absolutely no
> > sense. s390 has no way of implementing inb()/outb() because there
> > are no instructions for it and it cannot tunnel them through a virtual
> > address mapping like on most of the other architectures. (it has special
> > instructions for accessing memory space, which is not the same as
> > a pointer dereference here).
> > 
> > The existing implementation gets flagged as a NULL pointer dereference
> > by a compiler warning because it effectively is.
> 
> I think s390 currently uses the inb() in asm-generic/io.h, i.e.,
> "__raw_readb(PCI_IOBASE + addr)".  I understand that's a NULL pointer
> dereference because the default PCI_IOBASE is 0.
> 
> I mooted a s390 inb() implementation like "return ~0" because that's
> what happens on most arches when there's no device to respond to the
> inb().
> 
> The HAS_IOPORT dependencies are fairly ugly IMHO, and they clutter
> drivers that use I/O ports in some cases but not others.  But maybe
> it's the most practical way.
> 
> Bjorn

I fear such stubs are kind of equivalent to my previous patch doing the
same in asm-generic/io.h that was pulled and then unpulled by Linus.
Maybe it would be slightly different if instead of a warning outX()
would just be a NOP and inX() just returned ~0 but we're in essence
pretending that we have these functions when we know they are nonsense.

Another argument I see is that as shown by POWER9 we might start to see
more platforms that just can't do I/O port access. E.g. I would also be
surprised if Apple's M1 has I/O port access. Sooner or later I expect
distributions on some platforms to only support such systems. For
example on ppc a server distribution might only support IBM POWER
without I/O port support before too long. Then having HAS_IOPORT allows
to get rid of drivers that won't work anyway.

There are also reports of probing a driver with I/O ports causing a
system crash on systems without I/O port support. For example in this
answer by John Garry (added so he may supply more information):

https://lore.kernel.org/lkml/db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com/


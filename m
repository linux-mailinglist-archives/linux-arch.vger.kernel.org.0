Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0250351B9B7
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346517AbiEEIQW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 04:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiEEIQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 04:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487724080;
        Thu,  5 May 2022 01:12:41 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2454o237019760;
        Thu, 5 May 2022 08:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=z4sq9VpdyC1twtJvv6LraDF4oC5l7K1Gjqz/EX96h48=;
 b=byg8yPH7lB6IZpHqaGAW/IeqHBFw1qVNnemAYMuW6RqtAD2Pr44LXtY5qhdvLHHtmyHS
 zx9iz65kowFV3EWLgEN1WG/d59kZe4yfXhGahlw0zEySpnmOMpKtnTu1H+qcza8lcgus
 VP1jt7FqQK3My93W8lTLtP5pcjNasJUlrXI0Oj9oLP5ti+9vQ6TEUWY2ibcsPnUs14uv
 NmvMjJPL0KUnhOk2z1eHsYp83y9pSRyRUfpRV7sovwq8yCY9xzBZFlBb50MQwBEdnaiO
 0N3pnELj4DvaEamDhYosnYTLvIbL2KA1mWAd5tpRBkVo6hFlV6xAvxmWORtU26wlKUnZ hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fv7w5ayn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:10:24 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24580f9U005340;
        Thu, 5 May 2022 08:10:23 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fv7w5ayks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:10:22 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245884X7030065;
        Thu, 5 May 2022 08:10:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3fttcj2t2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 08:10:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2458AH1F53543266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 08:10:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C65511C050;
        Thu,  5 May 2022 08:10:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B05911C04A;
        Thu,  5 May 2022 08:10:15 +0000 (GMT)
Received: from sig-9-145-85-251.uk.ibm.com (unknown [9.145.85.251])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 May 2022 08:10:15 +0000 (GMT)
Message-ID: <ce5510ff230fe76d9a74d0368d7d5be22011ff88.camel@linux.ibm.com>
Subject: Re: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Date:   Thu, 05 May 2022 10:10:15 +0200
In-Reply-To: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
References: <20220429135108.2781579-2-schnelle@linux.ibm.com>
         <20220504210840.GA469916@bhelgaas>
         <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TfB74bisdmBom1WXjB4-tPfxPcdeJalQ
X-Proofpoint-ORIG-GUID: fSEH5H7pwKFZyghH7nTHuMCiubmCCcLs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_02,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=278 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2022-05-04 at 23:31 +0200, Arnd Bergmann wrote:
> On Wed, May 4, 2022 at 11:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 29, 2022 at 03:49:59PM +0200, Niklas Schnelle wrote:
> > > We introduce a new HAS_IOPORT Kconfig option to indicate support for
> > > I/O Port access. In a future patch HAS_IOPORT=n will disable compilation
> > > of the I/O accessor functions inb()/outb() and friends on architectures
> > > which can not meaningfully support legacy I/O spaces such as s390 or
> > > where such support is optional.
> > 
> > So you plan to drop inb()/outb() on architectures where I/O port space
> > is optional?  So even platforms that have I/O port space may not be
> > able to use it?
> > 
> > This feels like a lot of work where the main benefit is to keep
> > Kconfig from offering drivers that aren't of interest on s390.
> > 
> > Granted, there may be issues where inb()/outb() does the wrong thing
> > such as dereferencing null pointers when I/O port space isn't
> > implemented.  I think that's a defect in inb()/outb() and could be
> > fixed there.
> 
> The current implementation in asm-generic/io.h implements inb()/outb()
> using readb()/writeb() with a fixed architecture specific offset.
> 
> There are three possible things that can happen here:
> 
> a) there is a host bridge driver that maps its I/O ports to this window,
>     and everything works
> b) the address range is reserved and accessible but no host bridge
>    driver has mapped its registers there, so an access causes a
>    page fault
> c) the architecture does not define an offset, and accessing low I/O
>     ports ends up as a NULL pointer dereference
> 
> The main goal is to avoid c), which is what happens on s390, but
> can also happen elsewhere. Catching b) would be nice as well,
> but is much harder to do from generic code as you'd need an
> architecture specific inline asm statement to insert a ex_table
> fixup, or a runtime conditional on each access.
> 
>          Arnd

Yes and to add to this, we did try a local solution in inb()/outb()
before. This added a warning when they are used and we know at compile
time that we're dealing with case c). This approach was nacked by Linus
though as we were turning a compile time known broken case into a
runtime one:

https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

I do agree with this assesment and think this is the right™ approach
but it is more churn as can be seen by the size of this series. I think
longer term it could be valuable though especially if more platforms
phase out I/O port support like POWER9 for which this also allows
filtering what drivers will never work.


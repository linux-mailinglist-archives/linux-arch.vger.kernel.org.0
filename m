Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B094823A5
	for <lists+linux-arch@lfdr.de>; Fri, 31 Dec 2021 12:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhLaL3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Dec 2021 06:29:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhLaL3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Dec 2021 06:29:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BV6teKp016507;
        Fri, 31 Dec 2021 11:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pzUt4LgyPXDJP5o63yyZnj398P6Tb55t1EAvGioG3k8=;
 b=g160z1MzL7ZaBJP0PCFl8WM+/oaNldyPX5T/b2OeqniIg6zpoJJ47PVZUowg0MtVBM+b
 75D8w5J5YM6d+KsITNJ6SyAPHmjNd4qzLkRKe2Aa5iqaRILDTl8nTunlrD/V/PWQopyi
 ffu+DrDe3G3FsNW8naQ0Vs9Jme2ccq8/xhb9T75Om2b3Ho14lej524nWlJSXlp9TAAz1
 NyTMooQ1KiqpJr+uzRKwIcFVyCGx228US4hJSEC5MwRoddDO03iAEPHtx6Mul7n9ZuAB
 j9Zbs6TrzO/vN/WHJf/odeWes281S8+pAqE18r2f1uyR1y9UGT7YCQUk3l3U7i4EttAT XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d9qyvfxnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 11:28:34 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BVBRr2I030593;
        Fri, 31 Dec 2021 11:28:33 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d9qyvfxms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 11:28:33 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BVBO64f003482;
        Fri, 31 Dec 2021 11:28:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3d5txa0f1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Dec 2021 11:28:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BVBSRO447514016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Dec 2021 11:28:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7DF04203F;
        Fri, 31 Dec 2021 11:28:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2638942047;
        Fri, 31 Dec 2021 11:28:24 +0000 (GMT)
Received: from sig-9-145-181-202.de.ibm.com (unknown [9.145.181.202])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Dec 2021 11:28:24 +0000 (GMT)
Message-ID: <072b9080be4a408052bf2c2cc1a9be0089cce5cc.camel@linux.ibm.com>
Subject: Re: [RFC 02/32] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Karol Gugala <kgugala@antmicro.com>,
        Jeff Dike <jdike@addtoit.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org,
        linux-s390@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Greg Ungerer <gerg@linux-m68k.org>
Date:   Fri, 31 Dec 2021 12:28:23 +0100
In-Reply-To: <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
         <20211227164317.4146918-3-schnelle@linux.ibm.com>
         <CAMuHMdXk6VcDryekkMJ3aGFnw4LLWOWMi8M2PwjT81PsOsOBMQ@mail.gmail.com>
         <d406b93a-0f76-d056-3380-65d459d05ea9@gmail.com>
         <CAK8P3a2j-OFUUp+haHoV4PyL-On4EASZ9+59SDqNqmL8Gv_k7Q@mail.gmail.com>
         <1f90f145-219e-1cad-6162-9959d43a27ad@gmail.com>
         <CAK8P3a3NqU-3nUZ9ve=QyPPB5Uep3eK+_hicjjSiP8VuL4FYfA@mail.gmail.com>
         <0211719b-8402-9865-8e5d-5c0a35715816@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d7GAvK0BVAwkfUmW9z0Tnb-kHBnvpkJi
X-Proofpoint-ORIG-GUID: nVApRVBnj1QdMi6qsc--MaC8MDeDduB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-31_04,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112310050
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2021-12-30 at 16:44 +1300, Michael Schmitz wrote:
> Hi Arnd,
> 
> Am 30.12.2021 um 14:48 schrieb Arnd Bergmann:
> > On Tue, Dec 28, 2021 at 11:15 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> > > Am 29.12.2021 um 16:41 schrieb Arnd Bergmann:
> > > > On Tue, Dec 28, 2021 at 8:20 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
---8<---
> 
> > What some other architectures do is to rely on inb()/outb() to have a
> > zero-based offset, and use an io_offset in PCI buses to ensure that a
> > low port number on the bus gets translated into a pointer value for the
> > virtual mapping in the kernel, which is then represented as an unsigned
> > int.
> 
> M54xx does just that for Coldfire:
> 
> arch/m68k/include/asm/io_no.h:
> #define PCI_IO_PA	0xf8000000		/* Host physical address */
> 
> (used to set PCI BAR mappings, so matches your definition above).
> 
> All other (MMU) m68k users of inb()/outb() apply an io_offset in the 
> platform specific address translation:
> 
> 
---8<---
> So as long as support for any of the m68k PCI or ISA bridges is selected 
> in the kernel config, the appropriate IO space mapping is applied. If no 
> support for PCI or ISA bridges is selected, we already fall back to zero 
> offset mapping (but as far as I can tell, it shouldn't be possible to 
> build a kernel without bridge support but drivers that require it).
> 
> > As this is indistinguishable from architectures that just don't have
> > a base address for I/O ports (we unfortunately picked 0 as the default
> > PCI_IOBASE value), my suggestion was to start marking architectures
> > that may have this problem as using HAS_IOPORT in order to keep
> > the existing behavior unchanged. If m68k does not suffer from this,
> > making HAS_IOPORT conditional on those config options that actually
> > need it would of course be best.
> 
> Following your description, HAS_IOPORT would be required for neither of 
> PCI, ISA or ATARI_ROM_ISA ??
> 

No, HAS_IOPORT being set just means that inb() etc. exist and are
functional be it as special instructions like on x86 or via an I/O
address offset. As I understand it if you do have PCI, ISA or
ATARI_ROM_ISA they are functional. If none of them are set and your
zero offset mapping means these accessors can't actually be used you
could make the declerations ifdeffed on CONFIG_HAS_IOPORT to detect the
cases where somone managed to build drivers that require them and that
would result in a compile time error instead of silently, or with a
NULL pointer warning, compiling code that won't work.


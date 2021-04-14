Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20E935F5C0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 16:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349274AbhDNODt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 10:03:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22113 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347931AbhDNODr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Apr 2021 10:03:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13EE2rvZ172241;
        Wed, 14 Apr 2021 10:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UuYTtjiOghyjalpQ0VaVzpDijY3LboOM0WowrtBxbRU=;
 b=krausk2m7mCMYMWrvGFYWvEoulxqWrl+4iTgEcsNJyfkh3zrp+/EHPQuJAmUWx68pm0d
 eQ1LDUHbHvQZnfmx9L2gGDTcIpUdbr7hzMugF3yEB6pCcIF92V/aiJh9gEYDi7jBQl/Z
 k184Iy8yARJhlthTxJrg3mKl7pao6m6lc9hUuguvXDwMfOBz2nBn2LND6X77HhjQ91dM
 MmDsaBOEHzM9/y4lzvl7wVRRp9ZKYxnI6x3hpkdwpjyfRFGI0qQHwBN7KwxSjvpYhg2U
 7fL47hX05lTVtxx5EBT2hUCPhxfenWaHBx0X9zdeo4dxivpiGP6mmxdBfGqVhfljz7L7 /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37x093k4gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 10:03:14 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13EE39Y5174425;
        Wed, 14 Apr 2021 10:03:12 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37x093k4cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 10:03:11 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13EDvTiI011743;
        Wed, 14 Apr 2021 14:03:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 37u3n8bbbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Apr 2021 14:03:01 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13EE2bnu32506180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 14:02:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47EB52054;
        Wed, 14 Apr 2021 14:02:59 +0000 (GMT)
Received: from sig-9-145-163-27.de.ibm.com (unknown [9.145.163.27])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2318B52051;
        Wed, 14 Apr 2021 14:02:59 +0000 (GMT)
Message-ID: <3ed30ec5a241c50689fc954103214ce5ed36c463.camel@linux.ibm.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Date:   Wed, 14 Apr 2021 16:02:58 +0200
In-Reply-To: <ac3447d8db2146798b86135e9f49891d@AcuMS.aculab.com>
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
         <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
         <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
         <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com>
         <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
         <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
         <40d4114fa34043d0841b81d09457c415@AcuMS.aculab.com>
         <c6f3c9a70e054e9087f657bf4f142732fd43784c.camel@linux.ibm.com>
         <ac3447d8db2146798b86135e9f49891d@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9yPIgPn0VkFBidXyLmxozlYX3xZAJTVD
X-Proofpoint-GUID: 6N4qSzjHCicifyAYz62M8ZbSLz8WIomL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-14_07:2021-04-14,2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140098
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-04-14 at 13:50 +0000, David Laight wrote:
> From: Niklas Schnelle
> > Sent: 14 April 2021 13:35
> > 
> > On Tue, 2021-04-13 at 14:12 +0000, David Laight wrote:
> > > From: Arnd Bergmann
> > > > Sent: 13 April 2021 14:40
> > > > 
> > > > On Tue, Apr 13, 2021 at 3:06 PM David Laight <David.Laight@aculab.com> wrote:
> > > > > From: Arnd Bergmann
> > > > > > Sent: 13 April 2021 13:58
> > > > > ...
> > > > > > The remaining ones (csky, m68k, sparc32) need to be inspected
> > > > > > manually to see if they currently support PCI I/O space but in
> > > > > > fact use address zero as the base (with large resources) or they
> > > > > > should also turn the operations into a NOP.
> > > > > 
> > > > > I'd expect sparc32 to use an ASI to access PCI IO space.
> > > > > I can't quite remember whether IO space was supported at all.
> > > > 
> > > > I see this bit in arch/sparc/kernel/leon_pci.c
> > > > 
> > > >  * PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
> > > >  * accessed through a Window which is translated to low 64KB in PCI space, the
> > > >  * first 4KB is not used so 60KB is available.
> > > > ...
> > > >         pci_add_resource_offset(&resources, &info->io_space,
> > > >                                 info->io_space.start - 0x1000);
> > > > 
> > > > which means that there is I/O space, which gets accessed through whichever
> > > > method readb() uses. Having the offset equal to the resource means that
> > > > the '(void *)0' start is correct.
> > > 
> > > It must have been the VMEbus (and maybe sBus) sparc that used an ASI.
> > > 
> > > I do remember issues with Solaris of some PCI cards not liking
> > > being assigned a BAR address of zero.
> > > That may be why the low 4k IO space isn't assigned here.
> > > (I've never run Linux on sparc, just SVR4 and Solaris.)
> > > 
> > > I guess setting PCI_IOBASE to zero is safer when you can't trust
> > > drivers not to use inb() instead of readb().
> > > Or whatever io_read() ends up being.
> > > 
> > > 	David
> > 
> > So "I guess setting PCI_IOBASE to zero is safer when you can't trust
> > drivers not to use inb()…" in principle is true on other architectures
> > than sparc too, right? So do you think this means we shouldn't go with
> > Arnd's idea of making inb() just WARN_ONCE() if PCI_IOBASE is not
> > defined or just that for sparc defining it as 0 would be preferred?
> > 
> > As for s390 since we only support a limited number of drivers I think
> > for us such a WARN_ONCE() for inb() would be preferable.
> > 
> > I guess one option would be to let each architecture opt in to leaving
> > PCI_IOBASE undefined but in the first patch push PCI_IOBASE 0 into all
> > drivers that currently don't define it at all _and_ do not define their
> > own inb() etc.
> 
> How much code outside of legacy x86 drivers should be using inb() etc?
> I'm not sure any other (modern) cpu have separate IO instructions.
> 
> Because some PCI(e) resources might be available on memory or IO BARs
> (possible duplicate BAR on some cards) aren't there also ioreadb()
> functions (with addresses as parameters)?
> IIRC on x86 they treat small values as IO ports and large ones
> as memory mapped addresses.
> If PCI IO space is memory mapped then these would be directly equivalent
> to readb() (etc).
> 
> So perhaps inb() should just not be defined at all except on x86?
> (Perhaps except for COMPILE_TEST).
> If it is defined, then maybe it should never be called?
> So a WARN_ONCE() returning ~0 for reads might even be best.

Ok yeah I think that's also what I'd like best.

> 
> Of course, there will be some obscure fallout - there always is.

Let me come up with a patch, then if this decision is wrong it's at
least one of us s390 people breaking someone else's architecture
instead of the usual other way around ;-D

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

